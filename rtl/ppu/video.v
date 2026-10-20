// =============================================================================
// Project      : GameBoy Emulator
// File         : video.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : the video side of the system. takes the pixel stream from
//                  the ppu, keeps it in the framebuffer, and scans it out to
//                  the basys 3 vga port.
//
//                  the 160 x 144 picture is scaled 3 times to 480 x 432 and
//                  centered in the 640 x 480 screen, which leaves a black
//                  border of 80 pixels left and right and 24 top and
//                  bottom. the picture occupies h 80 to 559 and v 24 to 455.
//                  scaling is by pixel doubling, each framebuffer pixel
//                  covers a 3 x 3 block. dividing by 3 is done as a
//                  multiply by 171 and a shift right 9, exact for every
//                  value this uses, so no divider is needed.
//
//                  ppu side: pixel_valid, pixel_x, pixel_y, and pixel_shade
//                  are the ppu's pixel output, with the dmg palette already
//                  applied. a pixel is written on a clock where both
//                  pixel_valid and ce_gb are high, since the ppu holds its
//                  output for a whole dot but a dot is one ce_gb tick.
//
//                  lcd_on low shows a blank screen, the lightest shade, the
//                  way an lcd that is switched off looks.
//
//                  everything outside the picture, including all the blanking
//                  time, is black. outputs are registered on ce_vga so the
//                  vga connector sees glitch-free signals. rgb and both syncs
//                  go through the same register stage, so they stay lined up
//                  with each other, all one pixel later than the counters.
//
//                  the framebuffer read takes one clock and a pixel lasts
//                  four, so the pixel is ready well before it is registered.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module video #(
    parameter GREEN = 1
) (
    input  wire        clk,
    input  wire        ce_gb,
    input  wire        ce_vga,
    input  wire        rst,

    input  wire        lcd_on,
    input  wire        pixel_valid,
    input  wire [7:0]  pixel_x,
    input  wire [7:0]  pixel_y,
    input  wire [1:0]  pixel_shade,

    output reg  [3:0]  vga_r,
    output reg  [3:0]  vga_g,
    output reg  [3:0]  vga_b,
    output reg         vga_hsync,
    output reg         vga_vsync
);

    localparam X0    = 80;
    localparam Y0    = 24;
    localparam WIN_W = 480;
    localparam WIN_H = 432;

    wire [9:0] h, v;
    wire       hsync_c, vsync_c, visible_c;

    vga_sync u_sync (
        .clk(clk), .ce_vga(ce_vga), .rst(rst),
        .h(h), .v(v), .hsync(hsync_c), .vsync(vsync_c), .visible(visible_c)
    );

    // the picture window, and the position inside it
    wire in_win = (h >= X0) && (h < X0 + WIN_W) && (v >= Y0) && (v < Y0 + WIN_H);

    wire [8:0]  x_rel = h - X0;
    wire [8:0]  y_rel = v - Y0;
    wire [16:0] x_mul = x_rel * 8'd171;
    wire [16:0] y_mul = y_rel * 8'd171;
    wire [7:0]  fx    = x_mul[16:9];   // x_rel / 3
    wire [7:0]  fy    = y_mul[16:9];   // y_rel / 3

    wire [1:0] fb_shade;

    framebuffer u_fb (
        .clk(clk),
        .we(pixel_valid && ce_gb),
        .wx(pixel_x), .wy(pixel_y), .wshade(pixel_shade),
        .rx(fx), .ry(fy), .rshade(fb_shade)
    );

    wire [11:0] pal_rgb;

    palette #(.GREEN(GREEN)) u_pal (
        .shade(lcd_on ? fb_shade : 2'd0),
        .rgb(pal_rgb)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            vga_r     <= 4'h0;
            vga_g     <= 4'h0;
            vga_b     <= 4'h0;
            vga_hsync <= 1'b1;
            vga_vsync <= 1'b1;
        end
        else if (ce_vga) begin
            vga_hsync <= hsync_c;
            vga_vsync <= vsync_c;
            if (in_win) {vga_r, vga_g, vga_b} <= pal_rgb;
            else        {vga_r, vga_g, vga_b} <= 12'h000;
        end
    end

endmodule