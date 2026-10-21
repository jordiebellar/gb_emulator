// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_reg.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : ppu register file - lcdc, stat, scy, scx, ly, lyc, bgp,
//                  obp0, obp1, wy, wx (0xFF40-45, 0xFF47-4B, 0xFF46 is a
//                  separate oam dma unit). ly is a live view of
//                  ppu_mode_fsm, not a second copy, and writes to it are
//                  ignored, same as real hardware. stat bits 0-1 are the
//                  stat mode view, bit 2 is the ly == lyc coincidence flag,
//                  bits 3-6 are stored interrupt-select enables, bit 7
//                  always reads 1 (unused bit rule, section 2).
//
//                  reads of ly and stat come from the next-state views of
//                  ppu_mode_fsm. the cpu samples read data on the ce_m edge,
//                  and the contract (section 3) says a read returns the value
//                  after that edge's update, so the data has to be computed
//                  from where the views are going, not where they are. every
//                  read is fully combinational.
//
//                  the coincidence flag is a register, not a live compare.
//                  it follows ly == lyc, except that it reads 0 for the
//                  first 4 engine dots of every line while ly is changing
//                  over, it is frozen while the lcd is off, and it is
//                  recomputed the moment the lcd turns on. a write to lyc
//                  recomputes it on that same edge while the lcd is on, and
//                  is ignored by the flag while the lcd is off.
//
//                  irq_lcdstat is a combinational strobe (section 5), high on
//                  the clock whose ending edge is the event. hardware has one
//                  stat interrupt line, the or of four conditions that are
//                  each gated by their own enable bit - mode 0, mode 1, mode
//                  2 and the coincidence flag. the interrupt is a rising
//                  edge of that or, so while one condition holds, a second
//                  one starting does nothing. the line is evaluated after the
//                  edge, with the enable bits as they will be after a stat
//                  write on this same edge, so writing stat to enable a
//                  condition that already holds raises the interrupt right
//                  away. the three mode conditions come from ppu_mode_fsm as
//                  levels. the three mode conditions are low while the lcd is
//                  off, but the coincidence condition follows the frozen
//                  flag, so a flag that is set when the lcd turns off keeps
//                  the line high and turning the lcd back on does not raise
//                  a second interrupt.
//
//                  lcdc, scx, scy, wy, wx, and the three palettes bgp, obp0,
//                  and obp1 are exported for the rest of the ppu. lcdc bit 7
//                  is the lcd enable ppu_mode_fsm needs, scx and scy feed the
//                  tile fetcher, wy and wx place the window, and the palettes
//                  are applied to each pixel on its way out.
// Revision     : 3.1 - ly_cmp_next added for the comparison, and a lyc write on
//                    the edge a match arrives no longer takes the interrupt back
//                  3.0 - the stat interrupt is now an edge on the or of the
//                  four enabled conditions instead of four separate strobes,
//                  so stat blocking works. the coincidence flag is a register
//                  with the rules above. stat mode and ly come from the cpu
//                  views, mode_next, ly_in, ly_next and the entering_*
//                  inputs are gone.
//                  2.2 - exported obp0, obp1, wy, and wx as obp0_out,
//                  obp1_out, wy_out, and wx_out.
//                  2.1 - exported bgp as bgp_out.
//                  2.0 - reads of ly and stat now use mode_next and ly_next.
//                  1.2 - exported scx and scy as scx_out and scy_out.
//                  1.1 - exported lcdc as lcdc_out and gated the coincidence
//                  interrupt by lcdc bit 7.
// =============================================================================
`timescale 1ns / 1ps

module ppu_reg (
    input  wire        clk,
    input  wire        ce_gb,
    input  wire        ce_m,
    input  wire        rst,
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output wire [7:0]  data_out,
    output wire        stall,

    // what the cpu sees after this edge, from ppu_mode_fsm
    input  wire [1:0]  stat_mode_next,
    input  wire [7:0]  ly_cpu_next,
    input  wire [7:0]  ly_cmp_next,
    input  wire        cmp_off_next,
    input  wire        term_m0_next,
    input  wire        term_m1_next,
    input  wire        term_m2_next,

    output wire [7:0]  lcdc_out,
    output wire [7:0]  scx_out,
    output wire [7:0]  scy_out,
    output wire [7:0]  bgp_out,
    output wire [7:0]  obp0_out,
    output wire [7:0]  obp1_out,
    output wire [7:0]  wy_out,
    output wire [7:0]  wx_out,
    output wire        irq_lcdstat
);

    assign stall = 1'b0;

    reg [7:0] lcdc;
    reg [7:0] scy;
    reg [7:0] scx;
    reg [7:0] lyc;
    reg [7:0] bgp;
    reg [7:0] obp0;
    reg [7:0] obp1;
    reg [7:0] wy;
    reg [7:0] wx;

    reg mode0_ie;
    reg mode1_ie;
    reg mode2_ie;
    reg lyc_ie;

    assign lcdc_out = lcdc;
    assign scx_out  = scx;
    assign scy_out  = scy;
    assign bgp_out  = bgp;
    assign obp0_out = obp0;
    assign obp1_out = obp1;
    assign wy_out   = wy;
    assign wx_out   = wx;
    wire lcd_en = lcdc[7];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lcdc     <= 8'h00; // lcd off at power-on, the boot rom turns it on
            scy      <= 8'h00;
            scx      <= 8'h00;
            lyc      <= 8'h00;
            bgp      <= 8'h00;
            obp0     <= 8'h00;
            obp1     <= 8'h00;
            wy       <= 8'h00;
            wx       <= 8'h00;
            mode0_ie <= 1'b0;
            mode1_ie <= 1'b0;
            mode2_ie <= 1'b0;
            lyc_ie   <= 1'b0;
        end
        else if (sel && we && ce_m) begin
            case (addr[3:0])
                4'h0: lcdc <= data_in;
                4'h1: begin
                    mode0_ie <= data_in[3];
                    mode1_ie <= data_in[4];
                    mode2_ie <= data_in[5];
                    lyc_ie   <= data_in[6];
                end
                4'h2: scy  <= data_in;
                4'h3: scx  <= data_in;
                4'h5: lyc  <= data_in;
                4'h7: bgp  <= data_in;
                4'h8: obp0 <= data_in;
                4'h9: obp1 <= data_in;
                4'hA: wy   <= data_in;
                4'hB: wx   <= data_in;
                default: ;   // ly (4) and anything else, ignored
            endcase
        end
    end

    // lyc after this edge, including a write to it on this same edge
    wire       lyc_wr   = sel && we && ce_m && (addr[3:0] == 4'h5);
    wire [7:0] lyc_next = lyc_wr ? data_in : lyc;

    // the coincidence flag. frozen while the lcd is off, so it is not
    // updated by anything, lyc writes included
    reg  coincidence_r;
    wire coincidence_next = !lcd_en ? coincidence_r :
                             (cmp_off_next ? 1'b0 : (ly_cmp_next == lyc_next));

    always @(posedge clk or posedge rst) begin
        if (rst) coincidence_r <= 1'b1;   // ly 0 == lyc 0 at power-on
        else     coincidence_r <= coincidence_next;
    end

    wire [7:0] stat_value = {1'b1, lyc_ie, mode2_ie, mode1_ie, mode0_ie, coincidence_next, stat_mode_next};

    reg [7:0] reg_rdata;
    always @(*) begin
        case (addr[3:0])
            4'h0:    reg_rdata = lcdc;
            4'h1:    reg_rdata = stat_value;
            4'h2:    reg_rdata = scy;
            4'h3:    reg_rdata = scx;
            4'h4:    reg_rdata = ly_cpu_next;
            4'h5:    reg_rdata = lyc;
            4'h7:    reg_rdata = bgp;
            4'h8:    reg_rdata = obp0;
            4'h9:    reg_rdata = obp1;
            4'hA:    reg_rdata = wy;
            4'hB:    reg_rdata = wx;
            default: reg_rdata = 8'hFF;
        endcase
    end

    assign data_out = sel ? reg_rdata : 8'h00;

    // the stat interrupt line after this edge, with the enables as they will
    // be after a stat write on this edge
    wire stat_wr    = sel && we && ce_m && (addr[3:0] == 4'h1);
    wire m0_ie_n    = stat_wr ? data_in[3] : mode0_ie;
    wire m1_ie_n    = stat_wr ? data_in[4] : mode1_ie;
    wire m2_ie_n    = stat_wr ? data_in[5] : mode2_ie;
    wire lyc_ie_n   = stat_wr ? data_in[6] : lyc_ie;

    wire stat_line_n = (m0_ie_n  && term_m0_next) ||
                       (m1_ie_n  && term_m1_next) ||
                       (m2_ie_n  && term_m2_next) ||
                       (lyc_ie_n && coincidence_next);

    reg stat_line_r;
    always @(posedge clk or posedge rst) begin
        if (rst)        stat_line_r <= 1'b0;
        else if (ce_gb) stat_line_r <= stat_line_n;
    end

    // a lyc write on the same edge as the comparison turning on does not
    // take the interrupt back. the comparison turns on with the old lyc
    // first, which raises the line for an instant, then the write lands
    wire coincidence_old = !lcd_en ? coincidence_r :
                            (cmp_off_next ? 1'b0 : (ly_cmp_next == lyc));
    wire stat_line_old   = (m0_ie_n  && term_m0_next) ||
                           (m1_ie_n  && term_m1_next) ||
                           (m2_ie_n  && term_m2_next) ||
                           (lyc_ie_n && coincidence_old);

    assign irq_lcdstat = ce_gb && (stat_line_n || stat_line_old) && !stat_line_r;

endmodule
