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
`timescale 1ns / 1ps
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
    localparam STATE_FETCH   = 3'd0;
    localparam STATE_DECODE  = 3'd1;
    localparam STATE_EXECUTE = 3'd2;
    localparam STATE_FETCH_IMM = 3'd3; // Fetch Immediate Data

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
    localparam ALU_LD     = 5'b00001; // Load
    localparam ALU_LD_IMM = 5'b00010; // Load Immediate
    localparam ALU_INC    = 5'b00011; // Increment

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
    reg [2:0] state;

    // Flags
    reg fetch_ready;

    // Instruction Decoding
    reg [2:0] src;
    reg [2:0] dst;
    reg [4:0] alu_op;

    // Immediate value for instructions that require it
    reg [7:0] n; // Immediate 8-bit value

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
            n <= 8'h00;
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

                // This state is used to fetch immediate data for instructions that require it
                STATE_FETCH_IMM: begin
                    if(!fetch_ready) begin
                        addr <= pc;           // Set address to PC for fetching immediate data
                        we <= 1'b0;           // Read operation
                        fetch_ready <= 1'b1;   // Indicate fetch is ready
                    end
                    else begin
                        n <= data_in;         // Load immediate value into 'n'
                        pc <= pc + 1;          // Increment PC after fetching immediate
                        fetch_ready <= 1'b0;   // Reset fetch ready for next cycle
                        state <= STATE_EXECUTE; // Move to execute state to execute instruction with immediate value
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

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b110) begin
                        // This is an instruction that requires an immediate value
                        alu_op <= ALU_LD_IMM; // Identify as LD IMMEDIATE instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b100) begin
                        alu_op <= ALU_INC; // Identify as INC instruction
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

                        ALU_LD_IMM: begin
                            // Handle LD r, n instruction
                            case (dst)
                                REG_B:  b <= n;
                                REG_C:  c <= n;
                                REG_D:  d <= n;
                                REG_E:  e <= n;
                                REG_H:  h <= n;
                                REG_L:  l <= n;
                                REG_A:  a <= n;
                                REG_HL: begin
                                    addr <= {h, l}; // Set address to HL for memory write
                                    data_out <= n; // Set data to be written
                                    we <= 1'b1; // Enable write
                                end
                                default: ; // No operation for invalid destination
                            endcase
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_INC: begin
                            // Handle INC r instruction

                            f[F_Z] <= (get_reg(dst) + 1 == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= ((get_reg(dst) & 4'hF) + 1 > 4'hF); // Set Half Carry flag if there is a carry from bit 3
                            f[F_N] <= 1'b0; // Reset Subtract flag for INC

                            case (dst)
                                REG_B:  begin
                                    b <= get_reg(dst) + 1; // Update register with result after flags are set
                                end
                                REG_C:  begin
                                    c <= get_reg(dst) + 1; // Update register with result after flags are set
                                end
                                REG_D:  begin
                                    d <= get_reg(dst) + 1; // Update register with result after flags are set
                                end
                                REG_E:  begin
                                    e <= get_reg(dst) + 1; // Update register with result after flags are set
                                end
                                REG_H:  begin
                                    h <= get_reg(dst) + 1; // Update register with result after flags are set
                                end
                                REG_L:  begin
                                    l <= get_reg(dst) + 1; // Update register with result after flags are set
                                end
                                REG_A:  begin
                                    a <= get_reg(dst) + 1; // Update register with result after flags are set
                                end
                                REG_HL: begin
                                    // We will be back to this
                                end
                                default: ; // No operation for invalid destination
                            endcase
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        default: state <= STATE_FETCH; // For unimplemented ALU operations, return to fetch
                        
                    endcase
                end

                default: begin
                    state <= STATE_FETCH;
                end
    
            endcase
        end
    end

endmodule