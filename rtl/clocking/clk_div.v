// =============================================================================
// Project      : GameBoy Emulator
// File         : clk_div.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : generates every clock-enable pulse the design runs on -
//                  ce_gb at ~4.194304MHz (t-cycle, phase-accumulator
//                  divider) for the cpu, bus, and gb-rate peripherals;
//                  ce_m, one pulse on every 4th ce_gb, coincident with
//                  it, for bus commits (writes, fetches, acknowledges)
//                  per interface contract rev 2 section 6; ce_vga at
//                  25MHz for the video subsystem. all derived from the
//                  single real 100MHz clk_100m, not separate physical
//                  clocks.
// Revision     : 2.0 - added ce_m per rev 2 of the interface contract
// =============================================================================
`timescale 1ns / 1ps

module clk_div (
    input  wire clk_100m,
    input  wire rst,
    output reg  ce_gb,
    output wire ce_m,
    output reg  ce_vga
);

    localparam integer W         = 32;
    localparam [31:0]  INCREMENT = 32'd180143985; // round(2^32 * 4.194304MHz / 100MHz)

    reg  [W-1:0] gb_acc;
    wire [W:0]   gb_acc_next = {1'b0, gb_acc} + INCREMENT;

    always @(posedge clk_100m or posedge rst) begin
        if (rst) begin
            gb_acc <= {W{1'b0}};
            ce_gb  <= 1'b0;
        end
        else begin
            gb_acc <= gb_acc_next[W-1:0];
            ce_gb  <= gb_acc_next[W];
        end
    end

    // m-cycle enable, one pulse on every 4th ce_gb, coincident with it.
    // t_cycle_count is a plain free-running 2-bit counter of ce_gb
    // pulses, wrapping on its own 2-bit overflow. ce_m is a
    // combinational function of ce_gb and the counter's CURRENT value,
    // not a separate registered pulse - a registered ce_m would add a
    // clock of latency, the exact same class of bug as a registered
    // irq strobe (section 5)
    reg [1:0] t_cycle_count;

    always @(posedge clk_100m or posedge rst) begin
        if (rst)
            t_cycle_count <= 2'd0;
        else if (ce_gb)
            t_cycle_count <= t_cycle_count + 2'd1; // wraps 3->0 on its own
    end

    assign ce_m = ce_gb && (t_cycle_count == 2'd3);

    reg [1:0] vga_count;

    always @(posedge clk_100m or posedge rst) begin
        if (rst) begin
            vga_count <= 2'd0;
            ce_vga    <= 1'b0;
        end
        else if (vga_count == 2'd3) begin
            vga_count <= 2'd0;
            ce_vga    <= 1'b1;
        end
        else begin
            vga_count <= vga_count + 2'd1;
            ce_vga    <= 1'b0;
        end
    end

endmodule