// =============================================================================
// Project      : GameBoy Emulator
// File         : cpu.v
// Author       : Jordie Bellar
// Date         : 2026-08-03
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
    input wire [7:0] ie,
    input wire [7:0] if_reg,
    output reg we,
    output reg [15:0] addr,
    output reg [7:0] data_out,
    output reg [7:0] if_clear,   // Which IF bit to clear
    output reg       if_clear_we // pulse high for one cycle to clear
);

    // Local Parameters

    // Flag Bit Positions
    localparam F_Z = 7; // Zero Flag
    localparam F_N = 6; // Subtract Flag
    localparam F_H = 5; // Half Carry Flag
    localparam F_C = 4; // Carry Flag

    // CPU States
    localparam STATE_FETCH   = 4'd0;
    localparam STATE_DECODE  = 4'd1;
    localparam STATE_EXECUTE = 4'd2;
    localparam STATE_FETCH_IMM = 4'd3; // Fetch Immediate Data
    localparam STATE_STACK_PUSH = 4'd4; // Push to Stack
    localparam STATE_STACK_POP  = 4'd5; // Pop from Stack
    localparam STATE_HALT = 4'd6; // Halts until interrupt
    localparam STATE_MEM_READ = 4'd7; // Puts address on bus, waits, them reads data_in
    localparam STATE_MEM_WRITE = 4'd8; // Writes to memory address

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
    localparam ALU_DEC    = 5'b00100; // Decrement
    localparam ALU_ADD    = 5'b00101; // Add
    localparam ALU_SUB    = 5'b00110; // Subtract
    localparam ALU_AND    = 5'b00111; // AND
    localparam ALU_XOR    = 5'b01000; // XOR
    localparam ALU_OR     = 5'b01001; // OR
    localparam ALU_CP     = 5'b01010; // Compare
    localparam ALU_JP_IMM = 5'b01011; // Jump to Immediate Address
    localparam ALU_JR     = 5'b01100; // Jump Relative
    localparam ALU_JR_CC  = 5'b01101; // Jump Relative Conditional
    localparam ALU_CALL   = 5'b01110; // Push to Stack
    localparam ALU_RET    = 5'b01111; // Pop from Stack
    localparam ALU_INT    = 5'b10000; // INT
    localparam ALU_DI     = 5'b10001; // Disable Interrupts
    localparam ALU_EI     = 5'b10010; // Enable Interrupts
    localparam ALU_RETI   = 5'b10011; // RETI
    localparam ALU_LD_SP  = 5'b10100; // Load into stack pointer
    localparam ALU_PUSH   = 5'b10101; // PUSH register pairs
    localparam ALU_POP    = 5'b10111; // POP register pair from stack
    localparam ALU_JP_CC  = 5'b11000; // Conditional absolute jumps

    // Registers
    reg [15:0] pc;   // Program Counter
    reg [15:0] sp;   // Stack Pointer
    reg [7:0]  a;    // Accumulator
    reg [7:0]  f;    // Flags Register
    reg [7:0]  b, c; // BC Register Pair
    reg [7:0]  d, e; // DE Register Pair
    reg [7:0]  h, l; // HL Register Pair
    reg [7:0]  ir;   // Instruction Register
    reg [15:0] mem_addr; // Memory Address register
    reg [15:0] mem_data; // Holds the value being written

    // State Machine
    reg [3:0] state;

    // Flags
    reg fetch_ready;
    reg second_fetch;
    reg imm16;

    // Instruction Decoding
    reg [2:0] src;
    reg [2:0] dst;
    reg [4:0] alu_op;

    // Immediate value for instructions that require it
    reg [7:0] n; // Immediate 8-bit value

    // 16-bit Immeditate value for instructions that require it
    reg [15:0] nn; // Immediate 16-bit value

    // Stack State Registers
    reg [15:0] ret_addr; // Return address for CALL and RET instructions
    reg second_stack_fetch; // Flag to indicate second fetch for 16-bit immediate values
    reg push_after_imm; // Flag to indicate that we need to push return address after fetching immediate value

    // Interrupt Registers
    reg ime; // Interrupt Master Enable
    reg [15:0] iv_addr; // Interrupt vector address
    reg ime_pending; // Delayed IME enable for EI instruction

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
            second_fetch <= 1'b0;
            imm16 <= 1'b0;
            src <= 3'b000;
            dst <= 3'b000;
            alu_op <= 5'b00000;
            n <= 8'h00;
            nn <= 16'h0000;
            ret_addr <= 16'h0000;
            second_stack_fetch <= 1'b0;
            push_after_imm <= 1'b0;
            iv_addr <= 16'h0000;
            ime_pending <= 1'b0;
            we <= 1'b0;
            addr <= 16'h0000;
            data_out <= 8'h00;
            if_clear <= 8'h00;
            if_clear_we <= 1'b0;
            mem_addr <= 16'h0000;
            mem_data <= 16'h0000;
        end
        else begin           
            // State Machine for Fetch, Decode, Execute
            case (state)
                // Fetch the next instruction
                STATE_FETCH: begin
                    if (ime && (ie & if_reg) != 8'h00) begin
                        ime <= 0;
                        ret_addr <= pc;
                        if (ie & if_reg & 8'h01) begin       // VBlank
                            iv_addr <= 16'h0040;             // Vector Address
                            if_clear <= 8'h01;               // Bit to Clear
                            if_clear_we <= 1'b1;             // Clear Enable    
                        end
                        else if (ie & if_reg & 8'h02) begin  // LCD STAT
                            iv_addr <= 16'h0048;             // Vector Address
                            if_clear <= 8'h02;               // Bit to Clear
                            if_clear_we <= 1'b1;             // Clear Enable
                        end
                        else if (ie & if_reg & 8'h04) begin  // Timer
                            iv_addr <= 16'h0050;             // Vector Address
                            if_clear <= 8'h04;               // Bit to Clear
                            if_clear_we <= 1'b1;             // Clear Enable
                        end    
                        else if (ie & if_reg & 8'h08) begin  // Serial
                            iv_addr <= 16'h0058;             // Vector Address
                            if_clear <= 8'h08;               // Bit to Clear
                            if_clear_we <= 1'b1;             // Clear Enable
                        end
                        else if (ie & if_reg & 8'h10) begin  // Joypad
                            iv_addr <= 16'h0060;             // Vector Address
                            if_clear <= 8'h10;               // Bit to Clear
                            if_clear_we <= 1'b1;             // Clear Enable
                        end
                        alu_op <= ALU_INT;
                        state <= STATE_STACK_PUSH;
                    end
                    else begin
                        if_clear_we <= 1'b0; // Disable Clear
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
                end

                // This state is used to fetch immediate data for instructions that require it
                STATE_FETCH_IMM: begin
                    if(!fetch_ready) begin
                        addr <= pc;           // Set address to PC for fetching immediate data
                        we <= 1'b0;           // Read operation
                        fetch_ready <= 1'b1;   // Indicate fetch is ready
                    end
                    else if(fetch_ready && !second_fetch) begin
                        if(!imm16) begin
                            n <= data_in;        // Load 8-bit immediate value into 'n'
                            pc <= pc + 1;        // Increment PC after fetching immediate
                            fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                            state <= STATE_EXECUTE; // Move to execute state to execute instruction with immediate value
                        end
                        else begin
                            nn[7:0] <= data_in;    // Load lower 8 bits of 16-bit immediate value into 'nn'
                            pc <= pc + 1;          // Increment PC after fetching immediate
                            second_fetch <= 1'b1;    // Set second fetch for next instruction
                            fetch_ready <= 1'b0;   // Reset fetch ready for next cycle
                        end

                    end
                    else if(fetch_ready && second_fetch) begin
                        nn[15:8] <= data_in;   // Load upper 8 bits of 16-bit immediate value into 'nn'
                        pc <= pc + 1;          // Increment PC after fetching immediate
                        second_fetch <= 1'b0;    // Reset second fetch for next instruction
                        fetch_ready <= 1'b0;   // Reset fetch ready for next cycle
                        imm16 <= 1'b0;          // Reset imm16 for next instruction
                        if(push_after_imm) begin
                            ret_addr <= pc + 1;        // Store return address for CALL instruction
                            push_after_imm <= 1'b0; // Reset push_after_imm flag
                            state <= STATE_STACK_PUSH; // Move to stack push state to push return address onto stack
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state to execute instruction with immediate value
                        end
                    end  
                end
                
                // Decode the fetched instruction
                STATE_DECODE: begin
                    dst <= ir[5:3]; // Destination register (bits 5-3)
                    src <= ir[2:0]; // Source register (bits 2-0)

                    if (ir[7:6] == 2'b01) begin
                        if (src == 3'b110) begin
                            // LD r, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else if (dst == 3'b110) begin
                            // LD (HL), r
                            mem_addr <= {h, l}; // Set memory address to HL for write
                            mem_data <= get_reg(src); // Set data to be written from source register
                            state <= STATE_MEM_WRITE; // Move to memory write state
                        end
                        else begin
                            // LD r, r'
                            alu_op <= ALU_LD; // Identify as LD instruction
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b110) begin
                        // This is an instruction that requires an immediate value
                        alu_op <= ALU_LD_IMM; // Identify as LD IMMEDIATE instruction
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b100) begin
                        alu_op <= ALU_INC; // Identify as INC instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b101) begin
                        alu_op <= ALU_DEC; // Identify as DEC instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b000) begin
                        alu_op <= ALU_ADD; // Identify as ADD instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b010) begin
                        alu_op <= ALU_SUB; // Identify as SUB instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b100) begin
                        alu_op <= ALU_AND; // Identify as AND instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b101) begin
                        alu_op <= ALU_XOR; // Identify as XOR instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b110) begin
                        alu_op <= ALU_OR; // Identify as OR instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b111) begin
                        alu_op <= ALU_CP; // Identify as CP instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b11 && ir[2:0] == 3'b011) begin
                        alu_op <= ALU_JP_IMM; // Identify as JP instruction with immediate value
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch a 16-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b00 && ir[5:3] == 3'b011 && ir[2:0] == 3'b000) begin
                        alu_op <= ALU_JR; // Identify as JR instruction
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b00 && ir[5:3] >= 3'b100 && ir[2:0] == 3'b000) begin
                        alu_op <= ALU_JR_CC; // Identify as JR conditional instruction
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b11 && ir[5:3] == 3'b001 && ir[2:0] == 3'b101) begin
                        alu_op <= ALU_CALL; // Identify as CALL instruction
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch a 16-bit immediate value
                        push_after_imm <= 1'b1; // Set flag to push return address after fetching immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b11 && ir[5:3] == 3'b001 && ir[2:0] == 3'b001) begin
                        alu_op <= ALU_RET; // Identify as RET instruction
                        state <= STATE_STACK_POP; // Move to stack pop state to retrieve return address
                    end

                    else if (ir == 8'hF3) begin
                        alu_op <= ALU_DI; // Identify as DI instruction
                        state <= STATE_EXECUTE;
                    end

                    else if (ir == 8'hFB) begin
                        alu_op <= ALU_EI; // Identify as EI instruction
                        state <= STATE_EXECUTE;
                    end

                    else if (ir == 8'hD9) begin
                        alu_op <= ALU_RETI; // Identify as RETI instruction
                        state <= STATE_STACK_POP;
                    end

                    else if (ir == 8'h76) begin
                        state <= STATE_HALT; // Identify as HALT instruction
                    end

                    else if (ir == 8'h00) begin
                        state <= STATE_FETCH; // Identify as NOP instruction
                    end

                    else if (ir == 8'h31) begin
                        alu_op <= ALU_LD_SP; // Identify as JR conditional instruction
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch an 16-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b11 && ir [2:0] == 3'b101 && ir[5:3] != 3'b001) begin
                        case (dst)
                            3'b000: ret_addr <= {b, c};
                            3'b010: ret_addr <= {d, e};
                            3'b100: ret_addr <= {h, l};
                            3'b110: ret_addr <= {a, f};
                        endcase
                        alu_op <= ALU_PUSH; // Identify as PUSH instruction
                        state <= STATE_STACK_PUSH;
                    end

                    else if (ir[7:6] == 2'b11 && ir[2:0] == 3'b001 && ir[5:3] != 3'b001) begin
                        alu_op <= ALU_POP; // Identify as POP instruction
                        state <= STATE_STACK_POP;
                    end

                    else if (ir[7:6] == 2'b11 && ir[2:0] == 3'b010) begin
                        alu_op <= ALU_JP_CC; // Identify as JP conditional instruction
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch an 16-bit immediate value
                        state <= STATE_FETCH_IMM;
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

                        ALU_DEC: begin
                            // Handle DEC r instruction
                            f[F_Z] <= (get_reg(dst) - 1 == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= ((get_reg(dst) & 4'hF) == 4'h0); // Set Half Carry flag if there is a borrow from bit 4
                            f[F_N] <= 1'b1; // Set Subtract flag for DEC

                            case (dst)
                                REG_B:  begin
                                    b <= get_reg(dst) - 1; // Update register with result after flags are set
                                end
                                REG_C:  begin
                                    c <= get_reg(dst) - 1; // Update register with result after flags are set
                                end
                                REG_D:  begin
                                    d <= get_reg(dst) - 1; // Update register with result after flags are set
                                end
                                REG_E:  begin
                                    e <= get_reg(dst) - 1; // Update register with result after flags are set
                                end
                                REG_H:  begin
                                    h <= get_reg(dst) - 1; // Update register with result after flags are set
                                end
                                REG_L:  begin
                                    l <= get_reg(dst) - 1; // Update register with result after flags are set
                                end
                                REG_A:  begin
                                    a <= get_reg(dst) - 1; // Update register with result after flags are set
                                end
                                REG_HL: begin
                                    // We will be back to this
                                end
                                default: ; // No operation for invalid destination
                            endcase
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_ADD: begin
                            // Handle ADD A, r instruction
                            f[F_Z] <= ((a + get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= ((a & 4'hF) + (get_reg(src) & 4'hF) > 4'hF); // Set Half Carry flag if there is a carry from bit 3
                            f[F_C] <= ({1'b0, a} + {1'b0, get_reg(src)} > 9'h0FF); // Set Carry flag if there is a carry from bit 7
                            f[F_N] <= 1'b0; // Reset Subtract flag for ADD

                            a <= a + get_reg(src); // Update Accumulator with result after flags are set
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_SUB: begin
                            // Handle SUB A, r instruction
                            f[F_Z] <= ((a - get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= ((a & 4'hF) < (get_reg(src) & 4'hF)); // Set Half Carry flag if there is a borrow from bit 4
                            f[F_C] <= (a < get_reg(src)); // Set Carry flag if there is a borrow from bit 7
                            f[F_N] <= 1'b1; // Set Subtract flag for SUB

                            a <= a - get_reg(src); // Update Accumulator with result after flags are set
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_AND: begin
                            // Handle AND A, r instruction
                            f[F_Z] <= ((a & get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= 1'b1; // Set Half Carry flag for AND
                            f[F_C] <= 1'b0; // Reset Carry flag for AND
                            f[F_N] <= 1'b0; // Reset Subtract flag for AND

                            a <= a & get_reg(src); // Update Accumulator with result after flags are set
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_XOR: begin
                            // Handle XOR A, r instruction
                            f[F_Z] <= ((a ^ get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= 1'b0; // Reset Half Carry flag for XOR
                            f[F_C] <= 1'b0; // Reset Carry flag for XOR
                            f[F_N] <= 1'b0; // Reset Subtract flag for XOR

                            a <= a ^ get_reg(src); // Update Accumulator with result after flags are set
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_OR: begin
                            // Handle OR A, r instruction
                            f[F_Z] <= ((a | get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= 1'b0; // Reset Half Carry flag for OR
                            f[F_C] <= 1'b0; // Reset Carry flag for OR
                            f[F_N] <= 1'b0; // Reset Subtract flag for OR

                            a <= a | get_reg(src); // Update Accumulator with result after flags are set
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_CP: begin
                            // Handle CP A, r instruction
                            f[F_Z] <= ((a - get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= ((a & 4'hF) < (get_reg(src) & 4'hF)); // Set Half Carry flag if there is a borrow from bit 4
                            f[F_C] <= (a < get_reg(src)); // Set Carry flag if there is a borrow from bit 7
                            f[F_N] <= 1'b1; // Set Subtract flag for CP

                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_JP_IMM: begin
                            // Handle JP nn instruction
                            pc <= nn; // Set PC to the immediate 16-bit value
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_JR: begin
                            // Handle JR n instruction
                            pc <= pc + {{8{n[7]}}, n}; // Sign-extend the 8-bit immediate value and add to PC
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_JR_CC: begin
                            // Handle JR cc, n instruction
                            case (ir[5:3]) // Check the condition code
                                3'b100: if (!f[F_Z]) pc <= pc + {{8{n[7]}}, n}; // JR NZ, n
                                3'b101: if (f[F_Z]) pc <= pc + {{8{n[7]}}, n};  // JR Z, n
                                3'b110: if (!f[F_C]) pc <= pc + {{8{n[7]}}, n}; // JR NC, n
                                3'b111: if (f[F_C]) pc <= pc + {{8{n[7]}}, n};  // JR C, n
                                default: ; // No operation for invalid condition codes
                            endcase
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_CALL: begin
                            // Handle CALL nn instruction
                            // The return address (current PC) will be pushed onto the stack in the STATE_STACK_PUSH state
                            pc <= nn; // Set PC to the immediate 16-bit value
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_RET: begin
                            // Handle RET instruction
                            pc <= ret_addr; // Set PC to the return address popped from the stack
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_INT: begin
                            // Handle Interrupts
                            pc <= iv_addr;
                            state <= STATE_FETCH;
                        end

                        ALU_DI: begin
                            ime <= 1'b0;
                            state <= STATE_FETCH;
                        end

                        ALU_EI: begin
                            ime_pending <= 1'b1;
                            state <= STATE_FETCH;
                        end

                        ALU_RETI: begin
                            pc <= ret_addr;
                            ime <= 1'b1;
                            state <= STATE_FETCH;
                        end

                        ALU_LD_SP: begin
                            sp <= nn; // Move immediate 16-bit value into Stack Pointer
                            state <= STATE_FETCH;
                        end

                        ALU_PUSH: begin
                            state <= STATE_FETCH;
                        end

                        ALU_POP: begin
                            case (ir[5:3])
                                3'b000: begin
                                    b <= ret_addr[15:8];
                                    c <= ret_addr[7:0];
                                end
                                3'b010: begin
                                    d <= ret_addr[15:8];
                                    e <= ret_addr[7:0];
                                end
                                3'b100: begin
                                    h <= ret_addr[15:8];
                                    l <= ret_addr[7:0];
                                end
                                3'b110: begin
                                    a <= ret_addr[15:8];
                                    f <= ret_addr[7:0];
                                end
                            endcase
                            state <= STATE_FETCH;
                        end

                        ALU_JP_CC: begin
                            // Handle JP cc, nn instruction
                            case (ir[5:3]) // Check the condition code
                                3'b000: if (!f[F_Z]) pc <= nn; // JP NZ, nn
                                3'b001: if (f[F_Z]) pc <= nn;  // JP Z, nn
                                3'b010: if (!f[F_C]) pc <= nn; // JP NC, nn
                                3'b011: if (f[F_C]) pc <= nn;  // JP C, nn
                                default: ; // No operation for invalid condition codes
                            endcase
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        default: state <= STATE_FETCH; // For unimplemented ALU operations, return to fetch
                
                    endcase

                    if(ime_pending) begin
                        ime <= 1'b1;
                        ime_pending <= 1'b0;
                    end  

                end
                
                STATE_STACK_PUSH: begin
                    // Handle pushing a 16-bit value onto the stack
                    if (!second_stack_fetch) begin
                        if(!fetch_ready) begin
                            sp <= sp - 1; // Decrement SP by 1 after pushing high byte                    
                            fetch_ready <= 1'b1; // Indicate fetch is ready
                        end
                        else begin
                            we <= 1'b1; // Enable write
                            addr <= sp; // Set address to SP
                            data_out <= ret_addr[15:8];
                            fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                            second_stack_fetch <= 1'b1;
                        end
                    end
                    else if (second_stack_fetch) begin
                        if(!fetch_ready) begin
                            sp <= sp - 1; // Decrement SP by 1 after pushing low byte                          
                            fetch_ready <= 1'b1; // Indicate fetch is ready
                        end
                        else begin
                            we <= 1'b1; // Enable write
                            addr <= sp; // Set address to SP
                            data_out <= ret_addr[7:0];
                            fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                            second_stack_fetch <= 1'b0; // Reset for next push
                            state <= STATE_EXECUTE;
                        end
                    end
                end

                STATE_STACK_POP: begin
                    // Handle popping a 16-bit value from the stack
                    if (!second_stack_fetch) begin
                        if(!fetch_ready) begin
                            addr <= sp; // Set address to SP
                            we <= 1'b0; // Read operation
                            fetch_ready <= 1'b1; // Indicate fetch is ready
                        end
                        else begin
                            ret_addr[7:0] <= data_in; // Read low byte
                            sp <= sp + 1; // Increment SP by 1 after popping low byte
                            fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                            second_stack_fetch <= 1'b1;
                        end
                    end
                    else if (second_stack_fetch) begin
                        if(!fetch_ready) begin
                            addr <= sp; // Set address to SP
                            we <= 1'b0; // Read operation
                            fetch_ready <= 1'b1; // Indicate fetch is ready
                        end
                        else begin
                            ret_addr[15:8] <= data_in; // Read high byte
                            sp <= sp + 1; // Increment SP by 1 after popping high byte
                            fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                            second_stack_fetch <= 1'b0; // Reset for next pop
                            state <= STATE_EXECUTE;
                        end
                    end
                end

                STATE_HALT: begin
                    if((ie & if_reg) != 8'h00) begin
                        state <= STATE_FETCH;
                    end
                end

                STATE_MEM_READ: begin
                    if (!fetch_ready) begin
                        addr <= mem_addr;
                        we <= 1'b0;
                        fetch_ready <= 1'b1;
                    end
                    else if (fetch_ready) begin
                        case (dst)
                            REG_B:  b <= data_in;
                            REG_C:  c <= data_in;
                            REG_D:  d <= data_in;
                            REG_E:  e <= data_in;
                            REG_H:  h <= data_in;
                            REG_L:  l <= data_in;
                            REG_A:  a <= data_in;
                            default: ; // No operation for invalid destination
                        endcase
                        fetch_ready <= 1'b0;
                        state <= STATE_FETCH;
                    end
                end

                STATE_MEM_WRITE: begin
                    if(!fetch_ready) begin
                        addr <= mem_addr;
                        data_out <= mem_data;
                        we <= 1'b1;
                        fetch_ready <= 1'b1;
                    end
                    else if(fetch_ready) begin
                        we <= 1'b0;
                        fetch_ready <= 1'b0;
                        state <= STATE_FETCH;
                    end

                end


                default: begin
                    state <= STATE_FETCH;
                end

            endcase
        end
    end

endmodule