// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_cpu.v
// Description  : Self-checking testbench for the full SM83 CPU core as
//                implemented so far. After each instruction, waits for the
//                CPU to fully return to STATE_FETCH before checking
//                register/flag values, so checks never race the DUT's own
//                pipeline (register-form vs. [HL]-form instructions take a
//                different number of cycles).
// =============================================================================
`timescale 1ns / 1ps
`include "opcodes.vh"

module tb_cpu;

    reg clk;
    reg rst;
    reg [7:0] data_in;
    wire we;
    wire [15:0] addr;
    wire [7:0] data_out;
    wire [7:0] ie;
    wire [7:0] if_reg;
    wire [7:0] if_clear;
    wire if_clear_we;

    cpu uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .we(we),
        .addr(addr),
        .data_out(data_out),
        .ie(ie),
        .if_reg(if_reg),
        .if_clear(if_clear),
        .if_clear_we(if_clear_we)
    );

    reg [7:0] ram [0:65535];

    integer pass_count = 0;
    integer fail_count = 0;

    task wait_for_next_fetch;
        begin
            @(posedge clk);
            while (uut.state == `ST_FETCH) @(posedge clk);
            while (uut.state != `ST_FETCH) @(posedge clk);
            @(posedge clk); // let the final nonblocking write settle
        end
    endtask

    task check_a(input [7:0] expected, input [127:0] label);
        begin
            if (uut.a === expected) begin
                pass_count = pass_count + 1;
                $display("PASS [%0t] %0s : A=%h (expected %h)", $time, label, uut.a, expected);
            end
            else begin
                fail_count = fail_count + 1;
                $display("FAIL [%0t] %0s : A=%h (expected %h)", $time, label, uut.a, expected);
            end
        end
    endtask

    task check_flags(input z, input n, input h, input c, input [127:0] label);
        begin
            if (uut.f[`F_Z] === z && uut.f[`F_N] === n && uut.f[`F_H] === h && uut.f[`F_C] === c) begin
                pass_count = pass_count + 1;
                $display("PASS [%0t] %0s : flags ZNHC=%b%b%b%b", $time, label,
                          uut.f[`F_Z], uut.f[`F_N], uut.f[`F_H], uut.f[`F_C]);
            end
            else begin
                fail_count = fail_count + 1;
                $display("FAIL [%0t] %0s : flags ZNHC=%b%b%b%b (expected %b%b%b%b)", $time, label,
                          uut.f[`F_Z], uut.f[`F_N], uut.f[`F_H], uut.f[`F_C], z, n, h, c);
            end
        end
    endtask

    initial begin
        // --- Section A: LD (HLI)/(HLD), A round trip (your original test) ---
        ram[0]  = `OP_LD_N8(`REG_H); ram[1]  = 8'hC0;
        ram[2]  = `OP_LD_N8(`REG_L); ram[3]  = 8'h20;          // HL = 0xC020
        ram[4]  = `OP_LD_N8(`REG_A); ram[5]  = 8'h11;
        ram[6]  = `OP_LD_HLI_A;                                // [C020]=0x11, HL=C021
        ram[7]  = `OP_LD_N8(`REG_A); ram[8]  = 8'h22;
        ram[9]  = `OP_LD_HLI_A;                                // [C021]=0x22, HL=C022
        ram[10] = `OP_LD_N8(`REG_A); ram[11] = 8'h00;
        ram[12] = `OP_LD_A_HLD;                                // reads [C022] (uninit), HL=C021
        ram[13] = `OP_LD_A_HLD;                                // reads [C021]=0x22, HL=C020
        ram[14] = `OP_LD_A_HLD;                                // reads [C020]=0x11, HL=C01F

        // --- Section B: ADC/SBC, register and [HL] forms ---
        ram[15] = `OP_LD_N8(`REG_B); ram[16] = 8'hFF;
        ram[17] = `OP_LD_N8(`REG_A); ram[18] = 8'h02;
        ram[19] = `OP_ADD_A(`REG_B);                           // A=0x01, forces C=1
        ram[20] = `OP_LD_N8(`REG_C); ram[21] = 8'h01;
        ram[22] = `OP_ADC_A(`REG_C);                           // A=0x01+0x01+1=0x03, C=0
        ram[23] = `OP_LD_N8(`REG_H); ram[24] = 8'hC0;
        ram[25] = `OP_LD_N8(`REG_L); ram[26] = 8'h50;          // HL=0xC050
        ram[16'hC050] = 8'h05;                                 // preload [HL] directly
        ram[27] = `OP_ADC_A(`REG_HL);                          // A=0x03+0x05+0=0x08
        ram[28] = `OP_AND_A(`REG_HL);                          // A=0x08&0x05=0x00, Z=1
        ram[29] = `OP_LD_N8(`REG_C); ram[30] = 8'h02;
        ram[31] = `OP_ADC_A(`REG_C);                           // mem_alu_read leak check: A=0x02
        ram[32] = `OP_LD_N8(`REG_D); ram[33] = 8'h05;
        ram[34] = `OP_SUB_A(`REG_D);                           // A=0x02-0x05=0xFD, forces borrow
        ram[35] = `OP_LD_N8(`REG_B); ram[36] = 8'h01;
        ram[37] = `OP_SBC_A(`REG_B);                           // A=0xFD-0x01-1=0xFB
        ram[38] = `OP_SBC_A(`REG_HL);                          // A=0xFB-0x05-0=0xF6

        ram[39] = `OP_JP_NN; ram[40] = 8'h27; ram[41] = 8'h00; // JP to itself, park
    end

    initial begin
        $dumpfile("sim/waves/tb_cpu.vcd");
        $dumpvars(0, tb_cpu);

        clk = 0;
        rst = 1;
        data_in = 8'h00;
        #20 rst = 0;

        // --- Section A ---
        wait_for_next_fetch(); // LD H,n8
        wait_for_next_fetch(); // LD L,n8
        wait_for_next_fetch(); // LD A,n8 (0x11)
        wait_for_next_fetch(); // LD (HLI),A
        wait_for_next_fetch(); // LD A,n8 (0x22)
        wait_for_next_fetch(); // LD (HLI),A
        wait_for_next_fetch(); // LD A,n8 (0x00)
        wait_for_next_fetch(); // LD A,(HLD) -- uninitialized read, no check
        wait_for_next_fetch(); // LD A,(HLD)
        check_a(8'h22, "LD A,(HLD) #2");
        wait_for_next_fetch(); // LD A,(HLD)
        check_a(8'h11, "LD A,(HLD) #3");

        // --- Section B ---
        wait_for_next_fetch(); // LD B,n8
        wait_for_next_fetch(); // LD A,n8
        wait_for_next_fetch(); // ADD A,B
        check_a(8'h01, "ADD A,B");
        check_flags(1'b0, 1'b0, 1'b1, 1'b1, "ADD A,B flags");

        wait_for_next_fetch(); // LD C,n8
        wait_for_next_fetch(); // ADC A,C
        check_a(8'h03, "ADC A,C (carry-in=1)");
        check_flags(1'b0, 1'b0, 1'b0, 1'b0, "ADC A,C flags");

        wait_for_next_fetch(); // LD H,n8
        wait_for_next_fetch(); // LD L,n8
        wait_for_next_fetch(); // ADC A,(HL)
        check_a(8'h08, "ADC A,(HL) (carry-in=0)");

        wait_for_next_fetch(); // AND A,(HL)
        check_a(8'h00, "AND A,(HL)");
        check_flags(1'b1, 1'b0, 1'b1, 1'b0, "AND A,(HL) flags");

        wait_for_next_fetch(); // LD C,n8
        wait_for_next_fetch(); // ADC A,C (leak regression check)
        check_a(8'h02, "ADC A,C after [HL] op (mem_alu_read leak check)");

        wait_for_next_fetch(); // LD D,n8
        wait_for_next_fetch(); // SUB A,D
        check_a(8'hFD, "SUB A,D (forces borrow)");
        check_flags(1'b0, 1'b1, 1'b1, 1'b1, "SUB A,D flags");

        wait_for_next_fetch(); // LD B,n8
        wait_for_next_fetch(); // SBC A,B
        check_a(8'hFB, "SBC A,B (borrow-in=1)");

        wait_for_next_fetch(); // SBC A,(HL)
        check_a(8'hF6, "SBC A,(HL) (borrow-in=0)");

        $display("\n===== %0d PASSED, %0d FAILED =====\n", pass_count, fail_count);
        $finish;
    end

    always @(*) begin
        data_in = ram[addr];
    end

    always @(negedge clk) begin
        if (we)
            ram[addr] <= data_out;
    end

    always #10 clk = ~clk;

endmodule