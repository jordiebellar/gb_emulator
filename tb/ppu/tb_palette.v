// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_palette.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : checks both looks of the palette module, the dmg greens and
//                  the gray, for all four shades against fixed expected
//                  values, and that each look gets strictly darker as the
//                  shade number goes up, which is the property the rest of
//                  the video path relies on.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_palette;

    reg  [1:0]  shade;
    wire [11:0] rgb_green;
    wire [11:0] rgb_gray;

    palette #(.GREEN(1)) dut_green (.shade(shade), .rgb(rgb_green));
    palette #(.GREEN(0)) dut_gray  (.shade(shade), .rgb(rgb_gray));

    integer errors = 0;
    integer checks = 0;
    integer s;
    integer lum_prev_g, lum_prev_y;
    integer lum_g, lum_y;
    reg [11:0] exp_green [0:3];
    reg [11:0] exp_gray  [0:3];

    task check(input expr, input [8*100:1] label);
        begin
            checks = checks + 1;
            if (expr) $display("PASS  %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s", label);
            end
        end
    endtask

    initial begin
        exp_green[0] = 12'h9B0; exp_green[1] = 12'h8A0; exp_green[2] = 12'h363; exp_green[3] = 12'h030;
        exp_gray[0]  = 12'hFFF; exp_gray[1]  = 12'hAAA; exp_gray[2]  = 12'h555; exp_gray[3]  = 12'h000;

        lum_prev_g = 1000; lum_prev_y = 1000;
        for (s = 0; s < 4; s = s + 1) begin
            shade = s[1:0];
            #1;
            check(rgb_green === exp_green[s], "green look matches the expected color for this shade");
            check(rgb_gray  === exp_gray[s],  "gray look matches the expected color for this shade");
            lum_g = rgb_green[11:8] + rgb_green[7:4] + rgb_green[3:0];
            lum_y = rgb_gray[11:8]  + rgb_gray[7:4]  + rgb_gray[3:0];
            check(lum_g < lum_prev_g, "green look is darker than the previous shade");
            check(lum_y < lum_prev_y, "gray look is darker than the previous shade");
            lum_prev_g = lum_g; lum_prev_y = lum_y;
        end

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - both palette looks verified", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule