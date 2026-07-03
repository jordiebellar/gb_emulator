// =============================================================================
// Project      : GameBoy Emulator
// File         : gb_top.v
// Author       : Jordie Bellar
// Date         : 2026-07-03
// Description  : Top-level module for the GameBoy emulator, integrating CPU, memory map, and other components.
// Revision     : 1.0 - Initial implementation
// =============================================================================
`timescale 1ns / 1ps
module gb_top (
    input wire clk,
    input wire rst
);

wire [15:0] bus_addr;
wire [7:0]  bus_data_wr;
wire [7:0]  bus_data_rd;
wire        bus_we;

memory_map memory_map_inst (
    .clk(clk),
    .rst(rst),
    .addr(bus_addr),
    .data_in(bus_data_wr),
    .we(bus_we),
    .data_out(bus_data_rd)
);

cpu cpu_inst (
    .clk(clk),
    .rst(rst),
    .addr(bus_addr),
    .data_in(bus_data_rd),
    .we(bus_we),
    .data_out(bus_data_wr)
);

endmodule