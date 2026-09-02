// =============================================================================
// Project      : GameBoy Emulator
// File         : memory_map.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : decodes addr to figure out which peripheral owns this access
//                  muxes that peripheral's data back to cpu on reads, forwards
//                  data_out to it on writes
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module memory_map (
    input  wire        clk_100m, // 100MHz clk signal
    input  wire        ce,         // clk enable
    input  wire        rst,        // reset

    input  wire [15:0] addr,       // address input
    input  wire [7:0]  data_out,   // data from cpu (write)
    output reg  [7:0]  data_in,    // data to cpu (read)
    input  wire        we,         // write enable
    output wire        bus_stall, // ORed stall from every peripheral

    // --- cartridge rom -------------------------------------------------
    output reg          sel_cart_rom,
    input  wire [7:0]   cart_rom_data_out,
    input  wire         cart_rom_stall,

    // --- cartridge ram -------------------------------------------------
    output reg          sel_cart_ram,
    input  wire [7:0]   cart_ram_data_out,
    input  wire         cart_ram_stall,

    // --- wram, also covers echo ram -------------------------------------
    output reg          sel_wram,
    input  wire [7:0]   wram_data_out,
    input  wire         wram_stall,

    // --- ppu vram --------------------------------------------------------
    output reg          sel_ppu_vram,
    input  wire [7:0]   ppu_vram_data_out,
    input  wire         ppu_vram_stall,

    // --- ppu oam --------------------------------------------------------
    output reg          sel_ppu_oam,
    input  wire [7:0]   ppu_oam_data_out,
    input  wire         ppu_oam_stall,

    // --- ppu registers, lcdc/stat/scy/scx/ly/lyc etc --------------------
    output reg          sel_ppu_reg,
    input  wire [7:0]   ppu_reg_data_out,
    input  wire         ppu_reg_stall,

    // --- joypad -----------------------------------------------------------
    output reg          sel_joypad,
    input  wire [7:0]   joypad_data_out,
    input  wire         joypad_stall,

    // --- serial, not implemented yet, reads 0xFF until it exists --------
    output reg          sel_serial,
    input  wire [7:0]   serial_data_out,
    input  wire         serial_stall,

    // --- timer ------------------------------------------------------------
    output reg          sel_timer,
    input  wire [7:0]   timer_data_out,
    input  wire         timer_stall,

    // --- apu, stretch goal -------------------------------------------------
    output reg          sel_apu,
    input  wire [7:0]   apu_data_out,
    input  wire         apu_stall,

    // --- hram -------------------------------------------------------------
    output reg          sel_hram,
    input  wire [7:0]   hram_data_out,
    input  wire         hram_stall
);

    // --- ie / if storage --------------------------------------------------
    // memory_map owns these two registers directly, everything else here
    // is pure routing
    // TODO: once ppu/timer/joypad exist, OR their irq_* pulses into if_reg
    // per section 5 of the interface contract, set should win over a
    // same-cycle cpu clear
    reg [7:0] ie_reg;
    reg [7:0] if_reg;
    reg       sel_ie;
    reg       sel_if;

    // --- address decode -----------------------------------------------------
    // pure combinational, no ce needed, addr is valid every cycle and this
    // just reacts to whatever is currently on the bus
    always @(*) begin
        sel_cart_rom = 1'b0;
        sel_cart_ram = 1'b0;
        sel_wram     = 1'b0;
        sel_ppu_vram = 1'b0;
        sel_ppu_oam  = 1'b0;
        sel_joypad   = 1'b0;
        sel_serial   = 1'b0;
        sel_timer    = 1'b0;
        sel_if       = 1'b0;
        sel_apu      = 1'b0;
        sel_ppu_reg  = 1'b0;
        sel_hram     = 1'b0;
        sel_ie       = 1'b0;

        if (addr >= 16'h0000 && addr <= 16'h7FFF)
            sel_cart_rom = 1'b1;
        else if (addr >= 16'h8000 && addr <= 16'h9FFF)
            sel_ppu_vram = 1'b1;
        else if (addr >= 16'hA000 && addr <= 16'hBFFF)
            sel_cart_ram = 1'b1;
        else if (addr >= 16'hC000 && addr <= 16'hDFFF)
            sel_wram = 1'b1;
        else if (addr >= 16'hE000 && addr <= 16'hFDFF)
            sel_wram = 1'b1;          // echo ram, mirrors wram
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
        else if (addr >= 16'hFF80 && addr <= 16'hFFFE)
            sel_hram = 1'b1;
        else if (addr == 16'hFFFF)
            sel_ie = 1'b1;
        // everything else (0xFEA0-0xFEFF, 0xFF03, 0xFF08-0xFF0E, etc)
        // falls through with no sel asserted, reads 0xFF, writes ignored
    end

    // --- read mux -----------------------------------------------------------
    // combinational, forwards whichever peripheral is currently selected
    // back to the cpu, unmapped addresses read as 0xFF
    always @(*) begin
        if (sel_cart_rom)      data_in = cart_rom_data_out;
        else if (sel_cart_ram) data_in = cart_ram_data_out;
        else if (sel_wram)     data_in = wram_data_out;
        else if (sel_ppu_vram) data_in = ppu_vram_data_out;
        else if (sel_ppu_oam)  data_in = ppu_oam_data_out;
        else if (sel_joypad)   data_in = joypad_data_out;
        else if (sel_serial)   data_in = serial_data_out;
        else if (sel_timer)    data_in = timer_data_out;
        else if (sel_if)       data_in = if_reg;
        else if (sel_apu)      data_in = apu_data_out;
        else if (sel_ppu_reg)  data_in = ppu_reg_data_out;
        else if (sel_hram)     data_in = hram_data_out;
        else if (sel_ie)       data_in = ie_reg;
        else                   data_in = 8'hFF;
    end

    // --- stall aggregation --------------------------------------------------
    // only whichever peripheral is currently selected can stall the cpu
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

    // --- ie / if register writes ---------------------------------------
    // plain read/write storage for now, gated on ce like everything else
    // TODO: if_reg set side needs irq_* inputs, see note above
    always @(posedge clk_100m or posedge rst) begin
        if (rst) begin
            ie_reg <= 8'h00;
            if_reg <= 8'h00;
        end
        else if (ce) begin
            if (we && sel_ie)
                ie_reg <= data_out;
            if (we && sel_if)
                if_reg <= data_out;
        end
    end

endmodule
