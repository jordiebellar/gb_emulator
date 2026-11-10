// apu_tb.v
// Full APU check over the bus. One line per check, summary at the end.
// ce_gb tied high, so one frame-sequencer beat = 8192 clk.

`timescale 1ns/1ps

module apu_tb;
    reg        clk = 1'b0;
    reg [5:0]  addr = 6'd0;
    reg        sel = 1'b0, wr = 1'b0;
    reg [7:0]  wdata = 8'd0;
    wire [7:0] rdata;
    wire [9:0] sample;

    integer errors = 0;
    integer checks = 0;
    reg [9:0] max_s = 10'd0;
    reg [7:0] v;
    integer i;

    apu dut (
        .clk(clk), .ce_gb(1'b1), .addr(addr), .sel(sel), .wr(wr),
        .wdata(wdata), .rdata(rdata), .sample(sample)
    );

    always #5 clk = ~clk;
    always @(posedge clk) if (sample > max_s) max_s <= sample;

    task bus_write(input [5:0] a, input [7:0] d);
        begin
            @(posedge clk); #1 addr = a; wdata = d; sel = 1'b1; wr = 1'b1;
            @(posedge clk); #1 wr = 1'b0; sel = 1'b0;
        end
    endtask

    task bus_read(input [5:0] a);
        begin
            @(posedge clk); #1 addr = a; sel = 1'b1;
            #1 v = rdata;
            sel = 1'b0;
        end
    endtask

    // check without a value
    task chk(input cond, input [8*30-1:0] tag);
        begin
            checks = checks + 1;
            if (cond) $display("  ok    %0s", tag);
            else begin
                errors = errors + 1;
                $display("  FAIL  %0s", tag);
            end
        end
    endtask

    // check with a measured value printed at the end
    task chkv(input cond, input [8*30-1:0] tag, input [15:0] val);
        begin
            checks = checks + 1;
            if (cond) $display("  ok    %0s  %0h", tag, val);
            else begin
                errors = errors + 1;
                $display("  FAIL  %0s  %0h", tag, val);
            end
        end
    endtask

    initial begin
        $dumpfile("sim/apu.vcd");
        $dumpvars(0, apu_tb);
        #100;

        $display("power");
        bus_write(6'h24, 8'h77);
        bus_read(6'h24);  chkv(v == 8'h00, "write ignored while off", v);
        bus_read(6'h26);  chkv(v == 8'h70, "nr52 off", v);
        bus_write(6'h26, 8'h80);
        repeat (4) @(posedge clk);
        bus_read(6'h26);  chkv(v == 8'hF0, "nr52 on", v);
        bus_write(6'h24, 8'h77);
        bus_write(6'h25, 8'hFF);
        bus_read(6'h24);  chkv(v == 8'h77, "nr50 readback", v);
        bus_read(6'h10);  chkv(v == 8'h80, "nr10 unused bit", v);

        $display("ch2 pulse + length");
        max_s = 10'd0;
        bus_write(6'h16, 8'hBF);
        bus_write(6'h17, 8'hF0);
        bus_write(6'h18, 8'h00);
        bus_write(6'h19, 8'hC7);
        repeat (100) @(posedge clk);
        bus_read(6'h26);  chk(v[1] == 1'b1, "on after trigger");
        repeat (4000) @(posedge clk);
        chkv(max_s > 0, "makes sound, peak", max_s);
        repeat (20000) @(posedge clk);
        bus_read(6'h26);  chk(v[1] == 1'b0, "off after length");

        $display("dac off");
        bus_write(6'h17, 8'hF0);
        bus_write(6'h19, 8'h87);
        repeat (50) @(posedge clk);
        bus_read(6'h26);  chk(v[1] == 1'b1, "retrigger");
        bus_write(6'h17, 8'h00);
        repeat (50) @(posedge clk);
        bus_read(6'h26);  chk(v[1] == 1'b0, "off when dac disabled");

        $display("ch1 sweep");
        bus_write(6'h10, 8'h11);
        bus_write(6'h11, 8'h80);
        bus_write(6'h12, 8'hF0);
        bus_write(6'h13, 8'h00);
        bus_write(6'h14, 8'h84);
        repeat (100) @(posedge clk);
        bus_read(6'h26);  chk(v[0] == 1'b1, "on after trigger");
        repeat (33000) @(posedge clk);
        chkv(dut.ch1_freq == 11'h600, "freq 0x400 -> 0x600", dut.ch1_freq);
        bus_read(6'h26);  chk(v[0] == 1'b0, "killed on overflow");

        $display("ch3 wave");
        for (i = 0; i < 16; i = i + 1) bus_write(6'h30 + i, 8'hF0);
        max_s = 10'd0;
        bus_write(6'h1A, 8'h80);
        bus_write(6'h1C, 8'h20);
        bus_write(6'h1D, 8'h00);
        bus_write(6'h1E, 8'h87);
        repeat (6000) @(posedge clk);
        bus_read(6'h26);  chk(v[2] == 1'b1, "on after trigger");
        chkv(max_s > 0, "makes sound, peak", max_s);
        bus_read(6'h35);  chkv(v == 8'hF0, "wave ram readback", v);

        $display("ch4 noise");
        max_s = 10'd0;
        bus_write(6'h21, 8'hF0);
        bus_write(6'h22, 8'h00);
        bus_write(6'h23, 8'h80);
        repeat (3000) @(posedge clk);
        bus_read(6'h26);  chk(v[3] == 1'b1, "on after trigger");
        chkv(max_s > 0, "makes sound, peak", max_s);

        $display("power off");
        bus_write(6'h26, 8'h00);
        repeat (8) @(posedge clk);
        bus_read(6'h24);  chkv(v == 8'h00, "nr50 cleared", v);
        bus_read(6'h26);  chkv(v == 8'h70, "nr52 off", v);
        bus_read(6'h35);  chkv(v == 8'hF0, "wave ram kept", v);

        $display("");
        if (errors == 0) $display("%0d/%0d passed", checks, checks);
        else             $display("%0d/%0d passed, %0d failed", checks - errors, checks, errors);
        $finish;
    end

    // watchdog
    initial begin
        #5000000;
        $display("TIMEOUT");
        $finish;
    end
endmodule