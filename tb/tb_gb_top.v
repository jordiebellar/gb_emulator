// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_gb_top.v
// Author       : Aaron Luebbert
// Date         : 2026-10-20
// Description  : integration test for gb_top. a small program is assembled
//                  into the boot rom and the cartridge by the tasks below and
//                  run by the real cpu over the real bus, so every check is
//                  something the cpu itself saw or did.
//
//                  boot rom. sets sp, jumps to 0x00fc, writes ff50 which
//                  unmaps the overlay, and execution carries on at 0x0100 in
//                  the cartridge, the same hand off the real boot rom makes.
//
//                  cartridge program
//                    - fills a 160 byte source page in wram at 0xc100
//                    - copies a dma routine into hram and calls it. the
//                      routine starts the transfer, then reads wram and
//                      writes wram while the transfer runs (both must be
//                      dropped, a blocked read returns ff) and waits it out
//                    - reads oam back over the bus and copies it into wram
//                    - turns the lcd on, enables the vblank interrupt, halts,
//                      and counts vblanks in the handler at 0x0040
//                    - reads ly over the bus after the interrupt
//
//                  the testbench then looks at wram, hram and oam and at the
//                  boot rom latch.
// Revision     : 2.0 - rewritten for gb_top rev 2, program based
//                  1.0 - three instruction smoke test
// =============================================================================
`timescale 1ns / 1ps

module tb_gb_top;

    reg clk_100m;
    reg rst;
    initial clk_100m = 1'b0;
    always #5 clk_100m = ~clk_100m;

    wire [3:0] vga_r, vga_g, vga_b;
    wire       vga_hsync, vga_vsync, lcd_on;
    wire [15:0] dbg_addr;
    wire [7:0]  dbg_dout, dbg_din, dbg_ie, dbg_if;
    wire        dbg_we, dbg_dma;

    gb_top #(
        .BOOT_ROM_FILE("tb/integration/test_boot_prog.hex"),
        .CART_ROM_FILE("tb/integration/test_cart_prog.hex")
    ) dut (
        .clk_100m(clk_100m), .rst(rst),
        .btn_right(1'b0), .btn_left(1'b0), .btn_up(1'b0), .btn_down(1'b0),
        .btn_a(1'b0), .btn_b(1'b0), .btn_select(1'b0), .btn_start(1'b0),
        .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b),
        .vga_hsync(vga_hsync), .vga_vsync(vga_vsync), .lcd_on(lcd_on),
        .debug_cpu_addr(dbg_addr), .debug_cpu_data_out(dbg_dout),
        .debug_cpu_we(dbg_we), .debug_bus_data_in(dbg_din),
        .debug_ie(dbg_ie), .debug_if_reg(dbg_if), .debug_dma_active(dbg_dma)
    );

    // ------------------------------------------------------------------------
    // a tiny assembler, writes straight into the cartridge arrays
    // ------------------------------------------------------------------------
    reg [15:0] pc;
    reg        to_boot;

    task emit(input [7:0] b);
        begin
            if (to_boot) dut.u_cartridge.boot_rom[pc[7:0]]  = b;
            else         dut.u_cartridge.cart_rom[pc[14:0]] = b;
            pc = pc + 16'd1;
        end
    endtask

    task org(input boot, input [15:0] a);
        begin to_boot = boot; pc = a; end
    endtask

    task ld_sp(input [15:0] n);          begin emit(8'h31); emit(n[7:0]); emit(n[15:8]); end endtask
    task ld_a(input [7:0] n);            begin emit(8'h3E); emit(n); end endtask
    task ld_hl(input [15:0] n);          begin emit(8'h21); emit(n[7:0]); emit(n[15:8]); end endtask
    task ldh_n_a(input [7:0] n);         begin emit(8'hE0); emit(n); end endtask
    task ldh_a_n(input [7:0] n);         begin emit(8'hF0); emit(n); end endtask
    task ld_nn_a(input [15:0] n);        begin emit(8'hEA); emit(n[7:0]); emit(n[15:8]); end endtask
    task ld_a_nn(input [15:0] n);        begin emit(8'hFA); emit(n[7:0]); emit(n[15:8]); end endtask
    task jp(input [15:0] n);             begin emit(8'hC3); emit(n[7:0]); emit(n[15:8]); end endtask
    task call(input [15:0] n);           begin emit(8'hCD); emit(n[7:0]); emit(n[15:8]); end endtask

    // store an immediate at an address
    task poke(input [15:0] n, input [7:0] v);
        begin ld_a(v); ld_nn_a(n); end
    endtask

    // copy a byte of the dma routine into hram
    task hram_byte(input [7:0] off, input [7:0] v);
        begin ld_a(v); ldh_n_a(8'h80 + off); end
    endtask

    integer i;

    task build_program;
        begin
            // ---- boot rom ----
            org(1, 16'h0000);
            ld_sp(16'hFFFE);
            jp(16'h00FC);
            org(1, 16'h00FC);
            ld_a(8'h01);
            ldh_n_a(8'h50);                  // unmap the boot rom, next fetch is cart 0x0100

            // ---- vblank handler at 0x0040, counts vblanks in c030 ----
            org(0, 16'h0040);
            ld_hl(16'hC030);
            emit(8'h34);                     // inc (hl)
            emit(8'hD9);                     // reti

            // ---- entry ----
            org(0, 16'h0100);
            jp(16'h0150);

            // ---- main program ----
            org(0, 16'h0150);
            poke(16'hC000, 8'h5A);           // a blocked read of this must not show 5a
            poke(16'hC100, 8'h20);           // source page for the transfer
            poke(16'hC101, 8'h28);
            poke(16'hC102, 8'h01);
            poke(16'hC103, 8'h10);
            poke(16'hC19F, 8'hAB);           // last byte of the page

            // dma routine in hram at ff80
            //   ff80  ldh (46),a        start the transfer
            //   ff82  ld a,(c000)       blocked, reads ff
            //   ff85  ldh (a0),a        keep it in hram
            //   ff87  ld a,77
            //   ff89  ld (c020),a       blocked, dropped
            //   ff8c  ld a,99
            //   ff8e  ld (fe02),a       oam is closed to the cpu during dma, dropped. index 2
            //                          was written by the transfer long before, so a write that
            //                          got through would stay
            //   ff91  ld a,40
            //   ff93  dec a
            //   ff94  jr nz,ff93
            //   ff96  ret
            hram_byte(8'h00, 8'hE0); hram_byte(8'h01, 8'h46);
            hram_byte(8'h02, 8'hFA); hram_byte(8'h03, 8'h00); hram_byte(8'h04, 8'hC0);
            hram_byte(8'h05, 8'hE0); hram_byte(8'h06, 8'hA0);
            hram_byte(8'h07, 8'h3E); hram_byte(8'h08, 8'h77);
            hram_byte(8'h09, 8'hEA); hram_byte(8'h0A, 8'h20); hram_byte(8'h0B, 8'hC0);
            hram_byte(8'h0C, 8'h3E); hram_byte(8'h0D, 8'h99);
            hram_byte(8'h0E, 8'hEA); hram_byte(8'h0F, 8'h02); hram_byte(8'h10, 8'hFE);
            hram_byte(8'h11, 8'h3E); hram_byte(8'h12, 8'h28);
            hram_byte(8'h13, 8'h3D);
            hram_byte(8'h14, 8'h20); hram_byte(8'h15, 8'hFD);
            hram_byte(8'h16, 8'hC9);

            ld_a(8'hC1);                     // source page 0xc1
            call(16'hFF80);

            // read oam back over the bus, the lcd is still off so it is open
            ld_a_nn(16'hFE00); ld_nn_a(16'hC010);
            ld_a_nn(16'hFE01); ld_nn_a(16'hC011);
            ld_a_nn(16'hFE02); ld_nn_a(16'hC012);
            ld_a_nn(16'hFE03); ld_nn_a(16'hC013);
            ld_a_nn(16'hFE9F); ld_nn_a(16'hC014);
            ld_a_nn(16'hC020); ld_nn_a(16'hC015);     // the dropped write, still 00
            ldh_a_n(8'hA0);    ld_nn_a(16'hC016);     // the blocked read, ff

            // lcd on, vblank interrupt, halt until it fires
            ld_a(8'h91);  ldh_n_a(8'h40);             // lcdc
            ld_a(8'h01);  ldh_n_a(8'hFF);             // ie = vblank
            emit(8'hAF);  ldh_n_a(8'h0F);             // if = 0
            emit(8'hFB);                              // ei
            emit(8'h76);                              // halt
            emit(8'h00);                              // nop after the halt

            ld_a(8'hEE); ld_nn_a(16'hC031);           // reached after the handler
            ldh_a_n(8'h44); ld_nn_a(16'hC032);        // ly, should be in vblank
            emit(8'h18); emit(8'hFE);                 // jr -2, spin
        end
    endtask

    // ------------------------------------------------------------------------
    integer errors = 0, checks = 0;

    task check(input cond, input [8*60:1] label);
        begin
            checks = checks + 1;
            if (cond) $display("PASS  %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s", label);
            end
        end
    endtask

    // dma activity seen from outside
    integer dma_cycles = 0, dma_runs = 0;
    reg dma_d = 0;
    always @(posedge clk_100m) begin
        dma_d <= dbg_dma;
        if (dbg_dma && dut.ce_m) dma_cycles <= dma_cycles + 1;
        if (dbg_dma && !dma_d) dma_runs <= dma_runs + 1;
    end

    // the ppu must see the same dma_active as the dma unit, it is what makes
    // objects read as off screen during a transfer, which a write cannot show
    // because the dma write port already wins every ce_m edge it runs on
    integer dma_mismatch = 0;
    always @(posedge clk_100m)
        if (!rst && dut.u_ppu.dma_active !== dut.u_oam_dma.dma_active) dma_mismatch <= dma_mismatch + 1;

    integer cyc, stray;

    initial begin
        rst = 1'b1;
        #1;
        build_program;
        repeat (4) @(posedge clk_100m);
        @(negedge clk_100m);
        rst = 1'b0;

        // wait for the program to finish, ly stored, with a time limit
        cyc = 0;
        while (dut.u_wram.mem[13'h032] == 8'h00 && cyc < 6_000_000) begin
            @(posedge clk_100m);
            cyc = cyc + 1;
        end
        repeat (1000) @(posedge clk_100m);

        $display("program finished after %0d clocks", cyc);
        check(cyc < 6_000_000,                              "program ran to the end, no timeout");
        check(dut.u_cartridge.boot_active === 1'b0,         "boot rom unmapped by the ff50 write");

        // cpu fetched and ran the cartridge program, wram writes landed
        check(dut.u_wram.mem[13'h000] === 8'h5A,            "wram write from the cartridge program landed");
        check(dut.u_wram.mem[13'h100] === 8'h20,            "source page byte 0 in wram");
        check(dut.u_wram.mem[13'h19F] === 8'hAB,            "source page byte 159 in wram");

        // the hram routine was copied and the cpu ran from hram
        check(dut.u_hram.mem[7'h00] === 8'hE0 && dut.u_hram.mem[7'h16] === 8'hC9, "dma routine copied into hram");

        // the transfer
        check(dma_runs == 1,                                "one transfer started");
        check(dma_cycles == 160,                            "transfer lasted 160 m-cycles");
        check(dbg_dma === 1'b0,                             "transfer finished");
        check(dma_mismatch == 0,                            "ppu sees the dma unit's dma_active");
        check(dut.u_ppu.u_oam.mem[0]   === 8'h20,           "oam byte 0 after the transfer");
        check(dut.u_ppu.u_oam.mem[1]   === 8'h28,           "oam byte 1 after the transfer");
        check(dut.u_ppu.u_oam.mem[2]   === 8'h01,           "oam byte 2 after the transfer");
        check(dut.u_ppu.u_oam.mem[3]   === 8'h10,           "oam byte 3 after the transfer");
        check(dut.u_ppu.u_oam.mem[159] === 8'hAB,           "oam byte 159 after the transfer");

        // the cpu reading oam back over the bus, copied to wram by the program
        check(dut.u_wram.mem[13'h010] === 8'h20,            "cpu read of oam byte 0 matches");
        check(dut.u_wram.mem[13'h011] === 8'h28,            "cpu read of oam byte 1 matches");
        check(dut.u_wram.mem[13'h012] === 8'h01,            "cpu read of oam byte 2 matches");
        check(dut.u_wram.mem[13'h013] === 8'h10,            "cpu read of oam byte 3 matches");
        check(dut.u_wram.mem[13'h014] === 8'hAB,            "cpu read of oam byte 159 matches");

        // access rules during the transfer
        check(dut.u_hram.mem[7'h20] === 8'hFF,              "cpu read of wram during dma returned ff");
        check(dut.u_wram.mem[13'h020] === 8'h00,            "cpu write to wram during dma was dropped");
        stray = 0;
        for (i = 13'h104; i < 13'h19F; i = i + 1) if (dut.u_wram.mem[i] !== 8'h00) stray = stray + 1;
        check(stray == 0,                                   "cpu write during dma did not land in the source page");
        check(dut.u_ppu.u_oam.mem[2]  === 8'h01,            "cpu write to oam during dma was dropped");
        check(dut.u_wram.mem[13'h016] === 8'hFF,            "hram readback of the blocked read is ff");
        check(dut.u_wram.mem[13'h015] === 8'h00,            "wram readback of the dropped write is 00");

        // interrupts, ppu registers over the bus
        check(dut.u_wram.mem[13'h030] >= 8'h01,             "vblank interrupt reached the handler");
        check(dut.u_wram.mem[13'h031] === 8'hEE,            "cpu returned from the handler with reti");
        check(dut.u_wram.mem[13'h032] >= 8'h90 && dut.u_wram.mem[13'h032] <= 8'h99, "cpu read ly in the vblank range");
        check(lcd_on === 1'b1,                              "lcd is on");

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED", checks);
        else             $display("%0d of %0d CHECKS FAILED", errors, checks);
        $finish;
    end

endmodule
