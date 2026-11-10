// =============================================================================
// Project      : GameBoy Emulator
// File         : flash_rd.v
// Author       : Jordie Bellar
// Description  : the game rom read from the basys 3 onboard qspi flash instead
//                  of an sd card. same host side as sd_spi.v, so cartridge.v
//                  can use either one.
//
//                  host side
//                    rd_req     one clock pulse, taken only when ready and
//                               not busy. rd_sector is latched on it
//                    busy       high from the request until rd_done
//                    rd_valid   one clock pulse per data byte, with rd_byte
//                               and rd_idx (0 to 511) alongside
//                    rd_done    one clock pulse after the last byte
//                    ready      flash is up and answered its jedec id
//                    err        sticky, the id read back as all ones or all
//                               zeros. nothing more happens until reset
//
//                  the rom image sits in the flash at BASE (0x300000), written
//                  with write_cfgmem from the hardware manager. sector n is
//                  the 512 bytes at BASE + n * 512, plain 0x03 read, one bit
//                  wide. sck = 100 mhz / (2 * HALF), 12.5 mhz at HALF = 4
//                  (the speed proven in flash_probe), 25 mhz at HALF = 2.
//
//                  after configuration the flash clock can only be driven
//                  through STARTUPE2 (USRCCLKO). the first few clocks after
//                  configuration are lost, so the bring up sends dummy clocks
//                  first. the flash may also be left in continuous read mode
//                  by the configuration read, so it then gets 0xFFFF and a
//                  66/99 software reset before the id check. wp# and hold#
//                  (dq2, dq3) are driven high by the top level.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module flash_rd #(
    parameter integer HALF     = 4,
    parameter [23:0]  BASE     = 24'h300000,
    parameter integer PWR_CLKS = 1000000,    // about 10 ms before the first clock
    parameter integer REC_CLKS = 200000      // about 2 ms after the reset command
) (
    input  wire        clk,
    input  wire        rst,

    // flash pins, sck goes out through STARTUPE2
    output wire        fl_cs_n,
    output wire        fl_mosi,
    input  wire        fl_miso,

    // status
    output reg         ready,
    output reg         err,

    // sector read, same as sd_spi
    input  wire        rd_req,
    input  wire [22:0] rd_sector,
    output reg         busy,
    output reg         rd_valid,
    output reg  [7:0]  rd_byte,
    output reg  [8:0]  rd_idx,
    output reg         rd_done
);

    // ------------------------------------------------------------------------
    // bit engine. sends e_nt bits of e_cmd, then receives e_nr bits. spi mode 0,
    // miso sampled at the end of the low half, just before sck rises
    // ------------------------------------------------------------------------
    reg         e_start, e_cs, e_rd;
    reg  [31:0] e_cmd;
    reg  [5:0]  e_nt;
    reg  [12:0] e_nr;

    reg         e_busy, cs, sck;
    reg  [31:0] sh;
    reg  [23:0] rx;
    reg  [5:0]  nt;
    reg  [12:0] nr, idx;
    reg  [1:0]  ph;
    reg  [3:0]  hc;
    reg  [4:0]  tail;
    reg  [2:0]  rb;
    reg  [8:0]  ridx;
    reg         rden;
    reg         miso_s;

    wire [12:0] total = {7'd0, nt} + nr;

    always @(posedge clk) miso_s <= fl_miso;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            e_busy   <= 1'b0;
            cs       <= 1'b0;
            sck      <= 1'b0;
            ph       <= 2'd0;
            hc       <= 4'd0;
            rb       <= 3'd0;
            ridx     <= 9'd0;
            rden     <= 1'b0;
            rd_valid <= 1'b0;
            rd_byte  <= 8'h00;
            rd_idx   <= 9'd0;
        end
        else begin
            rd_valid <= 1'b0;
            if (e_start) begin
                sh     <= e_cmd;
                nt     <= e_nt;
                nr     <= e_nr;
                idx    <= 13'd0;
                cs     <= e_cs;
                rden   <= e_rd;
                sck    <= 1'b0;
                ph     <= 2'd0;
                hc     <= 4'd0;
                rb     <= 3'd0;
                ridx   <= 9'd0;
                e_busy <= 1'b1;
            end
            else if (e_busy) begin
                if (hc != HALF - 1) hc <= hc + 4'd1;
                else begin
                    hc <= 4'd0;
                    case (ph)
                        2'd0: begin                         // end of the low half
                            if (idx >= {7'd0, nt}) begin
                                rx <= {rx[22:0], miso_s};
                                if (rden) begin
                                    if (rb == 3'd7) begin
                                        rd_byte  <= {rx[6:0], miso_s};
                                        rd_idx   <= ridx;
                                        rd_valid <= 1'b1;
                                        ridx     <= ridx + 9'd1;
                                    end
                                    rb <= rb + 3'd1;
                                end
                            end
                            sck <= 1'b1;
                            ph  <= 2'd1;
                        end
                        2'd1: begin                         // end of the high half
                            sck <= 1'b0;
                            sh  <= {sh[30:0], 1'b0};
                            idx <= idx + 13'd1;
                            if (idx + 13'd1 == total) begin
                                cs   <= 1'b0;
                                tail <= 5'd15;
                                ph   <= 2'd2;
                            end
                            else ph <= 2'd0;
                        end
                        default: begin                      // cs high gap
                            if (tail == 5'd0) e_busy <= 1'b0;
                            else tail <= tail - 5'd1;
                        end
                    endcase
                end
            end
        end
    end

    assign fl_cs_n = ~cs;
    assign fl_mosi = sh[31];

    STARTUPE2 #(.PROG_USR("FALSE"), .SIM_CCLK_FREQ(0.0)) u_su (
        .CFGCLK(), .CFGMCLK(), .EOS(), .PREQ(),
        .CLK(1'b0), .GSR(1'b0), .GTS(1'b0), .KEYCLEARB(1'b1), .PACK(1'b0),
        .USRCCLKO(sck), .USRCCLKTS(1'b0),
        .USRDONEO(1'b1), .USRDONETS(1'b1)
    );

    // ------------------------------------------------------------------------
    // sequencer
    // ------------------------------------------------------------------------
    localparam [3:0] S_DUMMY = 4'd0, S_EXIT = 4'd1, S_RSTEN = 4'd2, S_RST = 4'd3,
                     S_REC   = 4'd4, S_ID   = 4'd5, S_CHK   = 4'd6, S_IDLE = 4'd7,
                     S_RUN   = 4'd8, S_ERR  = 4'd9;

    reg [3:0]  st;
    reg [31:0] wc;

    wire [23:0] byte_addr = BASE + {rd_sector[14:0], 9'd0};

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            st      <= S_DUMMY;
            wc      <= PWR_CLKS;
            e_start <= 1'b0;
            e_cs    <= 1'b0;
            e_rd    <= 1'b0;
            e_cmd   <= 32'd0;
            e_nt    <= 6'd0;
            e_nr    <= 13'd0;
            ready   <= 1'b0;
            err     <= 1'b0;
            busy    <= 1'b0;
            rd_done <= 1'b0;
        end
        else begin
            e_start <= 1'b0;
            rd_done <= 1'b0;
            if (wc != 32'd0) wc <= wc - 32'd1;
            else if (!e_busy && !e_start) begin
                case (st)
                    // dummy clocks with cs high, the first few after config are lost
                    S_DUMMY: begin e_cmd <= 32'h0;        e_nt <= 6'd16; e_nr <= 13'd0;  e_cs <= 1'b0; e_rd <= 1'b0; e_start <= 1'b1; st <= S_EXIT;  end
                    // leave continuous read mode
                    S_EXIT:  begin e_cmd <= 32'hFFFF0000; e_nt <= 6'd16; e_nr <= 13'd0;  e_cs <= 1'b1; e_rd <= 1'b0; e_start <= 1'b1; st <= S_RSTEN; end
                    S_RSTEN: begin e_cmd <= 32'h66000000; e_nt <= 6'd8;  e_nr <= 13'd0;  e_cs <= 1'b1; e_rd <= 1'b0; e_start <= 1'b1; st <= S_RST;   end
                    S_RST:   begin e_cmd <= 32'h99000000; e_nt <= 6'd8;  e_nr <= 13'd0;  e_cs <= 1'b1; e_rd <= 1'b0; e_start <= 1'b1; st <= S_REC;   end
                    S_REC:   begin wc <= REC_CLKS; st <= S_ID; end
                    S_ID:    begin e_cmd <= 32'h9F000000; e_nt <= 6'd8;  e_nr <= 13'd24; e_cs <= 1'b1; e_rd <= 1'b0; e_start <= 1'b1; st <= S_CHK;   end
                    S_CHK: begin
                        if (rx == 24'hFFFFFF || rx == 24'h000000) begin err <= 1'b1; st <= S_ERR; end
                        else begin ready <= 1'b1; st <= S_IDLE; end
                    end

                    S_IDLE: if (rd_req) begin
                        busy    <= 1'b1;
                        e_cmd   <= {8'h03, byte_addr};
                        e_nt    <= 6'd32;
                        e_nr    <= 13'd4096;
                        e_cs    <= 1'b1;
                        e_rd    <= 1'b1;
                        e_start <= 1'b1;
                        st      <= S_RUN;
                    end

                    S_RUN: begin
                        busy    <= 1'b0;
                        rd_done <= 1'b1;
                        st      <= S_IDLE;
                    end

                    default: ;
                endcase
            end
        end
    end
endmodule