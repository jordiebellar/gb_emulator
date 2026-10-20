// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_vga_sync.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : runs vga_sync for more than one full frame with ce_vga on
//                  every 4th clock, the real 25mhz relationship, and checks
//                  every pixel tick against an independent model:
//                  - h and v advance exactly as expected, h wrapping at 800
//                    and v at 525, and neither moves on a clock without
//                    ce_vga
//                  - hsync is low for exactly h 656 to 751 and high
//                    everywhere else, vsync low for exactly lines 490 and
//                    491 and high everywhere else
//                  - visible is high exactly when h < 640 and v < 480
//                  and then the totals: 800 pixels per line, 525 lines and
//                  420000 pixels per frame, 307200 visible pixels, 96 low
//                  pixels of hsync per line and 1600 low pixels of vsync per
//                  frame. also checks reset puts the counters at 0 and the
//                  syncs high, and that the counters hold with ce_vga low.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_vga_sync;

    reg clk;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    reg rst;
    reg [1:0] c4;
    initial c4 = 2'd0;
    always @(posedge clk) c4 <= c4 + 2'd1;
    reg  ce_run;
    wire ce_vga = ce_run && (c4 == 2'd3);

    wire [9:0] h, v;
    wire hsync, vsync, visible;

    vga_sync dut (
        .clk(clk), .ce_vga(ce_vga), .rst(rst),
        .h(h), .v(v), .hsync(hsync), .vsync(vsync), .visible(visible)
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

    // the independent model
    integer m_h, m_v;
    integer ticks, bad_step, bad_hs, bad_vs, bad_vis, bad_hold;
    integer snap_lines, snap_vis, snap_hs, snap_vs;
    integer vis_count, hs_low_line, hs_low_total, vs_low_total;
    integer lines_seen, ticks_in_line, bad_line_len, bad_hs_width, wraps;
    reg     prev_hs;
    integer hs_run;
    reg [9:0] h_hold, v_hold;
    reg       hs_hold, vs_hold;

    // sampled on each ce_vga edge before the counters update
    always @(posedge clk) begin
        if (ce_vga && ce_run) begin
            ticks = ticks + 1;

            // outputs now must match the model's state
            if (h !== m_h[9:0] || v !== m_v[9:0]) bad_step = bad_step + 1;
            if (hsync !== ~((m_h >= 656) && (m_h < 752)))     bad_hs  = bad_hs + 1;
            if (vsync !== ~((m_v >= 490) && (m_v < 492)))     bad_vs  = bad_vs + 1;
            if (visible !== ((m_h < 640) && (m_v < 480)))     bad_vis = bad_vis + 1;

            if (visible) vis_count = vis_count + 1;
            if (!hsync)  hs_low_total = hs_low_total + 1;
            if (!vsync)  vs_low_total = vs_low_total + 1;

            // hsync pulse width, measured from the outputs alone
            if (!hsync) hs_run = hs_run + 1;
            else begin
                if (hs_run != 0 && hs_run != 96) bad_hs_width = bad_hs_width + 1;
                hs_run = 0;
            end

            // line length, from the h counter wrapping
            ticks_in_line = ticks_in_line + 1;
            if (h == 10'd799) begin
                if (ticks_in_line != 800) bad_line_len = bad_line_len + 1;
                ticks_in_line = 0;
                lines_seen = lines_seen + 1;
                if (v == 10'd524) wraps = wraps + 1;
            end

            // totals over exactly one frame, 420000 ticks
            if (ticks == 420000) begin
                snap_lines = lines_seen;
                snap_vis   = vis_count;
                snap_hs    = hs_low_total;
                snap_vs    = vs_low_total;
            end

            // advance the model
            if (m_h == 799) begin
                m_h = 0;
                m_v = (m_v == 524) ? 0 : m_v + 1;
            end
            else m_h = m_h + 1;
        end
    end

    initial begin
        ce_run = 1'b0; rst = 1'b1;
        m_h = 0; m_v = 0; ticks = 0; bad_step = 0; bad_hs = 0; bad_vs = 0; bad_vis = 0;
        vis_count = 0; hs_low_total = 0; vs_low_total = 0; lines_seen = 0;
        ticks_in_line = 0; bad_line_len = 0; bad_hs_width = 0; wraps = 0; hs_run = 0;
        bad_hold = 0; snap_lines = -1; snap_vis = -1; snap_hs = -1; snap_vs = -1;

        repeat (3) @(posedge clk);
        @(negedge clk);
        #1;
        check(h === 10'd0 && v === 10'd0, "reset puts both counters at 0");
        check(hsync === 1'b1 && vsync === 1'b1, "both syncs idle high out of reset");
        rst = 1'b0;

        // with ce_vga low the counters must not move
        repeat (20) @(posedge clk);
        @(negedge clk);
        check(h === 10'd0 && v === 10'd0, "counters hold while ce_vga is low");

        // run a bit more than one full frame, 420000 ticks
        ce_run = 1'b1;
        while (ticks < 430000) @(negedge clk);
        ce_run = 1'b0;

        check(bad_step === 0, "h and v advanced exactly as expected on every tick, wrapping at 800 and 525");
        check(bad_hs   === 0, "hsync low for exactly h 656 to 751 and high elsewhere, every tick");
        check(bad_vs   === 0, "vsync low for exactly lines 490 and 491 and high elsewhere, every tick");
        check(bad_vis  === 0, "visible high exactly when h < 640 and v < 480, every tick");
        check(bad_line_len === 0, "every line was exactly 800 pixels");
        check(bad_hs_width === 0, "every hsync pulse was exactly 96 pixels wide");
        check(wraps === 1, "the frame wrapped from line 524 back to 0 exactly once");

        // totals over exactly one frame, the first 420000 ticks
        check(snap_lines === 525, "one frame is exactly 525 lines");
        check(snap_vis === 307200, "one frame has exactly 307200 visible pixels, 640 x 480");
        check(snap_hs === 525 * 96, "hsync is low for 96 pixels on each of the 525 lines");
        check(snap_vs === 1600, "vsync is low for exactly 2 whole lines, 1600 pixels, per frame");

        // ce_vga low again: hold
        h_hold = h; v_hold = v;
        repeat (50) @(posedge clk);
        @(negedge clk);
        check(h === h_hold && v === v_hold, "counters hold again once ce_vga stops");

        // async reset mid frame
        rst = 1'b1;
        #1;
        check(h === 10'd0 && v === 10'd0 && hsync === 1'b1 && vsync === 1'b1,
              "async reset mid frame clears the counters and idles the syncs at once");
        rst = 1'b0;

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - vga timing verified over a full frame", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule