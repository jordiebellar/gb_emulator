// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_mode_fsm.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : ppu mode timing core - dot_counter (0-455) and ly (0-153)
//                  drive mode 2 (oam scan, fixed 80 dots), mode 0 (hblank,
//                  fills the rest of the line), and mode 1 (vblank, 10
//                  extra lines). mode 3 (pixel transfer) exits on
//                  fifo_done from the fetcher. exports entering_hblank/
//                  entering_oam_scan/entering_vblank as combinational,
//                  same-edge strobes of each transition's own guard
//                  condition, for ppu_reg.v's stat interrupts.
//                  irq_vblank is literally entering_vblank.
//
//                  next-state exports: mode_next and ly_next are the values
//                  mode and ly will have once the current edge completes.
//                  the contract (sections 3 and 4) says a cpu access that
//                  commits on an edge sees the peripheral's own update from
//                  that same edge first, so blocking decisions and register
//                  reads must be made from these, not from mode and ly,
//                  which still hold the values from before the edge. the
//                  state is computed once, combinationally, and the
//                  registers just latch it, so the next-state values and
//                  the registered values cannot disagree.
//
//                  lcd_en is lcdc bit 7. while it is low the engine idles
//                  at the start of line 0 (dot 0, ly 0), the exported mode
//                  reads hblank and ly reads 0, so vram and oam are never
//                  blocked and no strobe can fire. the exported mode and
//                  ly are masked by lcd_en combinationally, so turning the
//                  lcd off takes effect on the cpu-visible side
//                  immediately. the internal counters follow on the next
//                  ce_gb tick. turning the lcd back on restarts at line 0
//                  dot 0 in oam scan, not where it left off.
//                  mode_next and ly_next assume lcd_en does not change on
//                  the edge being predicted. an lcdc write is itself the one
//                  bus access of its m-cycle, so no other access can
//                  observe the difference.
//
//                  known approximation: real hardware runs a shorter first
//                  line after lcd on with no mode 2. that is not modeled
//                  here, the first line is a normal 456 dot line.
// Revision     : 3.0 - refactored into a combinational next-state block and
//                  exported mode_next and ly_next. behavior of every other
//                  output is unchanged.
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
    output reg  [8:0] dot_counter, // raw, held at 0 while the lcd is off
    output wire [7:0] ly,

    output wire [1:0] mode_next,   // mode after this edge
    output wire [7:0] ly_next,     // ly after this edge

    output wire       oam_stall,
    output wire       vram_stall,

    output wire       entering_hblank,
    output wire       entering_oam_scan,
    output wire       entering_vblank,
    output wire       irq_vblank
);

    localparam MODE_HBLANK         = 2'd0;
    localparam MODE_VBLANK         = 2'd1;
    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;

    reg [1:0] mode_r;
    reg [7:0] ly_r;

    assign mode = lcd_en ? mode_r : MODE_HBLANK;
    assign ly   = lcd_en ? ly_r   : 8'd0;

    // blocked flags follow the masked mode, so an lcd that is off blocks
    // nothing
    assign oam_stall  = (mode == MODE_OAM_SCAN) || (mode == MODE_PIXEL_TRANSFER);
    assign vram_stall = (mode == MODE_PIXEL_TRANSFER);

    assign entering_hblank   = ce_gb && lcd_en && (dot_counter != 9'd455) &&
                                (mode_r == MODE_PIXEL_TRANSFER) && fifo_done;
    assign entering_oam_scan = ce_gb && lcd_en && (dot_counter == 9'd455) &&
                                ((ly_r == 8'd153) || (ly_r < 8'd143));
    assign entering_vblank   = ce_gb && lcd_en && (dot_counter == 9'd455) &&
                                (ly_r == 8'd143);
    assign irq_vblank        = entering_vblank;

    // next state, computed once. the registers below only latch it
    reg [8:0] dot_n;
    reg [7:0] ly_n;
    reg [1:0] mode_n;

    always @(*) begin
        dot_n  = dot_counter;
        ly_n   = ly_r;
        mode_n = mode_r;
        if (ce_gb) begin
            if (!lcd_en) begin
                // idle at the start of line 0, ready to run the moment
                // lcd_en rises
                dot_n  = 9'd0;
                ly_n   = 8'd0;
                mode_n = MODE_OAM_SCAN;
            end
            else if (dot_counter == 9'd455) begin
                dot_n = 9'd0;
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
                if (mode_r == MODE_OAM_SCAN && dot_counter == 9'd79)
                    mode_n = MODE_PIXEL_TRANSFER;
                else if (mode_r == MODE_PIXEL_TRANSFER && fifo_done)
                    mode_n = MODE_HBLANK;
            end
        end
    end

    assign mode_next = lcd_en ? mode_n : MODE_HBLANK;
    assign ly_next   = lcd_en ? ly_n   : 8'd0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dot_counter <= 9'd0;
            ly_r        <= 8'd0;
            mode_r      <= MODE_OAM_SCAN;
        end
        else begin
            dot_counter <= dot_n;
            ly_r        <= ly_n;
            mode_r      <= mode_n;
        end
    end

endmodule