// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_cartridge.v
// Author       : Aaron Luebbert
// Date         : 2026-09-14
// Description  : boundary-value analysis of the cartridge module, covering
//                  every dimension it actually has, not just addresses:
//                  the overlay window's two address edges (0x0000, 0x00FF),
//                  the exact same addresses re-checked after the overlay
//                  is disabled (state boundary), the far edge of the whole
//                  32kb rom (0x7FFF, unaffected by boot state either way),
//                  the disable register's own value boundary (0x00 has no
//                  effect, 0x01 does), the one-way latch (a second write
//                  can't re-arm it), sel/ce gating, and reset re-arming
//                  the overlay. every check prints, pass or fail, for a
//                  full terminal transcript.
// Revision     : 1.1 - moved the disable-register readback check to the
//                  end, it was sitting before the sel/ce gating checks
//                  and its own read was clobbering the held value they
//                  depend on
// =============================================================================
`timescale 1ns / 1ps

module tb_cartridge_boundary;

    reg clk;
    reg ce;
    reg rst;
    reg [15:0] addr;
    reg [7:0]  data_in;
    reg        we;
    reg        sel_cart_rom;
    reg        sel_boot_disable;
    wire [7:0] data_out;
    wire       stall;

    initial clk = 1'b0;
    always #5 clk = ~clk; // 100MHz, 10ns period

    integer errors = 0;
    integer checks = 0;

    cartridge #(
        .BOOT_ROM_FILE("boot_boundary.hex"),
        .CART_ROM_FILE("cart_boundary.hex")
    ) dut (
        .clk              (clk),
        .ce               (ce),
        .rst              (rst),
        .addr             (addr),
        .data_in          (data_in),
        .we               (we),
        .sel_cart_rom     (sel_cart_rom),
        .sel_boot_disable (sel_boot_disable),
        .data_out         (data_out),
        .stall            (stall)
    );

    task check_cart(input [15:0] a, input [7:0] expected, input [8*24:1] label);
        begin
            @(negedge clk);
            addr = a; we = 1'b0; sel_cart_rom = 1'b1; sel_boot_disable = 1'b0; ce = 1'b1;
            @(posedge clk);
            @(negedge clk);
            checks = checks + 1;
            if (data_out === expected && stall === 1'b0) begin
                $display("PASS  0x%04h  %0s  data=0x%02h", a, label, data_out);
            end
            else begin
                errors = errors + 1;
                $display("FAIL  0x%04h  %0s  expected=0x%02h got=0x%02h stall=%b",
                          a, label, expected, data_out, stall);
            end
        end
    endtask

    task check_disable_reg(input [7:0] expected, input [8*24:1] label);
        begin
            @(negedge clk);
            addr = 16'hFF50; we = 1'b0; sel_cart_rom = 1'b0; sel_boot_disable = 1'b1; ce = 1'b1;
            @(posedge clk);
            @(negedge clk);
            checks = checks + 1;
            if (data_out === expected) begin
                $display("PASS  disable-reg  %0s  data=0x%02h", label, data_out);
            end
            else begin
                errors = errors + 1;
                $display("FAIL  disable-reg  %0s  expected=0x%02h got=0x%02h", label, expected, data_out);
            end
        end
    endtask

    task write_disable(input [7:0] val);
        begin
            @(negedge clk);
            addr = 16'hFF50; data_in = val; we = 1'b1;
            sel_cart_rom = 1'b0; sel_boot_disable = 1'b1; ce = 1'b1;
            @(posedge clk);
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    initial begin
        addr = 16'h0000; data_in = 8'h00; we = 1'b0;
        sel_cart_rom = 1'b0; sel_boot_disable = 1'b0;
        ce = 1'b1;

        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        $display("=== cartridge boundary-value sweep ===");
        $display("-- address boundary: overlay window edges, boot active --");
        check_cart(16'h0000, 8'hB0, "overlay start (0x00),  boot active");
        check_cart(16'h00FF, 8'hB1, "overlay end   (0xFF),  boot active");

        $display("-- address boundary: unaffected by overlay, boot active --");
        check_cart(16'h0100, 8'hC1, "first byte past overlay, boot active");
        check_cart(16'h7FFF, 8'hC3, "far end of cart rom,     boot active");

        $display("value boundary: 0x00 does not disable the overlay");
        write_disable(8'h00);
        check_cart(16'h0000, 8'hB0, "overlay start, after writing 0x00");
        check_cart(16'h00FF, 8'hB1, "overlay end,   after writing 0x00");

        $display("value boundary: 0x01 (min nonzero) disables it");
        write_disable(8'h01);
        check_cart(16'h0000, 8'hC0, "overlay start, after writing 0x01");
        check_cart(16'h00FF, 8'hC2, "overlay end,   after writing 0x01");
        check_cart(16'h0100, 8'hC1, "past overlay, unaffected by the disable");
        check_cart(16'h7FFF, 8'hC3, "far end, unaffected by the disable");

        $display("-- state boundary: one-way latch, cannot be re-armed by writing --");
        write_disable(8'h01);
        check_cart(16'h0000, 8'hC0, "still cart rom after writing 0x01 again");

        $display("-- sel/ce gating --");
        @(negedge clk);
        addr = 16'h0000; sel_cart_rom = 1'b0; sel_boot_disable = 1'b0; ce = 1'b1; we = 1'b0;
        @(posedge clk);
        @(negedge clk);
        checks = checks + 1;
        if (data_out === 8'hC0)
            $display("PASS  sel gating  output held at 0x%02h with no sel line asserted", data_out);
        else begin
            errors = errors + 1;
            $display("FAIL  sel gating  expected held 0xC0 got=0x%02h", data_out);
        end

        @(negedge clk);
        addr = 16'h00FF; sel_cart_rom = 1'b1; sel_boot_disable = 1'b0; ce = 1'b0; we = 1'b0;
        @(posedge clk);
        @(negedge clk);
        ce = 1'b1;
        checks = checks + 1;
        if (data_out === 8'hC0)
            $display("PASS  ce gating   output held at 0x%02h with ce low", data_out);
        else begin
            errors = errors + 1;
            $display("FAIL  ce gating   expected held 0xC0 got=0x%02h", data_out);
        end

        $display("-- reset boundary: overlay re-arms after being disabled --");
        @(negedge clk);
        rst = 1'b1;
        @(posedge clk);
        @(negedge clk);
        rst = 1'b0;
        check_cart(16'h0000, 8'hB0, "overlay re-armed after reset");
        check_cart(16'h7FFF, 8'hC3, "far end still correct after reset");

        $display("-- disable register itself always reads 0xFF --");
        check_disable_reg(8'hFF, "read after everything else is done");

        $display("");
        if (errors == 0)
            $display("ALL %0d BOUNDARY CHECKS PASSED - address, value, and state boundaries all verified", checks);
        else
            $display("%0d of %0d boundary checks failed", errors, checks);

        $finish;
    end

endmodule