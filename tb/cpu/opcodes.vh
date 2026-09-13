// =============================================================================
// File         : tb/cpu/opcodes.vh
// Description  : Opcode + register-ID macros for every instruction currently
//                decoded in cpu.v. `include this at the top of tb_cpu.v.
//                Function-like macros (e.g. `OP_ADD_A(REG_C)) build the
//                opcode the same way cpu.v's decoder reads it, so this file
//                doubles as a reference for the bit-field encoding.
// =============================================================================

// --- Register IDs (must match REG_* localparams in cpu.v) ---
`define REG_B  3'd0
`define REG_C  3'd1
`define REG_D  3'd2
`define REG_E  3'd3
`define REG_H  3'd4
`define REG_L  3'd5
`define REG_HL 3'd6   // (HL) memory operand
`define REG_A  3'd7

// --- Flag bit positions (must match F_Z/F_N/F_H/F_C in cpu.v) ---
`define F_Z 7
`define F_N 6
`define F_H 5
`define F_C 4

// --- CPU state encoding used by the testbench's sync task ---
`define ST_FETCH 4'd0

// --- ir[7:6]==01 block: LD r, r' / LD r, (HL) / LD (HL), r ---
// NOTE: OP_LD(REG_HL, REG_HL) is NOT LD (HL),(HL) -- that encoding is HALT.
`define OP_LD(dst, src)  (8'h40 | ((dst) << 3) | (src))

// --- ir[7:6]==00, ir[2:0]==110: LD r, n8 / LD (HL), n8 ---
`define OP_LD_N8(dst)    (8'h06 | ((dst) << 3))

// --- ir[7:6]==00, ir[2:0]==100/101: INC r / DEC r (INC/DEC (HL) still stubbed in cpu.v) ---
`define OP_INC(dst)      (8'h04 | ((dst) << 3))
`define OP_DEC(dst)      (8'h05 | ((dst) << 3))

// --- ir[7:6]==10 block: the eight register-indexed ALU ops (src may be REG_HL) ---
`define OP_ADD_A(src)    (8'h80 | (src))
`define OP_ADC_A(src)    (8'h88 | (src))
`define OP_SUB_A(src)    (8'h90 | (src))
`define OP_SBC_A(src)    (8'h98 | (src))
`define OP_AND_A(src)    (8'hA0 | (src))
`define OP_XOR_A(src)    (8'hA8 | (src))
`define OP_OR_A(src)     (8'hB0 | (src))
`define OP_CP_A(src)     (8'hB8 | (src))

// --- Fixed single-purpose opcodes ---
`define OP_NOP        8'h00
`define OP_HALT       8'h76
`define OP_DI         8'hF3
`define OP_EI         8'hFB
`define OP_RETI       8'hD9
`define OP_RET        8'hC9
`define OP_CALL_NN    8'hCD
`define OP_JP_NN      8'hC3
`define OP_JR_N       8'h18
`define OP_JR_NZ      8'h20
`define OP_JR_Z       8'h28
`define OP_JR_NC      8'h30
`define OP_JR_C       8'h38
`define OP_JP_NZ_NN   8'hC2
`define OP_JP_Z_NN    8'hCA
`define OP_JP_NC_NN   8'hD2
`define OP_JP_C_NN    8'hDA
`define OP_LD_SP_NN   8'h31
`define OP_LD_A_NN    8'hFA
`define OP_LD_NN_A    8'hEA
`define OP_LDH_A_N    8'hF0
`define OP_LDH_N_A    8'hE0
`define OP_PUSH_BC    8'hC5
`define OP_PUSH_DE    8'hD5
`define OP_PUSH_HL    8'hE5
`define OP_PUSH_AF    8'hF5
`define OP_POP_BC     8'hC1
`define OP_POP_DE     8'hD1
`define OP_POP_HL     8'hE1
`define OP_POP_AF     8'hF1
`define OP_LD_BC_A    8'h02
`define OP_LD_DE_A    8'h12
`define OP_LD_HLI_A   8'h22
`define OP_LD_HLD_A   8'h32
`define OP_LD_A_BC    8'h0A
`define OP_LD_A_DE    8'h1A
`define OP_LD_A_HLI   8'h2A
`define OP_LD_A_HLD   8'h3A