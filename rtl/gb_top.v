// =============================================================================
// Project      : GameBoy Emulator
// File         : gb_top.v
// Author       : Aaron Luebbert
// Date         : 2026-10-20
// Description  : top level wiring for interface contract rev 2. one 100 mhz
//                  clock, clk_div makes ce_gb, ce_m and ce_vga. the cpu is
//                  jordie's cpu.v, it commits every bus access on ce_m.
//                  memory_map is pure decode and read mux, every peripheral
//                  commits its own write on sel && we && ce_m.
//
//                  peripherals on the bus
//                    - cartridge, boot rom overlay, the game rom (block ram or an
//                      sd card), the mapper and cart ram
//                    - wram and hram
//                    - ppu, vram oam and the ppu registers, plus video
//                    - oam dma unit at ff46
//                    - interrupt_ctrl at ff0f and ffff, timer at ff04-ff07
//                    - joypad at ff00
//                  serial and the apu are not built yet, their reads return
//                  ff and writes are ignored.
//
//                  oam dma. the dma unit is a bus master while a transfer
//                  runs. the cpu keeps hram and the io registers, so the
//                  cpu side peripherals (hram, io, interrupt_ctrl, timer,
//                  ppu registers) always see cpu_addr. the memory side
//                  peripherals (cartridge rom, wram) see dma_addr while a
//                  transfer is running. a cpu access below ff00 during a
//                  transfer is dropped, writes ignored and reads return ff
//                  (cpu_blocked from the dma unit). the source pages that
//                  work are rom (00-7f) and wram (c0-df, e0-ff folds onto
//                  c0-df in the dma unit). pages 80-bf read ff, vram as a
//                  dma source is not supported because the ppu has one
//                  address port.
// Revision     : 2.1 - sd card cartridge, mapper, clock enable hold
//                  2.0 - rewritten for contract rev 2. cpu with ce_m, ppu and
//                  video, oam dma steering, interrupt_ctrl, timer, joypad.
//                  1.0 - first integration, cpu on the raw clock
// =============================================================================
`timescale 1ns / 1ps

module gb_top #(
    parameter BOOT_ROM_FILE = "roms/boot/boot_rom.hex",
    parameter CART_ROM_FILE = "roms/game/cart_rom.hex",
    parameter GREEN         = 1,
    // cartridge, see cartridge.v. the defaults are the old 32kb rom in block ram
    parameter integer SD_MODE     = 0,
    parameter integer ROM_BYTES   = 32768,
    parameter integer RAM_BYTES   = 8192,
    parameter integer CACHE_LINES = 64,
    parameter [15:0]  SD_DIV_SLOW = 16'd125,
    parameter [15:0]  SD_DIV_FAST = 16'd2,
    parameter integer SD_PWR_CLKS = 100000,
    parameter integer RTC_TICKS   = 100000000
) (
    input  wire        clk_100m,
    input  wire        rst,

    // buttons, active high when pressed
    input  wire        btn_right,
    input  wire        btn_left,
    input  wire        btn_up,
    input  wire        btn_down,
    input  wire        btn_a,
    input  wire        btn_b,
    input  wire        btn_select,
    input  wire        btn_start,

    // vga
    output wire [3:0]  vga_r,
    output wire [3:0]  vga_g,
    output wire [3:0]  vga_b,
    output wire        vga_hsync,
    output wire        vga_vsync,

    output wire        lcd_on,

    // sd card cartridge, idle when SD_MODE is 0
    output wire        sd_cs_n,
    output wire        sd_sck,
    output wire        sd_mosi,
    input  wire        sd_miso,
    output wire [2:0]  cart_status,

    // apu
    output wire        audio_pin,

    // debug
    output wire [15:0] debug_cpu_addr,
    output wire [7:0]  debug_cpu_data_out,
    output wire        debug_cpu_we,
    output wire [7:0]  debug_bus_data_in,
    output wire [7:0]  debug_ie,
    output wire [7:0]  debug_if_reg,
    output wire        debug_dma_active
);

    // ------------------------------------------------------------------------
    // clocks
    // ------------------------------------------------------------------------
    wire ce_gb, ce_m, ce_vga;
    wire cart_stall;

    clk_div u_clk_div (
        .clk_100m (clk_100m), .rst (rst), .hold (cart_stall),
        .ce_gb (ce_gb), .ce_m (ce_m), .ce_vga (ce_vga)
    );

    // ------------------------------------------------------------------------
    // cpu
    // ------------------------------------------------------------------------
    wire [15:0] cpu_addr;
    wire [7:0]  cpu_data_out;
    wire        cpu_we;
    wire [7:0]  cpu_din;
    wire [7:0]  ie_wire, if_reg_wire, if_clear_wire;
    wire        if_clear_we_wire;

    cpu u_cpu (
        .clk (clk_100m), .ce_m (ce_m), .rst (rst),
        .data_in (cpu_din),
        .ie (ie_wire), .if_reg (if_reg_wire),
        .we (cpu_we), .addr (cpu_addr), .data_out (cpu_data_out),
        .if_clear (if_clear_wire), .if_clear_we (if_clear_we_wire)
    );

    // ------------------------------------------------------------------------
    // address decode and read mux, from the cpu address
    // ------------------------------------------------------------------------
    wire sel_cart_rom, sel_boot_disable, sel_cart_ram, sel_wram;
    wire sel_ppu_vram, sel_ppu_oam, sel_ppu_reg, sel_oam_dma;
    wire sel_joypad, sel_serial, sel_timer, sel_interrupt_ctrl, sel_apu, sel_hram;

    wire [7:0] cart_data_out, cart_ram_data_out, wram_data_out, hram_data_out;
    wire [7:0] ppu_vram_data_out, ppu_oam_data_out, ppu_reg_data_out;
    wire [7:0] oam_dma_data_out, joypad_data_out, timer_data_out, ic_data_out, ic_view;
    wire [7:0] mm_data_in;
    wire [7:0] apu_rdata;
    wire [9:0] apu_sample;
    wire       apu_wr = cpu_we & ce_m;

    memory_map u_memory_map (
        .addr (cpu_addr), .data_out (cpu_data_out), .data_in (mm_data_in), .we (cpu_we),

        .sel_cart_rom (sel_cart_rom),               .cart_rom_data_out (cart_data_out),
        // the cartridge answers ff on its own boot disable select
        .sel_boot_disable (sel_boot_disable),       .boot_disable_data_out (8'hFF),
        .sel_cart_ram (sel_cart_ram),               .cart_ram_data_out (cart_ram_data_out),
        .sel_wram (sel_wram),                       .wram_data_out (wram_data_out),
        .sel_ppu_vram (sel_ppu_vram),               .ppu_vram_data_out (ppu_vram_data_out),
        .sel_ppu_oam (sel_ppu_oam),                 .ppu_oam_data_out (ppu_oam_data_out),
        .sel_ppu_reg (sel_ppu_reg),                 .ppu_reg_data_out (ppu_reg_data_out),
        .sel_oam_dma (sel_oam_dma),                 .oam_dma_data_out (oam_dma_data_out),
        .sel_joypad (sel_joypad),                   .joypad_data_out (joypad_data_out),
        .sel_serial (sel_serial),                   .serial_data_out (8'hFF),
        .sel_timer (sel_timer),                     .timer_data_out (timer_data_out),
        .sel_interrupt_ctrl (sel_interrupt_ctrl),   .interrupt_ctrl_data_out (ic_data_out),
        .sel_apu (sel_apu),                         .apu_data_out (apu_rdata),
        .sel_interrupt_ctrl (sel_interrupt_ctrl),   .interrupt_ctrl_data_out (ic_view),
        .sel_apu (sel_apu),                         .apu_data_out (8'hFF),
        .sel_hram (sel_hram),                       .hram_data_out (hram_data_out)
    );

    // ------------------------------------------------------------------------
    // oam dma and the bus steering around it
    // ------------------------------------------------------------------------
    wire [15:0] dma_addr;
    wire [7:0]  dma_rdata;
    wire        dma_we, dma_active, cpu_blocked;
    wire [7:0]  dma_waddr, dma_wdata;

    oam_dma u_oam_dma (
        .clk (clk_100m), .ce_m (ce_m), .rst (rst),
        .addr (cpu_addr), .data_in (cpu_data_out), .we (cpu_we),
        .sel (sel_oam_dma), .data_out (oam_dma_data_out),
        .dma_addr (dma_addr), .dma_rdata (dma_rdata),
        .dma_we (dma_we), .dma_waddr (dma_waddr), .dma_wdata (dma_wdata),
        .dma_active (dma_active),
        .cpu_addr (cpu_addr), .cpu_blocked (cpu_blocked)
    );

    // source decode, the dma page is already folded to 00-df by the unit
    wire dma_src_rom  = ~dma_addr[15];
    wire dma_src_wram = (dma_addr[15:13] == 3'b110);

    // memory side peripherals, dma owns them while a transfer runs
    wire [15:0] mem_addr         = dma_active ? dma_addr : cpu_addr;
    wire        cart_sel_rom_eff = dma_active ? dma_src_rom  : sel_cart_rom;
    wire        wram_sel_eff     = dma_active ? dma_src_wram : sel_wram;
    wire        wram_we_eff      = cpu_we & ~dma_active;

    assign dma_rdata = dma_src_rom  ? cart_data_out :
                       dma_src_wram ? wram_data_out : 8'hFF;

    // the cpu sees ff for anything below ff00 during a transfer.
    // registered every clock to cut the peripheral read paths from the cpu
    // datapath. the cpu only samples on ce_m, and no gb state changes in the
    // 22+ clocks before a ce_m edge, so this is the same value it would see
    reg [7:0] cpu_din_q;
    always @(posedge clk_100m)
        cpu_din_q <= cpu_blocked ? 8'hFF : mm_data_in;
    assign cpu_din = cpu_din_q;

    // vram is dropped for the cpu during a transfer, oam is handled in the ppu
    wire sel_ppu_vram_eff = sel_ppu_vram & ~cpu_blocked;

    // ------------------------------------------------------------------------
    // memory
    // ------------------------------------------------------------------------
    // a rom read is in progress, from the cpu or from the dma unit. writes into
    // the rom space are mapper writes, and only the cpu makes them
    wire cart_rom_rd = dma_active ? dma_src_rom : (sel_cart_rom & ~cpu_we);
    wire cart_mbc_wr = cpu_we & sel_cart_rom & ~dma_active;
    wire cart_ram_we = cpu_we & ~dma_active;

    cartridge #(
        .BOOT_ROM_FILE (BOOT_ROM_FILE), .CART_ROM_FILE (CART_ROM_FILE),
        .SD_MODE (SD_MODE), .ROM_BYTES (ROM_BYTES), .RAM_BYTES (RAM_BYTES),
        .CACHE_LINES (CACHE_LINES), .SD_DIV_SLOW (SD_DIV_SLOW), .SD_DIV_FAST (SD_DIV_FAST),
        .SD_PWR_CLKS (SD_PWR_CLKS), .RTC_TICKS (RTC_TICKS)
    ) u_cartridge (
        .clk (clk_100m), .ce_gb (ce_gb), .ce_m (ce_m), .rst (rst),
        .addr (mem_addr), .cpu_addr (cpu_addr), .data_in (cpu_data_out), .we (cpu_we),
        .sel_cart_rom (cart_sel_rom_eff), .sel_boot_disable (sel_boot_disable),
        .rom_rd (cart_rom_rd), .mbc_wr (cart_mbc_wr),
        .sel_cart_ram (sel_cart_ram), .ram_we (cart_ram_we),
        .data_out (cart_data_out), .ram_data_out (cart_ram_data_out), .stall (cart_stall),
        .sd_cs_n (sd_cs_n), .sd_sck (sd_sck), .sd_mosi (sd_mosi), .sd_miso (sd_miso),
        .status (cart_status)
    );

    wram u_wram (
        .clk (clk_100m), .ce_gb (ce_gb), .ce_m (ce_m), .rst (rst),
        .addr (mem_addr), .data_in (cpu_data_out), .we (wram_we_eff),
        .sel (wram_sel_eff), .data_out (wram_data_out), .stall ()
    );

    hram u_hram (
        .clk (clk_100m), .ce_gb (ce_gb), .ce_m (ce_m), .rst (rst),
        .addr (cpu_addr), .data_in (cpu_data_out), .we (cpu_we),
        .sel (sel_hram), .data_out (hram_data_out), .stall ()
    );

    // ------------------------------------------------------------------------
    // ppu and video
    // ------------------------------------------------------------------------
    wire       pixel_valid, irq_vblank, irq_lcdstat, irq_vblank_view, irq_lcdstat_view;
    wire [1:0] pixel_color, pixel_shade;
    wire [7:0] pixel_x, pixel_y;

    ppu u_ppu (
        .clk (clk_100m), .ce_gb (ce_gb), .ce_m (ce_m), .rst (rst),
        .addr (cpu_addr), .data_in (cpu_data_out), .we (cpu_we),
        .sel_ppu_vram (sel_ppu_vram_eff), .ppu_vram_data_out (ppu_vram_data_out),
        .sel_ppu_oam (sel_ppu_oam),       .ppu_oam_data_out (ppu_oam_data_out),
        .sel_ppu_reg (sel_ppu_reg),       .ppu_reg_data_out (ppu_reg_data_out),
        .dma_active (dma_active),
        .dma_we (dma_we), .dma_waddr (dma_waddr), .dma_wdata (dma_wdata),
        .pixel_valid (pixel_valid), .pixel_color (pixel_color),
        .pixel_shade (pixel_shade), .pixel_x (pixel_x), .pixel_y (pixel_y),
        .lcd_on (lcd_on),
        .irq_vblank (irq_vblank), .irq_lcdstat (irq_lcdstat),
        .irq_vblank_view (irq_vblank_view), .irq_lcdstat_view (irq_lcdstat_view)
    );

    video #(.GREEN (GREEN)) u_video (
        .clk (clk_100m), .ce_gb (ce_gb), .ce_vga (ce_vga), .rst (rst),
        .lcd_on (lcd_on),
        .pixel_valid (pixel_valid), .pixel_x (pixel_x), .pixel_y (pixel_y),
        .pixel_shade (pixel_shade),
        .vga_r (vga_r), .vga_g (vga_g), .vga_b (vga_b),
        .vga_hsync (vga_hsync), .vga_vsync (vga_vsync)
    );

    // ------------------------------------------------------------------------
    // interrupts, timer, joypad
    // ------------------------------------------------------------------------
    wire irq_timer, irq_joypad, irq_timer_view, irq_joypad_view;

    // ff0f read view. interrupt_ctrl folds the irq strobes into its data_out only
    // when ce_gb is high, but the cpu samples the clock before the ce_m edge where
    // ce_gb is low. so build the view here from the ungated strobes, with the
    // dispatch clear applied the same way. ie reads keep the interrupt_ctrl value
    wire [4:0] ic_irq_view = {irq_joypad_view, 1'b0, irq_timer_view, irq_lcdstat_view, irq_vblank_view};
    wire [4:0] ic_if_view  = (if_reg_wire[4:0] & ~(if_clear_we_wire ? if_clear_wire[4:0] : 5'b0)) | ic_irq_view;
    assign ic_view         = (cpu_addr == 16'hFFFF) ? ic_data_out : {3'b111, ic_if_view};

    interrupt_ctrl u_interrupt_ctrl (
        .clk (clk_100m), .rst (rst), .ce_gb (ce_gb), .ce_m (ce_m),
        .addr (cpu_addr), .data_in (cpu_data_out), .we (cpu_we),
        .sel (sel_interrupt_ctrl),
        .irq_vblank (irq_vblank), .irq_lcdstat (irq_lcdstat),
        .irq_timer (irq_timer), .irq_serial (1'b0), .irq_joypad (irq_joypad),
        .if_clear (if_clear_wire), .if_clear_we (if_clear_we_wire),
        .ie (ie_wire), .if_reg (if_reg_wire),
        .data_out (ic_data_out), .stall ()
    );

    timer u_timer (
        .clk (clk_100m), .rst (rst), .ce_gb (ce_gb), .ce_m (ce_m),
        .addr (cpu_addr), .data_in (cpu_data_out), .we (cpu_we),
        .sel (sel_timer), .data_out (timer_data_out), .stall (),
        .irq_timer (irq_timer), .irq_timer_view (irq_timer_view)
    );

    joypad u_joypad (
        .clk (clk_100m), .ce_gb (ce_gb), .ce_m (ce_m), .rst (rst),
        .addr (cpu_addr), .data_in (cpu_data_out), .we (cpu_we),
        .sel (sel_joypad), .data_out (joypad_data_out), .stall (),
        .btn_right (btn_right), .btn_left (btn_left),
        .btn_up (btn_up), .btn_down (btn_down),
        .btn_a (btn_a), .btn_b (btn_b),
        .btn_select (btn_select), .btn_start (btn_start),
        .irq_joypad (irq_joypad), .irq_joypad_view (irq_joypad_view)
    );

    // ------------------------------------------------------------------------
    // audio / APU
    // ------------------------------------------------------------------------

    apu u_apu (
        .clk   (clk_100m),
        .ce_gb (ce_gb),
        .addr  (cpu_addr[5:0]),
        .sel   (sel_apu),
        .wr    (apu_wr),
        .wdata (cpu_data_out),
        .rdata (apu_rdata),
        .sample(apu_sample)
    );

    audio_out #(.W(10)) u_audio (
        .clk   (clk_100m),
        .sample(apu_sample),
        .pin   (audio_pin)
    );

    // ------------------------------------------------------------------------
    // debug
    // ------------------------------------------------------------------------
    assign debug_cpu_addr     = cpu_addr;
    assign debug_cpu_data_out = cpu_data_out;
    assign debug_cpu_we       = cpu_we;
    assign debug_bus_data_in  = cpu_din;
    assign debug_ie           = ie_wire;
    assign debug_if_reg       = if_reg_wire;
    assign debug_dma_active   = dma_active;

endmodule
