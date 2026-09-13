// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_cpu.v
// Author       : Jordie Bellar
// Date         : 2026-09-12
// Description  : Integration testbench for the SM83 CPU core against the real
//                memory_map (registered/synchronous memory), via gb_top. This
//                replaces the earlier flat-array behavioral RAM testbench,
//                which had zero-latency reads and could not expose timing
//                bugs against a synchronous memory. Exercises:
//                  1. HALT (0x76) decode reachability and exit-on-pending-IRQ
//                  2. (HL) memory operand timing for ALU ops (mem_alu_read)
//                  3. INC (HL) read-modify-write
//                  4. CALL/RET stack push/pop timing (second-byte pop fix)
// Revision     : 2.0 - Rewritten against gb_top/memory_map instead of a
//                       behavioral flat RAM
// =============================================================================
`timescale 1ns / 1ps
module tb_cpu;

    reg clk;
    reg rst;

    integer errors;
    integer timeout;

    // Mirrors of cpu.v's state localparams. Keep in sync if cpu.v changes.
    localparam TB_STATE_FETCH = 4'd0;
    localparam TB_STATE_HALT  = 4'd6;

    gb_top dut (
        .clk(clk),
        .rst(rst)
    );

    always #10 clk = ~clk;

    initial begin
        $dumpfile("sim/waves/tb_cpu.vcd");
        $dumpvars(0, tb_cpu);
        $monitor("t=%0t st=%0d pc=%h ir=%h addr=%h we=%b din=%h dout=%h a=%h b=%h sp=%h",
            $time, dut.cpu_inst.state, dut.cpu_inst.pc, dut.cpu_inst.ir,
            dut.cpu_inst.addr, dut.cpu_inst.we, dut.cpu_inst.data_in,
            dut.cpu_inst.data_out, dut.cpu_inst.a, dut.cpu_inst.b, dut.cpu_inst.sp);
    end

    // Global safety net in case something hangs that the per-check
    // timeouts below don't catch.
    initial begin
        #100000;
        $display("WATCHDOG: simulation ran 100000ns without finishing. Aborting.");
        $finish;
    end

    initial begin
        errors = 0;
        clk = 0;
        rst = 1;
        #20 rst = 0;

        // -----------------------------------------------------------
        // Check 1: HALT reachability. rom.hex sets IE=0x01 then hits
        // HALT while IF is still 0, so the CPU should reach STATE_HALT.
        // -----------------------------------------------------------
        timeout = 0;
        while (dut.cpu_inst.state !== TB_STATE_HALT && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (dut.cpu_inst.state !== TB_STATE_HALT) begin
            $display("FAIL: CPU never reached STATE_HALT (state=%0d, timeout)", dut.cpu_inst.state);
            errors = errors + 1;
        end else begin
            $display("PASS: CPU reached STATE_HALT at time %0t", $time);
        end

        // -----------------------------------------------------------
        // Check 2: HALT actually stalls (IE=0x01, IF=0x00, no pending IRQ)
        // -----------------------------------------------------------
        begin : halt_stall_check
            integer i;
            reg stalled;
            stalled = 1'b1;
            for (i = 0; i < 20; i = i + 1) begin
                @(posedge clk);
                if (dut.cpu_inst.state !== TB_STATE_HALT) stalled = 1'b0;
            end
            if (stalled) begin
                $display("PASS: CPU remained halted for 20 cycles with no pending interrupt");
            end else begin
                $display("FAIL: CPU left HALT with no interrupt pending");
                errors = errors + 1;
            end
        end

        // -----------------------------------------------------------
        // Check 3: HALT exits once (ie & if_reg) is nonzero. No peripheral
        // exists yet to set if_reg on its own (the still-open IF-set gap),
        // so this forces if_reg to stand in for a future interrupt source.
        // -----------------------------------------------------------
        $display("Forcing if_reg = 0x01 to emulate a pending interrupt (no peripheral exists yet)");
        force dut.memory_map_inst.if_reg = 8'h01;

        timeout = 0;
        while (dut.cpu_inst.state == TB_STATE_HALT && timeout < 20) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (dut.cpu_inst.state == TB_STATE_HALT) begin
            $display("FAIL: CPU did not exit HALT once (ie & if_reg) was nonzero");
            errors = errors + 1;
        end else begin
            $display("PASS: CPU exited HALT at time %0t", $time);
        end

        release dut.memory_map_inst.if_reg;

        // -----------------------------------------------------------
        // Check 4: ADD A,(HL) reads the correct byte from memory
        // (mem_wait + mem_alu_read timing). Wait for pc==0x0014 AND
        // state back at FETCH, not just pc==0x0014, since pc reaches
        // the next opcode's address as soon as ADD A,(HL) is fetched,
        // well before it has actually executed.
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0014 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0014 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0014/FETCH after ADD A,(HL) (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.a !== 8'h15) begin
            $display("FAIL: ADD A,(HL) gave A=0x%h, expected 0x15", dut.cpu_inst.a);
            errors = errors + 1;
        end else begin
            $display("PASS: ADD A,(HL) correctly gave A=0x15");
        end

        // -----------------------------------------------------------
        // Check 5: INC (HL) read-modify-write. Same pc/state boundary
        // fix as above, PLUS one extra clock edge: memory_map's wram
        // write is itself registered, so the array element doesn't
        // update until the cycle after we/addr/data_out are asserted,
        // one edge later than the CPU-internal register checks need.
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0015 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        @(posedge clk); // let memory_map's registered wram write commit
        if (!(dut.cpu_inst.pc === 16'h0015)) begin
            $display("FAIL: CPU never settled at pc=0x0015 after INC (HL) (pc=%h, timeout)", dut.cpu_inst.pc);
            errors = errors + 1;
        end else if (dut.memory_map_inst.wram[16'h0050] !== 8'h06) begin
            $display("FAIL: INC (HL) gave mem[0xC050]=0x%h, expected 0x06",
                dut.memory_map_inst.wram[16'h0050]);
            errors = errors + 1;
        end else begin
            $display("PASS: INC (HL) correctly gave mem[0xC050]=0x06");
        end

        // -----------------------------------------------------------
        // Check 6: CALL/RET round-trip. Same pc/state boundary fix.
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h001D && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 1000) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h001D && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x001D/FETCH after CALL/RET (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.b !== 8'hCD) begin
            $display("FAIL: CALL/RET returned to the wrong place, B=0x%h, expected 0xCD", dut.cpu_inst.b);
            errors = errors + 1;
        end else begin
            $display("PASS: CALL/RET correctly returned to 0x001B (B=0xCD)");
        end

                // -----------------------------------------------------------
        // Check 7: LD BC,nn / LD DE,nn / INC BC / DEC DE
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0025 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0025 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0025/FETCH after LD rr,nn/INC/DEC (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if ({dut.cpu_inst.b, dut.cpu_inst.c} !== 16'h2234) begin
            $display("FAIL: INC BC gave BC=0x%h, expected 0x2234", {dut.cpu_inst.b, dut.cpu_inst.c});
            errors = errors + 1;
        end else if ({dut.cpu_inst.d, dut.cpu_inst.e} !== 16'h4454) begin
            $display("FAIL: DEC DE gave DE=0x%h, expected 0x4454", {dut.cpu_inst.d, dut.cpu_inst.e});
            errors = errors + 1;
        end else begin
            $display("PASS: LD BC,nn/LD DE,nn/INC BC/DEC DE correctly gave BC=0x2234, DE=0x4454");
        end

        // -----------------------------------------------------------
        // Check 8: ADD HL,rr (H/C flag edge case: 0xFFFF + 1) and
        // LD (nn), SP (two-byte registered WRAM write). One extra
        // clock edge after settling, same reason as check 5: the
        // second (high-byte) write inside memory_map's registered
        // wram array doesn't commit until the edge after we/addr/
        // data_out are asserted.
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0033 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        @(posedge clk); // let memory_map's registered wram write commit
        if (!(dut.cpu_inst.pc === 16'h0033)) begin
            $display("FAIL: CPU never settled at pc=0x0033 after ADD HL,rr/LD(nn),SP (pc=%h, timeout)", dut.cpu_inst.pc);
            errors = errors + 1;
        end else if ({dut.cpu_inst.h, dut.cpu_inst.l} !== 16'h0000) begin
            $display("FAIL: ADD HL,BC gave HL=0x%h, expected 0x0000", {dut.cpu_inst.h, dut.cpu_inst.l});
            errors = errors + 1;
        end else if (dut.cpu_inst.f[5] !== 1'b1) begin // F_H
            $display("FAIL: ADD HL,BC gave H flag=%b, expected 1", dut.cpu_inst.f[5]);
            errors = errors + 1;
        end else if (dut.cpu_inst.f[4] !== 1'b1) begin // F_C
            $display("FAIL: ADD HL,BC gave C flag=%b, expected 1", dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else if (dut.memory_map_inst.wram[16'h0100] !== 8'hBC) begin
            $display("FAIL: LD (nn),SP gave mem[0xC100]=0x%h, expected 0xBC", dut.memory_map_inst.wram[16'h0100]);
            errors = errors + 1;
        end else if (dut.memory_map_inst.wram[16'h0101] !== 8'h9A) begin
            $display("FAIL: LD (nn),SP gave mem[0xC101]=0x%h, expected 0x9A", dut.memory_map_inst.wram[16'h0101]);
            errors = errors + 1;
        end else begin
            $display("PASS: ADD HL,BC gave HL=0x0000/H=1/C=1, LD (nn),SP correctly wrote 0xBC,0x9A");
        end

        // -----------------------------------------------------------
        // Check 9: LD SP, HL (0xF9)
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0038 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0038 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0038/FETCH after LD SP,HL (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.sp !== 16'h1234) begin
            $display("FAIL: LD SP,HL gave SP=0x%h, expected 0x1234", dut.cpu_inst.sp);
            errors = errors + 1;
        end else begin
            $display("PASS: LD SP,HL correctly gave SP=0x1234");
        end

        // -----------------------------------------------------------
        // Check 10: LD HL, SP+e8 (0xF8). Two sub-cases: a positive
        // immediate (straightforward), and a negative immediate,
        // where H/C are computed from an UNSIGNED byte add of SP's
        // low byte and e8, even though the actual 16-bit result
        // sign-extends e8 and can subtract from SP. SP is reset to
        // 0x00FF before each sub-case so the math is unambiguous.
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h003D && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h003D && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x003D/FETCH after LD HL,SP+1 (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if ({dut.cpu_inst.h, dut.cpu_inst.l} !== 16'h0100) begin
            $display("FAIL: LD HL,SP+1 gave HL=0x%h, expected 0x0100", {dut.cpu_inst.h, dut.cpu_inst.l});
            errors = errors + 1;
        end else if (dut.cpu_inst.f[5] !== 1'b1) begin // F_H
            $display("FAIL: LD HL,SP+1 gave H flag=%b, expected 1", dut.cpu_inst.f[5]);
            errors = errors + 1;
        end else if (dut.cpu_inst.f[4] !== 1'b1) begin // F_C
            $display("FAIL: LD HL,SP+1 gave C flag=%b, expected 1", dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: LD HL,SP+1 (positive e8) correctly gave HL=0x0100, H=1, C=1");
        end

        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0048 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0048 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0048/FETCH after LD HL,SP-1 (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if ({dut.cpu_inst.h, dut.cpu_inst.l} !== 16'h00FE) begin
            $display("FAIL: LD HL,SP+(-1) gave HL=0x%h, expected 0x00FE", {dut.cpu_inst.h, dut.cpu_inst.l});
            errors = errors + 1;
        end else if (dut.cpu_inst.f[5] !== 1'b1) begin // F_H
            $display("FAIL: LD HL,SP+(-1) gave H flag=%b, expected 1 (unsigned-add flag quirk)", dut.cpu_inst.f[5]);
            errors = errors + 1;
        end else if (dut.cpu_inst.f[4] !== 1'b1) begin // F_C
            $display("FAIL: LD HL,SP+(-1) gave C flag=%b, expected 1 (unsigned-add flag quirk)", dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: LD HL,SP+(-1) (negative e8) correctly gave HL=0x00FE, H=1, C=1 despite subtraction");
        end

        // -----------------------------------------------------------
        // Check 11: RLCA / RRCA / RLA / RRA (0x07/0x0F/0x17/0x1F).
        // Verifies the rotate itself, that Z is ALWAYS forced to 0
        // (never set from the result, and always overrides whatever
        // Z the preceding ADD left behind), and that RLA/RRA correctly
        // rotate in the OLD carry-in (the same same-cycle stale-read
        // behavior flagged as a bug pattern elsewhere in this file is
        // exactly what these two instructions require).
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h004B && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h004B && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x004B/FETCH after RLCA(0x00) (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.a !== 8'h00 || dut.cpu_inst.f[4] !== 1'b0 || dut.cpu_inst.f[7] !== 1'b0
                     || dut.cpu_inst.f[6] !== 1'b0 || dut.cpu_inst.f[5] !== 1'b0) begin
            $display("FAIL: RLCA(0x00) gave A=0x%h Z=%b N=%b H=%b C=%b, expected A=0x00 Z=0 N=0 H=0 C=0",
                dut.cpu_inst.a, dut.cpu_inst.f[7], dut.cpu_inst.f[6], dut.cpu_inst.f[5], dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: RLCA(0x00) correctly gave A=0x00, Z=0 despite zero result, C=0");
        end

        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h004E && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h004E && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x004E/FETCH after RLCA(0x85) (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.a !== 8'h0B || dut.cpu_inst.f[4] !== 1'b1 || dut.cpu_inst.f[7] !== 1'b0) begin
            $display("FAIL: RLCA(0x85) gave A=0x%h Z=%b C=%b, expected A=0x0B Z=0 C=1",
                dut.cpu_inst.a, dut.cpu_inst.f[7], dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: RLCA(0x85) correctly gave A=0x0B, C=1, Z=0");
        end

        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0051 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0051 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0051/FETCH after RRCA(0x03) (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.a !== 8'h81 || dut.cpu_inst.f[4] !== 1'b1 || dut.cpu_inst.f[7] !== 1'b0) begin
            $display("FAIL: RRCA(0x03) gave A=0x%h Z=%b C=%b, expected A=0x81 Z=0 C=1",
                dut.cpu_inst.a, dut.cpu_inst.f[7], dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: RRCA(0x03) correctly gave A=0x81, C=1, Z=0");
        end

        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0056 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0056 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0056/FETCH after RLA (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.a !== 8'h01 || dut.cpu_inst.f[4] !== 1'b0 || dut.cpu_inst.f[7] !== 1'b0) begin
            $display("FAIL: RLA gave A=0x%h Z=%b C=%b, expected A=0x01 (old carry-in rotated to bit0) Z=0 C=0",
                dut.cpu_inst.a, dut.cpu_inst.f[7], dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: RLA correctly used old carry-in, gave A=0x01, C=0, Z=0 despite prior ADD's Z=1");
        end

        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0059 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0059 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0059/FETCH after RRA (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.a !== 8'h80 || dut.cpu_inst.f[4] !== 1'b0 || dut.cpu_inst.f[7] !== 1'b0) begin
            $display("FAIL: RRA gave A=0x%h Z=%b C=%b, expected A=0x80 (old carry-in rotated to bit7) Z=0 C=0",
                dut.cpu_inst.a, dut.cpu_inst.f[7], dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: RRA correctly used old carry-in, gave A=0x80, C=0, Z=0 despite prior ADD's Z=1");
        end

        // -----------------------------------------------------------
        // Check 12a: CPL (0x2F)
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h005C && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h005C && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x005C/FETCH after CPL (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.a !== 8'hAA || dut.cpu_inst.f[6] !== 1'b1 || dut.cpu_inst.f[5] !== 1'b1
                     || dut.cpu_inst.f[7] !== 1'b0 || dut.cpu_inst.f[4] !== 1'b0) begin
            $display("FAIL: CPL gave A=0x%h N=%b H=%b Z=%b C=%b, expected A=0xAA N=1 H=1 Z=0 C=0",
                dut.cpu_inst.a, dut.cpu_inst.f[6], dut.cpu_inst.f[5], dut.cpu_inst.f[7], dut.cpu_inst.f[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: CPL correctly gave A=0xAA, N=1, H=1, Z/C unaffected");
        end

        // -----------------------------------------------------------
        // Check 12b: SCF (0x37)
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h005E && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h005E && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x005E/FETCH after SCF (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.f[4] !== 1'b1 || dut.cpu_inst.f[6] !== 1'b0 || dut.cpu_inst.f[5] !== 1'b0
                     || dut.cpu_inst.f[7] !== 1'b1) begin
            $display("FAIL: SCF gave C=%b N=%b H=%b Z=%b, expected C=1 N=0 H=0 Z=1 (unchanged from XOR)",
                dut.cpu_inst.f[4], dut.cpu_inst.f[6], dut.cpu_inst.f[5], dut.cpu_inst.f[7]);
            errors = errors + 1;
        end else begin
            $display("PASS: SCF correctly gave C=1, N=0, H=0, Z left unchanged at 1");
        end

        // -----------------------------------------------------------
        // Check 12c: CCF (0x3F)
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h005F && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h005F && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x005F/FETCH after CCF (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.f[4] !== 1'b0 || dut.cpu_inst.f[6] !== 1'b0 || dut.cpu_inst.f[5] !== 1'b0
                     || dut.cpu_inst.f[7] !== 1'b1) begin
            $display("FAIL: CCF gave C=%b N=%b H=%b Z=%b, expected C=0 N=0 H=0 Z=1 (unchanged)",
                dut.cpu_inst.f[4], dut.cpu_inst.f[6], dut.cpu_inst.f[5], dut.cpu_inst.f[7]);
            errors = errors + 1;
        end else begin
            $display("PASS: CCF correctly complemented C to 0, N=0, H=0, Z left unchanged at 1");
        end

        // -----------------------------------------------------------
        // Check 12d: Conditional RET (C0/RET NZ), both taken and
        // not-taken paths, plus the manual RET that follows the
        // not-taken case. Final SP==0xD000 confirms the stack stayed
        // balanced across both calls despite the asymmetry, if the
        // not-taken RET had incorrectly popped anyway, the subsequent
        // real RET would pop garbage and this whole chain would never
        // reach pc=0x006C at all.
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h006C && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h006C && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x006C/FETCH after conditional RET chain (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.b !== 8'h11) begin
            $display("FAIL: taken RET NZ subroutine didn't complete, B=0x%h, expected 0x11", dut.cpu_inst.b);
            errors = errors + 1;
        end else if (dut.cpu_inst.a !== 8'h99) begin
            $display("FAIL: not-taken RET NZ path wasn't exercised, A=0x%h, expected 0x99", dut.cpu_inst.a);
            errors = errors + 1;
        end else if (dut.cpu_inst.c !== 8'h22) begin
            $display("FAIL: final marker missing, C=0x%h, expected 0x22", dut.cpu_inst.c);
            errors = errors + 1;
        end else if (dut.cpu_inst.sp !== 16'hD000) begin
            $display("FAIL: SP not balanced after conditional RET chain, SP=0x%h, expected 0xD000", dut.cpu_inst.sp);
            errors = errors + 1;
        end else begin
            $display("PASS: RET NZ taken and not-taken paths both correct, stack balanced (SP=0xD000)");
        end

        // -----------------------------------------------------------
        // Check 12e: ADD SP, e8 -- positive immediate
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0071 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0071 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0071/FETCH after ADD SP,0x10 (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.sp !== 16'hD010 || dut.cpu_inst.f[5] !== 1'b0 || dut.cpu_inst.f[4] !== 1'b0
                     || dut.cpu_inst.f[7] !== 1'b0) begin
            $display("FAIL: ADD SP,0x10 gave SP=0x%h H=%b C=%b Z=%b, expected SP=0xD010 H=0 C=0 Z=0",
                dut.cpu_inst.sp, dut.cpu_inst.f[5], dut.cpu_inst.f[4], dut.cpu_inst.f[7]);
            errors = errors + 1;
        end else begin
            $display("PASS: ADD SP,0x10 correctly gave SP=0xD010, H=0, C=0, Z=0");
        end

        // -----------------------------------------------------------
        // Check 12f: ADD SP, e8 -- negative immediate (unsigned-add
        // flag quirk, same shape as the LD HL,SP+e8 negative case)
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0076 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0076 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0076/FETCH after ADD SP,-1 (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.sp !== 16'h00FE || dut.cpu_inst.f[5] !== 1'b1 || dut.cpu_inst.f[4] !== 1'b1
                     || dut.cpu_inst.f[7] !== 1'b0) begin
            $display("FAIL: ADD SP,-1 gave SP=0x%h H=%b C=%b Z=%b, expected SP=0x00FE H=1 C=1 Z=0",
                dut.cpu_inst.sp, dut.cpu_inst.f[5], dut.cpu_inst.f[4], dut.cpu_inst.f[7]);
            errors = errors + 1;
        end else begin
            $display("PASS: ADD SP,-1 correctly gave SP=0x00FE, H=1, C=1 despite subtraction, Z=0");
        end

        // -----------------------------------------------------------
        // Check 12g: RST 18H (0xDF) -- LAST check. Verifies the push
        // (correct return address, correct byte order, SP decremented
        // twice) and the jump to the vector, nothing more. Ends the
        // simulation immediately after, since every RST vector address
        // is already permanently defined by earlier checks' real
        // program bytes (a static $readmemh array can't hold two
        // different values at the same address for different points
        // in program-counter time), so nothing meaningful is at 0x0018
        // to actually execute.
        // -----------------------------------------------------------
        timeout = 0;
        while (!(dut.cpu_inst.pc === 16'h0018 && dut.cpu_inst.state === TB_STATE_FETCH) && timeout < 500) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        if (!(dut.cpu_inst.pc === 16'h0018 && dut.cpu_inst.state === TB_STATE_FETCH)) begin
            $display("FAIL: CPU never settled at pc=0x0018/FETCH after RST 18H (pc=%h, st=%0d, timeout)",
                dut.cpu_inst.pc, dut.cpu_inst.state);
            errors = errors + 1;
        end else if (dut.cpu_inst.sp !== 16'hCFFE) begin
            $display("FAIL: RST 18H left SP=0x%h, expected 0xCFFE (two pushes from 0xD000)", dut.cpu_inst.sp);
            errors = errors + 1;
        end else if (dut.memory_map_inst.wram[16'h0FFF] !== 8'h00) begin
            $display("FAIL: RST 18H pushed high byte 0x%h at 0xCFFF, expected 0x00 (return addr 0x007A)",
                dut.memory_map_inst.wram[16'h0FFF]);
            errors = errors + 1;
        end else if (dut.memory_map_inst.wram[16'h0FFE] !== 8'h7A) begin
            $display("FAIL: RST 18H pushed low byte 0x%h at 0xCFFE, expected 0x7A (return addr 0x007A)",
                dut.memory_map_inst.wram[16'h0FFE]);
            errors = errors + 1;
        end else begin
            $display("PASS: RST 18H correctly pushed return address 0x007A and jumped to vector 0x0018");
        end

        if (errors == 0)
            $display("ALL CHECKS PASSED");
        else
            $display("%0d CHECK(S) FAILED", errors);

        $finish;
    end

endmodule