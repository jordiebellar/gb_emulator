// =============================================================================
// Project      : GameBoy Emulator
// File         : joypad.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : p1/joyp register. cpu writes bits 4-5 to select the
//                  direction group or button group, committed on
//                  sel && we && ce_m. reads bits 0-3 back active-low,
//                  fully combinational (button state can change between
//                  m-cycles independent of the cpu, so there's nothing
//                  to latch). both groups selected at once reads the AND
//                  of both (real hardware behavior). raw button inputs
//                  are logical, active-high = pressed - board-level
//                  electrical mapping happens in gb_top.v / xdc.
//                  irq_joypad is a combinational strobe (section 5): high
//                  for exactly the ce_gb cycle where a selected button's
//                  press edge is detected, not a registered pulse - a
//                  registered irq would add a t-cycle of latency.
// Revision     : 2.0 - ce split into ce_gb (drives the button-edge
//                  monitor) / ce_m (drives the select-bit write); fixed
//                  irq_joypad from a registered pulse to a combinational
//                  strobe; data_out is now combinational and 0 when
//                  deselected (section 3), not registered.
// =============================================================================
`timescale 1ns / 1ps

module joypad (
    input  wire        clk,
    input  wire        ce_gb,
    input  wire        ce_m,
    input  wire        rst,
    input  wire [15:0] addr,     // unused internally, single register, sel already disambiguates
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output wire [7:0]  data_out,
    output wire        stall,    // p1 never blocks the cpu

    input  wire btn_right,
    input  wire btn_left,
    input  wire btn_up,
    input  wire btn_down,
    input  wire btn_a,
    input  wire btn_b,
    input  wire btn_select,
    input  wire btn_start,

    output wire irq_joypad
);

    assign stall = 1'b0;

    reg sel_btn;
    reg sel_dir;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sel_btn <= 1'b1;
            sel_dir <= 1'b1;
        end
        else if (ce_m && sel && we) begin
            sel_btn <= data_in[5];
            sel_dir <= data_in[4];
        end
    end

    wire [3:0] dir_bits = ~{btn_down, btn_up, btn_left, btn_right};
    wire [3:0] btn_bits = ~{btn_start, btn_select, btn_b, btn_a};

    reg [3:0] nibble;
    always @(*) begin
        case ({sel_btn, sel_dir})
            2'b10:   nibble = dir_bits;
            2'b01:   nibble = btn_bits;
            2'b00:   nibble = dir_bits & btn_bits;
            default: nibble = 4'hF;
        endcase
    end

    wire [7:0] p1_value = {2'b11, sel_btn, sel_dir, nibble};
    assign data_out = sel ? p1_value : 8'h00;

    reg [3:0] nibble_prev;
    always @(posedge clk or posedge rst) begin
        if (rst)
            nibble_prev <= 4'hF;
        else if (ce_gb)
            nibble_prev <= nibble;
    end

    assign irq_joypad = ce_gb && |(nibble_prev & ~nibble);

endmodule