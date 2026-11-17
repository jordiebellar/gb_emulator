// =============================================================================
// Project      : GameBoy Emulator
// File         : sd_probe_top.v
// Author       : Aaron Luebbert
// Date         : 2026-11-16
// Description  : bring-up design for the sd card, no game boy in it. it runs
//                  sd_spi alone on the basys 3 so the card, the wiring and the
//                  rom image can be checked before the cartridge goes near it.
//
//                  what to do
//                    1. program the board with the card in. btnC resets
//                    2. led0 comes on when the card is up. led1 on means the
//                       card did not answer (check wiring, press btnC to retry)
//                    3. sector 0 is read on its own. the four digits show one
//                       16 bit word of it, picked by sw7-sw0 (the word number,
//                       two bytes each). sw7-sw0 = 82 shows the nintendo logo
//                       start, CEED. 9A shows the title start of the game
//                    4. set sw15-sw8 to a sector number and press btnU to read
//                       that sector into the buffer and show it the same way
//                    5. set sw15-sw8 to n and press btnL to read the first
//                       (n + 1) * 8 sectors in a row. the digits then show the
//                       sum of every byte read, mod 65536, and led3 comes on.
//                       mkcard.py prints the same number for the rom file, so a
//                       match means the whole read path is clean. sw15-sw8 = FF
//                       checks 1 mb. while it runs led15-led8 count the sectors
//
//                  leds   0 card ready      1 card error     2 reading
//                         3 showing sum     4 sum run active 5 card selected
//                         6 a sector is in the buffer       7 heartbeat
//                         15-8 sector count of the sum run
//
//                  DIV_FAST is 4 here, 12.5 mhz, kinder to jumper wires than the
//                  25 mhz the cartridge uses. set it to 2 once this works
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module probe_btn #(
    parameter integer BITS = 20
) (
    input  wire clk,
    input  wire in,
    output reg  pulse
);
    reg [1:0]      s   = 2'b00;
    reg [BITS-1:0] cnt = {BITS{1'b0}};
    reg            st  = 1'b0;
    initial pulse = 1'b0;

    always @(posedge clk) begin
        s     <= {s[0], in};
        pulse <= 1'b0;
        if (s[1] == st) cnt <= {BITS{1'b0}};
        else begin
            cnt <= cnt + 1'b1;
            if (&cnt) begin
                st  <= s[1];
                cnt <= {BITS{1'b0}};
                if (s[1]) pulse <= 1'b1;
            end
        end
    end
endmodule


module sd_probe_top #(
    parameter [15:0]   DIV_SLOW  = 16'd125,
    parameter [15:0]   DIV_FAST  = 16'd4,
    parameter integer  PWR_CLKS  = 100000,
    parameter integer  DEB_BITS  = 20
) (
    input  wire        clk,
    input  wire        btnC,
    input  wire        btnU,
    input  wire        btnL,
    input  wire [15:0] sw,
    output wire [15:0] led,
    output reg  [6:0]  seg,
    output wire        dp,
    output reg  [3:0]  an,

    output wire        sd_cs_n,
    output wire        sd_sck,
    output wire        sd_mosi,
    input  wire        sd_miso
);

    // ------------------------------------------------------------------------
    // reset - a short power up pulse, or btnC
    // ------------------------------------------------------------------------
    reg [3:0] por   = 4'd0;
    reg [1:0] c_s   = 2'b00;
    always @(posedge clk) begin
        if (por != 4'hF) por <= por + 4'd1;
        c_s <= {c_s[0], btnC};
    end
    wire rst = (por != 4'hF) | c_s[1];

    wire btnU_p, btnL_p;
    probe_btn #(.BITS(DEB_BITS)) u_bu (.clk(clk), .in(btnU), .pulse(btnU_p));
    probe_btn #(.BITS(DEB_BITS)) u_bl (.clk(clk), .in(btnL), .pulse(btnL_p));

    // ------------------------------------------------------------------------
    // the card
    // ------------------------------------------------------------------------
    reg         rd_req = 1'b0;
    reg  [22:0] rd_sector = 23'd0;
    wire        ready, err, busy, rd_valid, rd_done;
    wire [7:0]  rd_byte;
    wire [8:0]  rd_idx;

    sd_spi #(
        .DIV_SLOW (DIV_SLOW),
        .DIV_FAST (DIV_FAST),
        .PWR_CLKS (PWR_CLKS)
    ) u_sd (
        .clk(clk), .rst(rst),
        .sd_cs_n(sd_cs_n), .sd_sck(sd_sck), .sd_mosi(sd_mosi), .sd_miso(sd_miso),
        .ready(ready), .err(err),
        .rd_req(rd_req), .rd_sector(rd_sector), .busy(busy),
        .rd_valid(rd_valid), .rd_byte(rd_byte), .rd_idx(rd_idx), .rd_done(rd_done)
    );

    // ------------------------------------------------------------------------
    // one sector buffer, as 256 words
    // ------------------------------------------------------------------------
    reg [7:0]  mem_hi [0:255];
    reg [7:0]  mem_lo [0:255];
    reg [15:0] word_q = 16'd0;
    integer    mi;
    initial for (mi = 0; mi < 256; mi = mi + 1) begin mem_hi[mi] = 8'd0; mem_lo[mi] = 8'd0; end

    always @(posedge clk) begin
        if (rd_valid) begin
            if (!rd_idx[0]) mem_hi[rd_idx[8:1]] <= rd_byte;
            else            mem_lo[rd_idx[8:1]] <= rd_byte;
        end
        word_q <= {mem_hi[sw[7:0]], mem_lo[sw[7:0]]};
    end

    // ------------------------------------------------------------------------
    // control - one sector on btnU, a run of sectors on btnL
    // ------------------------------------------------------------------------
    reg         ready_q = 1'b0;
    reg         waiting = 1'b0;
    reg         run     = 1'b0;
    reg         show_sum = 1'b0;
    reg         have    = 1'b0;
    reg  [11:0] sec_cnt = 12'd0;
    reg  [11:0] sec_tot = 12'd0;
    reg  [15:0] sum     = 16'd0;

    wire auto = ready & ~ready_q;

    always @(posedge clk) begin
        ready_q <= ready;
        rd_req  <= 1'b0;
        if (rst) begin
            waiting  <= 1'b0;
            run      <= 1'b0;
            show_sum <= 1'b0;
            have     <= 1'b0;
            sec_cnt  <= 12'd0;
            sum      <= 16'd0;
        end
        else begin
            if (run && rd_valid) sum <= sum + {8'd0, rd_byte};

            if (!waiting) begin
                if (ready && !busy && !err) begin
                    if (auto || btnU_p) begin
                        rd_sector <= auto ? 23'd0 : {15'd0, sw[15:8]};
                        rd_req    <= 1'b1;
                        waiting   <= 1'b1;
                        run       <= 1'b0;
                        show_sum  <= 1'b0;
                    end
                    else if (btnL_p) begin
                        rd_sector <= 23'd0;
                        rd_req    <= 1'b1;
                        waiting   <= 1'b1;
                        run       <= 1'b1;
                        show_sum  <= 1'b0;
                        sec_cnt   <= 12'd0;
                        sec_tot   <= {1'b0, sw[15:8], 3'b000} + 12'd8;
                        sum       <= 16'd0;
                    end
                end
            end
            else if (rd_done) begin
                have <= 1'b1;
                if (run) begin
                    sec_cnt <= sec_cnt + 12'd1;
                    if (sec_cnt + 12'd1 == sec_tot) begin
                        run      <= 1'b0;
                        show_sum <= 1'b1;
                        waiting  <= 1'b0;
                    end
                    else begin
                        rd_sector <= {11'd0, sec_cnt + 12'd1};
                        rd_req    <= 1'b1;
                    end
                end
                else waiting <= 1'b0;
            end
        end
    end

    wire [15:0] disp = show_sum ? sum : word_q;

    // ------------------------------------------------------------------------
    // leds
    // ------------------------------------------------------------------------
    reg [26:0] hb = 27'd0;
    always @(posedge clk) hb <= hb + 27'd1;

    assign led = {sec_cnt[11:4], hb[26], have, ~sd_cs_n, run, show_sum, busy, err, ready};

    // ------------------------------------------------------------------------
    // seven segment display, four digits shared
    // ------------------------------------------------------------------------
    reg [16:0] rf = 17'd0;
    always @(posedge clk) rf <= rf + 17'd1;
    wire [1:0] ds = rf[16:15];

    reg [3:0] nib;
    always @(*) begin
        case (ds)
            2'd0:    nib = disp[3:0];
            2'd1:    nib = disp[7:4];
            2'd2:    nib = disp[11:8];
            default: nib = disp[15:12];
        endcase
        an = ~(4'b0001 << ds);
    end

    always @(*) begin
        case (nib)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            default: seg = 7'b0001110;
        endcase
    end

    assign dp = 1'b1;

endmodule
