// =============================================================================
// Project      : GameBoy Emulator
// File         : joypad.v
// Author       : Aaron Luebbert
// Date         : 2026-09-14
// Description  : p1/joyp register at 0xFF00. cpu writes bits 4-5 to select
//                  the direction group or button group, reads bits 0-3 back
//                  active-low. both groups selected at once reads the AND
//                  of both (real hardware behavior). raw button inputs are
//                  logical, active-high = pressed - board-level electrical
//                  mapping (basys3 buttons/switches, debouncing) happens in
//                  gb_top.v / xdc, not here. also produces a one-cycle
//                  irq_joypad pulse on any selected button's press edge.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module joypad (
    input  wire        clk,
    input  wire        ce,
    input  wire        rst,
    input  wire [15:0] addr,     // unused internally, single register, sel already disambiguates
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output reg  [7:0]  data_out,
    output wire        stall,    // p1 never blocks the cpu

    // raw logical button state, active-high = pressed
    input  wire btn_right,
    input  wire btn_left,
    input  wire btn_up,
    input  wire btn_down,
    input  wire btn_a,
    input  wire btn_b,
    input  wire btn_select,
    input  wire btn_start,

    output reg  irq_joypad // one ce-cycle pulse on a selected button's press edge
);

    assign stall = 1'b0;

    // select bits, active-low per real hardware (0 = that group selected)
    // default both unselected on reset, matches real p1 power-on state
    reg sel_btn;
    reg sel_dir;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sel_btn <= 1'b1;
            sel_dir <= 1'b1;
        end
        else if (ce && sel && we) begin
            sel_btn <= data_in[5];
            sel_dir <= data_in[4];
        end
    end

    // active-low nibble for each group, order matches real hardware
    // p10-p13 line assignment
    wire [3:0] dir_bits = ~{btn_down, btn_up, btn_left, btn_right};
    wire [3:0] btn_bits = ~{btn_start, btn_select, btn_b, btn_a};

    // combinational, recomputed every cycle regardless of bus access -
    // this is the live button state, not a bus-read snapshot
    reg [3:0] nibble;
    always @(*) begin
        case ({sel_btn, sel_dir})
            2'b10:   nibble = dir_bits;              // sel_dir=0 (selected), sel_btn=1 (not)
            2'b01:   nibble = btn_bits;               // sel_btn=0 (selected), sel_dir=1 (not)
            2'b00:   nibble = dir_bits & btn_bits;   // both selected, real hw ANDs them
            default: nibble = 4'hF;                  // 2'b11, neither selected
        endcase
    end

    // bus read, registered same as every other peripheral, valid one
    // cycle after sel settles
    always @(posedge clk) begin
        if (ce && sel)
            data_out <= {2'b11, sel_btn, sel_dir, nibble};
    end

    // irq on a press edge (nibble bit falling from 1 to 0), monitored
    // continuously, independent of whether the cpu happens to be reading
    // the register this cycle
    reg [3:0] nibble_prev;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            nibble_prev <= 4'hF;
            irq_joypad  <= 1'b0;
        end
        else if (ce) begin
            irq_joypad <= |(nibble_prev & ~nibble); // any bit that was 1, now 0
            nibble_prev <= nibble;
        end
    end

endmodule