`timescale 1ns / 1ps

module tb_wram;

    reg clk;
    reg ce;
    reg rst;
    reg [15:0] addr;
    reg [7:0]  data_in;
    reg        we;
    reg        sel;
    wire [7:0] data_out;
    wire       stall;

    initial clk = 1'b0;
    always #5 clk = ~clk; // 100MHz, 10ns period

    integer errors = 0;
    integer checks = 0;

    wram dut (
        .clk      (clk),
        .ce       (ce),
        .rst      (rst),
        .addr     (addr),
        .data_in  (data_in),
        .we       (we),
        .sel      (sel),
        .data_out (data_out),
        .stall    (stall)
    );

    // writes one byte - asserts addr/data_in/we/sel/ce for one clock edge
    task write_byte(input [15:0] a, input [7:0] d);
        begin
            @(negedge clk);
            addr = a; data_in = d; we = 1'b1; sel = 1'b1; ce = 1'b1;
            @(posedge clk); // write happens on this edge
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    // reads one byte - data_out is registered, valid one cycle after
    // addr/we/sel/ce settle, so this waits a full edge before checking
    task check_read(input [15:0] a, input [7:0] expected, input [255:0] label);
        begin
            @(negedge clk);
            addr = a; we = 1'b0; sel = 1'b1; ce = 1'b1;
            @(posedge clk); // data_out registers here
            @(negedge clk); // now stable to check
            checks = checks + 1;
            if (data_out !== expected) begin
                errors = errors + 1;
                $display("FAIL %s: addr=%h expected=%h got=%h",
                          label, a, expected, data_out);
            end
        end
    endtask

    initial begin
        rst     = 1'b0;
        sel     = 1'b0;
        ce      = 1'b0;
        we      = 1'b0;
        addr    = 16'h0000;
        data_in = 8'h00;

        repeat (2) @(posedge clk);

        // --- power-on contents ------------------------------------------
        check_read(16'hC000, 8'h00, "power-on, 0xC000 reads zero");

        // --- basic write/readback, first/mid/last real wram address ----
        write_byte(16'hC000, 8'h11);
        check_read(16'hC000, 8'h11, "readback at first wram address 0xC000");

        write_byte(16'hC100, 8'h22);
        check_read(16'hC100, 8'h22, "readback at 0xC100");

        write_byte(16'hDFFF, 8'h33);
        check_read(16'hDFFF, 8'h33, "readback at last wram address 0xDFFF");

        // --- echo mirroring, both directions ----------------------------
        write_byte(16'hC010, 8'h44);
        check_read(16'hE010, 8'h44, "echo mirrors real write, 0xE010 == 0xC010");

        write_byte(16'hE100, 8'h55);
        check_read(16'hC100, 8'h55, "real reflects echo write, 0xC100 == 0xE100");

        // --- echo boundary, 0xFDFF should fold to same index as 0xDDFF -
        write_byte(16'hDDFF, 8'h66);
        check_read(16'hFDFF, 8'h66, "echo boundary, 0xFDFF mirrors 0xDDFF");

        // --- sel gating, write ignored while sel low ---------------------
        write_byte(16'hC200, 8'h77);
        @(negedge clk);
        addr = 16'hC200; data_in = 8'hEE; we = 1'b1; sel = 1'b0; ce = 1'b1;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; sel = 1'b1;
        check_read(16'hC200, 8'h77, "write ignored while sel low");

        // --- ce gating, write ignored while ce low ------------------------
        @(negedge clk);
        addr = 16'hC200; data_in = 8'hDD; we = 1'b1; sel = 1'b1; ce = 1'b0;
        @(posedge clk);
        @(negedge clk);
        we = 1'b0; ce = 1'b1;
        check_read(16'hC200, 8'h77, "write ignored while ce low");

        // --- adjacent locations hold independent values -------------------
        write_byte(16'hC300, 8'hAA);
        write_byte(16'hC301, 8'hBB);
        check_read(16'hC300, 8'hAA, "adjacent location 1 unaffected by neighbor write");
        check_read(16'hC301, 8'hBB, "adjacent location 2 holds its own value");

        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule