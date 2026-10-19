// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_demo_top.v
// Author       : Aaron Luebbert
// Date         : 2026-10-19
// Description  : ppu demo for the basys 3. no cpu. a small sequencer plays the
//                  part of the cpu and the boot rom, and writes the real ppu
//                  through its normal bus ports, one write per m-cycle, the
//                  same way a program would. the picture then comes out of the
//                  real ppu, video block, and vga port.
//
//                  the write list, in order, with the lcd still off so vram
//                  and oam are open
//                    - palettes, bgp and obp0 normal, obp1 inverted
//                    - 9 tiles at 0x8000
//                    - the 32 x 32 tile map at 0x9800
//                    - 3 sprites in oam at 0xFE00
//                    - lcdc = 0x93, which turns the lcd on with the
//                      background and sprites enabled and tile data at 0x8000
//
//                  what to expect on the monitor, in the 160 x 144 screen
//                    - a box outline on the edge of the screen
//                    - top half, four vertical bands in the four shades
//                    - bottom half, a checkerboard of small diagonal and dot
//                      tiles
//                    - three sprites, a smiley, a smiley in inverted shades
//                      using obp1, and a letter F that is flipped left to right
//
//                  controls
//                    - btnC resets and replays the whole write list
//                    - sw0 on scrolls the background to the left, one pixel
//                      about every 21 ms, by writing scx. sprites do not move.
//                    - sw1 on writes an inverted bgp, sw1 off writes the normal
//                      bgp. the change shows on the next update.
//                    - led0 is lcd on, led1 is the write list finished
//
//                  the register writes go on the same bus a cpu would use, so
//                  this also checks the select decode, the ce_m write timing,
//                  and the lcd off then on order.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module ppu_demo_top (
    input  wire       clk,
    input  wire       btnC,
    input  wire [1:0] sw,

    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire       Hsync,
    output wire       Vsync,
    output wire [1:0] led
);

    // reset - power-on hold plus the center button through a 2 flop sync
    reg [3:0] por_cnt = 4'd0;
    reg [1:0] btn_sync = 2'b00;

    always @(posedge clk) begin
        btn_sync <= {btn_sync[0], btnC};
        if (por_cnt != 4'hF) por_cnt <= por_cnt + 4'd1;
    end

    wire rst = (por_cnt != 4'hF) | btn_sync[1];

    wire ce_gb, ce_m, ce_vga;

    clk_div u_clk (
        .clk_100m(clk), .rst(rst),
        .ce_gb(ce_gb), .ce_m(ce_m), .ce_vga(ce_vga)
    );

    // ------------------------------------------------------------------------
    // write list sequencer
    // ------------------------------------------------------------------------
    localparam [10:0] TILE0  = 11'd3;      // first tile data write
    localparam [10:0] MAP0   = 11'd147;    // first tile map write
    localparam [10:0] OAM0   = 11'd1171;   // first oam write
    localparam [10:0] LCDC_W = 11'd1183;   // the lcdc write, last of the list
    localparam [10:0] END_W  = 11'd1184;   // list finished

    reg [10:0] step;
    reg [1:0]  rt_step;      // runtime update, 0 idle, 1 scx write, 2 bgp write
    reg [7:0]  scx_val;
    reg [20:0] tick_cnt;
    reg        tick_pend;

    wire running = (step < END_W);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            step      <= 11'd0;
            rt_step   <= 2'd0;
            scx_val   <= 8'd0;
            tick_cnt  <= 21'd0;
            tick_pend <= 1'b0;
        end
        else begin
            tick_cnt <= tick_cnt + 21'd1;
            if (&tick_cnt) tick_pend <= 1'b1;

            if (ce_m) begin
                if (running) step <= step + 11'd1;
                else case (rt_step)
                    2'd0: if (tick_pend) begin
                              rt_step   <= 2'd1;
                              tick_pend <= 1'b0;
                          end
                    2'd1: begin
                              rt_step <= 2'd2;
                              if (sw[0]) scx_val <= scx_val + 8'd1;
                          end
                    default: rt_step <= 2'd0;
                endcase
            end
        end
    end

    // tile data, 16 bytes a tile, low plane then high plane for each row
    //   0 blank, 1 to 3 solid shades 1 to 3, 4 box outline, 5 diagonal line,
    //   6 checker, 7 smiley, 8 letter F
    function [7:0] tile_byte(input [7:0] i);
        reg [3:0] n;
        reg [2:0] row;
        reg       pl;
        reg [7:0] pat;
        begin
            n   = i[7:4];
            row = i[3:1];
            pl  = i[0];
            case (n)
                4'd0: tile_byte = 8'h00;
                4'd1: tile_byte = pl ? 8'h00 : 8'hFF;
                4'd2: tile_byte = pl ? 8'hFF : 8'h00;
                4'd3: tile_byte = 8'hFF;
                4'd4: tile_byte = (row == 3'd0 || row == 3'd7) ? 8'hFF : 8'h81;
                4'd5: tile_byte = 8'h80 >> row;
                4'd6: tile_byte = row[0] ? 8'h55 : 8'hAA;
                4'd7: begin
                    case (row)
                        3'd0: pat = 8'h3C;
                        3'd1: pat = 8'h42;
                        3'd2: pat = 8'hA5;
                        3'd3: pat = 8'h81;
                        3'd4: pat = 8'hA5;
                        3'd5: pat = 8'h99;
                        3'd6: pat = 8'h42;
                        default: pat = 8'h3C;
                    endcase
                    tile_byte = pat;
                end
                4'd8: begin
                    case (row)
                        3'd0: pat = 8'h7E;
                        3'd1: pat = 8'h40;
                        3'd2: pat = 8'h40;
                        3'd3: pat = 8'h7C;
                        3'd4: pat = 8'h40;
                        3'd5: pat = 8'h40;
                        3'd6: pat = 8'h40;
                        default: pat = 8'h00;
                    endcase
                    tile_byte = pat;
                end
                default: tile_byte = 8'h00;
            endcase
        end
    endfunction

    // tile map entry for a column and row of the 32 x 32 map. the screen is
    // 20 x 18 tiles, the rest of the map is a checker of boxes so scrolling
    // has something to show
    function [7:0] map_tile(input [4:0] col, input [4:0] row);
        reg inside;
        begin
            inside = (col <= 5'd19) && (row <= 5'd17);
            if (inside && (row == 5'd0 || row == 5'd17 || col == 5'd0 || col == 5'd19))
                map_tile = 8'd4;
            else if (inside && row < 5'd9)
                map_tile = (col - 5'd1) / 5'd5;
            else if (inside)
                map_tile = (col[0] ^ row[0]) ? 8'd5 : 8'd6;
            else
                map_tile = (col[0] ^ row[0]) ? 8'd4 : 8'd0;
        end
    endfunction

    // three sprites, four bytes each, y then x then tile then attributes
    function [7:0] oam_byte(input [3:0] j);
        begin
            case (j)
                4'd0:  oam_byte = 8'd56;    // y 40
                4'd1:  oam_byte = 8'd38;    // x 30
                4'd2:  oam_byte = 8'd7;
                4'd3:  oam_byte = 8'h00;
                4'd4:  oam_byte = 8'd96;    // y 80
                4'd5:  oam_byte = 8'd108;   // x 100
                4'd6:  oam_byte = 8'd7;
                4'd7:  oam_byte = 8'h10;    // obp1
                4'd8:  oam_byte = 8'd136;   // y 120
                4'd9:  oam_byte = 8'd68;    // x 60
                4'd10: oam_byte = 8'd8;
                default: oam_byte = 8'h20;  // x flip
            endcase
        end
    endfunction

    // the bus the sequencer drives
    reg [15:0] addr;
    reg [7:0]  data_in;
    reg        we;

    wire [10:0] s = step;

    always @(*) begin
        addr    = 16'h0000;
        data_in = 8'h00;
        we      = 1'b0;
        if (running) begin
            we = 1'b1;
            if (s < TILE0) begin
                case (s[1:0])
                    2'd0:    begin addr = 16'hFF47; data_in = 8'hE4; end   // bgp
                    2'd1:    begin addr = 16'hFF48; data_in = 8'hE4; end   // obp0
                    default: begin addr = 16'hFF49; data_in = 8'h1B; end   // obp1
                endcase
            end
            else if (s < MAP0) begin
                addr    = 16'h8000 + {5'b0, s - TILE0};
                data_in = tile_byte(s - TILE0);
            end
            else if (s < OAM0) begin
                addr    = 16'h9800 + {5'b0, s - MAP0};
                data_in = map_tile((s - MAP0) & 11'h01F, ((s - MAP0) >> 5) & 11'h01F);
            end
            else if (s < LCDC_W) begin
                addr    = 16'hFE00 + {5'b0, s - OAM0};
                data_in = oam_byte(s - OAM0);
            end
            else begin
                addr    = 16'hFF40;
                data_in = 8'h93;
            end
        end
        else if (rt_step == 2'd1) begin
            we      = 1'b1;
            addr    = 16'hFF43;
            data_in = scx_val;
        end
        else if (rt_step == 2'd2) begin
            we      = 1'b1;
            addr    = 16'hFF47;
            data_in = sw[1] ? 8'h1B : 8'hE4;
        end
    end

    // address decode, the part memory_map would do in the full system
    wire sel_ppu_vram = (addr[15:13] == 3'b100);
    wire sel_ppu_oam  = (addr[15:8] == 8'hFE) && (addr[7:0] < 8'hA0);
    wire sel_ppu_reg  = (addr[15:4] == 12'hFF4) && (addr[3:0] != 4'h6);

    // ------------------------------------------------------------------------
    // ppu and video
    // ------------------------------------------------------------------------
    wire       pixel_valid, lcd_on;
    wire [1:0] pixel_color, pixel_shade;
    wire [7:0] pixel_x, pixel_y;

    ppu u_ppu (
        .clk(clk), .ce_gb(ce_gb), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(data_in), .we(we),
        .sel_ppu_vram(sel_ppu_vram), .ppu_vram_data_out(),
        .sel_ppu_oam(sel_ppu_oam),   .ppu_oam_data_out(),
        .sel_ppu_reg(sel_ppu_reg),   .ppu_reg_data_out(),
        .dma_active(1'b0),
        .dma_we(1'b0), .dma_waddr(8'h00), .dma_wdata(8'h00),
        .pixel_valid(pixel_valid), .pixel_color(pixel_color),
        .pixel_shade(pixel_shade), .pixel_x(pixel_x), .pixel_y(pixel_y),
        .lcd_on(lcd_on),
        .irq_vblank(), .irq_lcdstat()
    );

    video #(.GREEN(1)) u_video (
        .clk(clk), .ce_gb(ce_gb), .ce_vga(ce_vga), .rst(rst),
        .lcd_on(lcd_on),
        .pixel_valid(pixel_valid), .pixel_x(pixel_x), .pixel_y(pixel_y),
        .pixel_shade(pixel_shade),
        .vga_r(vgaRed), .vga_g(vgaGreen), .vga_b(vgaBlue),
        .vga_hsync(Hsync), .vga_vsync(Vsync)
    );

    assign led[0] = lcd_on;
    assign led[1] = ~running;

endmodule
