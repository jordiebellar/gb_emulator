// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_video_test_top.v
// Author       : Aaron Luebbert
// Date         : 2026-10-19
// Description  : checks video_test_top end to end from its pins.
//                    - hsync is low for 96 pixels in a 800 pixel line
//                    - vsync is low for 2 lines in a 525 line frame
//                    - every pixel of one full frame, 800 x 525 including
//                      blanking, matches an independent model of the
//                      pattern, the 3 x scaling, the centering, and the
//                      black border
//                  the model is written here from the pattern description
//                  and not taken from the dut, so a wrong address or a shifted
//                  picture shows up. the first frame is skipped since the
//                  framebuffer is still filling.
//                  the screen position of each pin sample comes from the sync
//                  counters, paired with the sample one vga tick later to
//                  account for the output register stage.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_video_test_top;

    reg clk = 0;
    reg btnC = 0;
    always #5 clk = ~clk;

    wire [3:0] r, g, b;
    wire hs, vs;

    video_test_top dut (
        .clk(clk), .btnC(btnC),
        .vgaRed(r), .vgaGreen(g), .vgaBlue(b), .Hsync(hs), .Vsync(vs)
    );

    integer checks = 0, fails = 0;

    task check(input cond, input [255:0] name);
        begin
            checks = checks + 1;
            if (!cond) begin
                fails = fails + 1;
                $display("FAIL: %0s", name);
            end
        end
    endtask

    // model of what the generator draws at framebuffer (x, y)
    function [1:0] model_shade(input integer x, input integer y);
        reg [1:0] band, base;
        reg edge_px;
        begin
            band = (x < 40) ? 2'd0 : (x < 80) ? 2'd1 : (x < 120) ? 2'd2 : 2'd3;
            base = (y < 72) ? band : (((((x / 8) % 2) ^ ((y / 8) % 2)) != 0) ? 2'd3 : 2'd0);
            edge_px = (x == 0) || (x == 159) || (y == 0) || (y == 143);
            model_shade = edge_px ? ((base == 2'd3) ? 2'd0 : 2'd3) : base;
        end
    endfunction

    function [11:0] green(input [1:0] s);
        begin
            case (s)
                2'd0:    green = 12'h9B0;
                2'd1:    green = 12'h8A0;
                2'd2:    green = 12'h363;
                default: green = 12'h030;
            endcase
        end
    endfunction

    function [11:0] model_rgb(input integer h, input integer v);
        begin
            if (h >= 80 && h < 560 && v >= 24 && v < 456)
                model_rgb = green(model_shade((h - 80) / 3, (v - 24) / 3));
            else
                model_rgb = 12'h000;
        end
    endfunction

    // sync timing measured on the pins, in 100 mhz clocks
    integer clk_cnt = 0;
    integer hs_fall = 0, vs_fall = 0, last_hs_fall = 0, last_vs_fall = 0;
    integer hs_w = 0, vs_w = 0, line_n = 0, line_ok = 0, frame_clks = 0;
    reg hs_d = 1, vs_d = 1;

    always @(posedge clk) begin
        clk_cnt <= clk_cnt + 1;
        hs_d <= hs;
        vs_d <= vs;
        if (hs_d && !hs) begin
            if (last_hs_fall != 0) begin
                line_n = line_n + 1;
                if (clk_cnt - last_hs_fall == 3200) line_ok = line_ok + 1;
            end
            last_hs_fall = clk_cnt;
            hs_fall = clk_cnt;
        end
        if (!hs_d && hs) hs_w = clk_cnt - hs_fall;
        if (vs_d && !vs) begin
            if (last_vs_fall != 0) frame_clks = clk_cnt - last_vs_fall;
            last_vs_fall = clk_cnt;
            vs_fall = clk_cnt;
        end
        if (!vs_d && vs) vs_w = clk_cnt - vs_fall;
    end

    // pixel compare - on each vga tick the pins hold the output for the
    // position the counters had one tick ago
    integer hprev = 0, vprev = 0;
    integer active = 0, done = 0, n_cmp = 0, n_bad = 0, n_pic = 0;
    reg [11:0] got, want;

    always @(posedge clk) begin
        if (dut.ce_vga) begin
            if (active && !done) begin
                got  = {r, g, b};
                want = model_rgb(hprev, vprev);
                n_cmp = n_cmp + 1;
                if (hprev >= 80 && hprev < 560 && vprev >= 24 && vprev < 456) n_pic = n_pic + 1;
                if (got !== want) begin
                    n_bad = n_bad + 1;
                    if (n_bad <= 5)
                        $display("  mismatch at screen (%0d,%0d) got %h want %h", hprev, vprev, got, want);
                end
            end
            // start at the first top-left tick after one full frame, stop at
            // the next one
            if (hprev == 0 && vprev == 0 && $time > 20_000_000) begin
                if (!active) active = 1;
                else if (n_cmp > 0) done = 1;
            end
            hprev = dut.u_video.u_sync.h;
            vprev = dut.u_video.u_sync.v;
        end
    end

    initial begin
        wait (done);
        check(hs_w == 4 * 96,                 "hsync low is 96 pixels");
        check(vs_w == 4 * 800 * 2,            "vsync low is 2 lines");
        check(line_n > 1000 && line_ok == line_n, "every line is 800 pixels");
        check(frame_clks == 4 * 800 * 525,    "frame is 525 lines");
        check(n_cmp == 800 * 525,             "one whole frame compared");
        check(n_pic == 480 * 432,             "picture area is 480 x 432");
        check(n_bad == 0,                     "every pixel matches the model");
        $display("tb_video_test_top: %0d checks, %0d failures", checks, fails);
        if (fails == 0) $display("PASS");
        $finish;
    end

    initial begin
        #100_000_000;
        $display("timeout");
        $finish;
    end

endmodule
