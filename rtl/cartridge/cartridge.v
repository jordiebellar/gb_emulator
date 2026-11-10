// =============================================================================
// Project      : GameBoy Emulator
// File         : cartridge.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : the whole cartridge. a boot rom overlay (256b), the game rom,
//                  the mapper (mbc1, mbc3 or mbc5, picked from the header at
//                  0147), the cart ram at A000-BFFF and the mbc3 clock.
//
//                  the game rom comes from one of two places, picked by
//                  SD_MODE
//
//                  SD_MODE = 0  a rom in block ram, loaded with readmemh from
//                               CART_ROM_FILE. ROM_BYTES is its size, 32768
//                               for a plain cartridge. the header is read from
//                               it in the first few clocks after reset
//                  SD_MODE = 2  same as 1 but the image is read from the basys 3
//                               onboard qspi flash through flash_rd.v, from
//                               0x300000 on. the sd pins carry the flash cs,
//                               mosi and miso, and sd_sck stays low
//                  SD_MODE = 1  the cartridge is an sd card in spi mode, see
//                               sd_spi.v. the card holds the raw rom image from
//                               sector 0. after reset the first 16 kb (bank 0,
//                               mapped at 0000-3FFF) is copied into block
//                               ram and the header is read out of it. the
//                               switchable window at 4000-7FFF goes through a
//                               direct mapped cache of 512 byte sectors in
//                               block ram, CACHE_LINES of them. a read that
//                               misses raises stall until its sector has been
//                               fetched, and the top level stops the clock
//                               enables while stall is high. stall also holds
//                               the machine at power up until bank 0 is in
//
//                  stall is registered and held for a few clocks after the
//                  last miss clears, so the read register has settled before
//                  the clock enables restart. the first ce_gb after any
//                  address change is 20+ clocks away, so there is always time
//                  to raise it first
//
//                  the cart ram is RAM_BYTES of block ram, 8 kb for most
//                  games and 32 kb for the pokemon carts. it does not survive
//                  power off
//
//                  address inputs
//                    addr      rom and boot side, the cpu address or the dma
//                              source address while a transfer runs
//                    cpu_addr  always the cpu, for the mapper writes and ram
//
//                  boot_active starts high on reset, cleared permanently by a
//                  nonzero write to the boot-disable register (sel_boot_disable,
//                  i.e. 0xFF50), committed on ce_m. gates whether the bottom
//                  256 bytes answer from boot rom or cart rom. every read
//                  register is clocked every clock so it has settled by the
//                  ce_m edge where the cpu samples read data. each select line
//                  drives 0 when it is not its own turn (section 3 rule)
// Revision     : 3.0 - mapper, cart ram, clock, sd card source, stall
//                  2.1 - rom read register now clocked every clock, see
//                  wram.v
//                  2.0 - ce split into ce_gb/ce_m
// =============================================================================
`timescale 1ns / 1ps

module cartridge #(
    parameter BOOT_ROM_FILE = "roms/boot/dmg_boot.hex",
    parameter CART_ROM_FILE = "roms/game/cart_rom.hex",
    parameter integer SD_MODE     = 0,
    parameter integer ROM_BYTES   = 32768,
    parameter integer RAM_BYTES   = 8192,
    parameter integer CACHE_LINES = 64,
    parameter [15:0]  SD_DIV_SLOW = 16'd125,
    parameter [15:0]  SD_DIV_FAST = 16'd2,
    parameter integer SD_PWR_CLKS = 100000,
    parameter integer FL_HALF     = 4,
    parameter integer RTC_TICKS   = 100000000
) (
    input  wire        clk,
    input  wire        ce_gb,           // unused
    input  wire        ce_m,
    input  wire        rst,
    input  wire [15:0] addr,            // rom and boot side
    input  wire [15:0] cpu_addr,        // mapper writes and cart ram
    input  wire [7:0]  data_in,         // shared bus write data
    input  wire        we,              // raw cpu write, used by the boot-disable write
    input  wire        sel_cart_rom,    // asserted for 0x0000-0x7FFF reads
    input  wire        sel_boot_disable,// asserted for the boot-disable register access
    input  wire        rom_rd,          // a rom read is in progress, cpu or dma
    input  wire        mbc_wr,          // cpu write into 0000-7FFF, not during dma
    input  wire        sel_cart_ram,    // asserted for A000-BFFF
    input  wire        ram_we,          // cpu write, not during dma
    output wire [7:0]  data_out,
    output wire [7:0]  ram_data_out,
    output wire        stall,           // high while a rom read cannot be answered yet

    // sd card pins, idle when SD_MODE is 0
    output wire        sd_cs_n,
    output wire        sd_sck,
    output wire        sd_mosi,
    input  wire        sd_miso,
    output wire [2:0]  status           // {sd error, bank 0 loaded, card ready}
);

    // ------------------------------------------------------------------------
    // boot rom and the overlay
    // ------------------------------------------------------------------------
    reg [7:0] boot_rom [0:255];

    initial $readmemh(BOOT_ROM_FILE, boot_rom);

    reg boot_active;

    always @(posedge clk or posedge rst) begin
        if (rst)
            boot_active <= 1'b1;
        else if (ce_m && sel_boot_disable && we && (data_in != 8'h00))
            boot_active <= 1'b0;
    end

    reg [7:0] boot_q;
    reg       boot_sel_q;

    always @(posedge clk) begin
        boot_q     <= boot_rom[addr[7:0]];
        boot_sel_q <= boot_active && addr[15:8] == 8'h00;
    end

    // ------------------------------------------------------------------------
    // header, from the rom itself
    // ------------------------------------------------------------------------
    wire [7:0] hdr_type_b, hdr_romsz_b, hdr_ramsz_b;
    wire [7:0] hdr_type_s, hdr_romsz_s, hdr_ramsz_s;

    wire [7:0] hdr_type  = (SD_MODE != 0) ? hdr_type_s  : hdr_type_b;
    wire [7:0] hdr_romsz = (SD_MODE != 0) ? hdr_romsz_s : hdr_romsz_b;
    wire [7:0] hdr_ramsz = (SD_MODE != 0) ? hdr_ramsz_s : hdr_ramsz_b;

    reg [1:0] kind;
    reg       has_rtc;
    always @(*) begin
        kind    = 2'd0;
        has_rtc = 1'b0;
        case (hdr_type)
            8'h01, 8'h02, 8'h03:                         kind = 2'd1;
            8'h0F, 8'h10:                                begin kind = 2'd2; has_rtc = 1'b1; end
            8'h11, 8'h12, 8'h13:                         kind = 2'd2;
            8'h19, 8'h1A, 8'h1B, 8'h1C, 8'h1D, 8'h1E:    kind = 2'd3;
            default:                                     kind = 2'd0;
        endcase
    end

    // rom size is 32 kb << code, so 2 << code banks of 16 kb
    wire [8:0] rom_mask = (hdr_romsz > 8'd8) ? 9'h1FF : ((9'd2 << hdr_romsz[3:0]) - 9'd1);

    // ram size code 0 none, 1 and 2 one bank, 3 four banks, 4 sixteen, 5 eight
    wire       ram_present = (hdr_ramsz != 8'd0);
    wire [4:0] ram_banks   = (hdr_ramsz == 8'd3) ? 5'd4 :
                             (hdr_ramsz == 8'd4) ? 5'd16 :
                             (hdr_ramsz == 8'd5) ? 5'd8 : 5'd1;
    wire [3:0] ram_bank_mask = (ram_banks[3:0] - 4'd1) & ((RAM_BYTES / 8192) - 1);

    // ------------------------------------------------------------------------
    // mapper
    // ------------------------------------------------------------------------
    wire [8:0] rom_bank, rom_bank0;
    wire       ram_en;
    wire [3:0] ram_sel;
    wire       rtc_latch;

    mbc u_mbc (
        .clk (clk), .rst (rst), .ce_m (ce_m),
        .wr (mbc_wr), .a_hi (cpu_addr[15:13]), .a_12 (cpu_addr[12]), .d (data_in),
        .kind (kind), .rom_mask (rom_mask),
        .rom_bank (rom_bank), .rom_bank0 (rom_bank0), .ram_en (ram_en), .ram_sel (ram_sel), .latch (rtc_latch)
    );

    // address into the rom image. rom_bank0 below 4000 (bank 0 almost always),
    // the mapped bank above
    wire [22:0] rom_phys = addr[14] ? {rom_bank, addr[13:0]} : {rom_bank0, addr[13:0]};

    // ------------------------------------------------------------------------
    // rom source
    // ------------------------------------------------------------------------
    localparam integer CROM_N = (SD_MODE != 0) ? 1 : ROM_BYTES;
    localparam integer ROMA   = (SD_MODE != 0) ? 1 : $clog2(ROM_BYTES);

    reg [7:0] cart_rom [0:CROM_N-1];

    initial if (SD_MODE == 0) $readmemh(CART_ROM_FILE, cart_rom);

    wire [7:0] core_q;
    wire       core_miss;
    wire       sd_ready_w, sd_err_w, loaded_w;

    generate
        if (SD_MODE == 0) begin : g_bram
            // header read through the one rom port, in the first clocks
            reg [2:0] hc;
            reg [7:0] t_r, s_r, m_r;
            reg [7:0] cart_q;

            wire        hdr_active = (hc < 3'd4);
            wire [15:0] hdr_a      = (hc == 3'd0) ? 16'h0147 : (hc == 3'd1) ? 16'h0148 : 16'h0149;
            wire [ROMA+15:0] hdr_ax = {{ROMA{1'b0}}, hdr_a};
            wire [ROMA-1:0] ra     = hdr_active ? hdr_ax[ROMA-1:0] : rom_phys[ROMA-1:0];

            always @(posedge clk) cart_q <= cart_rom[ra];

            always @(posedge clk or posedge rst) begin
                if (rst) begin
                    hc  <= 3'd0;
                    t_r <= 8'd0; s_r <= 8'd0; m_r <= 8'd0;
                end
                else begin
                    if (hc != 3'd7) hc <= hc + 3'd1;
                    if (hc == 3'd1) t_r <= cart_q;
                    if (hc == 3'd2) s_r <= cart_q;
                    if (hc == 3'd3) m_r <= cart_q;
                end
            end

            assign core_q      = cart_q;
            assign core_miss   = 1'b0;
            assign hdr_type_b  = t_r;
            assign hdr_romsz_b = s_r;
            assign hdr_ramsz_b = m_r;
            assign hdr_type_s  = 8'd0;
            assign hdr_romsz_s = 8'd0;
            assign hdr_ramsz_s = 8'd0;
            assign sd_cs_n     = 1'b1;
            assign sd_sck      = 1'b0;
            assign sd_mosi     = 1'b1;
            assign sd_ready_w  = 1'b1;
            assign sd_err_w    = 1'b0;
            assign loaded_w    = 1'b1;
        end
        else begin : g_sd
            localparam integer LB   = $clog2(CACHE_LINES);
            localparam integer TAGW = 14 - LB;

            reg [7:0] pin_ram   [0:16383];
            reg [7:0] cache_ram [0:CACHE_LINES*512-1];
            reg [TAGW-1:0] tag_mem [0:CACHE_LINES-1];
            reg [CACHE_LINES-1:0] tag_v;

            wire [LB-1:0]   cidx = rom_phys[8+LB:9];
            wire [TAGW-1:0] ctag = rom_phys[22:9+LB];
            wire            hit  = tag_v[cidx] && (tag_mem[cidx] == ctag);

            // sd card
            reg         sd_req;
            reg  [22:0] sd_sector;
            wire        sd_busy, sd_valid, sd_done;
            wire [7:0]  sd_byte;
            wire [8:0]  sd_idx;

            if (SD_MODE == 2) begin : g_flash
                flash_rd #(
                    .HALF (FL_HALF)
                ) u_fl (
                    .clk (clk), .rst (rst),
                    .fl_cs_n (sd_cs_n), .fl_mosi (sd_mosi), .fl_miso (sd_miso),
                    .ready (sd_ready_w), .err (sd_err_w),
                    .rd_req (sd_req), .rd_sector (sd_sector), .busy (sd_busy),
                    .rd_valid (sd_valid), .rd_byte (sd_byte), .rd_idx (sd_idx), .rd_done (sd_done)
                );
                assign sd_sck = 1'b0;
            end
            else begin : g_card
                sd_spi #(
                    .DIV_SLOW (SD_DIV_SLOW), .DIV_FAST (SD_DIV_FAST), .PWR_CLKS (SD_PWR_CLKS)
                ) u_sd (
                    .clk (clk), .rst (rst),
                    .sd_cs_n (sd_cs_n), .sd_sck (sd_sck), .sd_mosi (sd_mosi), .sd_miso (sd_miso),
                    .ready (sd_ready_w), .err (sd_err_w),
                    .rd_req (sd_req), .rd_sector (sd_sector), .busy (sd_busy),
                    .rd_valid (sd_valid), .rd_byte (sd_byte), .rd_idx (sd_idx), .rd_done (sd_done)
                );
            end

            // fill sequencer - bank 0 first, then one sector per miss
            localparam [2:0] F_WAIT = 3'd0, F_PREQ = 3'd1, F_PRUN = 3'd2, F_IDLE = 3'd3, F_RUN = 3'd4;

            reg [2:0]       f_st;
            reg [5:0]       pin_sec;
            reg             loaded;
            reg [LB-1:0]    fidx;
            reg [TAGW-1:0]  ftag;
            reg [7:0]       t_r, s_r, m_r;

            // bank 0 is pinned in block ram, so the low window only goes through the
            // cache on the rare mbc1 remap
            wire low_pin = !addr[14] && (rom_bank0 == 9'd0);
            wire need    = rom_rd && !low_pin;

            always @(posedge clk or posedge rst) begin
                if (rst) begin
                    f_st      <= F_WAIT;
                    pin_sec   <= 6'd0;
                    loaded    <= 1'b0;
                    tag_v     <= {CACHE_LINES{1'b0}};
                    sd_req    <= 1'b0;
                    sd_sector <= 23'd0;
                    fidx      <= {LB{1'b0}};
                    ftag      <= {TAGW{1'b0}};
                end
                else begin
                    sd_req <= 1'b0;
                    case (f_st)
                        F_WAIT: if (sd_ready_w) f_st <= F_PREQ;
                        F_PREQ: if (!sd_busy) begin
                            sd_req    <= 1'b1;
                            sd_sector <= {17'd0, pin_sec};
                            f_st      <= F_PRUN;
                        end
                        F_PRUN: if (sd_done) begin
                            if (pin_sec == 6'd31) begin loaded <= 1'b1; f_st <= F_IDLE; end
                            else begin pin_sec <= pin_sec + 6'd1; f_st <= F_PREQ; end
                        end
                        F_IDLE: if (need && !hit && !sd_busy) begin
                            fidx         <= cidx;
                            ftag         <= ctag;
                            tag_v[cidx]  <= 1'b0;
                            sd_req       <= 1'b1;
                            sd_sector    <= {9'd0, ctag, cidx};
                            f_st         <= F_RUN;
                        end
                        F_RUN: if (sd_done) begin
                            tag_mem[fidx] <= ftag;
                            tag_v[fidx]   <= 1'b1;
                            f_st          <= F_IDLE;
                        end
                        default: f_st <= F_WAIT;
                    endcase
                end
            end

            // the header bytes go past on the way into bank 0
            always @(posedge clk or posedge rst) begin
                if (rst) begin
                    t_r <= 8'd0; s_r <= 8'd0; m_r <= 8'd0;
                end
                else if (f_st == F_PRUN && sd_valid && pin_sec == 6'd0) begin
                    if (sd_idx == 9'h147) t_r <= sd_byte;
                    if (sd_idx == 9'h148) s_r <= sd_byte;
                    if (sd_idx == 9'h149) m_r <= sd_byte;
                end
            end

            // block ram: a write port from the card and a registered read
            reg [7:0] pin_q, cache_q;
            reg       win_q;

            always @(posedge clk) begin
                if (f_st == F_PRUN && sd_valid) pin_ram[{pin_sec[4:0], sd_idx}] <= sd_byte;
                pin_q <= pin_ram[addr[13:0]];
            end

            always @(posedge clk) begin
                if (f_st == F_RUN && sd_valid) cache_ram[{fidx, sd_idx}] <= sd_byte;
                cache_q <= cache_ram[{cidx, rom_phys[8:0]}];
            end

            always @(posedge clk) win_q <= !low_pin;

            assign core_q      = win_q ? cache_q : pin_q;
            assign core_miss   = !loaded || (need && !hit);
            assign hdr_type_s  = t_r;
            assign hdr_romsz_s = s_r;
            assign hdr_ramsz_s = m_r;
            assign hdr_type_b  = 8'd0;
            assign hdr_romsz_b = 8'd0;
            assign hdr_ramsz_b = 8'd0;
            assign loaded_w    = loaded;
        end
    endgenerate

    // the rom read answer. the boot overlay wins below 0100 until it is switched off
    wire [7:0] rom_rdata = boot_sel_q ? boot_q : core_q;

    assign data_out = sel_cart_rom      ? rom_rdata :
                       sel_boot_disable ? 8'hFF :
                                          8'h00;

    // ------------------------------------------------------------------------
    // stall, registered and held a few clocks past the last miss
    // ------------------------------------------------------------------------
    reg [2:0] settle;
    reg       stall_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            settle  <= (SD_MODE != 0) ? 3'd7 : 3'd0;
            stall_r <= (SD_MODE != 0);
        end
        else begin
            if (core_miss)         settle <= 3'd6;
            else if (settle != 3'd0) settle <= settle - 3'd1;
            stall_r <= core_miss | (settle != 3'd0);
        end
    end

    assign stall  = stall_r;
    assign status = {sd_err_w, loaded_w, sd_ready_w};

    // ------------------------------------------------------------------------
    // cart ram
    // ------------------------------------------------------------------------
    localparam integer RAMA = $clog2(RAM_BYTES);

    reg [7:0] cart_ram [0:RAM_BYTES-1];
    reg [7:0] ram_q;
    integer   ri;

    initial for (ri = 0; ri < RAM_BYTES; ri = ri + 1) cart_ram[ri] = 8'h00;

    wire        rtc_sel   = (kind == 2'd2) && has_rtc && ram_sel[3] && (ram_sel[2:0] <= 3'd4);
    wire        ram_hole  = (kind == 2'd2) && ((ram_sel[3] && !rtc_sel) || (!ram_sel[3] && ram_sel[2]));
    wire [3:0]  ram_bank  = ram_sel & ram_bank_mask;
    wire [16:0] ram_a_full = {ram_bank, cpu_addr[12:0]};
    wire [RAMA-1:0] ram_a  = ram_a_full[RAMA-1:0];

    wire ram_wr_ok = ram_we && sel_cart_ram && ram_en && ram_present && !rtc_sel && !ram_hole;

    always @(posedge clk) begin
        if (ce_m && ram_wr_ok) cart_ram[ram_a] <= data_in;
        ram_q <= cart_ram[ram_a];
    end

    // mbc3 clock
    wire [7:0] rtc_rd;
    wire       rtc_wr = ce_m && ram_we && sel_cart_ram && ram_en && rtc_sel;

    rtc #(.TICKS (RTC_TICKS)) u_rtc (
        .clk (clk), .rst (rst), .latch (rtc_latch),
        .wr (rtc_wr), .idx (ram_sel[2:0]), .wdata (data_in),
        .rd_idx (ram_sel[2:0]), .rdata (rtc_rd)
    );

    assign ram_data_out = !sel_cart_ram ? 8'h00 :
                          !ram_en       ? 8'hFF :
                          rtc_sel       ? rtc_rd :
                          (ram_present && !ram_hole) ? ram_q : 8'hFF;

endmodule
