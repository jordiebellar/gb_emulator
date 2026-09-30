`timescale 1ns / 1ps

module tb_joypad;

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

    reg btn_right, btn_left, btn_up, btn_down;
    reg btn_a, btn_b, btn_select, btn_start;

    wire irq_joypad;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;

    joypad dut (
        .clk        (clk),
        .ce_gb      (ce_gb),
        .ce_m       (ce_m),
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
            sel = 1'b1;
            #1;
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
        addr = 16'h0000; data_in = 8'h00; we = 1'b0; sel = 1'b0;
        ce_gb = 1'b1;
        ce_m  = 1'b1;
        btn_right = 0; btn_left = 0; btn_up = 0; btn_down = 0;
        btn_a = 0; btn_b = 0; btn_select = 0; btn_start = 0;

        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        check_read(8'hFF, "power-on, neither group selected");

        write_select(8'b0010_0000, "select directions");
        check_read(8'hEF, "directions selected, nothing pressed");

        btn_right = 1;
        check_read(8'hEE, "right pressed, directions selected");
        btn_right = 0;

        btn_up = 1; btn_down = 1;
        check_read(8'hE3, "up+down pressed, directions selected");
        btn_up = 0; btn_down = 0;

        write_select(8'b0001_0000, "select buttons");
        check_read(8'hDF, "buttons selected, nothing pressed");

        btn_a = 1;
        check_read(8'hDE, "a pressed, buttons selected");
        btn_a = 0;

        btn_right = 1;
        btn_b = 1;
        write_select(8'b0000_0000, "select both groups");
        check_read(8'hCC, "both groups selected, result is bitwise and");
        btn_right = 0; btn_b = 0;

        write_select(8'b0011_0000, "select neither");
        check_read(8'hFF, "neither selected, reads all 1s regardless of buttons");

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

        @(negedge clk);
        addr = 16'hFF00; data_in = 8'b0001_0000; we = 1'b1; sel = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_read(8'hFF, "select write ignored while sel low, still neither selected");

        @(negedge clk);
        addr = 16'hFF00; data_in = 8'b0001_0000; we = 1'b1; sel = 1'b1; ce_m = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce_m = 1'b1;
        check_read(8'hFF, "select write ignored while ce_m low, still neither selected");

        write_select(8'b0010_0000, "select directions for irq test");
        @(posedge clk); #1; check_irq(1'b0, "no irq before any press");
        btn_right = 1;
        @(posedge clk); check_irq(1'b1, "irq fires exactly on the press edge");
        @(posedge clk); #1; check_irq(1'b0, "irq does not stay high the next cycle");

        btn_right = 0;
        @(posedge clk); #1; check_irq(1'b0, "no irq on release");

        write_select(8'b0011_0000, "select neither for irq test");
        @(posedge clk); #1;
        btn_up = 1;
        @(posedge clk); #1; check_irq(1'b0, "no irq for a button in an unselected group");
        btn_up = 0;

        write_select(8'b0010_0000, "select directions for ce_gb gating test");
        @(posedge clk); #1;
        ce_gb = 1'b0;
        btn_left = 1;
        #1;
        checks = checks + 1;
        if (irq_joypad === 1'b0)
            $display("PASS irq_joypad does not strobe while ce_gb is low, even on a real press");
        else begin
            errors = errors + 1;
            $display("FAIL irq_joypad should not strobe while ce_gb is low, got=%b", irq_joypad);
        end
        ce_gb = 1'b1;
        btn_left = 0;

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule