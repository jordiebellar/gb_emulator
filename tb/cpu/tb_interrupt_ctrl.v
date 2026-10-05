// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_interrupt_ctrl.v
// Author       : Jordie Bellar
// Date         : 2026-09-26
// Description  : Self-checking unit testbench for interrupt_ctrl.v.
//
//                The enables are driven by hand instead of from a free-running
//                divider, so every test controls exactly which clock edges
//                carry ce_gb and ce_m. ce_m is only ever asserted together
//                with ce_gb, matching clk_div.
//
//                Stimulus convention: every input changes 1 ns after a rising
//                edge, so it is stable well before the next edge samples it.
//
//                Reads are combinational and return the post-edge value, so
//                bus_read samples data_out mid-clock, before the edge, the
//                same way the CPU samples data_in on its ce_m edge.
//
//                Covers:
//                  - reset values and both read-back formats
//                  - IE stores all 8 bits, IF stores only 5
//                  - bus writes commit on ce_m only
//                  - each irq line sets its own IF bit (catches a reversed
//                    concatenation), sampled on ce_gb only
//                  - acknowledge commits on ce_m only
//                  - same-clock collisions: request wins
//                  - a read on a request edge sees the new bit
//                  - CPU-facing if_reg has upper bits 0 (no phantom pending)
//                  - accesses without sel are ignored
//
//                Run:
//                  iverilog -o sim/tb_interrupt_ctrl tb/cpu/tb_interrupt_ctrl.v rtl/cpu/interrupt_ctrl.v
//                  vvp sim/tb_interrupt_ctrl
// Revision     : 1.0 - Initial implementation
//                1.1 - Next-state reads: sample before the edge, add
//                      same-edge read checks
// =============================================================================
`timescale 1ns / 1ps
module tb_interrupt_ctrl;

    reg         clk = 1'b0;
    reg         rst = 1'b1;
    reg         ce_gb = 1'b0;
    reg         ce_m = 1'b0;
    reg  [15:0] addr = 16'h0000;
    reg  [7:0]  data_in = 8'h00;
    reg         we = 1'b0;
    reg         sel = 1'b0;
    wire [7:0]  data_out;
    wire        stall;
    reg         irq_vblank = 1'b0;
    reg         irq_lcdstat = 1'b0;
    reg         irq_timer = 1'b0;
    reg         irq_serial = 1'b0;
    reg         irq_joypad = 1'b0;
    reg  [7:0]  if_clear = 8'h00;
    reg         if_clear_we = 1'b0;
    wire [7:0]  ie;
    wire [7:0]  if_reg;

    interrupt_ctrl uut (
        .clk(clk), .rst(rst), .ce_gb(ce_gb), .ce_m(ce_m),
        .addr(addr), .data_in(data_in), .we(we), .sel(sel),
        .data_out(data_out), .stall(stall),
        .irq_vblank(irq_vblank), .irq_lcdstat(irq_lcdstat),
        .irq_timer(irq_timer), .irq_serial(irq_serial), .irq_joypad(irq_joypad),
        .if_clear(if_clear), .if_clear_we(if_clear_we),
        .ie(ie), .if_reg(if_reg)
    );

    always #5 clk = ~clk; // 100 MHz

    localparam ADDR_IF = 16'hFF0F;
    localparam ADDR_IE = 16'hFFFF;

    integer checks = 0;
    integer fails  = 0;
    reg [7:0] rd;

    // ------------------------------------------------------------------
    // Helpers
    // ------------------------------------------------------------------

    // Compare two bytes, with === so an X or Z counts as a failure.
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

    // One rising edge carrying the given enables. Enables drop right after.
    task tick(input g, input m);
        begin
            ce_gb = g;
            ce_m  = m;
            @(posedge clk); #1;
            ce_gb = 1'b0;
            ce_m  = 1'b0;
        end
    endtask

    // A CPU write as the contract describes it: bus held for a full
    // M-cycle (three ce_gb ticks with plain clocks between), committing
    // on the fourth ce_gb tick, which carries ce_m.
    task bus_write(input [15:0] a, input [7:0] d);
        begin
            sel = 1'b1; we = 1'b1; addr = a; data_in = d;
            tick(1, 0); tick(0, 0);
            tick(1, 0); tick(0, 0);
            tick(1, 0); tick(0, 0);
            tick(1, 1);
            sel = 1'b0; we = 1'b0;
        end
    endtask

    // A bus read on a clock with no enables. data_out is combinational
    // (post-edge value), so it is sampled mid-clock, before the edge.
    // With no enables, post-edge equals current state.
    task bus_read(input [15:0] a);
        begin
            sel = 1'b1; we = 1'b0; addr = a;
            #2;
            rd = data_out;
            tick(0, 0);
            sel = 1'b0;
        end
    endtask

    // Raise one request line for one clock, the clock carrying ce_gb.
    task request(input [2:0] n);
        begin
            case (n)
                3'd0: irq_vblank  = 1'b1;
                3'd1: irq_lcdstat = 1'b1;
                3'd2: irq_timer   = 1'b1;
                3'd3: irq_serial  = 1'b1;
                3'd4: irq_joypad  = 1'b1;
                default: ;
            endcase
            tick(1, 0);
            {irq_joypad, irq_serial, irq_timer, irq_lcdstat, irq_vblank} = 5'b00000;
        end
    endtask

    // ------------------------------------------------------------------
    // Tests
    // ------------------------------------------------------------------
    initial begin
        $dumpfile("sim/waves/tb_interrupt_ctrl.vcd");
        $dumpvars(0, tb_interrupt_ctrl);

        #12 rst = 1'b0;
        @(posedge clk); #1;

        // Reset values 
        $display("\n-- reset --");
        expect8("ie output after reset",           ie,     8'h00);
        expect8("if_reg output after reset",       if_reg, 8'h00);
        bus_read(ADDR_IE);
        expect8("IE bus read after reset",         rd,     8'h00);
        bus_read(ADDR_IF);
        expect8("IF bus read after reset (E0)",    rd,     8'hE0);

        // IE stores all 8 bits
        $display("\n-- IE width --");
        bus_write(ADDR_IE, 8'hFF);
        expect8("ie output after writing FF",      ie,     8'hFF);
        bus_read(ADDR_IE);
        expect8("IE reads back FF, upper bits kept", rd,   8'hFF);

        // IF stores only 5 bits, two views
        $display("\n-- IF width and views --");
        bus_write(ADDR_IF, 8'hFF);
        bus_read(ADDR_IF);
        expect8("IF bus read after writing FF",    rd,     8'hFF);
        expect8("if_reg after writing FF (1F)",    if_reg, 8'h1F);
        bus_write(ADDR_IF, 8'hE0);
        bus_read(ADDR_IF);
        expect8("IF bus read after writing E0",    rd,     8'hE0);
        expect8("if_reg after writing E0 (00)",    if_reg, 8'h00);

        // Writes commit on ce_m only
        $display("\n-- write commit timing --");
        sel = 1'b1; we = 1'b1; addr = ADDR_IE; data_in = 8'h5A;
        tick(1, 0); tick(0, 0);
        tick(1, 0); tick(0, 0);
        tick(1, 0); tick(0, 0);
        expect8("IE unchanged before ce_m",        ie,     8'hFF);
        tick(1, 1);
        sel = 1'b0; we = 1'b0;
        expect8("IE updated on ce_m",              ie,     8'h5A);
        bus_write(ADDR_IE, 8'h00);

        // Each request line sets its own bit
        $display("\n-- request bit mapping --");
        bus_write(ADDR_IF, 8'h00);
        request(3'd0);
        expect8("irq_vblank sets bit 0",           if_reg, 8'h01);
        bus_write(ADDR_IF, 8'h00);
        request(3'd1);
        expect8("irq_lcdstat sets bit 1",          if_reg, 8'h02);
        bus_write(ADDR_IF, 8'h00);
        request(3'd2);
        expect8("irq_timer sets bit 2",            if_reg, 8'h04);
        bus_write(ADDR_IF, 8'h00);
        request(3'd3);
        expect8("irq_serial sets bit 3",           if_reg, 8'h08);
        bus_write(ADDR_IF, 8'h00);
        request(3'd4);
        expect8("irq_joypad sets bit 4",           if_reg, 8'h10);

        // Requests sampled on ce_gb only, and accumulate
        $display("\n-- request sampling --");
        bus_write(ADDR_IF, 8'h00);
        irq_timer = 1'b1;
        tick(0, 0); tick(0, 0); tick(0, 0);
        expect8("request ignored without ce_gb",   if_reg, 8'h00);
        tick(1, 0);
        irq_timer = 1'b0;
        expect8("request taken on ce_gb",          if_reg, 8'h04);
        request(3'd0);
        expect8("second request adds, keeps first", if_reg, 8'h05);

        // Acknowledge commits on ce_m only
        $display("\n-- acknowledge --");
        if_clear = 8'h04; if_clear_we = 1'b1;
        tick(1, 0); tick(0, 0);
        expect8("ack ignored before ce_m",         if_reg, 8'h05);
        tick(1, 1);
        if_clear_we = 1'b0; if_clear = 8'h00;
        expect8("ack clears only its bit on ce_m", if_reg, 8'h01);

        // Same-clock collisions: request wins
        $display("\n-- collisions --");
        bus_write(ADDR_IF, 8'h04);
        sel = 1'b1; we = 1'b1; addr = ADDR_IF; data_in = 8'h00;
        irq_vblank = 1'b1;
        tick(1, 1);
        sel = 1'b0; we = 1'b0; irq_vblank = 1'b0;
        expect8("write 00 + vblank same clock",    if_reg, 8'h01);

        bus_write(ADDR_IF, 8'h04);
        if_clear = 8'h04; if_clear_we = 1'b1;
        irq_timer = 1'b1;
        tick(1, 1);
        if_clear_we = 1'b0; if_clear = 8'h00; irq_timer = 1'b0;
        expect8("ack bit 2 + timer same clock",    if_reg, 8'h04);

        // Same-edge read: hardware update first, then the access
        $display("\n-- same-edge read --");
        bus_write(ADDR_IF, 8'h00);
        sel = 1'b1; we = 1'b0; addr = ADDR_IF;
        irq_timer = 1'b1; ce_gb = 1'b1; ce_m = 1'b1;   // CPU samples on this edge
        #2;
        rd = data_out;
        expect8("IF read on request edge sees bit", rd,    8'hE4);
        @(posedge clk); #1;
        ce_gb = 1'b0; ce_m = 1'b0; irq_timer = 1'b0; sel = 1'b0;
        expect8("bit is stored after the edge",    if_reg, 8'h04);

        // CPU view has no phantom bits
        $display("\n-- CPU view --");
        bus_write(ADDR_IE, 8'hFF);
        bus_write(ADDR_IF, 8'h00);
        bus_read(ADDR_IF);
        expect8("bus sees E0 with nothing pending", rd,    8'hE0);
        expect8("CPU sees ie & if_reg == 0",       ie & if_reg, 8'h00);
        bus_write(ADDR_IF, 8'h04);
        expect8("software request visible to CPU", ie & if_reg, 8'h04);

        // Accesses without sel are ignored 
        $display("\n-- sel gating --");
        sel = 1'b0; we = 1'b1; addr = ADDR_IF; data_in = 8'h1F;
        tick(1, 1);
        we = 1'b0;
        expect8("write without sel ignored",       if_reg, 8'h04);
        sel = 1'b0; addr = ADDR_IF;
        #2;
        expect8("data_out is 00 when not selected", data_out, 8'h00);
        expect8("stall is always low",             {7'b0, stall}, 8'h00);

        // Summary 
        $display("\n%0d checks, %0d failed.", checks, fails);
        if (fails == 0)
            $display("ALL INTERRUPT_CTRL CHECKS PASSED");
        else
            $display("INTERRUPT_CTRL CHECKS FAILED");
        $finish;
    end

endmodule