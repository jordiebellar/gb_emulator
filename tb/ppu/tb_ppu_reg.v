// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_reg.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : directed testbench for ppu_reg - write/readback for every
//                  plain storage register, ly as a read-only view, stat's
//                  hybrid bits, the coincidence flag and its rules, the stat
//                  interrupt line and its blocking, sel/ce_m gating,
//                  data_out=0 when deselected, lcdc_out, scx_out, scy_out,
//                  bgp_out, obp0_out, obp1_out, wy_out, and wx_out
//                  mirroring only committed writes.
//
//                  the cpu views stat_mode_next, ly_cpu_next, cmp_off_next
//                  and the three mode conditions are driven the way
//                  ppu_mode_fsm drives them, as the values after this edge.
//                  reads must return them as they are, since the cpu samples
//                  on the edge.
//
//                  the coincidence flag follows ly == lyc, reads 0 while
//                  cmp_off_next is high, freezes while the lcd is off
//                  including against lyc writes, and a lyc write on an lcd
//                  on edge recomputes it on that same edge.
//
//                  the stat interrupt is a rising edge of the or of the four
//                  conditions, each gated by its enable bit. it strobes once
//                  when the line goes up, not while it stays up, not when a
//                  second condition arrives while the line is already up, and
//                  not on a clock with ce_gb low. enabling a condition that
//                  already holds is itself a rising edge, on the edge of the
//                  stat write. with the lcd off the mode conditions are low
//                  but a set coincidence flag keeps the line up.
// Revision     : 3.1 - ly_cmp_next checks and the late lyc write strobe
//                  3.0 - rewritten for ppu_reg 3.0. the line is an edge on the
//                  or of the enabled conditions, the coincidence flag is a
//                  register with freeze and compare-off rules, and stat mode
//                  and ly come from the cpu views.
//                  2.2 - added obp0_out, obp1_out, wy_out, and wx_out checks
//                  2.1 - added bgp_out checks
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

    reg [1:0] stat_mode_next;
    reg [7:0] ly_cpu_next;
    reg [7:0] ly_cmp_next;
    reg       cmp_off_next;
    reg       term_m0_next;
    reg       term_m1_next;
    reg       term_m2_next;
    wire [7:0] lcdc_out;
    wire [7:0] scx_out;
    wire [7:0] scy_out;
    wire [7:0] bgp_out;
    wire [7:0] obp0_out;
    wire [7:0] obp1_out;
    wire [7:0] wy_out;
    wire [7:0] wx_out;
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
        .stat_mode_next    (stat_mode_next),
        .ly_cpu_next       (ly_cpu_next),
        .ly_cmp_next       (ly_cmp_next),
        .cmp_off_next      (cmp_off_next),
        .term_m0_next      (term_m0_next),
        .term_m1_next      (term_m1_next),
        .term_m2_next      (term_m2_next),
        .lcdc_out          (lcdc_out),
        .scx_out           (scx_out),
        .scy_out           (scy_out),
        .bgp_out           (bgp_out),
        .obp0_out          (obp0_out),
        .obp1_out          (obp1_out),
        .wy_out            (wy_out),
        .wx_out            (wx_out),
        .irq_lcdstat       (irq_lcdstat)
    );

    task set_ly(input [7:0] nxt);
        begin ly_cpu_next = nxt; ly_cmp_next = nxt; end
    endtask

    // one full clock, ce_gb as it stands. the registers settle on it
    task tick;
        begin
            @(posedge clk);
            @(negedge clk);
        end
    endtask

    task set_terms(input m0, input m1, input m2);
        begin term_m0_next = m0; term_m1_next = m1; term_m2_next = m2; end
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

    task check_win_pal(input [7:0] e_obp0, input [7:0] e_obp1, input [7:0] e_wy, input [7:0] e_wx,
                       input [8*100:1] label);
        begin
            #1;
            checks = checks + 1;
            if (obp0_out === e_obp0 && obp1_out === e_obp1 && wy_out === e_wy && wx_out === e_wx)
                $display("PASS %0s: obp0=0x%02h obp1=0x%02h wy=0x%02h wx=0x%02h", label, obp0_out, obp1_out, wy_out, wx_out);
            else begin
                errors = errors + 1;
                $display("FAIL %0s: expected obp0=%02h obp1=%02h wy=%02h wx=%02h got obp0=%02h obp1=%02h wy=%02h wx=%02h",
                          label, e_obp0, e_obp1, e_wy, e_wx, obp0_out, obp1_out, wy_out, wx_out);
            end
        end
    endtask

    initial begin
        addr = 16'h0000; data_in = 8'h00; we = 1'b0; sel = 1'b0;
        ce_gb = 1'b1; ce_m = 1'b1;
        stat_mode_next = 2'd0; set_ly(8'd0); cmp_off_next = 1'b0;
        set_terms(1'b0, 1'b0, 1'b0);

        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // --- lcd is off at power-on -----------------------------------------
        check_lcdc_out(8'h00, "lcdc_out is 0 after reset, lcd off");
        check_bgp(8'h00, "bgp_out is 0 after reset");
        check_win_pal(8'h00, 8'h00, 8'h00, 8'h00, "obp0, obp1, wy, and wx exports are 0 after reset");

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
        check_win_pal(8'hD0, 8'h00, 8'h00, 8'h00, "obp0_out mirrors the write, the other three still at reset");
        write_reg(16'hFF49, 8'hC0); check_read(16'hFF49, 8'hC0, "obp1 readback");
        check_win_pal(8'hD0, 8'hC0, 8'h00, 8'h00, "obp1_out mirrors the write, obp0 unaffected");
        write_reg(16'hFF4A, 8'h78); check_read(16'hFF4A, 8'h78, "wy readback");
        check_win_pal(8'hD0, 8'hC0, 8'h78, 8'h00, "wy_out mirrors the write, the others unaffected");
        write_reg(16'hFF4B, 8'h9A); check_read(16'hFF4B, 8'h9A, "wx readback");
        check_win_pal(8'hD0, 8'hC0, 8'h78, 8'h9A, "wx_out mirrors the write, the others unaffected");

        // --- ly: read-only, and a read returns the value after the edge ------
        set_ly(8'd42);
        check_read(16'hFF44, 8'd42, "ly reads the cpu view, 42");
        set_ly(8'd43);
        check_read(16'hFF44, 8'd43, "ly read follows the cpu view when it moves to 43");
        set_ly(8'd143);
        write_reg(16'hFF44, 8'hFF);
        check_read(16'hFF44, 8'd143, "ly unaffected by a write attempt");

        // --- stat: mode view, bit 7, coincidence flag -------------------------
        // the lcd is on from here, lcdc is 0x91 from the readback tests
        stat_mode_next = 2'd2; set_ly(8'd10); write_reg(16'hFF45, 8'd99);
        check_read(16'hFF41, 8'b1000_0010, "stat: mode 2, bit 7 set, no coincidence, enables clear");
        stat_mode_next = 2'd0;
        check_read(16'hFF41, 8'b1000_0000, "stat: mode bits follow the stat mode view, now 0");
        stat_mode_next = 2'd3;
        check_read(16'hFF41, 8'b1000_0011, "stat: mode bits follow the stat mode view, now 3");
        stat_mode_next = 2'd1;
        check_read(16'hFF41, 8'b1000_0001, "stat: mode bits follow the stat mode view, now 1");
        stat_mode_next = 2'd0;

        write_reg(16'hFF45, 8'd10);
        check_read(16'hFF41, 8'b1000_0100, "stat: coincidence flag set when ly == lyc");
        set_ly(8'd11);
        check_read(16'hFF41, 8'b1000_0000, "stat: coincidence flag clears on the edge ly leaves");
        set_ly(8'd10);
        check_read(16'hFF41, 8'b1000_0100, "stat: and sets again on the edge ly arrives");
        cmp_off_next = 1'b1;
        check_read(16'hFF41, 8'b1000_0000, "stat: the flag reads 0 while the compare is held off");
        cmp_off_next = 1'b0;
        check_read(16'hFF41, 8'b1000_0100, "stat: and comes back when the hold ends");

        write_reg(16'hFF41, 8'b0111_1111);
        check_read(16'hFF41, 8'b1111_1100, "stat: enables took the write, mode/coincidence/bit7 did not");
        write_reg(16'hFF41, 8'b0000_0000);

        // a write that sets lyc to the current ly creates the match
        set_ly(8'd20); write_reg(16'hFF45, 8'd77);
        check_read(16'hFF41, 8'b1000_0000, "stat: lyc 77, ly 20, no match");
        write_reg(16'hFF45, 8'd20);
        check_read(16'hFF41, 8'b1000_0100, "stat: a lyc write that makes the match sets the flag");

        // --- the comparison has its own ly view --------------------------------
        // line 153 reads 0 sooner than the comparison stops seeing 153. the
        // ly register follows ly_cpu_next and the flag follows ly_cmp_next
        stat_mode_next = 2'd1;
        write_reg(16'hFF45, 8'd153);
        ly_cpu_next = 8'd0; ly_cmp_next = 8'd153;
        check_read(16'hFF44, 8'd0, "ly register follows the cpu view while the comparison still sees 153");
        check_read(16'hFF41, 8'b1000_0101, "flag follows the comparison view, lyc 153 still matches");
        ly_cpu_next = 8'd0; ly_cmp_next = 8'd0;
        check_read(16'hFF41, 8'b1000_0001, "flag clears when the comparison view moves on to 0");
        write_reg(16'hFF45, 8'd0);
        check_read(16'hFF41, 8'b1000_0101, "lyc 0 matches once the comparison view reads 0");
        write_reg(16'hFF45, 8'd99);
        stat_mode_next = 2'd0; set_ly(8'd20);

        // --- the flag is frozen while the lcd is off --------------------------
        set_ly(8'd20);
        write_reg(16'hFF45, 8'd20);
        tick;
        write_reg(16'hFF40, 8'h00);
        tick;
        set_ly(8'd0);                  // the cpu view reads 0 with the lcd off
        check_read(16'hFF41, 8'b1000_0100, "frozen: the flag keeps its value when the lcd turns off");
        write_reg(16'hFF45, 8'd0);
        tick;
        check_read(16'hFF41, 8'b1000_0100, "frozen: a lyc write while the lcd is off does not move the flag");
        write_reg(16'hFF45, 8'd99);
        tick;
        write_reg(16'hFF40, 8'h80);    // lcd on, the flag recomputes against ly 0
        tick;
        check_read(16'hFF41, 8'b1000_0000, "frozen: the flag recomputes once the lcd is on");
        write_reg(16'hFF45, 8'd0);
        check_read(16'hFF41, 8'b1000_0100, "frozen: and a lyc write with the lcd on moves it again");
        write_reg(16'hFF45, 8'd99);

        // --- the stat interrupt line -------------------------------------------
        set_ly(8'd0); cmp_off_next = 1'b0;
        write_reg(16'hFF41, 8'b0000_0000);
        tick; tick;
        set_terms(1'b1, 1'b1, 1'b1);
        check_irq(1'b0, "no enables, no irq, whatever the conditions say");
        set_terms(1'b0, 1'b0, 1'b0);
        tick;

        // each mode source needs its own enable
        write_reg(16'hFF41, 8'b0000_1000);
        set_terms(1'b0, 1'b1, 1'b1);
        check_irq(1'b0, "mode 0 enable only: conditions 1 and 2 do not fire it");
        set_terms(1'b1, 1'b0, 1'b0);
        check_irq(1'b1, "mode 0 enable: its own condition rising strobes");
        tick;
        check_irq(1'b0, "and it does not strobe again while the condition holds");
        set_terms(1'b0, 1'b0, 1'b0);
        tick;

        write_reg(16'hFF41, 8'b0001_0000);
        set_terms(1'b1, 1'b0, 1'b1);
        check_irq(1'b0, "mode 1 enable only: conditions 0 and 2 do not fire it");
        set_terms(1'b0, 1'b1, 1'b0);
        check_irq(1'b1, "mode 1 enable: its own condition rising strobes");
        tick;
        set_terms(1'b0, 1'b0, 1'b0);
        tick;

        write_reg(16'hFF41, 8'b0010_0000);
        set_terms(1'b1, 1'b1, 1'b0);
        check_irq(1'b0, "mode 2 enable only: conditions 0 and 1 do not fire it");
        set_terms(1'b0, 1'b0, 1'b1);
        check_irq(1'b1, "mode 2 enable: its own condition rising strobes");
        tick;
        check_irq(1'b0, "and the strobe is one clock wide");
        set_terms(1'b0, 1'b0, 1'b0);
        tick;

        // blocking. a condition that arrives while the line is already high
        // does nothing, and the line has to fall before it can fire again
        write_reg(16'hFF41, 8'b0010_1000);        // mode 0 and mode 2
        set_terms(1'b1, 1'b0, 1'b0);
        check_irq(1'b1, "blocking: the first condition raises the line");
        tick;
        set_terms(1'b1, 1'b0, 1'b1);
        check_irq(1'b0, "blocking: a second condition while the line is high does not strobe");
        tick;
        set_terms(1'b0, 1'b0, 1'b1);
        check_irq(1'b0, "blocking: the first one dropping while the second holds keeps the line high");
        tick;
        set_terms(1'b0, 1'b0, 1'b0);
        tick;
        set_terms(1'b0, 1'b0, 1'b1);
        check_irq(1'b1, "blocking: after the line fell the second condition fires on its own");
        tick;
        // the handover on one edge, one condition falling as another rises,
        // is no edge on the or
        set_terms(1'b1, 1'b0, 1'b0);
        tick;
        set_terms(1'b0, 1'b0, 1'b1);
        check_irq(1'b0, "blocking: a handover on one edge between two conditions is not a new edge");
        tick;
        set_terms(1'b0, 1'b0, 1'b0);
        tick;

        // enabling a condition that already holds is an edge, on the write's own edge
        write_reg(16'hFF41, 8'b0000_0000);
        set_terms(1'b0, 1'b1, 1'b0);
        tick;
        check_irq(1'b0, "write-enable: premise, the condition holds with its enable off");
        @(negedge clk);
        addr = 16'hFF41; data_in = 8'b0001_0000; we = 1'b1; sel = 1'b1;
        check_irq(1'b1, "write-enable: a stat write that enables a holding condition strobes on its own edge");
        tick;
        we = 1'b0;
        check_irq(1'b0, "write-enable: and not again once the write has landed");
        set_terms(1'b0, 1'b0, 1'b0);
        tick;
        // disabling then dropping then writing again does not leave stale state
        write_reg(16'hFF41, 8'b0000_0000);
        tick;

        // the line register moves only on ce_gb. a condition that rises on a
        // clock without ce_gb must still strobe on the first edge that has it
        write_reg(16'hFF41, 8'b0000_1000);
        tick;
        ce_gb = 1'b0;
        set_terms(1'b1, 1'b0, 1'b0);
        tick;
        ce_gb = 1'b1;
        check_irq(1'b1, "the line register ignores clocks without ce_gb, the first ce_gb edge strobes");
        tick;
        set_terms(1'b0, 1'b0, 1'b0);
        tick;

        // every enable bit, written while its condition already holds, makes
        // the edge on the write's own edge. mode 1 was done above
        write_reg(16'hFF41, 8'b0000_0000);
        set_terms(1'b1, 1'b0, 1'b0);
        tick;
        @(negedge clk);
        addr = 16'hFF41; data_in = 8'b0000_1000; we = 1'b1; sel = 1'b1;
        check_irq(1'b1, "write-enable: mode 0 enable written while its condition holds strobes on the write's edge");
        tick;
        we = 1'b0;
        write_reg(16'hFF41, 8'b0000_0000);
        set_terms(1'b0, 1'b0, 1'b1);
        tick;
        @(negedge clk);
        addr = 16'hFF41; data_in = 8'b0010_0000; we = 1'b1; sel = 1'b1;
        check_irq(1'b1, "write-enable: mode 2 enable written while its condition holds strobes on the write's edge");
        tick;
        we = 1'b0;
        write_reg(16'hFF41, 8'b0000_0000);
        set_terms(1'b0, 1'b0, 1'b0);
        write_reg(16'hFF45, 8'd60);
        set_ly(8'd60);
        tick;
        @(negedge clk);
        addr = 16'hFF41; data_in = 8'b0100_0000; we = 1'b1; sel = 1'b1;
        check_irq(1'b1, "write-enable: lyc enable written while the flag is set strobes on the write's edge");
        tick;
        we = 1'b0;
        write_reg(16'hFF41, 8'b0000_0000);
        write_reg(16'hFF45, 8'd99);
        set_ly(8'd20);
        tick;

        // the coincidence source
        write_reg(16'hFF41, 8'b0100_0000);
        write_reg(16'hFF45, 8'd50);
        set_ly(8'd20);
        tick;
        check_irq(1'b0, "coincidence: no match, no irq");
        set_ly(8'd50);
        check_irq(1'b1, "coincidence: strobes on the edge ly arrives at lyc, not a tick later");
        tick;
        check_irq(1'b0, "coincidence: no strobe while the match persists");
        set_ly(8'd51);
        check_irq(1'b0, "coincidence: no strobe on the edge the match disappears");
        tick;
        // the flag is held 0 while the compare is off, so the line falls
        // there and rises when the compare comes back
        set_ly(8'd50);
        tick;
        cmp_off_next = 1'b1;
        tick;
        check_irq(1'b0, "coincidence: held off, nothing");
        cmp_off_next = 1'b0;
        check_irq(1'b1, "coincidence: the compare coming back with a match is a new edge");
        tick;
        set_ly(8'd20);
        tick;

        // a write to lyc that creates the match strobes on the write's own edge
        write_reg(16'hFF45, 8'd77);
        tick;
        check_irq(1'b0, "coincidence: lyc 77, ly 20, no match yet");
        @(negedge clk);
        addr = 16'hFF45; data_in = 8'd20; we = 1'b1; sel = 1'b1;
        check_irq(1'b1, "coincidence: a write to lyc that creates a match strobes on the write's own edge");
        tick;
        we = 1'b0;
        check_irq(1'b0, "coincidence: and it does not strobe again once the write has landed");

        // a write to lyc on the very edge the match arrives does not take
        // the interrupt back. the old lyc matched first, the write only
        // clears the flag afterwards
        write_reg(16'hFF45, 8'd50);
        set_ly(8'd20);
        tick;
        check_irq(1'b0, "late write: lyc 50, ly 20, no match yet");
        @(negedge clk);
        addr = 16'hFF45; data_in = 8'd77; we = 1'b1; sel = 1'b1;
        set_ly(8'd50);
        check_irq(1'b1, "late write: ly arrives at the old lyc as lyc moves away, the strobe stands");
        tick;
        we = 1'b0;
        check_irq(1'b0, "late write: and no second strobe after the write lands");
        check_read(16'hFF41, 8'b1100_0000, "late write: the flag itself follows the new lyc and is clear");
        set_ly(8'd20);
        tick;

        // a write to some other peripheral whose address also ends in 5, the
        // timer's tima at 0xFF05 for one, must not be mistaken for a lyc write
        write_reg(16'hFF45, 8'd77);
        tick;
        @(negedge clk);
        addr = 16'hFF05; data_in = 8'd20; we = 1'b1; sel = 1'b0;
        check_irq(1'b0, "a write to another peripheral ending in 5 is not seen as a lyc write");
        tick;
        we = 1'b0; sel = 1'b1;
        check_read(16'hFF45, 8'd77, "and lyc itself was not touched by it");
        write_reg(16'hFF45, 8'd50);
        tick;
        set_ly(8'd20);
        tick;

        // ce_gb gating, the event edge must carry ce_gb
        set_ly(8'd50);
        check_irq(1'b1, "premise: the match event would strobe here");
        ce_gb = 1'b0;
        check_irq(1'b0, "irq does not strobe when ce_gb is low, even on a real event");
        ce_gb = 1'b1;
        tick;
        set_ly(8'd20);
        tick;

        // with the lcd off the mode conditions are low (the fsm sees to that)
        // and a set flag keeps the line up, so turning the lcd on does not
        // make a second irq
        set_ly(8'd20);
        write_reg(16'hFF45, 8'd20);
        tick; tick;
        write_reg(16'hFF40, 8'h00);
        tick;
        set_ly(8'd0);
        tick;
        check_irq(1'b0, "lcd off with the flag set: no strobe");
        write_reg(16'hFF45, 8'd0);       // ignored by the flag while off
        tick;
        write_reg(16'hFF40, 8'h80);
        check_irq(1'b0, "lcd on again with the flag set: no irq on the next edge either, the line never fell");
        tick;
        check_irq(1'b0, "lcd on again with the flag still set and ly 0 equal to lyc 0 changed nothing, no second irq");
        write_reg(16'hFF40, 8'h00);
        write_reg(16'hFF45, 8'd5);
        tick;
        write_reg(16'hFF40, 8'h80);
        tick;
        check_irq(1'b0, "lcd on with the flag falling as ly 0 meets lyc 5: no irq");
        write_reg(16'hFF45, 8'd0);
        check_read(16'hFF41, 8'b1100_0100, "premise: lyc 0 against ly 0 reads as a match");
        write_reg(16'hFF45, 8'd5);
        write_reg(16'hFF41, 8'b0000_0000);

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

        // the window and object palette exports follow only committed writes
        @(negedge clk);
        addr = 16'hFF4B; data_in = 8'h55; we = 1'b1; sel = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_win_pal(8'hD0, 8'hC0, 8'h78, 8'h9A, "wx write ignored while sel low");
        @(negedge clk);
        addr = 16'hFF48; data_in = 8'h55; we = 1'b1; sel = 1'b1; ce_m = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce_m = 1'b1;
        check_win_pal(8'hD0, 8'hC0, 8'h78, 8'h9A, "obp0 write ignored while ce_m low");

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule
