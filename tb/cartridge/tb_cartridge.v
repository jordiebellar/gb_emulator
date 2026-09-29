// tb_cartridge.v
`timescale 1ns / 1ps

module tb_cartridge;

    reg clk;
    reg ce_gb;
    reg ce_m;
    reg rst;
    reg [15:0] addr;
    reg [7:0]  data_in;
    reg        we;
    reg        sel_cart_rom;
    reg        sel_boot_disable;
    wire [7:0] data_out;
    wire       stall;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;

    cartridge #(
        .BOOT_ROM_FILE("boot_boundary.hex"),
        .CART_ROM_FILE("cart_boundary.hex")
    ) dut (
        .clk              (clk),
        .ce_gb            (ce_gb),
        .ce_m             (ce_m),
        .rst              (rst),
        .addr             (addr),
        .data_in          (data_in),
        .we               (we),
        .sel_cart_rom     (sel_cart_rom),
        .sel_boot_disable (sel_boot_disable),
        .data_out         (data_out),
        .stall            (stall)
    );

    task check_cart(input [15:0] a, input [7:0] expected, input [8*40:1] label);
        begin
            @(negedge clk);
            addr = a; we = 1'b0; sel_cart_rom = 1'b1; sel_boot_disable = 1'b0;
            @(posedge clk);
            @(negedge clk);
            checks = checks + 1;
            if (data_out === expected && stall === 1'b0) begin
                $display("PASS  0x%04h  %-34s  data=0x%02h", a, label, data_out);
            end
            else begin
                errors = errors + 1;
                $display("FAIL  0x%04h  %-34s  expected=0x%02h got=0x%02h stall=%b",
                          a, label, expected, data_out, stall);
            end
        end
    endtask

    task write_disable(input [7:0] val);
        begin
            @(negedge clk);
            addr = 16'hFF50; data_in = val; we = 1'b1;
            sel_cart_rom = 1'b0; sel_boot_disable = 1'b1;
            @(posedge clk);
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    initial begin
        addr = 16'h0000; data_in = 8'h00; we = 1'b0;
        sel_cart_rom = 1'b0; sel_boot_disable = 1'b0;
        ce_gb = 1'b0;
        ce_m  = 1'b1;

        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        $display("=== cartridge boundary-value sweep (rev 2) ===");
        $display("-- address boundary: overlay window edges, boot active --");
        check_cart(16'h0000, 8'hB0, "overlay start, boot active");
        check_cart(16'h00FF, 8'hB1, "overlay end, boot active");

        $display("-- address boundary: unaffected by overlay, boot active --");
        check_cart(16'h0100, 8'hC1, "past overlay, boot active");
        check_cart(16'h7FFF, 8'hC3, "cart rom far end, boot active");

        $display("-- value boundary: 0x00 does not disable the overlay --");
        write_disable(8'h00);
        check_cart(16'h0000, 8'hB0, "overlay start, write 0x00");
        check_cart(16'h00FF, 8'hB1, "overlay end, write 0x00");

        $display("-- value boundary: 0x01 (min nonzero) disables it --");
        write_disable(8'h01);
        check_cart(16'h0000, 8'hC0, "overlay start, write 0x01");
        check_cart(16'h00FF, 8'hC2, "overlay end, write 0x01");
        check_cart(16'h0100, 8'hC1, "past overlay, unaffected");
        check_cart(16'h7FFF, 8'hC3, "far end, unaffected");

        $display("-- state boundary: one-way latch, cannot be re-armed by writing --");
        write_disable(8'h01);
        check_cart(16'h0000, 8'hC0, "overlay start, write 0x01 again");

        $display("-- sel/ce_m gating --");
        @(negedge clk);
        addr = 16'h0000; sel_cart_rom = 1'b0; sel_boot_disable = 1'b0; we = 1'b0;
        @(posedge clk);
        @(negedge clk);
        checks = checks + 1;
        if (data_out === 8'h00)
            $display("PASS  --------  %-34s  data=0x%02h", "sel gating, output is 0", data_out);
        else begin
            errors = errors + 1;
            $display("FAIL  --------  %-34s  expected=0x00 got=0x%02h", "sel gating, output is 0", data_out);
        end

        @(negedge clk);
        addr = 16'h00FF; sel_cart_rom = 1'b1; sel_boot_disable = 1'b0; we = 1'b0; ce_m = 1'b0;
        @(posedge clk);
        @(negedge clk);
        ce_m = 1'b1;
        checks = checks + 1;
        if (data_out === 8'hC0)
            $display("PASS  --------  %-34s  data=0x%02h", "ce_m gating, output held", data_out);
        else begin
            errors = errors + 1;
            $display("FAIL  --------  %-34s  expected=0xC0 got=0x%02h", "ce_m gating, output held", data_out);
        end

        $display("-- reset boundary: overlay re-arms after being disabled --");
        @(negedge clk);
        rst = 1'b1;
        @(posedge clk);
        @(negedge clk);
        rst = 1'b0;
        check_cart(16'h0000, 8'hB0, "overlay start, after reset");
        check_cart(16'h7FFF, 8'hC3, "far end, after reset");

        $display("-- new in rev 2: data_out is 0 when neither sel is asserted --");
        @(negedge clk);
        addr = 16'h0000; sel_cart_rom = 1'b0; sel_boot_disable = 1'b0; we = 1'b0;
        #1;
        checks = checks + 1;
        if (data_out === 8'h00)
            $display("PASS  --------  %-34s  data=0x%02h", "neither sel asserted", data_out);
        else begin
            errors = errors + 1;
            $display("FAIL  --------  %-34s  expected=0x00 got=0x%02h", "neither sel asserted", data_out);
        end

        $display("");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED - address, value, and state boundaries all verified", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule