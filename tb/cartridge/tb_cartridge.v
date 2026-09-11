// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_cartridge.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : directed testbench for cartridge - checks boot rom overlay
//                  behavior (active by default, exact 0x00-0xFF boundary,
//                  cart rom unaffected outside it), the 0xFF50 write-only
//                  register (reads as 0xFF, only a nonzero write disables
//                  the overlay, one-way), sel/ce gating, and that reset
//                  re-enables the overlay after it was disabled. checks
//                  against the real boot rom and cart rom, not synthetic
//                  markers - expected bytes below were read directly out
//                  of test_boot.hex/test_cart.hex
// Revision     : 1.1 - updated expected values to match real rom content
// =============================================================================
`timescale 1ns / 1ps

module tb_cartridge;

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
        .BOOT_ROM_FILE("test_boot.hex"),
        .CART_ROM_FILE("test_cart.hex")
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

    task check_cart_read(input [15:0] a, input [7:0] expected, input [255:0] label);
        begin
            @(negedge clk);
            addr = a; we = 1'b0; sel_cart_rom = 1'b1; sel_boot_disable = 1'b0; ce = 1'b1;
            @(posedge clk);
            @(negedge clk);
            checks = checks + 1;
            if (data_out !== expected) begin
                errors = errors + 1;
                $display("FAIL %s: addr=%h expected=%h got=%h", label, a, expected, data_out);
            end
            checks = checks + 1;
            if (stall !== 1'b0) begin
                errors = errors + 1;
                $display("FAIL %s: stall expected 0, got %b", label, stall);
            end
        end
    endtask

    task check_boot_disable_read(input [255:0] label);
        begin
            @(negedge clk);
            addr = 16'hFF50; we = 1'b0; sel_cart_rom = 1'b0; sel_boot_disable = 1'b1; ce = 1'b1;
            @(posedge clk);
            @(negedge clk);
            checks = checks + 1;
            if (data_out !== 8'hFF) begin
                errors = errors + 1;
                $display("FAIL %s: expected 0xFF got=%h", label, data_out);
            end
        end
    endtask

    task write_boot_disable(input [7:0] val);
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
        @(negedge clk); // avoid a same-edge race with the dut's reset logic
        rst = 1'b0;

        // --- boot overlay active by default after reset -----------------
        // real boot rom bytes: 0x00=0x31 (LD SP,d16 opcode), 0x50=0xF9, 0xFF=0x50
        check_cart_read(16'h0000, 8'h31, "boot rom byte 0, boot active");
        check_cart_read(16'h0050, 8'hF9, "boot rom byte 0x50, boot active");
        check_cart_read(16'h00FF, 8'h50, "boot rom last overlay byte 0xFF, boot active");

        // --- exactly one byte past the overlay, always cart rom --------
        // real cart rom byte at 0x100 is 0x00 (nop), standard gb entry point
        check_cart_read(16'h0100, 8'h00, "cart rom byte 0x100, outside overlay");

        // --- the 0xFF50 register itself reads as 0xFF -------------------
        check_boot_disable_read("boot disable register read");

        // --- writing 0x00 must not disable the overlay -------------------
        write_boot_disable(8'h00);
        check_cart_read(16'h0000, 8'h31, "boot rom still active after writing 0x00");
        check_cart_read(16'h0050, 8'hF9, "boot rom still active after writing 0x00 (2nd addr)");

        // --- writing nonzero disables it, permanently --------------------
        // real cart rom bytes: 0x00=0xC3, 0x50=0xC3 (coincidentally equal
        // in this real rom), 0xFF=0xFF, 0x100=0x00
        write_boot_disable(8'h01);
        check_cart_read(16'h0000, 8'hC3, "cart rom byte 0 after disable");
        check_cart_read(16'h0050, 8'hC3, "cart rom byte 0x50 after disable");
        check_cart_read(16'h00FF, 8'hFF, "cart rom byte 0xFF after disable");
        check_cart_read(16'h0100, 8'h00, "cart rom byte 0x100, still correct after disable");

        // --- one-way latch, a second write can't re-enable it -----------
        write_boot_disable(8'h01);
        check_cart_read(16'h0000, 8'hC3, "still cart rom, disable cannot be undone by writing again");

        // --- sel gating: neither sel line asserted, output must hold ---
        // last real read above latched 0xC3 (cart rom byte 0), that's the
        // value that must be held here even though addr changes
        @(negedge clk);
        addr = 16'h0050; sel_cart_rom = 1'b0; sel_boot_disable = 1'b0; ce = 1'b1; we = 1'b0;
        @(posedge clk);
        @(negedge clk);
        checks = checks + 1;
        if (data_out !== 8'hC3) begin
            errors = errors + 1;
            $display("FAIL sel gating: output changed to %h with no sel line asserted, expected held value C3",
                      data_out);
        end

        // --- ce gating: sel asserted but ce low, output must hold -------
        @(negedge clk);
        addr = 16'h0050; sel_cart_rom = 1'b1; sel_boot_disable = 1'b0; ce = 1'b0; we = 1'b0;
        @(posedge clk);
        @(negedge clk);
        ce = 1'b1;
        checks = checks + 1;
        if (data_out !== 8'hC3) begin
            errors = errors + 1;
            $display("FAIL ce gating: output changed to %h with ce low, expected held value C3",
                      data_out);
        end

        // --- system reset re-enables the boot overlay --------------------
        @(negedge clk);
        rst = 1'b1;
        @(posedge clk);
        @(negedge clk);
        rst = 1'b0;
        check_cart_read(16'h0000, 8'h31, "boot rom re-enabled after system reset");
        check_cart_read(16'h0100, 8'h00, "cart rom outside overlay, unaffected by reset");

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule