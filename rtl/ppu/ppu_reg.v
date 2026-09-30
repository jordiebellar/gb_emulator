// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_reg.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : ppu register file - lcdc, stat, scy, scx, ly, lyc, bgp,
//                  obp0, obp1, wy, wx (0xFF40-45, 0xFF47-4B; 0xFF46 is a
//                  separate oam dma unit). ly is a live passthrough of
//                  ppu_mode_fsm's ly, not a second copy - writes to it
//                  are ignored, same as real hardware. stat bits 0-1
//                  mirror mode directly, bit 2 is the ly==lyc coincidence
//                  flag, bits 3-6 are stored interrupt-select enables,
//                  bit 7 always reads 1 (unused bit rule, section 2).
//                  every read is fully combinational (no register stage),
//                  since ly/stat depend on ppu_mode_fsm's live, already
//                  post-edge state - adding a registered read here would
//                  add a second cycle of lag on top of that.
//                  irq_lcdstat is a combinational strobe (section 5):
//                  same-edge mode-transition events come straight from
//                  ppu_mode_fsm's entering_* exports (avoiding the one-
//                  cycle lag a mode_prev-vs-mode comparison would have
//                  here), and the lyc coincidence event is edge-detected
//                  locally, which is safe since this module owns both ly
//                  and lyc directly.
// Revision     : 1.0 - initial implementation
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

    input  wire [1:0]  mode,
    input  wire [7:0]  ly_in,
    input  wire        entering_hblank,
    input  wire        entering_oam_scan,
    input  wire        entering_vblank,

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

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lcdc     <= 8'h00;
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
                default: ;
            endcase
        end
    end

    wire coincidence = (ly_in == lyc);
    wire [7:0] stat_value = {1'b1, lyc_ie, mode2_ie, mode1_ie, mode0_ie, coincidence, mode};

    reg [7:0] reg_rdata;
    always @(*) begin
        case (addr[3:0])
            4'h0:    reg_rdata = lcdc;
            4'h1:    reg_rdata = stat_value;
            4'h2:    reg_rdata = scy;
            4'h3:    reg_rdata = scx;
            4'h4:    reg_rdata = ly_in;
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

    reg coincidence_prev;
    always @(posedge clk or posedge rst) begin
        if (rst)
            coincidence_prev <= 1'b0;
        else if (ce_gb)
            coincidence_prev <= coincidence;
    end

    wire coincidence_rising = coincidence && !coincidence_prev;

    assign irq_lcdstat = (entering_hblank   && mode0_ie) ||
                          (entering_vblank   && mode1_ie) ||
                          (entering_oam_scan && mode2_ie) ||
                          (ce_gb && coincidence_rising && lyc_ie);

endmodule