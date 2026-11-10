// apu_len.v
// Length counter. Loads MAXV - ldata, counts down on clk_len while len_en,
// pulses expire when it reaches 0. A trigger on an empty counter reloads MAXV.
// MAXV = 64 for CH1/2/4, 256 for CH3.

module apu_len #(
    parameter MAXV = 64
) (
    input  wire       clk,
    input  wire       apu_on,
    input  wire       clk_len,
    input  wire       load,
    input  wire [7:0] ldata,
    input  wire       trigger,
    input  wire       len_en,
    output reg        expire = 1'b0
);
    reg [8:0] cnt = 9'd0;

    always @(posedge clk) begin
        expire <= 1'b0;
        if (!apu_on) begin
            cnt <= 9'd0;
        end else if (load) begin
            cnt <= MAXV - ldata;
        end else begin
            if (trigger && cnt == 9'd0) begin
                cnt <= MAXV;
            end else if (clk_len && len_en && cnt != 9'd0) begin
                cnt <= cnt - 9'd1;
                if (cnt == 9'd1) expire <= 1'b1;
            end
        end
    end
endmodule