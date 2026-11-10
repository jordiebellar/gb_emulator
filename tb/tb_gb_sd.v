// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_gb_sd.v
// Author       : Aaron Luebbert
// Date         : 2026-11-09
// Description  : tb_gb_boot with the cartridge on an sd card. gb_top runs with
//                  SD_MODE = 1 and a behavioral card (sd_model) holds the rom
//                  image, so the whole path is exercised - card bring up, the
//                  bank 0 load, cache misses that pause the clock enables, the
//                  mapper, cart ram and the mbc3 clock. it stops on a mooneye
//                  verdict or a blargg style Passed/Failed on the serial port,
//                  and at the end prints how many sectors the card served and
//                  how long the machine sat paused.
//
//                  build from the repo root with a --binary --timing build of
//                  the files below, top module tb_gb_sd, then run the binary
//                  with +stub +img=game.gb
//                    tb/tb_gb_sd.v tb/cartridge/sd_model.v rtl/gb_top.v
//                    rtl/cpu/*.v rtl/timer/*.v rtl/clocking/*.v rtl/memory/*.v
//                    rtl/cartridge/*.v rtl/joypad/joypad.v rtl/ppu/*.v
//                  the image path must be short and relative, copy the rom next
//                  to the binary if needed
//
//                  plus arguments
//                    +img=file    raw rom image, written to the card from sector 0
//                    +stub        stand in boot rom, as in tb_gb_boot
//                    +frames=n    stop after n vblanks, default 400
//                    +every=n     dump a frame every n vblanks, default 100000
//                    +mooneye     stop on ld b,b with the mooneye verdict
//                    +mon         print a status line now and then
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_gb_sd;

    reg clk = 1'b0;
    reg rst = 1'b1;
    always #5 clk = ~clk;

    wire [3:0] vga_r, vga_g, vga_b;
    wire       hs, vs, lcd_on;
    wire [15:0] a;
    wire [7:0]  d, din, ie, ifr;
    wire        we, dma;

    wire sd_cs_n, sd_sck, sd_mosi, sd_miso;
    wire [2:0] cart_status;

    sd_model #(.SECTORS(16384), .SDHC(1), .IDLE_ACMDS(3), .NCR(2)) card (
        .sck(sd_sck), .cs_n(sd_cs_n), .mosi(sd_mosi), .miso(sd_miso));

    gb_top #(
        .BOOT_ROM_FILE("roms/boot/boot_rom.hex"),
        .CART_ROM_FILE("roms/game/cart_rom.hex"),
        .SD_MODE(1), .RAM_BYTES(32768), .CACHE_LINES(64),
        .SD_DIV_SLOW(4), .SD_DIV_FAST(2), .SD_PWR_CLKS(1000), .RTC_TICKS(100000)
    ) dut (
        .clk_100m(clk), .rst(rst),
        .btn_right(1'b0), .btn_left(1'b0), .btn_up(1'b0), .btn_down(1'b0),
        .btn_a(1'b0), .btn_b(1'b0), .btn_select(1'b0), .btn_start(1'b0),
        .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b), .vga_hsync(hs), .vga_vsync(vs),
        .lcd_on(lcd_on),
        .sd_cs_n(sd_cs_n), .sd_sck(sd_sck), .sd_mosi(sd_mosi), .sd_miso(sd_miso), .cart_status(cart_status),
        .debug_cpu_addr(a), .debug_cpu_data_out(d), .debug_cpu_we(we),
        .debug_bus_data_in(din), .debug_ie(ie), .debug_if_reg(ifr), .debug_dma_active(dma)
    );

    // ------------------------------------------------------------------------
    // plus arguments and the stand in boot rom
    // ------------------------------------------------------------------------
    integer max_frames = 400, dump_every = 100000, after_boot = 150;
    integer img_fd, img_n;
    reg [1023:0] img_name;
    reg use_stub = 1'b0;
    reg [1023:0] cart_name, boot_name;
    integer n;

    task stub_byte(input [7:0] addr, input [7:0] v);
        begin dut.u_cartridge.boot_rom[addr] = v; end
    endtask

    initial begin
        #1;
        if ($value$plusargs("img=%s", img_name)) begin
            img_fd = $fopen(img_name, "rb");
            img_n  = $fread(card.img, img_fd);
            $fclose(img_fd);
            $display("image loaded, %0d bytes", img_n);
        end
        if ($test$plusargs("stub")) begin
            use_stub = 1'b1;
            for (n = 0; n < 256; n = n + 1) stub_byte(n, 8'h00);
            // 0000  ld sp,fffe
            stub_byte(8'h00, 8'h31); stub_byte(8'h01, 8'hFE); stub_byte(8'h02, 8'hFF);
            // 0003  ld a,fc / ldh (47),a        bgp as the boot rom leaves it
            stub_byte(8'h03, 8'h3E); stub_byte(8'h04, 8'hFC);
            stub_byte(8'h05, 8'hE0); stub_byte(8'h06, 8'h47);
            // 0007  ld a,91 / ldh (40),a        lcd on, bg on, tile data 8000
            stub_byte(8'h07, 8'h3E); stub_byte(8'h08, 8'h91);
            stub_byte(8'h09, 8'hE0); stub_byte(8'h0A, 8'h40);
            // 000b  jp 00fc
            stub_byte(8'h0B, 8'hC3); stub_byte(8'h0C, 8'hFC); stub_byte(8'h0D, 8'h00);
            // 00fc  ld a,01 / ldh (50),a        unmap, then the cartridge at 0100
            stub_byte(8'hFC, 8'h3E); stub_byte(8'hFD, 8'h01);
            stub_byte(8'hFE, 8'hE0); stub_byte(8'hFF, 8'h50);
        end
        else if ($value$plusargs("boot=%s", boot_name)) $readmemh(boot_name, dut.u_cartridge.boot_rom);
        if ($value$plusargs("frames=%d", max_frames)) ;
        if ($value$plusargs("every=%d", dump_every)) ;
        if ($value$plusargs("after=%d", after_boot)) ;
    end

    // ------------------------------------------------------------------------
    // the lcd, as the ppu draws it
    // ------------------------------------------------------------------------
    reg [1:0] fb [0:23039];
    integer k;
    initial for (k = 0; k < 23040; k = k + 1) fb[k] = 2'd0;

    always @(posedge clk)
        if (dut.pixel_valid && dut.pixel_x < 8'd160 && dut.pixel_y < 8'd144)
            fb[dut.pixel_y * 160 + dut.pixel_x] <= dut.pixel_shade;

    integer frame = 0, boot_frame = -1, fd, x, y;
    reg boot_d = 1'b1;

    task dump(input [255:0] name);
        begin
            fd = $fopen(name, "w");
            $fwrite(fd, "P2\n160 144\n3\n");
            for (y = 0; y < 144; y = y + 1) begin
                for (x = 0; x < 160; x = x + 1)
                    $fwrite(fd, "%0d ", 3 - fb[y * 160 + x]);
                $fwrite(fd, "\n");
            end
            $fclose(fd);
        end
    endtask

    reg [255:0] fname;

    // mooneye tests end on ld b,b with their result in the registers
    reg mooneye = 1'b0;
    initial begin
        #1;
        if ($test$plusargs("mooneye")) mooneye = 1'b1;
    end

    always @(posedge clk) begin
        if (mooneye && !rst && dut.u_cpu.ir == 8'h40 && dut.u_cpu.state == 4'd2) begin
            if ({dut.u_cpu.b, dut.u_cpu.c, dut.u_cpu.d, dut.u_cpu.e, dut.u_cpu.h, dut.u_cpu.l} == 48'h03_05_08_0D_15_22)
                $display("MOONEYE PASS at frame %0d", frame);
            else if ({dut.u_cpu.b, dut.u_cpu.c, dut.u_cpu.d, dut.u_cpu.e, dut.u_cpu.h, dut.u_cpu.l} == {6{8'h42}})
                $display("MOONEYE FAIL at frame %0d", frame);
            else
                $display("MOONEYE ODD regs %h %h %h %h %h %h at frame %0d",
                         dut.u_cpu.b, dut.u_cpu.c, dut.u_cpu.d, dut.u_cpu.e, dut.u_cpu.h, dut.u_cpu.l, frame);
            dump("frames/frame_last.pgm");
            $display("STATS sd_reads=%0d stall_clks=%0d status=%b", card.reads, stall_clks, cart_status);
            $finish;
        end
    end

    integer stall_clks = 0;
    integer mon_n = 0;
    reg mon_on = 1'b0;
    initial begin #1; if ($test$plusargs("mon")) mon_on = 1'b1; end
    always @(posedge clk) begin
        mon_n <= mon_n + 1;
        if (mon_on && mon_n % 2000000 == 0)
            $display("MONITOR t=%0t frame=%0d addr=%h stall=%b status=%b fst=%0d reads=%0d bank=%0d kind=%0d",
                     $time, frame, a, dut.cart_stall, cart_status, dut.u_cartridge.g_sd.f_st, card.reads,
                     dut.u_cartridge.rom_bank, dut.u_cartridge.kind);
    end
    always @(posedge clk) if (!rst && dut.cart_stall) stall_clks = stall_clks + 1;


    // debug trace of the length of mode 3 on every line
    reg trace3 = 1'b0;
    initial begin #1; if ($test$plusargs("trace3")) trace3 = 1'b1; end
    reg [8:0] m3_start;
    reg [1:0] prev_mode = 2'd0;
    always @(posedge clk) if (dut.ce_gb) begin
        prev_mode <= dut.u_ppu.mode;
        if (dut.u_ppu.mode == 2'd3 && prev_mode != 2'd3) m3_start <= dut.u_ppu.dot_counter;
        if (trace3 && dut.u_ppu.mode != 2'd3 && prev_mode == 2'd3)
            $display("m3 ly=%0d start=%0d end=%0d len=%0d", dut.u_ppu.ly, m3_start, dut.u_ppu.dot_counter, dut.u_ppu.dot_counter - m3_start);
    end

    // debug trace of stat and ly reads and writes with the ppu dot counter
    reg trace = 1'b0;
    initial begin #1; if ($test$plusargs("trace")) trace = 1'b1; end
    always @(posedge clk)
        if (trace && !rst && dut.ce_m && (a == 16'hFF41 || a == 16'hFF44 || a == 16'hFF0F || a == 16'hFF40 || a == 16'hFF45 || a == 16'hFF04) )
            $display("t=%0t %s %h addr=%h data=%h ly=%0d dot=%0d mode=%0d", $time, we ? "W" : "R", we ? d : din, a, d, dut.u_ppu.ly, dut.u_ppu.dot_counter, dut.u_ppu.mode);

    always @(posedge clk) begin
        boot_d <= rst ? 1'b1 : dut.u_cartridge.boot_active;
        if (!rst && boot_d && !dut.u_cartridge.boot_active) begin
            boot_frame = frame;
            $display("boot rom unmapped at frame %0d, time %0t, sys_cnt %h", frame, $time, dut.u_timer.sys_cnt);
        end
        if (dut.irq_vblank && dut.ce_gb) begin
            frame = frame + 1;
            if (frame % dump_every == 0) begin
                $sformat(fname, "frames/frame_%0d.pgm", frame);
                dump(fname);
            end
            if (frame >= max_frames || (!use_stub && boot_frame >= 0 && frame >= boot_frame + after_boot)) begin
                dump("frames/frame_last.pgm");
                $display("stopping at frame %0d, boot handoff frame %0d, cpu at %h", frame, boot_frame, a);
                $display("STATS sd_reads=%0d stall_clks=%0d status=%b", card.reads, stall_clks, cart_status);
                $finish;
            end
        end
    end

    // blargg serial. the rom writes a char to sb (ff01), then 81 to sc (ff02).
    // the cpu commits writes on ce_m, so sample there. stops on "Passed" or
    // "Failed" so a run takes only as long as the test does
    reg [7:0]  sb = 8'h00;
    reg [47:0] last6 = 48'd0;
    always @(posedge clk) begin
        if (!rst && dut.ce_m && we) begin
            if (a == 16'hFF01) sb <= d;
            if (a == 16'hFF02 && d == 8'h81) begin
                $write("%c", sb);
                $fflush;
                last6 <= {last6[39:0], sb};
                if ({last6[39:0], sb} == "Passed" || {last6[39:0], sb} == "Failed") begin
                    $display("\nBLARGG done at frame %0d", frame);
                    $display("STATS sd_reads=%0d stall_clks=%0d status=%b", card.reads, stall_clks, cart_status);
                    dump("frames/frame_last.pgm");
                    $finish;
                end
            end
        end
    end

    initial begin
        repeat (8) @(posedge clk);
        rst = 1'b0;
    end

endmodule
