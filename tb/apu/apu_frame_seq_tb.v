// apu_frame_seq_tb.v
// Runs two full 8-step cycles with ce_gb tied high (1 tick per clk, so
// one beat = 8192 clk). Expect len=8, sweep=4, env=2. Then checks that
// power-off freezes everything.

`timescale 1ns/1ps

module apu_frame_seq_tb;
    reg  clk = 1'b0;
    reg  apu_on = 1'b0;
    wire clk_len, clk_sweep, clk_env;

    integer n_len = 0, n_sweep = 0, n_env = 0;
    integer errors = 0;
    time    last_len = 0;

    apu_frame_seq dut (
        .clk(clk), .ce_gb(1'b1), .apu_on(apu_on),
        .clk_len(clk_len), .clk_sweep(clk_sweep), .clk_env(clk_env)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (clk_len) begin
            if (n_len > 0 && ($time - last_len) != 163840) begin
                $display("FAIL: len spacing %0t ns, expected 163840", $time - last_len);
                errors = errors + 1;
            end
            last_len = $time;
            n_len <= n_len + 1;
        end
        if (clk_sweep) n_sweep <= n_sweep + 1;
        if (clk_env)   n_env   <= n_env + 1;
    end

    initial begin
        $dumpfile("sim/apu_frame_seq.vcd");
        $dumpvars(0, apu_frame_seq_tb);

        #100 apu_on = 1'b1;
        #(10 * (131072 + 20));   // 16 beats plus a little slack

        if (n_len   !== 8) begin $display("FAIL: len=%0d exp 8",   n_len);   errors = errors + 1; end
        if (n_sweep !== 4) begin $display("FAIL: sweep=%0d exp 4", n_sweep); errors = errors + 1; end
        if (n_env   !== 2) begin $display("FAIL: env=%0d exp 2",   n_env);   errors = errors + 1; end

        // power off: no further strobes allowed
        apu_on = 1'b0;
        #(10 * 20000);
        if (n_len !== 8 || n_sweep !== 4 || n_env !== 2) begin
            $display("FAIL: strobes while apu_on=0");
            errors = errors + 1;
        end

        if (errors == 0) $display("PASS: frame sequencer");
        else             $display("FAILED with %0d errors", errors);
        $finish;
    end
endmodule