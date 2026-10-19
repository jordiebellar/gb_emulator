// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_demo_top.v
// Author       : Aaron Luebbert
// Date         : 2026-10-19
// Description  : checks ppu_demo_top end to end from its vga pins. one whole
//                  frame, 800 x 525 including blanking, is compared pixel by
//                  pixel against a model written here from the picture
//                  description, the tiles, the tile map, the three sprites,
//                  the palettes, the 3 x scaling, and the black border. the
//                  model does not read anything from the dut.
//                  define SW1 to run with switch 1 on, which makes the demo
//                  write an inverted bgp. switch 0 is off, so the screen does
//                  not scroll, and the frame checked starts after the first
//                  runtime register update so a mid frame palette change
//                  cannot land inside it.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu_demo_top;

`ifdef SW1
    localparam SW1 = 1;
`else
    localparam SW1 = 0;
`endif

    reg clk = 0;
    reg btnC = 0;
    always #5 clk = ~clk;

    wire [3:0] r, g, b;
    wire hs, vs;
    wire [1:0] led;

    ppu_demo_top dut (
        .clk(clk), .btnC(btnC), .sw({SW1[0], 1'b0}),
        .vgaRed(r), .vgaGreen(g), .vgaBlue(b), .Hsync(hs), .Vsync(vs),
        .led(led)
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

    // a row of an 8 x 8 bitmap tile, bit 7 is the left pixel
    function [7:0] smiley_row(input integer y);
        begin
            case (y)
                0: smiley_row = 8'h3C;
                1: smiley_row = 8'h42;
                2: smiley_row = 8'hA5;
                3: smiley_row = 8'h81;
                4: smiley_row = 8'hA5;
                5: smiley_row = 8'h99;
                6: smiley_row = 8'h42;
                default: smiley_row = 8'h3C;
            endcase
        end
    endfunction

    function [7:0] f_row(input integer y);
        begin
            case (y)
                0: f_row = 8'h7E;
                1: f_row = 8'h40;
                2: f_row = 8'h40;
                3: f_row = 8'h7C;
                4: f_row = 8'h40;
                5: f_row = 8'h40;
                6: f_row = 8'h40;
                default: f_row = 8'h00;
            endcase
        end
    endfunction

    // color index 0 to 3 of pixel (px, py) of a tile
    function [1:0] tile_color(input integer t, input integer px, input integer py);
        reg [7:0] rowbits;
        begin
            case (t)
                0: tile_color = 2'd0;
                1: tile_color = 2'd1;
                2: tile_color = 2'd2;
                3: tile_color = 2'd3;
                4: tile_color = (px == 0 || px == 7 || py == 0 || py == 7) ? 2'd3 : 2'd0;
                5: tile_color = (px == py) ? 2'd3 : 2'd0;
                6: tile_color = (((px + py) % 2) == 0) ? 2'd3 : 2'd0;
                7: begin rowbits = smiley_row(py); tile_color = rowbits[7 - px] ? 2'd3 : 2'd0; end
                8: begin rowbits = f_row(py);      tile_color = rowbits[7 - px] ? 2'd3 : 2'd0; end
                default: tile_color = 2'd0;
            endcase
        end
    endfunction

    // which tile is at tile column c and row r of the map
    function integer map_t(input integer c, input integer rw);
        begin
            if (c <= 19 && rw <= 17) begin
                if (rw == 0 || rw == 17 || c == 0 || c == 19) map_t = 4;
                else if (rw < 9)                              map_t = (c - 1) / 5;
                else                                          map_t = (((c + rw) % 2) == 1) ? 5 : 6;
            end
            else map_t = (((c + rw) % 2) == 1) ? 4 : 0;
        end
    endfunction

    // the three sprites, x and y on screen and the tile they use
    function integer spr_x(input integer s);
        begin spr_x = (s == 0) ? 30 : (s == 1) ? 100 : 60; end
    endfunction
    function integer spr_y(input integer s);
        begin spr_y = (s == 0) ? 40 : (s == 1) ? 80 : 120; end
    endfunction
    function integer spr_t(input integer s);
        begin spr_t = (s == 2) ? 8 : 7; end
    endfunction

    // shade 0 to 3 at screen pixel (x, y) of the 160 x 144 picture
    function [1:0] model_shade(input integer x, input integer y);
        reg [1:0] c, shade;
        integer s, sx, sy, spx;
        begin
            c = tile_color(map_t(x / 8, y / 8), x % 8, y % 8);
            shade = SW1 ? (2'd3 - c) : c;
            for (s = 0; s < 3; s = s + 1) begin
                sx = x - spr_x(s);
                sy = y - spr_y(s);
                if (sx >= 0 && sx < 8 && sy >= 0 && sy < 8) begin
                    spx = (s == 2) ? (7 - sx) : sx;      // sprite 2 is x flipped
                    c = tile_color(spr_t(s), spx, sy);
                    if (c != 2'd0) shade = (s == 1) ? (2'd3 - c) : c;   // sprite 1 uses obp1
                end
            end
            model_shade = shade;
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

    // sync timing on the pins, in 100 mhz clocks
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

    // pixel compare, same scheme as tb_video_test_top
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
                    if (n_bad <= 8)
                        $display("  mismatch at screen (%0d,%0d) fb (%0d,%0d) got %h want %h",
                                 hprev, vprev, (hprev - 80) / 3, (vprev - 24) / 3, got, want);
                end
            end
            if (hprev == 0 && vprev == 0 && $time > 40_000_000) begin
                if (!active) active = 1;
                else if (n_cmp > 0) done = 1;
            end
            hprev = dut.u_video.u_sync.h;
            vprev = dut.u_video.u_sync.v;
        end
    end

    initial begin
        wait (done);
        check(hs_w == 4 * 96,                     "hsync low is 96 pixels");
        check(vs_w == 4 * 800 * 2,                "vsync low is 2 lines");
        check(line_n > 1000 && line_ok == line_n, "every line is 800 pixels");
        check(frame_clks == 4 * 800 * 525,        "frame is 525 lines");
        check(n_cmp == 800 * 525,                 "one whole frame compared");
        check(n_pic == 480 * 432,                 "picture area is 480 x 432");
        check(led[0] === 1'b1,                    "lcd is on");
        check(led[1] === 1'b1,                    "write list finished");
        check(n_bad == 0,                         "every pixel matches the model");
        $display("tb_ppu_demo_top (SW1=%0d): %0d checks, %0d failures", SW1, checks, fails);
        if (fails == 0) $display("PASS");
        $finish;
    end

    initial begin
        #200_000_000;
        $display("timeout");
        $finish;
    end

endmodule
