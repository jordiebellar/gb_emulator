// apu_noise.v
// CH4 noise. NR43: [7:4] clock shift s, [3] 1=7-bit LFSR, [2:0] divisor code r.
// LFSR clock period in T-cycles: D(r) << s, with D = 8 for r = 0, else 16*r.
// s = 14 or 15 stops the LFSR, like the real chip.

module apu_noise (
    input  wire       clk,
    input  wire       ce_gb,
    input  wire       apu_on,
    input  wire       trigger,
    input  wire       kill,
    input  wire [7:0] nr43,
    input  wire [3:0] vol,
    output reg        ch_on = 1'b0,
    output wire [3:0] out
);
    reg [14:0] lfsr = 15'h7FFF;
    reg [21:0] cnt  = 22'd0;

    wire [2:0]  code   = nr43[2:0];
    wire [3:0]  sh     = nr43[7:4];
    wire [6:0]  div    = (code == 3'd0) ? 7'd8 : {code, 4'b0000};
    wire [21:0] period = {15'd0, div} << sh;
    wire        xorbit = lfsr[0] ^ lfsr[1];

    assign out = (ch_on && !lfsr[0]) ? vol : 4'd0;

    always @(posedge clk) begin
        if (!apu_on) begin
            ch_on <= 1'b0;
        end else if (trigger) begin
            ch_on <= 1'b1;
            lfsr  <= 15'h7FFF;
            cnt   <= period;
        end else begin
            if (kill) ch_on <= 1'b0;
            if (ce_gb) begin
                if (cnt <= 22'd1) begin
                    cnt <= period;
                    if (sh < 4'd14) begin
                        lfsr <= nr43[3] ? {xorbit, lfsr[14:8], xorbit, lfsr[6:1]}
                                        : {xorbit, lfsr[14:1]};
                    end
                end else begin
                    cnt <= cnt - 22'd1;
                end
            end
        end
    end
endmodule