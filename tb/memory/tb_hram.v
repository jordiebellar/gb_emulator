// tb_hram.v
`timescale 1ns / 1ps

module tb_hram;

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

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;

    hram dut (
        .clk      (clk),
        .ce_gb    (ce_gb),
        .ce_m     (ce_m),
        .rst      (rst),
        .addr     (addr),
        .data_in  (data_in),
        .we       (we),
        .sel      (sel),
        .data_out (data_out),
        .stall    (stall)
    );

    task write_byte(input [15:0] a, input [7:0] d);
        begin
            @(negedge clk);
            addr = a; data_in = d; we = 1'b1; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    task check_read(input [15:0] a, input [7:0] expected, input [255:0] label);
        begin
            @(negedge clk);
            addr = a; we = 1'b0; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            checks = checks + 1;
            if (data_out !== expected) begin
                errors = errors + 1;
                $display("FAIL %s: addr=%h expected=%h got=%h", label, a, expected, data_out);
            end
        end
    endtask

    initial begin
        rst     = 1'b0;
        sel     = 1'b0;
        ce_gb   = 1'b0;
        ce_m    = 1'b1;
        we      = 1'b0;
        addr    = 16'h0000;
        data_in = 8'h00;

        repeat (2) @(posedge clk);

        check_read(16'hFF80, 8'h00, "power-on, 0xFF80 reads zero");

        write_byte(16'hFF80, 8'h11);
        check_read(16'hFF80, 8'h11, "readback at first hram address 0xFF80");

        write_byte(16'hFFFE, 8'h22);
        check_read(16'hFFFE, 8'h22, "readback at last hram address 0xFFFE");

        write_byte(16'hFFC0, 8'h33);
        check_read(16'hFFC0, 8'h33, "readback at middle address 0xFFC0");

        write_byte(16'hFF90, 8'h44);
        @(negedge clk);
        addr = 16'hFF90; data_in = 8'hEE; we = 1'b1; sel = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_read(16'hFF90, 8'h44, "write ignored while sel low");

        @(negedge clk);
        addr = 16'hFF90; data_in = 8'hDD; we = 1'b1; sel = 1'b1; ce_m = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce_m = 1'b1;
        check_read(16'hFF90, 8'h44, "write ignored while ce_m low");

        write_byte(16'hFFA0, 8'hAA);
        write_byte(16'hFFA1, 8'hBB);
        check_read(16'hFFA0, 8'hAA, "adjacent location 1 unaffected by neighbor write");
        check_read(16'hFFA1, 8'hBB, "adjacent location 2 holds its own value");

        @(negedge clk);
        addr = 16'hFFA0; sel = 1'b0; we = 1'b0;
        #1;
        checks = checks + 1;
        if (data_out === 8'h00)
            $display("PASS data_out reads 0 when sel is low");
        else begin
            errors = errors + 1;
            $display("FAIL data_out should read 0 when sel is low, got=%h", data_out);
        end

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule