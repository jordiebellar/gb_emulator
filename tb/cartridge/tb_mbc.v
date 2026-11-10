// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_mbc.v
// Author       : Aaron Luebbert
// Date         : 2026-11-09
// Description  : the cartridge with its mapper, cart ram and clock, driven
//                  directly on its ports with the rom in block ram. one run
//                  checks one mapper, picked by the KIND parameter (1 mbc1,
//                  2 mbc3 with the clock, 3 mbc5). every bank of the rom holds
//                  its own pattern so a wrong bank shows up as a wrong byte.
//
//                    - rom banking, including bank 0 reading as 1, masking to
//                      the cart size, and the mbc1 mode bit remapping 0000
//                    - writes that do not count (mbc_wr low, as during dma)
//                    - ram enable, ram banks, and the write lock when disabled
//                    - mbc3 clock, set, latch, read, halt, count, roll over
//                    - mbc5 banks 0 and 100 and above, and its exact enable
//
//                  run it once per mapper
//                    for k in 1 2 3; do
//                      iverilog -g2012 -P tb_mbc.KIND=$k -s tb_mbc -o mbc.vvp
//                        tb/cartridge/tb_mbc.v rtl/cartridge/*.v
//                      vvp mbc.vvp
//                    done
//                  it needs an empty none.hex in the working directory, the
//                  cartridge reads that name at time zero and the testbench
//                  then fills the rom array itself
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_mbc #(
    parameter integer KIND = 1
) (
);

    localparam integer ROMSZ    = (KIND == 3) ? 8 : 6;          // code, 8 mb or 2 mb
    localparam integer ROM_B    = (32768 << ROMSZ);
    localparam integer NBANKS   = (2 << ROMSZ);
    localparam [7:0]   HTYPE    = (KIND == 1) ? 8'h03 : (KIND == 2) ? 8'h10 : 8'h1B;
    localparam integer TICKS    = 4000;

    reg clk = 1'b0;
    reg rst = 1'b1;
    always #5 clk = ~clk;

    reg [1:0] m_cnt = 2'd0;
    always @(posedge clk) m_cnt <= m_cnt + 2'd1;
    wire ce_m = (m_cnt == 2'd3);

    reg  [15:0] addr = 16'd0, cpu_addr = 16'd0;
    reg  [7:0]  data_in = 8'd0;
    reg         we = 1'b0, sel_rom = 1'b0, rom_rd = 1'b0, mbc_wr = 1'b0, sel_ram = 1'b0, ram_we = 1'b0;
    wire [7:0]  data_out, ram_data_out;
    wire        stall;

    cartridge #(
        .BOOT_ROM_FILE("boot_boundary.hex"), .CART_ROM_FILE("none.hex"),
        .SD_MODE(0), .ROM_BYTES(ROM_B), .RAM_BYTES(32768), .RTC_TICKS(TICKS)
    ) dut (
        .clk(clk), .ce_gb(1'b0), .ce_m(ce_m), .rst(rst),
        .addr(addr), .cpu_addr(cpu_addr), .data_in(data_in), .we(we),
        .sel_cart_rom(sel_rom), .sel_boot_disable(1'b0),
        .rom_rd(rom_rd), .mbc_wr(mbc_wr), .sel_cart_ram(sel_ram), .ram_we(ram_we),
        .data_out(data_out), .ram_data_out(ram_data_out), .stall(stall),
        .sd_cs_n(), .sd_sck(), .sd_mosi(), .sd_miso(1'b1), .status()
    );

    function [7:0] pat(input integer bank, input integer off);
        begin pat = (bank * 3 + (bank >> 8) * 77 + off * 5) & 8'hFF; end
    endfunction

    integer checks = 0, fails = 0;
    task check(input cond, input [255:0] name);
        begin
            checks = checks + 1;
            if (!cond) begin fails = fails + 1; $display("FAIL  kind %0d  %0s", KIND, name); end
        end
    endtask

    // a bus write that lands on the next ce_m edge
    task wr(input [15:0] a, input [7:0] d);
        begin
            @(negedge clk);
            cpu_addr = a; data_in = d; we = 1'b1; ram_we = 1'b1;
            mbc_wr = (a < 16'h8000); sel_ram = (a >= 16'hA000 && a < 16'hC000);
            while (!ce_m) @(negedge clk);
            @(negedge clk);
            @(negedge clk); we = 1'b0; ram_we = 1'b0; mbc_wr = 1'b0; sel_ram = 1'b0;
        end
    endtask

    // a write the mapper must ignore, as while a dma transfer owns the bus
    task wr_dma(input [15:0] a, input [7:0] d);
        begin
            @(negedge clk);
            cpu_addr = a; data_in = d; we = 1'b1; ram_we = 1'b0; mbc_wr = 1'b0;
            while (!ce_m) @(negedge clk);
            @(negedge clk);
            @(negedge clk); we = 1'b0;
        end
    endtask

    reg [7:0] got;
    task rd_rom(input [15:0] a);
        begin
            @(negedge clk);
            addr = a; cpu_addr = a; sel_rom = 1'b1; rom_rd = 1'b1;
            repeat (6) @(negedge clk);
            got = data_out;
            sel_rom = 1'b0; rom_rd = 1'b0;
        end
    endtask

    task rd_ram(input [15:0] a);
        begin
            @(negedge clk);
            cpu_addr = a; sel_ram = 1'b1;
            repeat (6) @(negedge clk);
            got = ram_data_out;
            sel_ram = 1'b0;
        end
    endtask

    task expect_bank(input integer bank, input [255:0] name);
        begin
            rd_rom(16'h4000);
            check(got === pat(bank, 0), name);
            rd_rom(16'h7FFF);
            check(got === pat(bank, 16'h3FFF), name);
        end
    endtask

    integer i, b;
    initial begin
        for (i = 0; i < ROM_B; i = i + 1) dut.cart_rom[i] = pat(i >> 14, i & 16'h3FFF);
        dut.cart_rom[16'h0147] = HTYPE;
        dut.cart_rom[16'h0148] = ROMSZ;
        dut.cart_rom[16'h0149] = 8'd3;
        repeat (4) @(negedge clk);
        rst = 1'b0;
        repeat (20) @(negedge clk);

        // ---- rom banking ----
        rd_rom(16'h0200);
        check(got === pat(0, 16'h0200), "bank 0 at 0200");
        expect_bank(1, "reset state maps bank 1");

        wr(16'h2000, 8'h05);
        expect_bank(5, "bank 5");
        wr(16'h2000, 8'h00);
        if (KIND == 3) expect_bank(0, "mbc5 bank 0 is real bank 0");
        else           expect_bank(1, "bank 0 reads as bank 1");
        wr(16'h2000, 8'h1F);
        expect_bank(31, "bank 1f");

        wr_dma(16'h2000, 8'h07);
        expect_bank(31, "a write during dma changes nothing");

        if (KIND == 1) begin
            wr(16'h4000, 8'h02);
            wr(16'h2000, 8'h03);
            expect_bank(8'h43, "mbc1 bank2 supplies the upper bits");
            wr(16'h2000, 8'h00);
            expect_bank(8'h41, "mbc1 bank 40 reads as 41");
            wr(16'h6000, 8'h01);
            rd_rom(16'h0200);
            check(got === pat(8'h40, 16'h0200), "mbc1 mode 1 puts bank 40 at 0000");
            rd_rom(16'h3FFF);
            check(got === pat(8'h40, 16'h3FFF), "mbc1 mode 1 end of bank 40");
            wr(16'h6000, 8'h00);
            rd_rom(16'h0200);
            check(got === pat(0, 16'h0200), "mbc1 mode 0 puts bank 0 back");
            wr(16'h4000, 8'h00);
        end

        if (KIND == 2) begin
            wr(16'h2000, 8'h7F);
            expect_bank(8'h7F, "mbc3 bank 7f");
            wr(16'h2000, 8'h80);
            expect_bank(1, "mbc3 bank register is 7 bits, 80 reads as 1 on a 2 mb cart");
        end

        if (KIND == 3) begin
            wr(16'h2000, 8'hFF);
            wr(16'h3000, 8'h01);
            expect_bank(9'h1FF, "mbc5 bank 1ff");
            wr(16'h2000, 8'h00);
            expect_bank(9'h100, "mbc5 bank 100");
            wr(16'h3000, 8'h00);
            expect_bank(0, "mbc5 back to bank 0");
        end

        // ---- cart ram ----
        wr(16'h2000, 8'h02);
        rd_ram(16'hA000);
        check(got === 8'hFF, "ram disabled reads ff");
        wr(16'hA000, 8'h5A);
        wr(16'h0000, 8'h0B);
        wr(16'hA000, 8'h5A);
        if (KIND == 3) begin
            rd_ram(16'hA000);
            check(got === 8'hFF, "mbc5 enable needs exactly 0a");
        end
        wr(16'h0000, 8'h0A);
        rd_ram(16'hA000);
        check(got === 8'h00, "writes while disabled did not land");
        wr(16'hA000, 8'h5A);
        rd_ram(16'hA000);
        check(got === 8'h5A, "ram write and read back");
        wr(16'hBFFF, 8'hC3);
        rd_ram(16'hBFFF);
        check(got === 8'hC3, "ram top of the window");

        if (KIND == 1) wr(16'h6000, 8'h01);
        for (b = 1; b < 4; b = b + 1) begin
            wr(16'h4000, b);
            wr(16'hA000, 8'h10 + b);
        end
        wr(16'h4000, 8'h00);
        rd_ram(16'hA000);
        check(got === 8'h5A, "ram bank 0 kept its data");
        for (b = 1; b < 4; b = b + 1) begin
            wr(16'h4000, b);
            rd_ram(16'hA000);
            check(got === 8'h10 + b, "ram banks hold their own data");
        end
        if (KIND == 1) begin
            wr(16'h6000, 8'h00);
            rd_ram(16'hA000);
            check(got === 8'h5A, "mbc1 mode 0 always uses ram bank 0");
            wr(16'h6000, 8'h01);
        end
        wr(16'h0000, 8'h00);
        wr(16'h4000, 8'h00);
        rd_ram(16'hA000);
        check(got === 8'hFF, "ram disabled again");
        wr(16'h0000, 8'h0A);
        rd_ram(16'hA000);
        check(got === 8'h5A, "ram data survived being disabled");

        // ---- mbc3 clock ----
        if (KIND == 2) begin
            wr(16'h4000, 8'h0C); wr(16'hA000, 8'h40);              // halt
            wr(16'h4000, 8'h08); wr(16'hA000, 8'h10);
            wr(16'h4000, 8'h09); wr(16'hA000, 8'h20);
            wr(16'h4000, 8'h0A); wr(16'hA000, 8'h05);
            wr(16'h4000, 8'h0B); wr(16'hA000, 8'h7F);
            wr(16'h6000, 8'h00); wr(16'h6000, 8'h01);
            wr(16'h4000, 8'h08); rd_ram(16'hA000); check(got === 8'h10, "clock seconds");
            wr(16'h4000, 8'h09); rd_ram(16'hA000); check(got === 8'h20, "clock minutes");
            wr(16'h4000, 8'h0A); rd_ram(16'hA000); check(got === 8'h05, "clock hours");
            wr(16'h4000, 8'h0B); rd_ram(16'hA000); check(got === 8'h7F, "clock day low");
            wr(16'h4000, 8'h0C); rd_ram(16'hA000); check(got === 8'h40, "clock day high with halt");

            repeat (TICKS + 500) @(negedge clk);
            wr(16'h6000, 8'h00); wr(16'h6000, 8'h01);
            wr(16'h4000, 8'h08); rd_ram(16'hA000); check(got === 8'h10, "halted clock does not count");

            wr(16'h4000, 8'h0C); wr(16'hA000, 8'h00);              // run
            repeat (TICKS + 300) @(negedge clk);
            wr(16'h4000, 8'h08); rd_ram(16'hA000);
            check(got === 8'h10, "latched value holds until the next latch");
            wr(16'h6000, 8'h00); wr(16'h6000, 8'h01);
            wr(16'h4000, 8'h08); rd_ram(16'hA000); check(got === 8'h11, "one second later");

            // roll over everything
            wr(16'h4000, 8'h0C); wr(16'hA000, 8'h41);              // halt, day bit 8
            wr(16'h4000, 8'h08); wr(16'hA000, 8'd59);
            wr(16'h4000, 8'h09); wr(16'hA000, 8'd59);
            wr(16'h4000, 8'h0A); wr(16'hA000, 8'd23);
            wr(16'h4000, 8'h0B); wr(16'hA000, 8'hFF);
            wr(16'h4000, 8'h0C); wr(16'hA000, 8'h01);              // run, day 511
            repeat (TICKS + 300) @(negedge clk);
            wr(16'h6000, 8'h00); wr(16'h6000, 8'h01);
            wr(16'h4000, 8'h08); rd_ram(16'hA000); check(got === 8'd0, "seconds roll over");
            wr(16'h4000, 8'h09); rd_ram(16'hA000); check(got === 8'd0, "minutes roll over");
            wr(16'h4000, 8'h0A); rd_ram(16'hA000); check(got === 8'd0, "hours roll over");
            wr(16'h4000, 8'h0B); rd_ram(16'hA000); check(got === 8'd0, "day low rolls over");
            wr(16'h4000, 8'h0C); rd_ram(16'hA000); check(got === 8'h80, "day carry set");

            // ram bank select between 4 and 7 is nothing
            wr(16'h4000, 8'h05);
            rd_ram(16'hA000);
            check(got === 8'hFF, "ram bank 5 is not mapped");
        end

        $display("kind %0d: %0d checks, %0d failed", KIND, checks, fails);
        if (fails == 0) $display("ALL %0d CHECKS PASSED - mapper %0d verified", checks, KIND);
        $finish;
    end

    initial begin
        #60000000;
        $display("TIMEOUT");
        $finish;
    end

endmodule
