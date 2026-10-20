// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_fetcher.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : full frame testbench for ppu_fetcher, wired to the real
//                  ppu_mode_fsm so the end of mode 3 is the fetcher's own
//                  line_done, not a stub. vram is filled with pseudo
//                  random bytes from a fixed lfsr, so every tile and every
//                  map entry is different and nothing passes by accident.
//
//                  scx, scy, and lcdc bits 0, 3, 4 change every line by
//                  fixed formulas, covering all 8 values of scx & 7, both
//                  tile maps, both tile data modes, and background off.
//
//                  the oracle is a closed form rendering rule, written in
//                  a different style from the rtl on purpose: signed
//                  arithmetic and division, no fifo, no discard counter.
//                  it comes straight from the pan docs rules for which tile
//                  and which row feed each screen pixel.
//
//                  checks:
//                  - all 23040 pixels of the frame match the oracle
//                  - every line has exactly 160 pixels, none missing
//                  - pixel 0 lands on mode 3 dot 12 + (scx & 7)
//                  - pixel 159 lands on dot 171 + (scx & 7), so output is
//                    one pixel per dot with no gaps
//                  - the real fsm leaves mode 3 on dot 252 + (scx & 7)
//                  - no pixel while the lcd is off or outside mode 3
//
//                  run with +dump to write vram_dump.hex, expc_dump.hex,
//                  and got_dump.hex for cross checking against python.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu_fetcher;

    reg  clk;
    reg  rst;
    reg  lcd_en;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        #200000000;
        $display("TIMEOUT");
        $finish;
    end

    wire [1:0] mode;
    wire [8:0] dot_counter;
    wire [7:0] ly;

    wire       pixel_valid;
    wire [1:0] pixel_color;
    wire [7:0] pixel_x;
    wire       line_done;
    wire [12:0] vram_addr;

    reg  [7:0] vram [0:8191];
    wire [7:0] vram_data = vram[vram_addr];

    // --- per line configuration, from fixed formulas -----------------------
    function [7:0] f_scx(input integer l);
        f_scx = (l * 13 + 5) % 256;
    endfunction
    function [7:0] f_scy(input integer l);
        f_scy = (l * 3) % 256;
    endfunction
    function [7:0] f_lcdc(input integer l);
        begin
            f_lcdc    = 8'h80;
            f_lcdc[0] = ((l % 37) != 0);
            f_lcdc[3] = ((l / 8) % 2);
            f_lcdc[4] = ((l / 16) % 2);
        end
    endfunction

    integer lyi;
    always @(*) lyi = (ly < 144) ? ly : 0;

    wire [7:0] scx  = f_scx(lyi);
    wire [7:0] scy  = f_scy(lyi);
    wire [7:0] lcdc = f_lcdc(lyi);

    ppu_mode_fsm fsm (
        .clk(clk), .ce_gb(1'b1), .rst(rst), .lcd_en(lcd_en),
        .fifo_done(line_done),
        .mode(mode), .dot_counter(dot_counter), .ly(ly),
        .oam_stall(), .vram_stall(),
        .entering_hblank(), .entering_oam_scan(), .entering_vblank(),
        .irq_vblank()
    );

    ppu_fetcher dut (
        .clk(clk), .ce_gb(1'b1), .rst(rst),
        .active(mode == 2'd3),
        .ly(ly), .scx(scx), .scy(scy), .lcdc(lcdc),
        .vram_addr(vram_addr), .vram_data(vram_data),
        .pixel_valid(pixel_valid), .pixel_color(pixel_color),
        .pixel_x(pixel_x), .line_done(line_done)
    );

    // --- oracle: which pixel belongs at screen position (x, line l) ---------
    function [1:0] ref_pixel(input integer l, input integer x);
        integer y, px, tcol, trow, map_off, tidx, data_off, lo, hi, bitn;
        reg [7:0] sx, sy, lc;
        begin
            sx = f_scx(l); sy = f_scy(l); lc = f_lcdc(l);
            y  = (l + sy) % 256;
            px = (x + sx) % 256;
            tcol = px / 8;
            trow = y / 8;
            map_off = (lc[3] ? 'h1C00 : 'h1800) + trow * 32 + tcol;
            tidx = vram[map_off];
            if (lc[4]) data_off = tidx * 16;
            else       data_off = 'h1000 + ((tidx < 128) ? tidx : (tidx - 256)) * 16;
            lo = vram[data_off + (y % 8) * 2];
            hi = vram[data_off + (y % 8) * 2 + 1];
            bitn = 7 - (px % 8);
            if (lc[0]) ref_pixel = {hi[bitn], lo[bitn]};
            else       ref_pixel = 2'b00;
        end
    endfunction

    reg [1:0] expc [0:23039];
    reg [1:0] got  [0:23039];
    integer   cnt     [0:143];
    integer   first_r [0:143];
    integer   last_r  [0:143];
    integer   hb_dot  [0:143];

    integer idle_pixels   = 0;
    integer outside_pixels = 0;
    reg     frame_run     = 1'b0;
    reg [1:0] prev_mode   = 2'd0;

    // sampled at the edge, before the registers update, so these see the
    // values of the dot that is ending
    always @(posedge clk) begin
        if (!lcd_en && pixel_valid) idle_pixels = idle_pixels + 1;

        if (frame_run) begin
            if (pixel_valid) begin
                if (mode !== 2'd3) outside_pixels = outside_pixels + 1;
                if (ly < 144) begin
                    got[ly * 160 + pixel_x] = pixel_color;
                    cnt[ly] = cnt[ly] + 1;
                    if (cnt[ly] == 1) first_r[ly] = dot_counter - 80;
                    last_r[ly] = dot_counter - 80;
                end
            end
            if (prev_mode == 2'd3 && mode == 2'd0 && ly < 144)
                hb_dot[ly] = dot_counter;
            prev_mode = mode;
        end
    end

    // --- results ---------------------------------------------------------
    integer errors = 0;
    integer checks = 0;
    integer l, x, d, bad, shown;
    integer bad_cnt, bad_first, bad_last, bad_hb;
    reg [31:0] lfsr;
    integer cov_scx [0:7];
    integer cov_map [0:3];
    integer cov_bgoff, cov_yw, cov_xw;
    reg [7:0] lc_l;

    task check(input expr, input [8*72:1] label);
        begin
            checks = checks + 1;
            if (expr) $display("PASS  %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s", label);
            end
        end
    endtask

    initial begin
        // vram from a fixed lfsr, 32 bit, taps 32 22 2 1
        lfsr = 32'hACE12468;
        for (l = 0; l < 8192; l = l + 1) begin
            for (x = 0; x < 8; x = x + 1)
                lfsr = {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
            vram[l] = lfsr[7:0];
        end

        for (l = 0; l < 144; l = l + 1) begin
            cnt[l] = 0; first_r[l] = -1; last_r[l] = -1; hb_dot[l] = -1;
            for (x = 0; x < 160; x = x + 1) begin
                expc[l * 160 + x] = ref_pixel(l, x);
                got[l * 160 + x]  = 2'bxx;
            end
        end

        lcd_en = 1'b0;
        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // lcd off: the fetcher must stay silent
        repeat (1000) @(posedge clk);
        @(negedge clk);
        check(idle_pixels === 0, "lcd off: no pixel is produced across 1000 dots");

        // one full frame of visible lines
        lcd_en    = 1'b1;
        frame_run = 1'b1;
        @(negedge clk);
        while (!(ly === 8'd144 && dot_counter === 9'd5)) @(negedge clk);
        frame_run = 1'b0;

        // --- pixel content ----------------------------------------------
        bad = 0; shown = 0;
        for (l = 0; l < 23040; l = l + 1) begin
            if (got[l] !== expc[l]) begin
                bad = bad + 1;
                if (shown < 5) begin
                    $display("      mismatch line %0d x %0d: got %b expected %b",
                              l / 160, l % 160, got[l], expc[l]);
                    shown = shown + 1;
                end
            end
        end
        check(bad === 0, "all 23040 pixels of the frame match the oracle");

        // --- per line count and timing ------------------------------------
        bad_cnt = 0; bad_first = 0; bad_last = 0; bad_hb = 0;
        for (l = 0; l < 144; l = l + 1) begin
            d = f_scx(l) & 7;
            if (cnt[l] !== 160)             bad_cnt   = bad_cnt + 1;
            if (first_r[l] !== 12 + d)      bad_first = bad_first + 1;
            if (last_r[l]  !== 171 + d)     bad_last  = bad_last + 1;
            if (hb_dot[l]  !== 252 + d)     bad_hb    = bad_hb + 1;
        end
        check(bad_cnt   === 0, "every line produced exactly 160 pixels");
        check(bad_first === 0, "pixel 0 lands on mode 3 dot 12 + (scx & 7), every line");
        check(bad_last  === 0, "pixel 159 lands on dot 171 + (scx & 7), one pixel per dot, no gaps");
        check(bad_hb    === 0, "the fsm leaves mode 3 on dot 252 + (scx & 7) via line_done");
        check(outside_pixels === 0, "no pixel is produced outside mode 3");

        // --- the test is not vacuous: coverage ------------------------------
        for (l = 0; l < 8; l = l + 1) cov_scx[l] = 0;
        for (l = 0; l < 4; l = l + 1) cov_map[l] = 0;
        cov_bgoff = 0; cov_yw = 0; cov_xw = 0;
        for (l = 0; l < 144; l = l + 1) begin
            lc_l = f_lcdc(l);
            cov_scx[f_scx(l) & 7] = cov_scx[f_scx(l) & 7] + 1;
            cov_map[{lc_l[4], lc_l[3]}] = cov_map[{lc_l[4], lc_l[3]}] + 1;
            if (!lc_l[0]) cov_bgoff = cov_bgoff + 1;
            if (l + f_scy(l) >= 256) cov_yw = cov_yw + 1;
            if (f_scx(l) + 159 >= 256) cov_xw = cov_xw + 1;
        end
        $display("      coverage: scx&7 lines %0d %0d %0d %0d %0d %0d %0d %0d",
                  cov_scx[0], cov_scx[1], cov_scx[2], cov_scx[3],
                  cov_scx[4], cov_scx[5], cov_scx[6], cov_scx[7]);
        $display("      coverage: (data,map) modes 00:%0d 01:%0d 10:%0d 11:%0d, bg off lines %0d, y wrap lines %0d, x wrap lines %0d",
                  cov_map[0], cov_map[1], cov_map[2], cov_map[3], cov_bgoff, cov_yw, cov_xw);
        check(cov_scx[0] > 0 && cov_scx[1] > 0 && cov_scx[2] > 0 && cov_scx[3] > 0 &&
              cov_scx[4] > 0 && cov_scx[5] > 0 && cov_scx[6] > 0 && cov_scx[7] > 0,
              "coverage: every value of scx & 7 is exercised");
        check(cov_map[0] > 0 && cov_map[1] > 0 && cov_map[2] > 0 && cov_map[3] > 0,
              "coverage: every combination of tile data mode and map is exercised");
        check(cov_bgoff > 0 && cov_yw > 0 && cov_xw > 0,
              "coverage: background off, y wrap, and x wrap are all exercised");

        if ($test$plusargs("dump")) begin
            $writememh("vram_dump.hex", vram);
            $writememh("expc_dump.hex", expc);
            $writememh("got_dump.hex",  got);
        end

        $display("");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED - fetcher output matches the oracle over a full frame", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule