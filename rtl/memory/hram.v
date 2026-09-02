// =============================================================================
// Project      : GameBoy Emulator
// File         : hram.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : high ram storage, 127 bytes, 0xFF80-0xFFFE
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module hram (
    input  wire        clk,      // 100MHz clk signal
    input  wire        ce,       // clk enable
    input  wire        rst,      // unused for storage, kept for slave interface consistency
    input  wire [15:0] addr,     // full bus address, only bits [6:0] matter here
    input  wire [7:0]  data_in,  // write data from bus
    input  wire        we,       // write enable
    input  wire        sel,      // asserted by memory_map when addr falls in 0xFF80-0xFFFE
    output reg  [7:0]  data_out, // read data, valid one cycle after sel+addr settle
    output wire        stall     // hram never blocks the cpu
);

    // never any reason to stall, tie low permanently per section 3
    assign stall = 1'b0;

    // 127 bytes, addr[6:0] gives 0-126, since 0xFF80 is 128-aligned this
    // needs no offset subtraction, unlike a non-aligned base would
    reg [7:0] mem [0:126];

    // power-on contents, not a reset, same reasoning as wram.v
    integer i;
    initial begin
        for (i = 0; i < 127; i = i + 1)
            mem[i] = 8'h00;
        data_out = 8'h00;
    end

    // single clocked block, write-first, no reset in the sensitivity
    // list, same rationale as wram.v - this block stays tiny on purpose,
    // vivado will likely map this to lutram rather than a bram primitive
    // given the size, that's fine and expected for something this small
    always @(posedge clk) begin
        if (ce && sel) begin
            if (we)
                mem[addr[6:0]] <= data_in;
            data_out <= we ? data_in : mem[addr[6:0]];
        end
    end

endmodule
