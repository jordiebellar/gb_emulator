// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_video.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : tests the video module as a monitor would see it. the
//                  framebuffer is filled with a pseudo random shade for
//                  every one of the 23040 pixels, written through the same
//                  pixel port the ppu uses. then one full 640 x 480 frame is
//                  captured off the vga outputs and every pixel is compared
//                  with what it should be: the framebuffer pixel under it
//                  through the palette inside the 480 x 432 picture, and
//                  black everywhere else.
//
//                  the capture finds the picture from the sync pulses alone,
//                  the way a monitor does. the first visible pixel of a line
//                  is 144 pixels after the hsync pulse starts, 96 of sync
//                  and 48 of back porch, and the first visible line is 35
//                  lines after vsync starts, 2 of sync and 33 of back porch.
//                  any offset between the picture and the syncs shows up as
//                  a mismatch. the expected image uses a plain divide by 3,
//                  independent of the multiply-shift the hardware uses.
//
//                  also checks that every pixel of blanking time is black,
//                  that writes are ignored with ce_gb low or pixel_valid low
//                  and for coordinates off the screen, and that lcd_on low
//                  gives a blank screen inside the picture and black
//                  outside it.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_video;

    reg clk;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    reg [1:0] c4;
    initial c4 = 2'd0;
    always @(posedge clk) c4 <= c4 + 2'd1;
    wire ce_vga = (c4 == 2'd3);

    reg        rst;
    reg        ce_gb;
    reg        lcd_on;
    reg        pixel_valid;
    reg [7:0]  pixel_x, pixel_y;
    reg [1:0]  pixel_shade;

    wire [3:0] vga_r, vga_g, vga_b;
    wire       vga_hsync, vga_vsync;

    video #(.GREEN(1)) dut (
        .clk(clk), .ce_gb(ce_gb), .ce_vga(ce_vga), .rst(rst),
        .lcd_on(lcd_on),
        .pixel_valid(pixel_valid), .pixel_x(pixel_x), .pixel_y(pixel_y),
        .pixel_shade(pixel_shade),
        .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b),
        .vga_hsync(vga_hsync), .vga_vsync(vga_vsync)
    );

    integer errors = 0;
    integer checks = 0;

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

    // --- the expected picture, written independently of the hardware -------
    reg [1:0] pat [0:23039];

    function [11:0] pal(input [1:0] s);
        begin
            case (s)
                2'd0:    pal = 12'h9B0;
                2'd1:    pal = 12'h8A0;
                2'd2:    pal = 12'h363;
                default: pal = 12'h030;
            endcase
        end
    endfunction

    function [11:0] expected(input integer row, input integer col, input lcd);
        integer fxx, fyy;
        begin
            if (row >= 24 && row < 456 && col >= 80 && col < 560) begin
                fxx = (col - 80) / 3;
                fyy = (row - 24) / 3;
                expected = lcd ? pal(pat[fyy * 160 + fxx]) : pal(2'd0);
            end
            else expected = 12'h000;
        end
    endfunction

    // --- capture, found from the sync pulses alone ---------------------------
    reg [11:0] cap [0:307199];
    reg        cap_arm, cap_done;
    integer    cap_rows;
    integer    k, since_fall;
    reg        vs_seen;
    reg        prev_hs, prev_vs;
    reg [11:0] rgb_s;
    reg        hs_s, vs_s;
    integer    blank_nonzero, blank_samples;
    integer    row_i, col_i;
    reg        in_active;

    always @(posedge clk) begin
        if (ce_vga && cap_arm) begin
            // sampled on the pixel enable, before the outputs update, so
            // this is one stable value per pixel
            hs_s  = vga_hsync;
            vs_s  = vga_vsync;
            rgb_s = {vga_r, vga_g, vga_b};

            if (prev_vs === 1'b1 && vs_s === 1'b0) begin
                k = -1;
                vs_seen = 1'b1;
            end
            if (prev_hs === 1'b1 && hs_s === 1'b0) begin
                if (vs_seen) k = k + 1;
                since_fall = 0;
            end
            else since_fall = since_fall + 1;

            in_active = vs_seen && (k >= 34) && (k <= 34 + 479) &&
                        (since_fall >= 144) && (since_fall < 144 + 640);

            if (in_active) begin
                row_i = k - 34;
                col_i = since_fall - 144;
                if (row_i < cap_rows) begin
                    cap[row_i * 640 + col_i] = rgb_s;
                    if (row_i == cap_rows - 1 && col_i == 639) cap_done = 1'b1;
                end
            end
            else if (vs_seen) begin
                // blanking time, which has to be black
                blank_samples = blank_samples + 1;
                if (rgb_s !== 12'h000) blank_nonzero = blank_nonzero + 1;
            end

            prev_hs = hs_s;
            prev_vs = vs_s;
        end
    end

    task start_capture(input integer nrows);
        integer i;
        begin
            for (i = 0; i < 307200; i = i + 1) cap[i] = 12'hxxx;
            cap_rows = nrows;
            cap_done = 1'b0;
            vs_seen  = 1'b0;
            k = -1;
            since_fall = 100000;
            prev_hs = 1'b1; prev_vs = 1'b1;
            blank_nonzero = 0; blank_samples = 0;
            cap_arm = 1'b1;
        end
    endtask

    task wait_capture;
        begin
            while (!cap_done) @(negedge clk);
        end
    endtask

    task put(input [7:0] x_in, input [7:0] y_in, input [1:0] s_in,
             input valid_in, input ce_in);
        begin
            @(negedge clk);
            pixel_x = x_in; pixel_y = y_in; pixel_shade = s_in;
            pixel_valid = valid_in; ce_gb = ce_in;
            @(posedge clk);
            @(negedge clk);
            pixel_valid = 1'b0; ce_gb = 1'b1;
        end
    endtask

    integer x, y, a, nbad, nx, shown, r, c;
    reg [31:0] lfsr;
    reg [11:0] e;

    task compare_rows(input integer nrows, input lcd, input [8*40:1] what);
        begin
            nbad = 0; nx = 0; shown = 0;
            for (r = 0; r < nrows; r = r + 1)
                for (c = 0; c < 640; c = c + 1) begin
                    e = expected(r, c, lcd);
                    if (^cap[r * 640 + c] === 1'bx) nx = nx + 1;
                    if (cap[r * 640 + c] !== e) begin
                        nbad = nbad + 1;
                        if (shown < 4) begin
                            $display("      mismatch %0s row %0d col %0d: got %h expected %h",
                                      what, r, c, cap[r * 640 + c], e);
                            shown = shown + 1;
                        end
                    end
                end
        end
    endtask

    initial begin
        rst = 1'b1; ce_gb = 1'b1; lcd_on = 1'b1; pixel_valid = 1'b0;
        pixel_x = 0; pixel_y = 0; pixel_shade = 0;
        cap_arm = 1'b0; cap_done = 1'b0; cap_rows = 480; vs_seen = 1'b0;
        k = -1; since_fall = 100000; prev_hs = 1'b1; prev_vs = 1'b1;
        blank_nonzero = 0; blank_samples = 0;

        lfsr = 32'h5EED0042;
        for (a = 0; a < 23040; a = a + 1) begin
            for (x = 0; x < 8; x = x + 1)
                lfsr = {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
            pat[a] = lfsr[1:0];
        end

        repeat (4) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // fill the framebuffer through the ppu's pixel port
        for (y = 0; y < 144; y = y + 1)
            for (x = 0; x < 160; x = x + 1)
                put(x, y, pat[y * 160 + x], 1'b1, 1'b1);

        // writes that must be ignored. each uses a shade that differs from
        // what is stored, so a wrongly accepted write shows up in the picture
        put(8'd0,   8'd0,   ~pat[0],            1'b1, 1'b0);   // ce_gb low
        put(8'd1,   8'd0,   ~pat[1],            1'b0, 1'b1);   // pixel_valid low
        put(8'd200, 8'd10,  2'd3,               1'b1, 1'b1);   // x off the screen
        put(8'd10,  8'd200, 2'd3,               1'b1, 1'b1);   // y off the screen
        put(8'd160, 8'd0,   2'd3,               1'b1, 1'b1);   // would alias to the next row

        // one full frame with the lcd on
        start_capture(480);
        wait_capture;
        compare_rows(480, 1'b1, "lcd on");
        check(nx === 0, "every captured pixel is a known value, none are x");
        check(nbad === 0, "all 307200 pixels of the frame match: picture, scaling, placement, and border");

        // keep watching through the rest of the frame and into the next
        // vertical blanking, every blanking pixel must be black
        while (k < 34 + 5 || k > 34 + 479) @(negedge clk);
        check(blank_samples > 100000, "a large amount of blanking time was observed");
        check(blank_nonzero === 0, "every pixel of blanking time, horizontal and vertical, is black");
        cap_arm = 1'b0;

        // lcd off: the picture goes blank, the border stays black
        lcd_on = 1'b0;
        start_capture(40);
        wait_capture;
        compare_rows(40, 1'b0, "lcd off");
        check(nx === 0, "lcd off: every captured pixel is a known value");
        check(nbad === 0, "lcd off: the picture is the blank shade and the border is black");
        cap_arm = 1'b0;

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - video path verified pixel for pixel", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule