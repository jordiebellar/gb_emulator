`timescale 1ns / 1ps

module tb_vram;

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
    reg  [1:0] mode;
    reg  [12:0] render_addr;
    wire [7:0]  render_data;

    localparam MODE_HBLANK         = 2'd0;
    localparam MODE_VBLANK         = 2'd1;
    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;

    vram dut (
        .clk         (clk),
        .ce_gb       (ce_gb),
        .ce_m        (ce_m),
        .rst         (rst),
        .addr        (addr),
        .data_in     (data_in),
        .we          (we),
        .sel         (sel),
        .data_out    (data_out),
        .stall       (stall),
        .mode        (mode),
        .render_addr (render_addr),
        .render_data (render_data)
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

    task check_read(input [15:0] a, input [7:0] expected, input [8*40:1] label);
        begin
            @(negedge clk);
            addr = a; we = 1'b0; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            checks = checks + 1;
            if (data_out !== expected) begin
                errors = errors + 1;
                $display("FAIL %0s: addr=%h expected=%h got=%h", label, a, expected, data_out);
            end
        end
    endtask

    task check_render(input [12:0] a, input [7:0] expected, input [8*40:1] label);
        begin
            render_addr = a;
            #1;
            checks = checks + 1;
            if (render_data !== expected) begin
                errors = errors + 1;
                $display("FAIL %0s: render_addr=%h expected=%h got=%h", label, a, expected, render_data);
            end
        end
    endtask

    initial begin
        rst = 1'b0; sel = 1'b0; ce_gb = 1'b0; ce_m = 1'b1;
        we = 1'b0; addr = 16'h0000; data_in = 8'h00;
        mode = MODE_HBLANK; render_addr = 13'h0000;

        repeat (2) @(posedge clk);

        check_read(16'h8000, 8'h00, "power-on, 0x8000 reads zero");

        write_byte(16'h8000, 8'h11);
        check_read(16'h8000, 8'h11, "readback at first vram address 0x8000");

        write_byte(16'h9FFF, 8'h22);
        check_read(16'h9FFF, 8'h22, "readback at last vram address 0x9FFF");

        write_byte(16'h8500, 8'h33);
        check_read(16'h8500, 8'h33, "readback at a middle address");

        mode = MODE_PIXEL_TRANSFER;
        check_read(16'h8000, 8'hFF, "blocked read returns $FF during mode 3");

        write_byte(16'h8000, 8'hEE);
        mode = MODE_HBLANK;
        check_read(16'h8000, 8'h11, "blocked write was genuinely dropped, original value intact");

        mode = MODE_OAM_SCAN;
        check_read(16'h8500, 8'h33, "oam scan does not block vram");
        mode = MODE_VBLANK;
        check_read(16'h8500, 8'h33, "vblank does not block vram");
        mode = MODE_HBLANK;

        write_byte(16'h8600, 8'h44);
        @(negedge clk);
        addr = 16'h8600; data_in = 8'h55; we = 1'b1; sel = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_read(16'h8600, 8'h44, "write ignored while sel low");

        @(negedge clk);
        addr = 16'h8600; data_in = 8'h66; we = 1'b1; sel = 1'b1; ce_m = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce_m = 1'b1;
        check_read(16'h8600, 8'h44, "write ignored while ce_m low");

        @(negedge clk);
        addr = 16'h8600; sel = 1'b0; we = 1'b0;
        #1;
        checks = checks + 1;
        if (data_out === 8'h00)
            $display("PASS data_out reads 0 when sel is low");
        else begin
            errors = errors + 1;
            $display("FAIL data_out should read 0 when sel is low, got=%h", data_out);
        end

        check_render(13'h0000, 8'h11, "render port reads addr 0x0000 (0x8000)");
        check_render(13'h1FFF, 8'h22, "render port reads addr 0x1FFF (0x9FFF)");

        mode = MODE_PIXEL_TRANSFER;
        check_render(13'h0500, 8'h33, "render port still works during mode 3, cpu is blocked but renderer is not");
        mode = MODE_HBLANK;

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule