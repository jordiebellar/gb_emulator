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
    reg fifo_done;

    wire [1:0] mode;
    wire [8:0] dot_counter;
    wire [7:0] ly;
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

    ppu_mode_fsm dut (
        .clk               (clk),
        .ce_gb             (ce_gb),
        .rst               (rst),
        .fifo_done         (fifo_done),
        .mode              (mode),
        .dot_counter       (dot_counter),
        .ly                (ly),
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

    task check(input expr, input [8*40:1] label);
        begin
            checks = checks + 1;
            if (expr)
                $display("PASS  cycle=%0d  %0s", cyc, label);
            else begin
                errors = errors + 1;
                $display("FAIL  cycle=%0d  %0s  mode=%0d dot=%0d ly=%0d",
                          cyc, label, mode, dot_counter, ly);
            end
        end
    endtask

    initial begin
        ce_gb = 1'b1;
        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;
        cyc = 0;

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

        $display("");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED - full frame timing verified against the golden model", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule