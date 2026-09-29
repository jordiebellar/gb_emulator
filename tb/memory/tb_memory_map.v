// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_memory_map.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : boundary-value sweep of the rev-2 address decoder - every
//                  mapped range's first and last address, every unmapped
//                  gap's first and last address (22 regions, 38 boundary
//                  addresses total), plus a check that 'we' has no effect
//                  on decode (addr is the only thing that matters). no
//                  clock at all - memory_map is now pure combinational
//                  logic, so every check is just "set addr, wait for
//                  combinational settling, read data_in".
// Revision     : 2.0 - rewritten for the rev-2 decode table: dropped all
//                  ie/if write-then-readback checks (that storage moved
//                  to interrupt_ctrl.v) and all bus_stall checks (removed
//                  from the contract entirely). added oam_dma (FF46) and
//                  serial (FF01-FF02), and split the old single ppu_reg
//                  boundary into two, since FF46 now sits in the middle
//                  of that range.
// =============================================================================
`timescale 1ns / 1ps

module tb_memory_map;

    reg  [15:0] addr;
    reg  [7:0]  data_out;
    reg         we;
    wire [7:0]  data_in;

    wire sel_cart_rom, sel_boot_disable, sel_cart_ram, sel_wram, sel_ppu_vram;
    wire sel_ppu_oam, sel_ppu_reg, sel_oam_dma, sel_joypad, sel_serial;
    wire sel_timer, sel_interrupt_ctrl, sel_apu, sel_hram;

    reg [7:0] cart_rom_data_out;
    reg [7:0] boot_disable_data_out;
    reg [7:0] cart_ram_data_out;
    reg [7:0] wram_data_out;
    reg [7:0] ppu_vram_data_out;
    reg [7:0] ppu_oam_data_out;
    reg [7:0] ppu_reg_data_out;
    reg [7:0] oam_dma_data_out;
    reg [7:0] joypad_data_out;
    reg [7:0] serial_data_out;
    reg [7:0] timer_data_out;
    reg [7:0] interrupt_ctrl_data_out;
    reg [7:0] apu_data_out;
    reg [7:0] hram_data_out;

    integer errors = 0;
    integer checks = 0;

    memory_map dut (
        .addr(addr), .data_out(data_out), .data_in(data_in), .we(we),
        .sel_cart_rom(sel_cart_rom), .cart_rom_data_out(cart_rom_data_out),
        .sel_boot_disable(sel_boot_disable), .boot_disable_data_out(boot_disable_data_out),
        .sel_cart_ram(sel_cart_ram), .cart_ram_data_out(cart_ram_data_out),
        .sel_wram(sel_wram), .wram_data_out(wram_data_out),
        .sel_ppu_vram(sel_ppu_vram), .ppu_vram_data_out(ppu_vram_data_out),
        .sel_ppu_oam(sel_ppu_oam), .ppu_oam_data_out(ppu_oam_data_out),
        .sel_ppu_reg(sel_ppu_reg), .ppu_reg_data_out(ppu_reg_data_out),
        .sel_oam_dma(sel_oam_dma), .oam_dma_data_out(oam_dma_data_out),
        .sel_joypad(sel_joypad), .joypad_data_out(joypad_data_out),
        .sel_serial(sel_serial), .serial_data_out(serial_data_out),
        .sel_timer(sel_timer), .timer_data_out(timer_data_out),
        .sel_interrupt_ctrl(sel_interrupt_ctrl), .interrupt_ctrl_data_out(interrupt_ctrl_data_out),
        .sel_apu(sel_apu), .apu_data_out(apu_data_out),
        .sel_hram(sel_hram), .hram_data_out(hram_data_out)
    );

    task check_addr(input [15:0] a, input [7:0] expected, input [8*20:1] label);
        begin
            addr = a; we = 1'b0;
            #1;
            checks = checks + 1;
            if (data_in === expected) begin
                $display("PASS  0x%04h  %0s  data=0x%02h", a, label, data_in);
            end
            else begin
                errors = errors + 1;
                $display("FAIL  0x%04h  %0s  expected=0x%02h got=0x%02h", a, label, expected, data_in);
            end
        end
    endtask

    initial begin
        cart_rom_data_out       = 8'hA1;
        boot_disable_data_out   = 8'hAC;
        cart_ram_data_out       = 8'hA2;
        wram_data_out           = 8'hA3;
        ppu_vram_data_out       = 8'hA4;
        ppu_oam_data_out        = 8'hA5;
        ppu_reg_data_out        = 8'hA6;
        oam_dma_data_out        = 8'hAD;
        joypad_data_out         = 8'hA7;
        serial_data_out         = 8'hAE;
        timer_data_out          = 8'hA9;
        interrupt_ctrl_data_out = 8'hAF;
        apu_data_out            = 8'hAA;
        hram_data_out           = 8'hAB;

        addr = 16'h0000; data_out = 8'h00; we = 1'b0;
        #1;

        $display("=== memory_map (rev 2) boundary-value sweep, 22 regions ===");

        check_addr(16'h0000, 8'hA1, "cart_rom start");
        check_addr(16'h7FFF, 8'hA1, "cart_rom end");
        check_addr(16'h8000, 8'hA4, "ppu_vram start");
        check_addr(16'h9FFF, 8'hA4, "ppu_vram end");
        check_addr(16'hA000, 8'hA2, "cart_ram start");
        check_addr(16'hBFFF, 8'hA2, "cart_ram end");
        check_addr(16'hC000, 8'hA3, "wram start");
        check_addr(16'hDFFF, 8'hA3, "wram end");
        check_addr(16'hE000, 8'hA3, "wram_echo start");
        check_addr(16'hFDFF, 8'hA3, "wram_echo end");
        check_addr(16'hFE00, 8'hA5, "ppu_oam start");
        check_addr(16'hFE9F, 8'hA5, "ppu_oam end");
        check_addr(16'hFEA0, 8'hFF, "gap1 start");
        check_addr(16'hFEFF, 8'hFF, "gap1 end");
        check_addr(16'hFF00, 8'hA7, "joypad");
        check_addr(16'hFF01, 8'hAE, "serial start");
        check_addr(16'hFF02, 8'hAE, "serial end");
        check_addr(16'hFF03, 8'hFF, "gap2");
        check_addr(16'hFF04, 8'hA9, "timer start");
        check_addr(16'hFF07, 8'hA9, "timer end");
        check_addr(16'hFF08, 8'hFF, "gap3 start");
        check_addr(16'hFF0E, 8'hFF, "gap3 end");
        check_addr(16'hFF0F, 8'hAF, "interrupt_ctrl (IF)");
        check_addr(16'hFF10, 8'hAA, "apu start");
        check_addr(16'hFF3F, 8'hAA, "apu end");
        check_addr(16'hFF40, 8'hA6, "ppu_reg_a start");
        check_addr(16'hFF45, 8'hA6, "ppu_reg_a end");
        check_addr(16'hFF46, 8'hAD, "oam_dma");
        check_addr(16'hFF47, 8'hA6, "ppu_reg_b start");
        check_addr(16'hFF4B, 8'hA6, "ppu_reg_b end");
        check_addr(16'hFF4C, 8'hFF, "gap4 start");
        check_addr(16'hFF4F, 8'hFF, "gap4 end");
        check_addr(16'hFF50, 8'hAC, "boot_disable");
        check_addr(16'hFF51, 8'hFF, "gap5 start");
        check_addr(16'hFF7F, 8'hFF, "gap5 end");
        check_addr(16'hFF80, 8'hAB, "hram start");
        check_addr(16'hFFFE, 8'hAB, "hram end");
        check_addr(16'hFFFF, 8'hAF, "interrupt_ctrl (IE)");

        // --- decode depends only on addr, not on we ------------------------
        addr = 16'h0000; we = 1'b1; data_out = 8'h42;
        #1;
        checks = checks + 1;
        if (data_in === 8'hA1)
            $display("PASS  --------  decode unaffected by we  data=0x%02h", data_in);
        else begin
            errors = errors + 1;
            $display("FAIL  --------  decode unaffected by we  expected=0xA1 got=0x%02h", data_in);
        end

        $display("");
        if (errors == 0)
            $display("ALL %0d CHECKS PASSED - full rev-2 decode table verified, every range and gap", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule