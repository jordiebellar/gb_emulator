// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_oam_dma.v
// Author       : Aaron Luebbert
// Date         : 2026-10-06
// Description  : tests oam_dma with the real oam behind it and a plain array
//                  as the source memory. every m-cycle is logged, with the
//                  unit's active flag, write strobe, source address, oam
//                  address, and data, and checked against the timeline the
//                  unit documents, counted from the ce_m edge the register
//                  write commits on.
//                  - the register: powers up as 0xFF, reads back what was
//                    written, ignores a write with sel low or with no ce_m
//                    edge in it, reads 0 when sel is low
//                  - a transfer: nothing in the start delay cycle, then
//                    exactly 160 active cycles, byte i read from page and i
//                    in cycle i + 2, written to oam byte i on the edge that
//                    ends it, strobe only on ce_m clocks, and all 160 bytes
//                    in oam afterwards equal to the source page
//                  - the cpu gate: blocked below 0xFF00 while a transfer
//                    runs and never otherwise, and never at 0xFF00 and up
//                  - oam itself blocks the cpu for the whole transfer, a
//                    write attempted then is dropped
//                  - dma writes land even with the ppu in mode 3
//                  - restart: no gap in the active flag, the old transfer
//                    carries through the delay cycle, the new one takes over
//                    from byte 0 on the new page, and oam ends up holding the
//                    new page
//                  - the source page map: 0xE0 to 0xFF read 0xC0 to 0xDF
//                  - the start delay parameter, a second unit with 2
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_oam_dma;

    reg clk;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    reg [1:0] m_cnt;
    initial m_cnt = 2'd0;
    always @(posedge clk) m_cnt <= m_cnt + 2'd1;
    wire ce_m = (m_cnt == 2'd3);

    reg rst;

    wire [15:0] addr;
    wire [7:0]  wdata;
    wire        we, bm_sel, bm_late;
    wire [7:0]  bus_rdata;
    reg         sel_en;      // masks the dma register select
    reg  [1:0]  oam_mode;    // the ppu mode the oam sees after the edge
    reg  [15:0] gate_addr;

    // the source memory
    reg [7:0] srcmem [0:65535];
    wire [15:0] dma_addr, dma_addr2;
    wire [7:0]  dma_rdata  = srcmem[dma_addr];
    wire [7:0]  dma_rdata2 = srcmem[dma_addr2];

    wire [7:0] dma_dout, dma_dout2, oam_dout;
    wire       dma_we, dma_active, cpu_blocked;
    wire [7:0] dma_waddr, dma_wdata;
    wire       dma_we2, dma_active2, cpu_blocked2;
    wire [7:0] dma_waddr2, dma_wdata2;

    wire sel_dma = bm_sel && sel_en && (addr == 16'hFF46);
    wire sel_oam = bm_sel && (addr[15:8] == 8'hFE);

    assign bus_rdata = dma_dout | oam_dout;

    bus_master bm (.clk(clk), .ce_m(ce_m), .addr(addr), .wdata(wdata),
                   .we(we), .sel(bm_sel), .late(bm_late), .rdata(bus_rdata));

    oam_dma #(.START_DELAY(1)) dut (
        .clk(clk), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(wdata), .we(we), .sel(sel_dma), .data_out(dma_dout),
        .dma_addr(dma_addr), .dma_rdata(dma_rdata),
        .dma_we(dma_we), .dma_waddr(dma_waddr), .dma_wdata(dma_wdata),
        .dma_active(dma_active),
        .cpu_addr(gate_addr), .cpu_blocked(cpu_blocked)
    );

    // a second unit with a start delay of 2, watching the same bus
    oam_dma #(.START_DELAY(2)) dut2 (
        .clk(clk), .ce_m(ce_m), .rst(rst),
        .addr(addr), .data_in(wdata), .we(we), .sel(sel_dma), .data_out(dma_dout2),
        .dma_addr(dma_addr2), .dma_rdata(dma_rdata2),
        .dma_we(dma_we2), .dma_waddr(dma_waddr2), .dma_wdata(dma_wdata2),
        .dma_active(dma_active2),
        .cpu_addr(16'h0000), .cpu_blocked(cpu_blocked2)
    );

    oam u_oam (
        .clk(clk), .ce_gb(1'b0), .ce_m(ce_m), .rst(1'b0),
        .addr(addr), .data_in(wdata), .we(we), .sel(sel_oam), .data_out(oam_dout), .stall(),
        .mode_next(oam_mode), .dma_active(dma_active),
        .entry_idx(6'd0), .entry_data(),
        .dma_we(dma_we), .dma_waddr(dma_waddr), .dma_wdata(dma_wdata)
    );

    integer errors = 0;
    integer checks = 0;

    task check(input expr, input [8*100:1] label);
        begin
            checks = checks + 1;
            if (expr) $display("PASS  %0s", label);
            else begin
                errors = errors + 1;
                $display("FAIL  %0s", label);
            end
        end
    endtask

    // ---- the log, one entry per ce_m edge, values as they are just before it ----
    integer nedge, wedge;
    reg        act_l   [0:8191];
    reg        act2_l  [0:8191];
    reg        we_l    [0:8191];
    reg [7:0]  wa_l    [0:8191];
    reg [7:0]  wd_l    [0:8191];
    reg [15:0] da_l    [0:8191];
    integer    bad_we_off_edge;

    always @(posedge clk) begin
        if (dma_we && !ce_m) bad_we_off_edge = bad_we_off_edge + 1;
        if (ce_m) begin
            act_l[nedge]  = dma_active;
            act2_l[nedge] = dma_active2;
            we_l[nedge]   = dma_we;
            wa_l[nedge]   = dma_waddr;
            wd_l[nedge]   = dma_wdata;
            da_l[nedge]   = dma_addr;
            // the edge the register write commits on
            if (bm_sel && sel_en && we && addr == 16'hFF46) wedge = nedge;
            nedge = nedge + 1;
        end
    end

    // wait for n m-cycles
    task wait_m(input integer n);
        integer target;
        begin
            target = nedge + n;
            while (nedge < target) @(negedge clk);
        end
    endtask

    // check one whole transfer in the log, w is the commit edge, d the start
    // delay, page the source page the cycles must show
    integer k, bad_act, bad_we, bad_wa, bad_da, bad_wd, nact;
    task check_transfer(input integer w, input integer d, input [7:0] page, input use_unit2);
        integer i;
        reg a;
        begin
            bad_act = 0; bad_we = 0; bad_wa = 0; bad_da = 0; bad_wd = 0; nact = 0;
            for (i = 1; i <= d + 162; i = i + 1) begin
                a = use_unit2 ? act2_l[w + i] : act_l[w + i];
                // active for cycles d + 1 through d + 160, which is edges d + 1 to d + 160
                // dma_active is the state during the cycle that edge ends
                if (i >= d + 1 && i <= d + 160) begin
                    if (a !== 1'b1) bad_act = bad_act + 1;
                    nact = nact + 1;
                end
                else if (a !== 1'b0) bad_act = bad_act + 1;
            end
            if (!use_unit2) begin
                for (i = 1; i <= d + 162; i = i + 1) begin
                    if (i >= d + 1 && i <= d + 160) begin
                        k = i - d - 1;      // the byte, 0 to 159
                        if (we_l[w + i] !== 1'b1) bad_we = bad_we + 1;
                        if (wa_l[w + i] !== k[7:0]) bad_wa = bad_wa + 1;
                        if (da_l[w + i] !== {page, k[7:0]}) bad_da = bad_da + 1;
                        if (wd_l[w + i] !== srcmem[{page, k[7:0]}]) bad_wd = bad_wd + 1;
                    end
                    else if (we_l[w + i] !== 1'b0) bad_we = bad_we + 1;
                end
            end
        end
    endtask

    // all 160 oam bytes read back over the bus against a source page
    integer rb_bad, rb_i;
    task readback_page(input [7:0] page);
        begin
            rb_bad = 0;
            for (rb_i = 0; rb_i < 160; rb_i = rb_i + 1) begin
                bm.read(16'hFE00 + rb_i);
                if (bm.rd !== srcmem[{page, rb_i[7:0]}]) rb_bad = rb_bad + 1;
            end
        end
    endtask

    integer w1, w2, i, bad_gap, bad_old, lfsr_i, j;
    reg [31:0] lfsr;
    reg [7:0]  hi_exp;
    integer    ws [0:7];
    reg [7:0]  vs [0:7];
    reg [7:0]  hs [0:7];

    initial begin
        rst = 1'b1; sel_en = 1'b1; oam_mode = 2'd0; gate_addr = 16'h0000;
        nedge = 0; wedge = -1; bad_we_off_edge = 0;
        lfsr = 32'h0DAD0001;
        for (lfsr_i = 0; lfsr_i < 65536; lfsr_i = lfsr_i + 1) begin
            for (j = 0; j < 8; j = j + 1)
                lfsr = {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]};
            srcmem[lfsr_i] = lfsr[7:0];
        end
        repeat (4) @(posedge clk);
        @(negedge clk); rst = 1'b0;

        // ---------------------------------------------------------------- register
        bm.read(16'hFF46);
        check(bm.rd === 8'hFF, "the register powers up as 0xFF, its value after the boot rom");
        check(act_l[nedge - 1] === 1'b0, "no transfer running after reset");

        sel_en = 1'b0; bm.write(16'hFF46, 8'hC7); sel_en = 1'b1;
        bm.read(16'hFF46);
        check(bm.rd === 8'hFF, "a write with sel low is ignored");
        wait_m(4);
        check(act_l[nedge - 1] === 1'b0 && act_l[nedge - 3] === 1'b0, "and it starts no transfer");

        bm.write_short(16'hFF46, 8'hC7);
        bm.read(16'hFF46);
        check(bm.rd === 8'hFF, "a partial write with no ce_m edge inside it does not commit");
        wait_m(4);
        check(act_l[nedge - 1] === 1'b0, "and starts no transfer");

        // ---------------------------------------------------------------- a transfer
        bm.write(16'hFF46, 8'hC0);
        w1 = wedge;
        check(w1 > 0, "premise: the register write was seen committing");
        bm.read(16'hFF46);
        check(bm.rd === 8'hC0, "the register reads back 0xC0 during the transfer, reg_read");
        wait_m(175);
        check_transfer(w1, 1, 8'hC0, 1'b0);
        check(bad_act === 0, "dma_active: low in the delay cycle, high for exactly cycles 2 to 161, low after");
        check(nact === 160, "160 active m-cycles");
        check(bad_we === 0, "the write strobe is high on exactly those 160 edges and no others");
        check(bad_wa === 0, "oam byte i is written on the i-th edge, 0 to 159 in order");
        check(bad_da === 0, "the source address is page 0xC0 and byte i in the same cycle");
        check(bad_wd === 0, "the data written is the source byte at that address");
        check(bad_we_off_edge === 0, "the write strobe is never high on a clock without ce_m");

        readback_page(8'hC0);
        check(rb_bad === 0, "afterwards all 160 oam bytes equal source page 0xC0");

        // ---------------------------------------------------------------- the start delay parameter
        check_transfer(w1, 2, 8'hC0, 1'b1);
        check(bad_act === 0, "start delay 2: the second unit is active for exactly cycles 3 to 162");
        check(nact === 160, "start delay 2: still 160 active cycles");

        // ---------------------------------------------------------------- the cpu gate and oam blocking
        bm.write(16'hFF46, 8'hC3);
        w1 = wedge;
        wait_m(40);
        check(act_l[nedge - 1] === 1'b1, "premise: a transfer is running 40 cycles in");
        @(negedge clk);
        begin : gate_block
            reg [15:0] ba [0:5];
            reg [15:0] fa [0:4];
            integer g, bad_b, bad_f;
            ba[0] = 16'h0000; ba[1] = 16'h7FFF; ba[2] = 16'h8000; ba[3] = 16'hC000; ba[4] = 16'hFE00; ba[5] = 16'hFEFF;
            fa[0] = 16'hFF00; fa[1] = 16'hFF46; fa[2] = 16'hFF80; fa[3] = 16'hFFFE; fa[4] = 16'hFFFF;
            bad_b = 0; bad_f = 0;
            for (g = 0; g < 6; g = g + 1) begin gate_addr = ba[g]; #1; if (cpu_blocked !== 1'b1) bad_b = bad_b + 1; end
            for (g = 0; g < 5; g = g + 1) begin gate_addr = fa[g]; #1; if (cpu_blocked !== 1'b0) bad_f = bad_f + 1; end
            check(bad_b === 0, "cpu_blocked is high below 0xFF00 while a transfer runs, rom, vram, wram, oam, the gap");
            check(bad_f === 0, "cpu_blocked is low at 0xFF00 and up, io, 0xFF46, hram, ie, while a transfer runs");
        end
        // oam blocks the cpu for the whole transfer
        bm.read(16'hFE00);
        check(bm.rd === 8'hFF, "a cpu read of oam during the transfer returns 0xFF");
        bm.write(16'hFE05, 8'h5A);
        wait_m(130);
        check(act_l[nedge - 1] === 1'b0, "premise: the transfer has finished");
        bm.read(16'hFE05);
        check(bm.rd === srcmem[{8'hC3, 8'd5}], "the cpu write attempted during the transfer was dropped, byte 5 is the dma's");
        begin : gate_idle
            integer g, bad_i;
            reg [15:0] ia [0:3];
            ia[0] = 16'h0000; ia[1] = 16'hC000; ia[2] = 16'hFE00; ia[3] = 16'hFF80;
            bad_i = 0;
            for (g = 0; g < 4; g = g + 1) begin gate_addr = ia[g]; #1; if (cpu_blocked !== 1'b0) bad_i = bad_i + 1; end
            check(bad_i === 0, "cpu_blocked is low everywhere when no transfer is running");
        end

        // ---------------------------------------------------------------- dma writes land in any mode
        oam_mode = 2'd3;
        bm.write(16'hFF46, 8'hC2);
        wait_m(170);
        oam_mode = 2'd0;
        readback_page(8'hC2);
        check(rb_bad === 0, "a transfer run with the ppu in mode 3 still put all 160 bytes in oam");
        oam_mode = 2'd2;
        bm.write(16'hFF46, 8'hC4);
        wait_m(170);
        oam_mode = 2'd0;
        readback_page(8'hC4);
        check(rb_bad === 0, "and so did one run with the ppu in mode 2");

        // ---------------------------------------------------------------- restart
        bm.write(16'hFF46, 8'hC0);
        w1 = wedge;
        wait_m(50);
        bm.write(16'hFF46, 8'h80);
        w2 = wedge;
        wait_m(175);
        bad_gap = 0;
        for (i = w1 + 2; i <= w2 + 161; i = i + 1)
            if (act_l[i] !== 1'b1) bad_gap = bad_gap + 1;
        check(bad_gap === 0, "restart: dma_active never drops from the first transfer through the end of the second");
        check(act_l[w2 + 162] === 1'b0, "restart: and it drops 160 cycles after the second transfer starts");
        // the old transfer carries on through the delay cycle of the restart
        check(da_l[w2 + 1][15:8] === 8'hC0 && da_l[w2 + 1][7:0] === (w2 + 1 - w1 - 2),
              "restart: in the delay cycle the source address is still the old page, next byte");
        check(we_l[w2 + 1] === 1'b1 && wa_l[w2 + 1] === (w2 + 1 - w1 - 2),
              "restart: and the old transfer's next byte is still written on that edge");
        check(da_l[w2 + 2] === {8'h80, 8'd0}, "restart: the next cycle reads byte 0 of the new page");
        check_transfer(w2, 1, 8'h80, 1'b0);
        // only the new transfer's own window is checked below, so look at the tail
        bad_wa = 0;
        for (i = w2 + 2; i <= w2 + 161; i = i + 1)
            if (wa_l[i] !== (i - w2 - 2) || we_l[i] !== 1'b1) bad_wa = bad_wa + 1;
        check(bad_wa === 0, "restart: the new transfer writes bytes 0 to 159 on its 160 edges");
        readback_page(8'h80);
        check(rb_bad === 0, "restart: oam ends up holding all of the new page, 0x80");

        // ---------------------------------------------------------------- the source page map
        vs[0] = 8'hE0; hs[0] = 8'hC0;
        vs[1] = 8'hE5; hs[1] = 8'hC5;
        vs[2] = 8'hFF; hs[2] = 8'hDF;
        vs[3] = 8'hDF; hs[3] = 8'hDF;
        vs[4] = 8'hC0; hs[4] = 8'hC0;
        vs[5] = 8'h80; hs[5] = 8'h80;
        vs[6] = 8'h00; hs[6] = 8'h00;
        vs[7] = 8'hA1; hs[7] = 8'hA1;
        for (i = 0; i < 8; i = i + 1) begin
            bm.write(16'hFF46, vs[i]);
            ws[i] = wedge;
            wait_m(5);
        end
        wait_m(175);
        begin : map_check
            integer bad_m;
            bad_m = 0;
            for (i = 0; i < 8; i = i + 1)
                if (da_l[ws[i] + 2][15:8] !== hs[i]) bad_m = bad_m + 1;
            check(bad_m === 0, "source pages: 0xE0 reads 0xC0, 0xE5 reads 0xC5, 0xFF and 0xDF read 0xDF, 0xC0 0x80 0x00 0xA1 as is");
        end
        bm.read(16'hFF46);
        check(bm.rd === 8'hA1, "the register reads back the value as written, not the mapped page");
        bm.write(16'hFF46, 8'hFF);
        bm.read(16'hFF46);
        check(bm.rd === 8'hFF, "the register reads back 0xFF when 0xFF was written");
        wait_m(175);

        // data_out is 0 when sel is low
        @(negedge clk); sel_en = 1'b0; #1;
        check(dma_dout === 8'h00, "data_out reads 0 when sel is low");
        sel_en = 1'b1;

        // async reset stops a transfer
        bm.write(16'hFF46, 8'hC0);
        wait_m(20);
        @(negedge clk); rst = 1'b1; #1;
        check(dma_active === 1'b0, "async reset stops a running transfer at once");
        rst = 1'b0;
        bm.read(16'hFF46);
        check(bm.rd === 8'hFF, "and puts the register back to 0xFF");

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - oam dma verified against its documented timeline", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule
