// audio_out.v
// First-order delta-sigma 1-bit DAC.
// Pin density of 1s over time = sample / 2^W.
// Runs every clk cycle (100 MHz). sample is simply held, no strobe needed.

module audio_out #(
    parameter W = 10
) (
    input  wire         clk,
    input  wire [W-1:0] sample,
    output reg          pin
);
    reg  [W-1:0] acc = {W{1'b0}};
    wire [W:0]   sum = {1'b0, acc} + {1'b0, sample};

    always @(posedge clk) begin
        acc <= sum[W-1:0];
        pin <= sum[W];
    end
endmodule