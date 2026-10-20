// =============================================================================
// Project      : GameBoy Emulator
// File         : vram.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : video ram, 8kb, 0x8000-0x9FFF. dual-port: the cpu-facing
//                  bus interface (sel/we/data_out, blocked in mode 3 per
//                  section 4 - reads $FF, writes dropped) and a separate
//                  ppu-internal read port (render_addr/render_data) that
//                  is never blocked, since the renderer is exactly what is
//                  using vram during the modes that block the cpu.
//                  writes commit once, on sel && we && ce_m and not
//                  blocked. the cpu read register is clocked every clock so
//                  it has settled by the ce_m edge where the cpu samples.
//
//                  the blocked decision uses mode_next, the mode after the
//                  edge the access commits on (sections 3 and 4). an access
//                  landing exactly on the edge that enters mode 3 is
//                  blocked, one landing on the edge that leaves it is not.
//                  the read data mask uses the same value, so it is right at
//                  the moment the cpu samples, on that edge, before the
//                  registers update.
// Revision     : 2.0 - blocked decision now from mode_next instead of the
//                  current mode. the port is renamed from mode to mode_next.
//                  1.1 - cpu read register now clocked every clock
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module vram (
    input  wire        clk,
    input  wire        ce_gb,   // unused, storage has no autonomous t-cycle behavior
    input  wire        ce_m,
    input  wire        rst,     // unused for storage, kept for interface consistency
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output wire [7:0]  data_out,
    output wire        stall,

    input  wire [1:0]  mode_next, // mode after this edge, from ppu_mode_fsm

    // ppu-internal read port, always live, never blocked
    input  wire [12:0] render_addr,
    output wire [7:0]  render_data
);

    assign stall = 1'b0;

    localparam MODE_PIXEL_TRANSFER = 2'd3;
    wire blocked = (mode_next == MODE_PIXEL_TRANSFER);

    reg [7:0] mem [0:8191];
    reg [7:0] rdata;

    integer i;
    initial begin
        for (i = 0; i < 8192; i = i + 1)
            mem[i] = 8'h00;
        rdata = 8'h00;
    end

    // a write attempted while blocked is genuinely dropped, not queued
    always @(posedge clk) begin
        if (sel && we && ce_m && !blocked)
            mem[addr[12:0]] <= data_in;
    end

    always @(posedge clk) begin
        rdata <= mem[addr[12:0]];
    end

    // section 3: 0 when not selected. section 4: $FF when selected but
    // blocked, regardless of what rdata holds
    assign data_out = !sel ? 8'h00 : (blocked ? 8'hFF : rdata);

    // ppu-internal port, plain combinational read, no blocking
    assign render_data = mem[render_addr];

endmodule