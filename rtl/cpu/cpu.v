// =============================================================================
// Project      : GameBoy Emulator
// File         : cpu.v
// Author       : Jordie Bellar
// Date         : 2026-09-12
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
    localparam STATE_FETCH_CB = 4'd9; // Fetch CB-prefixed instruction
    localparam STATE_CB_DECODE = 4'd10; // Decode CB-prefixed instruction

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
    localparam ALU_LD          = 6'b000001; // Load
    localparam ALU_LD_IMM      = 6'b000010; // Load Immediate
    localparam ALU_INC         = 6'b000011; // Increment
    localparam ALU_DEC         = 6'b000100; // Decrement
    localparam ALU_ADD         = 6'b000101; // Add
    localparam ALU_SUB         = 6'b000110; // Subtract
    localparam ALU_AND         = 6'b000111; // AND
    localparam ALU_XOR         = 6'b001000; // XOR
    localparam ALU_OR          = 6'b001001; // OR
    localparam ALU_CP          = 6'b001010; // Compare
    localparam ALU_JP_IMM      = 6'b001011; // Jump to Immediate Address
    localparam ALU_JR          = 6'b001100; // Jump Relative
    localparam ALU_JR_CC       = 6'b001101; // Jump Relative Conditional
    localparam ALU_CALL        = 6'b001110; // Push to Stack
    localparam ALU_RET         = 6'b001111; // Pop from Stack
    localparam ALU_INT         = 6'b010000; // INT
    localparam ALU_DI          = 6'b010001; // Disable Interrupts
    localparam ALU_EI          = 6'b010010; // Enable Interrupts
    localparam ALU_RETI        = 6'b010011; // RETI
    localparam ALU_LD_SP       = 6'b010100; // Load into stack pointer
    localparam ALU_PUSH        = 6'b010101; // PUSH register pairs
    localparam ALU_POP         = 6'b010111; // POP register pair from stack
    localparam ALU_JP_CC       = 6'b011000; // Conditional absolute jumps
    localparam ALU_ADC         = 6'b011001; // Add with carry
    localparam ALU_SBC         = 6'b011010; // Subtract with carry
    localparam ALU_LD_SP_HL    = 6'b011011; // Load SP into HL
    localparam ALU_LD_RR_IMM   = 6'b011100; // Load register pair from immediate value
    localparam ALU_INC_RR      = 6'b011101; // Increment register pair
    localparam ALU_DEC_RR      = 6'b011110; // Decrement register pair
    localparam ALU_ADD_HL_RR   = 6'b011111; // Add register pair to HL
    localparam ALU_LD_HL_SP_E8 = 6'b100000; // Load HL with SP + signed immediate value
    localparam ALU_RLCA        = 6'b100001; // Rotate A left
    localparam ALU_RRCA        = 6'b100010; // Rotate A right
    localparam ALU_RLA         = 6'b100011; // Rotate A left through carry
    localparam ALU_RRA         = 6'b100100; // Rotate A right through carry
    localparam ALU_CPL         = 6'b100101; // Complement A
    localparam ALU_SCF         = 6'b100110; // Set Carry Flag
    localparam ALU_CCF         = 6'b100111; // Complement Carry Flag
    localparam ALU_RST         = 6'b101000; // Restart
    localparam ALU_RET_CC      = 6'b101001; // Conditional return
    localparam ALU_ADD_SP_E8   = 6'b101010; // Add signed immediate to SP
    localparam ALU_STOP        = 6'b101011; // Stop
    localparam ALU_DAA         = 6'b101100; // Decimal Adjust A
    localparam ALU_CB_ROT      = 6'b101101; // CB-prefixed rotate/shift instructions
    localparam ALU_CB_BIT      = 6'b101110; // CB-prefixed bit instructions
    localparam ALU_CB_RES      = 6'b101111; // CB-prefixed reset bit instructions
    localparam ALU_CB_SET      = 6'b110000; // CB-prefixed set bit instructions

    // Registers
    reg [15:0] pc;   // Program Counter
    reg [15:0] sp;   // Stack Pointer
    reg [7:0]  a;    // Accumulator
    reg [7:0]  f;    // Flags Register
    reg [7:0]  b, c; // BC Register Pair
    reg [7:0]  d, e; // DE Register Pair
    reg [7:0]  h, l; // HL Register Pair
    reg [7:0]  ir;   // Instruction Register
    reg [7:0] cb_ir;  // CB Instruction Register
    reg [15:0] mem_addr; // Memory Address register
    reg [15:0] mem_data; // Holds the value being written

    // State Machine
    reg [3:0] state;

    // Flags
    reg fetch_ready;
    reg mem_wait;
    reg second_fetch;
    reg imm16;
    reg alu_imm; // Immediate value for ALU operations
    reg halt_bug; // Flag to indicate that the HALT bug is active

    // For Memory Read/Write
    reg mem_read_after_imm; // Flag to indicate that we need to read from memory after fetching immediate value
    reg mem_write_after_imm; // Flag to indicate that we need to write to memory after fetching immediate value

    // ALU Memory Read
    reg mem_alu_read;  // Flag to indicate that we need to read from memory before ALU operation
    reg [15:0] mem_alu_data; // Holds the value read from memory for ALU operation

    // Instruction Decoding
    reg [2:0] src;
    reg [2:0] dst;
    reg [5:0] alu_op;
    reg [1:0] rp_sel;
    reg mem_write_sp; // Flag to indicate that we need to write to memory at the stack pointer address
    reg sp_write_low_done; // Flag to indicate that we have written the low byte of SP to memory

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

    // DAA Regs 
    reg [7:0] correction;
    reg new_c;
    reg [7:0] new_a;

    // CB Instruction Operand
    reg [7:0] cb_operand;
    // Determine the operand for CB instructions based on whether it's a memory read or a register read
    always @(dst or mem_alu_read or mem_alu_data or a or b or c or d or e or h or l) begin
        if (mem_alu_read)
            cb_operand = mem_alu_data[7:0];
        else
            cb_operand = get_reg(dst);
    end

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

    function [15:0] get_rp;
        input [1:0] rp_id;
            case (rp_id)
                2'b00: get_rp = {b, c}; // BC
                2'b01: get_rp = {d, e}; // DE
                2'b10: get_rp = {h, l}; // HL
                2'b11: get_rp = sp;     // SP
                default: get_rp = 16'h0000;
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
            mem_read_after_imm <= 1'b0;
            mem_write_after_imm <= 1'b0;
            src <= 3'b000;
            dst <= 3'b000;
            alu_op <= 5'b00000;
            n <= 8'h00;
            nn <= 16'h0000;
            ret_addr <= 16'h0000;
            second_stack_fetch <= 1'b0;
            push_after_imm <= 1'b0;
            rp_sel <= 2'b00;
            mem_write_sp <= 1'b0;
            sp_write_low_done <= 1'b0;
            iv_addr <= 16'h0000;
            ime_pending <= 1'b0;
            we <= 1'b0;
            addr <= 16'h0000;
            data_out <= 8'h00;
            if_clear <= 8'h00;
            if_clear_we <= 1'b0;
            mem_addr <= 16'h0000;
            mem_data <= 16'h0000;
            mem_alu_read <= 1'b0;
            mem_alu_data <= 16'h0000;
            alu_imm <= 1'b0;
            mem_wait <= 1'b0;
            ime <= 1'b0;
            halt_bug <= 1'b0;
            cb_ir <= 8'h00;
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
                        else if (!mem_wait) begin
                            mem_wait <= 1'b1;
                        end
                        else begin
                            ir <= data_in;         // Load fetched instruction into IR
                            if (halt_bug) begin
                                halt_bug <= 1'b0; // Clear halt_bug flag
                            end
                            else begin
                                pc <= pc + 1;          // Increment PC to point to next instruction
                            end
                            fetch_ready <= 1'b0;   // Reset fetch ready for next cycle
                            mem_wait <= 1'b0;        // Reset memory wait for next cycle
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
                    else if(!mem_wait) begin
                        mem_wait <= 1'b1;
                    end
                    else if(fetch_ready && !second_fetch) begin
                        mem_wait <= 1'b0;        // Reset memory wait for next cycle
                        if(!imm16) begin
                            n <= data_in;        // Load 8-bit immediate value into 'n'
                            pc <= pc + 1;        // Increment PC after fetching immediate
                            fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                            if (mem_read_after_imm) begin
                                mem_read_after_imm <= 1'b0; // Reset mem_read_after_imm flag
                                mem_addr <= 16'hFF00 + data_in; // Set memory address to the fetched 8-bit immediate value for read
                                state <= STATE_MEM_READ; // Move to memory read state
                            end
                            else if (mem_write_after_imm) begin
                                mem_write_after_imm <= 1'b0; // Reset mem_write_after_imm flag
                                mem_data <= get_reg(src); // Set data to be written from source register
                                mem_addr <= 16'hFF00 + data_in; // Set memory address to the fetched 8-bit immediate value for write
                                state <= STATE_MEM_WRITE; // Move to memory write state
                            end
                            else begin
                                state <= STATE_EXECUTE; // Move to execute state to execute instruction with immediate value
                            end
                        end
                        else begin
                            nn[7:0] <= data_in;    // Load lower 8 bits of 16-bit immediate value into 'nn'
                            pc <= pc + 1;          // Increment PC after fetching immediate
                            second_fetch <= 1'b1;    // Set second fetch for next instruction
                            fetch_ready <= 1'b0;   // Reset fetch ready for next cycle
                        end

                    end
                    else begin
                        mem_wait <= 1'b0;        // Reset memory wait for next cycle
                        nn[15:8] <= data_in;   // Load upper 8 bits of 16-bit immediate value into 'nn'
                        pc <= pc + 1;          // Increment PC after fetching immediate
                        second_fetch <= 1'b0;    // Reset second fetch for next instruction
                        fetch_ready <= 1'b0;   // Reset fetch ready for next cycle
                        imm16 <= 1'b0;          // Reset imm16 for next instruction
                        if (mem_write_sp) begin
                            mem_addr <= {data_in, nn[7:0]}; // Set memory address to the fetched 16-bit immediate value for write
                            mem_data <= sp[7:0]; // Set data to be written from SP low byte
                            sp_write_low_done <= 1'b0; // Reset sp_write_low_done flag
                            state <= STATE_MEM_WRITE; // Move to memory write state
                        end
                        else if(push_after_imm) begin
                            ret_addr <= pc + 1;        // Store return address for CALL instruction
                            push_after_imm <= 1'b0; // Reset push_after_imm flag
                            state <= STATE_STACK_PUSH; // Move to stack push state to push return address onto stack
                        end
                        else if (mem_read_after_imm) begin
                            mem_addr <= {data_in, nn[7:0]}; // Set memory address to the fetched 16-bit immediate value for read
                            mem_read_after_imm <= 1'b0; // Reset mem_read_after_imm flag
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else if (mem_write_after_imm) begin
                            mem_addr <= {data_in, nn[7:0]}; // Set memory address to the fetched 16-bit immediate value for write
                            mem_data <= get_reg(src); // Set data to be written from source register
                            mem_write_after_imm <= 1'b0; // Reset mem_write_after_imm flag
                            state <= STATE_MEM_WRITE; // Move to memory write state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state to execute instruction with immediate value
                        end
                    end  
                end
                
                // Decode the fetched instruction
                STATE_DECODE: begin

                    if (ir == 8'hC6) begin
                        // ADD A, n
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_imm <= 1'b1; // Set flag to indicate that we need to use an immediate value for ALU operation
                        alu_op <= ALU_ADD; // Identify as ADD A, n instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state                        
                    end

                    else if (ir == 8'hCE) begin
                        // ADC A, n
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_imm <= 1'b1; // Set flag to indicate that we need to use an immediate value for ALU operation
                        alu_op <= ALU_ADC; // Identify as ADC A, n instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state                        
                    end

                    else if (ir == 8'hD6) begin
                        // SUB A, n
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_imm <= 1'b1; // Set flag to indicate that we need to use an immediate value for ALU operation
                        alu_op <= ALU_SUB; // Identify as SUB A, n instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state                        
                    end

                    else if (ir == 8'hDE) begin
                        // SBC A, n
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_imm <= 1'b1; // Set flag to indicate that we need to use an immediate value for ALU operation
                        alu_op <= ALU_SBC; // Identify as SBC A, n instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state                        
                    end

                    else if (ir == 8'hE6) begin
                        // AND A, n
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_imm <= 1'b1; // Set flag to indicate that we need to use an immediate value for ALU operation
                        alu_op <= ALU_AND; // Identify as AND A, n instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state                        
                    end

                    else if (ir == 8'hEE) begin
                        // XOR A, n
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_imm <= 1'b1; // Set flag to indicate that we need to use an immediate value for ALU operation
                        alu_op <= ALU_XOR; // Identify as XOR A, n instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state                        
                    end

                    else if (ir == 8'hF6) begin
                        // OR A, n
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_imm <= 1'b1; // Set flag to indicate that we need to use an immediate value for ALU operation
                        alu_op <= ALU_OR; // Identify as OR A, n instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state                        
                    end

                    else if (ir == 8'hFE) begin
                        // CP A, n
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_imm <= 1'b1; // Set flag to indicate that we need to use an immediate value for ALU operation
                        alu_op <= ALU_CP; // Identify as CP A, n instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state                        
                    end

                    else if (ir == 8'hF3) begin
                        // DI
                        alu_op <= ALU_DI; // Identify as DI instruction
                        state <= STATE_EXECUTE;
                    end

                    else if (ir == 8'hFB) begin
                        // EI
                        alu_op <= ALU_EI; // Identify as EI instruction
                        state <= STATE_EXECUTE;
                    end

                    else if (ir == 8'hD9) begin
                        // RETI
                        alu_op <= ALU_RETI; // Identify as RETI instruction
                        state <= STATE_STACK_POP;
                    end

                    else if (ir == 8'h76) begin
                        // HALT
                        if (!ime && (ie & if_reg) != 8'h00) begin
                            // If interrupts are disabled and an interrupt is pending, enter HALT bug state
                            halt_bug <= 1'b1; // Set halt_bug flag to indicate that the HALT bug is active
                            state <= STATE_FETCH; // Return to fetch state to execute the next instruction
                        end
                        else begin
                            state <= STATE_HALT; // Enter HALT state, waiting for an interrupt to occur
                        end
                    end

                    else if (ir == 8'h00) begin
                        // NOP
                        state <= STATE_FETCH; // Identify as NOP instruction
                    end

                    else if (ir == 8'h31) begin
                        // LD SP, nn
                        alu_op <= ALU_LD_SP; // Identify as LD SP, nn instruction
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch an 16-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'hFA) begin
                        // LD A, (nn)
                        dst <= REG_A;
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch a 16-bit immediate value
                        mem_read_after_imm <= 1'b1; // Set flag to read from memory after fetching immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'hEA) begin
                        // LD (nn), A
                        src <= REG_A;
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch a 16-bit immediate value
                        mem_write_after_imm <= 1'b1; // Set flag to write to memory after fetching immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'hF0) begin
                        // LDH A, (n)
                        dst <= REG_A; // Set destination to A
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        mem_read_after_imm <= 1'b1; // Set flag to read from memory after fetching immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'hE0) begin
                        // LDH (n), A
                        src <= REG_A; // Set source to A
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        mem_write_after_imm <= 1'b1; // Set flag to write to memory after fetching immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'hF9) begin
                        // LD SP, HL
                        alu_op <= ALU_LD_SP_HL; // Identify as LD SP, HL instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir == 8'h08) begin
                        // LD (nn), SP
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch a 16-bit immediate value
                        mem_write_sp <= 1'b1; // Set flag to write SP to memory after fetching immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'hF8) begin
                        // LD HL, SP + e8
                        alu_op <= ALU_LD_HL_SP_E8; // Identify as LD HL, SP + e8 instruction
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'hE2) begin
                        // LD (C), A
                        mem_addr <= 16'hFF00 + c; // Set memory address to FF00 + C for write
                        mem_data <= a; // Set data to be written from A
                        state <= STATE_MEM_WRITE; // Move to memory write state
                    end

                    else if (ir == 8'hF2) begin
                        // LD A, (C)
                        dst <= REG_A; // Set destination to A
                        mem_addr <= 16'hFF00 + c; // Set memory address to FF00 + C for read
                        state <= STATE_MEM_READ; // Move to memory read state
                    end

                    else if (ir == 8'hE8) begin
                        // ADD SP, e8
                        alu_op <= ALU_ADD_SP_E8; // Identify as ADD SP, e8 instruction
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'h10) begin
                        // STOP
                        // TODO: Implement STOP instruction handling
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        alu_op <= ALU_STOP; // Identify as STOP instruction
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir == 8'hCB) begin
                        // CB-prefixed instruction
                        state <= STATE_FETCH_CB; // Move to fetch CB-prefixed instruction state
                    end

                    else if (ir[7:6] == 2'b01) begin
                        dst <= ir[5:3]; // Set destination register
                        src <= ir[2:0]; // Set source register
                        if (ir[2:0] == 3'b110) begin
                            // LD r, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else if (ir[5:3] == 3'b110) begin
                            // LD (HL), r
                            mem_addr <= {h, l}; // Set memory address to HL for write
                            mem_data <= get_reg(ir[2:0]); // Set data to be written from source register
                            state <= STATE_MEM_WRITE; // Move to memory write state
                        end
                        else begin
                            // LD r, r'
                            alu_op <= ALU_LD; // Identify as LD instruction
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b110) begin
                        // LD r, n
                        // This is an instruction that requires an immediate value
                        dst <= ir[5:3]; // Set destination register
                        src <= ir[2:0]; // Set source register
                        alu_op <= ALU_LD_IMM; // Identify as LD IMMEDIATE instruction
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b100) begin
                        // INC r
                        alu_op <= ALU_INC; // Identify as INC instruction
                        dst <= ir[5:3]; // Set destination register
                        src <= ir[2:0]; // Set source register
                        if (ir[5:3] == 3'b110) begin
                            // INC (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b101) begin
                        // DEC r
                        alu_op <= ALU_DEC; // Identify as DEC instruction
                        dst <= ir[5:3]; // Set destination register
                        src <= ir[2:0]; // Set source register
                        if (ir[5:3] == 3'b110) begin
                            // DEC (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b000) begin
                        // ADD A, r
                        src <= ir[2:0]; // Set source register
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        alu_op <= ALU_ADD; // Identify as ADD instruction
                        if (ir[2:0] == 3'b110) begin
                            // ADD A, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b010) begin
                        // SUB A, r
                        src <= ir[2:0]; // Set source register
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        alu_op <= ALU_SUB; // Identify as SUB instruction
                        if (ir[2:0] == 3'b110) begin
                            // SUB A, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b100) begin
                        // AND A, r
                        src <= ir[2:0]; // Set source register
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        alu_op <= ALU_AND; // Identify as AND instruction
                        if (ir[2:0] == 3'b110) begin
                            // AND A, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b101) begin
                        // XOR A, r
                        src <= ir[2:0]; // Set source register
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        alu_op <= ALU_XOR; // Identify as XOR instruction
                        if (ir[2:0] == 3'b110) begin
                            // XOR A, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b110) begin
                        // OR A, r
                        src <= ir[2:0]; // Set source register
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        alu_op <= ALU_OR; // Identify as OR instruction
                        if (ir[2:0] == 3'b110) begin
                            // OR A, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b111) begin
                        // CP A, r
                        src <= ir[2:0]; // Set source register
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        alu_op <= ALU_CP; // Identify as CP instruction
                        if (ir[2:0] == 3'b110) begin
                            // CP A, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b11 && ir[2:0] == 3'b011) begin
                        // JP nn
                        alu_op <= ALU_JP_IMM; // Identify as JP instruction with immediate value
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch a 16-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b00 && ir[5:3] == 3'b011 && ir[2:0] == 3'b000) begin
                        // JR n
                        alu_op <= ALU_JR; // Identify as JR instruction
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b00 && ir[5:3] >= 3'b100 && ir[2:0] == 3'b000) begin
                        // JR cc, n
                        alu_op <= ALU_JR_CC; // Identify as JR conditional instruction
                        imm16 <= 1'b0; // Set imm16 to indicate that we need to fetch an 8-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b11 && ir[5:3] == 3'b001 && ir[2:0] == 3'b101) begin
                        // CALL nn
                        alu_op <= ALU_CALL; // Identify as CALL instruction
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch a 16-bit immediate value
                        push_after_imm <= 1'b1; // Set flag to push return address after fetching immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b11 && ir[5:3] == 3'b001 && ir[2:0] == 3'b001) begin
                        // RET
                        alu_op <= ALU_RET; // Identify as RET instruction
                        state <= STATE_STACK_POP; // Move to stack pop state to retrieve return address
                    end

                    else if (ir[7:6] == 2'b11 && ir [2:0] == 3'b101 && ir[5:3] != 3'b001) begin
                        dst <= ir[5:3]; // Set destination register pair for PUSH instruction
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

                    else if (ir[7:6] == 2'b11 && ir[2:0] == 3'b010 && ir[5] == 1'b0) begin
                        alu_op <= ALU_JP_CC; // Identify as JP conditional instruction
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch an 16-bit immediate value
                        state <= STATE_FETCH_IMM;
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b010) begin
                        // LD (BC), A or LD (DE), A or LD (HL+), A or LD (HL-), A
                        src <= REG_A; // Set source to A
                        case (ir[5:4])
                            2'b00: mem_addr <= {b, c}; // Set memory address to BC for read/write
                            2'b01: mem_addr <= {d, e}; // Set memory address to DE for read/write
                            2'b10: // HL increment
                            begin 
                                {h, l} <= {h, l} + 1;
                                mem_addr <= {h, l}; // Set memory address to HL for read/write
                            end 
                            2'b11: // HL decrement
                            begin 
                                {h, l} <= {h, l} - 1; 
                                mem_addr <= {h, l}; // Set memory address to HL for read/write
                            end 
                        endcase

                        if (ir[3]) begin
                            // Read into A
                            dst <= REG_A; // Set destination to A
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            // Write from A
                            mem_data <= a; // Set data to be written from A
                            state <= STATE_MEM_WRITE; // Move to memory write state
                        end
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b001) begin
                        // ADC A, r
                        alu_op <= ALU_ADC; // Identify as ADC instruction
                        src <= ir[2:0]; // Set source register
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        if (ir[2:0] == 3'b110) begin
                            // ADC A, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b10 && ir[5:3] == 3'b011) begin
                        // SBC A, r
                        alu_op <= ALU_SBC; // Identify as SBC instruction
                        src <= ir[2:0]; // Set source register
                        dst <= 3'b111; // Set destination register to A (Accumulator)
                        if (ir[2:0] == 3'b110) begin
                            // SBC A, (HL)
                            mem_addr <= {h, l}; // Set memory address to HL for read
                            mem_alu_read <= 1'b1; // Set flag to read from memory before ALU operation
                            state <= STATE_MEM_READ; // Move to memory read state
                        end
                        else begin
                            state <= STATE_EXECUTE; // Move to execute state
                        end
                    end

                    else if (ir[7:6] == 2'b00 && ir[3:0] == 4'b0001) begin
                        // LD rr, nn
                        rp_sel <= ir[5:4]; // Set register pair select for LD rr, nn instruction
                        alu_op <= ALU_LD_RR_IMM; // Identify as LD rr, nn instruction
                        imm16 <= 1'b1; // Set imm16 to indicate that we need to fetch a 16-bit immediate value
                        state <= STATE_FETCH_IMM; // Move to fetch immediate state
                    end

                    else if (ir[7:6] == 2'b00 && ir[3:0] == 4'b0011) begin
                        // INC rr
                        rp_sel <= ir[5:4]; // Set register pair select for INC rr instruction
                        alu_op <= ALU_INC_RR; // Identify as INC rr instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b00 && ir[3:0] == 4'b1011) begin
                        // DEC rr
                        rp_sel <= ir[5:4]; // Set register pair select for DEC rr instruction
                        alu_op <= ALU_DEC_RR; // Identify as DEC rr instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b00 && ir[3:0] == 4'b1001) begin
                        // ADD HL, rr
                        rp_sel <= ir[5:4]; // Set register pair select for ADD HL, rr instruction
                        alu_op <= ALU_ADD_HL_RR; // Identify as ADD HL, rr instruction
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b111 && ir[5] == 1'b0) begin
                        // RLCA, RRCA, RLA, RRA
                        case (ir[4:3])
                            2'b00: alu_op <= ALU_RLCA; // Identify as RLCA instruction
                            2'b01: alu_op <= ALU_RRCA; // Identify as RRCA instruction
                            2'b10: alu_op <= ALU_RLA;  // Identify as RLA instruction
                            2'b11: alu_op <= ALU_RRA;  // Identify as RRA instruction
                            default: ;
                        endcase
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b111 && ir[5] == 1'b1 && ir[4:3] != 2'b00) begin
                        // CPL, SCF, CCF
                        case (ir[4:3])
                            2'b01: alu_op <= ALU_CPL; // Identify as CPL instruction
                            2'b10: alu_op <= ALU_SCF; // Identify as SCF instruction
                            2'b11: alu_op <= ALU_CCF; // Identify as CCF instruction
                            default: ;
                        endcase
                        state <= STATE_EXECUTE; // Move to execute state
                    end

                    else if (ir[7:6] == 2'b11 && ir[2:0] == 3'b111) begin
                        // RST vector, target = ir[5:3] * 8
                        ret_addr <= pc; // Store current PC as return address
                        iv_addr <= {10'b0000000000, ir[5:3], 3'b000}; // Calculate interrupt vector address
                        alu_op <= ALU_RST; // Identify as RST instruction
                        state <= STATE_STACK_PUSH; // Move to stack push state to save return address
                    end

                    else if (ir[7:6] == 2'b11 && ir[2:0] == 3'b000 && ir[5] == 1'b0) begin
                        // RET NZ/Z/NC/C
                        alu_op <= ALU_RET_CC; // Identify as RET conditional instruction
                        if (ir[4:3] == 2'b00 && !f[F_Z] ||
                            ir[4:3] == 2'b01 && f[F_Z] ||
                            ir[4:3] == 2'b10 && !f[F_C] ||
                            ir[4:3] == 2'b11 && f[F_C]) begin
                            state <= STATE_STACK_POP; // Move to stack pop state to retrieve return address if condition is met
                        end
                        else begin
                            state <= STATE_FETCH; // Return to fetch state if condition is not met
                        end
                    end

                    else if (ir[7:6] == 2'b00 && ir[2:0] == 3'b111 && ir[5] == 1'b1 && ir[4:3] == 2'b00) begin
                        // DAA
                        alu_op <= ALU_DAA; // Identify as DAA instruction
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
                            if (mem_alu_read) begin
                                f[F_Z] <= (mem_alu_data + 1 == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ((mem_alu_data & 4'hF) + 1 > 4'hF); // Set Half Carry flag if there is a carry from bit 3
                                f[F_N] <= 1'b0; // Reset Subtract flag for INC
                                addr <= {h, l}; // Set address to HL for memory write
                                data_out <= mem_alu_data + 1; // Set data to be written with result after flags are set
                                we <= 1'b1; // Enable write 
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                            end
                            else begin
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
                                    default: ; // No operation for invalid destination
                                endcase
                            end
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_DEC: begin
                            // Handle DEC r instruction
                            if (mem_alu_read) begin
                                f[F_Z] <= (mem_alu_data - 1 == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ((mem_alu_data & 4'hF) == 4'h0); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_N] <= 1'b1; // Set Subtract flag for DEC
                                addr <= {h, l}; // Set address to HL for memory write
                                data_out <= mem_alu_data - 1; // Set data to be written with result after flags are set
                                we <= 1'b1; // Enable write 
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                            end
                            else begin
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
                                    default: ; // No operation for invalid destination
                                endcase    
                            end
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_ADD: begin
                            // Handle ADD A, r instruction
                            if(mem_alu_read) begin
                                {f[F_C], a} <= a + mem_alu_data; // Set Carry flag and update Accumulator with result from memory
                                f[F_Z] <= (a + mem_alu_data == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} + {1'b0, mem_alu_data & 4'hF} > 5'h0F); // Set Half Carry flag if there is a carry from bit 3
                                f[F_N] <= 1'b0; // Reset Subtract flag for ADC
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                                state <= STATE_FETCH;
                            end
                            else if (alu_imm) begin
                                {f[F_C], a} <= a + n; // Set Carry flag and update Accumulator with result from immediate value
                                f[F_Z] <= (a + n == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} + {1'b0, n & 4'hF} > 5'h0F); // Set Half Carry flag if there is a carry from bit 3
                                f[F_N] <= 1'b0; // Reset Subtract flag for ADD
                                alu_imm <= 1'b0; // Reset immediate flag after operation
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                            else begin
                                {f[F_C], a} <= a + get_reg(src); // Set Carry flag and update Accumulator with result from register
                                f[F_Z] <= ((a + get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} + {1'b0, get_reg(src) & 4'hF} > 5'h0F); // Set Half Carry flag if there is a carry from bit 3
                                f[F_N] <= 1'b0; // Reset Subtract flag for ADD
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                        end

                        ALU_SUB: begin
                            // Handle SUB A, r instruction
                            if(mem_alu_read) begin
                                {f[F_C], a} <= a - mem_alu_data; // Set Carry flag and update Accumulator with result from memory
                                f[F_Z] <= ((a - mem_alu_data) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, mem_alu_data & 4'hF}); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_N] <= 1'b1; // Set Subtract flag for SUB
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                                state <= STATE_FETCH;
                            end
                            else if (alu_imm) begin
                                {f[F_C], a} <= a - n; // Set Carry flag and update Accumulator with result from immediate value
                                f[F_Z] <= ((a - n) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, n & 4'hF}); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_N] <= 1'b1; // Set Subtract flag for SUB
                                alu_imm <= 1'b0; // Reset immediate flag after operation
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                            else begin
                                {f[F_C], a} <= a - get_reg(src); // Set Carry flag and update Accumulator with result from register
                                f[F_Z] <= ((a - get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, get_reg(src) & 4'hF}); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_N] <= 1'b1; // Set Subtract flag for SUB
                                state <= STATE_FETCH; // Return to fetch state after execution                                
                            end
                        end

                        ALU_AND: begin
                            // Handle AND A, r instruction
                            if(mem_alu_read) begin
                                f[F_Z] <= ((a & mem_alu_data) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b1; // Set Half Carry flag for AND
                                f[F_C] <= 1'b0; // Reset Carry flag for AND
                                f[F_N] <= 1'b0; // Reset Subtract flag for AND
                                a <= a & mem_alu_data; // Update Accumulator with result after flags are set
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                                state <= STATE_FETCH;
                            end
                            else if (alu_imm) begin
                                f[F_Z] <= ((a & n) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b1; // Set Half Carry flag for AND
                                f[F_C] <= 1'b0; // Reset Carry flag for AND
                                f[F_N] <= 1'b0; // Reset Subtract flag for AND
                                a <= a & n; // Update Accumulator with result after flags are set
                                alu_imm <= 1'b0; // Reset immediate flag after operation
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                            else begin
                                f[F_Z] <= ((a & get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b1; // Set Half Carry flag for AND
                                f[F_C] <= 1'b0; // Reset Carry flag for AND
                                f[F_N] <= 1'b0; // Reset Subtract flag for AND
                                a <= a & get_reg(src); // Update Accumulator with result after flags are set
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                        end

                        ALU_XOR: begin
                            // Handle XOR A, r instruction
                            if(mem_alu_read) begin
                                f[F_Z] <= ((a ^ mem_alu_data) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b0; // Reset Half Carry flag for XOR
                                f[F_C] <= 1'b0; // Reset Carry flag for XOR
                                f[F_N] <= 1'b0; // Reset Subtract flag for XOR
                                a <= a ^ mem_alu_data; // Update Accumulator with result after flags are set
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                                state <= STATE_FETCH;
                            end
                            else if (alu_imm) begin
                                f[F_Z] <= ((a ^ n) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b0; // Reset Half Carry flag for XOR
                                f[F_C] <= 1'b0; // Reset Carry flag for XOR
                                f[F_N] <= 1'b0; // Reset Subtract flag for XOR
                                a <= a ^ n; // Update Accumulator with result after flags are set
                                alu_imm <= 1'b0; // Reset immediate flag after operation
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                            else begin
                                f[F_Z] <= ((a ^ get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b0; // Reset Half Carry flag for XOR
                                f[F_C] <= 1'b0; // Reset Carry flag for XOR
                                f[F_N] <= 1'b0; // Reset Subtract flag for XOR
                                a <= a ^ get_reg(src); // Update Accumulator with result after flags are set
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                        end

                        ALU_OR: begin
                            // Handle OR A, r instruction
                            if(mem_alu_read) begin
                                f[F_Z] <= ((a | mem_alu_data) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b0; // Reset Half Carry flag for OR
                                f[F_C] <= 1'b0; // Reset Carry flag for OR
                                f[F_N] <= 1'b0; // Reset Subtract flag for OR
                                a <= a | mem_alu_data; // Update Accumulator with result after flags are set
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                                state <= STATE_FETCH;
                            end
                            else if (alu_imm) begin
                                f[F_Z] <= ((a | n) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b0; // Reset Half Carry flag for OR
                                f[F_C] <= 1'b0; // Reset Carry flag for OR
                                f[F_N] <= 1'b0; // Reset Subtract flag for OR
                                a <= a | n; // Update Accumulator with result after flags are set
                                alu_imm <= 1'b0; // Reset immediate flag after operation
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                            else begin
                                f[F_Z] <= ((a | get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= 1'b0; // Reset Half Carry flag for OR
                                f[F_C] <= 1'b0; // Reset Carry flag for OR
                                f[F_N] <= 1'b0; // Reset Subtract flag for OR
                                a <= a | get_reg(src); // Update Accumulator with result after flags are set
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                        end

                        ALU_CP: begin
                            // Handle CP A, r instruction
                            if(mem_alu_read) begin
                                f[F_Z] <= ((a - mem_alu_data) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, mem_alu_data & 4'hF}); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_C] <= ({1'b0, a} < {1'b0, mem_alu_data}); // Set Carry flag if there is a borrow from bit 7
                                f[F_N] <= 1'b1; // Set Subtract flag for CP
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                                state <= STATE_FETCH;
                            end
                            else if (alu_imm) begin
                                f[F_Z] <= ((a - n) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, n & 4'hF}); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_C] <= ({1'b0, a} < {1'b0, n}); // Set Carry flag if there is a borrow from bit 7
                                f[F_N] <= 1'b1; // Set Subtract flag for CP
                                alu_imm <= 1'b0; // Reset immediate flag after operation
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                            else begin
                                f[F_Z] <= ((a - get_reg(src)) == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, get_reg(src) & 4'hF}); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_C] <= ({1'b0, a} < {1'b0, get_reg(src)}); // Set Carry flag if there is a borrow from bit 7
                                f[F_N] <= 1'b1; // Set Subtract flag for CP
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
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
                                    f <= ret_addr[7:0] & 8'hF0; // Ensure lower nibble of F is always 0
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

                        ALU_ADC: begin
                            // Handle ADC A, r instruction
                            if(mem_alu_read) begin
                                {f[F_C], a} <= a + mem_alu_data + f[F_C]; // Add with carry from memory
                                f[F_Z] <= (a + mem_alu_data + f[F_C] == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} + {1'b0, mem_alu_data & 4'hF} + f[F_C] > 5'h0F); // Set Half Carry flag if there is a carry from bit 3
                                f[F_N] <= 1'b0; // Reset Subtract flag for ADC
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                                state <= STATE_FETCH;
                            end
                            else if (alu_imm) begin
                                {f[F_C], a} <= a + n + f[F_C]; // Add with carry from immediate value
                                f[F_Z] <= (a + n + f[F_C] == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} + {1'b0, n & 4'hF} + f[F_C] > 5'h0F); // Set Half Carry flag if there is a carry from bit 3
                                f[F_N] <= 1'b0; // Reset Subtract flag for ADC
                                alu_imm <= 1'b0; // Reset immediate flag after operation
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                            else begin
                                {f[F_C], a} <= a + get_reg(src) + f[F_C]; // Add with carry
                                f[F_Z] <= (a + get_reg(src) + f[F_C] == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} + {1'b0, get_reg(src) & 4'hF} + f[F_C] > 5'h0F); // Set Half Carry flag if there is a carry from bit 3
                                f[F_N] <= 1'b0; // Reset Subtract flag for ADC
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end      
                        end

                        ALU_SBC: begin
                            // Handle SBC A, r instruction
                            if(mem_alu_read) begin
                                {f[F_C], a} <= a - mem_alu_data - f[F_C]; // Subtract with borrow from memory
                                f[F_Z] <= (a - mem_alu_data - f[F_C] == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, mem_alu_data & 4'hF} + f[F_C]); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_N] <= 1'b1; // Set Subtract flag for SBC
                                mem_alu_read <= 1'b0; // Reset memory read flag after operation
                                mem_alu_data <= 8'h00; // Clear memory ALU data after operation
                                state <= STATE_FETCH;
                            end
                            else if (alu_imm) begin
                                {f[F_C], a} <= a - n - f[F_C]; // Subtract with borrow from immediate value
                                f[F_Z] <= (a - n - f[F_C] == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, n & 4'hF} + f[F_C]); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_N] <= 1'b1; // Set Subtract flag for SBC
                                alu_imm <= 1'b0; // Reset immediate flag after operation
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                            else begin
                                {f[F_C], a} <= a - get_reg(src) - f[F_C]; // Subtract with borrow
                                f[F_Z] <= (a - get_reg(src) - f[F_C] == 8'h00); // Set Zero flag if result is zero
                                f[F_H] <= ({1'b0, a & 4'hF} < {1'b0, get_reg(src) & 4'hF} + f[F_C]); // Set Half Carry flag if there is a borrow from bit 4
                                f[F_N] <= 1'b1; // Set Subtract flag for SBC
                                state <= STATE_FETCH; // Return to fetch state after execution
                            end
                        end

                        ALU_LD_SP_HL: begin
                            // Handle LD SP, HL instruction
                            sp <= {h, l}; // Load Stack Pointer into HL
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_LD_RR_IMM: begin
                            // Handle LD rr, nn instruction
                            case (rp_sel)
                                2'b00: {b, c} <= nn; // Load immediate 16-bit value into BC
                                2'b01: {d, e} <= nn; // Load immediate 16-bit value into DE
                                2'b10: {h, l} <= nn; // Load immediate 16-bit value into HL
                                default: ; // No operation for invalid register pair selection
                            endcase
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_INC_RR: begin
                            // Handle INC rr instruction
                            case (rp_sel)
                                2'b00: {b, c} <= {b, c} + 1; // Increment BC
                                2'b01: {d, e} <= {d, e} + 1; // Increment DE
                                2'b10: {h, l} <= {h, l} + 1; // Increment HL
                                2'b11: sp <= sp + 1; // Increment SP
                                default: ; // No operation for invalid register pair selection
                            endcase
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_DEC_RR: begin
                            // Handle DEC rr instruction
                            case (rp_sel)
                                2'b00: {b, c} <= {b, c} - 1; // Decrement BC
                                2'b01: {d, e} <= {d, e} - 1; // Decrement DE
                                2'b10: {h, l} <= {h, l} - 1; // Decrement HL
                                2'b11: sp <= sp - 1; // Decrement SP
                                default: ; // No operation for invalid register pair selection
                            endcase
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_ADD_HL_RR: begin
                            // Handle ADD HL, rr instruction
                            f[F_N] <= 1'b0; // Reset Subtract flag for ADD
                            f[F_H] <= (({1'b0, h, l} & 16'h0FFF) + ({1'b0, get_rp(rp_sel)} & 16'h0FFF) > 16'h0FFF); // Set Half Carry flag if there is a carry from bit 11
                            {f[F_C], h, l} <= {1'b0, h, l} + {1'b0, get_rp(rp_sel)}; // Set Carry flag and update HL with result
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_LD_HL_SP_E8: begin
                            // Handle LD HL, SP+e8 instruction
                            f[F_Z] <= 1'b0; // Reset Zero flag for this operation
                            f[F_N] <= 1'b0; // Reset Subtract flag for this operation
                            f[F_H] <= (({1'b0, sp[3:0]} + {1'b0, n[3:0]}) > 5'h0F); // Set Half Carry flag if there is a carry from bit 3
                            f[F_C] <= (({1'b0, sp[7:0]} + {1'b0, n}) > 9'h0FF); // Set Carry flag if there is a carry from bit 7
                            {h, l} <= sp + {{8{n[7]}}, n}; // Update HL with result of SP + signed immediate value
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_RLCA: begin
                            // Handle RLCA instruction
                            f[F_C] <= a[7]; // Set Carry flag to the value of bit 7 of A
                            a <= {a[6:0], a[7]}; // Rotate A left, with bit 7 moving to bit 0
                            f[F_Z] <= 1'b0; // Reset Zero flag for this operation
                            f[F_N] <= 1'b0; // Reset Subtract flag for this operation
                            f[F_H] <= 1'b0; // Reset Half Carry flag for this operation
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_RRCA: begin
                            // Handle RRCA instruction
                            f[F_C] <= a[0]; // Set Carry flag to the value of bit 0 of A
                            a <= {a[0], a[7:1]}; // Rotate A right, with bit 0 moving to bit 7
                            f[F_Z] <= 1'b0; // Reset Zero flag for this operation
                            f[F_N] <= 1'b0; // Reset Subtract flag for this operation
                            f[F_H] <= 1'b0; // Reset Half Carry flag for this operation
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_RLA: begin
                            // Handle RLA instruction
                            {f[F_C], a} <= {a[7], a[6:0]} + f[F_C]; // Rotate A left through Carry flag
                            f[F_Z] <= 1'b0; // Reset Zero flag for this operation
                            f[F_N] <= 1'b0; // Reset Subtract flag for this operation
                            f[F_H] <= 1'b0; // Reset Half Carry flag for this operation
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_RRA: begin
                            // Handle RRA instruction
                            {f[F_C], a} <= {f[F_C], a[7:1]}; // Rotate A right through Carry flag
                            f[F_Z] <= 1'b0; // Reset Zero flag for this operation
                            f[F_N] <= 1'b0; // Reset Subtract flag for this operation
                            f[F_H] <= 1'b0; // Reset Half Carry flag for this operation
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_CPL: begin
                            // Handle CPL instruction
                            a <= ~a; // Complement A
                            f[F_N] <= 1'b1; // Set Subtract flag for CPL
                            f[F_H] <= 1'b1; // Set Half Carry flag for CPL
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_SCF: begin
                            // Handle SCF instruction
                            f[F_C] <= 1'b1; // Set Carry flag
                            f[F_N] <= 1'b0; // Reset Subtract flag
                            f[F_H] <= 1'b0; // Reset Half Carry flag
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_CCF: begin
                            // Handle CCF instruction
                            f[F_C] <= ~f[F_C]; // Complement Carry flag
                            f[F_N] <= 1'b0; // Reset Subtract flag
                            f[F_H] <= 1'b0; // Reset Half Carry flag
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_RST: begin
                            // Handle RST instruction
                            pc <= iv_addr; // Set PC to the interrupt vector address
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_RET_CC: begin
                            // Handle RET cc instruction
                            pc <= ret_addr; // Set PC to the return address popped from the stack
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_ADD_SP_E8: begin
                            // Handle ADD SP, e8 instruction
                            f[F_Z] <= 1'b0; // Reset Zero flag for this operation
                            f[F_N] <= 1'b0; // Reset Subtract flag for this operation
                            f[F_H] <= (({1'b0, sp[3:0]} + {1'b0, n[3:0]}) > 5'h0F); // Set Half Carry flag if there is a carry from bit 3
                            f[F_C] <= (({1'b0, sp[7:0]} + {1'b0, n}) > 9'h0FF); // Set Carry flag if there is a carry from bit 7
                            sp <= sp + {{8{n[7]}}, n}; // Update SP with result of SP + signed immediate value
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_STOP: begin
                            // PLACEHOLDER
                            state <= STATE_HALT; // Transition to HALT state
                        end

                        ALU_DAA: begin
                            // Handle DAA instruction
                            correction = 8'h00;
                            new_c = f[F_C];

                            // Determine the correction value based on the current flags and accumulator value
                            if (f[F_H] || (!f[F_N] && (a[3:0] > 4'h9))) begin
                                correction = correction + 8'h06;
                            end
                            if (f[F_C] || (!f[F_N] && (a > 8'h99))) begin
                                correction = correction + 8'h60;
                                new_c = 1'b1; // Set Carry flag if correction is applied
                            end

                            if (f[F_N]) begin
                                new_a = a - correction; // Subtract correction if previous operation was subtraction
                            end else begin
                                new_a = a + correction; // Add correction if previous operation was addition
                            end

                            a <= new_a; // Update Accumulator with corrected value
                            f[F_Z] <= (new_a == 8'h00); // Set Zero flag if result is zero
                            f[F_H] <= 1'b0; // Reset Half Carry flag after DAA operation
                            f[F_C] <= new_c; // Update Carry flag based on correction
                            state <= STATE_FETCH; // Return to fetch state after execution
                        end

                        ALU_CB_ROT: begin
                            case (cb_ir[5:3])
                                3'b000: begin 
                                    // RLC
                                    f[F_C] <= cb_operand[7];
                                    f[F_Z] <= ({cb_operand[6:0], cb_operand[7]} == 8'h00);
                                    f[F_N] <= 1'b0;
                                    f[F_H] <= 1'b0;
                                    if (mem_alu_read) begin
                                        addr <= {h, l};
                                        data_out <= {cb_operand[6:0], cb_operand[7]};
                                        we <= 1'b1;
                                    end else begin
                                        case (dst)
                                            REG_B: b <= {cb_operand[6:0], cb_operand[7]};
                                            REG_C: c <= {cb_operand[6:0], cb_operand[7]};
                                            REG_D: d <= {cb_operand[6:0], cb_operand[7]};
                                            REG_E: e <= {cb_operand[6:0], cb_operand[7]};
                                            REG_H: h <= {cb_operand[6:0], cb_operand[7]};
                                            REG_L: l <= {cb_operand[6:0], cb_operand[7]};
                                            REG_A: a <= {cb_operand[6:0], cb_operand[7]};
                                            default: ;
                                        endcase
                                    end
                                end
                                3'b001: begin 
                                    // RRC
                                    f[F_C] <= cb_operand[0];
                                    f[F_Z] <= ({cb_operand[0], cb_operand[7:1]} == 8'h00);
                                    f[F_N] <= 1'b0;
                                    f[F_H] <= 1'b0;
                                    if (mem_alu_read) begin
                                        addr <= {h, l};
                                        data_out <= {cb_operand[0], cb_operand[7:1]};
                                        we <= 1'b1;
                                    end else begin
                                        case (dst)
                                            REG_B: b <= {cb_operand[0], cb_operand[7:1]};
                                            REG_C: c <= {cb_operand[0], cb_operand[7:1]};
                                            REG_D: d <= {cb_operand[0], cb_operand[7:1]};
                                            REG_E: e <= {cb_operand[0], cb_operand[7:1]};
                                            REG_H: h <= {cb_operand[0], cb_operand[7:1]};
                                            REG_L: l <= {cb_operand[0], cb_operand[7:1]};
                                            REG_A: a <= {cb_operand[0], cb_operand[7:1]};
                                            default: ;
                                        endcase
                                    end
                                end
                                3'b010: begin 
                                    // RL
                                    f[F_C] <= cb_operand[7];
                                    f[F_Z] <= ({cb_operand[6:0], f[F_C]} == 8'h00);
                                    f[F_N] <= 1'b0;
                                    f[F_H] <= 1'b0;
                                    if (mem_alu_read) begin
                                        addr <= {h, l};
                                        data_out <= {cb_operand[6:0], f[F_C]};
                                        we <= 1'b1;
                                    end else begin
                                        case (dst)
                                            REG_B: b <= {cb_operand[6:0], f[F_C]};
                                            REG_C: c <= {cb_operand[6:0], f[F_C]};
                                            REG_D: d <= {cb_operand[6:0], f[F_C]};
                                            REG_E: e <= {cb_operand[6:0], f[F_C]};
                                            REG_H: h <= {cb_operand[6:0], f[F_C]};
                                            REG_L: l <= {cb_operand[6:0], f[F_C]};
                                            REG_A: a <= {cb_operand[6:0], f[F_C]};
                                            default: ;
                                        endcase
                                    end
                                end
                                3'b011: begin 
                                    // RR
                                    f[F_C] <= cb_operand[0];
                                    f[F_Z] <= ({f[F_C], cb_operand[7:1]} == 8'h00);
                                    f[F_N] <= 1'b0;
                                    f[F_H] <= 1'b0;
                                    if (mem_alu_read) begin
                                        addr <= {h, l};
                                        data_out <= {f[F_C], cb_operand[7:1]};
                                        we <= 1'b1;
                                    end else begin
                                        case (dst)
                                            REG_B: b <= {f[F_C], cb_operand[7:1]};
                                            REG_C: c <= {f[F_C], cb_operand[7:1]};
                                            REG_D: d <= {f[F_C], cb_operand[7:1]};
                                            REG_E: e <= {f[F_C], cb_operand[7:1]};
                                            REG_H: h <= {f[F_C], cb_operand[7:1]};
                                            REG_L: l <= {f[F_C], cb_operand[7:1]};
                                            REG_A: a <= {f[F_C], cb_operand[7:1]};
                                            default: ;
                                        endcase
                                    end
                                end
                                3'b100: begin 
                                    // SLA
                                    f[F_C] <= cb_operand[7];
                                    f[F_Z] <= ({cb_operand[6:0], 1'b0} == 8'h00);
                                    f[F_N] <= 1'b0;
                                    f[F_H] <= 1'b0;
                                    if (mem_alu_read) begin
                                        addr <= {h, l};
                                        data_out <= {cb_operand[6:0], 1'b0};
                                        we <= 1'b1;
                                    end else begin
                                        case (dst)
                                            REG_B: b <= {cb_operand[6:0], 1'b0};
                                            REG_C: c <= {cb_operand[6:0], 1'b0};
                                            REG_D: d <= {cb_operand[6:0], 1'b0};
                                            REG_E: e <= {cb_operand[6:0], 1'b0};
                                            REG_H: h <= {cb_operand[6:0], 1'b0};
                                            REG_L: l <= {cb_operand[6:0], 1'b0};
                                            REG_A: a <= {cb_operand[6:0], 1'b0};
                                            default: ;
                                        endcase
                                    end
                                end
                                3'b101: begin 
                                    // SRA 
                                    f[F_C] <= cb_operand[0];
                                    f[F_Z] <= ({cb_operand[7], cb_operand[7:1]} == 8'h00);
                                    f[F_N] <= 1'b0;
                                    f[F_H] <= 1'b0;
                                    if (mem_alu_read) begin
                                        addr <= {h, l};
                                        data_out <= {cb_operand[7], cb_operand[7:1]};
                                        we <= 1'b1;
                                    end else begin
                                        case (dst)
                                            REG_B: b <= {cb_operand[7], cb_operand[7:1]};
                                            REG_C: c <= {cb_operand[7], cb_operand[7:1]};
                                            REG_D: d <= {cb_operand[7], cb_operand[7:1]};
                                            REG_E: e <= {cb_operand[7], cb_operand[7:1]};
                                            REG_H: h <= {cb_operand[7], cb_operand[7:1]};
                                            REG_L: l <= {cb_operand[7], cb_operand[7:1]};
                                            REG_A: a <= {cb_operand[7], cb_operand[7:1]};
                                            default: ;
                                        endcase
                                    end
                                end
                                3'b110: begin 
                                    // SWAP
                                    f[F_C] <= 1'b0;
                                    f[F_Z] <= ({cb_operand[3:0], cb_operand[7:4]} == 8'h00);
                                    f[F_N] <= 1'b0;
                                    f[F_H] <= 1'b0;
                                    if (mem_alu_read) begin
                                        addr <= {h, l};
                                        data_out <= {cb_operand[3:0], cb_operand[7:4]};
                                        we <= 1'b1;
                                    end else begin
                                        case (dst)
                                            REG_B: b <= {cb_operand[3:0], cb_operand[7:4]};
                                            REG_C: c <= {cb_operand[3:0], cb_operand[7:4]};
                                            REG_D: d <= {cb_operand[3:0], cb_operand[7:4]};
                                            REG_E: e <= {cb_operand[3:0], cb_operand[7:4]};
                                            REG_H: h <= {cb_operand[3:0], cb_operand[7:4]};
                                            REG_L: l <= {cb_operand[3:0], cb_operand[7:4]};
                                            REG_A: a <= {cb_operand[3:0], cb_operand[7:4]};
                                            default: ;
                                        endcase
                                    end
                                end
                                3'b111: begin 
                                    // SRL
                                    f[F_C] <= cb_operand[0];
                                    f[F_Z] <= ({1'b0, cb_operand[7:1]} == 8'h00);
                                    f[F_N] <= 1'b0;
                                    f[F_H] <= 1'b0;
                                    if (mem_alu_read) begin
                                        addr <= {h, l};
                                        data_out <= {1'b0, cb_operand[7:1]};
                                        we <= 1'b1;
                                    end else begin
                                        case (dst)
                                            REG_B: b <= {1'b0, cb_operand[7:1]};
                                            REG_C: c <= {1'b0, cb_operand[7:1]};
                                            REG_D: d <= {1'b0, cb_operand[7:1]};
                                            REG_E: e <= {1'b0, cb_operand[7:1]};
                                            REG_H: h <= {1'b0, cb_operand[7:1]};
                                            REG_L: l <= {1'b0, cb_operand[7:1]};
                                            REG_A: a <= {1'b0, cb_operand[7:1]};
                                            default: ;
                                        endcase
                                    end
                                end
                            endcase
                            if (mem_alu_read) begin
                                mem_alu_read <= 1'b0;
                                mem_alu_data <= 16'h0000;
                            end
                            state <= STATE_FETCH;
                        end

                        ALU_CB_BIT: begin
                            // BIT b, r
                            f[F_Z] <= (cb_operand[cb_ir[5:3]] == 1'b0);
                            f[F_N] <= 1'b0;
                            f[F_H] <= 1'b1;
                            if (mem_alu_read) begin
                                mem_alu_read <= 1'b0;
                                mem_alu_data <= 16'h0000;
                            end
                            state <= STATE_FETCH;
                        end

                        ALU_CB_RES: begin
                            // RES b, r
                            if (mem_alu_read) begin
                                addr <= {h, l};
                                data_out <= cb_operand & ~(8'h01 << cb_ir[5:3]);
                                we <= 1'b1;
                                mem_alu_read <= 1'b0;
                                mem_alu_data <= 16'h0000;
                            end else begin
                                case (dst)
                                    REG_B: b <= cb_operand & ~(8'h01 << cb_ir[5:3]);
                                    REG_C: c <= cb_operand & ~(8'h01 << cb_ir[5:3]);
                                    REG_D: d <= cb_operand & ~(8'h01 << cb_ir[5:3]);
                                    REG_E: e <= cb_operand & ~(8'h01 << cb_ir[5:3]);
                                    REG_H: h <= cb_operand & ~(8'h01 << cb_ir[5:3]);
                                    REG_L: l <= cb_operand & ~(8'h01 << cb_ir[5:3]);
                                    REG_A: a <= cb_operand & ~(8'h01 << cb_ir[5:3]);
                                    default: ;
                                endcase
                            end
                            state <= STATE_FETCH;
                        end

                        ALU_CB_SET: begin
                            // SET b, r
                            if (mem_alu_read) begin
                                addr <= {h, l};
                                data_out <= cb_operand | (8'h01 << cb_ir[5:3]);
                                we <= 1'b1;
                                mem_alu_read <= 1'b0;
                                mem_alu_data <= 16'h0000;
                            end else begin
                                case (dst)
                                    REG_B: b <= cb_operand | (8'h01 << cb_ir[5:3]);
                                    REG_C: c <= cb_operand | (8'h01 << cb_ir[5:3]);
                                    REG_D: d <= cb_operand | (8'h01 << cb_ir[5:3]);
                                    REG_E: e <= cb_operand | (8'h01 << cb_ir[5:3]);
                                    REG_H: h <= cb_operand | (8'h01 << cb_ir[5:3]);
                                    REG_L: l <= cb_operand | (8'h01 << cb_ir[5:3]);
                                    REG_A: a <= cb_operand | (8'h01 << cb_ir[5:3]);
                                    default: ;
                                endcase
                            end
                            state <= STATE_FETCH;
                        end


                        default: state <= STATE_FETCH; // For unimplemented ALU operations, return to fetch
                
                    endcase

                    if(ime_pending) begin
                        ime <= 1'b1;
                        ime_pending <= 1'b0;
                    end  
                end
                
                // Handle stack operations
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

                // Handle popping a 16-bit value from the stack
                STATE_STACK_POP: begin
                    // Handle popping a 16-bit value from the stack
                    if (!second_stack_fetch) begin
                        if(!fetch_ready) begin
                            addr <= sp; // Set address to SP
                            we <= 1'b0; // Read operation
                            fetch_ready <= 1'b1; // Indicate fetch is ready
                        end
                        else if (!mem_wait) begin
                            mem_wait <= 1'b1; // Indicate that we are waiting for memory read to complete
                        end
                        else begin
                            ret_addr[7:0] <= data_in; // Read low byte
                            sp <= sp + 1; // Increment SP by 1 after popping low byte
                            fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                            mem_wait <= 1'b0; // Reset memory wait for next cycle
                            second_stack_fetch <= 1'b1;
                        end
                    end
                    else begin
                        if(!fetch_ready) begin
                            addr <= sp; // Set address to SP
                            we <= 1'b0; // Read operation
                            fetch_ready <= 1'b1; // Indicate fetch is ready
                        end
                        else if (!mem_wait) begin
                            mem_wait <= 1'b1; // Indicate that we are waiting for memory read to complete
                        end
                        else begin
                            ret_addr[15:8] <= data_in; // Read high byte
                            sp <= sp + 1; // Increment SP by 1 after popping high byte
                            fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                            mem_wait <= 1'b0; // Reset memory wait for next cycle
                            second_stack_fetch <= 1'b0; // Reset for next pop
                            state <= STATE_EXECUTE;
                        end
                    end
                end

                // Handle HALT state
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
                    else if (!mem_wait) begin
                        mem_wait <= 1'b1; // Indicate that we are waiting for memory read to complete
                    end
                    else begin
                        mem_wait <= 1'b0;        // Reset memory wait for next cycle
                        if (!mem_alu_read) begin
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
                        else begin
                            // If we are reading from memory for an ALU operation, store the data in a temporary register
                            mem_alu_data <= data_in;
                            fetch_ready <= 1'b0;
                            state <= STATE_EXECUTE;
                        end
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
                        if (mem_write_sp && !sp_write_low_done) begin
                            sp_write_low_done <= 1'b1; // Indicate that we have written the low byte of SP to memory
                            mem_addr <= mem_addr + 1; // Increment memory address to write the high byte of SP
                            mem_data <= sp[15:8]; // Set data to be written from SP high byte
                            state <= STATE_MEM_WRITE; // Stay in memory write state to write the high byte
                        end
                        else begin
                            mem_write_sp <= 1'b0; // Reset mem_write_sp flag after writing both bytes of SP to memory
                            sp_write_low_done <= 1'b0; // Reset sp_write_low_done flag for next operation
                            state <= STATE_FETCH;
                        end
                    end
                end

                STATE_FETCH_CB: begin
                    if(!fetch_ready) begin
                        addr <= pc;
                        we <= 1'b0;
                        fetch_ready <= 1'b1;
                    end
                    else if (!mem_wait) begin
                        mem_wait <= 1'b1;
                    end
                    else begin
                        cb_ir <= data_in; // Store the fetched CB instruction
                        pc <= pc + 1; // Increment PC after fetching the instruction
                        fetch_ready <= 1'b0; // Reset fetch ready for next cycle
                        mem_wait <= 1'b0; // Reset memory wait for next cycle
                        state <= STATE_CB_DECODE; // Transition to CB decode state
                    end
                end

                STATE_CB_DECODE: begin
                    dst <= cb_ir[2:0]; // Extract destination register from CB instruction
                    src <= cb_ir[2:0]; // Extract source register from CB instruction
                    case (cb_ir[7:6])
                        2'b00: alu_op <= ALU_CB_ROT; // Rotate/Shift operations
                        2'b01: alu_op <= ALU_CB_BIT; // Bit test operations
                        2'b10: alu_op <= ALU_CB_RES; // Bit reset operations
                        2'b11: alu_op <= ALU_CB_SET; // Bit set operations
                    endcase
                    if (cb_ir[2:0] == 3'b110) begin
                        // If the destination is (HL), we need to read from memory first
                        mem_addr <= {h, l}; // Set memory address to HL
                        mem_alu_read <= 1'b1; // Indicate that we are reading from memory for ALU operation
                        state <= STATE_MEM_READ; // Transition to memory read state
                    end
                    else begin
                        state <= STATE_EXECUTE; // Transition to execute state for register operations
                    end
                end

                default: begin
                    state <= STATE_FETCH;
                end

            endcase
        end
    end

endmodule