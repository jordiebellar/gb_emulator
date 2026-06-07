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
    localparam STATE_FETCH   = 2'd0;
    localparam STATE_DECODE  = 2'd1;
    localparam STATE_EXECUTE = 2'd2;

    // Register Identifiers
    localparam REG_B  = 3'd0;
    localparam REG_C  = 3'd1;
    localparam REG_D  = 3'd2;
    localparam REG_E  = 3'd3;
    localparam REG_H  = 3'd4;
    localparam REG_L  = 3'd5;
    localparam REG_HL = 3'd6; // Memory address pointed by HL
    localparam REG_A  = 3'd7;

    // ALU Operation Codes
    localparam ALU_LD = 5'b00001; // Load

    // Registers
    reg [15:0] pc;   // Program Counter
    reg [15:0] sp;   // Stack Pointer
    reg [7:0]  a;    // Accumulator
    reg [7:0]  f;    // Flags Register
    reg [7:0]  b, c; // BC Register Pair
    reg [7:0]  d, e; // DE Register Pair
    reg [7:0]  h, l; // HL Register Pair
    reg [7:0]  ir;   // Instruction Register

    // State Machine
    reg [1:0] state;

    // Flags
    reg fetch_ready;

    // Instruction Decoding
    reg [2:0] src;
    reg [2:0] dst;
    reg [4:0] alu_op;

    // Helper function to get register value based on identifier
    function [7:0] get_reg;
        input [2:0] reg_id;
            case (reg_id)
                REG_B:  get_reg = b;
                REG_C:  get_reg = c;
                REG_D:  get_reg = d;
                REG_E:  get_reg = e;
                REG_H:  get_reg = h;
                REG_L:  get_reg = l;
                REG_HL: get_reg = data_in; // Memory read from HL address
                REG_A:  get_reg = a;
                default: get_reg = 8'h00;
            endcase
    endfunction

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
            ir <= 8'h00;
            state <= STATE_FETCH;
            fetch_ready <= 1'b0;
            src <= 3'b000;
            dst <= 3'b000;
            alu_op <= 5'b00000;
            we <= 1'b0;
            addr <= 16'h0000;
            data_out <= 8'h00;
        end
        else begin
            
            // State Machine for Fetch, Decode, Execute
            case (state)
                // Fetch the next instruction
                STATE_FETCH: begin
                    if (!fetch_ready) begin
                        addr  <= pc;           // Set address to PC for fetching instruction
                        we    <= 1'b0;         // Read operation
                        fetch_ready <= 1'b1;   // Indicate fetch is ready
                    end
                    else begin
                        ir <= data_in;         // Load fetched instruction into IR
                        pc <= pc + 1;          // Increment PC to point to next instruction
                        fetch_ready <= 1'b0;   // Reset fetch ready for next cycle
                        state <= STATE_DECODE; // Move to decode state
                    end
                end
                
                // Decode the fetched instruction
                STATE_DECODE: begin
                    dst <= ir[5:3]; // Destination register (bits 5-3)
                    src <= ir[2:0]; // Source register (bits 2-0)

                    if (ir[7:6] == 2'b01) begin
                        alu_op <= ALU_LD;       // Identify as LD instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end
                    else begin
                        state <= STATE_FETCH;
                    end

                end
                
                // Execute the instruction
                STATE_EXECUTE: begin
                    case (alu_op)
                        ALU_LD: begin
                            // Handle LD r1, r2 instruction
                            case (dst)
                                REG_B:  b <= get_reg(src);
                                REG_C:  c <= get_reg(src);
                                REG_D:  d <= get_reg(src);
                                REG_E:  e <= get_reg(src);
                                REG_H:  h <= get_reg(src);
                                REG_L:  l <= get_reg(src);
                                REG_A:  a <= get_reg(src);
                                REG_HL: begin
                                    addr <= {h, l}; // Set address to HL for memory write
                                    data_out <= get_reg(src); // Set data to be written
                                    we <= 1'b1; // Enable write
                                end
                                default: ; // No operation for invalid destination
                            endcase
                            
                            state <= STATE_FETCH; // Return to fetch state after execution 
                        end
                    endcase
                end

                default: begin
                    state <= STATE_FETCH;
                end

            endcase
        end
    end

endmodule