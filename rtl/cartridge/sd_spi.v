// =============================================================================
// Project      : GameBoy Emulator
// File         : sd_spi.v
// Author       : Aaron Luebbert
// Date         : 2026-11-09
// Description  : sd card reader in spi mode. brings the card up on its own
//                  after reset (power up wait, cmd0, cmd8, acmd41 loop,
//                  cmd58, cmd16 for byte addressed cards), then serves one
//                  512 byte sector read at a time with cmd17. the card is
//                  used raw, the rom image is written to it starting at
//                  sector 0 with no filesystem.
//
//                  host side
//                    rd_req     one clock pulse, taken only when ready and
//                               not busy. rd_sector is latched on it
//                    busy       high from the request until rd_done
//                    rd_valid   one clock pulse per data byte, with rd_byte
//                               and rd_idx (0 to 511) alongside
//                    rd_done    one clock pulse after the last byte and the
//                               card's crc have been clocked in
//                    ready      card is initialised and the clock is fast
//                    err        sticky, init or read failed. nothing more
//                               happens until reset
//
//                  spi mode 0, msb first, sck idles low. the miso pin is
//                  sampled one clock before the falling edge, which is the
//                  middle of the card's valid window at 25 mhz. init runs at
//                  100 mhz / (2 * DIV_SLOW) = 400 khz, reads at
//                  100 mhz / (2 * DIV_FAST) = 25 mhz.
//
//                  sdhc and sdsc cards are both handled, the ccs bit from
//                  cmd58 picks block or byte addressing. cards that fail
//                  cmd8 are treated as version 1 sdsc cards.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module sd_spi #(
    parameter [15:0] DIV_SLOW     = 16'd125,    // half period in clocks, init
    parameter [15:0] DIV_FAST     = 16'd2,      // half period in clocks, reads
    parameter integer PWR_CLKS    = 100000,     // wait before the first clock, about 1 ms
    parameter integer ACMD41_TRIES = 8000,
    parameter integer TOKEN_TRIES  = 65535
) (
    input  wire        clk,
    input  wire        rst,

    // card pins
    output reg         sd_cs_n,
    output wire        sd_sck,
    output wire        sd_mosi,
    input  wire        sd_miso,

    // status
    output reg         ready,
    output reg         err,

    // sector read
    input  wire        rd_req,
    input  wire [22:0] rd_sector,
    output reg         busy,
    output reg         rd_valid,
    output reg  [7:0]  rd_byte,
    output reg  [8:0]  rd_idx,
    output reg         rd_done
);

    // ------------------------------------------------------------------------
    // byte engine - shifts one byte out and one byte in
    // ------------------------------------------------------------------------
    reg        b_busy, b_start, b_done;
    reg  [7:0] b_tx, b_rx;
    reg  [7:0] tx_sh, rx_sh;
    reg  [3:0] bit_cnt;
    reg [15:0] div_cnt;
    reg        sck_r, mosi_r, fast, miso_s;

    wire [15:0] half = fast ? DIV_FAST : DIV_SLOW;
    wire  [7:0] rx_n = {rx_sh[6:0], miso_s};

    assign sd_sck  = sck_r;
    assign sd_mosi = mosi_r;

    always @(posedge clk) miso_s <= sd_miso;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            b_busy  <= 1'b0;
            b_done  <= 1'b0;
            sck_r   <= 1'b0;
            mosi_r  <= 1'b1;
            div_cnt <= 16'd0;
            bit_cnt <= 4'd0;
            tx_sh   <= 8'hFF;
            rx_sh   <= 8'h00;
            b_rx    <= 8'hFF;
        end
        else begin
            b_done <= 1'b0;
            if (!b_busy) begin
                if (b_start) begin
                    b_busy  <= 1'b1;
                    tx_sh   <= b_tx;
                    mosi_r  <= b_tx[7];
                    bit_cnt <= 4'd0;
                    div_cnt <= 16'd0;
                    sck_r   <= 1'b0;
                end
            end
            else if (div_cnt == half - 16'd1) begin
                div_cnt <= 16'd0;
                if (!sck_r) begin
                    // rising edge, the card samples mosi here
                    sck_r   <= 1'b1;
                    bit_cnt <= bit_cnt + 4'd1;
                end
                else begin
                    // falling edge, take the bit the card presented and shift
                    sck_r <= 1'b0;
                    rx_sh <= rx_n;
                    if (bit_cnt == 4'd8) begin
                        b_busy <= 1'b0;
                        b_done <= 1'b1;
                        b_rx   <= rx_n;
                        mosi_r <= 1'b1;
                    end
                    else begin
                        tx_sh  <= {tx_sh[6:0], 1'b1};
                        mosi_r <= tx_sh[6];
                    end
                end
            end
            else begin
                div_cnt <= div_cnt + 16'd1;
            end
        end
    end

    // ------------------------------------------------------------------------
    // sequencer
    // ------------------------------------------------------------------------
    localparam [4:0]
        ST_PWR      = 5'd0,
        ST_DUMMY    = 5'd1,
        ST_C0       = 5'd2,
        ST_C0_CHK   = 5'd3,
        ST_C8       = 5'd4,
        ST_C8_CHK   = 5'd5,
        ST_C55      = 5'd6,
        ST_C55_CHK  = 5'd7,
        ST_C41      = 5'd8,
        ST_C41_CHK  = 5'd9,
        ST_C58      = 5'd10,
        ST_C58_CHK  = 5'd11,
        ST_C16      = 5'd12,
        ST_C16_CHK  = 5'd13,
        ST_IDLE     = 5'd14,
        ST_C17_CHK  = 5'd15,
        ST_TOKEN    = 5'd16,
        ST_DATA     = 5'd17,
        ST_CRC      = 5'd18,
        ST_FIN      = 5'd19,
        ST_ERR      = 5'd20,
        ST_CMD_SEND = 5'd21,
        ST_CMD_R1   = 5'd22,
        ST_CMD_RESP = 5'd23,
        ST_CMD_END  = 5'd24;

    reg  [4:0]  st, after_st;
    reg         bw;               // a byte is in flight
    reg  [2:0]  cmd_cnt;
    reg  [5:0]  cmd_idx;
    reg  [31:0] cmd_arg;
    reg  [7:0]  cmd_crc;
    reg         cmd_r7, cmd_keep;
    reg  [7:0]  r1;
    reg  [31:0] r32;
    reg  [4:0]  rcnt;
    reg         v2, ccs;
    reg  [15:0] tries;
    reg  [31:0] cnt;
    reg  [22:0] sector_q;
    reg  [8:0]  idx;

    // start a command, the sequencer runs it and lands in 'next' with r1 and
    // r32 filled in
    task launch(input [5:0] i, input [31:0] a, input [7:0] c, input r7, input keep, input [4:0] next);
        begin
            cmd_idx  <= i;
            cmd_arg  <= a;
            cmd_crc  <= c;
            cmd_r7   <= r7;
            cmd_keep <= keep;
            after_st <= next;
            cmd_cnt  <= 3'd0;
            st       <= ST_CMD_SEND;
        end
    endtask

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            st       <= ST_PWR;
            after_st <= ST_PWR;
            bw       <= 1'b0;
            b_start  <= 1'b0;
            b_tx     <= 8'hFF;
            sd_cs_n  <= 1'b1;
            fast     <= 1'b0;
            ready    <= 1'b0;
            err      <= 1'b0;
            busy     <= 1'b0;
            rd_valid <= 1'b0;
            rd_byte  <= 8'h00;
            rd_idx   <= 9'd0;
            rd_done  <= 1'b0;
            cmd_cnt  <= 3'd0;
            cmd_idx  <= 6'd0;
            cmd_arg  <= 32'd0;
            cmd_crc  <= 8'h01;
            cmd_r7   <= 1'b0;
            cmd_keep <= 1'b0;
            r1       <= 8'hFF;
            r32      <= 32'd0;
            rcnt     <= 5'd0;
            v2       <= 1'b0;
            ccs      <= 1'b0;
            tries    <= 16'd0;
            cnt      <= 32'd0;
            sector_q <= 23'd0;
            idx      <= 9'd0;
        end
        else begin
            b_start  <= 1'b0;
            rd_valid <= 1'b0;
            rd_done  <= 1'b0;

            case (st)
                // ------------------------------------------------------------
                // bring up
                // ------------------------------------------------------------
                ST_PWR: begin
                    sd_cs_n <= 1'b1;
                    if (cnt == PWR_CLKS) begin
                        cnt <= 32'd0;
                        st  <= ST_DUMMY;
                    end
                    else cnt <= cnt + 32'd1;
                end

                // ten idle bytes with cs high, at least 74 clocks
                ST_DUMMY: begin
                    if (!bw) begin
                        if (!b_busy) begin b_start <= 1'b1; b_tx <= 8'hFF; bw <= 1'b1; end
                    end
                    else if (b_done) begin
                        bw <= 1'b0;
                        if (cnt == 32'd9) begin cnt <= 32'd0; tries <= 16'd0; st <= ST_C0; end
                        else cnt <= cnt + 32'd1;
                    end
                end

                ST_C0:     launch(6'd0, 32'd0, 8'h95, 1'b0, 1'b0, ST_C0_CHK);
                ST_C0_CHK: begin
                    if (r1 == 8'h01) begin tries <= 16'd0; st <= ST_C8; end
                    else if (tries == 16'd20) begin err <= 1'b1; st <= ST_ERR; end
                    else begin tries <= tries + 16'd1; st <= ST_C0; end
                end

                ST_C8:     launch(6'd8, 32'h000001AA, 8'h87, 1'b1, 1'b0, ST_C8_CHK);
                ST_C8_CHK: begin
                    tries <= 16'd0;
                    if (r1 == 8'h01 && r32[11:0] == 12'h1AA) begin v2 <= 1'b1; st <= ST_C55; end
                    else if (r1[2]) begin v2 <= 1'b0; st <= ST_C55; end      // illegal command, version 1 card
                    else begin err <= 1'b1; st <= ST_ERR; end
                end

                ST_C55:     launch(6'd55, 32'd0, 8'h01, 1'b0, 1'b0, ST_C55_CHK);
                ST_C55_CHK: begin
                    if (r1[7:1] == 7'd0) st <= ST_C41;
                    else begin err <= 1'b1; st <= ST_ERR; end
                end

                ST_C41:     launch(6'd41, v2 ? 32'h40000000 : 32'd0, 8'h01, 1'b0, 1'b0, ST_C41_CHK);
                ST_C41_CHK: begin
                    if (r1 == 8'h00) begin
                        if (v2) st <= ST_C58;
                        else begin ccs <= 1'b0; st <= ST_C16; end
                    end
                    else if (r1 == 8'h01 && tries < ACMD41_TRIES) begin
                        tries <= tries + 16'd1;
                        st    <= ST_C55;
                    end
                    else begin err <= 1'b1; st <= ST_ERR; end
                end

                ST_C58:     launch(6'd58, 32'd0, 8'h01, 1'b1, 1'b0, ST_C58_CHK);
                ST_C58_CHK: begin
                    if (r1 == 8'h00) begin
                        ccs <= r32[30];
                        if (r32[30]) begin
                            fast  <= 1'b1;
                            ready <= 1'b1;
                            st    <= ST_IDLE;
                        end
                        else st <= ST_C16;
                    end
                    else begin err <= 1'b1; st <= ST_ERR; end
                end

                ST_C16:     launch(6'd16, 32'd512, 8'h01, 1'b0, 1'b0, ST_C16_CHK);
                ST_C16_CHK: begin
                    fast  <= 1'b1;
                    ready <= 1'b1;
                    st    <= ST_IDLE;
                end

                // ------------------------------------------------------------
                // sector read
                // ------------------------------------------------------------
                ST_IDLE: begin
                    sd_cs_n <= 1'b1;
                    if (rd_req) begin
                        busy     <= 1'b1;
                        sector_q <= rd_sector;
                        launch(6'd17, ccs ? {9'd0, rd_sector} : {rd_sector, 9'd0},
                               8'h01, 1'b0, 1'b1, ST_C17_CHK);
                    end
                end

                ST_C17_CHK: begin
                    if (r1 == 8'h00) begin cnt <= 32'd0; st <= ST_TOKEN; end
                    else begin err <= 1'b1; st <= ST_ERR; end
                end

                // poll for the start token
                ST_TOKEN: begin
                    if (!bw) begin
                        if (!b_busy) begin b_start <= 1'b1; b_tx <= 8'hFF; bw <= 1'b1; end
                    end
                    else if (b_done) begin
                        bw <= 1'b0;
                        if (b_rx == 8'hFE) begin idx <= 9'd0; st <= ST_DATA; end
                        else if (b_rx == 8'hFF && cnt < TOKEN_TRIES) cnt <= cnt + 32'd1;
                        else begin err <= 1'b1; st <= ST_ERR; end
                    end
                end

                ST_DATA: begin
                    if (!bw) begin
                        if (!b_busy) begin b_start <= 1'b1; b_tx <= 8'hFF; bw <= 1'b1; end
                    end
                    else if (b_done) begin
                        bw       <= 1'b0;
                        rd_byte  <= b_rx;
                        rd_idx   <= idx;
                        rd_valid <= 1'b1;
                        if (idx == 9'd511) begin cnt <= 32'd0; st <= ST_CRC; end
                        else idx <= idx + 9'd1;
                    end
                end

                // two crc bytes, not checked
                ST_CRC: begin
                    if (!bw) begin
                        if (!b_busy) begin b_start <= 1'b1; b_tx <= 8'hFF; bw <= 1'b1; end
                    end
                    else if (b_done) begin
                        bw <= 1'b0;
                        if (cnt == 32'd1) begin sd_cs_n <= 1'b1; cnt <= 32'd0; st <= ST_FIN; end
                        else cnt <= cnt + 32'd1;
                    end
                end

                // one more byte with cs high to let the card finish
                ST_FIN: begin
                    if (!bw) begin
                        if (!b_busy) begin b_start <= 1'b1; b_tx <= 8'hFF; bw <= 1'b1; end
                    end
                    else if (b_done) begin
                        bw      <= 1'b0;
                        rd_done <= 1'b1;
                        busy    <= 1'b0;
                        st      <= ST_IDLE;
                    end
                end

                ST_ERR: begin
                    sd_cs_n <= 1'b1;
                    busy    <= 1'b0;
                end

                // ------------------------------------------------------------
                // command engine - six command bytes, the r1 poll, an
                // optional four byte tail, then release the card
                // ------------------------------------------------------------
                ST_CMD_SEND: begin
                    sd_cs_n <= 1'b0;
                    if (!bw) begin
                        if (!b_busy) begin
                            b_start <= 1'b1;
                            bw      <= 1'b1;
                            case (cmd_cnt)
                                3'd0: b_tx <= {2'b01, cmd_idx};
                                3'd1: b_tx <= cmd_arg[31:24];
                                3'd2: b_tx <= cmd_arg[23:16];
                                3'd3: b_tx <= cmd_arg[15:8];
                                3'd4: b_tx <= cmd_arg[7:0];
                                default: b_tx <= cmd_crc;
                            endcase
                        end
                    end
                    else if (b_done) begin
                        bw <= 1'b0;
                        if (cmd_cnt == 3'd5) begin rcnt <= 5'd0; st <= ST_CMD_R1; end
                        else cmd_cnt <= cmd_cnt + 3'd1;
                    end
                end

                ST_CMD_R1: begin
                    if (!bw) begin
                        if (!b_busy) begin b_start <= 1'b1; b_tx <= 8'hFF; bw <= 1'b1; end
                    end
                    else if (b_done) begin
                        bw <= 1'b0;
                        if (!b_rx[7]) begin
                            r1 <= b_rx;
                            if (cmd_r7) begin rcnt <= 5'd0; st <= ST_CMD_RESP; end
                            else st <= ST_CMD_END;
                        end
                        else if (rcnt == 5'd15) begin
                            r1 <= 8'hFF;
                            st <= ST_CMD_END;
                        end
                        else rcnt <= rcnt + 5'd1;
                    end
                end

                ST_CMD_RESP: begin
                    if (!bw) begin
                        if (!b_busy) begin b_start <= 1'b1; b_tx <= 8'hFF; bw <= 1'b1; end
                    end
                    else if (b_done) begin
                        bw  <= 1'b0;
                        r32 <= {r32[23:0], b_rx};
                        if (rcnt == 5'd3) st <= ST_CMD_END;
                        else rcnt <= rcnt + 5'd1;
                    end
                end

                ST_CMD_END: begin
                    if (cmd_keep) st <= after_st;
                    else begin
                        sd_cs_n <= 1'b1;
                        if (!bw) begin
                            if (!b_busy) begin b_start <= 1'b1; b_tx <= 8'hFF; bw <= 1'b1; end
                        end
                        else if (b_done) begin
                            bw <= 1'b0;
                            st <= after_st;
                        end
                    end
                end

                default: st <= ST_ERR;
            endcase
        end
    end

endmodule
