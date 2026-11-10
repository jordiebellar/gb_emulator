// apu_sweep.v
// CH1 frequency sweep. NR10: [6:4] period, [3] 1=subtract, [2:0] shift.
// Keeps a shadow frequency. On each sweep step it computes the new frequency,
// kills the channel on overflow (> 2047), otherwise writes it back and
// runs a second overflow check on the result, like the real chip.

module apu_sweep (
    input  wire        clk,
    input  wire        apu_on,
    input  wire        clk_sweep,
    input  wire        trigger,
    input  wire [7:0]  nr10,
    input  wire [10:0] freq_in,
    output reg  [10:0] freq_new = 11'd0,
    output reg         freq_wr  = 1'b0,
    output reg         kill     = 1'b0
);
    reg [10:0] shadow = 11'd0;
    reg [3:0]  tmr    = 4'd0;
    reg        en     = 1'b0;

    wire [2:0] period = nr10[6:4];
    wire       neg    = nr10[3];
    wire [2:0] shift  = nr10[2:0];

    wire [10:0] base   = trigger ? freq_in : shadow;
    wire [10:0] delta  = base >> shift;
    wire [11:0] calc   = neg ? ({1'b0, base} - {1'b0, delta})
                             : ({1'b0, base} + {1'b0, delta});
    wire        ovf    = calc[11];

    wire [10:0] delta2 = calc[10:0] >> shift;
    wire [11:0] calc2  = neg ? ({1'b0, calc[10:0]} - {1'b0, delta2})
                             : ({1'b0, calc[10:0]} + {1'b0, delta2});
    wire        ovf2   = calc2[11];

    wire [3:0] reload = (period == 3'd0) ? 4'd8 : {1'b0, period};

    always @(posedge clk) begin
        freq_wr <= 1'b0;
        kill    <= 1'b0;

        if (!apu_on) begin
            en <= 1'b0;
        end else if (trigger) begin
            shadow <= freq_in;
            tmr    <= reload;
            en     <= (period != 3'd0) || (shift != 3'd0);
            if (shift != 3'd0 && ovf) kill <= 1'b1;
        end else if (clk_sweep) begin
            if (tmr <= 4'd1) begin
                tmr <= reload;
                if (en && period != 3'd0) begin
                    if (ovf) begin
                        kill <= 1'b1;
                    end else if (shift != 3'd0) begin
                        shadow   <= calc[10:0];
                        freq_new <= calc[10:0];
                        freq_wr  <= 1'b1;
                        if (ovf2) kill <= 1'b1;
                    end
                end
            end else begin
                tmr <= tmr - 4'd1;
            end
        end
    end
endmodule