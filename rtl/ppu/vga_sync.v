// =============================================================================
// Project      : GameBoy Emulator
// File         : vga_sync.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : standard 640 x 480 vga timing at 60hz. h counts pixels along
//                  a line, v counts lines down the frame, both advance on
//                  ce_vga, the 25mhz pixel enable, so the whole thing runs
//                  off the one 100mhz clock.
//
//                  horizontal, in pixels: 640 visible, 16 front porch, 96
//                  sync, 48 back porch, 800 total.
//                  vertical, in lines: 480 visible, 10 front porch, 2 sync,
//                  33 back porch, 525 total.
//                  both sync pulses are active low, which is what this mode
//                  uses. hsync is low for h 656 to 751. vsync is low for
//                  whole lines, v 490 and 491, and changes at the start of a
//                  line.
//
//                  25mhz is the nominal pixel clock for this mode,
//                  25.175mhz. at exactly 25.000mhz a frame takes 420000
//                  pixels, which is 59.52hz. monitors accept this.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module vga_sync (
    input  wire       clk,
    input  wire       ce_vga,
    input  wire       rst,

    output reg  [9:0] h,
    output reg  [9:0] v,
    output wire       hsync,   // active low
    output wire       vsync,   // active low
    output wire       visible  // inside the 640 x 480 picture area
);

    localparam H_VISIBLE = 640;
    localparam H_FRONT   = 16;
    localparam H_SYNC    = 96;
    localparam H_BACK    = 48;
    localparam H_TOTAL   = H_VISIBLE + H_FRONT + H_SYNC + H_BACK;   // 800

    localparam V_VISIBLE = 480;
    localparam V_FRONT   = 10;
    localparam V_SYNC    = 2;
    localparam V_BACK    = 33;
    localparam V_TOTAL   = V_VISIBLE + V_FRONT + V_SYNC + V_BACK;   // 525

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            h <= 10'd0;
            v <= 10'd0;
        end
        else if (ce_vga) begin
            if (h == H_TOTAL - 1) begin
                h <= 10'd0;
                if (v == V_TOTAL - 1)
                    v <= 10'd0;
                else
                    v <= v + 10'd1;
            end
            else begin
                h <= h + 10'd1;
            end
        end
    end

    assign hsync   = ~((h >= H_VISIBLE + H_FRONT) && (h < H_VISIBLE + H_FRONT + H_SYNC));
    assign vsync   = ~((v >= V_VISIBLE + V_FRONT) && (v < V_VISIBLE + V_FRONT + V_SYNC));
    assign visible = (h < H_VISIBLE) && (v < V_VISIBLE);

endmodule