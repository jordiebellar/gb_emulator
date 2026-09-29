// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_mode_fsm.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : ppu mode timing core - dot_counter (0-455) and ly (0-153)
//                  drive mode 2 (oam scan, fixed 80 dots), mode 0 (hblank,
//                  fills the rest of the line), and mode 1 (vblank, 10
//                  extra lines). mode 3 (pixel transfer) exits on
//                  fifo_done from the fetcher, not a dot count, since its
//                  length is variable under the fifo model. drives
//                  oam_stall/vram_stall (now just a "which range is
//                  blocked right now" flag consumed by vram/oam
//                  themselves, since there is no bus_stall anymore -
//                  section 4). irq_vblank is a combinational strobe
//                  (section 5), derived from the exact same condition
//                  that drives the mode transition, not a registered
//                  pulse. irq_lcdstat depends on the stat/lyc register
//                  file, which doesn't exist yet - stubbed low for now.
// Revision     : 2.0 - renamed ce to ce_gb (this is t-cycle logic per
//                  section 6). fixed irq_vblank from a registered pulse
//                  to a combinational strobe - the old version added a
//                  t-cycle of latency, the same class of bug ce_m's
//                  design in clk_div.v was written to avoid.
// =============================================================================
`timescale 1ns / 1ps

module ppu_mode_fsm (
    input  wire       clk,
    input  wire       ce_gb,
    input  wire       rst,
    input  wire       fifo_done,

    output reg  [1:0] mode,
    output reg  [8:0] dot_counter,
    output reg  [7:0] ly,

    output wire       oam_stall,
    output wire       vram_stall,

    output wire       irq_vblank,
    output wire       irq_lcdstat
);

    localparam MODE_HBLANK         = 2'd0;
    localparam MODE_VBLANK         = 2'd1;
    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;

    assign oam_stall   = (mode == MODE_OAM_SCAN) || (mode == MODE_PIXEL_TRANSFER);
    assign vram_stall  = (mode == MODE_PIXEL_TRANSFER);
    assign irq_lcdstat = 1'b0;

    assign irq_vblank = ce_gb && (dot_counter == 9'd455) && (ly == 8'd143);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dot_counter <= 9'd0;
            ly          <= 8'd0;
            mode        <= MODE_OAM_SCAN;
        end
        else if (ce_gb) begin
            if (dot_counter == 9'd455) begin
                dot_counter <= 9'd0;
                if (ly == 8'd153) begin
                    ly   <= 8'd0;
                    mode <= MODE_OAM_SCAN;
                end
                else begin
                    ly <= ly + 8'd1;
                    if (ly == 8'd143) begin
                        mode <= MODE_VBLANK;
                    end
                    else if (ly < 8'd143) begin
                        mode <= MODE_OAM_SCAN;
                    end
                end
            end
            else begin
                dot_counter <= dot_counter + 9'd1;

                if (mode == MODE_OAM_SCAN && dot_counter == 9'd79)
                    mode <= MODE_PIXEL_TRANSFER;
                else if (mode == MODE_PIXEL_TRANSFER && fifo_done)
                    mode <= MODE_HBLANK;
            end
        end
    end

endmodule