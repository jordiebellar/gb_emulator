// =============================================================================
// Project      : GameBoy Emulator
// File         : memory_map.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : decodes addr to figure out which peripheral owns this access
//                  muxes that peripheral's data back to cpu on reads, forwards
//                  data_out to it on writes. also owns ie/if storage directly
//                  and exposes them to the cpu's side-channel ie/if_reg
//                  inputs, and accepts the cpu's if_clear/if_clear_we
//                  dispatch-clear pulse per section 5 of the interface
//                  contract
// Revision     : 1.2 - expose ie/if_reg as direct outputs to cpu, accept
//                  if_clear/if_clear_we, added sel_boot_disable (0xFF50)
// =============================================================================
`timescale 1ns / 1ps

module memory_map (
    input  wire        clk_100m,
    input  wire        ce,
    input  wire        rst,

    input  wire [15:0] addr,
    input  wire [7:0]  data_out,
    output reg  [7:0]  data_in,
    input  wire        we,
    output wire         bus_stall,

    output reg  [7:0]  ie,
    output reg  [7:0]  if_reg,
    input  wire [7:0]  if_clear,
    input  wire        if_clear_we,

    output reg          sel_cart_rom,
    input  wire [7:0]   cart_rom_data_out,
    input  wire         cart_rom_stall,

    output reg          sel_boot_disable,
    input  wire [7:0]   boot_disable_data_out,

    output reg          sel_cart_ram,
    input  wire [7:0]   cart_ram_data_out,
    input  wire         cart_ram_stall,

    output reg          sel_wram,
    input  wire [7:0]   wram_data_out,
    input  wire         wram_stall,

    output reg          sel_ppu_vram,
    input  wire [7:0]   ppu_vram_data_out,
    input  wire         ppu_vram_stall,

    output reg          sel_ppu_oam,
    input  wire [7:0]   ppu_oam_data_out,
    input  wire         ppu_oam_stall,

    output reg          sel_ppu_reg,
    input  wire [7:0]   ppu_reg_data_out,
    input  wire         ppu_reg_stall,

    output reg          sel_joypad,
    input  wire [7:0]   joypad_data_out,
    input  wire         joypad_stall,

    output reg          sel_serial,
    input  wire [7:0]   serial_data_out,
    input  wire         serial_stall,

    output reg          sel_timer,
    input  wire [7:0]   timer_data_out,
    input  wire         timer_stall,

    output reg          sel_apu,
    input  wire [7:0]   apu_data_out,
    input  wire         apu_stall,

    output reg          sel_hram,
    input  wire [7:0]   hram_data_out,
    input  wire         hram_stall
);

    reg sel_ie;
    reg sel_if;

    always @(*) begin
        sel_cart_rom     = 1'b0;
        sel_boot_disable = 1'b0;
        sel_cart_ram     = 1'b0;
        sel_wram         = 1'b0;
        sel_ppu_vram     = 1'b0;
        sel_ppu_oam      = 1'b0;
        sel_joypad       = 1'b0;
        sel_serial       = 1'b0;
        sel_timer        = 1'b0;
        sel_if           = 1'b0;
        sel_apu          = 1'b0;
        sel_ppu_reg      = 1'b0;
        sel_hram         = 1'b0;
        sel_ie           = 1'b0;

        if (addr >= 16'h0000 && addr <= 16'h7FFF)
            sel_cart_rom = 1'b1;
        else if (addr >= 16'h8000 && addr <= 16'h9FFF)
            sel_ppu_vram = 1'b1;
        else if (addr >= 16'hA000 && addr <= 16'hBFFF)
            sel_cart_ram = 1'b1;
        else if (addr >= 16'hC000 && addr <= 16'hDFFF)
            sel_wram = 1'b1;
        else if (addr >= 16'hE000 && addr <= 16'hFDFF)
            sel_wram = 1'b1;
        else if (addr >= 16'hFE00 && addr <= 16'hFE9F)
            sel_ppu_oam = 1'b1;
        else if (addr == 16'hFF00)
            sel_joypad = 1'b1;
        else if (addr >= 16'hFF01 && addr <= 16'hFF02)
            sel_serial = 1'b1;
        else if (addr >= 16'hFF04 && addr <= 16'hFF07)
            sel_timer = 1'b1;
        else if (addr == 16'hFF0F)
            sel_if = 1'b1;
        else if (addr >= 16'hFF10 && addr <= 16'hFF3F)
            sel_apu = 1'b1;
        else if (addr >= 16'hFF40 && addr <= 16'hFF4B)
            sel_ppu_reg = 1'b1;
        else if (addr == 16'hFF50)
            sel_boot_disable = 1'b1;
        else if (addr >= 16'hFF80 && addr <= 16'hFFFE)
            sel_hram = 1'b1;
        else if (addr == 16'hFFFF)
            sel_ie = 1'b1;
    end

    always @(*) begin
        if (sel_cart_rom)          data_in = cart_rom_data_out;
        else if (sel_boot_disable) data_in = boot_disable_data_out;
        else if (sel_cart_ram)     data_in = cart_ram_data_out;
        else if (sel_wram)         data_in = wram_data_out;
        else if (sel_ppu_vram)     data_in = ppu_vram_data_out;
        else if (sel_ppu_oam)      data_in = ppu_oam_data_out;
        else if (sel_joypad)       data_in = joypad_data_out;
        else if (sel_serial)       data_in = serial_data_out;
        else if (sel_timer)        data_in = timer_data_out;
        else if (sel_if)           data_in = if_reg;
        else if (sel_apu)          data_in = apu_data_out;
        else if (sel_ppu_reg)      data_in = ppu_reg_data_out;
        else if (sel_hram)         data_in = hram_data_out;
        else if (sel_ie)           data_in = ie;
        else                       data_in = 8'hFF;
    end

    assign bus_stall = (sel_cart_rom && cart_rom_stall) ||
                        (sel_cart_ram && cart_ram_stall) ||
                        (sel_wram     && wram_stall)     ||
                        (sel_ppu_vram && ppu_vram_stall) ||
                        (sel_ppu_oam  && ppu_oam_stall)  ||
                        (sel_joypad   && joypad_stall)   ||
                        (sel_serial   && serial_stall)   ||
                        (sel_timer    && timer_stall)    ||
                        (sel_apu      && apu_stall)      ||
                        (sel_ppu_reg  && ppu_reg_stall)  ||
                        (sel_hram     && hram_stall);

    always @(posedge clk_100m or posedge rst) begin
        if (rst) begin
            ie     <= 8'h00;
            if_reg <= 8'h00;
        end
        else if (ce) begin
            if (we && sel_ie)
                ie <= data_out;

            if (we && sel_if)
                if_reg <= data_out;
            else if (if_clear_we)
                if_reg <= if_reg & ~if_clear;
        end
    end

endmodule