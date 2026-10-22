// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_gb_boot.v
// Author       : Aaron Luebbert
// Date         : 2026-10-20
// Description  : runs a cartridge on gb_top and writes the lcd out as pgm
//                  images so the picture can be looked at. by default it runs
//                  the real dmg boot rom into the cartridge. nothing here is
//                  checked against a model, this is a look at the whole
//                  machine working. with the real boot rom it reports the
//                  frame the boot rom unmaps itself on, which is the
//                  strongest single sign that the cpu, bus, ppu and
//                  interrupts are all right, because the boot rom checks the
//                  cartridge logo and header checksum before it will hand off.
//
//                  run with verilator, iverilog is too slow for this one. from
//                  the repo root, with a frames folder next to roms
//                    mkdir -p frames
//                    build: verilator --binary --timing -Wno-fatal -Wno-lint
//                      -Wno-style -Wno-WIDTH --top-module tb_gb_boot
//                      -o gbboot tb/tb_gb_boot.v rtl/gb_top.v rtl/*/*.v
//                    obj_dir/gbboot
//                  the hex files need unix line endings under verilator, and
//                  roms/boot/boot_rom.hex and roms/game/cart_rom.hex are read
//                  from the folder it runs in unless told otherwise.
//
//                  plus arguments
//                    +cart=file   cartridge hex, one byte a line
//                    +boot=file   boot rom hex
//                    +stub        use a small stand in boot rom, it sets sp,
//                                 bgp and lcdc the way the real one leaves
//                                 them, unmaps itself, and falls into 0x0100.
//                                 for test roms that do not need the 6 minute
//                                 boot
//                    +frames=n    stop after n vblanks, default 400
//                    +every=n     dump a frame every n vblanks, default 20
//                    +after=n     with the real boot rom, stop n frames after
//                                 it unmaps, default 150
//                    +mooneye     stop when a mooneye test ends, which is the cpu
//                                 executing ld b,b, and print its verdict. pass
//                                 is b,c,d,e,h,l = 3,5,8,13,21,34 and fail is
//                                 all 0x42. frames is the time limit
//                  the last frame is always written as frames/frame_last.pgm
// Revision     : 1.2 - mooneye verdict
//                  1.1 - plus arguments, stand in boot rom, frame_last
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_gb_boot;

    reg clk = 1'b0;
    reg rst = 1'b1;
    always #5 clk = ~clk;

    wire [3:0] vga_r, vga_g, vga_b;
    wire       hs, vs, lcd_on;
    wire [15:0] a;
    wire [7:0]  d, din, ie, ifr;
    wire        we, dma;

    gb_top #(
        .BOOT_ROM_FILE("roms/boot/boot_rom.hex"),
        .CART_ROM_FILE("roms/game/cart_rom.hex")
    ) dut (
        .clk_100m(clk), .rst(rst),
        .btn_right(1'b0), .btn_left(1'b0), .btn_up(1'b0), .btn_down(1'b0),
        .btn_a(1'b0), .btn_b(1'b0), .btn_select(1'b0), .btn_start(1'b0),
        .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b), .vga_hsync(hs), .vga_vsync(vs),
        .lcd_on(lcd_on),
        .debug_cpu_addr(a), .debug_cpu_data_out(d), .debug_cpu_we(we),
        .debug_bus_data_in(din), .debug_ie(ie), .debug_if_reg(ifr), .debug_dma_active(dma)
    );

    // ------------------------------------------------------------------------
    // plus arguments and the stand in boot rom
    // ------------------------------------------------------------------------
    integer max_frames = 400, dump_every = 20, after_boot = 150;
    reg use_stub = 1'b0;
    reg [1023:0] cart_name, boot_name;
    integer n;

    task stub_byte(input [7:0] addr, input [7:0] v);
        begin dut.u_cartridge.boot_rom[addr] = v; end
    endtask

    initial begin
        #1;
        if ($value$plusargs("cart=%s", cart_name)) $readmemh(cart_name, dut.u_cartridge.cart_rom);
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
            $finish;
        end
    end


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
            $display("boot rom unmapped at frame %0d, time %0t", frame, $time);
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
                $finish;
            end
        end
    end

    initial begin
        repeat (8) @(posedge clk);
        rst = 1'b0;
    end

endmodule
