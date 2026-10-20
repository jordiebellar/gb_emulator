// =============================================================================
// Project      : GameBoy Emulator
// File         : cartridge.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : boot rom overlay (256b) plus flat 32kb rom-only cartridge,
//                  loaded via readmemh from BOOT_ROM_FILE/CART_ROM_FILE
//                  params. boot_active latch starts high on reset, cleared
//                  permanently by a nonzero write to the boot-disable
//                  register (sel_boot_disable, i.e. 0xFF50), committed on
//                  ce_m. gates whether the bottom 256 bytes answer from
//                  boot rom or cart rom. the rom read register is clocked
//                  every clock so it has settled by the ce_m edge where the
//                  cpu samples read data. two independent sel lines share
//                  one data_out, each driving 0 when not its own turn
//                  (section 3 rule), since this one module serves two
//                  separate address ranges under memory_map's decode.
// Revision     : 2.1 - rom read register now clocked every clock, see
//                  wram.v
//                  2.0 - ce split into ce_gb/ce_m
// =============================================================================
`timescale 1ns / 1ps

module cartridge #(
    parameter BOOT_ROM_FILE = "roms/boot/dmg_boot.hex",
    parameter CART_ROM_FILE = "roms/game/cart_rom.hex"
) (
    input  wire        clk,
    input  wire        ce_gb,           // unused
    input  wire        ce_m,
    input  wire        rst,
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,         // shared bus write data, only used by the boot-disable write
    input  wire        we,
    input  wire        sel_cart_rom,    // asserted for 0x0000-0x7FFF reads
    input  wire        sel_boot_disable,// asserted for the boot-disable register access
    output wire [7:0]  data_out,
    output wire        stall            // rom never blocks the cpu
);

    assign stall = 1'b0;

    reg [7:0] boot_rom [0:255];
    reg [7:0] cart_rom [0:32767];

    initial begin
        $readmemh(BOOT_ROM_FILE, boot_rom);
        $readmemh(CART_ROM_FILE, cart_rom);
    end

    // boot_active starts high on reset, cleared permanently by a nonzero
    // write to the boot-disable register. one-way until the next reset
    reg boot_active;

    always @(posedge clk or posedge rst) begin
        if (rst)
            boot_active <= 1'b1;
        else if (ce_m && sel_boot_disable && we && (data_in != 8'h00))
            boot_active <= 1'b0;
    end

    // rom read register, every clock. the boot overlay only covers the
    // bottom 256 bytes, everything else always comes from cart_rom
    reg [7:0] rom_rdata;

    always @(posedge clk) begin
        if (boot_active && addr[15:8] == 8'h00)
            rom_rdata <= boot_rom[addr[7:0]];
        else
            rom_rdata <= cart_rom[addr[14:0]];
    end

    // section 3: data_out is 0 when sel is low. two sels here, so the gate
    // picks whichever is active, 0 if neither is
    assign data_out = sel_cart_rom      ? rom_rdata :
                       sel_boot_disable ? 8'hFF :
                                          8'h00;

endmodule