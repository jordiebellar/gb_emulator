// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ps2_keys.v
// Author       : Aaron Luebbert
// Date         : 2026-11-02
// Description  : checks ps2_keys against a ps/2 device model that sends real
//                  11 bit frames at about 15 khz. covers every mapped key
//                  make and break, the e0 prefix on the arrow keys, the three
//                  keys that share select, the fake shift some keyboards wrap
//                  around arrow keys, two keys held at once, an unmapped key, a frame with bad parity, a
//                  frame with a bad stop bit, a low glitch and a high spike on the clock line,
//                  recovery after a stalled frame, and reset clearing held
//                  keys.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_ps2_keys;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg        rst = 1'b1;
    reg        ps2_clk  = 1'b1;
    reg        ps2_data = 1'b1;
    wire [7:0] keys;

    ps2_keys dut (.clk(clk), .rst(rst), .ps2_clk(ps2_clk), .ps2_data(ps2_data), .keys(keys));

    // when set, send() drops a 30 ns high spike into the low phase of bit 3
    reg glitch_hi = 1'b0;

    integer fails = 0;
    integer checks = 0;

    task expect(input [7:0] want, input [8*40:1] label);
        begin
            checks = checks + 1;
            if (keys !== want) begin
                fails = fails + 1;
                $display("FAIL  %-40s  expected=%b got=%b", label, want, keys);
            end
        end
    endtask

    // one clock period of the device, 66 us
    task half; begin #33000; end endtask

    // send one frame. par_flip and stop_val let a test corrupt it
    task send(input [7:0] b, input par_flip, input stop_val);
        integer i;
        reg [10:0] f;
        begin
            f = {stop_val, (~(^b)) ^ par_flip, b, 1'b0};
            for (i = 0; i < 11; i = i + 1) begin
                ps2_data = f[i];
                #5000;
                ps2_clk = 1'b0;
                if (glitch_hi && i == 3) begin
                    #10000; ps2_clk = 1'b1; #30; ps2_clk = 1'b0; #22970;
                end else begin
                    half;
                end
                ps2_clk = 1'b1;
                half;
            end
            ps2_data = 1'b1;
            #100000;
        end
    endtask

    task key(input [7:0] b); begin send(b, 1'b0, 1'b1); end endtask

    initial begin
        #200;
        rst = 1'b0;
        #1000;
        expect(8'h00, "idle");

        // plain codes
        key(8'h22);               expect(8'b0001_0000, "x make is a");
        key(8'hF0); key(8'h22);   expect(8'b0000_0000, "x break");
        key(8'h1A);               expect(8'b0010_0000, "z make is b");
        key(8'hF0); key(8'h1A);   expect(8'b0000_0000, "z break");
        key(8'h66);               expect(8'b0100_0000, "backspace is select");
        key(8'hF0); key(8'h66);   expect(8'b0000_0000, "backspace break");
        key(8'h12);               expect(8'b0100_0000, "left shift is select");
        key(8'hF0); key(8'h12);   expect(8'b0000_0000, "left shift break");
        key(8'h59);               expect(8'b0100_0000, "right shift is select");
        key(8'hF0); key(8'h59);   expect(8'b0000_0000, "right shift break");
        key(8'h5A);               expect(8'b1000_0000, "enter is start");
        key(8'hF0); key(8'h5A);   expect(8'b0000_0000, "enter break");
        key(8'hE0); key(8'h5A);               expect(8'b1000_0000, "keypad enter is start");
        key(8'hE0); key(8'hF0); key(8'h5A);   expect(8'b0000_0000, "keypad enter break");

        // three keys share select, it stays high until the last one lets go
        key(8'h66); key(8'h12);   expect(8'b0100_0000, "backspace and left shift held");
        key(8'hF0); key(8'h66);   expect(8'b0100_0000, "backspace up, left shift still holds select");
        key(8'h59);               expect(8'b0100_0000, "right shift joins");
        key(8'hF0); key(8'h12);   expect(8'b0100_0000, "left shift up, right shift still holds select");
        key(8'hF0); key(8'h59);   expect(8'b0000_0000, "last select key up");

        // the fake shift around an arrow key is not select
        key(8'hE0); key(8'h12);               expect(8'b0000_0000, "fake shift make is ignored");
        key(8'hE0); key(8'h74);               expect(8'b0000_0001, "right with a fake shift around it");
        key(8'hE0); key(8'hF0); key(8'h74);   expect(8'b0000_0000, "right break");
        key(8'hE0); key(8'hF0); key(8'h12);   expect(8'b0000_0000, "fake shift break is ignored");

        // a held real shift survives the fake shift break the keyboard sends with an arrow
        key(8'h12);               expect(8'b0100_0000, "real left shift held");
        key(8'hE0); key(8'hF0); key(8'h12);   expect(8'b0100_0000, "fake shift break leaves the real shift held");
        key(8'hE0); key(8'h75);               expect(8'b0100_0100, "up while shift held");
        key(8'hE0); key(8'hF0); key(8'h75);   expect(8'b0100_0000, "up released, shift held");
        key(8'hE0); key(8'h12);               expect(8'b0100_0000, "fake shift make leaves the real shift held");
        key(8'hF0); key(8'h12);               expect(8'b0000_0000, "real shift released");

        // arrows with the e0 prefix, break is e0 f0 code
        key(8'hE0); key(8'h74);               expect(8'b0000_0001, "right make");
        key(8'hE0); key(8'hF0); key(8'h74);   expect(8'b0000_0000, "right break");
        key(8'hE0); key(8'h6B);               expect(8'b0000_0010, "left make");
        key(8'hE0); key(8'hF0); key(8'h6B);   expect(8'b0000_0000, "left break");
        key(8'hE0); key(8'h75);               expect(8'b0000_0100, "up make");
        key(8'hE0); key(8'hF0); key(8'h75);   expect(8'b0000_0000, "up break");
        key(8'hE0); key(8'h72);               expect(8'b0000_1000, "down make");
        key(8'hE0); key(8'hF0); key(8'h72);   expect(8'b0000_0000, "down break");

        // two keys at once
        key(8'hE0); key(8'h6B);
        key(8'h22);               expect(8'b0001_0010, "left and a held");
        key(8'hF0); key(8'h22);   expect(8'b0000_0010, "a released, left held");
        key(8'hE0); key(8'hF0); key(8'h6B);   expect(8'b0000_0000, "left released");

        // an unmapped key changes nothing
        key(8'h1C);               expect(8'b0000_0000, "a key is ignored");
        key(8'hF0); key(8'h1C);   expect(8'b0000_0000, "a key break is ignored");

        // a break flag must not leak onto the next key
        key(8'hF0); key(8'h1C);
        key(8'h22);               expect(8'b0001_0000, "x after unmapped break");
        key(8'hF0); key(8'h22);

        // bad parity and bad stop are dropped
        send(8'h22, 1'b1, 1'b1);  expect(8'b0000_0000, "bad parity dropped");
        send(8'h22, 1'b0, 1'b0);  expect(8'b0000_0000, "bad stop dropped");
        key(8'h22);               expect(8'b0001_0000, "good frame after bad ones");
        key(8'hF0); key(8'h22);

        // a short glitch on the clock line is filtered out
        ps2_clk = 1'b0; #30; ps2_clk = 1'b1; #1000;
        key(8'h5A);               expect(8'b1000_0000, "frame after a clock glitch");
        key(8'hF0); key(8'h5A);

        // a short spike up inside a low phase must not look like a clock edge
        glitch_hi = 1'b1;
        key(8'h22);               expect(8'b0001_0000, "frame with a high spike on the clock");
        glitch_hi = 1'b0;
        key(8'hF0); key(8'h22);   expect(8'b0000_0000, "break after the spike frame");

        // a stalled frame times out, the next frame still lands
        begin : stall
            integer i;
            reg [7:0] b;
            b = 8'h1A;
            ps2_data = 1'b0; #5000; ps2_clk = 1'b0; half; ps2_clk = 1'b1; half;
            for (i = 0; i < 3; i = i + 1) begin
                ps2_data = b[i]; #5000; ps2_clk = 1'b0; half; ps2_clk = 1'b1; half;
            end
            ps2_data = 1'b1;
            #3_000_000;
        end
        key(8'h1A);               expect(8'b0010_0000, "frame after a stalled frame");

        // reset clears held keys
        rst = 1'b1; #100; rst = 1'b0; #100;
        expect(8'h00, "reset clears held keys");

        if (fails == 0) $display("ALL %0d CHECKS PASSED - ps2 receiver and key map verified", checks);
        else            $display("%0d of %0d checks failed", fails, checks);
        $finish;
    end

endmodule
