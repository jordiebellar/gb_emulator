// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_cartridge.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : boundary-value analysis of the cartridge module, driven by
//                  bus_master so reads are sampled on the ce_m edge the way
//                  the cpu samples them. the overlay window's two address
//                  edges, the same addresses re-checked after the overlay
//                  is disabled (state boundary), the far edge of the whole
//                  32kb rom (unaffected by boot state either way), the
//                  disable register's own value boundary (0x00 has no
//                  effect, 0x01 does), the one-way latch, sel gating, a
//                  partial write to the disable register that must not
//                  commit, reset re-arming the overlay, and data_out
//                  reading 0 when neither sel line is asserted.
//                  reads of four different addresses back to back also
//                  serve as the stale read regression.
// Revision     : 3.0 - driven by bus_master with the real ce_m. added the
//                  partial write check. reads sampled on the ce_m edge.
//                  2.0 - ce split into ce_gb/ce_m
// =============================================================================
`timescale 1ns / 1ps

module tb_cartridge;

    reg clk;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    reg [1:0] m_cnt;
    initial m_cnt = 2'd0;
    always @(posedge clk) m_cnt <= m_cnt + 2'd1;
    wire ce_m = (m_cnt == 2'd3);

    reg  rst;
    reg  sel_en;
    wire [15:0] addr;
    wire [7:0]  wdata;
    wire        we, bm_sel;
    wire [7:0]  data_out;
    wire        stall;

    // a stand-in for the decoder, the two ranges this module serves
    wire sel_cart_rom     = bm_sel && sel_en && (addr < 16'h8000);
    wire sel_boot_disable = bm_sel && sel_en && (addr == 16'hFF50);

    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(wdata),
                   .we(we), .sel(bm_sel), .rdata(data_out));

    cartridge #(
        .BOOT_ROM_FILE("boot_boundary.hex"),
        .CART_ROM_FILE("cart_boundary.hex")
    ) dut (
        .clk(clk), .ce_gb(1'b0), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(wdata), .we(we),
        .sel_cart_rom(sel_cart_rom), .sel_boot_disable(sel_boot_disable),
        .data_out(data_out), .stall(stall)
    );

    integer errors = 0;
    integer checks = 0;

    task check_cart(input [15:0] a, input [7:0] expected, input [8*40:1] label);
        begin
            bm.read(a);
            checks = checks + 1;
            if (bm.rd === expected && stall === 1'b0)
                $display("PASS  0x%04h  %-34s  data=0x%02h", a, label, bm.rd);
            else begin
                errors = errors + 1;
                $display("FAIL  0x%04h  %-34s  expected=0x%02h got=0x%02h stall=%b",
                          a, label, expected, bm.rd, stall);
            end
        end
    endtask

    initial begin
        sel_en = 1'b1;
        rst = 1'b1;
        repeat (3) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        $display("=== cartridge boundary-value sweep ===");
        $display("-- address boundary: overlay window edges, boot active --");
        check_cart(16'h0000, 8'hB0, "overlay start, boot active");
        check_cart(16'h00FF, 8'hB1, "overlay end, boot active");

        $display("-- address boundary: unaffected by overlay, boot active --");
        check_cart(16'h0100, 8'hC1, "past overlay, boot active");
        check_cart(16'h7FFF, 8'hC3, "cart rom far end, boot active");

        $display("-- a partial write to the disable register must not commit --");
        bm.write_short(16'hFF50, 8'h01);
        check_cart(16'h0000, 8'hB0, "overlay still active after a partial write");

        $display("-- value boundary: 0x00 does not disable the overlay --");
        bm.write(16'hFF50, 8'h00);
        check_cart(16'h0000, 8'hB0, "overlay start, write 0x00");
        check_cart(16'h00FF, 8'hB1, "overlay end, write 0x00");

        $display("-- value boundary: 0x01 (min nonzero) disables it --");
        bm.write(16'hFF50, 8'h01);
        check_cart(16'h0000, 8'hC0, "overlay start, write 0x01");
        check_cart(16'h00FF, 8'hC2, "overlay end, write 0x01");
        check_cart(16'h0100, 8'hC1, "past overlay, unaffected");
        check_cart(16'h7FFF, 8'hC3, "far end, unaffected");

        $display("-- state boundary: one-way latch, cannot be re-armed by writing --");
        bm.write(16'hFF50, 8'h01);
        check_cart(16'h0000, 8'hC0, "overlay start, write 0x01 again");
        bm.write(16'hFF50, 8'h00);
        check_cart(16'h0000, 8'hC0, "writing 0x00 afterwards does not re-arm it");

        $display("-- sel gating --");
        sel_en = 1'b0;
        bm.read(16'h0000);
        checks = checks + 1;
        if (bm.rd === 8'h00)
            $display("PASS  --------  %-34s  data=0x%02h", "sel low, output is 0", bm.rd);
        else begin
            errors = errors + 1;
            $display("FAIL  --------  %-34s  expected=0x00 got=0x%02h", "sel low, output is 0", bm.rd);
        end
        sel_en = 1'b1;

        $display("-- reset boundary: overlay re-arms after being disabled --");
        @(negedge clk);
        rst = 1'b1;
        @(posedge clk);
        @(negedge clk);
        rst = 1'b0;
        check_cart(16'h0000, 8'hB0, "overlay start, after reset");
        check_cart(16'h7FFF, 8'hC3, "far end, after reset");

        $display("");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED - address, value, and state boundaries all verified", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule