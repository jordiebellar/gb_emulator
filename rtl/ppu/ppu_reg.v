// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_reg.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : ppu register file - lcdc, stat, scy, scx, ly, lyc, bgp,
//                  obp0, obp1, wy, wx (0xFF40-45, 0xFF47-4B, 0xFF46 is a
//                  separate oam dma unit). ly is a live passthrough of
//                  ppu_mode_fsm's ly, not a second copy, and writes to it
//                  are ignored, same as real hardware. stat bits 0-1
//                  mirror mode, bit 2 is the ly==lyc coincidence flag,
//                  bits 3-6 are stored interrupt-select enables, bit 7
//                  always reads 1 (unused bit rule, section 2).
//
//                  reads of ly and stat come from the next-state values,
//                  ly_next and mode_next. the cpu samples read data on the
//                  ce_m edge, and the contract (section 3) says a read
//                  returns the value after that edge's update, so the data
//                  has to be computed from where ly and mode are going, not
//                  where they are. every read is fully combinational.
//
//                  irq_lcdstat is a combinational strobe (section 5), high
//                  on the clock whose ending edge is the event. mode
//                  transition events come straight from ppu_mode_fsm's
//                  entering_* exports. the lyc coincidence event is the
//                  match going from false to true across this edge, the
//                  current ly against lyc becoming the next ly against the
//                  next lyc, where the next lyc includes a write to lyc on
//                  this same edge. so it strobes on the edge ly changes to
//                  match, or on the edge a write to lyc creates the match.
//                  it is gated by lcdc bit 7, since ly snaps to 0 when the
//                  lcd is turned off and that must not raise an interrupt.
//
//                  lcdc, scx, scy, and bgp are exported for the rest of the
//                  ppu. lcdc bit 7 is the lcd enable ppu_mode_fsm needs, scx
//                  and scy feed the tile fetcher, and bgp is applied to each
//                  pixel on its way out.
// Revision     : 2.1 - exported bgp as bgp_out.
//                  2.0 - reads of ly and stat now use mode_next and ly_next.
//                  the coincidence strobe is now same-edge, it used to land
//                  one tick late through a coincidence_prev register, which
//                  is gone. the mode input is replaced by mode_next, and
//                  ly_next is new.
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

    input  wire [1:0]  mode_next,        // mode after this edge
    input  wire [7:0]  ly_in,            // ly now
    input  wire [7:0]  ly_next,          // ly after this edge
    input  wire        entering_hblank,
    input  wire        entering_oam_scan,
    input  wire        entering_vblank,

    output wire [7:0]  lcdc_out,
    output wire [7:0]  scx_out,
    output wire [7:0]  scy_out,
    output wire [7:0]  bgp_out,
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

    wire coincidence_cur  = (ly_in   == lyc);
    wire coincidence_next = (ly_next == lyc_next);

    wire [7:0] stat_value = {1'b1, lyc_ie, mode2_ie, mode1_ie, mode0_ie, coincidence_next, mode_next};

    reg [7:0] reg_rdata;
    always @(*) begin
        case (addr[3:0])
            4'h0:    reg_rdata = lcdc;
            4'h1:    reg_rdata = stat_value;
            4'h2:    reg_rdata = scy;
            4'h3:    reg_rdata = scx;
            4'h4:    reg_rdata = ly_next;
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

    // the match going from false to true across this edge
    wire coincidence_rising = coincidence_next && !coincidence_cur;

    // the three mode terms arrive already gated by lcd_en from
    // ppu_mode_fsm. the coincidence term is derived here, so it carries its
    // own lcd_en and ce_gb factors
    assign irq_lcdstat = (entering_hblank   && mode0_ie) ||
                          (entering_vblank   && mode1_ie) ||
                          (entering_oam_scan && mode2_ie) ||
                          (ce_gb && lcd_en && coincidence_rising && lyc_ie);

endmodule