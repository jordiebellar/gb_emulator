// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_blargg.v
// Description  : Runs a Blargg cpu_instrs test ROM against the standalone
//                SM83 core. Blargg's test ROMs report progress and results
//                as plain text written character-by-character to the real
//                Game Boy's serial port (SB=0xFF01, SC=0xFF02) -- this
//                testbench models just enough of that port to capture and
//                print that text, standing in for hardware that doesn't
//                exist in this project yet, the same way tb_ie/tb_if stood
//                in for the bus in the presentation testbenches.
//
//                IE (0xFFFF) and IF (0xFF0F) are genuinely memory-mapped on
//                real hardware -- ordinary LD/LDH instructions read and
//                write them over the normal bus, and Blargg's own
//                interrupt-related test code does exactly that. Since this
//                core's cpu.v treats ie/if_reg as plain ports rather than
//                addresses, this testbench has to bridge the two: any bus
//                access to those two addresses is redirected to the same
//                tb_ie/tb_if regs actually wired into the CPU, so a value
//                the ROM writes via LDH is the SAME value the CPU's own
//                interrupt logic sees, not a disconnected copy sitting in
//                plain RAM.
//
//                Usage:
//                  iverilog -o sim_blargg tb_blargg.v cpu.v
//                  vvp sim_blargg
// =============================================================================
`timescale 1ns / 1ps
module tb_blargg;

    reg clk;
    reg rst;
    wire [7:0] data_in;
    wire we;
    wire [15:0] addr;
    wire [7:0] data_out;
    reg  [7:0] tb_ie;
    reg  [7:0] tb_if;
    wire [7:0] if_clear;
    wire if_clear_we;

    cpu #(
        .RESET_PC(16'h0100)
    ) uut (
        .clk(clk), .rst(rst), .data_in(data_in), .we(we), .addr(addr),
        .data_out(data_out), .ie(tb_ie), .if_reg(tb_if),
        .if_clear(if_clear), .if_clear_we(if_clear_we)
    );

    reg [7:0] ram [0:65535];

    // Reads: IE/IF are redirected to the live tb_ie/tb_if regs instead of
    // whatever's sitting in plain ram[] at those two addresses, so a
    // program that reads IE right back after writing it sees the value
    // the CPU is actually using. SC (0xFF02) always reads back with bit 7
    // clear -- standing in for "the transfer always completes instantly"
    // since there's no real serial clock in this model, which is what
    // unblocks a ROM that polls SC waiting for a transfer to finish.
    assign data_in = (addr == 16'hFFFF) ? tb_ie :
                      (addr == 16'hFF0F) ? tb_if :
                      (addr == 16'hFF02) ? {1'b0, ram[addr][6:0]} :
                      ram[addr];

    always @(negedge clk) begin
        if (we) begin
            if (addr == 16'hFFFF) tb_ie <= data_out;
            else if (addr == 16'hFF0F) tb_if <= data_out;
            else if (addr == 16'hFF01) $write("%c", data_out); // serial character out
            else ram[addr] <= data_out;
        end
    end

    // Mirrors memory_map.v's own IF-clearing logic, same as the
    // presentation testbenches.
    always @(posedge clk or posedge rst) begin
        if (rst) tb_if <= 8'h00;
        else if (if_clear_we) tb_if <= tb_if & ~if_clear;
    end

    always #10 clk = ~clk;

    // Lightweight heartbeat so you can see it's making progress during a
    // long run, without flooding the terminal. One line roughly every
    // 50,000 CPU cycles.
    integer hb;
    initial hb = 0;
    always @(negedge clk) begin
        if (we && addr == 16'hFF01) begin
            $display("SERIAL '%c' (0x%h)  pc=%h sp=%h a=%h f=%h d=%h e=%h bc=%h hl=%h",
                data_out, data_out, uut.pc, uut.sp, uut.a, uut.f, uut.d, uut.e,
                {uut.b,uut.c}, {uut.h,uut.l});
        end
    end

    // Blargg's own docs note some sub-tests take up to half a real-hardware
    // minute; at ~1MHz that's tens of millions of cycles, so this watchdog
    // is generous on purpose. Individual sub-tests should finish well
    // before this in practice.
    initial begin
        #900_000_000;
        $display("\nWATCHDOG: 900,000,000ns elapsed without the ROM signaling completion. Aborting.");
        $finish;
    end

    // Initialize the testbench and load the ROM
    initial begin
        clk = 0;
        rst = 1;
        tb_ie = 8'h00;
        $readmemh("rom.hex", ram, 0, 32767);

        #20 rst = 0;

        #800_000_000;
        $display("\n--- 800,000,000ns elapsed, stopping here ---");
        $finish;
    end

endmodule