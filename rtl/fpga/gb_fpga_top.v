// =============================================================================
// Project      : GameBoy Emulator
// File         : gb_fpga_top.v
// Author       : Aaron Luebbert
// Date         : 2026-10-22
// Description  : the whole game boy on the basys 3. wraps gb_top with the
//                  board's pins - the 100 mhz clock, a reset, the joypad
//                  inputs, the vga port, and the leds. nothing else lives
//                  here, so everything that runs is the same gb_top the
//                  testbenches run.
//
//                  controls
//                    - btnC resets the whole machine and replays the boot rom
//                    - btnU, btnD, btnL, btnR are the d-pad
//                    - sw0 is a, sw1 is b, sw2 is select, sw3 is start. the
//                      switches hold their level, which is fine for bring up
//                    - a usb keyboard in the usb port plays the game, see
//                      ps2_keys.v - arrows, x is a, z is b, enter is start,
//                      backspace or either shift is select. it is ored with
//                      the buttons and switches, so both work at once
//                    - led15 to led0 show the cpu address bus, so a running
//                      machine flickers and a stuck cpu holds a pattern
//
//                  the rom files are named without a folder on purpose. vivado
//                  finds a hex file for readmemh by name when the file is
//                  added to the project as a design source, and does not
//                  follow a relative folder. add roms/boot/boot_rom.hex and
//                  roms/game/cart_rom.hex to the project, one byte a line.
//                  a simulation that runs from the repo root passes the long
//                  paths in through the parameters instead.
//
//                  SD_MODE picks the cartridge. 0 is the rom in block ram, one
//                  32 kb game baked into the bitstream, and the sd pins sit idle.
//                  1 reads the game from a micro sd card in a pmod sd on header
//                  JA, in spi mode, and supports mbc1, mbc3 and mbc5 carts. the
//                  card holds the rom as a raw image from sector 0, no file
//                  system. in that mode the leds show {sd error, bank 0 loaded,
//                  card ready} on led15 to led13 and the cpu address on the rest.
//
//                  reset is held for 256 clocks at power up and for as long as
//                  btnC is down. every input goes through a 2 flop
//                  synchronizer before it reaches the machine.
// Revision     : 1.2 - added the sd card cartridge
//                  1.1 - added the ps/2 keyboard input
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module gb_fpga_top #(
    parameter BOOT_ROM_FILE = "boot_rom.hex",
    parameter CART_ROM_FILE = "cart_rom.hex",
    parameter integer SD_MODE = 0
) (
    input  wire        clk,
    input  wire        btnC,
    input  wire        btnU,
    input  wire        btnD,
    input  wire        btnL,
    input  wire        btnR,
    input  wire [3:0]  sw,
    input  wire        PS2Clk,
    input  wire        PS2Data,

    // pmod sd on JA, top row - 1 cs, 2 mosi, 3 miso, 4 sck
    output wire        sd_cs_n,
    output wire        sd_sck,
    output wire        sd_mosi,
    input  wire        sd_miso,

    output wire [3:0]  vgaRed,
    output wire [3:0]  vgaGreen,
    output wire [3:0]  vgaBlue,
    output wire        Hsync,
    output wire        Vsync,
    output wire [15:0] led,

    output wire        audio_pin
);

    // ------------------------------------------------------------------------
    // reset - power up hold plus the center button
    // ------------------------------------------------------------------------
    reg [7:0] por_cnt  = 8'd0;
    reg [1:0] rst_sync = 2'b00;

    always @(posedge clk) begin
        rst_sync <= {rst_sync[0], btnC};
        if (por_cnt != 8'hFF) por_cnt <= por_cnt + 8'd1;
    end

    wire rst = (por_cnt != 8'hFF) | rst_sync[1];

    // ------------------------------------------------------------------------
    // inputs - d-pad, a, b, select, start
    // ------------------------------------------------------------------------
    wire [7:0] kb_keys;

    ps2_keys u_kb (
        .clk      (clk),
        .rst      (rst),
        .ps2_clk  (PS2Clk),
        .ps2_data (PS2Data),
        .keys     (kb_keys)
    );

    reg [7:0] in_s1 = 8'd0;
    reg [7:0] in_s2 = 8'd0;

    always @(posedge clk) begin
        in_s1 <= {sw[3], sw[2], sw[1], sw[0], btnD, btnU, btnL, btnR} | kb_keys;
        in_s2 <= in_s1;
    end

    // ------------------------------------------------------------------------
    // the machine
    // ------------------------------------------------------------------------
    wire [15:0] cpu_addr;
    wire [2:0]  cart_status;

    gb_top #(
        .BOOT_ROM_FILE (BOOT_ROM_FILE),
        .CART_ROM_FILE (CART_ROM_FILE),
        .SD_MODE       (SD_MODE),
        .RAM_BYTES     (SD_MODE != 0 ? 32768 : 8192)
    ) u_gb (
        .clk_100m   (clk),
        .rst        (rst),

        .btn_right  (in_s2[0]),
        .btn_left   (in_s2[1]),
        .btn_up     (in_s2[2]),
        .btn_down   (in_s2[3]),
        .btn_a      (in_s2[4]),
        .btn_b      (in_s2[5]),
        .btn_select (in_s2[6]),
        .btn_start  (in_s2[7]),

        .vga_r      (vgaRed),
        .vga_g      (vgaGreen),
        .vga_b      (vgaBlue),
        .vga_hsync  (Hsync),
        .vga_vsync  (Vsync),

        .audio_pin   (audio_pin),

        .sd_cs_n     (sd_cs_n),
        .sd_sck      (sd_sck),
        .sd_mosi     (sd_mosi),
        .sd_miso     (sd_miso),
        .cart_status (cart_status),

        .lcd_on             (),
        .debug_cpu_addr     (cpu_addr),
        .debug_cpu_data_out (),
        .debug_cpu_we       (),
        .debug_bus_data_in  (),
        .debug_ie           (),
        .debug_if_reg       (),
        .debug_dma_active   ()
    );

    assign led = (SD_MODE != 0) ? {cart_status, cpu_addr[12:0]} : cpu_addr;

endmodule
