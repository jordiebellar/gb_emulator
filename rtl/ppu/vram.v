// =============================================================================
// Project      : GameBoy Emulator
// File         : vram.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : video ram, 8kb, 0x8000-0x9FFF. dual-port: the cpu-facing
//                  bus interface (sel/we/data_out, blocked in mode 3 per
//                  section 4 - reads $FF, writes dropped) and a separate
//                  ppu-internal read port (render_addr/render_data) that
//                  is never blocked, since the renderer is exactly what's
//                  using vram during the modes that block the cpu. the
//                  blocked decision uses mode directly - already a live,
//                  post-edge value from ppu_mode_fsm, same pattern
//                  ppu_reg.v uses for stat/ly.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module vram (
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

    input  wire [12:0] render_addr,
    output wire [7:0]  render_data
);

    assign stall = 1'b0;

    localparam MODE_PIXEL_TRANSFER = 2'd3;
    wire blocked = (mode == MODE_PIXEL_TRANSFER);

    reg [7:0] mem [0:8191];
    reg [7:0] cpu_rdata;

    integer i;
    initial begin
        for (i = 0; i < 8192; i = i + 1)
            mem[i] = 8'h00;
        cpu_rdata = 8'h00;
    end

    always @(posedge clk) begin
        if (sel && ce_m && !blocked) begin
            if (we)
                mem[addr[12:0]] <= data_in;
            cpu_rdata <= we ? data_in : mem[addr[12:0]];
        end
    end

    assign data_out = !sel ? 8'h00 : (blocked ? 8'hFF : cpu_rdata);

    assign render_data = mem[render_addr];

endmodule