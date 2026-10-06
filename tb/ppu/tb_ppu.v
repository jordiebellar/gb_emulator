// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : integration testbench for the ppu wrapper. the cpu side is
//                  modeled as a bus master (addr, write data, we) held for
//                  a full m-cycle, driving the real memory_map for decode
//                  and read mux. enables use the real relationship: one
//                  t-cycle per clock, ce_m on every 4th.
//                  part a - lcd off at power-on, the boot rom scenario:
//                    all 160 bytes of vram and oam written and read back
//                    with nothing dropped, register decode through
//                    memory_map, unselected outputs read 0, oam dma block.
//                  part b - lcd on: stat reads the right mode, vram and
//                    oam block in the right modes and not in others,
//                    blocked writes are dropped, the oam render port is
//                    never blocked, turning the lcd off unblocks.
//                  part c - one full frame of interrupts: the vblank
//                    strobe lands on exactly one tick, and the stat
//                    interrupt fires on the expected ticks for hblank and
//                    lyc coincidence.
//                  part d - the background fetcher through the wrapper:
//                    scx and scy set over the bus, a tile map laid down,
//                    and the wrapper's pixel output compared with an
//                    oracle, with mode 3 lasting 172 + (scx & 7) dots.
//                  part e - accesses whose ce_m edge is exactly a ppu
//                    transition edge. vram and oam writes, an ly read, and
//                    a stat read are each landed on the edge that enters or
//                    leaves a mode, and must be decided by the mode after
//                    that edge. two controls away from any transition show
//                    the harness lands where it claims to.
//                  part d also sets bgp to a reversed palette over the bus
//                  and checks pixel_shade against it, and lcd_on is checked
//                  against lcdc bit 7.
//                  every bus access goes through bus_master, which samples
//                  reads on the ce_m edge the way the cpu does.
// Revision     : 2.1 - checks pixel_shade through a reversed bgp, and
//                  lcd_on.
//                  2.0 - bus accesses through bus_master, part e added, and
//                    the lyc coincidence interrupt now checked on the exact
//                    edge, tick 912, instead of within a window.
//                  1.1 - the fetcher replaced the fifo_done stand-in, the
//                    vram render port is internal, added part d.
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu;

    reg        clk;
    reg        rst;
    wire [15:0] addr;
    wire [7:0]  cpu_wdata;
    wire        we, bm_sel, bm_late;
    reg        dma_active;
    reg [7:0]  oam_render_addr;

    // real enable relationship, one t-cycle per clock, ce_m every 4th
    reg [1:0] m_cnt;
    wire      ce_gb = 1'b1;
    wire      ce_m  = (m_cnt == 2'd3);
    initial m_cnt = 2'd0;
    always @(posedge clk) m_cnt <= m_cnt + 2'd1;

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        #30000000;
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
    wire [7:0] oam_render_data;
    wire       pixel_valid;
    wire [1:0] pixel_color;
    wire [1:0] pixel_shade;
    wire       lcd_on;
    wire [7:0] pixel_x, pixel_y;
    wire       irq_vblank, irq_lcdstat;

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
        .dma_active(dma_active),
        .oam_render_addr(oam_render_addr),   .oam_render_data(oam_render_data),
        .pixel_valid(pixel_valid), .pixel_color(pixel_color),
        .pixel_shade(pixel_shade), .lcd_on(lcd_on),
        .pixel_x(pixel_x), .pixel_y(pixel_y),
        .irq_vblank(irq_vblank), .irq_lcdstat(irq_lcdstat)
    );

    // --- cpu bus model. every access goes through bus_master, which holds
    // addr, data, and we for a whole m-cycle and samples read data on the
    // ce_m edge that ends it, before registers update, like the cpu does
    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(cpu_wdata),
                   .we(we), .sel(bm_sel), .late(bm_late), .rdata(bus_rdata));

    reg [7:0] rd;

    task bus_write(input [15:0] a, input [7:0] d);
        begin bm.write(a, d); end
    endtask

    task bus_read(input [15:0] a);
        begin bm.read(a); rd = bm.rd; end
    endtask

    task wait_dot(input [8:0] d);
        begin
            @(negedge clk);
            while (dut.dot_counter !== d) @(negedge clk);
        end
    endtask

    task wait_line_dot(input [7:0] l, input [8:0] d);
        begin
            @(negedge clk);
            while (!(dut.ly === l && dut.dot_counter === d)) @(negedge clk);
        end
    endtask

    task check(input expr, input [8*100:1] label);
        begin
            checks = checks + 1;
            if (expr)
                $display("PASS  %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s  (rd=0x%02h mode=%0d ly=%0d dot=%0d)",
                          label, rd, dut.mode, dut.ly, dut.dot_counter);
            end
        end
    endtask

    // --- interrupt monitor. tick counts clock edges since the lcd was
    // turned on, tick k is the k-th edge. strobes are combinational so
    // they are sampled pre-update at the edge, where tick still holds k-1
    integer tick;
    integer vb_n, st_n;
    integer vb_k [0:3];
    integer st_k [0:255];
    reg     mon_en;

    always @(posedge clk) begin
        if (!dut.lcdc[7]) tick <= 0;
        else              tick <= tick + 1;

        if (mon_en) begin
            if (irq_vblank) begin
                vb_k[vb_n] = tick + 1;
                vb_n = vb_n + 1;
            end
            if (irq_lcdstat) begin
                st_k[st_n] = tick + 1;
                st_n = st_n + 1;
            end
        end
    end

    // --- pixel capture for part d, lines 0 and 1. sampled at the edge,
    // before the registers update, so it sees the dot that is ending
    reg        pix_mon;
    reg [1:0]  pix [0:319];
    reg [1:0]  psh [0:319];
    integer    pcnt [0:1];
    integer    pfirst [0:1];
    integer    plast [0:1];
    integer    phb [0:1];
    reg [1:0]  pmode_prev;

    always @(posedge clk) begin
        if (pix_mon) begin
            if (pixel_valid && pixel_y < 2) begin
                pix[pixel_y * 160 + pixel_x] = pixel_color;
                psh[pixel_y * 160 + pixel_x] = pixel_shade;
                pcnt[pixel_y] = pcnt[pixel_y] + 1;
                if (pcnt[pixel_y] == 1) pfirst[pixel_y] = dut.dot_counter - 80;
                plast[pixel_y] = dut.dot_counter - 80;
            end
            if (pmode_prev == 2'd3 && dut.mode == 2'd0 && dut.ly < 2)
                phb[dut.ly] = dut.dot_counter;
            pmode_prev = dut.mode;
        end
    end

    // oracle for part d: scx 5, scy 0x12, lcdc 0x91 so the map is 0x9800
    // and tile data is unsigned from 0x8000. written as a closed form
    // rule with division and no fifo, so it shares nothing with the rtl
    function [1:0] ref_pix(input integer l, input integer x);
        integer y, px, tidx, doff, lo, hi, bitn;
        begin
            y    = l + 18;
            px   = x + 5;
            tidx = dut.u_vram.mem['h1800 + (y / 8) * 32 + (px / 8)];
            doff = tidx * 16;
            lo   = dut.u_vram.mem[doff + (y % 8) * 2];
            hi   = dut.u_vram.mem[doff + (y % 8) * 2 + 1];
            bitn = 7 - (px % 8);
            ref_pix = {hi[bitn], lo[bitn]};
        end
    endfunction

    integer i, bad;
    reg [7:0] expv;
    reg [7:0] ly_edge, stat_edge;

    initial begin
        dma_active = 1'b0;
        oam_render_addr = 8'h00; pix_mon = 1'b0;
        tick = 0; vb_n = 0; st_n = 0; mon_en = 1'b0; rd = 8'h00;

        rst = 1'b1;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // =====================================================================
        // part a - lcd off at power-on, the boot rom scenario
        // =====================================================================
        $display("=== part a: lcd off at power-on ===");
        bus_read(16'hFF40);
        check(rd === 8'h00, "lcdc reads 0 after reset, the lcd is off at power-on");
        bus_read(16'hFF41);
        check(rd === 8'h84, "stat reads mode 0 with coincidence set (ly 0 == lyc 0)");
        bus_read(16'hFF44);
        check(rd === 8'h00, "ly reads 0 with the lcd off");

        // 160 writes and 160 reads at several clocks each span well over a
        // line, time in which a running ppu would have blocked vram in mode 3
        for (i = 0; i < 160; i = i + 1) begin
            expv = (i ^ 8'h5A) & 8'hFF;
            bus_write(16'h8000 + i, expv);
        end
        bad = 0;
        for (i = 0; i < 160; i = i + 1) begin
            expv = (i ^ 8'h5A) & 8'hFF;
            bus_read(16'h8000 + i);
            if (rd !== expv) bad = bad + 1;
        end
        check(bad === 0, "lcd off: all 160 vram writes landed and read back, none dropped");

        for (i = 0; i < 160; i = i + 1) begin
            expv = (i * 3 + 1) & 8'hFF;
            bus_write(16'hFE00 + i, expv);
        end
        bad = 0;
        for (i = 0; i < 160; i = i + 1) begin
            expv = (i * 3 + 1) & 8'hFF;
            bus_read(16'hFE00 + i);
            if (rd !== expv) bad = bad + 1;
        end
        check(bad === 0, "lcd off: all 160 oam writes landed and read back, none dropped");

        dma_active = 1'b1;
        bus_write(16'hFE00, 8'h77);
        bus_read(16'hFE00);
        check(rd === 8'hFF, "oam dma active: oam reads $FF even with the lcd off");
        dma_active = 1'b0;
        bus_read(16'hFE00);
        check(rd === 8'h01, "oam dma active: the blocked write was dropped, oam[0] intact");

        bus_write(16'hFF42, 8'h12);
        bus_read(16'hFF42);
        check(rd === 8'h12, "scy writes and reads back through memory_map and the ppu");
        bus_write(16'hFF47, 8'hE4);
        bus_read(16'hFF47);
        check(rd === 8'hE4, "bgp works too, the second range after the oam dma gap");
        bus_write(16'hFF46, 8'h99);
        bus_read(16'hFF47);
        check(rd === 8'hE4, "a write to ff46 does not disturb the neighboring registers");
        bus_read(16'hFF45);
        check(rd === 8'h00, "a write to ff46 does not land in lyc either");

        @(negedge clk); bm.addr = 16'h8000; #1;
        check(ppu_oam_data_out === 8'h00 && ppu_reg_data_out === 8'h00,
              "reading vram: the oam and register outputs are 0");
        bm.addr = 16'hFE00; #1;
        check(ppu_vram_data_out === 8'h00 && ppu_reg_data_out === 8'h00,
              "reading oam: the vram and register outputs are 0");
        bm.addr = 16'hFF42; #1;
        check(ppu_vram_data_out === 8'h00 && ppu_oam_data_out === 8'h00,
              "reading a register: the vram and oam outputs are 0");
        bm.addr = 16'h0000; #1;
        check(ppu_vram_data_out === 8'h00 && ppu_oam_data_out === 8'h00 &&
              ppu_reg_data_out === 8'h00, "outside the ppu: all three outputs are 0");

        // =====================================================================
        // part b - lcd on, blocking behavior through the real bus
        // =====================================================================
        $display("");
        $display("=== part b: lcd on ===");
        bus_write(16'hFF40, 8'h91);
        bus_read(16'hFF40);
        check(rd === 8'h91, "lcdc reads back 0x91, the lcd is on");
        check(lcd_on === 1'b1, "lcd_on follows lcdc bit 7, high");

        wait_dot(150);
        bus_read(16'hFF41);
        check(rd === 8'h87, "stat during pixel transfer reads mode 3 with coincidence set");
        bus_read(16'h8000);
        check(rd === 8'hFF, "mode 3: vram read is blocked and returns $FF");
        bus_read(16'hFE00);
        check(rd === 8'hFF, "mode 3: oam read is blocked and returns $FF");

        oam_render_addr  = 8'h00;
        #1;
        check(oam_render_data === 8'h01, "mode 3: the oam render port still reads oam[0], never blocked");

        bus_write(16'h8000, 8'hEE);
        wait_dot(300);
        bus_read(16'h8000);
        check(rd === 8'h5A, "the mode 3 write was dropped, vram[0] still holds its original value");
        bus_read(16'hFE00);
        check(rd === 8'h01, "hblank: oam is readable again");
        bus_read(16'hFF41);
        check(rd === 8'h84, "stat in hblank reads mode 0 with coincidence set");

        wait_line_dot(8'd1, 9'd20);
        bus_read(16'hFE00);
        check(rd === 8'hFF, "mode 2: oam read is blocked");
        bus_read(16'h8000);
        check(rd === 8'h5A, "mode 2: vram is not blocked");
        bus_read(16'hFF44);
        check(rd === 8'h01, "ly reads 1 on line 1");

        bus_write(16'hFF40, 8'h00);
        bus_read(16'hFE00);
        check(rd === 8'h01, "lcd turned off during mode 2: oam is readable right away");
        check(lcd_on === 1'b0, "lcd_on follows lcdc bit 7, low");
        bus_read(16'hFF44);
        check(rd === 8'h00, "lcd off: ly reads 0 again");

        // =====================================================================
        // part c - one full frame of interrupts
        // =====================================================================
        $display("");
        $display("=== part c: interrupts over one frame ===");
        bus_write(16'hFF41, 8'h48); // mode 0 interrupt and lyc interrupt enabled
        bus_write(16'hFF45, 8'h02); // lyc = 2
        vb_n = 0; st_n = 0;
        mon_en = 1'b1;
        bus_write(16'hFF40, 8'h91); // lcd on, tick counting starts at this commit

        while (tick < 65720) @(negedge clk);
        mon_en = 1'b0;

        check(vb_n === 1, "irq_vblank strobed exactly once in the frame");
        check(vb_k[0] === 65664, "irq_vblank landed on tick 65664, 456 x 144");
        check(st_n === 145, "irq_lcdstat strobed 145 times: 144 hblanks plus one lyc match");
        check(st_k[0] === 252, "first stat interrupt is line 0's hblank, tick 252");
        check(st_k[1] === 708, "second is line 1's hblank, tick 708 = 456 + 252");
        check(st_k[2] === 912, "third is the lyc=2 match, on the edge ly becomes 2, tick 912 = 2 x 456");
        check(st_k[3] === 1164, "fourth is line 2's hblank, tick 1164 = 2 x 456 + 252");

        // =====================================================================
        // part d - the fetcher through the wrapper, scx and scy set over the bus
        // =====================================================================
        $display("");
        $display("=== part d: background fetcher through the wrapper ===");
        bus_write(16'hFF40, 8'h00);         // lcd off so vram is writable
        // lcd_on must follow bit 7 and not some other bit. these values make
        // bit 7 and bit 0 disagree, which 0x91 and 0x00 never do
        bus_write(16'hFF40, 8'h01);
        check(lcd_on === 1'b0, "lcd_on is low with lcdc 0x01, bit 0 set but bit 7 clear");
        bus_write(16'hFF40, 8'h80);
        check(lcd_on === 1'b1, "lcd_on is high with lcdc 0x80, bit 7 set but bit 0 clear");
        bus_write(16'hFF40, 8'h00);
        bus_write(16'hFF43, 8'h05);         // scx = 5, a fine scroll of 5 pixels
        bus_read(16'hFF43);
        check(rd === 8'h05, "scx reads back 5 through the bus");
        bus_write(16'hFF47, 8'h1B);          // bgp reversed, color 0 to shade 3 down to color 3 to shade 0
        // scy is still 0x12 from part a, so lines 0 and 1 both use map row 2.
        // lay tiles 0 to 3, written in part a, across that whole map row
        for (i = 0; i < 32; i = i + 1)
            bus_write(16'h9840 + i, i % 4);

        for (i = 0; i < 2; i = i + 1) begin
            pcnt[i] = 0; pfirst[i] = -1; plast[i] = -1; phb[i] = -1;
        end
        for (i = 0; i < 320; i = i + 1) begin pix[i] = 2'bxx; psh[i] = 2'bxx; end
        pmode_prev = 2'd0;
        pix_mon = 1'b1;
        bus_write(16'hFF40, 8'h91);         // lcd on
        wait_line_dot(8'd2, 9'd10);
        pix_mon = 1'b0;

        check(pcnt[0] === 160 && pcnt[1] === 160, "pixel output: exactly 160 pixels on each of lines 0 and 1");
        bad = 0;
        for (i = 0; i < 320; i = i + 1)
            if (pix[i] !== ref_pix(i / 160, i % 160)) bad = bad + 1;
        check(bad === 0, "pixel output matches the oracle on lines 0 and 1 (scx 5, scy 0x12)");
        bad = 0;
        for (i = 0; i < 320; i = i + 1)
            if (psh[i] !== 2'd3 - ref_pix(i / 160, i % 160)) bad = bad + 1;
        check(bad === 0, "pixel_shade is the color index through the reversed bgp, 3 minus the index");
        check(pfirst[0] === 17 && pfirst[1] === 17, "pixel 0 lands on mode 3 dot 17 = 12 + (scx & 7)");
        check(plast[0] === 176 && plast[1] === 176, "pixel 159 lands on dot 176 = 171 + (scx & 7)");
        check(phb[0] === 257 && phb[1] === 257, "mode 3 ends on dot 257 = 252 + (scx & 7), set by the fetcher");

        // =====================================================================
        // part e - accesses landing exactly on a ppu transition edge
        // =====================================================================
        $display("");
        $display("=== part e: accesses on transition edges ===");
        bus_write(16'hFF40, 8'h00);          // lcd off so vram and oam are writable
        bus_write(16'hFF43, 8'h00);          // scx 0, so mode 3 is 172 dots and ends on dot 252
        bus_write(16'h8000, 8'h11);
        bus_write(16'h8001, 8'h00);
        bus_write(16'h8002, 8'h00);
        bus_write(16'h8003, 8'h00);
        bus_write(16'hFE01, 8'h00);
        bus_write(16'hFE02, 8'h00);
        bus_write(16'hFF40, 8'h91);          // lcd on. this commit is a ce_m edge, so ce_m
                                             // then lands on every tick that is a multiple of 4

        // each access starts on the negedge after the ce_m edge four ticks before the tick
        // it should land on, and write_now and read_now run it from there. every tick used
        // here is a multiple of 4, so every one of them is a ce_m edge
        wait_dot(76);  bm.write_now(16'h8000, 8'hAB);       // lands on tick 80, the edge that enters mode 3
        wait_dot(156); bm.write_now(16'h8002, 8'hC1);       // control, mid mode 3
        wait_dot(248); bm.write_now(16'h8001, 8'hBB);       // lands on tick 252, the edge that leaves mode 3
        wait_dot(296); bm.write_now(16'h8003, 8'hC2);       // control, mid hblank
        wait_dot(452); bm.read_now(16'hFF44);  ly_edge = bm.rd;     // tick 456, the edge that increments ly
        wait_line_dot(8'd1, 9'd76);  bm.read_now(16'hFF41); stat_edge = bm.rd;  // line 1 tick 80
        wait_line_dot(8'd1, 9'd452); bm.write_now(16'hFE01, 8'hCC);  // tick 912, the edge that enters mode 2
        wait_line_dot(8'd2, 9'd248); bm.write_now(16'hFE02, 8'hDD);  // tick 1164, the edge that leaves mode 3

        check(dut.u_vram.mem[0] === 8'h11, "vram write on the edge that enters mode 3 is dropped");
        check(dut.u_vram.mem[2] === 8'h00, "control: a vram write mid mode 3 is dropped");
        check(dut.u_vram.mem[1] === 8'hBB, "vram write on the edge that leaves mode 3 lands");
        check(dut.u_vram.mem[3] === 8'hC2, "control: a vram write mid hblank lands");
        check(ly_edge === 8'd1, "ly read on the edge that increments ly returns the new value");
        check(stat_edge[1:0] === 2'd3, "stat read on the edge that enters mode 3 returns mode 3");
        check(dut.u_oam.mem[1] === 8'h00, "oam write on the edge that enters mode 2 is dropped");
        check(dut.u_oam.mem[2] === 8'hDD, "oam write on the edge that leaves mode 3 lands");

        $display("");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED - ppu wrapper wiring verified through memory_map", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule