`timescale 1ns / 1ps

module tb_ppu_reg;

    reg clk;
    reg ce_gb;
    reg ce_m;
    reg rst;
    reg [15:0] addr;
    reg [7:0]  data_in;
    reg        we;
    reg        sel;
    wire [7:0] data_out;
    wire       stall;

    reg [1:0] mode;
    reg [7:0] ly_in;
    reg       entering_hblank;
    reg       entering_oam_scan;
    reg       entering_vblank;
    wire      irq_lcdstat;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;

    ppu_reg dut (
        .clk               (clk),
        .ce_gb             (ce_gb),
        .ce_m              (ce_m),
        .rst               (rst),
        .addr              (addr),
        .data_in           (data_in),
        .we                (we),
        .sel               (sel),
        .data_out          (data_out),
        .stall             (stall),
        .mode              (mode),
        .ly_in             (ly_in),
        .entering_hblank   (entering_hblank),
        .entering_oam_scan (entering_oam_scan),
        .entering_vblank   (entering_vblank),
        .irq_lcdstat       (irq_lcdstat)
    );

    task write_reg(input [15:0] a, input [7:0] val);
        begin
            @(negedge clk);
            addr = a; data_in = val; we = 1'b1; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    task check_read(input [15:0] a, input [7:0] expected, input [8*32:1] label);
        begin
            addr = a; sel = 1'b1; we = 1'b0;
            #1;
            checks = checks + 1;
            if (data_out === expected)
                $display("PASS %0s: data=0x%02h", label, data_out);
            else begin
                errors = errors + 1;
                $display("FAIL %0s: expected=0x%02h got=0x%02h", label, expected, data_out);
            end
        end
    endtask

    task check_irq(input expected, input [8*40:1] label);
        begin
            #1;
            checks = checks + 1;
            if (irq_lcdstat === expected)
                $display("PASS %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL %0s: irq_lcdstat expected=%b got=%b", label, expected, irq_lcdstat);
            end
        end
    endtask

    initial begin
        addr = 16'h0000; data_in = 8'h00; we = 1'b0; sel = 1'b0;
        ce_gb = 1'b1; ce_m = 1'b1;
        mode = 2'd2; ly_in = 8'd0;
        entering_hblank = 1'b0; entering_oam_scan = 1'b0; entering_vblank = 1'b0;

        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        write_reg(16'hFF40, 8'h91); check_read(16'hFF40, 8'h91, "lcdc readback");
        write_reg(16'hFF42, 8'h12); check_read(16'hFF42, 8'h12, "scy readback");
        write_reg(16'hFF43, 8'h34); check_read(16'hFF43, 8'h34, "scx readback");
        write_reg(16'hFF45, 8'h56); check_read(16'hFF45, 8'h56, "lyc readback");
        write_reg(16'hFF47, 8'hE4); check_read(16'hFF47, 8'hE4, "bgp readback");
        write_reg(16'hFF48, 8'hD0); check_read(16'hFF48, 8'hD0, "obp0 readback");
        write_reg(16'hFF49, 8'hC0); check_read(16'hFF49, 8'hC0, "obp1 readback");
        write_reg(16'hFF4A, 8'h78); check_read(16'hFF4A, 8'h78, "wy readback");
        write_reg(16'hFF4B, 8'h9A); check_read(16'hFF4B, 8'h9A, "wx readback");

        ly_in = 8'd42;
        check_read(16'hFF44, 8'd42, "ly mirrors ly_in (42)");
        ly_in = 8'd143;
        check_read(16'hFF44, 8'd143, "ly mirrors ly_in (143), no latency");
        write_reg(16'hFF44, 8'hFF);
        check_read(16'hFF44, 8'd143, "ly unaffected by a write attempt");

        mode = 2'd2; ly_in = 8'd10; write_reg(16'hFF45, 8'd99);
        check_read(16'hFF41, 8'b1000_0010, "stat: mode=2, bit7=1, no coincidence, enables clear");

        mode = 2'd0;
        check_read(16'hFF41, 8'b1000_0000, "stat: mode mirror updates to 0 (hblank)");

        write_reg(16'hFF45, 8'd10);
        check_read(16'hFF41, 8'b1000_0100, "stat: coincidence flag sets when ly==lyc");

        write_reg(16'hFF41, 8'b0111_1111);
        check_read(16'hFF41, 8'b1111_1100, "stat: enables took the write, mode/coincidence/bit7 did not");

        entering_hblank = 1'b1;
        check_irq(1'b1, "irq_lcdstat fires on entering_hblank, mode0_ie set");
        entering_hblank = 1'b0;

        write_reg(16'hFF41, 8'b0000_0000);
        entering_hblank = 1'b1;
        check_irq(1'b0, "irq_lcdstat does not fire on entering_hblank, mode0_ie clear");
        entering_hblank = 1'b0;

        write_reg(16'hFF41, 8'b0001_0000);
        entering_vblank = 1'b1;
        check_irq(1'b1, "irq_lcdstat fires on entering_vblank, mode1_ie set");
        entering_vblank = 1'b0;

        write_reg(16'hFF41, 8'b0010_0000);
        entering_oam_scan = 1'b1;
        check_irq(1'b1, "irq_lcdstat fires on entering_oam_scan, mode2_ie set");
        entering_oam_scan = 1'b0;
        check_irq(1'b0, "irq_lcdstat clears once entering_oam_scan drops");

        write_reg(16'hFF41, 8'b0100_0000);
        write_reg(16'hFF45, 8'd50);
        ly_in = 8'd20;
        @(negedge clk); @(posedge clk); @(negedge clk);
        check_irq(1'b0, "no coincidence yet, no irq");

        ly_in = 8'd50;
        check_irq(1'b1, "irq_lcdstat fires on the coincidence rising edge");

        @(posedge clk);
        check_irq(1'b0, "irq_lcdstat does not stay high while coincidence remains true");

        ly_in = 8'd51;
        @(negedge clk); @(posedge clk); @(negedge clk);
        check_irq(1'b0, "no irq on the coincidence falling edge");

        sel = 1'b0;
        #1;
        checks = checks + 1;
        if (data_out === 8'h00)
            $display("PASS data_out reads 0 when sel is low");
        else begin
            errors = errors + 1;
            $display("FAIL data_out should read 0 when sel is low, got=%h", data_out);
        end
        sel = 1'b1;

        write_reg(16'hFF42, 8'hAA);
        @(negedge clk);
        addr = 16'hFF42; data_in = 8'h55; we = 1'b1; sel = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_read(16'hFF42, 8'hAA, "scy write ignored while sel low");

        @(negedge clk);
        addr = 16'hFF42; data_in = 8'h55; we = 1'b1; sel = 1'b1; ce_m = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce_m = 1'b1;
        check_read(16'hFF42, 8'hAA, "scy write ignored while ce_m low");

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule