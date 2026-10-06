// =============================================================================
// Project      : GameBoy Emulator
// File         : framebuffer.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : the 160 x 144 screen, 2 bits per pixel, 23040 pixels. the
//                  ppu writes it one pixel at a time and the vga side reads
//                  it at its own pace, so it has two independent ports on
//                  the one clock. no clock crossing is needed, both sides
//                  run off the same 100mhz clock with their own enables.
//
//                  write port: when we is high on a clock edge, wshade is
//                  stored at (wx, wy). a write outside 160 x 144 is ignored,
//                  so a stray coordinate can never land on some other pixel.
//
//                  read port: rshade is the pixel at (rx, ry) as of one
//                  clock after the address, a registered read, which is the
//                  shape block ram wants. a read outside 160 x 144 returns
//                  shade 0.
//
//                  address is y * 160 + x, built as y * 128 + y * 32 + x
//                  to avoid a multiplier.
//
//                  a write and a read of the same pixel on the same edge
//                  return the old value. with a single buffer the vga side
//                  can show part of one frame and part of the next, a tear
//                  line. a second buffer would fix that and is not here yet.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module framebuffer (
    input  wire        clk,

    input  wire        we,
    input  wire [7:0]  wx,
    input  wire [7:0]  wy,
    input  wire [1:0]  wshade,

    input  wire [7:0]  rx,
    input  wire [7:0]  ry,
    output wire [1:0]  rshade
);

    wire        w_ok   = (wx < 8'd160) && (wy < 8'd144);
    wire [14:0] w_addr = ({7'b0, wy} << 7) + ({7'b0, wy} << 5) + {7'b0, wx};

    wire        r_ok   = (rx < 8'd160) && (ry < 8'd144);
    wire [14:0] r_addr = ({7'b0, ry} << 7) + ({7'b0, ry} << 5) + {7'b0, rx};

    reg [1:0] mem [0:23039];
    reg [1:0] rdata;

    integer i;
    initial begin
        for (i = 0; i < 23040; i = i + 1)
            mem[i] = 2'b00;
        rdata = 2'b00;
    end

    always @(posedge clk) begin
        if (we && w_ok)
            mem[w_addr] <= wshade;
    end

    always @(posedge clk) begin
        rdata <= r_ok ? mem[r_addr] : 2'b00;
    end

    assign rshade = rdata;

endmodule