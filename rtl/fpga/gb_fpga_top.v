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
//                      and gets replaced by the joypad board later
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
//                  reset is held for 256 clocks at power up and for as long as
//                  btnC is down. every input goes through a 2 flop
//                  synchronizer before it reaches the machine.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module gb_fpga_top #(
    parameter BOOT_ROM_FILE = "boot_rom.hex",
    parameter CART_ROM_FILE = "cart_rom.hex"
) (
    input  wire        clk,
    input  wire        btnC,
    input  wire        btnU,
    input  wire        btnD,
    input  wire        btnL,
    input  wire        btnR,
    input  wire [3:0]  sw,

    output wire [3:0]  vgaRed,
    output wire [3:0]  vgaGreen,
    output wire [3:0]  vgaBlue,
    output wire        Hsync,
    output wire        Vsync,
    output wire [15:0] led
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
    reg [7:0] in_s1 = 8'd0;
    reg [7:0] in_s2 = 8'd0;

    always @(posedge clk) begin
        in_s1 <= {sw[3], sw[2], sw[1], sw[0], btnD, btnU, btnL, btnR};
        in_s2 <= in_s1;
    end

    // ------------------------------------------------------------------------
    // the machine
    // ------------------------------------------------------------------------
    wire [15:0] cpu_addr;

    gb_top #(
        .BOOT_ROM_FILE (BOOT_ROM_FILE),
        .CART_ROM_FILE (CART_ROM_FILE)
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

        .lcd_on             (),
        .debug_cpu_addr     (cpu_addr),
        .debug_cpu_data_out (),
        .debug_cpu_we       (),
        .debug_bus_data_in  (),
        .debug_ie           (),
        .debug_if_reg       (),
        .debug_dma_active   ()
    );

    assign led = cpu_addr;

endmodule
