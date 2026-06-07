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

    cpu uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .we(we),
        .addr(addr),
        .data_out(data_out)
    );

    initial begin
        $dumpfile("sim/waves/tb_cpu.vcd");
        $dumpvars(0, tb_cpu);
        clk = 0;
        rst = 1;
        data_in = 8'h00;
        #20 rst = 0; // Release reset after 20ns
        // Test Case 1: Basic Instruction Fetch and Execute
        // Load a simple instruction into the data_in and observe the CPU behavior
        #20 data_in = 8'h42; // Example instruction (LD B, D)
        // Additional test cases can be added here to cover more instructions and scenarios
        #100;
        $finish; // End simulation after 100ns
    end

    always #10 clk = ~clk;

endmodule