// =============================================================================
// Project      : GameBoy Emulator
// File         : ps2_keys.v
// Author       : Aaron Luebbert
// Date         : 2026-11-02
// Description  : turns a ps/2 keyboard into the eight joypad lines. the basys 3
//                  usb port is a usb host chip that hands the fpga a ps/2
//                  keyboard (scan code set 2), so this module is a ps/2 device
//                  receiver and a small make/break decoder.
//
//                  keys, the same layout mgba, retroarch and most other
//                  emulators ship as their default
//                    - arrow keys are the d-pad
//                    - x is a, z is b
//                    - enter is start
//                    - backspace, left shift or right shift is select
//                  the keypad 4, 6, 8, 2 and keypad enter send the same codes
//                  without the e0 prefix and work too. the e0 prefix is ignored
//                  for the d-pad and enter, so both forms land on the same key.
//                  left shift with an e0 prefix is the fake shift some keyboards
//                  wrap around the arrow keys, it is ignored so an arrow press
//                  can never look like select.
//
//                  the keys output is ordered like the joypad inputs in
//                  gb_fpga_top - bit 0 right, 1 left, 2 up, 3 down, 4 a, 5 b,
//                  6 select, 7 start. a bit stays high from the make code
//                  until the matching break code (f0 then the key code).
//
//                  receiver - both lines are filtered, a level has to hold for
//                  8 clocks before it counts. a frame is start, 8 data bits
//                  lsb first, odd parity, stop, read on each falling edge of
//                  the device clock. a frame with a bad start, parity or stop
//                  is dropped, and a stalled frame is abandoned after about
//                  2.6 ms of silence so the receiver cannot lock out of step.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module ps2_keys (
    input  wire       clk,
    input  wire       rst,
    input  wire       ps2_clk,
    input  wire       ps2_data,
    output wire [7:0] keys
);

    // ------------------------------------------------------------------------
    // input filter - a level has to hold for 8 clocks to be believed
    // ------------------------------------------------------------------------
    reg [7:0] clk_hist = 8'hFF;
    reg [7:0] dat_hist = 8'hFF;
    reg       clk_f    = 1'b1;
    reg       dat_f    = 1'b1;
    reg       clk_prev = 1'b1;

    always @(posedge clk) begin
        clk_hist <= {clk_hist[6:0], ps2_clk};
        dat_hist <= {dat_hist[6:0], ps2_data};
        if      (clk_hist == 8'hFF) clk_f <= 1'b1;
        else if (clk_hist == 8'h00) clk_f <= 1'b0;
        if      (dat_hist == 8'hFF) dat_f <= 1'b1;
        else if (dat_hist == 8'h00) dat_f <= 1'b0;
        clk_prev <= clk_f;
    end

    wire fall = clk_prev & ~clk_f;

    // ------------------------------------------------------------------------
    // frame receiver
    // ------------------------------------------------------------------------
    reg [3:0]  bitcnt   = 4'd0;
    reg [7:0]  shreg    = 8'd0;
    reg        par_ok   = 1'b0;
    reg [17:0] idle_cnt = 18'd0;
    reg [7:0]  code     = 8'd0;
    reg        got      = 1'b0;

    always @(posedge clk) begin
        got <= 1'b0;
        if (rst) begin
            bitcnt   <= 4'd0;
            idle_cnt <= 18'd0;
        end else if (fall) begin
            idle_cnt <= 18'd0;
            case (bitcnt)
                4'd0: if (!dat_f) bitcnt <= 4'd1;
                4'd9: begin
                    // odd parity - data bits plus the parity bit hold an odd count of ones
                    par_ok <= (^shreg) ^ dat_f;
                    bitcnt <= 4'd10;
                end
                4'd10: begin
                    bitcnt <= 4'd0;
                    if (dat_f && par_ok) begin
                        code <= shreg;
                        got  <= 1'b1;
                    end
                end
                default: begin
                    shreg  <= {dat_f, shreg[7:1]};
                    bitcnt <= bitcnt + 4'd1;
                end
            endcase
        end else if (idle_cnt != 18'h3FFFF) begin
            idle_cnt <= idle_cnt + 18'd1;
        end else begin
            bitcnt <= 4'd0;
        end
    end

    // ------------------------------------------------------------------------
    // make and break decoder
    // ------------------------------------------------------------------------
    // one bit per physical key, so two keys on select can be held and released
    // in any order. bit 0 right, 1 left, 2 up, 3 down, 4 x, 5 z, 6 backspace,
    // 7 enter, 8 left shift, 9 right shift
    reg [9:0] held = 10'd0;
    reg       brk  = 1'b0;
    reg       e0   = 1'b0;

    always @(posedge clk) begin
        if (rst) begin
            held <= 10'd0;
            brk  <= 1'b0;
            e0   <= 1'b0;
        end else if (got) begin
            case (code)
                8'hF0: brk <= 1'b1;
                8'hE0: e0  <= 1'b1;
                default: begin
                    brk <= 1'b0;
                    e0  <= 1'b0;
                    case (code)
                        8'h74: held[0] <= ~brk;            // right
                        8'h6B: held[1] <= ~brk;            // left
                        8'h75: held[2] <= ~brk;            // up
                        8'h72: held[3] <= ~brk;            // down
                        8'h22: held[4] <= ~brk;            // x, a
                        8'h1A: held[5] <= ~brk;            // z, b
                        8'h66: held[6] <= ~brk;            // backspace, select
                        8'h5A: held[7] <= ~brk;            // enter, start
                        8'h12: if (!e0) held[8] <= ~brk;   // left shift, select
                        8'h59: held[9] <= ~brk;            // right shift, select
                        default: ;
                    endcase
                end
            endcase
        end
    end

    assign keys = {held[7], held[6] | held[8] | held[9], held[5], held[4], held[3:0]};

endmodule
