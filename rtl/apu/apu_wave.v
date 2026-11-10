// apu_wave.v
// CH3 wave channel. Steps through 32 four-bit samples of wave RAM.
// Timer ticks every 2 T-cycles, period (2048 - freq) ticks per sample.
// lvl (NR32 bits 6:5): 0 mute, 1 100%, 2 50%, 3 25%.

module apu_wave (
    input  wire        clk,
    input  wire        ce_gb,
    input  wire        apu_on,
    input  wire        trigger,
    input  wire        kill,
    input  wire [10:0] freq,
    input  wire [1:0]  lvl,
    output wire [3:0]  rd_idx,
    input  wire [7:0]  rd_byte,
    output reg         ch_on = 1'b0,
    output wire [3:0]  out
);
    reg        half  = 1'b0;
    reg [10:0] timer = 11'd0;
    reg [4:0]  pos   = 5'd0;

    wire tick = ce_gb && half;

    assign rd_idx = pos[4:1];
    wire [3:0] nib = pos[0] ? rd_byte[3:0] : rd_byte[7:4];

    wire [3:0] shifted = (lvl == 2'd1) ? nib :
                         (lvl == 2'd2) ? {1'b0,  nib[3:1]} :
                         (lvl == 2'd3) ? {2'b00, nib[3:2]} : 4'd0;

    assign out = ch_on ? shifted : 4'd0;

    always @(posedge clk) begin
        if (!apu_on) begin
            ch_on <= 1'b0;
            half  <= 1'b0;
        end else begin
            if (ce_gb) half <= ~half;

            if (trigger) begin
                ch_on <= 1'b1;
                timer <= freq;
                pos   <= 5'd0;
            end else begin
                if (kill) ch_on <= 1'b0;
                if (tick) begin
                    if (timer == 11'd2047) begin
                        timer <= freq;
                        pos   <= pos + 5'd1;
                    end else begin
                        timer <= timer + 11'd1;
                    end
                end
            end
        end
    end
endmodule