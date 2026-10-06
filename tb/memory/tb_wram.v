// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_wram.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : directed test for wram, driven by bus_master so reads are
//                  sampled the way the cpu samples them, on the ce_m edge.
//                  basic write and readback, echo ram mirroring in both
//                  directions, echo boundary masking, back-to-back reads of
//                  different addresses (the stale read regression), sel
//                  gating, a partial write that must not commit, adjacent
//                  location isolation, and data_out reading 0 when sel is
//                  low.
// Revision     : 3.0 - driven by bus_master with the real ce_m, one in four
//                  clocks. reads sampled on the ce_m edge. added the stale
//                  read regression and the partial write check.
//                  2.0 - ce split into ce_gb/ce_m
// =============================================================================
`timescale 1ns / 1ps

module tb_wram;

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

    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(wdata),
                   .we(we), .sel(bm_sel), .rdata(data_out));

    wram dut (
        .clk(clk), .ce_gb(1'b0), .ce_m(ce_m), .rst(1'b0),
        .addr(addr), .data_in(wdata), .we(we), .sel(bm_sel & sel_en),
        .data_out(data_out), .stall(stall)
    );

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

    initial begin
        sel_en = 1'b1;
        repeat (3) @(posedge clk);

        bm.read(16'hC000);
        check(bm.rd === 8'h00, "power-on, 0xC000 reads zero");

        bm.write(16'hC000, 8'h11); bm.read(16'hC000);
        check(bm.rd === 8'h11, "readback at first wram address 0xC000");
        bm.write(16'hC100, 8'h22); bm.read(16'hC100);
        check(bm.rd === 8'h22, "readback at 0xC100");
        bm.write(16'hDFFF, 8'h33); bm.read(16'hDFFF);
        check(bm.rd === 8'h33, "readback at last wram address 0xDFFF");

        bm.write(16'hC010, 8'h44); bm.read(16'hE010);
        check(bm.rd === 8'h44, "echo mirrors real write, 0xE010 == 0xC010");
        bm.write(16'hE100, 8'h55); bm.read(16'hC100);
        check(bm.rd === 8'h55, "real reflects echo write, 0xC100 == 0xE100");
        bm.write(16'hDDFF, 8'h66); bm.read(16'hFDFF);
        check(bm.rd === 8'h66, "echo boundary, 0xFDFF mirrors 0xDDFF");

        // the stale read regression: distinct addresses, back to back
        bm.write(16'hC300, 8'hA1); bm.write(16'hC301, 8'hA2); bm.write(16'hC302, 8'hA3);
        bm.read(16'hC300); check(bm.rd === 8'hA1, "back to back read 1 of 5, 0xC300");
        bm.read(16'hC301); check(bm.rd === 8'hA2, "back to back read 2 of 5, 0xC301");
        bm.read(16'hC302); check(bm.rd === 8'hA3, "back to back read 3 of 5, 0xC302");
        bm.read(16'hC301); check(bm.rd === 8'hA2, "back to back read 4 of 5, back to 0xC301");
        bm.read(16'hC300); check(bm.rd === 8'hA1, "back to back read 5 of 5, back to 0xC300");

        // sel gating
        bm.write(16'hC200, 8'h77);
        sel_en = 1'b0; bm.write(16'hC200, 8'hEE); sel_en = 1'b1;
        bm.read(16'hC200);
        check(bm.rd === 8'h77, "write ignored while sel low");

        // a write released before the ce_m edge must not commit
        bm.write_short(16'hC200, 8'hDD);
        bm.read(16'hC200);
        check(bm.rd === 8'h77, "a partial write with no ce_m edge inside it does not commit");

        bm.write(16'hC400, 8'hAA); bm.write(16'hC401, 8'hBB);
        bm.read(16'hC400);
        check(bm.rd === 8'hAA, "adjacent location 1 unaffected by neighbor write");
        bm.read(16'hC401);
        check(bm.rd === 8'hBB, "adjacent location 2 holds its own value");

        // sel is low again once the access ends, so the output must be 0.
        // the #1 lets the continuous assign settle after sel drops
        #1;
        check(data_out === 8'h00, "data_out reads 0 when sel is low");

        if (errors == 0) $display("all %0d checks passed", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule