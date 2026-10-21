// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_oam.v
// Author       : Aaron Luebbert
// Date         : 2026-10-12
// Description  : directed testbench for oam - write/readback across the whole
//                  160 bytes, data_out=0 when deselected, blocking while the
//                  ppu has oam locked and while the oam dma unit is running
//                  (reads 0xFF, writes dropped), the lock after the edge
//                  deciding the block rather than the lock now, ce_m gating of
//                  writes, the ppu-internal entry port working whatever the
//                  lock and packing the four bytes of an object in the right
//                  order, and the dma write port landing whatever the lock.
//
//                  oam has two lock inputs, blocked_next for reads and
//                  wr_blocked_next for writes, because hardware locks writes
//                  later than reads. each is tested alone so a lock wired to
//                  the wrong side shows up.
//
//                  the dut decides blocking from those two and dma_active,
//                  all driven here the way ppu_mode_fsm and oam_dma drive
//                  them. cpu accesses are one clock wide with ce_m high, the
//                  read data is sampled on the clock after, like the cpu does
//                  on the ce_m edge that ends its m-cycle.
// Revision     : 5.0 - separate read and write lock inputs, replacing the
//                  mode_next input.
//                  4.0 - rewritten for oam 3.0. the render port checks became
//                  entry port checks, and the dma write port is tested.
// =============================================================================
`timescale 1ns / 1ps

module tb_oam;

    reg         clk;
    reg         ce_gb, ce_m, rst;
    reg  [15:0] addr;
    reg  [7:0]  data_in;
    reg         we, sel;
    wire [7:0]  data_out;
    wire        stall;
    reg         rl, wl;     // read lock and write lock, after this edge
    reg         dma_active;
    reg  [5:0]  entry_idx;
    wire [31:0] entry_data;
    reg         dma_we;
    reg  [7:0]  dma_waddr, dma_wdata;

    // the modes the old tests were written in, as locks. mode 2 and 3 lock
    // both reads and writes, hblank and vblank lock neither
    task set_lock(input r, input w);
        begin rl = r; wl = w; end
    endtask

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;
    integer checks = 0;
    integer i;
    reg [7:0] rd;

    oam dut (
        .clk(clk), .ce_gb(ce_gb), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(data_in), .we(we), .sel(sel),
        .data_out(data_out), .stall(stall),
        .blocked_next(rl), .wr_blocked_next(wl), .dma_active(dma_active),
        .entry_idx(entry_idx), .entry_data(entry_data),
        .dma_we(dma_we), .dma_waddr(dma_waddr), .dma_wdata(dma_wdata)
    );

    task check(input ok, input [8*100:1] label);
        begin
            checks = checks + 1;
            if (!ok) begin
                errors = errors + 1;
                $display("FAIL %0s", label);
            end
        end
    endtask

    // one cpu write, a single clock wide, committing on the edge
    task cpu_write(input [15:0] a, input [7:0] d);
        begin
            @(negedge clk);
            addr = a; data_in = d; we = 1'b1; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            we = 1'b0;
        end
    endtask

    // one cpu read. the read register is clocked every clock, so data_out
    // has settled by the clock after the address is presented
    task cpu_read(input [15:0] a);
        begin
            @(negedge clk);
            addr = a; we = 1'b0; sel = 1'b1;
            @(posedge clk);
            @(negedge clk);
            rd = data_out;
        end
    endtask

    task check_read(input [15:0] a, input [7:0] expected, input [8*100:1] label);
        begin
            cpu_read(a);
            checks = checks + 1;
            if (rd !== expected) begin
                errors = errors + 1;
                $display("FAIL %0s: addr=%h expected=%h got=%h", label, a, expected, rd);
            end
        end
    endtask

    task check_entry(input [5:0] idx, input [31:0] expected, input [8*100:1] label);
        begin
            entry_idx = idx;
            #1;
            checks = checks + 1;
            if (entry_data !== expected) begin
                errors = errors + 1;
                $display("FAIL %0s: entry=%0d expected=%h got=%h", label, idx, expected, entry_data);
            end
        end
    endtask

    // one dma write, the way the dma unit does it, a single clock wide
    task dma_write(input [7:0] a, input [7:0] d);
        begin
            @(negedge clk);
            dma_waddr = a; dma_wdata = d; dma_we = 1'b1;
            @(posedge clk);
            @(negedge clk);
            dma_we = 1'b0;
        end
    endtask

    initial begin
        ce_gb = 1'b1; ce_m = 1'b1; rst = 1'b0;
        addr = 16'hFE00; data_in = 8'h00; we = 1'b0; sel = 1'b0;
        set_lock(1'b0, 1'b0); dma_active = 1'b0;
        entry_idx = 6'd0;
        dma_we = 1'b0; dma_waddr = 8'h00; dma_wdata = 8'h00;
        repeat (3) @(posedge clk);

        // ---------------------------------------------------------------- basics
        check(stall === 1'b0, "stall is never asserted, the cpu is never held");
        check_read(16'hFE00, 8'h00, "oam powers up as zeros");
        check_read(16'hFE9F, 8'h00, "the last byte powers up as zero too");

        cpu_write(16'hFE00, 8'h11); check_read(16'hFE00, 8'h11, "write and read back at 0xFE00");
        cpu_write(16'hFE9F, 8'h22); check_read(16'hFE9F, 8'h22, "write and read back at 0xFE9F, the last byte");
        cpu_write(16'hFE50, 8'h33); check_read(16'hFE50, 8'h33, "write and read back in the middle");
        check_read(16'hFE00, 8'h11, "earlier writes are untouched");

        // every byte holds its own value
        for (i = 0; i < 160; i = i + 1) cpu_write(16'hFE00 + i, (i * 7 + 3) & 8'hFF);
        begin : sweep
            integer bad;
            bad = 0;
            for (i = 0; i < 160; i = i + 1) begin
                cpu_read(16'hFE00 + i);
                if (rd !== ((i * 7 + 3) & 8'hFF)) bad = bad + 1;
            end
            check(bad == 0, "all 160 bytes hold their own value, no aliasing");
        end

        // deselected
        @(negedge clk); sel = 1'b0; addr = 16'hFE10;
        @(posedge clk); @(negedge clk);
        check(data_out === 8'h00, "data_out is 0 when deselected");
        @(negedge clk);
        addr = 16'hFE10; data_in = 8'hEE; we = 1'b1; sel = 1'b0;
        @(posedge clk); @(negedge clk); we = 1'b0; sel = 1'b1;
        check_read(16'hFE10, (16 * 7 + 3) & 8'hFF, "a write with sel low is ignored");

        // ce_m gating
        @(negedge clk);
        ce_m = 1'b0; addr = 16'hFE10; data_in = 8'hEE; we = 1'b1; sel = 1'b1;
        @(posedge clk); @(negedge clk); we = 1'b0; ce_m = 1'b1;
        check_read(16'hFE10, (16 * 7 + 3) & 8'hFF, "a write on a clock with ce_m low is ignored");

        // ---------------------------------------------------------------- blocking
        cpu_write(16'hFE20, 8'h5A);
        set_lock(1'b1, 1'b1);
        check_read(16'hFE20, 8'hFF, "locked as in mode 2: reads return 0xFF");
        cpu_write(16'hFE20, 8'hA5);
        set_lock(1'b0, 1'b0);
        check_read(16'hFE20, 8'h5A, "locked as in mode 2: the write was dropped");

        set_lock(1'b1, 1'b1);
        check_read(16'hFE20, 8'hFF, "locked as in mode 3: reads return 0xFF");
        cpu_write(16'hFE20, 8'hA5);
        set_lock(1'b0, 1'b0);
        check_read(16'hFE20, 8'h5A, "locked as in mode 3: the write was dropped");

        set_lock(1'b0, 1'b0);
        check_read(16'hFE20, 8'h5A, "vblank: reads work");
        cpu_write(16'hFE20, 8'h6B);
        check_read(16'hFE20, 8'h6B, "vblank: writes work");
        set_lock(1'b0, 1'b0);
        cpu_write(16'hFE20, 8'h7C);
        check_read(16'hFE20, 8'h7C, "hblank: writes work");

        // the two locks are independent
        set_lock(1'b1, 1'b0);
        cpu_write(16'hFE22, 8'h31);
        check_read(16'hFE22, 8'hFF, "read lock alone blocks the read");
        set_lock(1'b0, 1'b0);
        check_read(16'hFE22, 8'h31, "read lock alone did not block the write");
        set_lock(1'b0, 1'b1);
        cpu_write(16'hFE22, 8'h42);
        check_read(16'hFE22, 8'h31, "write lock alone does not block the read, and drops the write");
        set_lock(1'b0, 1'b0);

        // dma blocks the cpu whatever the locks say
        dma_active = 1'b1;
        check_read(16'hFE20, 8'hFF, "dma running in hblank: reads return 0xFF");
        cpu_write(16'hFE20, 8'h99);
        dma_active = 1'b0;
        check_read(16'hFE20, 8'h7C, "dma running: the write was dropped");
        set_lock(1'b0, 1'b0); dma_active = 1'b1;
        check_read(16'hFE20, 8'hFF, "dma running in vblank: still blocked");
        dma_active = 1'b0; set_lock(1'b0, 1'b0);

        // it is the lock after the edge that blocks, not the lock now
        @(negedge clk);
        set_lock(1'b1, 1'b1); addr = 16'hFE30; data_in = 8'hAB; we = 1'b1; sel = 1'b1;
        @(posedge clk); @(negedge clk); we = 1'b0; set_lock(1'b0, 1'b0);
        check_read(16'hFE30, (48 * 7 + 3) & 8'hFF, "a write on the edge that locks writes is dropped");
        @(negedge clk);
        set_lock(1'b0, 1'b0); addr = 16'hFE30; data_in = 8'hAB; we = 1'b1; sel = 1'b1;
        @(posedge clk); @(negedge clk); we = 1'b0;
        check_read(16'hFE30, 8'hAB, "and a write on the edge before it lands");

        // ---------------------------------------------------------------- entry port
        // earlier in the test 0xFE00 was set to 0x11 and then swept, so rewrite
        // the bytes the entry checks depend on
        for (i = 0; i < 160; i = i + 1) cpu_write(16'hFE00 + i, 8'h00);
        cpu_write(16'hFE00, 8'h11);
        cpu_write(16'hFE9F, 8'h22);
        cpu_write(16'hFE50, 8'h33);
        cpu_write(16'hFE70, 8'hA1); cpu_write(16'hFE71, 8'hA2); cpu_write(16'hFE72, 8'hA3);
        check_entry(6'd0,  32'h0000_0011, "entry 0: y is the byte at 0xFE00, the rest zero");
        check_entry(6'd39, 32'h2200_0000, "entry 39: the attribute byte is 0xFE9F, bits 31:24");
        check_entry(6'd20, 32'h0000_0033, "entry 20: y is the byte at 0xFE50");
        check_entry(6'd28, 32'h00A3_A2A1, "entry 28: bytes 0xFE70 to 0xFE72 land as y, x, tile");
        check_entry(6'd40, 32'hFFFF_FFFF, "an index past 39 reads as all ones");
        check_entry(6'd63, 32'hFFFF_FFFF, "the largest index reads as all ones too");
        set_lock(1'b1, 1'b1);
        check_entry(6'd20, 32'h0000_0033, "entry port still works during mode 2");
        set_lock(1'b1, 1'b1);
        check_entry(6'd20, 32'h0000_0033, "entry port still works during mode 3");
        dma_active = 1'b1;
        check_entry(6'd20, 32'h0000_0033, "entry port still works even during oam dma");
        dma_active = 1'b0;
        set_lock(1'b0, 1'b0);

        // the four bytes of one object, written in order, come out packed
        cpu_write(16'hFE04, 8'h10); cpu_write(16'hFE05, 8'h20);
        cpu_write(16'hFE06, 8'h30); cpu_write(16'hFE07, 8'h40);
        check_entry(6'd1, 32'h4030_2010, "entry 1 packs y 10, x 20, tile 30, attributes 40 in that order");

        // ---------------------------------------------------------------- dma write port
        set_lock(1'b0, 1'b0);  dma_write(8'h08, 8'hA8);
        check_entry(6'd2, 32'h0000_00A8, "dma write lands in hblank");
        set_lock(1'b1, 1'b1); dma_write(8'h09, 8'hB9);
        check_entry(6'd2, 32'h0000_B9A8, "dma write lands while the ppu has oam locked, where the cpu is blocked");
        set_lock(1'b1, 1'b1); dma_write(8'h0A, 8'hCA);
        check_entry(6'd2, 32'h00CA_B9A8, "dma write lands with both locks on, where the cpu is blocked");
        dma_active = 1'b1; set_lock(1'b0, 1'b0); dma_write(8'h0B, 8'hDB);
        check_entry(6'd2, 32'hDBCA_B9A8, "dma write lands while dma_active is high");
        dma_write(8'h9F, 8'h5E);
        check_entry(6'd39, 32'h5E00_0000, "dma write at the last oam byte, 159, lands");
        dma_write(8'hA0, 8'h77);
        dma_write(8'hFF, 8'h77);
        check_entry(6'd39, 32'h5E00_0000, "dma writes at 160 and up are dropped, nothing past the end changes");
        check_entry(6'd0,  32'h0000_0011, "and entry 0 was not hit by a wrapped address");
        dma_active = 1'b0;
        check_read(16'hFE08, 8'hA8, "the cpu reads back a byte the dma wrote, once dma is over");
        dma_waddr = 8'h09; dma_wdata = 8'h00;     // dma_we low must not write
        @(negedge clk); @(posedge clk); @(negedge clk);
        check_read(16'hFE09, 8'hB9, "with dma_we low nothing is written, whatever the address and data say");

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - oam verified, cpu port, entry port, and dma port", checks);
        else             $display("%0d of %0d CHECKS FAILED", errors, checks);
        $finish;
    end

    initial begin
        #20000000;
        $display("FAIL timeout");
        $finish;
    end

endmodule
