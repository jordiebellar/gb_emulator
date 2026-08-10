// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_cpu.v
// Author       : Jordie Bellar
// Date         : 2026-06-06
// Description  : Testbench for the SM83 CPU core. Provides a simple environment to verify
//                the functionality of the CPU module. Can be extended with specific test cases
//                to validate instruction execution, register operations, and memory interactions.
// Revision     : 1.0 - Initial implementation
// =============================================================================
`timescale 1ns / 1ps
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
        .ie(ie), // Interrupt Enable register
        .if_reg(if_reg), // Interrupt Flag register
        .if_clear(if_clear), // Interrupt Clear register
        .if_clear_we(if_clear_we) // Interrupt Clear Write Enable
    );

    reg [7:0] ram [0:65535]; // Full 64KB address space

    initial begin
        ram[0]  = 8'h26;  // LD H, n
        ram[1]  = 8'hC0;  // H = 0xC0
        ram[2]  = 8'h2E;  // LD L, n
        ram[3]  = 8'h20;  // L = 0x20  -> HL = 0xC020

        ram[4]  = 8'h3E;  // LD A, n
        ram[5]  = 8'h11;  // A = 0x11
        ram[6]  = 8'h22;  // LD (HLI), A -> ram[C020]=0x11, HL becomes C021

        ram[7]  = 8'h3E;  // LD A, n
        ram[8]  = 8'h22;  // A = 0x22
        ram[9]  = 8'h22;  // LD (HLI), A -> ram[C021]=0x22, HL becomes C022

        ram[10] = 8'h3E;  // LD A, n
        ram[11] = 8'h00;  // clear A so the reads below are a real test

        ram[12] = 8'h3A;  // LD A, (HLD) -> reads ram[C022] (uninitialized), HL becomes C021
        ram[13] = 8'h3A;  // LD A, (HLD) -> reads ram[C021]=0x22, A should be 0x22, HL becomes C020
        ram[14] = 8'h3A;  // LD A, (HLD) -> reads ram[C020]=0x11, A should be 0x11, HL becomes C01F

        ram[15] = 8'hC3;  // JP to itself
        ram[16] = 8'h0F;
        ram[17] = 8'h00;
    end

    initial begin
        $dumpfile("sim/waves/tb_cpu.vcd");
        $dumpvars(0, tb_cpu);
        $monitor("t=%0t state=%0d we=%b addr=%h data_out=%h mem_data=%h src=%0d a=%h", 
         $time, uut.state, uut.we, uut.addr, uut.data_out, uut.mem_data, uut.src, uut.a);
        clk = 0;
        rst = 1;
        data_in = 8'h00;
        #20 rst = 0; // Release reset after 20ns
        // Additional test cases can be added here to cover more instructions and scenarios
        #800;
        #1500;
        $finish; // End simulation after 100ns
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