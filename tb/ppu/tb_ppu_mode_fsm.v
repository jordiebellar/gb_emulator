// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_mode_fsm.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : golden-model testbench for the ppu mode state machine.
//
//                  the golden model is a set of functions of one number, t,
//                  the count of ce_gb edges since the lcd turned on. it knows
//                  nothing about the rtl's registers or its delay chain. from
//                  t it works out which line the engine is on, the engine dot
//                  (the first line starts at dot 4 and is 452 dots long, every
//                  other line is 456), the engine mode (mode 3 lasts a
//                  different number of dots on every line, as it does with
//                  sprites), and then every view the cpu gets - stat mode,
//                  ly, the compare hold, the four locks, and the three mode
//                  conditions - straight from the definitions in the rtl
//                  header.
//
//                  a monitor compares all of those against the next-state
//                  exports on every single edge, across more than two full
//                  frames, so the first line after lcd on, the frame wrap
//                  into a normal line 0, line 144 and the line 153 ly quirk
//                  are all covered. it also compares the registered dot
//                  counter and the four strobes. the same monitor runs with
//                  ce_gb pulsing one clock in four, where the exports must
//                  sit still between edges.
//
//                  directed checks pin the model itself to numbers that came
//                  from hardware tests, counted in dots after the lcd on
//                  write: stat reads 3 from dot 80 and 0 again from dot 249
//                  on the first line with a 172 dot mode 3, ly reads 1 from
//                  dot 452, oam reads lock at dot 452, vram reads lock 4
//                  dots before vram writes do, and so on. part 2 covers the
//                  lcd enable, which masks every export at once, restarts at
//                  line 0 with a first line, and gates the strobes at the
//                  exact edges where they would otherwise fire.
// Revision     : 4.0 - rewritten for ppu_mode_fsm 4.0. golden model of the
//                  cpu views, first line, and engine dot 4 idle.
//                  3.0 - added the mode_next and ly_next monitor
//                  2.3 - added lcd_en and the part 2 checks
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu_mode_fsm;

    localparam MODE_HBLANK         = 2'd0;
    localparam MODE_VBLANK         = 2'd1;
    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;

    reg clk;
    reg ce_gb;
    reg rst;
    reg lcd_en;
    wire fifo_done;

    wire [1:0] mode;
    wire [8:0] dot_counter;
    wire [7:0] ly;
    wire [1:0] mode_next;
    wire [7:0] ly_next;
    wire [1:0] stat_mode_next;
    wire [7:0] ly_cpu_next;
    wire       cmp_off_next;
    wire       oam_blocked_next;
    wire       vram_blocked_next;
    wire       oam_wr_blocked_next;
    wire       vram_wr_blocked_next;
    wire       term_m0_next;
    wire       term_m1_next;
    wire       term_m2_next;
    wire       first_line;
    wire       win_check;
    wire       entering_hblank;
    wire       entering_oam_scan;
    wire       entering_vblank;
    wire       irq_vblank;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;

    ppu_mode_fsm dut (
        .clk                  (clk),
        .ce_gb                (ce_gb),
        .rst                  (rst),
        .lcd_en               (lcd_en),
        .fifo_done            (fifo_done),
        .mode                 (mode),
        .dot_counter          (dot_counter),
        .ly                   (ly),
        .mode_next            (mode_next),
        .ly_next              (ly_next),
        .stat_mode_next       (stat_mode_next),
        .ly_cpu_next          (ly_cpu_next),
        .cmp_off_next         (cmp_off_next),
        .oam_blocked_next     (oam_blocked_next),
        .vram_blocked_next    (vram_blocked_next),
        .oam_wr_blocked_next  (oam_wr_blocked_next),
        .vram_wr_blocked_next (vram_wr_blocked_next),
        .term_m0_next         (term_m0_next),
        .term_m1_next         (term_m1_next),
        .term_m2_next         (term_m2_next),
        .first_line           (first_line),
        .win_check            (win_check),
        .entering_hblank      (entering_hblank),
        .entering_oam_scan    (entering_oam_scan),
        .entering_vblank      (entering_vblank),
        .irq_vblank           (irq_vblank)
    );

    // ------------------------------------------------------------------------
    // the fetcher stand in. mode 3 lasts a different number of dots on every
    // line, 172 to 194, and fifo_done is high on its last dot
    // ------------------------------------------------------------------------
    function integer m3len(input integer l);
        begin
            m3len = 172 + ((l * 7) % 23);
        end
    endfunction

    assign fifo_done = (mode == MODE_PIXEL_TRANSFER) &&
                       (dot_counter == 9'd80 + m3len(ly) - 1);

    // ------------------------------------------------------------------------
    // the golden model. t is the count of ce_gb edges since the lcd turned on
    // ------------------------------------------------------------------------
    // the engine line, counted from the first one after lcd on
    function integer g_line(input integer t);
        begin
            g_line = (t < 452) ? 0 : 1 + (t - 452) / 456;
        end
    endfunction

    // the engine dot, 4 to 455 on the first line and 0 to 455 on the rest
    function integer g_dot(input integer t);
        begin
            g_dot = (t < 452) ? t + 4 : (t - 452) % 456;
        end
    endfunction

    function integer g_ly(input integer t);
        begin
            g_ly = (g_line(t) == 0) ? 0 : g_line(t) % 154;
        end
    endfunction

    function g_first(input integer t);
        begin
            g_first = (t < 452);
        end
    endfunction

    // the engine mode. before the lcd turned on it reads hblank
    function [1:0] g_eng(input integer t);
        integer l, d;
        begin
            if (t < 0) g_eng = MODE_HBLANK;
            else begin
                l = g_ly(t); d = g_dot(t);
                if (l >= 144)                       g_eng = MODE_VBLANK;
                else if (g_first(t) && d < 80)      g_eng = MODE_HBLANK;
                else if (d < 80)                    g_eng = MODE_OAM_SCAN;
                else if (d < 80 + m3len(l))         g_eng = MODE_PIXEL_TRANSFER;
                else                                g_eng = MODE_HBLANK;
            end
        end
    endfunction

    // the stat mode is the engine mode 4 dots late, and the end of mode 3
    // shows after 1
    function [1:0] g_stat(input integer t);
        begin
            g_stat = (g_eng(t - 4) == MODE_PIXEL_TRANSFER) ? g_eng(t - 1) : g_eng(t - 4);
        end
    endfunction

    function [7:0] g_lyc(input integer t);   // ly as the cpu reads it
        begin
            g_lyc = (g_ly(t) == 153 && g_dot(t) >= 8) ? 8'd0 : g_ly(t);
        end
    endfunction

    function g_cmp_off(input integer t);
        begin
            g_cmp_off = (g_dot(t) < 4);
        end
    endfunction

    function g_oam_rd(input integer t);
        begin
            g_oam_rd = (g_stat(t) == MODE_PIXEL_TRANSFER) ||
                       (!g_first(t) && (g_eng(t) == MODE_OAM_SCAN || g_eng(t) == MODE_PIXEL_TRANSFER));
        end
    endfunction

    function g_vram_rd(input integer t);
        begin
            g_vram_rd = (g_stat(t) == MODE_PIXEL_TRANSFER) ||
                        (!g_first(t) && g_eng(t) == MODE_PIXEL_TRANSFER);
        end
    endfunction

    function g_vram_wr(input integer t);
        begin
            g_vram_wr = (g_stat(t) == MODE_PIXEL_TRANSFER);
        end
    endfunction

    function g_oam_wr(input integer t);
        begin
            g_oam_wr = (g_stat(t) == MODE_PIXEL_TRANSFER) ||
                       (g_stat(t) == MODE_OAM_SCAN && g_eng(t) == MODE_OAM_SCAN);
        end
    endfunction

    function g_m0(input integer t);
        begin
            g_m0 = (g_eng(t) == MODE_HBLANK) && (g_eng(t - 3) == MODE_HBLANK) &&
                   !(g_first(t) && g_dot(t) < 80);
        end
    endfunction

    function g_m1(input integer t);
        begin
            g_m1 = (g_eng(t) == MODE_VBLANK);
        end
    endfunction

    function g_m2(input integer t);
        begin
            g_m2 = (g_eng(t) == MODE_OAM_SCAN) || (g_ly(t) == 144 && g_dot(t) < 4);
        end
    endfunction

    function g_win(input integer t);
        begin
            g_win = (g_eng(t) == MODE_OAM_SCAN) || (g_first(t) && g_dot(t) < 80);
        end
    endfunction

    // ------------------------------------------------------------------------
    // the monitor. every posedge, the exports as they stand before the edge
    // are the values after it, so they are compared with the model at the t
    // the edge leads to. with ce_gb low the edge does not move t. lcd_en
    // only changes on a negedge here, so it is steady across the edge
    // ------------------------------------------------------------------------
    integer tcount = 0;      // edges counted so far since lcd on, 0 while off
    integer mon_checked = 0;
    integer mon_bad     = 0;
    integer mon_moves   = 0; // edges where the stat mode or ly changed
    integer mon_shown   = 0;
    integer ta;
    reg [1:0] last_stat;
    reg [7:0] last_ly;
    reg       bad_now;
    reg       exp_hb, exp_oam, exp_vb;

    task mismatch(input [8*40:1] what);
        begin
            bad_now = 1'b1;
            if (mon_shown < 8) begin
                mon_shown = mon_shown + 1;
                $display("      monitor: %0s wrong at t=%0d (line %0d dot %0d)", what, ta, g_ly(ta), g_dot(ta));
            end
        end
    endtask

    always @(posedge clk) begin
        if (!rst) begin
            bad_now = 1'b0;
            if (!lcd_en) begin
                tcount = 0;
                if (stat_mode_next !== 2'd0 || ly_cpu_next !== 8'd0) mismatch("lcd off, stat or ly");
                if (oam_blocked_next !== 1'b0 || vram_blocked_next !== 1'b0 ||
                    oam_wr_blocked_next !== 1'b0 || vram_wr_blocked_next !== 1'b0) mismatch("lcd off, a lock");
                if (term_m0_next !== 1'b0 || term_m1_next !== 1'b0 || term_m2_next !== 1'b0) mismatch("lcd off, a condition");
                if (cmp_off_next !== 1'b0) mismatch("lcd off, compare hold");
                if (mode_next !== 2'd0 || ly_next !== 8'd0) mismatch("lcd off, engine mode or ly");
                ta = 0;
            end
            else begin
                ta = ce_gb ? tcount + 1 : tcount;
                if (stat_mode_next !== g_stat(ta))      mismatch("stat mode");
                if (ly_cpu_next !== g_lyc(ta))          mismatch("ly");
                if (cmp_off_next !== g_cmp_off(ta))     mismatch("compare hold");
                if (oam_blocked_next !== g_oam_rd(ta))  mismatch("oam read lock");
                if (vram_blocked_next !== g_vram_rd(ta)) mismatch("vram read lock");
                if (oam_wr_blocked_next !== g_oam_wr(ta)) mismatch("oam write lock");
                if (vram_wr_blocked_next !== g_vram_wr(ta)) mismatch("vram write lock");
                if (term_m0_next !== g_m0(ta))          mismatch("mode 0 condition");
                if (term_m1_next !== g_m1(ta))          mismatch("mode 1 condition");
                if (term_m2_next !== g_m2(ta))          mismatch("mode 2 condition");
                if (mode_next !== g_eng(ta))            mismatch("engine mode");
                if (ly_next !== g_ly(ta))               mismatch("engine ly");
                // the strobes belong to the edge itself, so the t before it
                exp_hb  = ce_gb && (g_eng(tcount) == MODE_PIXEL_TRANSFER) && (g_eng(tcount + 1) == MODE_HBLANK);
                exp_oam = ce_gb && (g_dot(tcount) == 455) && (g_ly(tcount) == 153 || g_ly(tcount) < 143);
                exp_vb  = ce_gb && (g_dot(tcount) == 455) && (g_ly(tcount) == 143);
                if (entering_hblank   !== exp_hb)  mismatch("entering_hblank");
                if (entering_oam_scan !== exp_oam) mismatch("entering_oam_scan");
                if (entering_vblank   !== exp_vb)  mismatch("entering_vblank");
                if (irq_vblank        !== exp_vb)  mismatch("irq_vblank");
                if (win_check !== g_win(tcount))   mismatch("win_check");
                if (first_line !== g_first(tcount)) mismatch("first_line");
                if (ta != tcount && (g_stat(ta) !== g_stat(tcount) || g_lyc(ta) !== g_lyc(tcount))) mon_moves = mon_moves + 1;
                tcount = ta;
            end
            mon_checked = mon_checked + 1;
            if (bad_now) mon_bad = mon_bad + 1;
        end
    end

    // the registered dot counter and masked engine mode and ly, at every
    // negedge, against the model
    integer reg_bad = 0;
    always @(negedge clk) begin
        if (!rst) begin
            if (lcd_en && tcount > 0) begin
                if (dot_counter !== g_dot(tcount) || ly !== g_ly(tcount) || mode !== g_eng(tcount))
                    reg_bad = reg_bad + 1;
            end
        end
    end

    task check(input expr, input [8*90:1] label);
        begin
            checks = checks + 1;
            if (expr) $display("PASS  %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s  (t=%0d mode=%0d dot=%0d ly=%0d)", label, tcount, mode, dot_counter, ly);
            end
        end
    endtask

    // run to just before the edge that leads to t, so the exports show t
    task goto_t(input integer t);
        begin
            while (tcount < t - 1) @(negedge clk);
        end
    endtask

    // ------------------------------------------------------------------------
    initial begin
        lcd_en = 1'b1;
        ce_gb  = 1'b1;
        rst    = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // =====================================================================
        // part 1 - directed checks that pin the model to hardware numbers.
        // t is the number of dots since the lcd turned on
        // =====================================================================
        $display("=== directed checks, first line after lcd on, mode 3 of %0d dots ===", m3len(0));
        check(dot_counter === 9'd4 && ly === 8'd0 && first_line === 1'b1 && mode === MODE_HBLANK,
              "idle before the first edge: engine dot 4, line 0, first line, hblank");

        goto_t(1);
        check(stat_mode_next === 2'd0 && ly_cpu_next === 8'd0, "t=1: stat mode 0, ly 0");
        goto_t(75);
        check(vram_blocked_next === 1'b0 && oam_blocked_next === 1'b0, "t=75: nothing locked yet");
        goto_t(79);
        check(stat_mode_next === 2'd0, "t=79: stat still reads mode 0, the first line has no mode 2");
        check(vram_blocked_next === 1'b0 && oam_blocked_next === 1'b0,
              "t=79: first line, the engine is in mode 3 but the locks wait for the stat mode");
        check(mode_next === MODE_PIXEL_TRANSFER, "t=76 onward: the engine itself is in mode 3, 4 dots ahead");
        goto_t(80);
        check(stat_mode_next === 2'd3, "t=80: stat reads mode 3");
        check(vram_blocked_next === 1'b1 && oam_blocked_next === 1'b1, "t=80: vram and oam reads locked");
        check(vram_wr_blocked_next === 1'b1 && oam_wr_blocked_next === 1'b1, "t=80: and writes");
        goto_t(248);
        check(stat_mode_next === 2'd3, "t=248: stat still reads mode 3, the engine already left it");
        goto_t(249);
        check(stat_mode_next === 2'd0 && vram_blocked_next === 1'b0 && oam_blocked_next === 1'b0,
              "t=249: stat reads 0 and both unlock, 1 dot after the engine, not 4");
        goto_t(451);
        check(ly_cpu_next === 8'd0, "t=451: ly still 0");
        goto_t(452);
        check(ly_cpu_next === 8'd1, "t=452: ly reads 1, 452 dots after the lcd on write");
        check(oam_blocked_next === 1'b1, "t=452: oam reads lock, 4 dots before the stat mode shows 2");
        check(oam_wr_blocked_next === 1'b0, "t=452: oam writes are still allowed");
        check(stat_mode_next === 2'd0, "t=452: stat still reads 0");
        check(cmp_off_next === 1'b1, "t=452: the compare is held off");
        check(term_m2_next === 1'b1, "t=452: the mode 2 condition is up, the interrupt fires here");
        goto_t(455);
        check(stat_mode_next === 2'd0 && cmp_off_next === 1'b1, "t=455: stat still 0, compare still held");
        goto_t(456);
        check(stat_mode_next === 2'd2 && cmp_off_next === 1'b0, "t=456: stat reads 2, the compare is back, line 1 is 456 dots after");
        check(oam_wr_blocked_next === 1'b1, "t=456: oam writes lock with the stat mode");
        goto_t(528);
        check(vram_blocked_next === 1'b0, "t=528 (line 1 dot 72 in view): vram reads still open");
        goto_t(532);
        check(vram_blocked_next === 1'b1 && vram_wr_blocked_next === 1'b0,
              "t=532 (line 1 dot 76 in view): vram reads lock, writes do not yet");
        check(oam_blocked_next === 1'b1 && oam_wr_blocked_next === 1'b0,
              "t=532: oam reads stay locked and oam writes get through for these 4 dots");
        goto_t(536);
        check(vram_wr_blocked_next === 1'b1 && oam_wr_blocked_next === 1'b1 && stat_mode_next === 2'd3,
              "t=536 (line 1 dot 80 in view): stat reads 3 and both write locks are on");

        // =====================================================================
        // part 2 - the model against the rtl on every edge, over a frame and a
        // half, with ce_gb on every clock
        // =====================================================================
        $display("");
        $display("=== monitor, ce_gb on every clock ===");
        goto_t(452 + 156 * 456 - 1 - 70);    // line 156 of the engine is line 2 of the next frame
        check(g_ly(tcount + 1) === 2 && g_line(tcount + 1) === 156, "premise: the model is in the second frame");
        goto_t(452 + 156 * 456 + 456 + 100);
        check(mon_bad === 0, "monitor, ce_gb every clock: every export matches the model on every edge");
        check(reg_bad === 0, "registered dot, ly and engine mode match the model on every edge");
        check(mon_checked > 70000, "monitor: compared on over a frame's worth of edges");
        check(mon_moves > 300, "monitor: and many of those edges moved the stat mode or ly, so it is not vacuous");

        // =====================================================================
        // part 3 - ce_gb pulsing, one clock in four. between edges nothing
        // may move, and the exports must show the settled values
        // =====================================================================
        $display("");
        $display("=== monitor, ce_gb one clock in four ===");
        begin : slow
            integer bad_before, n;
            bad_before = mon_bad;
            n = 0;
            while (n < 2 * 456 * 4 + 400) begin
                @(negedge clk);
                ce_gb = (n % 4 == 3);
                n = n + 1;
            end
            ce_gb = 1'b1;
            @(negedge clk);
            check(mon_bad === bad_before, "monitor, ce_gb one clock in four: exports match the model, and sit still between edges");
        end
        check(reg_bad === 0, "registered values still match the model after the slow ce_gb run");

        // =====================================================================
        // part 4 - reset and lcd enable
        // =====================================================================
        $display("");
        $display("=== reset and lcd enable ===");
        @(negedge clk);
        rst = 1'b1;
        @(posedge clk);
        @(negedge clk);
        check(mode === MODE_HBLANK && dot_counter === 9'd4 && ly === 8'd0 && first_line === 1'b1,
              "async reset: hblank, engine dot 4, line 0, first line, immediately");
        rst = 1'b0;
        tcount = 0;

        // run a way into the first frame and turn the lcd off mid line
        repeat (456 * 3 + 130) @(negedge clk);
        check(ly === 8'd3 && mode === MODE_PIXEL_TRANSFER, "premise: mid mode 3 on line 3");
        check(vram_blocked_next === 1'b1, "premise: vram reads locked");
        lcd_en = 1'b0;
        #1;
        check(mode === MODE_HBLANK && ly === 8'd0, "lcd off: engine mode and ly read hblank and 0 at once");
        check(stat_mode_next === 2'd0 && ly_cpu_next === 8'd0, "lcd off: stat mode and ly read 0 at once");
        check(oam_blocked_next === 1'b0 && vram_blocked_next === 1'b0 &&
              oam_wr_blocked_next === 1'b0 && vram_wr_blocked_next === 1'b0, "lcd off: all four locks drop at once");
        check(term_m0_next === 1'b0 && term_m1_next === 1'b0 && term_m2_next === 1'b0 && cmp_off_next === 1'b0,
              "lcd off: the three conditions and the compare hold read low at once");
        @(posedge clk);
        @(negedge clk);
        check(dot_counter === 9'd4 && first_line === 1'b1, "lcd off: one tick later the engine is back at dot 4 with first_line set");

        begin : quiet
            reg seen;
            integer q;
            seen = 1'b0;
            for (q = 0; q < 1000; q = q + 1) begin
                @(posedge clk);
                seen = seen | entering_hblank | entering_oam_scan | entering_vblank | irq_vblank;
            end
            @(negedge clk);
            check(seen === 1'b0, "lcd off: no strobe fires across 1000 ticks");
            check(dot_counter === 9'd4 && ly === 8'd0 && mode === MODE_HBLANK, "lcd off: still idle after 1000 ticks");
        end

        // lcd on restarts at line 0 on a first line, not where it left off
        @(negedge clk);
        lcd_en = 1'b1;
        #1;
        check(mode === MODE_HBLANK && ly === 8'd0 && dot_counter === 9'd4 && first_line === 1'b1,
              "lcd on: line 0, engine dot 4, first line, hblank - there is no mode 2");
        check(win_check === 1'b1, "lcd on: the window y condition is already being watched");
        goto_t(80);
        check(stat_mode_next === 2'd3, "lcd on: stat reads 3 after 80 dots");

        // strobes are gated by lcd_en at the exact edges they would fire
        goto_t(452 + 455);
        @(negedge clk);
        check(dot_counter === 9'd455 && ly === 8'd1, "premise: engine dot 455 of line 1, the edge into line 2");
        check(entering_oam_scan === 1'b1, "lcd on: entering_oam_scan fires on that edge");
        check(entering_hblank === 1'b0 && entering_vblank === 1'b0 && irq_vblank === 1'b0, "lcd on: no other strobe fires there");
        lcd_en = 1'b0;
        #1;
        check(entering_oam_scan === 1'b0, "lcd off: entering_oam_scan is gated at the edge it would fire");
        lcd_en = 1'b1;
        #1;
        check(entering_oam_scan === 1'b1, "and it is back the moment lcd_en is");
        // that glitch must not have been seen by the model, no edge passed

        // end of mode 3 on line 2, where the engine goes to hblank
        goto_t(452 + 456 + 80 + m3len(2) - 1);
        @(negedge clk);
        check(mode === MODE_PIXEL_TRANSFER && fifo_done === 1'b1, "premise: last dot of mode 3 on line 2");
        check(entering_hblank === 1'b1, "lcd on: entering_hblank fires on that edge");
        begin : hold
            force dut.fifo_done = 1'b1;
            lcd_en = 1'b0;
            #1;
            check(entering_hblank === 1'b0, "lcd off: entering_hblank is gated at the edge it would fire");
            lcd_en = 1'b1;
            #1;
            release dut.fifo_done;
            #1;
            check(entering_hblank === 1'b1, "and it is back the moment lcd_en is");
        end

        // end of line 143, the edge that enters vblank
        goto_t(452 + 142 * 456 + 455);
        @(negedge clk);
        check(ly === 8'd143 && dot_counter === 9'd455, "premise: engine dot 455 of line 143");
        check(entering_vblank === 1'b1 && irq_vblank === 1'b1, "lcd on: entering_vblank and irq_vblank fire at the end of line 143");
        lcd_en = 1'b0;
        #1;
        check(entering_vblank === 1'b0 && irq_vblank === 1'b0, "lcd off: both are gated at the edge they would fire");
        lcd_en = 1'b1;
        #1;
        check(entering_vblank === 1'b1 && irq_vblank === 1'b1, "and they are back the moment lcd_en is");
        goto_t(452 + 143 * 456 + 2);
        check(ly_cpu_next === 8'd144 && stat_mode_next === 2'd0, "line 144: ly reads 144 and stat still reads 0 for its first 4 dots");
        check(term_m1_next === 1'b1 && term_m2_next === 1'b1, "line 144: the mode 1 condition is up, and so is the short mode 2 one");
        goto_t(452 + 143 * 456 + 4);
        check(stat_mode_next === 2'd1 && term_m2_next === 1'b0, "line 144, 4 dots in: stat reads mode 1 and the short mode 2 condition is gone");

        // the whole of the run above, one more time
        check(mon_bad === 0, "monitor: nothing mismatched anywhere in parts 3 and 4 either");
        check(reg_bad === 0, "registered values matched the model throughout");

        $display("");
        $display("monitor: %0d edges compared, %0d moved the stat mode or ly, %0d mismatched",
                 mon_checked, mon_moves, mon_bad);
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED - engine, cpu views, first line, and lcd enable verified against the golden model", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

    initial begin
        #800000000;
        $display("TIMEOUT");
        $finish;
    end

endmodule
