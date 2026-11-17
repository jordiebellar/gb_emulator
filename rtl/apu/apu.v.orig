// apu.v
// Game Boy DMG APU top. Registers FF10..FF3F.
//   addr  : cpu address bits [5:0]
//   sel   : high when the cpu address is in FF10..FF3F
//   wr    : write commit strobe (a pulse or a level both work, effects are idempotent)
//   sample: mono mix, 10 bits, feed to audio_out
// Unused register bits read as 1, NR52 power-off clears NR10..NR51 and blocks
// register writes (wave RAM stays writable), as on hardware.

module apu (
    input  wire        clk,
    input  wire        ce_gb,
    input  wire [5:0]  addr,
    input  wire        sel,
    input  wire        wr,
    input  wire [7:0]  wdata,
    output reg  [7:0]  rdata  = 8'hFF,
    output reg  [9:0]  sample = 10'd0
);
    // ---------------- registers ----------------
    reg apu_on = 1'b0;
    reg [7:0]  nr10 = 8'd0, nr11 = 8'd0, nr12 = 8'd0, nr14 = 8'd0;
    reg [7:0]  nr21 = 8'd0, nr22 = 8'd0, nr23 = 8'd0, nr24 = 8'd0;
    reg [7:0]  nr30 = 8'd0, nr31 = 8'd0, nr32 = 8'd0, nr33 = 8'd0, nr34 = 8'd0;
    reg [7:0]  nr41 = 8'd0, nr42 = 8'd0, nr43 = 8'd0, nr44 = 8'd0;
    reg [7:0]  nr50 = 8'd0, nr51 = 8'd0;
    reg [10:0] ch1_freq = 11'd0;

    reg [7:0] wram [0:15];
    integer wi;
    initial for (wi = 0; wi < 16; wi = wi + 1) wram[wi] = 8'h00;

    wire sw_wr;
    wire [10:0] sw_freq;

    wire w    = wr & sel;
    wire w52  = w & (addr == 6'h26);
    wire wreg = w & apu_on;

    always @(posedge clk) begin
        if (!apu_on) begin
            nr10 <= 8'd0; nr11 <= 8'd0; nr12 <= 8'd0; nr14 <= 8'd0;
            nr21 <= 8'd0; nr22 <= 8'd0; nr23 <= 8'd0; nr24 <= 8'd0;
            nr30 <= 8'd0; nr31 <= 8'd0; nr32 <= 8'd0; nr33 <= 8'd0; nr34 <= 8'd0;
            nr41 <= 8'd0; nr42 <= 8'd0; nr43 <= 8'd0; nr44 <= 8'd0;
            nr50 <= 8'd0; nr51 <= 8'd0; ch1_freq <= 11'd0;
            if (w52 && wdata[7]) apu_on <= 1'b1;
        end else begin
            if (w52 && !wdata[7]) apu_on <= 1'b0;
            if (sw_wr) ch1_freq <= sw_freq;
            if (w) begin
                case (addr)
                    6'h10: nr10 <= wdata;
                    6'h11: nr11 <= wdata;
                    6'h12: nr12 <= wdata;
                    6'h13: ch1_freq[7:0] <= wdata;
                    6'h14: begin nr14 <= wdata; ch1_freq[10:8] <= wdata[2:0]; end
                    6'h16: nr21 <= wdata;
                    6'h17: nr22 <= wdata;
                    6'h18: nr23 <= wdata;
                    6'h19: nr24 <= wdata;
                    6'h1A: nr30 <= wdata;
                    6'h1B: nr31 <= wdata;
                    6'h1C: nr32 <= wdata;
                    6'h1D: nr33 <= wdata;
                    6'h1E: nr34 <= wdata;
                    6'h20: nr41 <= wdata;
                    6'h21: nr42 <= wdata;
                    6'h22: nr43 <= wdata;
                    6'h23: nr44 <= wdata;
                    6'h24: nr50 <= wdata;
                    6'h25: nr51 <= wdata;
                    default: ;
                endcase
            end
        end
    end

    // wave RAM is writable regardless of power
    always @(posedge clk)
        if (w && addr[5:4] == 2'b11) wram[addr[3:0]] <= wdata;

    // trigger and length-load strobes, one clk after the register write
    reg trg1 = 1'b0, trg2 = 1'b0, trg3 = 1'b0, trg4 = 1'b0;
    reg ld1  = 1'b0, ld2  = 1'b0, ld3  = 1'b0, ld4  = 1'b0;
    always @(posedge clk) begin
        trg1 <= wreg && (addr == 6'h14) && wdata[7];
        trg2 <= wreg && (addr == 6'h19) && wdata[7];
        trg3 <= wreg && (addr == 6'h1E) && wdata[7];
        trg4 <= wreg && (addr == 6'h23) && wdata[7];
        ld1  <= wreg && (addr == 6'h11);
        ld2  <= wreg && (addr == 6'h16);
        ld3  <= wreg && (addr == 6'h1B);
        ld4  <= wreg && (addr == 6'h20);
    end

    // ---------------- frame sequencer ----------------
    wire clk_len, clk_sweep, clk_env;
    apu_frame_seq u_fs (
        .clk(clk), .ce_gb(ce_gb), .apu_on(apu_on),
        .clk_len(clk_len), .clk_sweep(clk_sweep), .clk_env(clk_env)
    );

    // DAC enables
    wire dac1 = |nr12[7:3];
    wire dac2 = |nr22[7:3];
    wire dac3 = nr30[7];
    wire dac4 = |nr42[7:3];

    // ---------------- CH1 ----------------
    wire       len_exp1, sw_kill, ch1_on;
    wire [3:0] env1, c1;
    apu_len #(.MAXV(64)) u_len1 (
        .clk(clk), .apu_on(apu_on), .clk_len(clk_len), .load(ld1),
        .ldata({2'b00, nr11[5:0]}), .trigger(trg1), .len_en(nr14[6]),
        .expire(len_exp1)
    );
    apu_env u_env1 (
        .clk(clk), .clk_env(clk_env), .trigger(trg1), .nrx2(nr12), .vol(env1)
    );
    apu_sweep u_sweep (
        .clk(clk), .apu_on(apu_on), .clk_sweep(clk_sweep), .trigger(trg1),
        .nr10(nr10), .freq_in(ch1_freq),
        .freq_new(sw_freq), .freq_wr(sw_wr), .kill(sw_kill)
    );
    apu_pulse u_ch1 (
        .clk(clk), .ce_gb(ce_gb), .apu_on(apu_on), .trigger(trg1),
        .kill(len_exp1 | sw_kill | ~dac1),
        .duty(nr11[7:6]), .freq(ch1_freq), .vol(env1),
        .ch_on(ch1_on), .out(c1)
    );

    // ---------------- CH2 ----------------
    wire       len_exp2, ch2_on;
    wire [3:0] env2, c2;
    apu_len #(.MAXV(64)) u_len2 (
        .clk(clk), .apu_on(apu_on), .clk_len(clk_len), .load(ld2),
        .ldata({2'b00, nr21[5:0]}), .trigger(trg2), .len_en(nr24[6]),
        .expire(len_exp2)
    );
    apu_env u_env2 (
        .clk(clk), .clk_env(clk_env), .trigger(trg2), .nrx2(nr22), .vol(env2)
    );
    apu_pulse u_ch2 (
        .clk(clk), .ce_gb(ce_gb), .apu_on(apu_on), .trigger(trg2),
        .kill(len_exp2 | ~dac2),
        .duty(nr21[7:6]), .freq({nr24[2:0], nr23}), .vol(env2),
        .ch_on(ch2_on), .out(c2)
    );

    // ---------------- CH3 ----------------
    wire       len_exp3, ch3_on;
    wire [3:0] c3, widx;
    wire [7:0] wbyte = wram[widx];
    apu_len #(.MAXV(256)) u_len3 (
        .clk(clk), .apu_on(apu_on), .clk_len(clk_len), .load(ld3),
        .ldata(nr31), .trigger(trg3), .len_en(nr34[6]),
        .expire(len_exp3)
    );
    apu_wave u_ch3 (
        .clk(clk), .ce_gb(ce_gb), .apu_on(apu_on), .trigger(trg3),
        .kill(len_exp3 | ~dac3),
        .freq({nr34[2:0], nr33}), .lvl(nr32[6:5]),
        .rd_idx(widx), .rd_byte(wbyte),
        .ch_on(ch3_on), .out(c3)
    );

    // ---------------- CH4 ----------------
    wire       len_exp4, ch4_on;
    wire [3:0] env4, c4;
    apu_len #(.MAXV(64)) u_len4 (
        .clk(clk), .apu_on(apu_on), .clk_len(clk_len), .load(ld4),
        .ldata({2'b00, nr41[5:0]}), .trigger(trg4), .len_en(nr44[6]),
        .expire(len_exp4)
    );
    apu_env u_env4 (
        .clk(clk), .clk_env(clk_env), .trigger(trg4), .nrx2(nr42), .vol(env4)
    );
    apu_noise u_ch4 (
        .clk(clk), .ce_gb(ce_gb), .apu_on(apu_on), .trigger(trg4),
        .kill(len_exp4 | ~dac4),
        .nr43(nr43), .vol(env4),
        .ch_on(ch4_on), .out(c4)
    );

    // ---------------- mixer ----------------
    wire [5:0] l_sum = ({6{nr51[4]}} & {2'b00, c1}) + ({6{nr51[5]}} & {2'b00, c2})
                     + ({6{nr51[6]}} & {2'b00, c3}) + ({6{nr51[7]}} & {2'b00, c4});
    wire [5:0] r_sum = ({6{nr51[0]}} & {2'b00, c1}) + ({6{nr51[1]}} & {2'b00, c2})
                     + ({6{nr51[2]}} & {2'b00, c3}) + ({6{nr51[3]}} & {2'b00, c4});
    wire [8:0] l_mix = l_sum * ({1'b0, nr50[6:4]} + 4'd1);
    wire [8:0] r_mix = r_sum * ({1'b0, nr50[2:0]} + 4'd1);

    always @(posedge clk) sample <= {1'b0, l_mix} + {1'b0, r_mix};

    // ---------------- register read ----------------
    always @* begin
        case (addr)
            6'h10: rdata = nr10 | 8'h80;
            6'h11: rdata = nr11 | 8'h3F;
            6'h12: rdata = nr12;
            6'h13: rdata = 8'hFF;
            6'h14: rdata = nr14 | 8'hBF;
            6'h16: rdata = nr21 | 8'h3F;
            6'h17: rdata = nr22;
            6'h18: rdata = 8'hFF;
            6'h19: rdata = nr24 | 8'hBF;
            6'h1A: rdata = nr30 | 8'h7F;
            6'h1B: rdata = 8'hFF;
            6'h1C: rdata = nr32 | 8'h9F;
            6'h1D: rdata = 8'hFF;
            6'h1E: rdata = nr34 | 8'hBF;
            6'h20: rdata = 8'hFF;
            6'h21: rdata = nr42;
            6'h22: rdata = nr43;
            6'h23: rdata = nr44 | 8'hBF;
            6'h24: rdata = nr50;
            6'h25: rdata = nr51;
            6'h26: rdata = {apu_on, 3'b111, ch4_on, ch3_on, ch2_on, ch1_on};
            default: rdata = (addr[5:4] == 2'b11) ? wram[addr[3:0]] : 8'hFF;
        endcase
    end
endmodule