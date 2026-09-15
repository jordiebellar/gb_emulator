// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_joypad.v
// Author       : Aaron Luebbert
// Date         : 2026-09-14
// Description  : directed testbench for joypad - select-bit write/readback,
//                  direction group, button group, both groups selected at
//                  once (AND behavior), neither selected, sel/ce gating,
//                  and irq_joypad firing exactly on a press edge, not on
//                  release and not while unselected
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_joypad;

    reg clk;
    reg ce;
    reg rst;
    reg [15:0] addr;
    reg [7:0]  data_in;
    reg        we;
    reg        sel;
    wire [7:0] data_out;
    wire       stall;

    reg btn_right, btn_left, btn_up, btn_down;
    reg btn_a, btn_b, btn_select, btn_start;

    wire irq_joypad;

    initial clk = 1'b0;
    always #5 clk = ~clk; // 100MHz, 10ns period

    integer errors = 0;
    integer checks = 0;

    joypad dut (
        .clk        (clk),
        .ce         (ce),
        .rst        (rst),
        .addr       (addr),
        .data_in    (data_in),
        .we         (we),
        .sel        (sel),
        .data_out   (data_out),
        .stall      (stall),
        .btn_right  (btn_right),
        .btn_left   (btn_left),
        .btn_up     (btn_up),
        .btn_down   (btn_down),
        .btn_a      (btn_a),
        .btn_b      (btn_b),
        .btn_select (btn_select),
        .btn_start  (btn_start),
        .irq_joypad (irq_joypad)
    );

    task write_select(input [7:0] val, input [255:0] label);
        begin
            @(negedge clk);
            addr = 16'hFF00; data_in = val; we = 1'b1; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    task check_read(input [7:0] expected, input [255:0] label);
        begin
            @(negedge clk);
            addr = 16'hFF00; we = 1'b0; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            checks = checks + 1;
            if (data_out !== expected) begin
                errors = errors + 1;
                $display("FAIL %s: expected=%h got=%h", label, expected, data_out);
            end
        end
    endtask

    task check_irq(input expected, input [255:0] label);
        begin
            checks = checks + 1;
            if (irq_joypad !== expected) begin
                errors = errors + 1;
                $display("FAIL %s: irq_joypad expected=%b got=%b", label, expected, irq_joypad);
            end
        end
    endtask

    initial begin
        addr = 16'h0000; data_in = 8'h00; we = 1'b0; sel = 1'b0; ce = 1'b1;
        btn_right = 0; btn_left = 0; btn_up = 0; btn_down = 0;
        btn_a = 0; btn_b = 0; btn_select = 0; btn_start = 0;

        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // --- power-on, neither group selected, nibble reads all 1s ------
        check_read(8'hFF, "power-on, neither group selected");

        // --- select directions (bit4=0, bit5=1), echo back --------------
        write_select(8'b0010_0000, "select directions");
        check_read(8'hEF, "directions selected, nothing pressed");

        // --- press right, directions selected ----------------------------
        btn_right = 1;
        check_read(8'hEE, "right pressed, directions selected");
        btn_right = 0;

        // --- press up+down together, directions selected ------------------
        btn_up = 1; btn_down = 1;
        check_read(8'hE3, "up+down pressed, directions selected");
        btn_up = 0; btn_down = 0;

        // --- select buttons instead (bit5=0, bit4=1), echo back -----------
        write_select(8'b0001_0000, "select buttons");
        check_read(8'hDF, "buttons selected, nothing pressed");

        btn_a = 1;
        check_read(8'hDE, "a pressed, buttons selected");
        btn_a = 0;

        // --- both groups selected at once, result is the and of both -----
        btn_right = 1; // direction bit 0
        btn_b = 1;     // button bit 1
        write_select(8'b0000_0000, "select both groups");
        // dir_bits = 1110 (right pressed), btn_bits = 1101 (b pressed)
        // and = 1100 -> nibble = C
        check_read(8'hCC, "both groups selected, result is bitwise and");
        btn_right = 0; btn_b = 0;

        // --- back to neither selected -------------------------------------
        write_select(8'b0011_0000, "select neither");
        check_read(8'hFF, "neither selected, reads all 1s regardless of buttons");

        // --- sel gating: write ignored while sel low ------------------------
        @(negedge clk);
        addr = 16'hFF00; data_in = 8'b0001_0000; we = 1'b1; sel = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_read(8'hFF, "select write ignored while sel low, still neither selected");

        // --- ce gating: write ignored while ce low --------------------------
        @(negedge clk);
        addr = 16'hFF00; data_in = 8'b0001_0000; we = 1'b1; sel = 1'b1; ce = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce = 1'b1;
        check_read(8'hFF, "select write ignored while ce low, still neither selected");

        // --- irq: fires on a press edge while a group is selected -----------
        write_select(8'b0010_0000, "select directions for irq test");
        @(posedge clk); #1; check_irq(1'b0, "no irq before any press");
        btn_right = 1;
        @(posedge clk); #1; check_irq(1'b1, "irq fires exactly on the press edge");
        @(posedge clk); #1; check_irq(1'b0, "irq does not stay high the next cycle");

        // --- irq: does not fire on release -----------------------------------
        btn_right = 0;
        @(posedge clk); #1; check_irq(1'b0, "no irq on release");

        // --- irq: does not fire when neither group is selected ----------------
        write_select(8'b0011_0000, "select neither for irq test");
        @(posedge clk); #1; // let nibble_prev settle to FF with neither selected
        btn_up = 1;
        @(posedge clk); #1; check_irq(1'b0, "no irq for a button in an unselected group");
        btn_up = 0;

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule