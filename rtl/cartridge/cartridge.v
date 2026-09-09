// =============================================================================
// Project      : GameBoy Emulator
// File         : cartridge.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : boot rom overlay (256b) plus flat 32kb rom-only cartridge,
//                  loaded via readmemh from BOOT_ROM_FILE/CART_ROM_FILE
//                  params. boot_active latch starts high on reset, cleared
//                  permanently by a nonzero write to 0xFF50, gating whether
//                  the bottom 256 bytes answer from boot rom or cart rom.
//                  registered reads, same bram-inference template as
//                  wram.v/hram.v
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module cartridge #(
    parameter BOOT_ROM_FILE = "roms/boot/dmg_boot.hex",
    parameter CART_ROM_FILE = "roms/game/cart_rom.hex"
) (
    input  wire        clk,
    input  wire        ce,
    input  wire        rst,
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,        // shared bus write data, only used by the 0xFF50 write
    input  wire        we,
    input  wire        sel_cart_rom,   // asserted for 0x0000-0x7FFF reads
    input  wire        sel_boot_disable, // asserted for 0xFF50 access
    output reg  [7:0]  data_out,
    output wire        stall           // rom never blocks the cpu
);

    assign stall = 1'b0;

    reg [7:0] boot_rom [0:255];
    reg [7:0] cart_rom [0:32767];

    initial begin
        $readmemh(BOOT_ROM_FILE, boot_rom);
        $readmemh(CART_ROM_FILE, cart_rom);
        data_out = 8'h00;
    end

    // boot_active starts high on reset, cleared permanently by a nonzero
    // write to 0xFF50 - real hardware behavior, one-way, no going back
    // until the next system reset
    reg boot_active;

    always @(posedge clk or posedge rst) begin
        if (rst)
            boot_active <= 1'b1;
        else if (ce && sel_boot_disable && we && (data_in != 8'h00))
            boot_active <= 1'b0;
    end

    // read path, registered same as wram/hram - boot overlay only covers
    // the bottom 256 bytes, everything else always comes from cart_rom
    // regardless of boot_active
    always @(posedge clk) begin
        if (ce && sel_cart_rom) begin
            if (boot_active && addr[15:8] == 8'h00)
                data_out <= boot_rom[addr[7:0]];
            else
                data_out <= cart_rom[addr[14:0]];
        end
        else if (ce && sel_boot_disable) begin
            data_out <= 8'hFF;
        end
    end

endmodule
