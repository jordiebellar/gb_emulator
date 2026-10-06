// =============================================================================
// Project      : GameBoy Emulator
// File         : oam.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : object attribute memory, 160 bytes, 0xFE00-0xFE9F.
//                  dual-port, same shape as vram.v: cpu-facing bus
//                  interface, blocked in modes 2 and 3 and during oam
//                  dma (section 4), and a separate ppu-internal read
//                  port (render_addr/render_data, oam scan + sprite
//                  fetch) that is never blocked. writes commit once, on
//                  sel && we && ce_m and not blocked. the cpu read register
//                  is clocked every clock so it has settled by the ce_m edge
//                  where the cpu samples.
//
//                  the blocked decision uses mode_next, the mode after the
//                  edge the access commits on, see vram.v. dma_active
//                  follows the same rule. it must be the value after the
//                  edge, so the oam dma unit has to provide a next-state
//                  version when it exists. tie it low until then.
// Revision     : 2.0 - blocked decision now from mode_next instead of the
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
    input  wire        dma_active, // after this edge. tie low until the oam dma unit exists

    // ppu-internal read port, always live, never blocked
    input  wire [7:0]  render_addr, // 0-159 valid
    output wire [7:0]  render_data
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

    always @(posedge clk) begin
        if (sel && we && ce_m && !blocked)
            mem[addr[7:0]] <= data_in;
    end

    always @(posedge clk) begin
        rdata <= mem[addr[7:0]];
    end

    assign data_out = !sel ? 8'h00 : (blocked ? 8'hFF : rdata);

    assign render_data = mem[render_addr];

endmodule