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

    // Local Parameters

    // Flag Bit Positions
    localparam F_Z = 7; // Zero Flag
    localparam F_N = 6; // Subtract Flag
    localparam F_H = 5; // Half Carry Flag
    localparam F_C = 4; // Carry Flag

    // CPU States
    localparam STATE_FETCH = 2'd0;
    localparam STATE_DECODE = 2'd1;
    localparam STATE_EXECUTE = 2'd2;

    // Registers
    reg [15:0] pc;  // Program Counter
    reg [15:0] sp;  // Stack Pointer
    reg [7:0]  a;    // Accumulator
    reg [7:0]  f;    // Flags Register
    reg [7:0]  b, c; // BC Register Pair
    reg [7:0]  d, e; // DE Register Pair
    reg [7:0]  h, l; // HL Register Pair

    // State Machine
    reg [1:0] state;

    // Loop
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers and state
            pc <= 16'h0000;
            sp <= 16'hFFFE;
            a <= 8'h00;
            f <= 8'h00;
            b <= 8'h00;
            c <= 8'h00;
            d <= 8'h00;
            e <= 8'h00;
            h <= 8'h00;
            l <= 8'h00;
            state <= STATE_FETCH;
            we <= 1'b0;
            addr <= 16'h0000;
            data_out <= 8'h00;
        end
        else begin

            // State Machine for Fetch, Decode, Execute
            case (state)
                // Fetch the next instruction
                STATE_FETCH: begin
                end
                
                // Decode the fetched instruction
                STATE_DECODE: begin
                end
                
                // Execute the instruction
                STATE_EXECUTE: begin
                end

                default: begin
                    state <= STATE_FETCH;
                end

            endcase
        end
    end

endmodule