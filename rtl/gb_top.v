// =============================================================================
// Project      : GameBoy Emulator
// File         : gb_top.v
// Author       : Jordie Bellar
// Date         : 2026-08-03
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
wire [7:0]  bus_ie;
wire [7:0]  bus_if;
wire [7:0]  bus_if_clear;
wire        bus_if_clear_we;
wire        bus_we;

memory_map memory_map_inst (
    .clk(clk),
    .rst(rst),
    .addr(bus_addr),
    .data_in(bus_data_wr),
    .we(bus_we),
    .if_clear(bus_if_clear),
    .if_clear_we(bus_if_clear_we),
    .data_out(bus_data_rd),
    .ie(bus_ie),
    .if_reg(bus_if)
);

cpu cpu_inst (
    .clk(clk),
    .rst(rst),
    .data_in(bus_data_rd),
    .ie(bus_ie),
    .if_reg(bus_if),
    .we(bus_we),
    .addr(bus_addr),
    .data_out(bus_data_wr),
    .if_clear(bus_if_clear),
    .if_clear_we(bus_if_clear_we)
);

endmodule