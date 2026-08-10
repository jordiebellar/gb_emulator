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
        ram[0] = 8'h31;    // LD SP, nn
        ram[1] = 8'hFE;    // SP = 0xDFFE (in WRAM)
        ram[2] = 8'hDF;
        ram[3] = 8'h3E;    // LD A, n
        ram[4] = 8'h42;    // A = 0x42
        ram[5] = 8'hEA;    // LD (nn), A  - store A to address
        ram[6] = 8'h00;    // low byte of address
        ram[7] = 8'hC0;    // high byte - store to 0xC000 (WRAM)
        ram[8] = 8'hFA;    // LD A, (nn) - load from same address
        ram[9] = 8'h00;    // low byte
        ram[10] = 8'hC0;   // high byte
        ram[11] = 8'h3E;    // LD A, n
        ram[12] = 8'h99;    // A = 0x99
        ram[13] = 8'hE0;    // LDH (n), A
        ram[14] = 8'h80;    // n = 0x80 -> writes A to 0xFF80
        ram[15] = 8'h3E;    // LD A, n
        ram[16] = 8'h00;    // A = 0x00 (clear it so the next load is a real test, not a leftover)
        ram[17] = 8'hF0;    // LDH A, (n)
        ram[18] = 8'h80;    // n = 0x80 -> reads 0xFF80 back into A
        ram[19] = 8'hC3;    // JP to itself (new halt point)
        ram[20] = 8'h16;
        ram[21] = 8'h00;
        ram[22] = 8'hC3;   // JP to itself
        ram[23] = 8'h0B;
        ram[24] = 8'h00;
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
        $display("ram[C000] = %h", ram[16'hC000]);
        #1500;
        $display("ram[FF80] = %h", ram[16'hFF80]);
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