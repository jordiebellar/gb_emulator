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

    reg [7:0] ram [0:65535]; // Full 64KB address space

    initial begin
        // Copy ROM contents into RAM
        ram[0] = 8'hCD;
        ram[1] = 8'h05;
        ram[2] = 8'h00;
        ram[3] = 8'hC3; // JP nn
        ram[4] = 8'h03; // low byte - jump to 0x0003
        ram[5] = 8'h00; // high byte
        ram[6] = 8'hC9; // RET

    end

    initial begin
        $dumpfile("sim/waves/tb_cpu.vcd");
        $dumpvars(0, tb_cpu);
        $monitor("t=%0t pc=%h sp=%h ret_addr=%h", $time, uut.pc, uut.sp, uut.ret_addr);
        clk = 0;
        rst = 1;
        data_in = 8'h00;
        #20 rst = 0; // Release reset after 20ns
        // Additional test cases can be added here to cover more instructions and scenarios
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