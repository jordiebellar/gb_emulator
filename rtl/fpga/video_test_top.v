// =============================================================================
// Project      : GameBoy Emulator
// File         : video_test_top.v
// Author       : Aaron Luebbert
// Date         : 2026-10-19
// Description  : basic video output test for the basys 3. no cpu, no ppu.
//                  a small pattern generator plays the part of the ppu and
//                  feeds the real video block, so this checks clk_div, the
//                  framebuffer, the palette, the vga timing, and the pins.
//
//                  the generator walks the 160 x 144 screen one pixel per
//                  ce_gb tick, the same rate the ppu would, and repeats
//                  forever. the pattern is
//                    - a one pixel frame around the picture, dark on a light
//                      pixel and light on a dark one so it always shows
//                    - top half, four vertical bands of shade 0, 1, 2, 3
//                    - bottom half, an 8 x 8 checkerboard of shade 0 and 3
//
//                  what to expect on the monitor: a 480 x 432 picture
//                  centered in a black screen, 80 pixels of black left and
//                  right and 24 top and bottom. each pattern pixel is a
//                  clean 3 x 3 block. the dmg green look is used.
//
//                  btnC is reset. a short power-on reset runs at start-up.
//                  pin names match digilent's basys 3 master xdc.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module video_test_top (
    input  wire       clk,
    input  wire       btnC,

    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire       Hsync,
    output wire       Vsync
);

    // reset - power-on hold plus the center button through a 2 flop sync
    reg [3:0] por_cnt = 4'd0;
    reg [1:0] btn_sync = 2'b00;

    always @(posedge clk) begin
        btn_sync <= {btn_sync[0], btnC};
        if (por_cnt != 4'hF) por_cnt <= por_cnt + 4'd1;
    end

    wire rst = (por_cnt != 4'hF) | btn_sync[1];

    // clock enables
    wire ce_gb, ce_m, ce_vga;

    clk_div u_clk (
        .clk_100m(clk), .rst(rst),
        .ce_gb(ce_gb), .ce_m(ce_m), .ce_vga(ce_vga)
    );

    // pattern generator - one pixel per ce_gb, same as the ppu output rate
    reg [7:0] px, py;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            px <= 8'd0;
            py <= 8'd0;
        end
        else if (ce_gb) begin
            if (px == 8'd159) begin
                px <= 8'd0;
                py <= (py == 8'd143) ? 8'd0 : py + 8'd1;
            end
            else px <= px + 8'd1;
        end
    end

    wire [1:0] band = (px < 8'd40)  ? 2'd0 :
                      (px < 8'd80)  ? 2'd1 :
                      (px < 8'd120) ? 2'd2 : 2'd3;
    wire       chk  = px[3] ^ py[3];
    wire [1:0] base = (py < 8'd72) ? band : (chk ? 2'd3 : 2'd0);
    wire       edge_px = (px == 8'd0) || (px == 8'd159) ||
                         (py == 8'd0) || (py == 8'd143);
    wire [1:0] shade = edge_px ? ((base == 2'd3) ? 2'd0 : 2'd3) : base;

    video #(.GREEN(1)) u_video (
        .clk(clk), .ce_gb(ce_gb), .ce_vga(ce_vga), .rst(rst),
        .lcd_on(1'b1),
        .pixel_valid(1'b1), .pixel_x(px), .pixel_y(py), .pixel_shade(shade),
        .vga_r(vgaRed), .vga_g(vgaGreen), .vga_b(vgaBlue),
        .vga_hsync(Hsync), .vga_vsync(Vsync)
    );

endmodule
