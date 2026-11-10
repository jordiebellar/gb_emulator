// apu_pulse_tb.v
// ce_gb tied high, so 1 T-cycle = 1 clk (10 ns).
// freq=1792 -> 256 ticks/slot -> 1024 clk/slot -> 8192 clk/period.
// Expect period 81920 ns, high time = (high slots contiguous) * 10240 ns.

`timescale 1ns/1ps

module apu_pulse_tb;
    reg         clk = 1'b0;
    reg         apu_on = 1'b0;
    reg         trigger = 1'b0;
    reg  [1:0]  duty = 2'd0;
    reg  [10:0] freq = 11'd1792;
    wire        ch_on;
    wire [3:0]  out;

    integer errors = 0;

    apu_pulse dut (
        .clk(clk), .ce_gb(1'b1), .apu_on(apu_on), .trigger(trigger), .kill(1'b0),
        .duty(duty), .freq(freq), .vol(4'd15),
        .ch_on(ch_on), .out(out)
    );

    always #5 clk = ~clk;

    task run_duty(input [1:0] d, input integer slots_high);
        time t_rise, t_fall, t_rise2;
        begin
            duty = d;
            @(posedge clk); #1 trigger = 1'b1;
            @(posedge clk); #1 trigger = 1'b0;

            @(posedge out[3]); t_rise  = $time;
            @(negedge out[3]); t_fall  = $time;
            @(posedge out[3]); t_rise2 = $time;

            if ((t_rise2 - t_rise) != 81920) begin
                $display("FAIL duty %0d: period %0t ns, exp 81920", d, t_rise2 - t_rise);
                errors = errors + 1;
            end
            if ((t_fall - t_rise) != slots_high * 10240) begin
                $display("FAIL duty %0d: high %0t ns, exp %0d", d, t_fall - t_rise, slots_high * 10240);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("sim/apu_pulse.vcd");
        $dumpvars(0, apu_pulse_tb);

        #100 apu_on = 1'b1;
        #100;

        run_duty(2'd0, 1);   // 12.5%
        run_duty(2'd1, 2);   // 25%  (slots 7 and 0 are contiguous)
        run_duty(2'd2, 4);   // 50%  (slots 5,6,7,0 contiguous)
        run_duty(2'd3, 6);   // 75%

        // power off must silence the channel
        apu_on = 1'b0;
        #100;
        if (ch_on !== 1'b0 || out !== 4'd0) begin
            $display("FAIL: channel not silent after apu_on=0");
            errors = errors + 1;
        end

        if (errors == 0) $display("PASS: pulse channel");
        else             $display("FAILED with %0d errors", errors);
        $finish;
    end

        // watchdog: expected total sim time is about 1 ms, bail out at 5 ms
    initial begin
        #5000000;
        $display("TIMEOUT: stuck waiting on an edge, ch_on=%b slot=%0d timer=%0d out=%h",
                 ch_on, dut.slot, dut.timer, out);
        $finish;
    end
    
endmodule