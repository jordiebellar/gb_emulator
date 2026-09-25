// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_clk_div.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : directed testbench for clk_div - checks ce_gb pulse timing
//                  against a golden model computed offline from the same
//                  increment (first pulse cycle, exact count over a fixed
//                  window, bounded gap between pulses), checks ce_vga's
//                  exact mod-4 alignment, checks both enables are never
//                  high two cycles in a row, and checks async reset drops
//                  both immediately and restarts timing cleanly
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_clk_div;

    reg clk_100m;
    reg rst;
    wire ce_gb;
    wire ce_vga;

    initial clk_100m = 1'b0;
    always #5 clk_100m = ~clk_100m; // 100MHz, 10ns period

    integer errors = 0;
    integer checks = 0;

    clk_div dut (
        .clk_100m (clk_100m),
        .rst      (rst),
        .ce_gb    (ce_gb),
        .ce_vga   (ce_vga)
    );

    // -------------------------------------------------------------------
    // golden model, computed offline in python from the same 32-bit
    // accumulator and increment=180143985: first ce_gb pulse lands on
    // the 24th posedge after reset releases, gaps between pulses are
    // only ever 23 or 24 cycles (2^32/increment ~= 23.8447, so those are
    // the only two integer gaps possible), and exactly 41 pulses land in
    // the first 1000 cycles. ce_vga is exact, every 4th cycle, no
    // jitter, since 100MHz/25MHz divides evenly.
    // -------------------------------------------------------------------
    localparam integer GB_FIRST_PULSE    = 24;
    localparam integer GB_PULSES_IN_1000  = 41;
    localparam integer VGA_PERIOD         = 4;
    localparam integer WINDOW_CYCLES      = 1000;

    integer cycle_count;
    integer gb_pulse_count;
    integer vga_pulse_count;
    integer last_gb_pulse_cycle;
    integer gap;
    reg     prev_ce_gb;
    reg     prev_ce_vga;

    task run_window(input integer n_cycles);
        integer i;
        begin
            cycle_count         = 0;
            gb_pulse_count      = 0;
            vga_pulse_count     = 0;
            last_gb_pulse_cycle = -1;
            prev_ce_gb          = 1'b0;
            prev_ce_vga         = 1'b0;

            for (i = 0; i < n_cycles; i = i + 1) begin
                @(posedge clk_100m);
                #1; // let the registered outputs settle after the edge
                cycle_count = cycle_count + 1;

                // pulse-width check, neither enable should stay high two
                // cycles in a row - checked every single cycle
                checks = checks + 1;
                if (prev_ce_gb && ce_gb) begin
                    errors = errors + 1;
                    $display("FAIL ce_gb stayed high two cycles in a row at cycle %0d", cycle_count);
                end
                checks = checks + 1;
                if (prev_ce_vga && ce_vga) begin
                    errors = errors + 1;
                    $display("FAIL ce_vga stayed high two cycles in a row at cycle %0d", cycle_count);
                end

                if (ce_gb) begin
                    gb_pulse_count = gb_pulse_count + 1;
                    if (gb_pulse_count == 1) begin
                        checks = checks + 1;
                        if (cycle_count !== GB_FIRST_PULSE) begin
                            errors = errors + 1;
                            $display("FAIL ce_gb first pulse: expected cycle %0d got %0d",
                                      GB_FIRST_PULSE, cycle_count);
                        end
                    end
                    else begin
                        gap = cycle_count - last_gb_pulse_cycle;
                        checks = checks + 1;
                        if (gap !== 23 && gap !== 24) begin
                            errors = errors + 1;
                            $display("FAIL ce_gb gap out of bounds: %0d at cycle %0d (expected 23 or 24)",
                                      gap, cycle_count);
                        end
                    end
                    last_gb_pulse_cycle = cycle_count;
                end

                if (ce_vga) begin
                    vga_pulse_count = vga_pulse_count + 1;
                    checks = checks + 1;
                    if (cycle_count % VGA_PERIOD !== 0) begin
                        errors = errors + 1;
                        $display("FAIL ce_vga misaligned: fired at cycle %0d, not a multiple of %0d",
                                  cycle_count, VGA_PERIOD);
                    end
                end

                prev_ce_gb  = ce_gb;
                prev_ce_vga = ce_vga;
            end
        end
    endtask

    initial begin
        rst = 1'b1;
        repeat (4) @(posedge clk_100m);
        @(negedge clk_100m); // avoid a same-edge race with the dut's reset logic
        rst = 1'b0;

        // --- golden window, exact deterministic pulse counts -----------
        run_window(WINDOW_CYCLES);

        checks = checks + 1;
        if (gb_pulse_count !== GB_PULSES_IN_1000) begin
            errors = errors + 1;
            $display("FAIL ce_gb count over %0d cycles: expected %0d got %0d",
                      WINDOW_CYCLES, GB_PULSES_IN_1000, gb_pulse_count);
        end

        checks = checks + 1;
        if (vga_pulse_count !== WINDOW_CYCLES / VGA_PERIOD) begin
            errors = errors + 1;
            $display("FAIL ce_vga count over %0d cycles: expected %0d got %0d",
                      WINDOW_CYCLES, WINDOW_CYCLES / VGA_PERIOD, vga_pulse_count);
        end

        // --- mid-run async reset, both enables must drop immediately ---
        @(negedge clk_100m);
        rst = 1'b1;
        #1;
        checks = checks + 1;
        if (ce_gb !== 1'b0 || ce_vga !== 1'b0) begin
            errors = errors + 1;
            $display("FAIL async reset: ce_gb=%b ce_vga=%b, expected both 0 immediately",
                      ce_gb, ce_vga);
        end

        // --- release reset, timing must restart cleanly from cycle 0 ---
        // reusing run_window here means its own internal "first pulse"
        // check re-validates that the accumulator actually cleared,
        // rather than resuming from whatever state it held before reset
        @(negedge clk_100m);
        rst = 1'b0;
        run_window(100);

        checks = checks + 1;
        if (gb_pulse_count < 1) begin
            errors = errors + 1;
            $display("FAIL post-reset: no ce_gb pulse observed in 100 cycles after reset release");
        end

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule
