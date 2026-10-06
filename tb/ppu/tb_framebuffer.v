// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_framebuffer.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : fills all 23040 pixels with a pseudo random pattern through
//                  the write port and reads every one back, so the address
//                  mapping is checked for every pixel. also checks that a
//                  read arrives one clock after its address and not before,
//                  that writes with we low are ignored, that writes outside
//                  160 x 144 are ignored and never alias onto another pixel
//                  (the whole buffer is read back again after trying them),
//                  that reads outside 160 x 144 return shade 0, and that
//                  writing one pixel leaves its neighbors alone.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_framebuffer;

    reg clk;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    reg        we;
    reg [7:0]  wx, wy;
    reg [1:0]  wshade;
    reg [7:0]  rx, ry;
    wire [1:0] rshade;

    framebuffer dut (
        .clk(clk), .we(we), .wx(wx), .wy(wy), .wshade(wshade),
        .rx(rx), .ry(ry), .rshade(rshade)
    );

    integer errors = 0;
    integer checks = 0;
    integer x, y, bad, a;
    reg [1:0] pat [0:23039];
    reg [31:0] lfsr;

    task check(input expr, input [8*100:1] label);
        begin
            checks = checks + 1;
            if (expr) $display("PASS  %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s", label);
            end
        end
    endtask

    task write_px(input [7:0] x_in, input [7:0] y_in, input [1:0] s_in, input we_in);
        begin
            @(negedge clk);
            wx = x_in; wy = y_in; wshade = s_in; we = we_in;
            @(posedge clk);
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    // set the read address, wait for the registered read, return the shade
    reg [1:0] got;
    task read_px(input [7:0] x_in, input [7:0] y_in);
        begin
            @(negedge clk);
            rx = x_in; ry = y_in;
            @(posedge clk);
            @(negedge clk);
            got = rshade;
        end
    endtask

    task readback_all(output integer nbad);
        integer xx, yy;
        begin
            nbad = 0;
            for (yy = 0; yy < 144; yy = yy + 1)
                for (xx = 0; xx < 160; xx = xx + 1) begin
                    read_px(xx, yy);
                    if (got !== pat[yy * 160 + xx]) nbad = nbad + 1;
                end
        end
    endtask

    initial begin
        we = 1'b0; wx = 0; wy = 0; wshade = 0; rx = 0; ry = 0;

        lfsr = 32'hC0DE1234;
        for (a = 0; a < 23040; a = a + 1) begin
            for (x = 0; x < 8; x = x + 1)
                lfsr = {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
            pat[a] = lfsr[1:0];
        end
        repeat (3) @(posedge clk);

        // fill every pixel, one write per clock
        for (y = 0; y < 144; y = y + 1)
            for (x = 0; x < 160; x = x + 1)
                write_px(x, y, pat[y * 160 + x], 1'b1);

        readback_all(bad);
        check(bad === 0, "all 23040 pixels read back what was written, address mapping is right");

        // the read is registered, it arrives with the clock, not with the address
        write_px(8'd7, 8'd9, 2'd1, 1'b1);
        write_px(8'd8, 8'd9, 2'd2, 1'b1);
        pat[9 * 160 + 7] = 2'd1;
        pat[9 * 160 + 8] = 2'd2;
        read_px(8'd7, 8'd9);
        @(negedge clk);
        rx = 8'd8; ry = 8'd9;
        #1;
        check(rshade === 2'd1, "read data has not changed just because the address did, it is registered");
        @(posedge clk);
        @(negedge clk);
        check(rshade === 2'd2, "read data follows the address one clock later");

        // we low: nothing is written
        write_px(8'd50, 8'd50, ~pat[50 * 160 + 50], 1'b0);
        read_px(8'd50, 8'd50);
        check(got === pat[50 * 160 + 50], "a write with we low is ignored");

        // writing one pixel leaves its neighbors alone
        write_px(8'd100, 8'd70, ~pat[70 * 160 + 100], 1'b1);
        pat[70 * 160 + 100] = ~pat[70 * 160 + 100];
        read_px(8'd100, 8'd70); check(got === pat[70 * 160 + 100], "the written pixel changed");
        read_px(8'd99,  8'd70); check(got === pat[70 * 160 + 99],  "its left neighbor is untouched");
        read_px(8'd101, 8'd70); check(got === pat[70 * 160 + 101], "its right neighbor is untouched");
        read_px(8'd100, 8'd69); check(got === pat[69 * 160 + 100], "the pixel above is untouched");
        read_px(8'd100, 8'd71); check(got === pat[71 * 160 + 100], "the pixel below is untouched");

        // writes outside the screen are ignored. x = 160 would alias to the
        // first pixel of the next row if the range were not checked
        write_px(8'd160, 8'd0,   2'd3, 1'b1);
        write_px(8'd159, 8'd144, 2'd3, 1'b1);
        write_px(8'd255, 8'd255, 2'd3, 1'b1);
        write_px(8'd200, 8'd10,  2'd3, 1'b1);
        write_px(8'd0,   8'd200, 2'd3, 1'b1);
        readback_all(bad);
        check(bad === 0, "after writes outside the screen, every pixel still reads back unchanged");

        // reads outside the screen return 0, even when pixel 0 is not 0
        write_px(8'd0, 8'd0, 2'd3, 1'b1);
        pat[0] = 2'd3;
        read_px(8'd0, 8'd0);     check(got === 2'd3, "premise: pixel 0 holds a nonzero shade");
        read_px(8'd160, 8'd0);   check(got === 2'd0, "a read with x = 160 returns shade 0");
        read_px(8'd0, 8'd144);   check(got === 2'd0, "a read with y = 144 returns shade 0");
        read_px(8'd255, 8'd255); check(got === 2'd0, "a read at 255, 255 returns shade 0");

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - framebuffer verified over every pixel", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule