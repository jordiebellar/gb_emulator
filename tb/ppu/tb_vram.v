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
//                  $FF and blocked writes being genuinely dropped during
//                  mode 3, sel gating, a partial write that must not
//                  commit, data_out=0 when deselected, and the ppu-internal
//                  render port working continuously regardless of mode.
//                  the dut decides blocking from mode_next, the mode after
//                  the edge. most accesses hold it steady. the transition
//                  tests make it change in the last clock of an access, so
//                  the mode flips exactly on the edge the access commits on.
// Revision     : 3.0 - blocking tested against mode_next, with accesses
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

    localparam MODE_HBLANK         = 2'd0;
    localparam MODE_VBLANK         = 2'd1;
    localparam MODE_OAM_SCAN       = 2'd2;
    localparam MODE_PIXEL_TRANSFER = 2'd3;

    wire [15:0] addr;
    wire [7:0]  wdata;
    wire        we, bm_sel;
    wire [7:0]  data_out;
    wire        stall;
    reg         sel_en;
    reg  [1:0]  mode_before, mode_after;
    wire        late;
    // mode_next is mode_before until the last clock of an access, then
    // mode_after, which is what the cpu's edge sees
    wire [1:0]  mode_next = late ? mode_after : mode_before;
    reg  [12:0] render_addr;
    wire [7:0]  render_data;

    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(wdata),
                   .we(we), .sel(bm_sel), .late(late), .rdata(data_out));

    vram dut (
        .clk(clk), .ce_gb(1'b0), .ce_m(ce_m), .rst(1'b0),
        .addr(addr), .data_in(wdata), .we(we), .sel(bm_sel & sel_en),
        .data_out(data_out), .stall(stall), .mode_next(mode_next),
        .render_addr(render_addr), .render_data(render_data)
    );

    task set_mode(input [1:0] m);
        begin mode_before = m; mode_after = m; end
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
        sel_en = 1'b1; set_mode(MODE_HBLANK); render_addr = 13'h0000;
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

        // blocked during mode 3
        set_mode(MODE_PIXEL_TRANSFER);
        bm.read(16'h8000);
        check(bm.rd === 8'hFF, "blocked read returns $FF during mode 3");
        bm.write(16'h8000, 8'hEE);
        set_mode(MODE_HBLANK);
        bm.read(16'h8000);
        check(bm.rd === 8'h11, "blocked write was genuinely dropped, original value intact");

        set_mode(MODE_OAM_SCAN);
        bm.read(16'h8500);
        check(bm.rd === 8'h33, "oam scan does not block vram");
        set_mode(MODE_VBLANK);
        bm.read(16'h8500);
        check(bm.rd === 8'h33, "vblank does not block vram");
        set_mode(MODE_HBLANK);

        // accesses landing exactly on a mode transition edge are decided by
        // the mode after that edge, not the mode before it
        bm.write(16'h8020, 8'h6D);
        mode_before = MODE_HBLANK; mode_after = MODE_PIXEL_TRANSFER;
        bm.write(16'h8000, 8'hEE);
        set_mode(MODE_HBLANK); bm.read(16'h8000);
        check(bm.rd === 8'h11, "write on the edge that enters mode 3 is dropped");
        mode_before = MODE_PIXEL_TRANSFER; mode_after = MODE_HBLANK;
        bm.write(16'h8010, 8'h5C);
        set_mode(MODE_HBLANK); bm.read(16'h8010);
        check(bm.rd === 8'h5C, "write on the edge that leaves mode 3 lands");
        mode_before = MODE_HBLANK; mode_after = MODE_PIXEL_TRANSFER;
        bm.read(16'h8020);
        check(bm.rd === 8'hFF, "read on the edge that enters mode 3 returns $FF");
        mode_before = MODE_PIXEL_TRANSFER; mode_after = MODE_HBLANK;
        bm.read(16'h8020);
        check(bm.rd === 8'h6D, "read on the edge that leaves mode 3 returns the data");
        set_mode(MODE_HBLANK);

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
        set_mode(MODE_PIXEL_TRANSFER);
        check_render(13'h0500, 8'h33, "render port still works during mode 3, only the cpu is blocked");
        set_mode(MODE_HBLANK);

        if (errors == 0) $display("all %0d checks passed", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule