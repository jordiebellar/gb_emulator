// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_clk_div.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : directed testbench for clk_div - checks ce_gb pulse timing
//                  against a golden model computed offline from the same
//                  increment (first pulse cycle, exact count over a fixed
//                  window, bounded gap between pulses), checks ce_vga's
//                  exact mod-4 alignment, checks both enables are never
//                  high two cycles in a row, checks async reset drops all
//                  three enables immediately and restarts timing cleanly,
//                  and (rev 2) checks ce_m: always coincident with ce_gb,
//                  never asserted without it, and exactly 4 ce_gb pulses
//                  between consecutive ce_m pulses, every time.
// Revision     : 2.0 - added ce_m checks per interface contract rev 2
// =============================================================================
`timescale 1ns / 1ps

module tb_clk_div;

    reg clk_100m;
    reg rst;
    wire ce_gb;
    wire ce_m;
    wire ce_vga;

    initial clk_100m = 1'b0;
    always #5 clk_100m = ~clk_100m; // 100MHz, 10ns period

    integer errors = 0;
    integer checks = 0;

    clk_div dut (
        .clk_100m (clk_100m),
        .rst      (rst),
        .ce_gb    (ce_gb),
        .ce_m     (ce_m),
        .ce_vga   (ce_vga)
    );

    localparam integer GB_FIRST_PULSE    = 24;
    localparam integer GB_PULSES_IN_1000  = 41;
    localparam integer VGA_PERIOD         = 4;
    localparam integer WINDOW_CYCLES      = 1000;
    localparam integer M_PULSE_PERIOD     = 4; // ce_gb pulses per ce_m pulse

    integer cycle_count;
    integer gb_pulse_count;
    integer vga_pulse_count;
    integer m_pulse_count;
    integer last_gb_pulse_cycle;
    integer gb_since_last_m;
    integer gap;
    reg     prev_ce_gb;
    reg     prev_ce_vga;
    reg     first_m_seen;

    task run_window(input integer n_cycles);
        integer i;
        begin
            cycle_count         = 0;
            gb_pulse_count      = 0;
            vga_pulse_count     = 0;
            m_pulse_count       = 0;
            last_gb_pulse_cycle = -1;
            gb_since_last_m     = 0;
            first_m_seen        = 1'b0;
            prev_ce_gb          = 1'b0;
            prev_ce_vga         = 1'b0;

            for (i = 0; i < n_cycles; i = i + 1) begin
                @(posedge clk_100m);
                #1;
                cycle_count = cycle_count + 1;

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

                checks = checks + 1;
                if (ce_m && !ce_gb) begin
                    errors = errors + 1;
                    $display("FAIL ce_m asserted without ce_gb at cycle %0d", cycle_count);
                end

                if (ce_gb) begin
                    gb_pulse_count = gb_pulse_count + 1;
                    gb_since_last_m = gb_since_last_m + 1;

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

                if (ce_m) begin
                    m_pulse_count = m_pulse_count + 1;

                    checks = checks + 1;
                    if (!ce_gb) begin
                        errors = errors + 1;
                        $display("FAIL ce_m fired at cycle %0d but ce_gb was not high", cycle_count);
                    end

                    if (!first_m_seen) begin
                        first_m_seen = 1'b1;
                        checks = checks + 1;
                        if (gb_pulse_count !== M_PULSE_PERIOD) begin
                            errors = errors + 1;
                            $display("FAIL first ce_m: expected on the %0dth ce_gb pulse, fired on the %0dth",
                                      M_PULSE_PERIOD, gb_pulse_count);
                        end
                    end
                    else begin
                        checks = checks + 1;
                        if (gb_since_last_m !== M_PULSE_PERIOD) begin
                            errors = errors + 1;
                            $display("FAIL ce_m period: expected exactly %0d ce_gb pulses since the last one, got %0d, at cycle %0d",
                                      M_PULSE_PERIOD, gb_since_last_m, cycle_count);
                        end
                    end
                    gb_since_last_m = 0;
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
        @(negedge clk_100m);
        rst = 1'b0;

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

        checks = checks + 1;
        if (m_pulse_count !== GB_PULSES_IN_1000 / M_PULSE_PERIOD) begin
            errors = errors + 1;
            $display("FAIL ce_m count over %0d cycles: expected %0d got %0d",
                      WINDOW_CYCLES, GB_PULSES_IN_1000 / M_PULSE_PERIOD, m_pulse_count);
        end

        @(negedge clk_100m);
        rst = 1'b1;
        #1;
        checks = checks + 1;
        if (ce_gb !== 1'b0 || ce_m !== 1'b0 || ce_vga !== 1'b0) begin
            errors = errors + 1;
            $display("FAIL async reset: ce_gb=%b ce_m=%b ce_vga=%b, expected all 0 immediately",
                      ce_gb, ce_m, ce_vga);
        end

        @(negedge clk_100m);
        rst = 1'b0;
        run_window(100);

        checks = checks + 1;
        if (gb_pulse_count < 1) begin
            errors = errors + 1;
            $display("FAIL post-reset: no ce_gb pulse observed in 100 cycles after reset release");
        end
        checks = checks + 1;
        if (m_pulse_count < 1) begin
            errors = errors + 1;
            $display("FAIL post-reset: no ce_m pulse observed in 100 cycles after reset release");
        end

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule