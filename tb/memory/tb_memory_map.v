// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_memory_map_boundary.v
// Author       : Aaron Luebbert
// Date         : 2026-09-14
// Description  : boundary-value analysis of the address decoder - checks
//                  the first and last address of every mapped range AND
//                  every unmapped gap in the entire 64kb space, not just
//                  one sample address per range. every check prints, pass
//                  or fail, for a full terminal transcript of the whole
//                  decode table being exercised
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_memory_map_boundary;

    reg clk_100m;
    reg ce;
    reg rst;

    initial clk_100m = 1'b0;
    always #5 clk_100m = ~clk_100m;

    reg  [15:0] addr;
    reg  [7:0]  data_out;
    reg         we;
    wire [7:0]  data_in;
    wire        bus_stall;

    wire sel_cart_rom, sel_boot_disable, sel_cart_ram, sel_wram, sel_ppu_vram, sel_ppu_oam;
    wire sel_ppu_reg, sel_joypad, sel_serial, sel_timer, sel_apu, sel_hram;
    wire [7:0] ie, if_reg;
    reg  [7:0] if_clear;
    reg        if_clear_we;

    reg [7:0] cart_rom_data_out;      reg cart_rom_stall;
    reg [7:0] boot_disable_data_out;
    reg [7:0] cart_ram_data_out;      reg cart_ram_stall;
    reg [7:0] wram_data_out;          reg wram_stall;
    reg [7:0] ppu_vram_data_out;      reg ppu_vram_stall;
    reg [7:0] ppu_oam_data_out;       reg ppu_oam_stall;
    reg [7:0] ppu_reg_data_out;       reg ppu_reg_stall;
    reg [7:0] joypad_data_out;        reg joypad_stall;
    reg [7:0] serial_data_out;        reg serial_stall;
    reg [7:0] timer_data_out;         reg timer_stall;
    reg [7:0] apu_data_out;           reg apu_stall;
    reg [7:0] hram_data_out;          reg hram_stall;

    integer errors = 0;
    integer checks = 0;

    memory_map dut (
        .clk_100m (clk_100m), .ce(ce), .rst(rst),
        .addr(addr), .data_out(data_out), .data_in(data_in), .we(we),
        .bus_stall(bus_stall),
        .ie(ie), .if_reg(if_reg), .if_clear(if_clear), .if_clear_we(if_clear_we),

        .sel_cart_rom(sel_cart_rom), .cart_rom_data_out(cart_rom_data_out), .cart_rom_stall(cart_rom_stall),
        .sel_boot_disable(sel_boot_disable), .boot_disable_data_out(boot_disable_data_out),
        .sel_cart_ram(sel_cart_ram), .cart_ram_data_out(cart_ram_data_out), .cart_ram_stall(cart_ram_stall),
        .sel_wram(sel_wram), .wram_data_out(wram_data_out), .wram_stall(wram_stall),
        .sel_ppu_vram(sel_ppu_vram), .ppu_vram_data_out(ppu_vram_data_out), .ppu_vram_stall(ppu_vram_stall),
        .sel_ppu_oam(sel_ppu_oam), .ppu_oam_data_out(ppu_oam_data_out), .ppu_oam_stall(ppu_oam_stall),
        .sel_ppu_reg(sel_ppu_reg), .ppu_reg_data_out(ppu_reg_data_out), .ppu_reg_stall(ppu_reg_stall),
        .sel_joypad(sel_joypad), .joypad_data_out(joypad_data_out), .joypad_stall(joypad_stall),
        .sel_serial(sel_serial), .serial_data_out(serial_data_out), .serial_stall(serial_stall),
        .sel_timer(sel_timer), .timer_data_out(timer_data_out), .timer_stall(timer_stall),
        .sel_apu(sel_apu), .apu_data_out(apu_data_out), .apu_stall(apu_stall),
        .sel_hram(sel_hram), .hram_data_out(hram_data_out), .hram_stall(hram_stall)
    );

    // checks one address, prints every result
    task check_addr(input [15:0] a, input [7:0] expected, input [8*16:1] label);
        begin
            @(negedge clk_100m);
            addr = a;
            we   = 1'b0;
            @(negedge clk_100m);
            checks = checks + 1;
            if (data_in === expected) begin
                $display("PASS  0x%04h  %0s  data=0x%02h stall=%b", a, label, data_in, bus_stall);
            end
            else begin
                errors = errors + 1;
                $display("FAIL  0x%04h  %0s  expected=0x%02h got=0x%02h", a, label, expected, data_in);
            end
        end
    endtask

    initial begin
        cart_rom_data_out      = 8'hA1; cart_rom_stall      = 1'b0;
        boot_disable_data_out  = 8'hAC;
        cart_ram_data_out      = 8'hA2; cart_ram_stall      = 1'b0;
        wram_data_out          = 8'hA3; wram_stall          = 1'b0;
        ppu_vram_data_out      = 8'hA4; ppu_vram_stall      = 1'b0;
        ppu_oam_data_out       = 8'hA5; ppu_oam_stall       = 1'b0;
        ppu_reg_data_out       = 8'hA6; ppu_reg_stall       = 1'b0;
        joypad_data_out        = 8'hA7; joypad_stall        = 1'b0;
        serial_data_out        = 8'hA8; serial_stall        = 1'b0;
        timer_data_out         = 8'hA9; timer_stall         = 1'b0;
        apu_data_out           = 8'hAA; apu_stall           = 1'b0;
        hram_data_out          = 8'hAB; hram_stall          = 1'b0;
        if_clear = 8'h00; if_clear_we = 1'b0;

        addr = 16'h0000; data_out = 8'h00; we = 1'b0; ce = 1'b1;

        rst = 1'b1;
        repeat (2) @(posedge clk_100m);
        @(negedge clk_100m);
        rst = 1'b0;

        $display("address decoder boundary-value sweep, 35 checks");

        // cart_rom, 0x0000-0x7FFF
        check_addr(16'h0000, 8'hA1, "cart_rom   start");
        check_addr(16'h7FFF, 8'hA1, "cart_rom   end  ");

        // ppu_vram, 0x8000-0x9FFF
        check_addr(16'h8000, 8'hA4, "ppu_vram   start");
        check_addr(16'h9FFF, 8'hA4, "ppu_vram   end  ");

        // cart_ram, 0xA000-0xBFFF
        check_addr(16'hA000, 8'hA2, "cart_ram   start");
        check_addr(16'hBFFF, 8'hA2, "cart_ram   end  ");

        // wram, 0xC000-0xDFFF
        check_addr(16'hC000, 8'hA3, "wram       start");
        check_addr(16'hDFFF, 8'hA3, "wram       end  ");

        // wram echo, 0xE000-0xFDFF
        check_addr(16'hE000, 8'hA3, "wram_echo  start");
        check_addr(16'hFDFF, 8'hA3, "wram_echo  end  ");

        // ppu_oam, 0xFE00-0xFE9F
        check_addr(16'hFE00, 8'hA5, "ppu_oam    start");
        check_addr(16'hFE9F, 8'hA5, "ppu_oam    end  ");

        // unmapped gap 1, 0xFEA0-0xFEFF
        check_addr(16'hFEA0, 8'hFF, "gap1       start");
        check_addr(16'hFEFF, 8'hFF, "gap1       end  ");

        // joypad, single address 0xFF00
        check_addr(16'hFF00, 8'hA7, "joypad          ");

        // serial, 0xFF01-0xFF02
        check_addr(16'hFF01, 8'hA8, "serial     start");
        check_addr(16'hFF02, 8'hA8, "serial     end  ");

        // unmapped gap 2, single address 0xFF03
        check_addr(16'hFF03, 8'hFF, "gap2            ");

        // timer, 0xFF04-0xFF07
        check_addr(16'hFF04, 8'hA9, "timer      start");
        check_addr(16'hFF07, 8'hA9, "timer      end  ");

        // unmapped gap 3, 0xFF08-0xFF0E
        check_addr(16'hFF08, 8'hFF, "gap3       start");
        check_addr(16'hFF0E, 8'hFF, "gap3       end  ");

        // if_reg, single address 0xFF0F - write then read back
        @(negedge clk_100m);
        addr = 16'hFF0F; data_out = 8'h05; we = 1'b1;
        @(posedge clk_100m);
        @(negedge clk_100m);
        we = 1'b0;
        check_addr(16'hFF0F, 8'h05, "if_reg          ");

        // apu, 0xFF10-0xFF3F
        check_addr(16'hFF10, 8'hAA, "apu        start");
        check_addr(16'hFF3F, 8'hAA, "apu        end  ");

        // ppu_reg, 0xFF40-0xFF4B
        check_addr(16'hFF40, 8'hA6, "ppu_reg    start");
        check_addr(16'hFF4B, 8'hA6, "ppu_reg    end  ");

        // unmapped gap 4, 0xFF4C-0xFF4F
        check_addr(16'hFF4C, 8'hFF, "gap4       start");
        check_addr(16'hFF4F, 8'hFF, "gap4       end  ");

        // boot_disable, single address 0xFF50
        check_addr(16'hFF50, 8'hAC, "boot_dis        ");

        // unmapped gap 5, 0xFF51-0xFF7F
        check_addr(16'hFF51, 8'hFF, "gap5       start");
        check_addr(16'hFF7F, 8'hFF, "gap5       end  ");

        // hram, 0xFF80-0xFFFE
        check_addr(16'hFF80, 8'hAB, "hram       start");
        check_addr(16'hFFFE, 8'hAB, "hram       end  ");

        // ie, single address 0xFFFF - write then read back
        @(negedge clk_100m);
        addr = 16'hFFFF; data_out = 8'h1F; we = 1'b1;
        @(posedge clk_100m);
        @(negedge clk_100m);
        we = 1'b0;
        check_addr(16'hFFFF, 8'h1F, "ie              ");

        $display("");
        if (errors == 0)
            $display("ALL %0d BOUNDARY CHECKS PASSED - every mapped range and every unmapped gap in the 64kb space verified", checks);
        else
            $display("%0d of %0d boundary checks failed", errors, checks);

        $finish;
    end

endmodule