// =============================================================================
// Project      : GameBoy Emulator
// File         : oam.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : object attribute memory, 160 bytes, 0xFE00-0xFE9F.
//                  dual-port, same shape as vram.v: cpu-facing bus
//                  interface, blocked in modes 2 and 3 and during oam
//                  dma (section 4), and a separate ppu-internal read
//                  port (render_addr/render_data, oam scan + sprite
//                  fetch) that is never blocked. dma_active is a
//                  placeholder input - tie it low until the oam dma unit
//                  (0xFF46) exists, at which point it wires straight in.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module oam (
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
    input  wire        dma_active,

    input  wire [7:0]  render_addr,
    output wire [7:0]  render_data
);

    assign stall = 1'b0;

    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;
    wire blocked = (mode == MODE_OAM_SCAN) || (mode == MODE_PIXEL_TRANSFER) || dma_active;

    reg [7:0] mem [0:159];
    reg [7:0] cpu_rdata;

    integer i;
    initial begin
        for (i = 0; i < 160; i = i + 1)
            mem[i] = 8'h00;
        cpu_rdata = 8'h00;
    end

    always @(posedge clk) begin
        if (sel && ce_m && !blocked) begin
            if (we)
                mem[addr[7:0]] <= data_in;
            cpu_rdata <= we ? data_in : mem[addr[7:0]];
        end
    end

    assign data_out = !sel ? 8'h00 : (blocked ? 8'hFF : cpu_rdata);

    assign render_data = mem[render_addr];

endmodule