// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_mode_fsm.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : ppu mode timing core - dot_counter (0-455) and ly (0-153)
//                  drive mode 2 (oam scan, fixed 80 dots), mode 0 (hblank,
//                  fills the rest of the line), and mode 1 (vblank, 10
//                  extra lines). mode 3 (pixel transfer) exits on
//                  fifo_done from the fetcher. exports entering_hblank/
//                  entering_oam_scan/entering_vblank as combinational,
//                  same-edge strobes of each transition's own guard
//                  condition - ppu_reg.v's STAT mode-interrupts consume
//                  these directly instead of re-deriving "mode changed"
//                  from the already-exported mode value, which would lag
//                  by one ce_gb tick (the same latency bug irq_vblank and
//                  irq_joypad were fixed to avoid, just one hop further
//                  away). irq_vblank is literally entering_vblank.
//                  irq_lcdstat now lives in ppu_reg.v, which has the
//                  stat enable bits.
// Revision     : 2.1 - exported entering_hblank/entering_oam_scan/
//                  entering_vblank for ppu_reg.v's stat interrupt logic.
//                  removed irq_lcdstat (moved to ppu_reg.v, the module
//                  that actually owns stat's enable bits).
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

    output wire       entering_hblank,
    output wire       entering_oam_scan,
    output wire       entering_vblank,
    output wire       irq_vblank
);

    localparam MODE_HBLANK         = 2'd0;
    localparam MODE_VBLANK         = 2'd1;
    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;

    assign oam_stall   = (mode == MODE_OAM_SCAN) || (mode == MODE_PIXEL_TRANSFER);
    assign vram_stall  = (mode == MODE_PIXEL_TRANSFER);

    assign entering_hblank    = ce_gb && (dot_counter != 9'd455) &&
                                 (mode == MODE_PIXEL_TRANSFER) && fifo_done;
    assign entering_oam_scan  = ce_gb && (dot_counter == 9'd455) &&
                                 ((ly == 8'd153) || (ly < 8'd143));
    assign entering_vblank    = ce_gb && (dot_counter == 9'd455) && (ly == 8'd143);
    assign irq_vblank         = entering_vblank;

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