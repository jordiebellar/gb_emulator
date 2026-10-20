// =============================================================================
// Project      : GameBoy Emulator
// File         : wram.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : work ram storage, 8kb, 0xC000-0xDFFF plus its echo mirror
//                  at 0xE000-0xFDFF, folded down via address masking.
//                  writes commit once, on sel && we && ce_m (interface
//                  contract rev 2, section 3). the read register is clocked
//                  every clock, not just on ce_m. the cpu holds the address
//                  for the whole m-cycle and samples read data on the ce_m
//                  edge that ends it, so a read register that only updated
//                  on ce_m would still hold the previous access's data at
//                  the moment of sampling. data_out is driven to 0 whenever
//                  sel is low (section 3 rule).
// Revision     : 2.1 - read register now clocked every clock. before this
//                  it updated only on ce_m and every read returned the
//                  previous access's data when sampled the way the cpu
//                  samples.
//                  2.0 - ce split into ce_gb/ce_m
// =============================================================================
`timescale 1ns / 1ps

module wram (
    input  wire        clk,
    input  wire        ce_gb,    // unused, storage has no autonomous t-cycle behavior
    input  wire        ce_m,
    input  wire        rst,      // unused for storage, kept for interface consistency
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output wire [7:0]  data_out,
    output wire        stall     // wram never blocks the cpu
);

    assign stall = 1'b0;

    reg [7:0] mem [0:8191];
    reg [7:0] rdata;

    integer i;
    initial begin
        for (i = 0; i < 8192; i = i + 1)
            mem[i] = 8'h00;
        rdata = 8'h00;
    end

    // writes, committed once per access
    always @(posedge clk) begin
        if (sel && we && ce_m)
            mem[addr[12:0]] <= data_in;
    end

    // read register, every clock. no reset, real bram has no per-cell reset
    always @(posedge clk) begin
        rdata <= mem[addr[12:0]];
    end

    // section 3: data_out is 0 when sel is low
    assign data_out = sel ? rdata : 8'h00;

endmodule