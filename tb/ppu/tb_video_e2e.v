// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_video_e2e.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : end to end test of the whole picture path. everything runs
//                  on the real enables from clk_div: ce_gb about one clock
//                  in 24, ce_m one in four of those, ce_vga one in four. the
//                  bus master programs tile data, a tile map, scroll, and
//                  the palette through the real memory_map into the ppu, the
//                  lcd is turned on, the ppu fetches and draws, pixels pass
//                  through bgp into the framebuffer, and video scans it out.
//                  one full 640 x 480 frame is captured off the vga outputs
//                  and compared pixel for pixel with an expected image
//                  worked out from the vram contents with a closed form
//                  rendering rule, a reversed bgp, and the green palette.
//
//                  this is the first test where the ppu runs on the real,
//                  sparse ce_gb. it also checks the framebuffer's write
//                  enable, over every ppu frame that completes, fires
//                  exactly once for each of the 23040 pixels and nowhere
//                  else, and that turning the lcd off blanks the screen.
//
//                  the picture is found from the sync pulses alone, as a
//                  monitor does, see tb_video.v.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_video_e2e;

    reg clk;
    reg rst;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        #150000000;
        $display("TIMEOUT");
        $finish;
    end

    // --- the real enables ------------------------------------------------------
    wire ce_gb, ce_m, ce_vga;
    clk_div u_clk (.clk_100m(clk), .rst(rst), .ce_gb(ce_gb), .ce_m(ce_m), .ce_vga(ce_vga));

    // --- cpu side: the bus master through the real memory_map ------------------
    wire [15:0] addr;
    wire [7:0]  cpu_wdata;
    wire        we, bm_sel, bm_late;
    wire [7:0]  bus_rdata;

    wire sel_cart_rom, sel_boot_disable, sel_cart_ram, sel_wram;
    wire sel_ppu_vram, sel_ppu_oam, sel_ppu_reg, sel_oam_dma;
    wire sel_joypad, sel_serial, sel_timer, sel_interrupt_ctrl, sel_apu, sel_hram;
    wire [7:0] ppu_vram_data_out, ppu_oam_data_out, ppu_reg_data_out;
    wire [7:0] oam_render_data;

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

    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(cpu_wdata),
                   .we(we), .sel(bm_sel), .late(bm_late), .rdata(bus_rdata));

    // --- the ppu and the video side --------------------------------------------
    wire       pixel_valid, lcd_on, irq_vblank, irq_lcdstat;
    wire [1:0] pixel_color, pixel_shade;
    wire [7:0] pixel_x, pixel_y;

    ppu u_ppu (
        .clk(clk), .ce_gb(ce_gb), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(cpu_wdata), .we(we),
        .sel_ppu_vram(sel_ppu_vram), .ppu_vram_data_out(ppu_vram_data_out),
        .sel_ppu_oam(sel_ppu_oam),   .ppu_oam_data_out(ppu_oam_data_out),
        .sel_ppu_reg(sel_ppu_reg),   .ppu_reg_data_out(ppu_reg_data_out),
        .dma_active(1'b0),
        .oam_render_addr(8'h00), .oam_render_data(oam_render_data),
        .pixel_valid(pixel_valid), .pixel_color(pixel_color),
        .pixel_shade(pixel_shade), .lcd_on(lcd_on),
        .pixel_x(pixel_x), .pixel_y(pixel_y),
        .irq_vblank(irq_vblank), .irq_lcdstat(irq_lcdstat)
    );

    wire [3:0] vga_r, vga_g, vga_b;
    wire       vga_hsync, vga_vsync;

    video #(.GREEN(1)) u_video (
        .clk(clk), .ce_gb(ce_gb), .ce_vga(ce_vga), .rst(rst),
        .lcd_on(lcd_on),
        .pixel_valid(pixel_valid), .pixel_x(pixel_x), .pixel_y(pixel_y),
        .pixel_shade(pixel_shade),
        .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b),
        .vga_hsync(vga_hsync), .vga_vsync(vga_vsync)
    );

    integer errors = 0;
    integer checks = 0;

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

    // --- the expected picture ------------------------------------------------------
    // lcdc 0x91: map at 0x9800, tiles unsigned from 0x8000, background on.
    // scx 3, scy 5. bgp 0x1B reverses the shades, so shade = 3 - color index.
    localparam SCX = 3;
    localparam SCY = 5;

    function [11:0] pal(input [1:0] s);
        begin
            case (s)
                2'd0:    pal = 12'h9B0;
                2'd1:    pal = 12'h8A0;
                2'd2:    pal = 12'h363;
                default: pal = 12'h030;
            endcase
        end
    endfunction

    function [1:0] ref_idx(input integer x, input integer y);
        integer yy, px, tidx, doff, lo, hi, bitn;
        begin
            yy   = (y + SCY) % 256;
            px   = (x + SCX) % 256;
            tidx = u_ppu.u_vram.mem['h1800 + (yy / 8) * 32 + (px / 8)];
            doff = tidx * 16;
            lo   = u_ppu.u_vram.mem[doff + (yy % 8) * 2];
            hi   = u_ppu.u_vram.mem[doff + (yy % 8) * 2 + 1];
            bitn = 7 - (px % 8);
            ref_idx = {hi[bitn], lo[bitn]};
        end
    endfunction

    reg [1:0] exp_fb [0:23039];

    function [11:0] expected(input integer row, input integer col, input lcd);
        integer fxx, fyy;
        begin
            if (row >= 24 && row < 456 && col >= 80 && col < 560) begin
                fxx = (col - 80) / 3;
                fyy = (row - 24) / 3;
                expected = lcd ? pal(2'd3 - exp_fb[fyy * 160 + fxx]) : pal(2'd0);
            end
            else expected = 12'h000;
        end
    endfunction

    // --- capture, found from the sync pulses alone -----------------------------------
    reg [11:0] cap [0:307199];
    reg        cap_arm, cap_done;
    integer    cap_rows;
    integer    k, since_fall;
    reg        vs_seen, prev_hs, prev_vs, hs_s, vs_s, in_active;
    reg [11:0] rgb_s;
    integer    row_i, col_i;
    integer    blank_nonzero;

    always @(posedge clk) begin
        if (ce_vga && cap_arm) begin
            hs_s  = vga_hsync;
            vs_s  = vga_vsync;
            rgb_s = {vga_r, vga_g, vga_b};

            if (prev_vs === 1'b1 && vs_s === 1'b0) begin
                k = -1;
                vs_seen = 1'b1;
            end
            if (prev_hs === 1'b1 && hs_s === 1'b0) begin
                if (vs_seen) k = k + 1;
                since_fall = 0;
            end
            else since_fall = since_fall + 1;

            in_active = vs_seen && (k >= 34) && (k <= 34 + 479) &&
                        (since_fall >= 144) && (since_fall < 144 + 640);

            if (in_active) begin
                row_i = k - 34;
                col_i = since_fall - 144;
                if (row_i < cap_rows) begin
                    cap[row_i * 640 + col_i] = rgb_s;
                    if (row_i == cap_rows - 1 && col_i == 639) cap_done = 1'b1;
                end
            end
            else if (vs_seen) begin
                if (rgb_s !== 12'h000) blank_nonzero = blank_nonzero + 1;
            end

            prev_hs = hs_s;
            prev_vs = vs_s;
        end
    end

    task start_capture(input integer nrows);
        integer i;
        begin
            for (i = 0; i < 307200; i = i + 1) cap[i] = 12'hxxx;
            cap_rows = nrows;
            cap_done = 1'b0;
            vs_seen  = 1'b0;
            k = -1;
            since_fall = 100000;
            prev_hs = 1'b1; prev_vs = 1'b1;
            blank_nonzero = 0;
            cap_arm = 1'b1;
        end
    endtask

    task wait_capture;
        begin
            while (!cap_done) @(negedge clk);
        end
    endtask

    // --- the framebuffer write monitor: every ppu frame must write each pixel once ----
    integer wcount [0:23039];
    integer frames_done, frames_bad, writes_this_frame, writes_off_screen;
    integer wi, bad_in_frame, waddr;

    always @(posedge clk) begin
        // the framebuffer's own write enable, as the framebuffer sees it
        if (u_video.u_fb.we) begin
            if (u_video.u_fb.w_ok) begin
                waddr = u_video.u_fb.wy * 160 + u_video.u_fb.wx;
                wcount[waddr] = wcount[waddr] + 1;
                writes_this_frame = writes_this_frame + 1;
            end
            else writes_off_screen = writes_off_screen + 1;
        end
        // a frame is complete at the vblank strobe, which is gated by ce_gb
        if (irq_vblank && frame_mon) begin
            bad_in_frame = 0;
            for (wi = 0; wi < 23040; wi = wi + 1) begin
                if (wcount[wi] !== 1) bad_in_frame = bad_in_frame + 1;
                wcount[wi] = 0;
            end
            if (frames_done > 0) begin   // the first strobe ends a partial window, skip it
                if (bad_in_frame != 0 || writes_this_frame != 23040) frames_bad = frames_bad + 1;
            end
            frames_done = frames_done + 1;
            writes_this_frame = 0;
        end
    end
    reg frame_mon;

    // --- the run ---------------------------------------------------------------------------
    integer i, a, x, nbad, nx, shown, r, c;
    integer h0, h1, h2, h3;
    reg [31:0] lfsr;
    reg [11:0] e;

    task compare_rows(input integer nrows, input lcd, input [8*40:1] what);
        begin
            nbad = 0; nx = 0; shown = 0;
            for (r = 0; r < nrows; r = r + 1)
                for (c = 0; c < 640; c = c + 1) begin
                    e = expected(r, c, lcd);
                    if (^cap[r * 640 + c] === 1'bx) nx = nx + 1;
                    if (cap[r * 640 + c] !== e) begin
                        nbad = nbad + 1;
                        if (shown < 4) begin
                            $display("      mismatch %0s row %0d col %0d: got %h expected %h",
                                      what, r, c, cap[r * 640 + c], e);
                            shown = shown + 1;
                        end
                    end
                end
        end
    endtask

    initial begin
        rst = 1'b1; cap_arm = 1'b0; cap_done = 1'b0; cap_rows = 480; vs_seen = 1'b0;
        k = -1; since_fall = 100000; prev_hs = 1'b1; prev_vs = 1'b1; blank_nonzero = 0;
        frame_mon = 1'b0; frames_done = 0; frames_bad = 0;
        writes_this_frame = 0; writes_off_screen = 0;
        for (i = 0; i < 23040; i = i + 1) wcount[i] = 0;

        repeat (6) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // program tile data, a tile map, scroll, and the palette over the bus.
        // the lcd is still off, so vram is freely writable
        lfsr = 32'hFACE0FF5;
        for (a = 0; a < 64; a = a + 1) begin
            for (x = 0; x < 8; x = x + 1)
                lfsr = {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
            bm.write(16'h8000 + a, lfsr[7:0]);          // tiles 0 to 3, 16 bytes each
        end
        for (a = 0; a < 1024; a = a + 1) begin
            for (x = 0; x < 8; x = x + 1)
                lfsr = {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
            bm.write(16'h9800 + a, {6'b0, lfsr[1:0]});  // every map entry a tile 0 to 3
        end
        bm.write(16'hFF42, SCY);
        bm.write(16'hFF43, SCX);
        bm.write(16'hFF47, 8'h1B);

        // the expected picture, from what is really in vram
        for (i = 0; i < 23040; i = i + 1)
            exp_fb[i] = ref_idx(i % 160, i / 160);

        // the expected picture has to be a real test, not a flat color
        h0 = 0; h1 = 0; h2 = 0; h3 = 0;
        for (i = 0; i < 23040; i = i + 1)
            case (exp_fb[i])
                2'd0: h0 = h0 + 1;
                2'd1: h1 = h1 + 1;
                2'd2: h2 = h2 + 1;
                default: h3 = h3 + 1;
            endcase
        $display("      expected picture, color index counts: 0:%0d 1:%0d 2:%0d 3:%0d", h0, h1, h2, h3);
        check(h0 > 3000 && h1 > 3000 && h2 > 3000 && h3 > 3000,
              "premise: the expected picture uses all four colors, each over 3000 pixels");

        // lcd on, and let the first ppu frame finish
        bm.write(16'hFF40, 8'h91);
        frame_mon = 1'b1;
        while (frames_done < 1) @(negedge clk);

        // capture one full frame off the vga outputs. the picture is static
        // so any frame after the first complete ppu frame is the same
        start_capture(480);
        wait_capture;
        compare_rows(480, 1'b1, "lcd on");
        check(nx === 0, "every captured pixel is a known value, none are x");
        check(nbad === 0, "all 307200 pixels match: vram through the ppu, bgp, framebuffer, and scan-out");
        check(blank_nonzero === 0, "every pixel of blanking time seen during the frame is black");
        cap_arm = 1'b0;

        // the write monitor has been running over every complete ppu frame
        check(frames_done >= 2, "more than one ppu frame completed while the picture was captured");
        check(frames_bad === 0, "every complete ppu frame wrote each of the 23040 pixels exactly once");
        check(writes_off_screen === 0, "no write was ever attempted outside the 160 x 144 screen");

        // lcd off: the screen goes blank
        bm.write(16'hFF40, 8'h00);
        start_capture(40);
        wait_capture;
        compare_rows(40, 1'b0, "lcd off");
        check(nx === 0, "lcd off: every captured pixel is a known value");
        check(nbad === 0, "lcd off: the picture area is the blank shade and the border is black");
        cap_arm = 1'b0;

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - the whole picture path verified end to end on the real enables", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule