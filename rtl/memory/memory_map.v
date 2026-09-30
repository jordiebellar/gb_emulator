// =============================================================================
// Project      : GameBoy Emulator
// File         : memory_map.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : pure address decode and read mux, per interface contract
//                  rev 2. holds no storage and no clock at all - ie/if
//                  moved to interrupt_ctrl.v (wired directly to the cpu,
//                  bypassing this module entirely per section 1), and
//                  there is no bus_stall to aggregate (the dmg never
//                  waits on the bus, section 4). writes pass through
//                  untouched; each peripheral commits its own write on
//                  its own sel && we && ce_m.
// Revision     : 2.0 - rewritten for interface contract rev 2: dropped
//                  ie/if storage, if_clear handling, and bus_stall.
//                  added selects for interrupt_ctrl (FF0F/FFFF, one
//                  peripheral), timer, serial, and oam_dma (FF46, which
//                  now splits the ppu register range in two).
// =============================================================================
`timescale 1ns / 1ps

module memory_map (
    input  wire [15:0] addr,
    input  wire [7:0]  data_out,  // from cpu
    output reg  [7:0]  data_in,   // to cpu
    input  wire        we,

    output reg          sel_cart_rom,
    input  wire [7:0]   cart_rom_data_out,

    output reg          sel_boot_disable,
    input  wire [7:0]   boot_disable_data_out,

    output reg          sel_cart_ram,
    input  wire [7:0]   cart_ram_data_out,

    output reg          sel_wram,
    input  wire [7:0]   wram_data_out,

    output reg          sel_ppu_vram,
    input  wire [7:0]   ppu_vram_data_out,

    output reg          sel_ppu_oam,
    input  wire [7:0]   ppu_oam_data_out,

    output reg          sel_ppu_reg,
    input  wire [7:0]   ppu_reg_data_out,

    output reg          sel_oam_dma,
    input  wire [7:0]   oam_dma_data_out,

    output reg          sel_joypad,
    input  wire [7:0]   joypad_data_out,

    output reg          sel_serial,
    input  wire [7:0]   serial_data_out,

    output reg          sel_timer,
    input  wire [7:0]   timer_data_out,

    output reg          sel_interrupt_ctrl,
    input  wire [7:0]   interrupt_ctrl_data_out,

    output reg          sel_apu,
    input  wire [7:0]   apu_data_out,

    output reg          sel_hram,
    input  wire [7:0]   hram_data_out
);

    // --- address decode -----------------------------------------------
    // pure combinational, no clock involved - addr is valid for the
    // whole m-cycle, this just reacts to whatever is currently on the
    // bus. sel_ppu_reg is asserted by two separate ranges (FF40-45 and
    // FF47-4B), split by oam_dma at FF46 in between - same pattern
    // already used for sel_wram covering both the real range and its
    // echo mirror.
    always @(*) begin
        sel_cart_rom       = 1'b0;
        sel_boot_disable   = 1'b0;
        sel_cart_ram       = 1'b0;
        sel_wram           = 1'b0;
        sel_ppu_vram       = 1'b0;
        sel_ppu_oam        = 1'b0;
        sel_ppu_reg        = 1'b0;
        sel_oam_dma        = 1'b0;
        sel_joypad         = 1'b0;
        sel_serial         = 1'b0;
        sel_timer          = 1'b0;
        sel_interrupt_ctrl = 1'b0;
        sel_apu            = 1'b0;
        sel_hram           = 1'b0;

        if (addr >= 16'h0000 && addr <= 16'h7FFF)
            sel_cart_rom = 1'b1;
        else if (addr >= 16'h8000 && addr <= 16'h9FFF)
            sel_ppu_vram = 1'b1;
        else if (addr >= 16'hA000 && addr <= 16'hBFFF)
            sel_cart_ram = 1'b1;
        else if (addr >= 16'hC000 && addr <= 16'hDFFF)
            sel_wram = 1'b1;
        else if (addr >= 16'hE000 && addr <= 16'hFDFF)
            sel_wram = 1'b1; // echo ram, mirrors wram via address masking
        else if (addr >= 16'hFE00 && addr <= 16'hFE9F)
            sel_ppu_oam = 1'b1;
        else if (addr == 16'hFF00)
            sel_joypad = 1'b1;
        else if (addr >= 16'hFF01 && addr <= 16'hFF02)
            sel_serial = 1'b1;
        else if (addr >= 16'hFF04 && addr <= 16'hFF07)
            sel_timer = 1'b1;
        else if (addr == 16'hFF0F)
            sel_interrupt_ctrl = 1'b1; // IF
        else if (addr >= 16'hFF10 && addr <= 16'hFF3F)
            sel_apu = 1'b1;
        else if (addr >= 16'hFF40 && addr <= 16'hFF45)
            sel_ppu_reg = 1'b1;
        else if (addr == 16'hFF46)
            sel_oam_dma = 1'b1;
        else if (addr >= 16'hFF47 && addr <= 16'hFF4B)
            sel_ppu_reg = 1'b1;
        else if (addr == 16'hFF50)
            sel_boot_disable = 1'b1;
        else if (addr >= 16'hFF80 && addr <= 16'hFFFE)
            sel_hram = 1'b1;
        else if (addr == 16'hFFFF)
            sel_interrupt_ctrl = 1'b1; // IE
        // everything else (FEA0-FEFF, FF03, FF08-FF0E, FF51-FF7F) falls
        // through with no sel asserted, reads 0xFF, writes ignored
    end

    // --- read mux -------------------------------------------------------
    // combinational, forwards whichever peripheral is currently selected
    // back to the cpu. unmapped addresses read as 0xFF.
    always @(*) begin
        if (sel_cart_rom)            data_in = cart_rom_data_out;
        else if (sel_boot_disable)   data_in = boot_disable_data_out;
        else if (sel_cart_ram)       data_in = cart_ram_data_out;
        else if (sel_wram)           data_in = wram_data_out;
        else if (sel_ppu_vram)       data_in = ppu_vram_data_out;
        else if (sel_ppu_oam)        data_in = ppu_oam_data_out;
        else if (sel_joypad)         data_in = joypad_data_out;
        else if (sel_serial)         data_in = serial_data_out;
        else if (sel_timer)          data_in = timer_data_out;
        else if (sel_interrupt_ctrl) data_in = interrupt_ctrl_data_out;
        else if (sel_apu)            data_in = apu_data_out;
        else if (sel_ppu_reg)        data_in = ppu_reg_data_out;
        else if (sel_oam_dma)        data_in = oam_dma_data_out;
        else if (sel_hram)           data_in = hram_data_out;
        else                         data_in = 8'hFF;
    end

    // note: 'we' and 'data_out' are not consumed here at all - they are
    // shared bus signals, broadcast directly to every peripheral in
    // gb_top.v, unrelated to this module's own decode/mux. each
    // peripheral commits its own write on its own sel && we && ce_m.
    // memory_map has no registered state and nothing left to clock.

endmodule