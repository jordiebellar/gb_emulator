// =============================================================================
// Project      : GameBoy Emulator
// File         : palette.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : turns one of the four dmg shades into a 12 bit color for the
//                  basys 3 vga port, 4 bits each of red, green, and blue,
//                  packed {r, g, b}. shade 0 is the lightest and shade 3 the
//                  darkest, the same order the dmg palette registers use.
//                  parameter GREEN picks the look. 1 is the classic dmg
//                  greens, 0 is plain gray. purely combinational.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module palette #(
    parameter GREEN = 1
) (
    input  wire [1:0]  shade,
    output reg  [11:0] rgb
);

    always @(*) begin
        if (GREEN) begin
            case (shade)
                2'd0:    rgb = 12'h9B0;   // lightest green
                2'd1:    rgb = 12'h8A0;
                2'd2:    rgb = 12'h363;
                default: rgb = 12'h030;   // darkest green
            endcase
        end
        else begin
            case (shade)
                2'd0:    rgb = 12'hFFF;   // white
                2'd1:    rgb = 12'hAAA;
                2'd2:    rgb = 12'h555;
                default: rgb = 12'h000;   // black
            endcase
        end
    end

endmodule