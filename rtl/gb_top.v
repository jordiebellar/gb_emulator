// =============================================================================
// Project      : GameBoy Emulator
// File         : gb_top.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : top-level wiring - clk_div, cpu (jordie's), memory_map,
//                  wram, hram, cartridge. ppu/joypad/timer/serial/apu are
//                  not instantiated yet, their memory_map peripheral ports
//                  are tied off (data 0xFF, stall low) same pattern used
//                  throughout every testbench so far.
//
//                  KNOWN GAP: cpu.v has no ce input yet, so it is wired
//                  directly to clk_100m and runs unthrottled at 100MHz
//                  while every other module here only latches on ce_gb
//                  (~4.194304MHz). this is a real functional mismatch, not
//                  cosmetic - see the integration testbench for the
//                  measured consequence. cpu.v also has no bus_stall
//                  input yet, so memory_map's bus_stall output is exposed
//                  as a debug port here but not consumed anywhere.
// Revision     : 1.0 - initial integration, reflects current state of
//                  both sides, gaps included
// =============================================================================
`timescale 1ns / 1ps

module gb_top #(
    parameter BOOT_ROM_FILE = "roms/boot/dmg_boot.hex",
    parameter CART_ROM_FILE = "roms/game/cart_rom.hex"
) (
    input  wire clk_100m,
    input  wire rst,

    output wire [15:0] debug_cpu_addr,
    output wire [7:0]  debug_cpu_data_out,
    output wire        debug_cpu_we,
    output wire [7:0]  debug_bus_data_in,
    output wire [7:0]  debug_ie,
    output wire [7:0]  debug_if_reg,
    output wire        debug_bus_stall
);

    wire ce_gb, ce_vga; // ce_vga unused until video/ exists

    wire [15:0] cpu_addr;
    wire [7:0]  cpu_data_out;
    wire        cpu_we;
    wire [7:0]  bus_data_in;
    wire [7:0]  ie_wire;
    wire [7:0]  if_reg_wire;
    wire [7:0]  if_clear_wire;
    wire        if_clear_we_wire;
    wire        bus_stall_wire;

    wire sel_cart_rom, sel_boot_disable, sel_cart_ram, sel_wram;
    wire sel_ppu_vram, sel_ppu_oam, sel_ppu_reg, sel_joypad;
    wire sel_serial, sel_timer, sel_apu, sel_hram;

    wire [7:0] cart_rom_data_out;
    wire       cart_rom_stall;
    wire [7:0] wram_data_out;
    wire       wram_stall;
    wire [7:0] hram_data_out;
    wire       hram_stall;

    assign debug_cpu_addr     = cpu_addr;
    assign debug_cpu_data_out = cpu_data_out;
    assign debug_cpu_we       = cpu_we;
    assign debug_bus_data_in  = bus_data_in;
    assign debug_ie           = ie_wire;
    assign debug_if_reg       = if_reg_wire;
    assign debug_bus_stall    = bus_stall_wire;

    clk_div u_clk_div (
        .clk_100m (clk_100m),
        .rst      (rst),
        .ce_gb    (ce_gb),
        .ce_vga   (ce_vga)
    );

    // jordie's module, unmodified. no ce port exists yet - see header note.
    cpu u_cpu (
        .clk         (clk_100m),
        .rst         (rst),
        .data_in     (bus_data_in),
        .ie          (ie_wire),
        .if_reg      (if_reg_wire),
        .we          (cpu_we),
        .addr        (cpu_addr),
        .data_out    (cpu_data_out),
        .if_clear    (if_clear_wire),
        .if_clear_we (if_clear_we_wire)
    );

    memory_map u_memory_map (
        .clk_100m (clk_100m),
        .ce       (ce_gb),
        .rst      (rst),

        .addr     (cpu_addr),
        .data_out (cpu_data_out),
        .data_in  (bus_data_in),
        .we       (cpu_we),
        .bus_stall(bus_stall_wire),

        .ie          (ie_wire),
        .if_reg      (if_reg_wire),
        .if_clear    (if_clear_wire),
        .if_clear_we (if_clear_we_wire),

        .sel_cart_rom          (sel_cart_rom),
        .cart_rom_data_out     (cart_rom_data_out),
        .cart_rom_stall        (cart_rom_stall),

        .sel_boot_disable      (sel_boot_disable),
        .boot_disable_data_out (cart_rom_data_out),

        .sel_cart_ram          (sel_cart_ram),
        .cart_ram_data_out     (8'hFF),
        .cart_ram_stall        (1'b0),

        .sel_wram              (sel_wram),
        .wram_data_out         (wram_data_out),
        .wram_stall            (wram_stall),

        .sel_ppu_vram          (sel_ppu_vram),
        .ppu_vram_data_out     (8'hFF),
        .ppu_vram_stall        (1'b0),

        .sel_ppu_oam           (sel_ppu_oam),
        .ppu_oam_data_out      (8'hFF),
        .ppu_oam_stall         (1'b0),

        .sel_ppu_reg           (sel_ppu_reg),
        .ppu_reg_data_out      (8'hFF),
        .ppu_reg_stall         (1'b0),

        .sel_joypad            (sel_joypad),
        .joypad_data_out       (8'hFF),
        .joypad_stall          (1'b0),

        .sel_serial            (sel_serial),
        .serial_data_out       (8'hFF),
        .serial_stall          (1'b0),

        .sel_timer             (sel_timer),
        .timer_data_out        (8'hFF),
        .timer_stall           (1'b0),

        .sel_apu               (sel_apu),
        .apu_data_out          (8'hFF),
        .apu_stall             (1'b0),

        .sel_hram              (sel_hram),
        .hram_data_out         (hram_data_out),
        .hram_stall            (hram_stall)
    );

    wram u_wram (
        .clk      (clk_100m),
        .ce       (ce_gb),
        .rst      (rst),
        .addr     (cpu_addr),
        .data_in  (cpu_data_out),
        .we       (cpu_we),
        .sel      (sel_wram),
        .data_out (wram_data_out),
        .stall    (wram_stall)
    );

    hram u_hram (
        .clk      (clk_100m),
        .ce       (ce_gb),
        .rst      (rst),
        .addr     (cpu_addr),
        .data_in  (cpu_data_out),
        .we       (cpu_we),
        .sel      (sel_hram),
        .data_out (hram_data_out),
        .stall    (hram_stall)
    );

    cartridge #(
        .BOOT_ROM_FILE (BOOT_ROM_FILE),
        .CART_ROM_FILE (CART_ROM_FILE)
    ) u_cartridge (
        .clk              (clk_100m),
        .ce               (ce_gb),
        .rst              (rst),
        .addr             (cpu_addr),
        .data_in          (cpu_data_out),
        .we               (cpu_we),
        .sel_cart_rom     (sel_cart_rom),
        .sel_boot_disable (sel_boot_disable),
        .data_out         (cart_rom_data_out),
        .stall            (cart_rom_stall)
    );

endmodule