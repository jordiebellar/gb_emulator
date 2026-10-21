// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_vram.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : directed test for vram, driven by bus_master so reads are
//                  sampled on the ce_m edge the way the cpu samples them.
//                  write and readback across the full 8kb range while
//                  unblocked, back to back reads of different addresses
//                  (the stale read regression), blocked reads returning
//                  $FF and blocked writes being genuinely dropped while
//                  locked, sel gating, a partial write that must not
//                  commit, data_out=0 when deselected, and the ppu-internal
//                  render port working continuously regardless of the lock.
//                  vram has two lock inputs, blocked_next for reads and
//                  wr_blocked_next for writes, because hardware locks writes
//                  later than reads. each is tested alone, so a lock wired to
//                  the wrong side shows up. the dut decides from the values
//                  after the edge. most accesses hold them steady. the
//                  transition tests make one change in the last clock of an
//                  access, so the lock flips exactly on the edge the access
//                  commits on.
// Revision     : 4.0 - separate read and write lock inputs, replacing the
//                  mode_next input.
//                  3.0 - blocking tested against mode_next, with accesses
//                  that land exactly on a mode transition edge.
//                  2.0 - driven by bus_master with the real ce_m, added the
//                  stale read regression and the partial write check.
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_vram;

    reg clk;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    reg [1:0] m_cnt;
    initial m_cnt = 2'd0;
    always @(posedge clk) m_cnt <= m_cnt + 2'd1;
    wire ce_m = (m_cnt == 2'd3);

    wire [15:0] addr;
    wire [7:0]  wdata;
    wire        we, bm_sel;
    wire [7:0]  data_out;
    wire        stall;
    reg         sel_en;
    reg         rl_before, rl_after, wl_before, wl_after;
    wire        late;
    // each lock is its before value until the last clock of an access, then
    // its after value, which is what the cpu's edge sees
    wire        rl_next = late ? rl_after : rl_before;
    wire        wl_next = late ? wl_after : wl_before;
    reg  [12:0] render_addr;
    wire [7:0]  render_data;

    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(wdata),
                   .we(we), .sel(bm_sel), .late(late), .rdata(data_out));

    vram dut (
        .clk(clk), .ce_gb(1'b0), .ce_m(ce_m), .rst(1'b0),
        .addr(addr), .data_in(wdata), .we(we), .sel(bm_sel & sel_en),
        .data_out(data_out), .stall(stall), .blocked_next(rl_next),
        .wr_blocked_next(wl_next),
        .render_addr(render_addr), .render_data(render_data)
    );

    task set_lock(input r, input w);
        begin rl_before = r; rl_after = r; wl_before = w; wl_after = w; end
    endtask

    integer errors = 0;
    integer checks = 0;

    task check(input expr, input [8*72:1] label);
        begin
            checks = checks + 1;
            if (!expr) begin
                errors = errors + 1;
                $display("FAIL %0s (read 0x%02h)", label, bm.rd);
            end
        end
    endtask

    task check_render(input [12:0] a, input [7:0] expected, input [8*72:1] label);
        begin
            render_addr = a;
            #1;
            checks = checks + 1;
            if (render_data !== expected) begin
                errors = errors + 1;
                $display("FAIL %0s: render_addr=%h expected=%h got=%h", label, a, expected, render_data);
            end
        end
    endtask

    initial begin
        sel_en = 1'b1; set_lock(1'b0, 1'b0); render_addr = 13'h0000;
        repeat (3) @(posedge clk);

        bm.read(16'h8000);
        check(bm.rd === 8'h00, "power-on, 0x8000 reads zero");

        bm.write(16'h8000, 8'h11); bm.read(16'h8000);
        check(bm.rd === 8'h11, "readback at first vram address 0x8000");
        bm.write(16'h9FFF, 8'h22); bm.read(16'h9FFF);
        check(bm.rd === 8'h22, "readback at last vram address 0x9FFF");
        bm.write(16'h8500, 8'h33); bm.read(16'h8500);
        check(bm.rd === 8'h33, "readback at a middle address");

        // the stale read regression: distinct addresses, back to back
        bm.write(16'h8700, 8'hA1); bm.write(16'h8701, 8'hA2); bm.write(16'h8702, 8'hA3);
        bm.read(16'h8700); check(bm.rd === 8'hA1, "back to back read 1 of 5, 0x8700");
        bm.read(16'h8701); check(bm.rd === 8'hA2, "back to back read 2 of 5, 0x8701");
        bm.read(16'h8702); check(bm.rd === 8'hA3, "back to back read 3 of 5, 0x8702");
        bm.read(16'h8701); check(bm.rd === 8'hA2, "back to back read 4 of 5, back to 0x8701");
        bm.read(16'h8700); check(bm.rd === 8'hA1, "back to back read 5 of 5, back to 0x8700");

        // both locks on, the way mode 3 leaves them
        set_lock(1'b1, 1'b1);
        bm.read(16'h8000);
        check(bm.rd === 8'hFF, "blocked read returns $FF while locked");
        bm.write(16'h8000, 8'hEE);
        set_lock(1'b0, 1'b0);
        bm.read(16'h8000);
        check(bm.rd === 8'h11, "blocked write was genuinely dropped, original value intact");

        // the two locks are independent. reads locked, writes open is the
        // window just after the fetcher starts on hardware
        set_lock(1'b1, 1'b0);
        bm.write(16'h8030, 8'h77);
        bm.read(16'h8030);
        check(bm.rd === 8'hFF, "read lock alone blocks the read");
        set_lock(1'b0, 1'b0);
        bm.read(16'h8030);
        check(bm.rd === 8'h77, "read lock alone does not block the write");
        set_lock(1'b0, 1'b1);
        bm.write(16'h8030, 8'h88);
        bm.read(16'h8030);
        check(bm.rd === 8'h77, "write lock alone does not block the read, and drops the write");

        // accesses landing exactly on a lock edge are decided by the lock
        // after that edge, not the lock before it
        set_lock(1'b0, 1'b0);
        bm.write(16'h8020, 8'h6D);
        wl_before = 1'b0; wl_after = 1'b1;
        bm.write(16'h8000, 8'hEE);
        set_lock(1'b0, 1'b0); bm.read(16'h8000);
        check(bm.rd === 8'h11, "write on the edge that locks writes is dropped");
        wl_before = 1'b1; wl_after = 1'b0;
        bm.write(16'h8010, 8'h5C);
        set_lock(1'b0, 1'b0); bm.read(16'h8010);
        check(bm.rd === 8'h5C, "write on the edge that unlocks writes lands");
        rl_before = 1'b0; rl_after = 1'b1;
        bm.read(16'h8020);
        check(bm.rd === 8'hFF, "read on the edge that locks reads returns $FF");
        rl_before = 1'b1; rl_after = 1'b0;
        bm.read(16'h8020);
        check(bm.rd === 8'h6D, "read on the edge that unlocks reads returns the data");
        set_lock(1'b0, 1'b0);

        // sel gating and the partial write
        bm.write(16'h8600, 8'h44);
        sel_en = 1'b0; bm.write(16'h8600, 8'h55); sel_en = 1'b1;
        bm.read(16'h8600);
        check(bm.rd === 8'h44, "write ignored while sel low");
        bm.write_short(16'h8600, 8'h66);
        bm.read(16'h8600);
        check(bm.rd === 8'h44, "a partial write with no ce_m edge inside it does not commit");

        #1;
        check(data_out === 8'h00, "data_out reads 0 when sel is low");

        // render port, never blocked
        check_render(13'h0000, 8'h11, "render port reads addr 0x0000 (0x8000)");
        check_render(13'h1FFF, 8'h22, "render port reads addr 0x1FFF (0x9FFF)");
        set_lock(1'b1, 1'b1);
        check_render(13'h0500, 8'h33, "render port still works while locked, only the cpu is blocked");
        set_lock(1'b0, 1'b0);

        if (errors == 0) $display("all %0d checks passed", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule