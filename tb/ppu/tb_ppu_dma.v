// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_dma.v
// Author       : Aaron Luebbert
// Date         : 2026-10-06
// Description  : oam dma with the whole ppu, through the real memory_map. the
//                  dma register is selected by memory_map's sel_oam_dma, the
//                  source is a plain array, and the oam dma unit's write port
//                  and active flag go straight into the ppu.
//                  - a transfer with the lcd off fills oam, 18 objects one
//                    above the other down the screen, one per 8 lines
//                  - with the lcd on, every line then shows its object
//                  - a transfer started in hblank of line 40, from a page
//                    holding the very same objects, overlaps mode 2 of line
//                    41 and nothing else. pan docs says objects read during
//                    dma are taken as off-screen. so line 41 must show no
//                    object and have no object penalty, 172 dots of mode 3,
//                    and lines 40 and 42 must show theirs as before
//                  - oam holds the transferred page afterwards
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu_dma;

    reg clk;
    reg rst;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    reg [1:0] m_cnt;
    initial m_cnt = 2'd0;
    always @(posedge clk) m_cnt <= m_cnt + 2'd1;
    wire ce_m = (m_cnt == 2'd3);

    initial begin
        #200000000;
        $display("TIMEOUT");
        $finish;
    end

    wire [15:0] addr;
    wire [7:0]  cpu_wdata;
    wire        we, bm_sel, bm_late;
    wire [7:0]  bus_rdata;

    wire sel_cart_rom, sel_boot_disable, sel_cart_ram, sel_wram;
    wire sel_ppu_vram, sel_ppu_oam, sel_ppu_reg, sel_oam_dma;
    wire sel_joypad, sel_serial, sel_timer, sel_interrupt_ctrl, sel_apu, sel_hram;
    wire [7:0] ppu_vram_data_out, ppu_oam_data_out, ppu_reg_data_out, oam_dma_data_out;
    wire       pixel_valid, lcd_on, irq_vblank, irq_lcdstat;
    wire [1:0] pixel_color, pixel_shade;
    wire [7:0] pixel_x, pixel_y;

    wire [15:0] dma_addr;
    reg  [7:0]  srcmem [0:65535];
    wire [7:0]  dma_rdata = srcmem[dma_addr];
    wire        dma_we, dma_active, cpu_blocked;
    wire [7:0]  dma_waddr, dma_wdata;

    memory_map mm (
        .addr(addr), .data_out(cpu_wdata), .data_in(bus_rdata), .we(we),
        .sel_cart_rom(sel_cart_rom),           .cart_rom_data_out(8'hFF),
        .sel_boot_disable(sel_boot_disable),   .boot_disable_data_out(8'hFF),
        .sel_cart_ram(sel_cart_ram),           .cart_ram_data_out(8'hFF),
        .sel_wram(sel_wram),                   .wram_data_out(8'hFF),
        .sel_ppu_vram(sel_ppu_vram),           .ppu_vram_data_out(ppu_vram_data_out),
        .sel_ppu_oam(sel_ppu_oam),             .ppu_oam_data_out(ppu_oam_data_out),
        .sel_ppu_reg(sel_ppu_reg),             .ppu_reg_data_out(ppu_reg_data_out),
        .sel_oam_dma(sel_oam_dma),             .oam_dma_data_out(oam_dma_data_out),
        .sel_joypad(sel_joypad),               .joypad_data_out(8'hFF),
        .sel_serial(sel_serial),               .serial_data_out(8'hFF),
        .sel_timer(sel_timer),                 .timer_data_out(8'hFF),
        .sel_interrupt_ctrl(sel_interrupt_ctrl), .interrupt_ctrl_data_out(8'hFF),
        .sel_apu(sel_apu),                     .apu_data_out(8'hFF),
        .sel_hram(sel_hram),                   .hram_data_out(8'hFF)
    );

    oam_dma u_dma (
        .clk(clk), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(cpu_wdata), .we(we), .sel(sel_oam_dma), .data_out(oam_dma_data_out),
        .dma_addr(dma_addr), .dma_rdata(dma_rdata),
        .dma_we(dma_we), .dma_waddr(dma_waddr), .dma_wdata(dma_wdata),
        .dma_active(dma_active),
        .cpu_addr(addr), .cpu_blocked(cpu_blocked)
    );

    ppu dut (
        .clk(clk), .ce_gb(1'b1), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(cpu_wdata), .we(we),
        .sel_ppu_vram(sel_ppu_vram), .ppu_vram_data_out(ppu_vram_data_out),
        .sel_ppu_oam(sel_ppu_oam),   .ppu_oam_data_out(ppu_oam_data_out),
        .sel_ppu_reg(sel_ppu_reg),   .ppu_reg_data_out(ppu_reg_data_out),
        .dma_active(dma_active),
        .dma_we(dma_we), .dma_waddr(dma_waddr), .dma_wdata(dma_wdata),
        .pixel_valid(pixel_valid), .pixel_color(pixel_color),
        .pixel_shade(pixel_shade), .lcd_on(lcd_on),
        .pixel_x(pixel_x), .pixel_y(pixel_y),
        .irq_vblank(irq_vblank), .irq_lcdstat(irq_lcdstat)
    );

    reg  [7:0] bus_rdata_r;
    assign bus_rdata = bus_rdata_r;
    always @(*) bus_rdata_r = ppu_reg_data_out | oam_dma_data_out | ppu_oam_data_out | ppu_vram_data_out;

    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(cpu_wdata),
                   .we(we), .sel(bm_sel), .late(bm_late), .rdata(bus_rdata));

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

    // the pixel at x = 35 of each line, and the length of mode 3 on each
    reg        cap_en;
    reg [1:0]  px35 [0:143];
    integer    m3   [0:143];
    always @(posedge clk) begin
        if (cap_en) begin
            if (pixel_valid && pixel_x == 8'd35 && pixel_y < 144) px35[pixel_y] = pixel_shade;
            if (dut.mode == 2'd3 && dut.ly < 144) m3[dut.ly] = m3[dut.ly] + 1;
        end
    end

    integer i, k, bad_oam, bad_px, bad_m3, l;

    initial begin
        rst = 1'b1; cap_en = 1'b0;
        for (i = 0; i < 65536; i = i + 1) srcmem[i] = 8'h00;
        // 18 objects, object k on lines 8k to 8k + 7, x from 32 to 39, tile 1
        for (k = 0; k < 18; k = k + 1) begin
            srcmem[16'hC000 + 4*k]     = 8'd16 + 8*k;
            srcmem[16'hC000 + 4*k + 1] = 8'd40;
            srcmem[16'hC000 + 4*k + 2] = 8'd1;
            srcmem[16'hC000 + 4*k + 3] = 8'd0;
        end
        // the second page holds exactly the same objects
        for (i = 0; i < 160; i = i + 1) srcmem[16'hC100 + i] = srcmem[16'hC000 + i];

        repeat (3) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // tile 0 is blank and tile 1 is solid color 3
        for (i = 0; i < 16; i = i + 1) dut.u_vram.mem[16 + i] = 8'hFF;
        bm.write(16'hFF47, 8'h00);     // bgp, color 0 is shade 0
        bm.write(16'hFF48, 8'hFF);     // obp0, color 3 is shade 3

        // fill oam by dma, with the lcd off
        bm.write(16'hFF46, 8'hC0);
        repeat (170 * 4) @(negedge clk);
        bad_oam = 0;
        for (i = 0; i < 160; i = i + 1)
            if (dut.u_oam.mem[i] !== srcmem[16'hC000 + i]) bad_oam = bad_oam + 1;
        check(bad_oam === 0, "a transfer with the lcd off, started through memory_map, filled all 160 oam bytes");

        // lcd on, objects on
        for (i = 0; i < 144; i = i + 1) begin m3[i] = 0; px35[i] = 2'bxx; end
        cap_en = 1'b1;
        bm.write(16'hFF40, 8'h93);

        // wait for hblank of line 40, then start a transfer from the identical page
        @(negedge clk);
        while (!(dut.ly == 8'd40 && dut.dot_counter >= 9'd262)) @(negedge clk);
        bm.write(16'hFF46, 8'hC1);
        while (dut.ly < 8'd46) @(negedge clk);
        cap_en = 1'b0;

        bad_px = 0; bad_m3 = 0;
        for (l = 34; l <= 45; l = l + 1) begin
            if (l == 41) begin
                if (px35[l] !== 2'd0) bad_px = bad_px + 1;
                if (m3[l] !== 172)    bad_m3 = bad_m3 + 1;
            end
            else begin
                if (px35[l] !== 2'd3) bad_px = bad_px + 1;
                if (m3[l] !== 183)    bad_m3 = bad_m3 + 1;
            end
        end
        check(px35[40] === 2'd3 && px35[42] === 2'd3, "lines 40 and 42 show their object, shade 3 at x = 35");
        check(m3[40] === 183 && m3[42] === 183, "and pay the object penalty, mode 3 lasts 172 + 11 = 183 dots");
        check(px35[41] === 2'd0, "line 41, whose mode 2 the transfer overlaps, shows no object");
        check(m3[41] === 172, "and pays no object penalty, mode 3 lasts the plain 172 dots");
        check(bad_px === 0 && bad_m3 === 0, "lines 34 to 45: only line 41 is affected, every other line is as expected");

        repeat (200) @(negedge clk);
        bad_oam = 0;
        for (i = 0; i < 160; i = i + 1)
            if (dut.u_oam.mem[i] !== srcmem[16'hC100 + i]) bad_oam = bad_oam + 1;
        check(bad_oam === 0, "the mid-frame transfer also completed, oam holds the second page");

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - dma and the ppu together verified, objects hidden for the scan that overlaps a transfer", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule
