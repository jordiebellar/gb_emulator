// apu_frame_seq.v
// APU frame sequencer. 512 Hz beat from a 13-bit T-cycle counter.
//   step 0,2,4,6 -> clk_len   (256 Hz)
//   step 2,6     -> clk_sweep (128 Hz)
//   step 7       -> clk_env   (64 Hz)
// Outputs are single-clk strobes on the 100 MHz clk. Consumers must NOT
// gate them with ce_gb, just use them as enables directly.
// Holding apu_on low resets the sequencer so the next beat is step 0.

module apu_frame_seq (
    input  wire clk,
    input  wire ce_gb,      // 4.194304 MHz T-cycle enable
    input  wire apu_on,     // NR52 bit 7
    output reg  clk_len,
    output reg  clk_sweep,
    output reg  clk_env
);
    reg [12:0] tcnt = 13'd0;
    reg [2:0]  step = 3'd0;     // step that fires on the next wrap

    always @(posedge clk) begin
        clk_len   <= 1'b0;
        clk_sweep <= 1'b0;
        clk_env   <= 1'b0;

        if (!apu_on) begin
            tcnt <= 13'd0;
            step <= 3'd0;
        end else if (ce_gb) begin
            tcnt <= tcnt + 13'd1;
            if (&tcnt) begin
                step <= step + 3'd1;
                case (step)
                    3'd0: clk_len <= 1'b1;
                    3'd2: begin clk_len <= 1'b1; clk_sweep <= 1'b1; end
                    3'd4: clk_len <= 1'b1;
                    3'd6: begin clk_len <= 1'b1; clk_sweep <= 1'b1; end
                    3'd7: clk_env <= 1'b1;
                    default: ;
                endcase
            end
        end
    end
endmodule