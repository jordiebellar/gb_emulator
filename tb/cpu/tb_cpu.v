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

    reg [7:0] rom [0:255]; // Simple ROM for testing

    initial begin
        // Initialize ROM with some test instructions (for example purposes)
        // Test AND
        rom[0] = 8'h3E; // LD A, n
        rom[1] = 8'hFF; // Value to load into A
        rom[2] = 8'h06; // LD B, n
        rom[3] = 8'h0F; // Value to load into B
        rom[4] = 8'hA0; // AND A, B
        // Test XOR
        rom[5] = 8'hAF; // XOR A, A (should result in 0)
        // Test OR
        rom[6] = 8'h3E; // LD A, n
        rom[7] = 8'hF0; // Value to load into A
        rom[8] = 8'h06; // LD B, n
        rom[9] = 8'h0F; // Value to load into B
        rom[10] = 8'hB0; // OR A, B
        // Zero A
        rom[11] = 8'hAF; // XOR A, A (should result in 0)
        // Test CP
        rom[12] = 8'h3E; // LD A, n
        rom[13] = 8'h05; // Value to load into A
        rom[14] = 8'h06; // LD B, n
        rom[15] = 8'h05; // Value to load into B
        rom[16] = 8'hB8; // CP A, B (should set Zero flag)
    end

    initial begin
        $dumpfile("sim/waves/tb_cpu.vcd");
        $dumpvars(0, tb_cpu);
        clk = 0;
        rst = 1;
        data_in = 8'h00;
        #20 rst = 0; // Release reset after 20ns
        // Additional test cases can be added here to cover more instructions and scenarios
        #1500;
        $finish; // End simulation after 100ns
    end

    always @(*) begin
        // Simple ROM behavior: output data based on the address
        data_in = rom[addr];
    end

    always #10 clk = ~clk;

endmodule