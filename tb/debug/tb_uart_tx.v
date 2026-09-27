// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_uart_tx.v
// Author       : Jordie Bellar
// Date         : 2026-09-27
// Description  : Self-checking testbench for uart_tx.v at the real Basys 3
//                settings (100 MHz, 115200 baud, 868 clocks per bit).
//
//                A byte source feeds uart_tx through the valid/ready
//                handshake, the same way the FIFO in the bring-up top will.
//                A receiver model decodes the line the way a PC's UART does:
//                wait for the falling edge of the start bit, then sample each
//                bit at its midpoint.
//
//                Covers:
//                  - line idles high and ready is high after reset
//                  - every bit is exactly 868 clocks wide (measured on 0x55,
//                    whose alternating bits make every boundary an edge)
//                  - 7 bytes sent back-to-back decode correctly, each with a
//                    valid start bit and stop bit
//                  - every byte is taken exactly once by the handshake
//                  - line returns to idle high when the source is empty
//
//                Run:
//                  iverilog -o sim/tb_uart_tx tb/debug/tb_uart_tx.v rtl/debug/uart_tx.v
//                  vvp sim/tb_uart_tx
// =============================================================================
`timescale 1ns / 1ps
module tb_uart_tx;

    localparam integer CLK_HZ = 100_000_000;
    localparam integer BAUD   = 115_200;
    localparam integer CLKS   = CLK_HZ / BAUD;     // 868
    localparam integer BIT_NS = CLKS * 10;         // 8680 ns at 10 ns per clock
    localparam integer NBYTES = 7;

    reg        clk = 1'b0;
    reg        rst = 1'b1;
    wire       tx;
    wire       ready;

    // ------------------------------------------------------------------
    // Byte source: 0x55 first (for the width check), then "Passed".
    // Presents the next byte whenever it has one; advances on handshake.
    // ------------------------------------------------------------------
    reg  [7:0] msg [0:NBYTES-1];
    integer    idx = 0;
    reg        go  = 1'b0;
    wire       valid = go && (idx < NBYTES);
    wire [7:0] data  = (idx < NBYTES) ? msg[idx] : 8'h00;

    always @(posedge clk) begin
        if (valid && ready) idx <= idx + 1;
    end

    uart_tx #(
        .CLK_HZ(CLK_HZ), .BAUD(BAUD)
    ) uut (
        .clk(clk), .rst(rst),
        .data(data), .valid(valid), .ready(ready),
        .tx(tx)
    );

    always #5 clk = ~clk; // 100 MHz

    integer checks = 0;
    integer fails  = 0;

    task expect8(input [8*48-1:0] label, input [7:0] got, input [7:0] exp);
        begin
            checks = checks + 1;
            if (got === exp)
                $display("PASS  %0s  (%h)", label, got);
            else begin
                fails = fails + 1;
                $display("FAIL  %0s  expected %h  got %h", label, exp, got);
            end
        end
    endtask

    // ------------------------------------------------------------------
    // Bit-width monitor: timestamps every transition on tx. The first
    // frame (0x55) has a transition at every one of its 10 bit
    // boundaries, so its 9 intervals must each be exactly one bit-time.
    // ------------------------------------------------------------------
    realtime last_edge = 0;
    integer  n_edges   = 0;
    integer  n_widths  = 0;
    integer  bad_width = 0;

    always @(tx) begin
        if (!rst) begin
            if (n_edges >= 1 && n_edges <= 9) begin
                n_widths = n_widths + 1;
                if ($realtime - last_edge != BIT_NS) begin
                    bad_width = bad_width + 1;
                    $display("      bit %0d width %0.0f ns, expected %0d ns",
                             n_edges - 1, $realtime - last_edge, BIT_NS);
                end
            end
            last_edge = $realtime;
            n_edges   = n_edges + 1;
        end
    end

    // ------------------------------------------------------------------
    // Receiver model: falling edge of the start bit, then mid-bit samples.
    // ------------------------------------------------------------------
    reg  [7:0] rx_data [0:NBYTES-1];
    reg        rx_ok   [0:NBYTES-1];
    integer    rx_count = 0;

    task rx_byte(output [7:0] b, output ok);
        integer k;
        begin
            @(negedge tx);
            #(BIT_NS / 2);                  // middle of the start bit
            ok = (tx === 1'b0);
            for (k = 0; k < 8; k = k + 1) begin
                #(BIT_NS);                  // middle of data bit k
                b[k] = tx;
            end
            #(BIT_NS);                      // middle of the stop bit
            ok = ok && (tx === 1'b1);
        end
    endtask

    integer r;
    reg [7:0] b_tmp;
    reg       ok_tmp;
    initial begin
        wait (rst == 1'b0);
        for (r = 0; r < NBYTES; r = r + 1) begin
            rx_byte(b_tmp, ok_tmp);
            rx_data[r] = b_tmp;
            rx_ok[r]   = ok_tmp;
            rx_count   = rx_count + 1;
        end
    end

    // ------------------------------------------------------------------
    // Tests
    // ------------------------------------------------------------------
    integer i;
    initial begin
        $dumpfile("sim/waves/tb_uart_tx.vcd");
        $dumpvars(0, tb_uart_tx);

        msg[0] = 8'h55;
        msg[1] = "P"; msg[2] = "a"; msg[3] = "s";
        msg[4] = "s"; msg[5] = "e"; msg[6] = "d";

        #25 rst = 1'b0;
        @(posedge clk); #1;

        $display("\n-- reset --");
        expect8("tx idles high after reset",        {7'b0, tx},    8'h01);
        expect8("ready is high when idle",          {7'b0, ready}, 8'h01);

        go = 1'b1;
        wait (rx_count == NBYTES);
        repeat (2 * CLKS) @(posedge clk);   // let the last stop bit finish
        #1;

        $display("\n-- bit width --");
        expect8("9 bit widths measured on 0x55",    n_widths,  8'd9);
        expect8("every bit exactly 868 clocks",     bad_width, 8'd0);

        $display("\n-- decoded bytes --");
        for (i = 0; i < NBYTES; i = i + 1) begin
            expect8("byte value",                   rx_data[i], msg[i]);
            expect8("start and stop bits valid",    {7'b0, rx_ok[i]}, 8'h01);
        end

        $display("\n-- handshake --");
        expect8("each byte taken exactly once",     idx,   NBYTES);
        expect8("tx idle high when source empty",   {7'b0, tx},    8'h01);
        expect8("ready high when source empty",     {7'b0, ready}, 8'h01);

        $display("\n%0d checks, %0d failed.", checks, fails);
        if (fails == 0)
            $display("ALL UART_TX CHECKS PASSED");
        else
            $display("UART_TX CHECKS FAILED");
        $finish;
    end

    // Watchdog: 7 frames are about 0.61 ms of simulated time.
    initial begin
        #2_000_000;
        $display("\nWATCHDOG: receiver never finished (%0d of %0d bytes).",
                 rx_count, NBYTES);
        $display("UART_TX CHECKS FAILED");
        $finish;
    end

endmodule