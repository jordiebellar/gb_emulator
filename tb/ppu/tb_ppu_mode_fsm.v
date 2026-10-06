// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_mode_fsm.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : golden-model testbench for the ppu mode state machine.
//                  part 1 checks every checkpoint a full frame produces
//                  with the lcd enabled, plus the entering_* strobes and
//                  their mutual exclusivity. part 2 (lcd enable) checks
//                  that with the lcd off the engine idles, mode reads
//                  hblank, ly reads 0, nothing is blocked and no strobe
//                  fires, that turning it on restarts at line 0 dot 0,
//                  that turning it off mid-frame resets instead of
//                  pausing, and that the strobes are gated by lcd_en at
//                  the exact edges where they would otherwise fire.
//                  throughout, a monitor checks the next-state exports: on
//                  every edge, mode_next and ly_next must equal the mode and
//                  ly the registers actually hold just after that edge.
// Revision     : 3.0 - added the mode_next and ly_next monitor
//                  2.3 - added lcd_en and the part 2 checks
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu_mode_fsm;

    localparam MODE_HBLANK         = 2'd0;
    localparam MODE_VBLANK         = 2'd1;
    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;
    localparam MODE3_LEN           = 172;

    reg clk;
    reg ce_gb;
    reg rst;
    reg lcd_en;
    reg fifo_done;

    wire [1:0] mode;
    wire [8:0] dot_counter;
    wire [7:0] ly;
    wire [1:0] mode_next;
    wire [7:0] ly_next;
    wire       oam_stall;
    wire       vram_stall;
    wire       entering_hblank;
    wire       entering_oam_scan;
    wire       entering_vblank;
    wire       irq_vblank;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;
    integer cyc;
    reg     strobe_seen;

    ppu_mode_fsm dut (
        .clk               (clk),
        .ce_gb             (ce_gb),
        .rst               (rst),
        .lcd_en            (lcd_en),
        .fifo_done         (fifo_done),
        .mode              (mode),
        .dot_counter       (dot_counter),
        .ly                (ly),
        .mode_next         (mode_next),
        .ly_next           (ly_next),
        .oam_stall         (oam_stall),
        .vram_stall        (vram_stall),
        .entering_hblank   (entering_hblank),
        .entering_oam_scan (entering_oam_scan),
        .entering_vblank   (entering_vblank),
        .irq_vblank        (irq_vblank)
    );

    always @(*) begin
        fifo_done = (mode == MODE_PIXEL_TRANSFER) &&
                    (dot_counter == 9'd80 + MODE3_LEN - 1);
    end

    // next-state monitor. on every edge the prediction made before the
    // edge must match what the registers hold just after it. lcd_en only
    // ever changes on a negedge in this testbench, so it is steady across
    // the edge being predicted, which is the assumption the exports make
    integer ns_checked = 0;
    integer ns_bad     = 0;
    integer ns_changes = 0;
    reg [1:0] ns_mode;
    reg [7:0] ns_ly;
    reg [1:0] ns_mode_before;
    reg [7:0] ns_ly_before;

    always @(posedge clk) begin
        if (!rst) begin
            ns_mode = mode_next;
            ns_ly   = ly_next;
            ns_mode_before = mode;
            ns_ly_before   = ly;
            #1;
            ns_checked = ns_checked + 1;
            if (mode !== ns_mode || ly !== ns_ly) ns_bad = ns_bad + 1;
            if (ns_mode !== ns_mode_before || ns_ly !== ns_ly_before) ns_changes = ns_changes + 1;
        end
    end

    // cyc >= 0 means part 1, where cycle numbers are meaningful.
    // cyc = -1 means part 2, where they are not.
    task check(input expr, input [8*72:1] label);
        begin
            checks = checks + 1;
            if (expr) begin
                if (cyc >= 0) $display("PASS  cycle=%0d  %0s", cyc, label);
                else          $display("PASS  %0s", label);
            end
            else begin
                errors = errors + 1;
                if (cyc >= 0) $display("FAIL  cycle=%0d  %0s  mode=%0d dot=%0d ly=%0d",
                                        cyc, label, mode, dot_counter, ly);
                else          $display("FAIL  %0s  mode=%0d dot=%0d ly=%0d",
                                        label, mode, dot_counter, ly);
            end
        end
    endtask

    initial begin
        lcd_en = 1'b1; // part 1 runs with the lcd on
        ce_gb  = 1'b1;
        rst    = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;
        cyc = 0;

        // =====================================================================
        // part 1 - full frame timing, lcd enabled throughout
        // =====================================================================
        check(mode === MODE_OAM_SCAN, "power-on mode is oam scan");
        check(dot_counter === 9'd0, "power-on dot_counter is 0");
        check(ly === 8'd0, "power-on ly is 0");

        repeat (80) begin @(posedge clk); cyc = cyc + 1; end
        @(negedge clk);
        check(mode === MODE_PIXEL_TRANSFER, "line 0: mode2->3 exactly at cycle 80");

        repeat (172) begin @(posedge clk); cyc = cyc + 1; end
        check(entering_hblank === 1'b1, "entering_hblank strobes exactly at mode3->0, pre-settle");
        check(entering_oam_scan === 1'b0, "entering_oam_scan is not also asserted here");
        check(entering_vblank === 1'b0, "entering_vblank is not also asserted here");
        @(negedge clk);
        check(mode === MODE_HBLANK, "line 0: mode3->0 exactly at cycle 252 (fifo_done)");

        repeat (456 - 252) begin @(posedge clk); cyc = cyc + 1; end
        check(entering_oam_scan === 1'b1, "entering_oam_scan strobes exactly at the line wrap, pre-settle");
        check(entering_hblank === 1'b0, "entering_hblank is not also asserted here");
        check(entering_vblank === 1'b0, "entering_vblank is not also asserted here");
        @(negedge clk);
        check(dot_counter === 9'd0, "line 0->1: dot_counter wraps to 0 at cycle 456");
        check(ly === 8'd1, "line 0->1: ly increments to 1");
        check(mode === MODE_OAM_SCAN, "line 0->1: mode returns to oam scan");

        repeat (80) begin @(posedge clk); cyc = cyc + 1; end
        @(negedge clk);
        check(mode === MODE_PIXEL_TRANSFER, "line 1: mode2->3 again");

        repeat (172) begin @(posedge clk); cyc = cyc + 1; end
        @(negedge clk);
        check(mode === MODE_HBLANK, "line 1: mode3->0 again");

        while (cyc < 65663) begin @(posedge clk); cyc = cyc + 1; end
        @(posedge clk); cyc = cyc + 1;

        check(irq_vblank === 1'b1, "irq_vblank strobes exactly on this edge, checked pre-settle");
        check(entering_vblank === 1'b1, "entering_vblank matches irq_vblank");
        check(entering_hblank === 1'b0, "entering_hblank is not also asserted at vblank entry");
        check(entering_oam_scan === 1'b0, "entering_oam_scan is not also asserted at vblank entry");

        @(negedge clk);
        check(cyc == 65664, "vblank entry lands on the predicted cycle");
        check(ly === 8'd144, "ly becomes 144 as part of entering vblank");
        check(mode === MODE_VBLANK, "mode switches to vblank");
        check(irq_vblank === 1'b0, "irq_vblank already cleared once settled, one edge later in effect");

        @(posedge clk); cyc = cyc + 1;
        @(negedge clk);
        check(irq_vblank === 1'b0, "irq_vblank does not stay high into the next cycle either");

        while (cyc < 70223) begin @(posedge clk); cyc = cyc + 1; end
        @(posedge clk); cyc = cyc + 1;

        check(entering_oam_scan === 1'b1, "entering_oam_scan strobes at the frame wrap too, pre-settle");
        check(entering_vblank === 1'b0, "entering_vblank is not also asserted at the frame wrap");

        @(negedge clk);
        check(cyc == 70224, "frame wrap lands on the predicted cycle");
        check(ly === 8'd0, "ly wraps back to 0 for the new frame");
        check(mode === MODE_OAM_SCAN, "mode returns to oam scan for the new frame");

        check(oam_stall === 1'b1, "oam_stall high in oam scan (new frame start)");
        check(vram_stall === 1'b0, "vram_stall low in oam scan");

        @(negedge clk);
        rst = 1'b1;
        @(posedge clk);
        @(negedge clk);
        check(mode === MODE_OAM_SCAN, "async reset: mode clears immediately");
        check(dot_counter === 9'd0, "async reset: dot_counter clears immediately");
        check(ly === 8'd0, "async reset: ly clears immediately");
        rst = 1'b0;

        repeat (80) @(posedge clk);
        @(negedge clk);
        check(mode === MODE_PIXEL_TRANSFER, "timing restarts cleanly after reset");

        // =====================================================================
        // part 2 - lcd enable
        // =====================================================================
        cyc = -1;
        $display("");
        $display("=== lcd enable ===");

        // --- turning the lcd off takes effect on the cpu-visible side at once
        check(vram_stall === 1'b1, "premise: vram is blocked mid pixel transfer");
        @(negedge clk);
        lcd_en = 1'b0;
        #1;
        check(mode === MODE_HBLANK, "lcd off: mode reads hblank immediately");
        check(vram_stall === 1'b0, "lcd off: vram unblocked immediately");
        check(oam_stall === 1'b0, "lcd off: oam unblocked immediately");

        // --- one tick later the internal counters are reset, and stay there
        @(posedge clk);
        @(negedge clk);
        check(dot_counter === 9'd0, "lcd off: dot_counter reset on the next tick");

        strobe_seen = 1'b0;
        repeat (1000) begin
            @(posedge clk);
            strobe_seen = strobe_seen | entering_hblank | entering_oam_scan |
                          entering_vblank | irq_vblank;
        end
        @(negedge clk);
        check(strobe_seen === 1'b0, "lcd off: no strobe fires across 1000 ticks");
        check(dot_counter === 9'd0, "lcd off: dot_counter still held at 0 after 1000 ticks");
        check(ly === 8'd0, "lcd off: ly still reads 0");
        check(mode === MODE_HBLANK, "lcd off: mode still reads hblank");

        // --- turning the lcd on starts line 0 from dot 0 in oam scan
        @(negedge clk);
        lcd_en = 1'b1;
        #1;
        check(mode === MODE_OAM_SCAN, "lcd on: mode reads oam scan immediately");
        check(oam_stall === 1'b1, "lcd on: oam blocked again immediately");
        check(dot_counter === 9'd0, "lcd on: starts at dot 0");
        check(ly === 8'd0, "lcd on: starts at line 0");
        repeat (80) @(posedge clk);
        @(negedge clk);
        check(mode === MODE_PIXEL_TRANSFER, "lcd on: pixel transfer begins 80 ticks after enable");

        // --- turning the lcd off mid-frame resets instead of pausing
        repeat (456 * 3 - 80 + 100) @(posedge clk);
        @(negedge clk);
        check(ly === 8'd3, "premise: running on line 3");
        check(mode === MODE_PIXEL_TRANSFER, "premise: mid pixel transfer on line 3");
        @(negedge clk);
        lcd_en = 1'b0;
        #1;
        check(ly === 8'd0, "lcd off mid-frame: ly reads 0 immediately");
        check(mode === MODE_HBLANK, "lcd off mid-frame: mode reads hblank immediately");
        @(posedge clk);
        @(negedge clk);
        check(dot_counter === 9'd0, "lcd off mid-frame: dot_counter reset on the next tick");
        lcd_en = 1'b1;
        #1;
        check(ly === 8'd0, "re-enable: restarts at line 0, not line 3");
        check(dot_counter === 9'd0, "re-enable: restarts at dot 0, not where it left off");
        check(mode === MODE_OAM_SCAN, "re-enable: restarts in oam scan");

        // --- strobes are gated by lcd_en at the exact edges they would fire
        repeat (455) @(posedge clk);
        @(negedge clk);
        check(dot_counter === 9'd455, "premise: