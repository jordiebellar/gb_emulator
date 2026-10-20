// =============================================================================
// Project      : GameBoy Emulator
// File         : hram.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : high ram storage, 127 bytes, 0xFF80-0xFFFE. writes commit
//                  once, on sel && we && ce_m (interface contract rev 2,
//                  section 3). the read register is clocked every clock so
//                  it has settled by the ce_m edge where the cpu samples
//                  read data. data_out is driven to 0 whenever sel is low
//                  (section 3 rule).
// Revision     : 2.1 - read register now clocked every clock, see wram.v
//                  2.0 - ce split into ce_gb/ce_m
// =============================================================================
`timescale 1ns / 1ps

module hram (
    input  wire        clk,
    input  wire        ce_gb,    // unused
    input  wire        ce_m,
    input  wire        rst,      // unused for storage, kept for interface consistency
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output wire [7:0]  data_out,
    output wire        stall     // hram never blocks the cpu
);

    assign stall = 1'b0;

    reg [7:0] mem [0:126];
    reg [7:0] rdata;

    integer i;
    initial begin
        for (i = 0; i < 127; i = i + 1)
            mem[i] = 8'h00;
        rdata = 8'h00;
    end

    always @(posedge clk) begin
        if (sel && we && ce_m)
            mem[addr[6:0]] <= data_in;
    end

    always @(posedge clk) begin
        rdata <= mem[addr[6:0]];
    end

    assign data_out = sel ? rdata : 8'h00;

endmodule