// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_scene.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : whole ppu test for the window and sprites. each scene loads
//                  vram and oam, programs the registers over the real bus
//                  through memory_map, turns the lcd on, and renders one
//                  full frame. every one of the 23040 pixels is compared
//                  with an oracle, and so is the length of mode 3 on each of
//                  the 144 lines.
//
//                  the oracle is written from the pan docs, not from the
//                  rtl, and shares no structure with it. a pixel is worked
//                  out on its own: the background or window pixel under it
//                  from the map and tile data, then every object on the line
//                  in plain sorted order, the first with an opaque pixel
//                  there wins, then the bg-over-obj bit, then the palette.
//                  mode 3 is 172 + scx % 8, plus 6 on lines the window is
//                  drawn on, plus the pan docs object penalty per object, with
//                  a set of the background and window tiles already taken by
//                  an earlier object rather than the rtl's last tile
//                  register. an object at oam x of 0 costs 11, or 6 when an
//                  earlier object already took the tile, and one at x of 168
//                  and up costs nothing. line 0 of the frame is drawn with
//                  no objects, since the first line after lcd on has no oam
//                  scan.
//
//                  scenes: directed ones for the window alone, objects
//                  alone, 8 x 16 objects, and objects crowded to the left
//                  and right edges and past the limit of 10 per line, then
//                  random scenes with every lcdc option, scroll, window
//                  position, palette, and oam drawn at random. the window x
//                  position is kept at 7 or more, the part of the pan docs
//                  where wx below 7 has hardware quirks that are not
//                  modeled. dma is not running here, see tb_oam_dma.
// Revision     : 1.1 - line 0 has no objects, a second object at x of 0
//                  costs 6
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu_scene;

    reg        clk;
    reg        rst;
    wire [15:0] addr;
    wire [7:0]  cpu_wdata;
    wire        we, bm_sel, bm_late;

    reg [1:0] m_cnt;
    wire      ce_gb = 1'b1;
    wire      ce_m  = (m_cnt == 2'd3);
    initial m_cnt = 2'd0;
    always @(posedge clk) m_cnt <= m_cnt + 2'd1;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        #400000000;
        $display("TIMEOUT");
        $finish;
    end

    integer errors = 0;
    integer checks = 0;

    wire [7:0] bus_rdata;
    wire sel_cart_rom, sel_boot_disable, sel_cart_ram, sel_wram;
    wire sel_ppu_vram, sel_ppu_oam, sel_ppu_reg, sel_oam_dma;
    wire sel_joypad, sel_serial, sel_timer, sel_interrupt_ctrl, sel_apu, sel_hram;
    wire [7:0] ppu_vram_data_out, ppu_oam_data_out, ppu_reg_data_out;
    wire       pixel_valid, lcd_on, irq_vblank, irq_lcdstat;
    wire [1:0] pixel_color, pixel_shade;
    wire [7:0] pixel_x, pixel_y;

    memory_map mm (
        .addr(addr), .data_out(cpu_wdata), .data_in(bus_rdata), .we(we),
        .sel_cart_rom(sel_cart_rom),           .cart_rom_data_out(8'hFF),
        .sel_boot_disable(sel_boot_disable),   .boot_disable_data_out(8'hFF),
        .sel_cart_ram(sel_cart_ram),           .cart_ram_data_out(8'hFF),
        .sel_wram(sel_wram),                   .wram_data_out(8'hFF),
        .sel_ppu_vram(sel_ppu_vram),           .ppu_vram_data_out(ppu_vram_data_out),
        .sel_ppu_oam(sel_ppu_oam),             .ppu_oam_data_out(ppu_oam_data_out),
        .sel_ppu_reg(sel_ppu_reg),             .ppu_reg_data_out(ppu_reg_data_out),
        .sel_oam_dma(sel_oam_dma),             .oam_dma_data_out(8'hFF),
        .sel_joypad(sel_joypad),               .joypad_data_out(8'hFF),
        .sel_serial(sel_serial),               .serial_data_out(8'hFF),
        .sel_timer(sel_timer),                 .timer_data_out(8'hFF),
        .sel_interrupt_ctrl(sel_interrupt_ctrl), .interrupt_ctrl_data_out(8'hFF),
        .sel_apu(sel_apu),                     .apu_data_out(8'hFF),
        .sel_hram(sel_hram),                   .hram_data_out(8'hFF)
    );

    ppu dut (
        .clk(clk), .ce_gb(ce_gb), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(cpu_wdata), .we(we),
        .sel_ppu_vram(sel_ppu_vram), .ppu_vram_data_out(ppu_vram_data_out),
        .sel_ppu_oam(sel_ppu_oam),   .ppu_oam_data_out(ppu_oam_data_out),
        .sel_ppu_reg(sel_ppu_reg),   .ppu_reg_data_out(ppu_reg_data_out),
        .dma_active(1'b0),
        .dma_we(1'b0), .dma_waddr(8'h00), .dma_wdata(8'h00),
        .pixel_valid(pixel_valid), .pixel_color(pixel_color),
        .pixel_shade(pixel_shade), .lcd_on(lcd_on),
        .pixel_x(pixel_x), .pixel_y(pixel_y),
        .irq_vblank(irq_vblank), .irq_lcdstat(irq_lcdstat)
    );

    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(cpu_wdata),
                   .we(we), .sel(bm_sel), .late(bm_late), .rdata(bus_rdata));

    task check(input expr, input [8*100:1] label);
        begin
            checks = checks + 1;
            if (expr) $display("PASS  %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s", label);
            end
        end
    endtask

    // ---------------------------------------------------------------------------
    // the scene's registers, as the bus wrote them
    // ---------------------------------------------------------------------------
    reg [7:0] c_lcdc, c_scx, c_scy, c_wy, c_wx, c_bgp, c_obp0, c_obp1;

    function [7:0] vmb(input integer a);
        begin vmb = dut.u_vram.mem[a]; end
    endfunction
    function [7:0] omb(input integer a);
        begin omb = dut.u_oam.mem[a]; end
    endfunction

    // ---------------------------------------------------------------------------
    // the oracle
    // ---------------------------------------------------------------------------
    reg [1:0] exp_shade [0:23039];
    integer   exp_m3    [0:143];
    integer   exp_win_lines;       // lines the window is drawn on, for the report
    integer   exp_sprites_drawn;   // objects selected over the frame, for the report
    integer   exp_over10;          // lines that had more than 10 objects

    // a background or window pixel from a map
    function [1:0] map_px(input integer mapbase, input integer mcol, input integer mrow,
                          input integer frow, input integer fx);
        integer tidx, taddr;
        reg [7:0] lo, hi;
        begin
            tidx = vmb(mapbase + mrow * 32 + mcol);
            if (c_lcdc[4]) taddr = tidx * 16;
            else           taddr = 4096 + ((tidx >= 128) ? (tidx - 256) : tidx) * 16;
            lo = vmb(taddr + frow * 2);
            hi = vmb(taddr + frow * 2 + 1);
            map_px = {hi[7 - fx], lo[7 - fx]};
        end
    endfunction

    // the color of object e at screen x on line l, 0 when it does not cover x
    function [1:0] obj_px(input integer e, input integer l, input integer x);
        integer yy, xx, tile, h, row, c, taddr;
        reg [7:0] a, lo, hi;
        begin
            yy = omb(4*e); xx = omb(4*e+1); tile = omb(4*e+2); a = omb(4*e+3);
            h  = c_lcdc[2] ? 16 : 8;
            obj_px = 2'd0;
            if (x >= xx - 8 && x < xx) begin
                c = x - (xx - 8);
                if (a[5]) c = 7 - c;
                row = l + 16 - yy;
                if (a[6]) row = h - 1 - row;
                if (h == 16) tile = (tile - (tile % 2)) + ((row >= 8) ? 1 : 0);
                taddr = tile * 16 + (row % 8) * 2;
                lo = vmb(taddr);
                hi = vmb(taddr + 1);
                obj_px = {hi[7 - c], lo[7 - c]};
            end
        end
    endfunction

    integer sel_e [0:9];      // objects picked for the line, in oam order
    integer srt_e [0:9];      // the same, stable sorted by x
    integer nsel;
    reg     seen_bg [0:31];   // tile -1 is index 1, so index is tile + 2
    reg     seen_win [0:31];

    task oracle_frame;
        integer l, x, e, i, j, tmp, h, d, xw, win_line, wrow, pen;
        integer px, py, wpx, bgc, ocol, oidx, oattr, winner, xx, xp, p, t, pos, w, iswin;
        reg [1:0] bgcol, oc;
        reg [7:0] pal;
        reg       seen;
        begin
            wrow = 0; exp_win_lines = 0; exp_sprites_drawn = 0; exp_over10 = 0;
            h  = c_lcdc[2] ? 16 : 8;
            xw = c_wx - 7;
            for (l = 0; l < 144; l = l + 1) begin
                // which objects are on the line, the first 10 in oam order
                nsel = 0;
                for (e = 0; e < 40; e = e + 1) begin
                    d = l + 16 - omb(4*e);
                    if (d >= 0 && d < h) begin
                        if (nsel < 10) begin sel_e[nsel] = e; nsel = nsel + 1; end
                        else if (nsel == 10) begin exp_over10 = exp_over10 + 1; nsel = 11; end
                    end
                end
                if (nsel == 11) nsel = 10;
                // the first line after the lcd turns on has no oam scan on
                // hardware, so it has no objects
                if (l == 0) nsel = 0;
                exp_sprites_drawn = exp_sprites_drawn + nsel;
                // stable sort by x, only swap on strictly greater
                for (i = 0; i < nsel; i = i + 1) srt_e[i] = sel_e[i];
                for (i = 0; i < nsel; i = i + 1)
                    for (j = 0; j < nsel - 1 - i; j = j + 1)
                        if (omb(4*srt_e[j] + 1) > omb(4*srt_e[j+1] + 1)) begin
                            tmp = srt_e[j]; srt_e[j] = srt_e[j+1]; srt_e[j+1] = tmp;
                        end

                win_line = (c_lcdc[5] && c_lcdc[0] && c_wy <= l && c_wx <= 166 && c_wx >= 7) ? 1 : 0;
                if (win_line) exp_win_lines = exp_win_lines + 1;

                // the pixels
                for (x = 0; x < 160; x = x + 1) begin
                    // background or window
                    if (!c_lcdc[0]) bgcol = 2'd0;
                    else if (win_line && x >= xw) begin
                        wpx = x - xw;
                        bgcol = map_px(c_lcdc[6] ? 7168 : 6144, wpx / 8, wrow / 8, wrow % 8, wpx % 8);
                    end
                    else begin
                        px = (x + c_scx) % 256;
                        py = (l + c_scy) % 256;
                        bgcol = map_px(c_lcdc[3] ? 7168 : 6144, px / 8, py / 8, py % 8, px % 8);
                    end
                    // the first object, in priority order, with an opaque pixel here
                    oc = 2'd0; oattr = 0;
                    if (c_lcdc[1]) begin
                        for (i = 0; i < nsel; i = i + 1)
                            if (oc == 2'd0) begin
                                oc = obj_px(srt_e[i], l, x);
                                if (oc != 2'd0) oattr = omb(4*srt_e[i] + 3);
                            end
                    end
                    // mix
                    if (oc != 2'd0 && !(oattr[7] && bgcol != 2'd0)) begin
                        pal = oattr[4] ? c_obp1 : c_obp0;
                        exp_shade[l * 160 + x] = pal >> (2 * oc);
                    end
                    else exp_shade[l * 160 + x] = c_bgp >> (2 * bgcol);
                end

                // mode 3 length
                pen = 0;
                for (i = 0; i < 32; i = i + 1) begin seen_bg[i] = 1'b0; seen_win[i] = 1'b0; end
                if (c_lcdc[1]) begin
                    for (i = 0; i < nsel; i = i + 1) begin
                        xx = omb(4*srt_e[i] + 1);
                        if (xx >= 168) begin
                            // never reached, no penalty
                        end
                        else if (xx == 0) begin
                            // the first costs 11, one after it on the same
                            // background tile -1 costs only the 6 of its fetch
                            pen = pen + (seen_bg[1] ? 6 : 11);
                            seen_bg[1] = 1'b1;           // background tile -1
                        end
                        else begin
                            xp = xx - 8;
                            if (win_line && xp >= xw) begin
                                p = xp - xw; iswin = 1;
                                t = p / 8; pos = p % 8;
                            end
                            else begin
                                p = xp + (c_scx % 8); iswin = 0;
                                if (p >= 0) begin t = p / 8; pos = p % 8; end
                                else begin t = -1; pos = p + 8; end   // p is -7 to -1 here
                            end
                            seen = iswin ? seen_win[t + 2] : seen_bg[t + 2];
                            w = seen ? 0 : ((5 - pos) > 0 ? (5 - pos) : 0);
                            pen = pen + w + 6;
                            if (iswin) seen_win[t + 2] = 1'b1; else seen_bg[t + 2] = 1'b1;
                        end
                    end
                end
                exp_m3[l] = 172 + (c_scx % 8) + (win_line ? 6 : 0) + pen;
                if (win_line) wrow = wrow + 1;
            end
        end
    endtask

    // ---------------------------------------------------------------------------
    // capture, from the ppu's own outputs
    // ---------------------------------------------------------------------------
    reg        cap_en;
    reg [1:0]  got_shade [0:23039];
    integer    got_cnt   [0:23039];
    integer    got_m3    [0:143];
    always @(posedge clk) begin
        if (cap_en) begin
            if (pixel_valid && pixel_y < 144 && pixel_x < 160) begin
                got_shade[pixel_y * 160 + pixel_x] = pixel_shade;
                got_cnt  [pixel_y * 160 + pixel_x] = got_cnt[pixel_y * 160 + pixel_x] + 1;
            end
            if (dut.mode == 2'd3 && dut.ly < 144)
                got_m3[dut.ly] = got_m3[dut.ly] + 1;
        end
    end

    // ---------------------------------------------------------------------------
    // building a scene
    // ---------------------------------------------------------------------------
    reg [31:0] seed;
    function integer rnd(input integer n);   // 0 to n-1
        begin rnd = ($random(seed) & 32'h7FFFFFFF) % n; end
    endfunction

    integer wopt, sopt, topt, dopt, eopt, bopt, fopt;   // window, objects, tall, density, edge-biased x, background, window at pixel 0

    task build_scene;
        integer i, n, band, y0, k;
        reg [7:0] lcdc_v;
        begin
            // vram: tile data and maps all random
            for (i = 0; i < 8192; i = i + 1) dut.u_vram.mem[i] = rnd(256);
            // bias a share of tile bytes to zero so there is plenty of color 0 to be in front of
            for (i = 0; i < 6144; i = i + 1) if (rnd(4) == 0) dut.u_vram.mem[i] = 8'h00;
            for (i = 6144; i < 8192; i = i + 1) dut.u_vram.mem[i] = rnd(256);

            // oam
            n = 40;
            band = (dopt == 1) ? 14 : 150;        // dense scenes cram objects into a few lines
            y0   = 30 + rnd(80);
            for (i = 0; i < n; i = i + 1) begin
                if (dopt == 1) dut.u_oam.mem[4*i] = y0 + 16 - 4 + rnd(band);
                else           dut.u_oam.mem[4*i] = 8 + rnd(160);
                k = rnd(10);
                if (eopt == 1) begin
                    case (k)
                        0, 1: dut.u_oam.mem[4*i+1] = rnd(10);              // the left edge, x = 0 included
                        2, 3: dut.u_oam.mem[4*i+1] = 150 + rnd(20);        // the right edge, 168 and up included
                        default: dut.u_oam.mem[4*i+1] = rnd(256);
                    endcase
                end
                else begin
                    if (k < 7) dut.u_oam.mem[4*i+1] = 8 + rnd(160);        // on screen
                    else       dut.u_oam.mem[4*i+1] = rnd(256);
                end
                // equal x now and then, to exercise the oam order tie break
                if (i > 0 && rnd(6) == 0) dut.u_oam.mem[4*i+1] = dut.u_oam.mem[4*(i-1)+1];
                dut.u_oam.mem[4*i+2] = rnd(256);
                dut.u_oam.mem[4*i+3] = rnd(256);
            end

            // registers
            lcdc_v = rnd(256);
            lcdc_v[7] = 1'b1;
            lcdc_v[0] = (rnd(10) != 0);                       // the background is mostly on
            if (bopt == 1) lcdc_v[0] = 1'b0;                  // forced off
            if (bopt == 2) lcdc_v[0] = 1'b1;                  // forced on
            lcdc_v[4] = rnd(2);
            case (wopt) 0: lcdc_v[5] = 1'b0;  1: lcdc_v[5] = 1'b1;  default: lcdc_v[5] = (rnd(4) != 0); endcase
            case (sopt) 0: lcdc_v[1] = 1'b0;  1: lcdc_v[1] = 1'b1;  default: lcdc_v[1] = (rnd(6) != 0); endcase
            case (topt) 0: lcdc_v[2] = 1'b0;  1: lcdc_v[2] = 1'b1;  default: lcdc_v[2] = rnd(2);        endcase
            c_lcdc = lcdc_v;
            c_scx  = rnd(256);
            c_scy  = rnd(256);
            c_wy   = (rnd(5) == 0) ? 8'd0 : rnd(110);
            c_wx   = (rnd(8) == 0) ? (167 + rnd(89)) : (7 + rnd(160));   // 7 to 166, sometimes 167 and up
            if (rnd(12) == 0) c_wx = 8'd7;
            if (rnd(20) == 0) c_wx = 8'd165;
            c_bgp  = rnd(256);
            c_obp0 = rnd(256);
            c_obp1 = rnd(256);

            // the window starting on pixel 0 with objects crowded around the
            // left edge. scx & 7 is 7 so the object at x = 1 lands on the
            // first tile, the same tile number the object at x = 8 takes in
            // the window, which is the case that needs the tile's window or
            // background kind to tell them apart
            if (fopt == 1) begin
                c_wx = 8'd7;
                c_wy = 8'd0;
                c_scx[2:0] = 3'd7;
                c_lcdc[5] = 1'b1; c_lcdc[1] = 1'b1; c_lcdc[0] = 1'b1;
                dut.u_oam.mem[0] = 8'd80; dut.u_oam.mem[1] = 8'd1;
                dut.u_oam.mem[4] = 8'd80; dut.u_oam.mem[5] = 8'd8;
                dut.u_oam.mem[8] = 8'd80; dut.u_oam.mem[9] = 8'd2;
                dut.u_oam.mem[12] = 8'd80; dut.u_oam.mem[13] = 8'd9;
                dut.u_oam.mem[16] = 8'd80; dut.u_oam.mem[17] = 8'd7;
                dut.u_oam.mem[20] = 8'd80; dut.u_oam.mem[21] = 8'd16;
            end
        end
    endtask

    integer pcount, bad_px, bad_dup, bad_m3, shown, ll, xx2;
    integer scenes_run, total_win_lines, total_over10, total_drawn;

    task run_scene(input [8*64:1] name);
        integer i, expw;
        begin
            // lcd off so everything can be loaded
            bm.write(16'hFF40, 8'h00);
            build_scene;
            bm.write(16'hFF42, c_scy);
            bm.write(16'hFF43, c_scx);
            bm.write(16'hFF4A, c_wy);
            bm.write(16'hFF4B, c_wx);
            bm.write(16'hFF47, c_bgp);
            bm.write(16'hFF48, c_obp0);
            bm.write(16'hFF49, c_obp1);
            oracle_frame;

            for (i = 0; i < 23040; i = i + 1) begin got_shade[i] = 2'bxx; got_cnt[i] = 0; end
            for (i = 0; i < 144; i = i + 1) got_m3[i] = 0;
            cap_en = 1'b1;
            bm.write(16'hFF40, c_lcdc);
            // run until the frame has been drawn
            @(negedge clk);
            while (dut.ly < 8'd144) @(negedge clk);
            cap_en = 1'b0;

            bad_px = 0; bad_dup = 0; bad_m3 = 0; shown = 0;
            for (i = 0; i < 23040; i = i + 1) begin
                if (got_cnt[i] !== 1) bad_dup = bad_dup + 1;
                if (got_shade[i] !== exp_shade[i]) begin
                    bad_px = bad_px + 1;
                    if (shown < 4) begin
                        $display("      %0s: pixel x=%0d y=%0d got shade %0d expected %0d", name, i % 160, i / 160, got_shade[i], exp_shade[i]);
                        shown = shown + 1;
                    end
                end
            end
            shown = 0;
            for (i = 0; i < 144; i = i + 1)
                if (got_m3[i] !== exp_m3[i]) begin
                    bad_m3 = bad_m3 + 1;
                    if (shown < 4) begin
                        $display("      %0s: line %0d mode 3 lasted %0d dots, expected %0d", name, i, got_m3[i], exp_m3[i]);
                        shown = shown + 1;
                    end
                end
            checks = checks + 1;
            if (bad_px === 0 && bad_dup === 0 && bad_m3 === 0)
                $display("PASS  %0s: 23040 pixels and 144 mode 3 lengths match (lcdc %02h scx %0d wx %0d wy %0d, %0d window lines, %0d lines over 10 objects)",
                          name, c_lcdc, c_scx, c_wx, c_wy, exp_win_lines, exp_over10);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s: %0d wrong pixels, %0d pixels not drawn exactly once, %0d wrong mode 3 lengths (lcdc %02h scx %0d wx %0d wy %0d)",
                          name, bad_px, bad_dup, bad_m3, c_lcdc, c_scx, c_wx, c_wy);
            end
            scenes_run = scenes_run + 1;
            total_win_lines = total_win_lines + exp_win_lines;
            total_over10 = total_over10 + exp_over10;
            total_drawn = total_drawn + exp_sprites_drawn;
        end
    endtask

    integer sc, nrand;
    initial begin
        seed = 32'h0B1EC7ED;
        cap_en = 1'b0; rst = 1'b1;
        scenes_run = 0; total_win_lines = 0; total_over10 = 0; total_drawn = 0;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // directed
        bopt = 2; fopt = 0;
        wopt = 1; sopt = 0; topt = 0; dopt = 0; eopt = 0;  run_scene("window alone");
        bopt = 0;
        wopt = 0; sopt = 1; topt = 0; dopt = 0; eopt = 0;  run_scene("objects alone, 8 x 8");
        wopt = 0; sopt = 1; topt = 1; dopt = 0; eopt = 0;  run_scene("objects alone, 8 x 16");
        wopt = 1; sopt = 1; topt = 2; dopt = 0; eopt = 0;  run_scene("window and objects");
        wopt = 0; sopt = 1; topt = 2; dopt = 1; eopt = 0;  run_scene("crowded lines, over 10 objects");
        wopt = 2; sopt = 1; topt = 2; dopt = 0; eopt = 1;  run_scene("objects at the left and right edges");
        wopt = 1; sopt = 1; topt = 2; dopt = 1; eopt = 1;  run_scene("window, crowded, edges");
        // the window on pixel 0 with objects at the left edge
        bopt = 2; fopt = 1;
        wopt = 1; sopt = 1; topt = 0; dopt = 0; eopt = 1;  run_scene("window on pixel 0, objects at the left edge");
        fopt = 0;
        // lcdc bit 0 clear blanks the background and the window, objects still show
        bopt = 1;
        wopt = 1; sopt = 1; topt = 2; dopt = 0; eopt = 0;  run_scene("background off, window enabled, objects");
        bopt = 0;

        // random. +random=N on the command line runs N random scenes instead of 13
        wopt = 2; sopt = 2; topt = 2;
        if (!$value$plusargs("random=%d", nrand)) nrand = 13;
        for (sc = 0; sc < nrand; sc = sc + 1) begin
            dopt = rnd(3) == 0; eopt = rnd(2);
            run_scene("random scene");
        end

        $display("");
        $display("      %0d scenes, %0d window lines, %0d lines that had over 10 objects, %0d objects picked in all",
                  scenes_run, total_win_lines, total_over10, total_drawn);
        check(total_win_lines > 300, "premise: the scenes between them drew the window on over 300 lines");
        check(total_over10 > 30, "premise: the scenes between them had more than 10 objects on over 30 lines");
        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - window and sprites verified against the oracle, pixels and mode 3 lengths", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule
