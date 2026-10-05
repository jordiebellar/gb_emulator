// =============================================================================
// Project      : GameBoy Emulator
// File         : hram.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : high ram storage, 127 bytes, 0xFF80-0xFFFE. read and
//                  write both commit on sel && ce_m (interface contract
//                  rev 2, section 3). data_out is driven to 0 whenever
//                  sel is low (section 3 rule).
// Revision     : 2.0 - ce split into ce_gb/ce_m (ce_gb unused); write/read
//                  commit moved from ce to sel && ce_m; added the
//                  data_out=0-when-deselected gate.
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
        if (sel && ce_m) begin
            if (we)
                mem[addr[6:0]] <= data_in;
            rdata <= we ? data_in : mem[addr[6:0]];
        end
    end

    assign data_out = sel ? rdata : 8'h00;

endmodule