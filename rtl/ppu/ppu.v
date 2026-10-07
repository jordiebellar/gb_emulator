// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : ppu top level. instantiates the mode timing engine, the
//                  register file, vram, oam, the oam scan, and the pixel
//                  fetcher with its window and sprite handling, and wires
//                  them together.
//                  lcdc bit 7 from the register file drives lcd_en in the
//                  timing engine. mode, ly, and the entering_* strobes
//                  from the timing engine feed the register file. the
//                  next-state exports mode_next and ly_next feed the
//                  register file, vram, and oam, so cpu accesses are decided
//                  by the state after the edge they commit on. the current
//                  mode gates the fetcher so it runs only in mode 3. the fetcher reads
//                  vram through vram's render port, which is never
//                  blocked, and its line_done is the fifo_done that ends
//                  mode 3. so mode 3 lasts 172 + (scx & 7) dots plus the
//                  window and sprite penalties, see ppu_fetcher.
//                  the oam scan runs in mode 2 and hands the fetcher its
//                  list of objects for the line. oam is read by the scan
//                  through its entry port, and written by the oam dma unit
//                  through the dma write port, which is a port of this
//                  module for gb_top to wire from the dma unit.
//                  the three bus facing ranges (vram, oam, registers) each
//                  keep their own sel and data_out, named the same as
//                  memory_map's ports so gb_top wires them straight
//                  across. there is no bus_stall (section 4).
//
//                  pixel output, for the video side: pixel_valid is high on
//                  each dot a pixel is produced, with pixel_x, pixel_y,
//                  pixel_color, and pixel_shade. pixel_color is the color
//                  index 0 to 3 of the pixel that won, background, window,
//                  or object. pixel_shade is that index run through the
//                  palette that applies, bgp for the background and window,
//                  obp0 or obp1 for an object, the shade that goes on
//                  screen, 0 the lightest to 3 the darkest. the palette is
//                  applied to each pixel as it leaves, so a palette change
//                  in the middle of a frame affects exactly the pixels after
//                  it. the output is held for a whole dot, so the consumer
//                  takes it on the edge where ce_gb is high. lcd_on is lcdc
//                  bit 7.
//
//                  dma_active comes from the oam dma unit. it blocks cpu
//                  access to oam and hides objects from the oam scan.
//
//                  the oam_stall and vram_stall outputs of ppu_mode_fsm
//                  are left unconnected. vram and oam take mode_next and
//                  decide blocking themselves.
// Revision     : 2.0 - window and sprites. the oam scan is instantiated, the
//                  fetcher takes the window and object ports, the three
//                  palettes are applied by pixel_pal, and the dma write
//                  port is added. the oam render port is gone, the scan
//                  uses oam's entry port internally.
//                  1.3 - added pixel_shade, which applies bgp to each pixel,
//                  and lcd_on for the video side.
//                  1.2 - mode_next and ly_next from the timing engine now
//                  feed vram, oam, and the register file, so cpu accesses
//                  that land exactly on a mode transition edge are decided
//                  by the mode after that edge, as the contract requires.
//                  the fetcher still uses the current mode, it is logic
//                  inside the ppu and not a bus access.
//                  1.1 - added the background fetcher in place of the fixed
//                  172 dot fifo_done stand-in. removed the vram render
//                  port from the module ports, it is internal now. added
//                  the pixel output ports.
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module ppu (
    input  wire        clk,
    input  wire        ce_gb,
    input  wire        ce_m,
    input  wire        rst,

    // shared bus, broadcast by gb_top
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,   // the cpu's write data
    input  wire        we,

    // the three bus facing ranges
    input  wire        sel_ppu_vram,
    output wire [7:0]  ppu_vram_data_out,
    input  wire        sel_ppu_oam,
    output wire [7:0]  ppu_oam_data_out,
    input  wire        sel_ppu_reg,
    output wire [7:0]  ppu_reg_data_out,

    input  wire        dma_active,

    // oam dma write port, from the oam dma unit
    input  wire        dma_we,
    input  wire [7:0]  dma_waddr,
    input  wire [7:0]  dma_wdata,

    // pixel output
    output wire        pixel_valid,
    output wire [1:0]  pixel_color,
    output wire [1:0]  pixel_shade,
    output wire [7:0]  pixel_x,
    output wire [7:0]  pixel_y,
    output wire        lcd_on,

    output wire        irq_vblank,
    output wire        irq_lcdstat
);

    wire [1:0]  mode;
    wire [8:0]  dot_counter;
    wire [7:0]  ly;
    wire [1:0]  mode_next;
    wire [7:0]  ly_next;
    wire [7:0]  lcdc;
    wire [7:0]  scx;
    wire [7:0]  scy;
    wire [7:0]  bgp;
    wire [7:0]  obp0;
    wire [7:0]  obp1;
    wire [7:0]  wy;
    wire [7:0]  wx;
    wire [1:0]  pixel_pal;
    wire [319:0] spr_list;
    wire [3:0]   spr_count;
    wire [5:0]   oam_entry_idx;
    wire [31:0]  oam_entry_data;
    wire        entering_hblank;
    wire        entering_oam_scan;
    wire        entering_vblank;
    wire        fifo_done;

    wire [12:0] vram_render_addr;
    wire [7:0]  vram_render_data;

    assign pixel_y = ly;
    assign lcd_on  = lcdc[7];

    // each palette holds four 2 bit shades, color 0 in bits 1:0 up to color
    // 3 in bits 7:6. the color index picks which field comes out, and
    // pixel_pal picks which palette
    wire [7:0] pal_value = (pixel_pal == 2'd0) ? bgp :
                           (pixel_pal == 2'd1) ? obp0 : obp1;
    assign pixel_shade = pal_value[{pixel_color, 1'b0} +: 2];

    ppu_mode_fsm u_fsm (
        .clk               (clk),
        .ce_gb             (ce_gb),
        .rst               (rst),
        .lcd_en            (lcdc[7]),
        .fifo_done         (fifo_done),
        .mode              (mode),
        .dot_counter       (dot_counter),
        .ly                (ly),
        .mode_next         (mode_next),
        .ly_next           (ly_next),
        .oam_stall         (),
        .vram_stall        (),
        .entering_hblank   (entering_hblank),
        .entering_oam_scan (entering_oam_scan),
        .entering_vblank   (entering_vblank),
        .irq_vblank        (irq_vblank)
    );

    ppu_oam_scan u_scan (
        .clk         (clk),
        .ce_gb       (ce_gb),
        .rst         (rst),
        .scan_active (mode == 2'd2),
        .ly          (ly),
        .obj_tall    (lcdc[2]),
        .dma_active  (dma_active),
        .entry_idx   (oam_entry_idx),
        .entry_data  (oam_entry_data),
        .list        (spr_list),
        .count       (spr_count)
    );

    ppu_fetcher u_fetcher (
        .clk         (clk),
        .ce_gb       (ce_gb),
        .rst         (rst),
        .active      (mode == 2'd3),
        .lcd_en      (lcdc[7]),
        .oam_scan    (mode == 2'd2),
        .ly          (ly),
        .scx         (scx),
        .scy         (scy),
        .lcdc        (lcdc),
        .wy          (wy),
        .wx          (wx),
        .spr_list    (spr_list),
        .spr_count   (spr_count),
        .vram_addr   (vram_render_addr),
        .vram_data   (vram_render_data),
        .pixel_valid (pixel_valid),
        .pixel_color (pixel_color),
        .pixel_pal   (pixel_pal),
        .pixel_x     (pixel_x),
        .line_done   (fifo_done)
    );

    ppu_reg u_reg (
        .clk               (clk),
        .ce_gb             (ce_gb),
        .ce_m              (ce_m),
        .rst               (rst),
        .addr              (addr),
        .data_in           (data_in),
        .we                (we),
        .sel               (sel_ppu_reg),
        .data_out          (ppu_reg_data_out),
        .stall             (),
        .mode_next         (mode_next),
        .ly_in             (ly),
        .ly_next           (ly_next),
        .entering_hblank   (entering_hblank),
        .entering_oam_scan (entering_oam_scan),
        .entering_vblank   (entering_vblank),
        .lcdc_out          (lcdc),
        .scx_out           (scx),
        .scy_out           (scy),
        .bgp_out           (bgp),
        .obp0_out          (obp0),
        .obp1_out          (obp1),
        .wy_out            (wy),
        .wx_out            (wx),
        .irq_lcdstat       (irq_lcdstat)
    );

    vram u_vram (
        .clk         (clk),
        .ce_gb       (ce_gb),
        .ce_m        (ce_m),
        .rst         (rst),
        .addr        (addr),
        .data_in     (data_in),
        .we          (we),
        .sel         (sel_ppu_vram),
        .data_out    (ppu_vram_data_out),
        .stall       (),
        .mode_next   (mode_next),
        .render_addr (vram_render_addr),
        .render_data (vram_render_data)
    );

    oam u_oam (
        .clk         (clk),
        .ce_gb       (ce_gb),
        .ce_m        (ce_m),
        .rst         (rst),
        .addr        (addr),
        .data_in     (data_in),
        .we          (we),
        .sel         (sel_ppu_oam),
        .data_out    (ppu_oam_data_out),
        .stall       (),
        .mode_next   (mode_next),
        .dma_active  (dma_active),
        .entry_idx   (oam_entry_idx),
        .entry_data  (oam_entry_data),
        .dma_we      (dma_we),
        .dma_waddr   (dma_waddr),
        .dma_wdata   (dma_wdata)
    );

endmodule