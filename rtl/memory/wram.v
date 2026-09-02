// =============================================================================
// Project      : GameBoy Emulator
// File         : wram.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : work ram storage, 8kb, 0xC000-0xDFFF plus its echo mirror
//                  at 0xE000-0xFDFF, folded down via address masking
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module wram (
    input  wire        clk,      // 100MHz clk signal
    input  wire        ce,       // clk enable
    input  wire        rst,      // unused for storage, kept for slave interface consistency
    input  wire [15:0] addr,     // full bus address, only bits [12:0] matter here
    input  wire [7:0]  data_in,  // write data from bus
    input  wire        we,       // write enable
    input  wire        sel,      // asserted by memory_map when addr falls in wram or echo range
    output reg  [7:0]  data_out, // read data, valid one cycle after sel+addr settle
    output wire        stall     // wram never blocks the cpu
);

    // never any reason to stall, tie low permanently
    assign stall = 1'b0;

    // 8kb storage, addr[12:0] gives 0-8191
    reg [7:0] mem [0:8191];

    // power-on contents, not a reset - vivado treats this as the bram's
    // init value at configuration time, distinct from an active reset
    // network, this also keeps simulation reads clean instead of
    // returning x before the first write
    integer i;
    initial begin
        for (i = 0; i < 8192; i = i + 1)
            mem[i] = 8'h00;
        data_out = 8'h00;
    end

    // single clocked block, write-first, no reset in the sensitivity
    // list - real bram has no per-cell reset wiring, trying to reset
    // all 8192 entries here blocks vivado from inferring block ram
    always @(posedge clk) begin
        if (ce && sel) begin
            if (we)
                mem[addr[12:0]] <= data_in;
            data_out <= we ? data_in : mem[addr[12:0]];
        end
    end

endmodule
