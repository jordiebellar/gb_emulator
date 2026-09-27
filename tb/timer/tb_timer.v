// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_timer.v
// Author       : Jordie Bellar
// Date         : 2026-09-26
// Description  : Self-checking unit testbench for timer.v.
//
//                Enables come from a free-running divider shaped like
//                clk_div (ce_gb every 4 clocks, ce_m on every 4th ce_gb),
//                because the counter/M-cycle alignment is part of what is
//                under test. All CPU writes are driven the way the contract
//                says the CPU performs them: bus held from the start of an
//                M-cycle, committing on the ce_m edge that ends it.
//
//                Edge numbering used in the comments: setup() leaves the
//                system counter at 8 on edge E3; every later M-cycle edge
//                adds 4 T-cycles. With TAC select 01 (bit 3), the first
//                natural tick is E5 (counter 16), then every 4 edges.
//
//                Covers:
//                  - reset values and TAC's upper-bit read-back
//                  - DIV counting and DIV-write reset
//                  - TIMA rate for two TAC selects
//                  - every row of the glitch table (DIV write, disable,
//                    select change, change while disabled, enable)
//                  - overflow: 00 during A, reload and strobe on the same
//                    edge at the start of B
//                  - TIMA write in A cancels, TIMA write in B ignored,
//                    TMA write in B reaches TIMA, TMA write in A is used
//                  - design choice: TIMA write on the tick edge wins
//                  - monitors: every tick and every strobe lands on ce_m
//
//                Run:
//                  iverilog -o sim/tb_timer tb/timer/tb_timer.v rtl/timer/timer.v
//                  vvp sim/tb_timer
// =============================================================================
`timescale 1ns / 1ps
module tb_timer;

    reg         clk = 1'b0;
    reg         rst = 1'b1;
    reg  [15:0] addr = 16'h0000;
    reg  [7:0]  data_in = 8'h00;
    reg         we = 1'b0;
    reg         sel = 1'b0;
    wire [7:0]  data_out;
    wire        stall;
    wire        irq_timer;

    // ------------------------------------------------------------------
    // Enable divider, same shape as clk_div: ce_gb every 4 clocks here,
    // ce_m on every 4th ce_gb. Both single-clock, both reset together.
    // ------------------------------------------------------------------
    reg [1:0] gdiv;
    reg [1:0] mph;
    reg       ce_gb;
    reg       ce_m;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            gdiv  <= 2'd0;
            mph   <= 2'd0;
            ce_gb <= 1'b0;
            ce_m  <= 1'b0;
        end
        else begin
            ce_gb <= 1'b0;
            ce_m  <= 1'b0;
            gdiv  <= gdiv + 2'd1;
            if (gdiv == 2'd3) begin
                ce_gb <= 1'b1;
                mph   <= mph + 2'd1;
                if (mph == 2'd3) ce_m <= 1'b1;
            end
        end
    end

    timer uut (
        .clk(clk), .rst(rst), .ce_gb(ce_gb), .ce_m(ce_m),
        .addr(addr), .data_in(data_in), .we(we), .sel(sel),
        .data_out(data_out), .stall(stall),
        .irq_timer(irq_timer)
    );

    always #5 clk = ~clk; // 100 MHz

    localparam R_DIV  = 2'd0;
    localparam R_TIMA = 2'd1;
    localparam R_TMA  = 2'd2;
    localparam R_TAC  = 2'd3;

    integer checks = 0;
    integer fails  = 0;
    reg [7:0] rd;

    // ------------------------------------------------------------------
    // Monitors. Values read at a rising edge are the pre-edge values,
    // i.e. exactly what the design's own flip-flops sample on that edge.
    // ------------------------------------------------------------------
    integer irq_count  = 0;
    integer strobe_bad = 0;
    integer tick_bad   = 0;
    integer irq_base;

    always @(posedge clk) begin
        if (irq_timer) begin
            irq_count = irq_count + 1;
            if (!ce_m) strobe_bad = strobe_bad + 1;
        end
        if (uut.tima_tick && !ce_m) tick_bad = tick_bad + 1;
    end

    // ------------------------------------------------------------------
    // Helpers
    // ------------------------------------------------------------------
    task expect8(input [8*48-1:0] label, input [7:0] got, input [7:0] exp);
        begin
            checks = checks + 1;
            if (got === exp)
                $display("PASS  %0s  (%h)", label, got);
            else begin
                fails = fails + 1;
                $display("FAIL  %0s  expected %h  got %h", label, exp, got);
            end
        end
    endtask

    // Return 1 ns after the next rising edge that carries ce_m.
    // ce_m is registered, so it is stable at the negedge before that edge.
    task m_edge;
        begin
            @(negedge clk);
            while (ce_m !== 1'b1) @(negedge clk);
            @(posedge clk); #1;
        end
    endtask

    // CPU write: bus held through the M-cycle, commits on its ending edge.
    task cpu_write(input [1:0] r, input [7:0] d);
        begin
            sel = 1'b1; we = 1'b1; addr = 16'hFF04 + r; data_in = d;
            m_edge;
            sel = 1'b0; we = 1'b0;
        end
    endtask

    // CPU read: registered, one clock. Called right after an M-cycle edge,
    // it finishes long before the next one (16 clocks per M-cycle here).
    task cpu_read(input [1:0] r);
        begin
            sel = 1'b1; we = 1'b0; addr = 16'hFF04 + r;
            @(posedge clk); #1;
            rd = data_out;
            sel = 1'b0;
        end
    endtask

    // Known starting point for every timer test. Leaves TIMA = 00, the
    // counter = 8 (bit 3 set, bits 5/7/9 clear), TAC = tac_val, no tick.
    //   E0: TAC = 00       timer off, so the next writes can't glitch
    //   E1: DIV write      counter = 0
    //   E2: TIMA = 00      counter = 4
    //   E3: TAC = tac_val  counter = 8; enabling is a rising edge, no tick
    task setup(input [7:0] tac_val);
        begin
            cpu_write(R_TAC,  8'h00);
            cpu_write(R_DIV,  8'h00);
            cpu_write(R_TIMA, 8'h00);
            cpu_write(R_TAC,  tac_val);
        end
    endtask

    // ------------------------------------------------------------------
    // Tests
    // ------------------------------------------------------------------
    initial begin
        $dumpfile("sim/waves/tb_timer.vcd");
        $dumpvars(0, tb_timer);

        #12 rst = 1'b0;
        m_edge; // align to the start of an M-cycle

        // ---- Reset values ------------------------------------------------
        $display("\n-- reset --");
        cpu_read(R_DIV);  expect8("DIV after reset",               rd, 8'h00);
        cpu_read(R_TIMA); expect8("TIMA after reset",              rd, 8'h00);
        cpu_read(R_TMA);  expect8("TMA after reset",               rd, 8'h00);
        cpu_read(R_TAC);  expect8("TAC reads F8 after reset",      rd, 8'hF8);

        // ---- DIV ---------------------------------------------------------
        $display("\n-- DIV --");
        cpu_write(R_DIV, 8'h00);            // counter = 0
        repeat (64) m_edge;                 // 64 M-cycles = 256 T-cycles
        cpu_read(R_DIV);  expect8("DIV = 01 after 256 T-cycles",   rd, 8'h01);
        cpu_write(R_DIV, 8'hAB);            // any value resets
        cpu_read(R_DIV);  expect8("DIV write of AB resets to 00",  rd, 8'h00);

        // ---- TIMA rate -------------------------------------------------
        $display("\n-- TIMA rate --");
        setup(8'h05);
        cpu_read(R_TAC);  expect8("TAC reads FD after writing 05", rd, 8'hFD);
        repeat (8) m_edge;                  // E4..E11: ticks at E5, E9
        expect8("select 01: 2 ticks in 8 M-cycles",   uut.tima, 8'h02);

        setup(8'h06);                       // select 10 = bit 5
        repeat (13) m_edge;                 // E4..E16: counter 12..60
        expect8("select 10: no tick before counter 64", uut.tima, 8'h00);
        m_edge;                             // E17: counter 64, bit 5 falls
        expect8("select 10: tick at counter 64",      uut.tima, 8'h01);

        // ---- Glitch table ------------------------------------------------
        $display("\n-- glitch table --");
        setup(8'h05);
        m_edge;                             // E4: counter 12, no write
        expect8("control: no tick at E4",             uut.tima, 8'h00);
        m_edge;                             // E5: natural tick
        expect8("control: natural tick at E5",        uut.tima, 8'h01);

        setup(8'h05);
        cpu_write(R_DIV, 8'h00);            // E4: bit 3 was 1 -> 0
        expect8("DIV write with bit set ticks",       uut.tima, 8'h01);

        setup(8'h05);
        cpu_write(R_TAC, 8'h01);            // E4: disable, bit 3 was 1
        expect8("disable with bit set ticks",         uut.tima, 8'h01);

        setup(8'h05);
        cpu_write(R_TAC, 8'h06);            // E4: bit 3 (1) -> bit 5 (0)
        expect8("select 1-bit to 0-bit ticks",        uut.tima, 8'h01);

        setup(8'h01);                       // timer disabled
        cpu_write(R_DIV, 8'h00);            // E4: bit 3 was 1, but disabled
        expect8("DIV write while disabled: no tick",  uut.tima, 8'h00);

        setup(8'h01);                       // timer disabled
        cpu_write(R_TAC, 8'h05);            // E4: enable with bit 3 = 1
        expect8("enable with bit set: no tick",       uut.tima, 8'h00);
        m_edge;                             // E5: bit 3 falls, now enabled
        expect8("enabled: next fall ticks once",      uut.tima, 8'h01);

        // ---- Overflow sequence -------------------------------------------
        $display("\n-- overflow --");
        cpu_write(R_TMA, 8'h23);
        setup(8'h05);
        cpu_write(R_TIMA, 8'hFF);           // E4
        irq_base = irq_count;
        m_edge;                             // E5: FF -> 00, cycle A begins
        expect8("A: TIMA register is 00",             uut.tima, 8'h00);
        cpu_read(R_TIMA);
        expect8("A: TIMA reads 00",                   rd, 8'h00);
        expect8("A: no interrupt yet",                irq_count - irq_base, 8'd0);
        m_edge;                             // E6: reload + strobe, B begins
        expect8("B: TIMA reloaded from TMA",          uut.tima, 8'h23);
        expect8("B: strobe fired on the reload edge", irq_count - irq_base, 8'd1);
        m_edge;                             // E7: end of B
        expect8("after B: TIMA still TMA",            uut.tima, 8'h23);
        expect8("after B: exactly one strobe",        irq_count - irq_base, 8'd1);

        // ---- Rule 1: TIMA write in A cancels -----------------------------
        $display("\n-- write rules --");
        setup(8'h05);
        cpu_write(R_TIMA, 8'hFF);           // E4
        irq_base = irq_count;
        m_edge;                             // E5: overflow, cycle A
        cpu_write(R_TIMA, 8'h42);           // E6: write during A
        expect8("rule 1: written value kept",         uut.tima, 8'h42);
        m_edge;                             // E7
        expect8("rule 1: no reload afterwards",       uut.tima, 8'h42);
        expect8("rule 1: no interrupt",               irq_count - irq_base, 8'd0);

        // ---- Rule 2: TIMA write in B ignored -----------------------------
        setup(8'h05);
        cpu_write(R_TIMA, 8'hFF);           // E4
        irq_base = irq_count;
        m_edge;                             // E5: overflow
        m_edge;                             // E6: reload
        cpu_write(R_TIMA, 8'h99);           // E7: write during B
        expect8("rule 2: TIMA write in B ignored",    uut.tima, 8'h23);
        expect8("rule 2: interrupt still fired once", irq_count - irq_base, 8'd1);

        // ---- Rule 3: TMA write in B reaches TIMA ---------------------------
        setup(8'h05);
        cpu_write(R_TIMA, 8'hFF);           // E4
        m_edge;                             // E5: overflow
        m_edge;                             // E6: reload with 23
        cpu_write(R_TMA, 8'h55);            // E7: TMA write during B
        expect8("rule 3: TIMA follows new TMA",       uut.tima, 8'h55);
        expect8("rule 3: TMA holds new value",        uut.tma,  8'h55);

        // ---- TMA write in A is used by the reload (TMA is a latch) -------
        cpu_write(R_TMA, 8'h23);
        setup(8'h05);
        cpu_write(R_TIMA, 8'hFF);           // E4
        irq_base = irq_count;
        m_edge;                             // E5: overflow
        cpu_write(R_TMA, 8'h66);            // E6: TMA write, reload same edge
        expect8("TMA write in A: reload uses it",     uut.tima, 8'h66);
        expect8("TMA write in A: interrupt fires",    irq_count - irq_base, 8'd1);

        // ---- Design choice: TIMA write on the tick edge wins ------------
        $display("\n-- design choice --");
        setup(8'h05);
        cpu_write(R_TIMA, 8'hFF);           // E4
        irq_base = irq_count;
        cpu_write(R_TIMA, 8'h10);           // E5: write on the tick edge
        expect8("write on tick edge wins",            uut.tima, 8'h10);
        repeat (3) m_edge;                  // E6..E8: no ticks due
        expect8("no overflow sequence followed",      uut.tima, 8'h10);
        expect8("no interrupt from suppressed tick",  irq_count - irq_base, 8'd0);

        // ---- Monitors ------------------------------------------------------
        $display("\n-- monitors --");
        expect8("every TIMA tick landed on ce_m",     tick_bad,   8'd0);
        expect8("every strobe landed on ce_m",        strobe_bad, 8'd0);
        expect8("stall is always low",                {7'b0, stall}, 8'h00);

        // ---- Summary -------------------------------------------------------
        $display("\n%0d checks, %0d failed.", checks, fails);
        if (fails == 0)
            $display("ALL TIMER CHECKS PASSED");
        else
            $display("TIMER CHECKS FAILED");
        $finish;
    end

endmodule