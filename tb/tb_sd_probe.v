// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_sd_probe.v
// Author       : Aaron Luebbert
// Date         : 2026-11-16
// Description  : sd_probe_top against sd_model with a known image. checks that
//                  the card comes up and sector 0 is read on its own, that
//                  btnU reads the sector the switches pick and the digits show
//                  the word the switches pick, that btnL runs the sum over the
//                  first (n + 1) * 8 sectors and shows the right total, and
//                  that the seven segment lines carry the digits.
//
//                  iverilog -g2012 -o probe.vvp -s tb_sd_probe tb/tb_sd_probe.v
//                    tb/cartridge/sd_model.v rtl/cartridge/sd_spi.v
//                    rtl/fpga/sd_probe_top.v
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_sd_probe;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg         btnC = 1'b0, btnU = 1'b0, btnL = 1'b0;
    reg  [15:0] sw = 16'd0;
    wire [15:0] led;
    wire [6:0]  seg;
    wire [3:0]  an;
    wire        dp, cs, sck, mosi, miso;

    sd_model #(.SECTORS(64), .SDHC(1), .IDLE_ACMDS(3), .NCR(2)) card (
        .sck(sck), .cs_n(cs), .mosi(mosi), .miso(miso));

    sd_probe_top #(.DIV_SLOW(3), .DIV_FAST(2), .PWR_CLKS(200), .DEB_BITS(4)) dut (
        .clk(clk), .btnC(btnC), .btnU(btnU), .btnL(btnL), .sw(sw),
        .led(led), .seg(seg), .dp(dp), .an(an),
        .sd_cs_n(cs), .sd_sck(sck), .sd_mosi(mosi), .sd_miso(miso));

    integer checks = 0, fails = 0;
    task check(input cond, input [255:0] name);
        begin
            checks = checks + 1;
            if (!cond) begin fails = fails + 1; $display("FAIL  %0s", name); end
        end
    endtask

    function [7:0] pat(input integer n);
        begin pat = (n * 11 + (n >> 9) * 29 + 3) & 8'hFF; end
    endfunction

    integer k, t;
    reg [31:0] exp_sum;
    initial for (k = 0; k < 64 * 512; k = k + 1) card.img[k] = pat(k);

    task press(input integer which);
        begin
            @(negedge clk);
            if (which == 0) btnU = 1'b1; else btnL = 1'b1;
            repeat (40) @(negedge clk);
            btnU = 1'b0; btnL = 1'b0;
            repeat (40) @(negedge clk);
        end
    endtask

    task wait_idle;
        begin
            t = 0;
            while ((dut.waiting || dut.busy) && t < 3000000) begin @(negedge clk); t = t + 1; end
            repeat (20) @(negedge clk);
        end
    endtask

    // the segment code for one digit, active low
    function [6:0] code(input [3:0] n);
        begin
            case (n)
                4'h0: code = 7'b1000000; 4'h1: code = 7'b1111001; 4'h2: code = 7'b0100100;
                4'h3: code = 7'b0110000; 4'h4: code = 7'b0011001; 4'h5: code = 7'b0010010;
                4'h6: code = 7'b0000010; 4'h7: code = 7'b1111000; 4'h8: code = 7'b0000000;
                4'h9: code = 7'b0010000; 4'hA: code = 7'b0001000; 4'hB: code = 7'b0000011;
                4'hC: code = 7'b1000110; 4'hD: code = 7'b0100001; 4'hE: code = 7'b0000110;
                default: code = 7'b0001110;
            endcase
        end
    endfunction

    integer seen, i;
    initial begin
        repeat (10) @(negedge clk);
        // wait for the card to come up and the automatic read of sector 0
        t = 0;
        while (!dut.have && t < 3000000) begin @(negedge clk); t = t + 1; end
        wait_idle;
        check(led[0] === 1'b1, "ready led on");
        check(led[1] === 1'b0, "error led off");
        check(led[6] === 1'b1, "buffer led on after the first read");
        check(card.reads == 1, "one sector read so far");
        check(card.last_sector == 0, "it was sector 0");

        // word 0x82 of sector 0, the bytes at 0x104 and 0x105
        sw[7:0] = 8'h82;
        repeat (6) @(negedge clk);
        check(dut.disp === {pat(16'h104), pat(16'h105)}, "word 82 of sector 0");
        sw[7:0] = 8'h00;
        repeat (6) @(negedge clk);
        check(dut.disp === {pat(0), pat(1)}, "word 00 of sector 0");
        sw[7:0] = 8'hFF;
        repeat (6) @(negedge clk);
        check(dut.disp === {pat(510), pat(511)}, "last word of sector 0");

        // another sector with btnU
        sw[15:8] = 8'd5;
        sw[7:0]  = 8'h10;
        press(0);
        wait_idle;
        check(card.last_sector == 5, "btnU read sector 5");
        check(dut.disp === {pat(5 * 512 + 32), pat(5 * 512 + 33)}, "word 10 of sector 5");

        // the seven segment lines show the four digits, one after another
        seen = 0;
        for (i = 0; i < 4; i = i + 1) begin
            while (an !== ~(4'b0001 << i)) @(negedge clk);
            if (seg === code(dut.disp >> (4 * i))) seen = seen + 1;
        end
        check(seen == 4, "all four digits carry the right segments");

        // a sum over the first 16 sectors, sw15-sw8 = 1
        sw[15:8] = 8'd1;
        press(1);
        t = 0;
        while (!dut.show_sum && t < 30000000) begin @(negedge clk); t = t + 1; end
        wait_idle;
        exp_sum = 0;
        for (k = 0; k < 16 * 512; k = k + 1) exp_sum = exp_sum + pat(k);
        check(dut.show_sum === 1'b1, "sum mode on");
        check(led[3] === 1'b1, "sum led on");
        check(dut.disp === exp_sum[15:0], "sum of 16 sectors");
        check(card.last_sector == 15, "the run ended on sector 15");

        // and back to a single sector
        sw[15:8] = 8'd2;
        press(0);
        wait_idle;
        check(dut.show_sum === 1'b0, "single read leaves sum mode");
        check(card.last_sector == 2, "btnU read sector 2 again");

        $display("%0d checks, %0d failed", checks, fails);
        if (fails == 0) $display("ALL %0d CHECKS PASSED - sd probe verified", checks);
        $finish;
    end

    initial begin
        #200000000;
        $display("TIMEOUT");
        $finish;
    end

endmodule
