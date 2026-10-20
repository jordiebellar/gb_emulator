// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_hram.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : directed test for hram, driven by bus_master so reads are
//                  sampled on the ce_m edge the way the cpu samples them.
//                  write and readback across the 127 byte range, back to
//                  back reads of different addresses (the stale read
//                  regression), sel gating, a partial write that must not
//                  commit, adjacent location isolation, and data_out
//                  reading 0 when sel is low.
// Revision     : 3.0 - driven by bus_master with the real ce_m, added the
//                  stale read regression and the partial write check.
//                  2.0 - ce split into ce_gb/ce_m
// =============================================================================
`timescale 1ns / 1ps

module tb_hram;

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

    hram dut (
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

        bm.read(16'hFF80);
        check(bm.rd === 8'h00, "power-on, 0xFF80 reads zero");

        bm.write(16'hFF80, 8'h11); bm.read(16'hFF80);
        check(bm.rd === 8'h11, "readback at first hram address 0xFF80");
        bm.write(16'hFFFE, 8'h22); bm.read(16'hFFFE);
        check(bm.rd === 8'h22, "readback at last hram address 0xFFFE");
        bm.write(16'hFFC0, 8'h33); bm.read(16'hFFC0);
        check(bm.rd === 8'h33, "readback at middle address 0xFFC0");

        // the stale read regression: distinct addresses, back to back
        bm.write(16'hFFD0, 8'hA1); bm.write(16'hFFD1, 8'hA2); bm.write(16'hFFD2, 8'hA3);
        bm.read(16'hFFD0); check(bm.rd === 8'hA1, "back to back read 1 of 5, 0xFFD0");
        bm.read(16'hFFD1); check(bm.rd === 8'hA2, "back to back read 2 of 5, 0xFFD1");
        bm.read(16'hFFD2); check(bm.rd === 8'hA3, "back to back read 3 of 5, 0xFFD2");
        bm.read(16'hFFD1); check(bm.rd === 8'hA2, "back to back read 4 of 5, back to 0xFFD1");
        bm.read(16'hFFD0); check(bm.rd === 8'hA1, "back to back read 5 of 5, back to 0xFFD0");

        bm.write(16'hFF90, 8'h44);
        sel_en = 1'b0; bm.write(16'hFF90, 8'hEE); sel_en = 1'b1;
        bm.read(16'hFF90);
        check(bm.rd === 8'h44, "write ignored while sel low");

        bm.write_short(16'hFF90, 8'hDD);
        bm.read(16'hFF90);
        check(bm.rd === 8'h44, "a partial write with no ce_m edge inside it does not commit");

        bm.write(16'hFFA0, 8'hAA); bm.write(16'hFFA1, 8'hBB);
        bm.read(16'hFFA0);
        check(bm.rd === 8'hAA, "adjacent location 1 unaffected by neighbor write");
        bm.read(16'hFFA1);
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