// apu_pulse.v
// Pulse channel core (CH1 and CH2).
// 11-bit up-counter timer, ticks every 4 T-cycles. Overflow advances the
// 8-slot duty position. kill clears ch_on (length expiry, sweep overflow,
// DAC off). trigger has priority over kill.

module apu_pulse (
    input  wire        clk,
    input  wire        ce_gb,
    input  wire        apu_on,
    input  wire        trigger,
    input  wire        kill,
    input  wire [1:0]  duty,
    input  wire [10:0] freq,
    input  wire [3:0]  vol,
    output reg         ch_on = 1'b0,
    output wire [3:0]  out
);
    reg [1:0]  pre   = 2'd0;
    reg [10:0] timer = 11'd0;
    reg [2:0]  slot  = 3'd0;

    wire tick = ce_gb && (pre == 2'd3);

    wire [7:0] pat = (duty == 2'd0) ? 8'b1000_0000 :
                     (duty == 2'd1) ? 8'b1000_0001 :
                     (duty == 2'd2) ? 8'b1110_0001 :
                                      8'b0111_1110;

    assign out = (ch_on && pat[slot]) ? vol : 4'd0;

    always @(posedge clk) begin
        if (!apu_on) begin
            ch_on <= 1'b0;
            pre   <= 2'd0;
        end else begin
            if (ce_gb) pre <= pre + 2'd1;

            if (trigger) begin
                ch_on <= 1'b1;
                timer <= freq;
            end else begin
                if (kill) ch_on <= 1'b0;
                if (tick) begin
                    if (timer == 11'd2047) begin
                        timer <= freq;
                        slot  <= slot + 3'd1;
                    end else begin
                        timer <= timer + 11'd1;
                    end
                end
            end
        end
    end
endmodule