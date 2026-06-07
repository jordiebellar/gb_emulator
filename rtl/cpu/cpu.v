// =============================================================================
// Project      : GameBoy Emulator
// File         : cpu.v
// Author       : Jordie Bellar
// Date         : 2026-06-06
// Description  : Implements the SM83 CPU core. Responsible for fetch,
//                decode, and execute of all instructions. Manages
//                internal registers, flags, and memory bus interface.
// Revision     : 1.0 - Initial implementation
// =============================================================================

module cpu (
    input wire clk,
    input wire rst,
    input wire [7:0] data_in,
    output reg we,
    output reg [15:0] addr,
    output reg [7:0] data_out
);
    // CPU implementation goes here

    // Local Parameters
    localparam F_Z = 7; // Zero Flag
    localparam F_N = 6; // Subtract Flag
    localparam F_H = 5; // Half Carry Flag
    localparam F_C = 4; // Carry Flag
    
    // Registers
    reg [15:0] pc;  // Program Counter
    reg [15:0] sp;  // Stack Pointer
    reg [7:0]  a;    // Accumulator
    reg [7:0]  f;    // Flags Register
    reg [7:0]  b, c; // BC Register Pair
    reg [7:0]  d, e; // DE Register Pair
    reg [7:0]  h, l; // HL Register Pair

endmodule