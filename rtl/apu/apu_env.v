// apu_env.v
// Volume envelope (CH1, CH2, CH4). NRx2: [7:4] start vol, [3] 1=up, [2:0] period.
// Period 0 means the envelope never changes the volume.

module apu_env (
    input  wire       clk,
    input  wire       clk_env,
    input  wire       trigger,
    input  wire [7:0] nrx2,
    output reg  [3:0] vol = 4'd0
);
    reg  [3:0] cnt = 4'd0;
    wire [2:0] per = nrx2[2:0];
    wire       up  = nrx2[3];
    wire [3:0] reload = (per == 3'd0) ? 4'd8 : {1'b0, per};

    always @(posedge clk) begin
        if (trigger) begin
            vol <= nrx2[7:4];
            cnt <= reload;
        end else if (clk_env) begin
            if (cnt <= 4'd1) begin
                cnt <= reload;
                if (per != 3'd0) begin
                    if ( up && vol != 4'd15) vol <= vol + 4'd1;
                    if (!up && vol != 4'd0)  vol <= vol - 4'd1;
                end
            end else begin
                cnt <= cnt - 4'd1;
            end
        end
    end
endmodule