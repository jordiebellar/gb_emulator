// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_reg.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : directed testbench for ppu_reg - write/readback for every
//                  plain storage register, ly as a read-only passthrough,
//                  stat's hybrid bits, irq_lcdstat for each of the four
//                  trigger sources gated by its own enable bit, sel/ce_m
//                  gating, data_out=0 when deselected, lcdc_out, scx_out,
//                  scy_out, and bgp_out mirroring only committed writes.
//
//                  the inputs ly_in, ly_next, and mode_next are driven the
//                  way ppu_mode_fsm drives them: ly_in is the value now,
//                  ly_next and mode_next are the values after this edge.
//                  reads must return the next-state values, since the cpu
//                  samples on the edge. the coincidence interrupt must
//                  strobe on the edge the match appears, which is either
//                  ly_next arriving at lyc or a write that sets lyc to the
//                  current ly. it must not strobe while the match persists,
//                  when it disappears, with ce_gb low, or with the lcd off.
// Revision     : 2.1 - added bgp_out checks
//                  2.0 - next-state interface: reads from ly_next and
//                  mode_next, same-edge coincidence strobe including the
//                  lyc write case.
//                  1.2 - added scx_out and scy_out checks
//                  1.1 - added lcdc_out and lcd-off gating checks
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu_reg;

    reg clk;
    reg ce_gb;
    reg ce_m;
    reg rst;
    reg [15:0] addr;
    reg [7:0]  data_in;
    reg        we;
    reg        sel;
    wire [7:0] data_out;
    wire       stall;

    reg [1:0] mode_next;
    reg [7:0] ly_in;
    reg [7:0] ly_next;
    reg       entering_hblank;
    reg       entering_oam_scan;
    reg       entering_vblank;
    wire [7:0] lcdc_out;
    wire [7:0] scx_out;
    wire [7:0] scy_out;
    wire [7:0] bgp_out;
    wire      irq_lcdstat;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;

    ppu_reg dut (
        .clk               (clk),
        .ce_gb             (ce_gb),
        .ce_m              (ce_m),
        .rst               (rst),
        .addr              (addr),
        .data_in           (data_in),
        .we                (we),
        .sel               (sel),
        .data_out          (data_out),
        .stall             (stall),
        .mode_next         (mode_next),
        .ly_in             (ly_in),
        .ly_next           (ly_next),
        .entering_hblank   (entering_hblank),
        .entering_oam_scan (entering_oam_scan),
        .entering_vblank   (entering_vblank),
        .lcdc_out          (lcdc_out),
        .scx_out           (scx_out),
        .scy_out           (scy_out),
        .bgp_out           (bgp_out),
        .irq_lcdstat       (irq_lcdstat)
    );

    task set_ly(input [7:0] cur, input [7:0] nxt);
        begin ly_in = cur; ly_next = nxt; end
    endtask

    task write_reg(input [15:0] a, input [7:0] val);
        begin
            @(negedge clk);
            addr = a; data_in = val; we = 1'b1; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    task check_read(input [15:0] a, input [7:0] expected, input [8*100:1] label);
        begin
            addr = a; sel = 1'b1; we = 1'b0;
            #1;
            checks = checks + 1;
            if (data_out === expected)
                $display("PASS %0s: data=0x%02h", label, data_out);
            else begin
                errors = errors + 1;
                $display("FAIL %0s: expected=0x%02h got=0x%02h", label, expected, data_out);
            end
        end
    endtask

    task check_irq(input expected, input [8*100:1] label);
        begin
            #1;
            checks = checks + 1;
            if (irq_lcdstat === expected)
                $display("PASS %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL %0s: irq_lcdstat expected=%b got=%b", label, expected, irq_lcdstat);
            end
        end
    endtask

    task check_lcdc_out(input [7:0] expected, input [8*100:1] label);
        begin
            #1;
            checks = checks + 1;
            if (lcdc_out === expected)
                $display("PASS %0s: lcdc_out=0x%02h", label, lcdc_out);
            else begin
                errors = errors + 1;
                $display("FAIL %0s: lcdc_out expected=0x%02h got=0x%02h", label, expected, lcdc_out);
            end
        end
    endtask

    task check_scroll(input [7:0] exp_scx, input [7:0] exp_scy, input [8*100:1] label);
        begin
            #1;
            checks = checks + 1;
            if (scx_out === exp_scx && scy_out === exp_scy)
                $display("PASS %0s: scx_out=0x%02h scy_out=0x%02h", label, scx_out, scy_out);
            else begin
                errors = errors + 1;
                $display("FAIL %0s: expected scx=0x%02h scy=0x%02h got scx=0x%02h scy=0x%02h",
                          label, exp_scx, exp_scy, scx_out, scy_out);
            end
        end
    endtask

    task check_bgp(input [7:0] expected, input [8*100:1] label);
        begin
            #1;
            checks = checks + 1;
            if (bgp_out === expected)
                $display("PASS %0s: bgp_out=0x%02h", label, bgp_out);
            else begin
                errors = errors + 1;
                $display("FAIL %0s: bgp_out expected=0x%02h got=0x%02h", label, expected, bgp_out);
            end
        end
    endtask

    initial begin
        addr = 16'h0000; data_in = 8'h00; we = 1'b0; sel = 1'b0;
        ce_gb = 1'b1; ce_m = 1'b1;
        mode_next = 2'd2; set_ly(8'd0, 8'd0);
        entering_hblank = 1'b0; entering_oam_scan = 1'b0; entering_vblank = 1'b0;

        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // --- lcd is off at power-on -----------------------------------------
        check_lcdc_out(8'h00, "lcdc_out is 0 after reset, lcd off");
        check_bgp(8'h00, "bgp_out is 0 after reset");

        write_reg(16'hFF40, 8'h91); check_read(16'hFF40, 8'h91, "lcdc readback");
        check_lcdc_out(8'h91, "lcdc_out mirrors the written value");
        write_reg(16'hFF42, 8'h12); check_read(16'hFF42, 8'h12, "scy readback");
        check_scroll(8'h00, 8'h12, "scy_out mirrors the written value, scx_out still at reset");
        check_lcdc_out(8'h91, "lcdc_out unaffected by other registers");
        write_reg(16'hFF43, 8'h34); check_read(16'hFF43, 8'h34, "scx readback");
        check_scroll(8'h34, 8'h12, "scx_out mirrors the written value, scy_out unaffected");
        write_reg(16'hFF45, 8'h56); check_read(16'hFF45, 8'h56, "lyc readback");
        write_reg(16'hFF47, 8'hE4); check_read(16'hFF47, 8'hE4, "bgp readback");
        check_bgp(8'hE4, "bgp_out mirrors the written value");
        write_reg(16'hFF48, 8'hD0); check_read(16'hFF48, 8'hD0, "obp0 readback");
        check_bgp(8'hE4, "bgp_out unaffected by a write to obp0 next door");
        write_reg(16'hFF49, 8'hC0); check_read(16'hFF49, 8'hC0, "obp1 readback");
        write_reg(16'hFF4A, 8'h78); check_read(16'hFF4A, 8'h78, "wy readback");
        write_reg(16'hFF4B, 8'h9A); check_read(16'hFF4B, 8'h9A, "wx readback");

        // --- ly: read-only, and a read returns the value after the edge ------
        set_ly(8'd42, 8'd42);
        check_read(16'hFF44, 8'd42, "ly reads 42 when it is steady at 42");
        set_ly(8'd42, 8'd43);
        check_read(16'hFF44, 8'd43, "ly read returns the next-state value, not the current one");
        set_ly(8'd143, 8'd143);
        write_reg(16'hFF44, 8'hFF);
        check_read(16'hFF44, 8'd143, "ly unaffected by a write attempt");

        // --- stat: mode mirror, bit 7, coincidence flag, all from next state -
        mode_next = 2'd2; set_ly(8'd10, 8'd10); write_reg(16'hFF45, 8'd99);
        check_read(16'hFF41, 8'b1000_0010, "stat: mode 2, bit 7 set, no coincidence, enables clear");

        mode_next = 2'd0;
        check_read(16'hFF41, 8'b1000_0000, "stat: mode bits follow mode_next, now 0");
        mode_next = 2'd3;
        check_read(16'hFF41, 8'b1000_0011, "stat: mode bits follow mode_next, now 3");
        mode_next = 2'd0;

        write_reg(16'hFF45, 8'd10);
        check_read(16'hFF41, 8'b1000_0100, "stat: coincidence flag set when ly == lyc");
        set_ly(8'd9, 8'd10);
        check_read(16'hFF41, 8'b1000_0100, "stat: coincidence flag is from next ly, set on the edge ly arrives");
        set_ly(8'd10, 8'd11);
        check_read(16'hFF41, 8'b1000_0000, "stat: coincidence flag clears on the edge ly leaves");
        set_ly(8'd10, 8'd10);

        write_reg(16'hFF41, 8'b0111_1111);
        check_read(16'hFF41, 8'b1111_1100, "stat: enables took the write, mode/coincidence/bit7 did not");

        // --- mode transition sources, each gated by its own enable ----------
        entering_hblank = 1'b1;
        check_irq(1'b1, "irq_lcdstat fires on entering_hblank, mode0_ie set");
        entering_hblank = 1'b0;

        write_reg(16'hFF41, 8'b0000_0000);
        entering_hblank = 1'b1;
        check_irq(1'b0, "irq_lcdstat does not fire on entering_hblank, mode0_ie clear");
        entering_hblank = 1'b0;

        write_reg(16'hFF41, 8'b0001_0000);
        entering_vblank = 1'b1;
        check_irq(1'b1, "irq_lcdstat fires on entering_vblank, mode1_ie set");
        entering_vblank = 1'b0;

        write_reg(16'hFF41, 8'b0010_0000);
        entering_oam_scan = 1'b1;
        check_irq(1'b1, "irq_lcdstat fires on entering_oam_scan, mode2_ie set");
        entering_oam_scan = 1'b0;
        check_irq(1'b0, "irq_lcdstat clears once entering_oam_scan drops");

        // --- the coincidence strobe, same edge as the event ------------------
        write_reg(16'hFF41, 8'b0100_0000);    // lyc interrupt only
        write_reg(16'hFF45, 8'd50);
        set_ly(8'd20, 8'd20);
        check_irq(1'b0, "no match, no irq");

        set_ly(8'd49, 8'd50);
        check_irq(1'b1, "irq strobes on the edge ly arrives at lyc, not a tick later");
        set_ly(8'd50, 8'd50);
        check_irq(1'b0, "irq does not stay high while the match persists");
        set_ly(8'd50, 8'd51);
        check_irq(1'b0, "no irq on the edge the match disappears");
        set_ly(8'd51, 8'd51);
        check_irq(1'b0, "no irq while unmatched");

        // a write that sets lyc to the current ly creates the match on its own edge
        write_reg(16'hFF45, 8'd77);
        set_ly(8'd50, 8'd50);
        check_irq(1'b0, "lyc 77, ly 50, no match yet");
        @(negedge clk);
        addr = 16'hFF45; data_in = 8'd50; we = 1'b1; sel = 1'b1;
        check_irq(1'b1, "a write to lyc that creates a match strobes on the write's own edge");
        @(posedge clk);
        @(negedge clk);
        we = 1'b0;
        check_irq(1'b0, "and it does not strobe again once the write has landed");

        // a write to some other peripheral whose address also ends in 5, the
        // timer's tima at 0xFF05 for one, must not be mistaken for a lyc write
        write_reg(16'hFF45, 8'd77);
        @(negedge clk);
        addr = 16'hFF05; data_in = 8'd50; we = 1'b1; sel = 1'b0;
        check_irq(1'b0, "a write to another peripheral ending in 5 is not seen as a lyc write");
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_read(16'hFF45, 8'd77, "and lyc itself was not touched by it");
        write_reg(16'hFF45, 8'd50);

        // ce_gb gating, the event edge must carry ce_gb
        set_ly(8'd49, 8'd50);
        check_irq(1'b1, "premise: the match event would strobe here");
        ce_gb = 1'b0;
        check_irq(1'b0, "irq does not strobe when ce_gb is low, even on a real event");
        ce_gb = 1'b1;
        set_ly(8'd50, 8'd50);

        // lcd off suppresses it
        write_reg(16'hFF40, 8'h00);
        check_lcdc_out(8'h00, "lcd turned off");
        set_ly(8'd49, 8'd50);
        check_irq(1'b0, "no coincidence irq while the lcd is off");
        write_reg(16'hFF40, 8'h80);
        check_lcdc_out(8'h80, "lcd turned back on");
        set_ly(8'd49, 8'd50);
        check_irq(1'b1, "coincidence irq fires again once the lcd is on");
        set_ly(8'd50, 8'd50);

        // --- sel and ce_m gating --------------------------------------------
        sel = 1'b0;
        #1;
        checks = checks + 1;
        if (data_out === 8'h00)
            $display("PASS data_out reads 0 when sel is low");
        else begin
            errors = errors + 1;
            $display("FAIL data_out should read 0 when sel is low, got=%h", data_out);
        end
        sel = 1'b1;

        write_reg(16'hFF42, 8'hAA);
        @(negedge clk);
        addr = 16'hFF42; data_in = 8'h55; we = 1'b1; sel = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_read(16'hFF42, 8'hAA, "scy write ignored while sel low");

        @(negedge clk);
        addr = 16'hFF42; data_in = 8'h55; we = 1'b1; sel = 1'b1; ce_m = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce_m = 1'b1;
        check_read(16'hFF42, 8'hAA, "scy write ignored while ce_m low");
        check_scroll(8'h34, 8'hAA, "scroll outputs reflect only committed writes");

        // bgp_out follows only committed writes too
        write_reg(16'hFF47, 8'h1B);
        check_bgp(8'h1B, "bgp_out follows a new write to bgp");
        @(negedge clk);
        addr = 16'hFF47; data_in = 8'hFF; we = 1'b1; sel = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_bgp(8'h1B, "bgp write ignored while sel low");
        @(negedge clk);
        addr = 16'hFF47; data_in = 8'hFF; we = 1'b1; sel = 1'b1; ce_m = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce_m = 1'b1;
        check_bgp(8'h1B, "bgp write ignored while ce_m low");

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule