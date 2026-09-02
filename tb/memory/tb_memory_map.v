// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_memory_map.v
// Author       : Aaron Luebbert
// Date         : 2026-09-02
// Description  : directed smoke test for memory_map decode, mux, and stall
//                  logic, every peripheral tied to a distinct constant so
//                  mux correctness can be checked directly
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_memory_map;

    // --- clock / reset ------------------------------------------------------
    reg clk_100m;
    reg ce;
    reg rst;

    initial clk_100m = 1'b0;
    always #5 clk_100m = ~clk_100m; // 100MHz, 10ns period

    // --- dut inputs -----------------------------------------------------
    reg  [15:0] addr;
    reg  [7:0]  data_out;
    reg         we;

    // --- dut outputs ------------------------------------------------------
    wire [7:0]  data_in;
    wire        bus_stall;

    wire sel_cart_rom, sel_cart_ram, sel_wram, sel_ppu_vram, sel_ppu_oam;
    wire sel_ppu_reg, sel_joypad, sel_serial, sel_timer, sel_apu, sel_hram;

    // --- peripheral stand-ins ---------------------------------------------
    // each tied to a distinct constant so we can confirm the mux picked
    // the right one, not just that it picked something
    reg [7:0] cart_rom_data_out; reg cart_rom_stall;
    reg [7:0] cart_ram_data_out; reg cart_ram_stall;
    reg [7:0] wram_data_out;     reg wram_stall;
    reg [7:0] ppu_vram_data_out; reg ppu_vram_stall;
    reg [7:0] ppu_oam_data_out;  reg ppu_oam_stall;
    reg [7:0] ppu_reg_data_out;  reg ppu_reg_stall;
    reg [7:0] joypad_data_out;   reg joypad_stall;
    reg [7:0] serial_data_out;   reg serial_stall;
    reg [7:0] timer_data_out;    reg timer_stall;
    reg [7:0] apu_data_out;      reg apu_stall;
    reg [7:0] hram_data_out;     reg hram_stall;

    // --- pass/fail bookkeeping ---------------------------------------------
    integer errors = 0;
    integer checks = 0;

    memory_map dut (
        .clk_100m       (clk_100m),
        .ce             (ce),
        .rst            (rst),
        .addr           (addr),
        .data_out       (data_out),
        .data_in        (data_in),
        .we             (we),
        .bus_stall      (bus_stall),

        .sel_cart_rom      (sel_cart_rom),
        .cart_rom_data_out (cart_rom_data_out),
        .cart_rom_stall    (cart_rom_stall),

        .sel_cart_ram      (sel_cart_ram),
        .cart_ram_data_out (cart_ram_data_out),
        .cart_ram_stall    (cart_ram_stall),

        .sel_wram       (sel_wram),
        .wram_data_out  (wram_data_out),
        .wram_stall     (wram_stall),

        .sel_ppu_vram      (sel_ppu_vram),
        .ppu_vram_data_out (ppu_vram_data_out),
        .ppu_vram_stall    (ppu_vram_stall),

        .sel_ppu_oam       (sel_ppu_oam),
        .ppu_oam_data_out  (ppu_oam_data_out),
        .ppu_oam_stall     (ppu_oam_stall),

        .sel_ppu_reg       (sel_ppu_reg),
        .ppu_reg_data_out  (ppu_reg_data_out),
        .ppu_reg_stall     (ppu_reg_stall),

        .sel_joypad     (sel_joypad),
        .joypad_data_out(joypad_data_out),
        .joypad_stall   (joypad_stall),

        .sel_serial     (sel_serial),
        .serial_data_out(serial_data_out),
        .serial_stall   (serial_stall),

        .sel_timer      (sel_timer),
        .timer_data_out (timer_data_out),
        .timer_stall    (timer_stall),

        .sel_apu        (sel_apu),
        .apu_data_out   (apu_data_out),
        .apu_stall      (apu_stall),

        .sel_hram       (sel_hram),
        .hram_data_out  (hram_data_out),
        .hram_stall     (hram_stall)
    );

    // --- directed check task -----------------------------------------------
    // drives one address, waits a cycle, checks data_in and bus_stall
    // against expected values, we stays low for all decode/mux checks
    task check_read(input [15:0] test_addr, input [7:0] expected_data,
                     input expected_stall, input [255:0] label);
        begin
            @(negedge clk_100m);
            addr = test_addr;
            we   = 1'b0;
            @(negedge clk_100m); // let combinational logic settle
            checks = checks + 1;
            if (data_in !== expected_data) begin
                errors = errors + 1;
                $display("FAIL %s: addr=%h expected data_in=%h got=%h",
                          label, test_addr, expected_data, data_in);
            end
            if (bus_stall !== expected_stall) begin
                errors = errors + 1;
                $display("FAIL %s: addr=%h expected bus_stall=%b got=%b",
                          label, test_addr, expected_stall, bus_stall);
            end
        end
    endtask

    initial begin
        // tie every peripheral to a distinct constant, stalls low to start
        cart_rom_data_out = 8'hA1; cart_rom_stall = 1'b0;
        cart_ram_data_out = 8'hA2; cart_ram_stall = 1'b0;
        wram_data_out     = 8'hA3; wram_stall     = 1'b0;
        ppu_vram_data_out = 8'hA4; ppu_vram_stall = 1'b0;
        ppu_oam_data_out  = 8'hA5; ppu_oam_stall  = 1'b0;
        ppu_reg_data_out  = 8'hA6; ppu_reg_stall  = 1'b0;
        joypad_data_out   = 8'hA7; joypad_stall   = 1'b0;
        serial_data_out   = 8'hA8; serial_stall   = 1'b0;
        timer_data_out    = 8'hA9; timer_stall    = 1'b0;
        apu_data_out      = 8'hAA; apu_stall      = 1'b0;
        hram_data_out     = 8'hAB; hram_stall     = 1'b0;

        addr     = 16'h0000;
        data_out = 8'h00;
        we       = 1'b0;
        ce       = 1'b1;

        // --- reset -------------------------------------------------------
        rst = 1'b1;
        repeat (2) @(posedge clk_100m);
        rst = 1'b0;

        // --- decode / mux, one address per range ------------------------
        check_read(16'h0100, 8'hA1, 1'b0, "cart rom");
        check_read(16'h9000, 8'hA4, 1'b0, "ppu vram");
        check_read(16'hA100, 8'hA2, 1'b0, "cart ram");
        check_read(16'hC100, 8'hA3, 1'b0, "wram");
        check_read(16'hE100, 8'hA3, 1'b0, "echo ram, mirrors wram");
        check_read(16'hFE10, 8'hA5, 1'b0, "oam");
        check_read(16'hFF00, 8'hA7, 1'b0, "joypad");
        check_read(16'hFF01, 8'hA8, 1'b0, "serial");
        check_read(16'hFF05, 8'hA9, 1'b0, "timer");
        check_read(16'hFF20, 8'hAA, 1'b0, "apu");
        check_read(16'hFF45, 8'hA6, 1'b0, "ppu registers");
        check_read(16'hFF90, 8'hAB, 1'b0, "hram");

        // --- unmapped gaps read as 0xff -------------------------------
        check_read(16'hFEA0, 8'hFF, 1'b0, "unusable region");
        check_read(16'hFF03, 8'hFF, 1'b0, "gap between joypad and timer");

        // --- stall only forwards from the currently selected peripheral -
        ppu_vram_stall = 1'b1;
        check_read(16'h9000, 8'hA4, 1'b1, "vram stall while selected");
        check_read(16'hC100, 8'hA3, 1'b0, "wram unaffected by vram stall");
        ppu_vram_stall = 1'b0;

        // --- ie / if write and readback ---------------------------------
        @(negedge clk_100m);
        addr = 16'hFFFF; data_out = 8'h1F; we = 1'b1;
        @(posedge clk_100m);
        @(negedge clk_100m);
        we = 1'b0;
        check_read(16'hFFFF, 8'h1F, 1'b0, "ie register readback");

        @(negedge clk_100m);
        addr = 16'hFF0F; data_out = 8'h05; we = 1'b1;
        @(posedge clk_100m);
        @(negedge clk_100m);
        we = 1'b0;
        check_read(16'hFF0F, 8'h05, 1'b0, "if register readback");

        // --- summary -------------------------------------------------------
        if (errors == 0)
            $display("all %0d checks passed", checks);
        else
            $display("%0d of %0d checks failed", errors, checks);

        $finish;
    end

endmodule
