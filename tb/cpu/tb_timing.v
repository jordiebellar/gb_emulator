// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_timing.v
// Author       : Jordie Bellar
// Date         : 2026-09-25
// Description  : M-cycle timing testbench for the standalone SM83 core.
//                Checks that every instruction takes exactly the number of
//                M-cycles the real SM83 takes, measured as the number of
//                ce_m pulses from one opcode-fetch commit to the next. That
//                definition matches the published counts, including the
//                fetch/execute overlap (NOP = 1, LD B,n = 2, CALL nn = 6).
//
//                Written against the ce_m bus contract, test-first:
//                  - ce_gb pulses every 24 clocks, ce_m every 4th ce_gb,
//                    matching the rates clk_div will produce
//                  - reads are combinational from ram[]
//                  - writes commit on (we && ce_m), exactly once
//                  - a fetch commit is (state == STATE_FETCH && ce_m)
//
//                Expected counts are keyed by instruction ADDRESS, not by
//                execution order, so a skipped or extra fetch shows up as a
//                FAIL on the specific instruction instead of shifting every
//                row after it. Any fetch from an address with no expectation
//                (padding bytes a wrong branch would land on) is flagged.
//
//                Run with Icarus Verilog:
//                  iverilog -o sim/tb_timing tb/cpu/tb_timing.v rtl/cpu/cpu.v
//                  vvp sim/tb_timing
// =============================================================================
`timescale 1ns / 1ps
module tb_timing;

    // Mirrors cpu.v's STATE_FETCH localparam, kept in sync by hand.
    localparam STATE_FETCH = 4'd0;

    localparam PARK_ADDR  = 16'h013B; // JR -2 parking loop, end of program
    localparam NUM_CHECKS = 35;       // Instructions with an expected count

    reg clk;
    reg rst;
    wire [7:0]  data_in;
    wire        we;
    wire [15:0] addr;
    wire [7:0]  data_out;
    wire [7:0]  if_clear;
    wire        if_clear_we;

    // ------------------------------------------------------------------
    // Clock enables: ce_gb every 24 clocks (~4.19 MHz off 100 MHz),
    // ce_m on every 4th ce_gb. Both are single-clock pulses and reset
    // together, so the M-cycle phase is fixed from reset.
    // ------------------------------------------------------------------
    reg [4:0] t_div;
    reg [1:0] m_phase;
    reg       ce_gb;
    reg       ce_m;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            t_div   <= 5'd0;
            m_phase <= 2'd0;
            ce_gb   <= 1'b0;
            ce_m    <= 1'b0;
        end
        else begin
            ce_gb <= 1'b0;
            ce_m  <= 1'b0;
            if (t_div == 5'd23) begin
                t_div   <= 5'd0;
                ce_gb   <= 1'b1;
                m_phase <= m_phase + 2'd1;
                if (m_phase == 2'd3) ce_m <= 1'b1;
            end
            else begin
                t_div <= t_div + 5'd1;
            end
        end
    end

    cpu #(
        .RESET_PC(16'h0100)
    ) uut (
        .clk(clk), .rst(rst), .ce_m(ce_m),
        .data_in(data_in), .we(we), .addr(addr), .data_out(data_out),
        .ie(8'h00), .if_reg(8'h00),
        .if_clear(if_clear), .if_clear_we(if_clear_we)
    );

    // ------------------------------------------------------------------
    // Memory: combinational reads, writes commit once on ce_m.
    // ------------------------------------------------------------------
    reg [7:0] ram [0:65535];
    assign data_in = ram[addr];

    always @(posedge clk) begin
        if (we && ce_m) ram[addr] <= data_out;
    end

    always #5 clk = ~clk; // 100 MHz

    // ------------------------------------------------------------------
    // Expected M-cycles for the instruction starting at each address.
    // 0 means "no instruction should ever be fetched here".
    // ------------------------------------------------------------------
    function [3:0] expected_m(input [15:0] a);
        case (a)
            16'h0100: expected_m = 3; // LD SP,$DFF0
            16'h0103: expected_m = 3; // LD HL,$C000
            16'h0106: expected_m = 1; // NOP
            16'h0107: expected_m = 1; // LD B,C
            16'h0108: expected_m = 2; // LD B,n
            16'h010A: expected_m = 1; // ADD A,B
            16'h010B: expected_m = 2; // ADD A,n
            16'h010D: expected_m = 2; // LD A,(HL)
            16'h010E: expected_m = 3; // LD (HL),n
            16'h0110: expected_m = 3; // LDH (n),A
            16'h0112: expected_m = 4; // LD (nn),A
            16'h0115: expected_m = 2; // INC BC
            16'h0116: expected_m = 2; // ADD HL,BC
            16'h0117: expected_m = 4; // PUSH BC
            16'h0118: expected_m = 3; // POP BC
            16'h0119: expected_m = 3; // LD HL,SP+e
            16'h011B: expected_m = 4; // ADD SP,e
            16'h011D: expected_m = 2; // LD SP,HL
            16'h011E: expected_m = 3; // LD HL,$C000
            16'h0121: expected_m = 2; // RLC C
            16'h0123: expected_m = 3; // BIT 0,(HL)
            16'h0125: expected_m = 4; // RLC (HL)
            16'h0127: expected_m = 1; // XOR A
            16'h0128: expected_m = 2; // JR NZ,e (not taken)
            16'h012A: expected_m = 1; // INC A
            16'h012B: expected_m = 3; // JR NZ,e (taken)
            16'h012E: expected_m = 4; // JP nn
            16'h0132: expected_m = 6; // CALL nn
            16'h0140: expected_m = 1; // XOR A (in subroutine)
            16'h0141: expected_m = 2; // RET NZ (not taken)
            16'h0142: expected_m = 5; // RET Z (taken)
            16'h0135: expected_m = 3; // LD HL,$013A
            16'h0138: expected_m = 1; // JP (HL)
            16'h013A: expected_m = 4; // RST $08
            16'h0008: expected_m = 4; // RET (from RST vector)
            default:  expected_m = 0;
        endcase
    endfunction

    function [8*12-1:0] name(input [15:0] a);
        case (a)
            16'h0100: name = "LD SP,nn";
            16'h0103: name = "LD HL,nn";
            16'h0106: name = "NOP";
            16'h0107: name = "LD B,C";
            16'h0108: name = "LD B,n";
            16'h010A: name = "ADD A,B";
            16'h010B: name = "ADD A,n";
            16'h010D: name = "LD A,(HL)";
            16'h010E: name = "LD (HL),n";
            16'h0110: name = "LDH (n),A";
            16'h0112: name = "LD (nn),A";
            16'h0115: name = "INC BC";
            16'h0116: name = "ADD HL,BC";
            16'h0117: name = "PUSH BC";
            16'h0118: name = "POP BC";
            16'h0119: name = "LD HL,SP+e";
            16'h011B: name = "ADD SP,e";
            16'h011D: name = "LD SP,HL";
            16'h011E: name = "LD HL,nn";
            16'h0121: name = "RLC C";
            16'h0123: name = "BIT 0,(HL)";
            16'h0125: name = "RLC (HL)";
            16'h0127: name = "XOR A";
            16'h0128: name = "JR NZ (nt)";
            16'h012A: name = "INC A";
            16'h012B: name = "JR NZ (t)";
            16'h012E: name = "JP nn";
            16'h0132: name = "CALL nn";
            16'h0140: name = "XOR A";
            16'h0141: name = "RET NZ (nt)";
            16'h0142: name = "RET Z (t)";
            16'h0135: name = "LD HL,nn";
            16'h0138: name = "JP (HL)";
            16'h013A: name = "RST $08";
            16'h0008: name = "RET";
            default:  name = "???";
        endcase
    endfunction

    // ------------------------------------------------------------------
    // Measurement: count ce_m ticks, and at every fetch commit compare
    // the ticks since the previous commit against the previous
    // instruction's expected count.
    // ------------------------------------------------------------------
    integer m_tick;
    integer last_tick;
    reg [15:0] last_addr;
    reg        have_last;
    integer checked, passed;
    integer unexpected;

    always @(posedge clk) begin
        if (!rst && ce_m) begin
            m_tick = m_tick + 1;

            if (uut.state == STATE_FETCH) begin
                if (have_last) begin
                    if (expected_m(last_addr) == 0) begin
                        $display("FAIL  %h  unexpected fetch (no instruction should start here)",
                                 last_addr);
                        unexpected = unexpected + 1;
                        if (unexpected == 8) begin
                            $display("\nRUNAWAY: 8 fetches from unexpected addresses, CPU has left the program.");
                            $display("%0d/%0d checked, %0d passed.", checked, NUM_CHECKS, passed);
                            $display("TIMING CHECKS FAILED");
                            $finish;
                        end
                    end
                    else begin
                        checked = checked + 1;
                        if (m_tick - last_tick == expected_m(last_addr)) begin
                            passed = passed + 1;
                            $display("PASS  %h  %-12s  expected %0d  got %0d",
                                     last_addr, name(last_addr),
                                     expected_m(last_addr), m_tick - last_tick);
                        end
                        else begin
                            $display("FAIL  %h  %-12s  expected %0d  got %0d",
                                     last_addr, name(last_addr),
                                     expected_m(last_addr), m_tick - last_tick);
                        end
                    end
                end

                if (addr == PARK_ADDR) begin
                    $display("\nReached parking loop. %0d/%0d checked, %0d passed.",
                             checked, NUM_CHECKS, passed);
                    if (checked == NUM_CHECKS && passed == NUM_CHECKS)
                        $display("ALL TIMING CHECKS PASSED");
                    else
                        $display("TIMING CHECKS FAILED");
                    $finish;
                end

                last_addr = addr;
                last_tick = m_tick;
                have_last = 1'b1;
            end
        end
    end

    // Watchdog: the program is ~90 M-cycles, about 9,000 clocks. Anything
    // past 100,000 clocks means the parking loop was never reached.
    initial begin
        #1_000_000;
        $display("\nWATCHDOG: parking loop never reached. %0d/%0d checked, %0d passed.",
                 checked, NUM_CHECKS, passed);
        $display("TIMING CHECKS FAILED");
        $finish;
    end

    // ------------------------------------------------------------------
    // Program. Starts at 0x0100 (RESET_PC), subroutine at 0x0140,
    // RST $08 vector holds a RET. Padding bytes are 0x00 at addresses
    // with no expectation, so a wrong branch target gets flagged.
    // ------------------------------------------------------------------
    integer i;
    initial begin
        for (i = 0; i < 65536; i = i + 1) ram[i] = 8'h00;

        ram[16'h0008] = 8'hC9;                                            // RET

        ram[16'h0100] = 8'h31; ram[16'h0101] = 8'hF0; ram[16'h0102] = 8'hDF; // LD SP,$DFF0
        ram[16'h0103] = 8'h21; ram[16'h0104] = 8'h00; ram[16'h0105] = 8'hC0; // LD HL,$C000
        ram[16'h0106] = 8'h00;                                            // NOP
        ram[16'h0107] = 8'h41;                                            // LD B,C
        ram[16'h0108] = 8'h06; ram[16'h0109] = 8'h12;                     // LD B,$12
        ram[16'h010A] = 8'h80;                                            // ADD A,B
        ram[16'h010B] = 8'hC6; ram[16'h010C] = 8'h34;                     // ADD A,$34
        ram[16'h010D] = 8'h7E;                                            // LD A,(HL)
        ram[16'h010E] = 8'h36; ram[16'h010F] = 8'h5A;                     // LD (HL),$5A
        ram[16'h0110] = 8'hE0; ram[16'h0111] = 8'h80;                     // LDH ($80),A
        ram[16'h0112] = 8'hEA; ram[16'h0113] = 8'h10; ram[16'h0114] = 8'hC0; // LD ($C010),A
        ram[16'h0115] = 8'h03;                                            // INC BC
        ram[16'h0116] = 8'h09;                                            // ADD HL,BC
        ram[16'h0117] = 8'hC5;                                            // PUSH BC
        ram[16'h0118] = 8'hC1;                                            // POP BC
        ram[16'h0119] = 8'hF8; ram[16'h011A] = 8'h02;                     // LD HL,SP+2
        ram[16'h011B] = 8'hE8; ram[16'h011C] = 8'h02;                     // ADD SP,2
        ram[16'h011D] = 8'hF9;                                            // LD SP,HL
        ram[16'h011E] = 8'h21; ram[16'h011F] = 8'h00; ram[16'h0120] = 8'hC0; // LD HL,$C000
        ram[16'h0121] = 8'hCB; ram[16'h0122] = 8'h01;                     // RLC C
        ram[16'h0123] = 8'hCB; ram[16'h0124] = 8'h46;                     // BIT 0,(HL)
        ram[16'h0125] = 8'hCB; ram[16'h0126] = 8'h06;                     // RLC (HL)
        ram[16'h0127] = 8'hAF;                                            // XOR A      (Z=1)
        ram[16'h0128] = 8'h20; ram[16'h0129] = 8'h05;                     // JR NZ,+5   (not taken)
        ram[16'h012A] = 8'h3C;                                            // INC A      (Z=0)
        ram[16'h012B] = 8'h20; ram[16'h012C] = 8'h01;                     // JR NZ,+1   (taken, skips 0x012D)
        ram[16'h012D] = 8'h00;                                            // padding
        ram[16'h012E] = 8'hC3; ram[16'h012F] = 8'h32; ram[16'h0130] = 8'h01; // JP $0132
        ram[16'h0131] = 8'h00;                                            // padding
        ram[16'h0132] = 8'hCD; ram[16'h0133] = 8'h40; ram[16'h0134] = 8'h01; // CALL $0140
        ram[16'h0135] = 8'h21; ram[16'h0136] = 8'h3A; ram[16'h0137] = 8'h01; // LD HL,$013A
        ram[16'h0138] = 8'hE9;                                            // JP (HL)
        ram[16'h0139] = 8'h00;                                            // padding
        ram[16'h013A] = 8'hCF;                                            // RST $08
        ram[16'h013B] = 8'h18; ram[16'h013C] = 8'hFE;                     // JR -2 (park)

        ram[16'h0140] = 8'hAF;                                            // XOR A      (Z=1)
        ram[16'h0141] = 8'hC0;                                            // RET NZ     (not taken)
        ram[16'h0142] = 8'hC8;                                            // RET Z      (taken)

        m_tick    = 0;
        last_tick = 0;
        last_addr = 16'h0000;
        have_last = 1'b0;
        checked   = 0;
        passed    = 0;
        unexpected = 0;

        $dumpfile("sim/waves/tb_timing.vcd");
        $dumpvars(0, tb_timing);

        clk = 0;
        rst = 1;
        #25 rst = 0;
    end

endmodule