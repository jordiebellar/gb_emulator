// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_mode_fsm.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : ppu mode timing core - dot_counter and ly drive mode 2 (oam
//                  scan, fixed 80 dots), mode 3 (pixel transfer, exits on
//                  fifo_done from the fetcher), mode 0 (hblank, fills the rest
//                  of the line) and mode 1 (vblank, 10 extra lines).
//                  mode, mode_next, ly and ly_next are the engine's own
//                  state, the one the oam scan and the fetcher run on.
//
//                  the engine's dot counter is the hardware line dot plus 4.
//                  the engine starts a line 4 dots before the line is visible
//                  to the cpu, and that is the moment ly changes, the oam
//                  locks and the mode 2 interrupt fires. everything the cpu
//                  can look at is a view built from that, listed below. all
//                  the views are exported as next-state values, meaning what
//                  they will read once the current edge completes. the
//                  contract (sections 3 and 4) says a cpu access that
//                  commits on an edge sees the peripheral's own update from
//                  that same edge first, so blocking decisions and register
//                  reads must be made from these and not from the registered
//                  values, which still hold the state from before the edge.
//                  the state is computed once, combinationally, and the
//                  registers just latch it, so the next-state values and the
//                  registered values cannot disagree.
//
//                  cpu views
//                    stat_mode_next   the stat mode bits. this is the engine
//                                     mode 4 dots late, so stat reads 0 for
//                                     the first 4 dots after a line starts
//                                     and mode 3 shows 4 dots after the
//                                     fetcher starts. the end of mode 3 is
//                                     the exception, mode 0 shows only 1 dot
//                                     after the fetcher finishes
//                    ly_cpu_next      ly as read. line 153 reads 153 for
//                                     only its first 8 engine dots and 0
//                                     for the rest of the line
//                    cmp_off_next     high for the first 4 engine dots of a
//                                     line, where the ly == lyc comparison is
//                                     held false
//                    oam_blocked_next oam is locked from the start of mode 2
//                                     until stat shows mode 0
//                    vram_blocked_next vram is locked from the moment the
//                                     fetcher starts until stat shows mode 0.
//                                     on the first line after lcd on the lock
//                                     starts with the stat mode 3 instead
//                    oam_wr_blocked_next, vram_wr_blocked_next
//                                     the same locks as they apply to cpu
//                                     writes, which hardware starts 4 dots
//                                     later than it starts them for reads.
//                                     the oam write lock also has a 4 dot gap
//                                     right where the fetcher starts
//                    term_m0_next, term_m1_next, term_m2_next
//                                     the three mode conditions that feed the
//                                     stat interrupt line, as levels. ppu_reg
//                                     ands them with the enable bits and
//                                     watches the or for a rising edge
//
//                  first_line says the line is the first after lcd on, the oam
//                  scan uses it to keep its object list empty. win_check is
//                  the window that the fetcher watches for the window y
//                  condition, mode 2 plus the dots mode 2 would have had on
//                  the first line.
//
//                  entering_hblank, entering_oam_scan and entering_vblank are
//                  the same-edge strobes of each engine transition's own
//                  guard condition. irq_vblank is literally entering_vblank.
//
//                  lcd_en is lcdc bit 7. while it is low the engine idles at
//                  engine dot 4 (visible dot 0) of line 0, the exported modes
//                  read hblank, ly reads 0 and nothing is blocked, so vram and
//                  oam are never locked and no strobe can fire. every export
//                  is masked by lcd_en combinationally, so turning the lcd off
//                  takes effect on the cpu visible side immediately. the
//                  internal counters follow on the next ce_gb tick.
//                  the exports assume lcd_en does not change on the edge being
//                  predicted. an lcdc write is itself the one bus access of its
//                  m-cycle, so no other access can observe the difference.
//
//                  the first line after lcd on is different on hardware. the
//                  engine starts it already past the mode 2 window, so there
//                  is no oam scan, no mode 2 interrupt and the stat mode stays
//                  0 until mode 3 begins. first_line marks it. the line is 452
//                  engine dots long because the engine counts from 4, so the
//                  next line becomes visible 456 dots after the lcdc write
//                  like every other line.
// Revision     : 4.0 - cpu views added, the engine dot counter starts at 4
//                  and the first line after lcd on has no mode 2. mode, ly
//                  and their next-state versions are unchanged for lines
//                  other than the first one.
//                  3.0 - refactored into a combinational next-state block and
//                  exported mode_next and ly_next.
//                  2.2 - added lcd_en
// =============================================================================
`timescale 1ns / 1ps

module ppu_mode_fsm (
    input  wire       clk,
    input  wire       ce_gb,
    input  wire       rst,
    input  wire       lcd_en,
    input  wire       fifo_done,

    output wire [1:0] mode,
    output reg  [8:0] dot_counter, // engine dot, held at 4 while the lcd is off
    output wire [7:0] ly,

    output wire [1:0] mode_next,   // engine mode after this edge
    output wire [7:0] ly_next,     // engine ly after this edge

    // what the cpu sees, all after this edge
    output wire [1:0] stat_mode_next,
    output wire [7:0] ly_cpu_next,
    output wire       cmp_off_next,
    output wire       oam_blocked_next,      // oam reads
    output wire       vram_blocked_next,     // vram reads
    output wire       oam_wr_blocked_next,   // oam writes
    output wire       vram_wr_blocked_next,  // vram writes
    output wire       term_m0_next,
    output wire       term_m1_next,
    output wire       term_m2_next,

    output wire       first_line,    // the first line after lcd on, no oam scan
    output wire       win_check,     // the window y condition is looked at now

    output wire       entering_hblank,
    output wire       entering_oam_scan,
    output wire       entering_vblank,
    output wire       irq_vblank
);

    localparam MODE_HBLANK         = 2'd0;
    localparam MODE_VBLANK         = 2'd1;
    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;

    localparam [8:0] DOT_IDLE      = 9'd4;   // visible dot 0
    localparam [8:0] DOT_LAST      = 9'd455;
    localparam [8:0] DOT_MODE3     = 9'd80;  // the fetcher starts here

    reg [1:0] mode_r;
    reg [7:0] ly_r;
    reg       first_line_r;

    // the engine mode, 1 to 4 ce_gb ticks ago. m_d4 is the stat mode
    reg [1:0] m_d1, m_d2, m_d3, m_d4;

    assign mode = lcd_en ? mode_r : MODE_HBLANK;
    assign ly   = lcd_en ? ly_r   : 8'd0;

    assign first_line = first_line_r;

    // the window y condition is watched during the oam scan, and on the first
    // line, which has no scan, during the dots the scan would have taken
    assign win_check = lcd_en && (mode_r == MODE_OAM_SCAN ||
                                  (first_line_r && dot_counter < DOT_MODE3));

    assign entering_hblank   = ce_gb && lcd_en && (dot_counter != DOT_LAST) &&
                                (mode_r == MODE_PIXEL_TRANSFER) && fifo_done;
    assign entering_oam_scan = ce_gb && lcd_en && (dot_counter == DOT_LAST) &&
                                ((ly_r == 8'd153) || (ly_r < 8'd143));
    assign entering_vblank   = ce_gb && lcd_en && (dot_counter == DOT_LAST) &&
                                (ly_r == 8'd143);
    assign irq_vblank        = entering_vblank;

    // next state, computed once. the registers below only latch it
    reg [8:0] dot_n;
    reg [7:0] ly_n;
    reg [1:0] mode_n;
    reg       first_n;

    always @(*) begin
        dot_n   = dot_counter;
        ly_n    = ly_r;
        mode_n  = mode_r;
        first_n = first_line_r;
        if (ce_gb) begin
            if (!lcd_en) begin
                // idle at the start of line 0, ready to run the moment
                // lcd_en rises
                dot_n   = DOT_IDLE;
                ly_n    = 8'd0;
                mode_n  = MODE_HBLANK;
                first_n = 1'b1;
            end
            else if (dot_counter == DOT_LAST) begin
                dot_n   = 9'd0;
                first_n = 1'b0;
                if (ly_r == 8'd153) begin
                    ly_n   = 8'd0;
                    mode_n = MODE_OAM_SCAN;
                end
                else begin
                    ly_n = ly_r + 8'd1;
                    if (ly_r == 8'd143)
                        mode_n = MODE_VBLANK;
                    else if (ly_r < 8'd143)
                        mode_n = MODE_OAM_SCAN;
                end
            end
            else begin
                dot_n = dot_counter + 9'd1;
                if ((mode_r == MODE_OAM_SCAN || (first_line_r && mode_r == MODE_HBLANK)) &&
                    dot_counter == DOT_MODE3 - 9'd1)
                    mode_n = MODE_PIXEL_TRANSFER;
                else if (mode_r == MODE_PIXEL_TRANSFER && fifo_done)
                    mode_n = MODE_HBLANK;
            end
        end
    end

    assign mode_next = lcd_en ? mode_n : MODE_HBLANK;
    assign ly_next   = lcd_en ? ly_n   : 8'd0;

    // ------------------------------------------------------------------------
    // cpu views
    // ------------------------------------------------------------------------
    // the stat mode is the engine mode 4 ticks late, except that the end of
    // mode 3 shows after only 1 tick. after an edge the engine mode 4 ticks
    // ago is what m_d3 holds now and 1 tick ago is what mode_r holds now.
    // between edges nothing moves, so it is m_d4 and m_d1
    wire [1:0] mode_d4_n   = ce_gb ? m_d3 : m_d4;
    wire [1:0] mode_d1_n   = ce_gb ? mode_r : m_d1;
    wire [1:0] stat_mode_n = (mode_d4_n == MODE_PIXEL_TRANSFER) ? mode_d1_n : mode_d4_n;

    assign stat_mode_next   = lcd_en ? stat_mode_n : MODE_HBLANK;
    assign ly_cpu_next      = !lcd_en ? 8'd0 :
                               ((ly_n == 8'd153 && dot_n >= 9'd8) ? 8'd0 : ly_n);
    assign cmp_off_next     = lcd_en && (dot_n < 9'd4);

    // the locks start with the engine and end with the stat mode, so they
    // cover the dots where the engine is ahead of the stat mode. on the
    // first line after lcd on both start with the stat mode instead
    wire engine_busy = (mode_n == MODE_PIXEL_TRANSFER);
    wire stat_busy   = (stat_mode_n == MODE_PIXEL_TRANSFER);

    assign oam_blocked_next  = lcd_en && (stat_busy ||
                                           (!first_n && (mode_n == MODE_OAM_SCAN || engine_busy)));
    assign vram_blocked_next = lcd_en && (stat_busy || (!first_n && engine_busy));

    // writes lock later than reads. vram writes lock with the stat mode 3 and
    // oam writes with the stat mode 2, except that oam writes get through for
    // the 4 dots where the engine has started mode 3 and the stat mode still
    // reads 2
    assign vram_wr_blocked_next = lcd_en && stat_busy;
    assign oam_wr_blocked_next  = lcd_en && (stat_busy ||
                                              (stat_mode_n == MODE_OAM_SCAN && mode_n == MODE_OAM_SCAN));

    // the mode 0 condition rises 3 dots after the engine reaches mode 0 and
    // falls with it. on the first line there is no mode 0 condition until
    // mode 3 has run
    wire [1:0] mode_d3_n = ce_gb ? m_d2 : m_d3;
    assign term_m0_next = lcd_en && (mode_n == MODE_HBLANK) &&
                           (mode_d3_n == MODE_HBLANK) &&
                           !(first_n && dot_n < DOT_MODE3);
    assign term_m1_next = lcd_en && (mode_n == MODE_VBLANK);
    // the extra pulse is the mode 2 condition that is seen on the first dots
    // of line 144 on hardware, alongside the vblank interrupt
    assign term_m2_next = lcd_en && ((mode_n == MODE_OAM_SCAN) ||
                                      (ly_n == 8'd144 && dot_n < 9'd4));

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dot_counter  <= DOT_IDLE;
            ly_r         <= 8'd0;
            mode_r       <= MODE_HBLANK;
            first_line_r <= 1'b1;
            m_d1         <= MODE_HBLANK;
            m_d2         <= MODE_HBLANK;
            m_d3         <= MODE_HBLANK;
            m_d4         <= MODE_HBLANK;
        end
        else begin
            dot_counter  <= dot_n;
            ly_r         <= ly_n;
            mode_r       <= mode_n;
            first_line_r <= first_n;
            if (ce_gb) begin
                m_d1 <= mode_r;
                m_d2 <= m_d1;
                m_d3 <= m_d2;
                m_d4 <= m_d3;
            end
        end
    end

endmodule
