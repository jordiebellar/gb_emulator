// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_gb_top.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : real integration testbench for gb_top - runs a tiny
//                  hand-assembled test program (LD A,0xAB / LD (0xC000),A
//                  / HALT) through the actual cpu+bus+wram+cartridge
//                  wiring and checks whether the write actually lands in
//                  wram. exercises the real integration boundary, not a
//                  single module in isolation
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_gb_top;

    reg clk_100m;
    reg rst;

    initial clk_100m = 1'b0;
    always #5 clk_100m = ~clk_100m; // 100MHz, 10ns period

    wire [15:0] dbg_addr;
    wire [7:0]  dbg_data_out;
    wire        dbg_we;
    wire [7:0]  dbg_data_in;
    wire [7:0]  dbg_ie;
    wire [7:0]  dbg_if_reg;
    wire        dbg_bus_stall;

    gb_top #(
        .BOOT_ROM_FILE("test_boot_prog.hex"),
        .CART_ROM_FILE("test_cart_prog.hex")
    ) dut (
        .clk_100m           (clk_100m),
        .rst                (rst),
        .debug_cpu_addr     (dbg_addr),
        .debug_cpu_data_out (dbg_data_out),
        .debug_cpu_we       (dbg_we),
        .debug_bus_data_in  (dbg_data_in),
        .debug_ie           (dbg_ie),
        .debug_if_reg       (dbg_if_reg),
        .debug_bus_stall    (dbg_bus_stall)
    );

    integer i;

    initial begin
        rst = 1'b1;
        repeat (4) @(posedge clk_100m);
        @(negedge clk_100m);
        rst = 1'b0;

        $display("cyc  addr   we data_out data_in");
        for (i = 0; i < 40; i = i + 1) begin
            @(posedge clk_100m);
            #1;
            $display("%3d  %04h   %b  %02h       %02h", i, dbg_addr, dbg_we, dbg_data_out, dbg_data_in);
        end

        repeat (2000) @(posedge clk_100m);

        $display("");
        $display("final cpu state: addr=%h we=%b data_out=%h ie=%h if_reg=%h",
                  dbg_addr, dbg_we, dbg_data_out, dbg_ie, dbg_if_reg);
        $display("wram[0] (addr 0xC000) = %h  (expect 0xAB if LD (0xC000),A actually landed)",
                  dut.u_wram.mem[0]);

        $finish;
    end

endmodule