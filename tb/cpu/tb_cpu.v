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

        if (errors == 0)
            $display("ALL CHECKS PASSED");
        else
            $display("%0d CHECK(S) FAILED", errors);

        $finish;
    end

endmodule