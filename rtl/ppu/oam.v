// =============================================================================
// Project      : GameBoy Emulator
// File         : oam.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : object attribute memory, 160 bytes, 0xFE00-0xFE9F.
//                  three ports, same shape as vram.v for the first two:
//                  - the cpu-facing bus interface, blocked in modes 2 and 3
//                    and during oam dma (section 4). writes commit once, on
//                    sel && we && ce_m and not blocked. the cpu read register
//                    is clocked every clock so it has settled by the ce_m
//                    edge where the cpu samples.
//                  - a ppu-internal entry port, for the oam scan. entry_idx
//                    picks one of the 40 objects and entry_data is all four
//                    of its bytes at once, never blocked, packed
//                    {attributes, tile, x, y} so y is bits 7:0 and the
//                    attributes are bits 31:24.
//                  - the dma write port. a write with dma_we high lands on
//                    the clock edge in any ppu mode, the dma unit is the one
//                    thing that can write oam while the ppu is using it.
//                    the dma unit gates dma_we with ce_m itself.
//
//                  the blocked decision uses mode_next, the mode after the
//                  edge the access commits on, see vram.v. dma_active is
//                  different, it is the dma unit's state during the m-cycle
//                  that the committing edge ends, which is how the unit
//                  exports it, so it is used as it comes.
// Revision     : 3.0 - the 8 bit render port is replaced by the 32 bit
//                  entry port, and the dma write port is added. dma_active
//                  is now a real signal from the oam dma unit.
//                  2.0 - blocked decision now from mode_next instead of the
//                  current mode. the port is renamed from mode to mode_next.
//                  1.1 - cpu read register now clocked every clock
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module oam (
    input  wire        clk,
    input  wire        ce_gb,   // unused
    input  wire        ce_m,
    input  wire        rst,     // unused for storage, kept for interface consistency
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output wire [7:0]  data_out,
    output wire        stall,

    input  wire [1:0]  mode_next, // mode after this edge, from ppu_mode_fsm
    input  wire        dma_active, // from the oam dma unit, high for the whole transfer

    // ppu-internal entry port for the oam scan, always live, never blocked
    input  wire [5:0]  entry_idx,   // 0-39 valid
    output wire [31:0] entry_data,  // {attributes, tile, x, y}

    // oam dma write port, lands in any mode
    input  wire        dma_we,
    input  wire [7:0]  dma_waddr,   // 0-159 valid
    input  wire [7:0]  dma_wdata
);

    assign stall = 1'b0;

    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;
    wire blocked = (mode_next == MODE_OAM_SCAN) || (mode_next == MODE_PIXEL_TRANSFER) || dma_active;

    reg [7:0] mem [0:159];
    reg [7:0] rdata;

    integer i;
    initial begin
        for (i = 0; i < 160; i = i + 1)
            mem[i] = 8'h00;
        rdata = 8'h00;
    end

    // the dma write wins if it ever lands on the same edge as a cpu write,
    // though the cpu is blocked from oam for the whole transfer anyway
    always @(posedge clk) begin
        if (dma_we && (dma_waddr < 8'd160))
            mem[dma_waddr] <= dma_wdata;
        else if (sel && we && ce_m && !blocked)
            mem[addr[7:0]] <= data_in;
    end

    always @(posedge clk) begin
        rdata <= mem[addr[7:0]];
    end

    assign data_out = !sel ? 8'h00 : (blocked ? 8'hFF : rdata);

    // object n starts at byte 4n. an index above 39 reads as all ones
    wire [7:0] entry_base = {entry_idx, 2'b00};
    wire       entry_ok   = (entry_idx < 6'd40);
    assign entry_data = entry_ok ? {mem[entry_base + 8'd3], mem[entry_base + 8'd2],
                                    mem[entry_base + 8'd1], mem[entry_base]}
                                 : 32'hFFFF_FFFF;

endmodule