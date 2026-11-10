// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_sd_spi.v
// Author       : Aaron Luebbert
// Date         : 2026-11-09
// Description  : sd_spi against sd_model, once as an sdhc card and once as a
//                  byte addressed version 1 card. checks that init finishes,
//                  that sectors come back byte for byte with the right index,
//                  that reads work back to back and out of order, and that
//                  the model saw the expected number of reads.
//
//                  iverilog -g2012 -o sd.vvp -s tb_sd_spi tb/cartridge/tb_sd_spi.v
//                    tb/cartridge/sd_model.v rtl/cartridge/sd_spi.v
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_sd_spi;

    reg clk = 1'b0;
    reg rst = 1'b1;
    always #5 clk = ~clk;

    integer checks = 0, fails = 0;

    task check(input cond, input [255:0] name);
        begin
            checks = checks + 1;
            if (!cond) begin fails = fails + 1; $display("FAIL  %0s", name); end
        end
    endtask

    // two cards, two controllers
    wire cs_a, sck_a, mosi_a, miso_a, cs_b, sck_b, mosi_b, miso_b;
    wire ready_a, err_a, busy_a, valid_a, done_a, ready_b, err_b, busy_b, valid_b, done_b;
    wire [7:0] byte_a, byte_b;
    wire [8:0] idx_a, idx_b;
    reg        req_a = 1'b0, req_b = 1'b0;
    reg [22:0] sec_a = 23'd0, sec_b = 23'd0;

    sd_model #(.SECTORS(64), .SDHC(1), .IDLE_ACMDS(3), .NCR(2)) card_a (
        .sck(sck_a), .cs_n(cs_a), .mosi(mosi_a), .miso(miso_a));
    sd_model #(.SECTORS(64), .SDHC(0), .IDLE_ACMDS(1), .NCR(5)) card_b (
        .sck(sck_b), .cs_n(cs_b), .mosi(mosi_b), .miso(miso_b));

    sd_spi #(.DIV_SLOW(3), .DIV_FAST(2), .PWR_CLKS(200)) ctl_a (
        .clk(clk), .rst(rst), .sd_cs_n(cs_a), .sd_sck(sck_a), .sd_mosi(mosi_a), .sd_miso(miso_a),
        .ready(ready_a), .err(err_a), .rd_req(req_a), .rd_sector(sec_a), .busy(busy_a),
        .rd_valid(valid_a), .rd_byte(byte_a), .rd_idx(idx_a), .rd_done(done_a));
    sd_spi #(.DIV_SLOW(3), .DIV_FAST(2), .PWR_CLKS(200)) ctl_b (
        .clk(clk), .rst(rst), .sd_cs_n(cs_b), .sd_sck(sck_b), .sd_mosi(mosi_b), .sd_miso(miso_b),
        .ready(ready_b), .err(err_b), .rd_req(req_b), .rd_sector(sec_b), .busy(busy_b),
        .rd_valid(valid_b), .rd_byte(byte_b), .rd_idx(idx_b), .rd_done(done_b));

    function [7:0] pat(input integer n);
        begin pat = (n * 7 + (n >> 9) * 13 + 5) & 8'hFF; end
    endfunction

    integer k;
    initial begin
        for (k = 0; k < 64 * 512; k = k + 1) begin
            card_a.img[k] = pat(k);
            card_b.img[k] = pat(k) ^ 8'h5A;
        end
    end

    // collectors
    integer cnt_a, cnt_b, bad_a, bad_b, base_a, base_b, order_a, order_b, dones_a, dones_b;
    always @(posedge clk) begin
        if (valid_a) begin
            if (byte_a !== pat(base_a * 512 + idx_a)) bad_a = bad_a + 1;
            if (idx_a !== cnt_a[8:0]) order_a = order_a + 1;
            cnt_a = cnt_a + 1;
        end
        if (valid_b) begin
            if (byte_b !== (pat(base_b * 512 + idx_b) ^ 8'h5A)) bad_b = bad_b + 1;
            if (idx_b !== cnt_b[8:0]) order_b = order_b + 1;
            cnt_b = cnt_b + 1;
        end
        if (done_a) dones_a = dones_a + 1;
        if (done_b) dones_b = dones_b + 1;
    end

    task read_a(input integer s);
        begin
            cnt_a = 0; base_a = s;
            @(posedge clk); sec_a <= s; req_a <= 1'b1;
            @(posedge clk); req_a <= 1'b0;
            wait (done_a); @(posedge clk);
        end
    endtask

    task read_b(input integer s);
        begin
            cnt_b = 0; base_b = s;
            @(posedge clk); sec_b <= s; req_b <= 1'b1;
            @(posedge clk); req_b <= 1'b0;
            wait (done_b); @(posedge clk);
        end
    endtask

    integer t0;
    initial begin
        cnt_a = 0; cnt_b = 0; bad_a = 0; bad_b = 0; base_a = 0; base_b = 0;
        order_a = 0; order_b = 0; dones_a = 0; dones_b = 0;
        #50 rst = 1'b0;

        t0 = $time;
        wait (ready_a && ready_b);
        $display("both cards ready after %0d ns", $time - t0);
        check(!err_a && !err_b, "no init error");
        check(card_a.idle_st == 1'b0 && card_b.idle_st == 1'b0, "both cards left idle");

        read_a(0);  check(cnt_a == 512 && bad_a == 0 && order_a == 0, "sdhc: sector 0");
        read_a(1);  check(cnt_a == 512 && bad_a == 0 && order_a == 0, "sdhc: sector 1 back to back");
        read_a(63); check(cnt_a == 512 && bad_a == 0 && order_a == 0, "sdhc: last sector");
        read_a(17); check(cnt_a == 512 && bad_a == 0 && order_a == 0, "sdhc: out of order");
        read_a(17); check(cnt_a == 512 && bad_a == 0 && order_a == 0, "sdhc: same sector twice");
        check(card_a.reads == 5 && card_a.last_sector == 17, "sdhc: model saw five reads");
        check(dones_a == 5, "sdhc: five done pulses");

        read_b(0);  check(cnt_b == 512 && bad_b == 0 && order_b == 0, "sdsc: sector 0");
        read_b(33); check(cnt_b == 512 && bad_b == 0 && order_b == 0, "sdsc: byte addressed sector 33");
        read_b(2);  check(cnt_b == 512 && bad_b == 0 && order_b == 0, "sdsc: sector 2");
        check(card_b.reads == 3 && card_b.last_sector == 2, "sdsc: model saw three reads");

        check(!busy_a && !busy_b, "idle at the end");
        check(!err_a && !err_b, "still no error");

        $display("");
        if (fails == 0) $display("ALL %0d CHECKS PASSED - sd init and sector reads verified on an sdhc and a version 1 card", checks);
        else            $display("%0d of %0d checks failed", fails, checks);
        $finish;
    end

    initial begin
        #200000000;
        $display("TIMEOUT");
        $finish;
    end

endmodule
