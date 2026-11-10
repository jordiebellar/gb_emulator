// =============================================================================
// Project      : GameBoy Emulator
// File         : rtc.v
// Author       : Aaron Luebbert
// Date         : 2026-11-09
// Description  : the real time clock inside mbc3 carts. seconds, minutes,
//                  hours and a 9 bit day count, a halt bit and a day carry.
//                  the live registers count off the 100 mhz clock, not the
//                  emulated one, so the time keeps running while the machine
//                  is paused for a card read. the game reads the latched copy,
//                  which is refreshed when the mbc sees a 0 then 1 written to
//                  6000-7FFF.
//
//                  register index   0 seconds   1 minutes   2 hours
//                                   3 day low   4 day high (bit 0 is day
//                                   bit 8, bit 6 halt, bit 7 carry)
//                  writing seconds also clears the sub second count.
//                  TICKS is the number of clk cycles in one second.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module rtc #(
    parameter integer TICKS = 100000000
) (
    input  wire       clk,
    input  wire       rst,
    input  wire       latch,
    input  wire       wr,
    input  wire [2:0] idx,
    input  wire [7:0] wdata,
    input  wire [2:0] rd_idx,
    output reg  [7:0] rdata
);

    reg [31:0] sub;
    reg [5:0]  sec, min;
    reg [4:0]  hr;
    reg [8:0]  day;
    reg        halt, carry;

    reg [5:0]  l_sec, l_min;
    reg [4:0]  l_hr;
    reg [8:0]  l_day;
    reg        l_halt, l_carry;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sub <= 32'd0; sec <= 6'd0; min <= 6'd0; hr <= 5'd0; day <= 9'd0;
            halt <= 1'b0; carry <= 1'b0;
            l_sec <= 6'd0; l_min <= 6'd0; l_hr <= 5'd0; l_day <= 9'd0;
            l_halt <= 1'b0; l_carry <= 1'b0;
        end
        else begin
            if (latch) begin
                l_sec <= sec; l_min <= min; l_hr <= hr; l_day <= day;
                l_halt <= halt; l_carry <= carry;
            end

            if (wr) begin
                case (idx)
                    3'd0: begin sec <= wdata[5:0]; sub <= 32'd0; end
                    3'd1: min <= wdata[5:0];
                    3'd2: hr  <= wdata[4:0];
                    3'd3: day[7:0] <= wdata;
                    default: begin
                        day[8] <= wdata[0];
                        halt   <= wdata[6];
                        carry  <= wdata[7];
                    end
                endcase
            end
            else if (!halt) begin
                if (sub == TICKS - 1) begin
                    sub <= 32'd0;
                    if (sec == 6'd59) begin
                        sec <= 6'd0;
                        if (min == 6'd59) begin
                            min <= 6'd0;
                            if (hr == 5'd23) begin
                                hr <= 5'd0;
                                if (day == 9'd511) begin day <= 9'd0; carry <= 1'b1; end
                                else day <= day + 9'd1;
                            end
                            else hr <= hr + 5'd1;
                        end
                        else min <= min + 6'd1;
                    end
                    else sec <= sec + 6'd1;
                end
                else sub <= sub + 32'd1;
            end
        end
    end

    always @(*) begin
        case (rd_idx)
            3'd0:    rdata = {2'b00, l_sec};
            3'd1:    rdata = {2'b00, l_min};
            3'd2:    rdata = {3'b000, l_hr};
            3'd3:    rdata = l_day[7:0];
            default: rdata = {l_carry, l_halt, 5'b00000, l_day[8]};
        endcase
    end

endmodule
