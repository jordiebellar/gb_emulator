// =============================================================================
// Project      : GameBoy Emulator
// File         : tb_ppu_oam_scan.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : tests the oam scan against a golden model written
//                  separately from it. the golden model picks objects with a
//                  plain pass over oam, then sorts them with a stable sort
//                  by x, while the dut inserts into a sorted list as it goes.
//                  directed cases first: the 8 x 8 and 8 x 16 edges of the
//                  y range, more than 10 objects on a line, objects at x = 0
//                  and x >= 168 that still count toward the 10, equal x in
//                  oam order, and dma hiding objects. then 600 random scans
//                  with oam contents biased toward the edges, random ly and
//                  object size, dma on for none, all, or part of a scan, and
//                  ce_gb either on every clock or one clock in three.
//
//                  on every dot of every scan the count and the list are
//                  compared with the golden model's state after exactly the
//                  objects looked at so far, which is dot 2e for object e,
//                  so the two dots per object timing is checked too. the
//                  list is checked to hold through the clocks between ce_gb
//                  and through mode 3, and to clear on the next scan.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module tb_ppu_oam_scan;

    reg clk;
    initial clk = 1'b0;
    always #5 clk = ~clk;

    reg        rst, ce, scan_active, obj_tall, dma_active;
    reg  [7:0] ly;
    wire [5:0] entry_idx;
    wire [31:0] entry_data;
    wire [319:0] list;
    wire [3:0]  count;

    // the oam, as a plain array
    reg [7:0] omem [0:159];
    assign entry_data = (entry_idx < 6'd40)
        ? {omem[{entry_idx, 2'b00} + 3], omem[{entry_idx, 2'b00} + 2],
           omem[{entry_idx, 2'b00} + 1], omem[{entry_idx, 2'b00}]}
        : 32'hFFFF_FFFF;

    ppu_oam_scan dut (
        .clk(clk), .ce_gb(ce), .rst(rst),
        .scan_active(scan_active), .ly(ly), .obj_tall(obj_tall), .dma_active(dma_active),
        .entry_idx(entry_idx), .entry_data(entry_data),
        .list(list), .count(count)
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

    // ---- the golden model --------------------------------------------------
    integer g_cnt;
    reg [31:0] g_sel [0:9];     // picked, in oam order
    reg [31:0] g_sorted [0:9];  // the same, stable sorted by x

    task g_clear;
        begin g_cnt = 0; end
    endtask

    // look at object e with the conditions that hold on its dot
    task g_look(input integer e, input integer lyv, input tall, input dma);
        reg [31:0] en;
        integer d, h;
        begin
            en = {omem[4*e+3], omem[4*e+2], omem[4*e+1], omem[4*e]};
            h  = tall ? 16 : 8;
            d  = lyv + 16 - en[7:0];
            if (!dma && d >= 0 && d < h && g_cnt < 10) begin
                g_sel[g_cnt] = en;
                g_cnt = g_cnt + 1;
            end
        end
    endtask

    // stable sort by x, a plain bubble sort that only swaps on strictly greater
    task g_sort;
        integer a, b;
        reg [31:0] tmp;
        begin
            for (a = 0; a < g_cnt; a = a + 1) g_sorted[a] = g_sel[a];
            for (a = 0; a < g_cnt; a = a + 1)
                for (b = 0; b < g_cnt - 1 - a; b = b + 1)
                    if (g_sorted[b][15:8] > g_sorted[b+1][15:8]) begin
                        tmp = g_sorted[b]; g_sorted[b] = g_sorted[b+1]; g_sorted[b+1] = tmp;
                    end
        end
    endtask

    reg match_ok;
    task do_match;
        integer a;
        begin
            g_sort;
            match_ok = (count === g_cnt[3:0]);
            for (a = 0; a < g_cnt; a = a + 1)
                if (list[32*a +: 32] !== g_sorted[a]) match_ok = 1'b0;
        end
    endtask

    // ---- driving a scan -----------------------------------------------------
    integer bad_dot, bad_hold, scans_run;
    integer gap;         // idle clocks between ce_gb dots
    integer dma_mode;    // 0 off, 1 whole scan, 2 starts partway
    integer dma_from;
    reg [3:0]  hold_count;
    reg [319:0] hold_list;
    integer j, e, dd;
    reg dma_now;

    // one dot: ce for one clock, then gap idle clocks that must change nothing
    task one_dot;
        begin
            @(negedge clk); ce = 1'b1;
            @(negedge clk); ce = 1'b0;
            hold_count = count; hold_list = list;
            repeat (gap) begin
                @(negedge clk);
                if (count !== hold_count || list !== hold_list) bad_hold = bad_hold + 1;
            end
        end
    endtask

    task run_scan(input integer lyv, input tall, input integer dmam, input integer dmaf, input integer mode3_dots);
        integer d, ee;
        begin
            ly = lyv[7:0]; obj_tall = tall;
            g_clear;
            for (d = 0; d < 80; d = d + 1) begin
                dma_now = (dmam == 1) || (dmam == 2 && d >= dmaf);
                dma_active = dma_now;
                scan_active = 1'b1;
                // the golden model looks at an object on its even dot, with
                // the dma state of that dot
                if (d % 2 == 0) g_look(d / 2, lyv, tall, dma_now);
                one_dot;
                #1;
                begin do_match; if (!match_ok) bad_dot = bad_dot + 1; end
            end
            // mode 3 and the rest of the line, the list has to hold
            scan_active = 1'b0;
            hold_count = count; hold_list = list;
            for (d = 0; d < mode3_dots; d = d + 1) begin
                dma_active = ($random & 1);     // must not matter now
                one_dot;
                #1;
                begin do_match; if (!match_ok) bad_dot = bad_dot + 1; end
            end
            scans_run = scans_run + 1;
        end
    endtask

    task set_obj(input integer e, input [7:0] y, input [7:0] x, input [7:0] t, input [7:0] a);
        begin
            omem[4*e] = y; omem[4*e+1] = x; omem[4*e+2] = t; omem[4*e+3] = a;
        end
    endtask

    task clear_oam;
        integer i;
        begin
            for (i = 0; i < 40; i = i + 1) set_obj(i, 8'h00, 8'h00, 8'h00, 8'h00);
        end
    endtask

    integer i, s, r, base, ny, nx;

    initial begin
        rst = 1'b1; ce = 1'b0; scan_active = 1'b0; obj_tall = 1'b0; dma_active = 1'b0; ly = 8'd0;
        bad_dot = 0; bad_hold = 0; scans_run = 0; gap = 0;
        clear_oam;
        repeat (3) @(posedge clk);
        @(negedge clk); rst = 1'b0;

        // =====================================================================
        // directed. line 40, so ly + 16 = 56
        // =====================================================================
        gap = 0;

        // the y range, 8 x 8: y = 56 is row 0, y = 49 is row 7, 48 and 57 are out
        clear_oam;
        set_obj(0, 8'd56, 8'd20, 8'h01, 8'h00);   // row 0, in
        set_obj(1, 8'd49, 8'd21, 8'h02, 8'h00);   // row 7, in
        set_obj(2, 8'd48, 8'd22, 8'h03, 8'h00);   // row 8, out
        set_obj(3, 8'd57, 8'd23, 8'h04, 8'h00);   // not yet started, out
        run_scan(40, 1'b0, 0, 0, 5);
        check(count === 4'd2, "8 x 8: y at row 0 and row 7 are in, row 8 and one not yet started are out");
        check(list[7:0] === 8'd56 && list[39:32] === 8'd49, "8 x 8: the two objects picked are 0 and 1, sorted by x");

        // 8 x 16: row 15 in, row 16 out
        clear_oam;
        set_obj(0, 8'd41, 8'd20, 8'h01, 8'h00);   // row 15, in
        set_obj(1, 8'd40, 8'd21, 8'h02, 8'h00);   // row 16, out
        set_obj(2, 8'd56, 8'd22, 8'h03, 8'h00);   // row 0, in
        set_obj(3, 8'd57, 8'd23, 8'h04, 8'h00);   // starts next line, out
        run_scan(40, 1'b1, 0, 0, 5);
        check(count === 4'd2, "8 x 16: row 15 in, row 16 out, row 0 in, not yet started out");

        // y = 0 and y >= 160 hide an object, y wraps do not matter
        clear_oam;
        set_obj(0, 8'd0,   8'd20, 8'h01, 8'h00);
        set_obj(1, 8'd160, 8'd21, 8'h02, 8'h00);
        set_obj(2, 8'd255, 8'd22, 8'h03, 8'h00);
        run_scan(40, 1'b1, 0, 0, 5);
        check(count === 4'd0, "objects at y = 0, 160, and 255 are never on line 40");
        run_scan(0, 1'b0, 0, 0, 5);
        check(count === 4'd0, "an empty oam picks nothing on line 0 either");

        // more than 10 on a line: the first 10 in oam order, the rest dropped
        clear_oam;
        for (i = 0; i < 14; i = i + 1) set_obj(i, 8'd56, 8'd100 - i, 8'h10 + i, 8'h00);
        run_scan(40, 1'b0, 0, 0, 5);
        check(count === 4'd10, "14 objects on the line: only 10 are kept");
        // x runs down 100, 99, ... so sorted ascending the 10 kept (0 to 9) are x = 91 to 100
        check(list[15:8] === 8'd91 && list[32*9 + 8 +: 8] === 8'd100, "the 10 kept are objects 0 to 9, not the last 10, sorted by x");
        check(list[23:16] === 8'h19, "the smallest x among them, object 9, is first in the list");

        // off-screen x still takes a place
        clear_oam;
        for (i = 0; i < 10; i = i + 1) set_obj(i, 8'd56, (i % 2) ? 8'd0 : 8'd200, 8'h20 + i, 8'h00);
        set_obj(10, 8'd56, 8'd80, 8'hEE, 8'h00);
        run_scan(40, 1'b0, 0, 0, 5);
        check(count === 4'd10, "ten objects at x = 0 and x = 200 fill the limit");
        check(list[23:16] !== 8'hEE && list[32*9 + 16 +: 8] !== 8'hEE, "so the on-screen object 10 at x = 80 does not get drawn");

        // equal x stays in oam order
        clear_oam;
        set_obj(5,  8'd56, 8'd50, 8'hA5, 8'h00);
        set_obj(7,  8'd56, 8'd50, 8'hA7, 8'h00);
        set_obj(9,  8'd56, 8'd30, 8'hB9, 8'h00);
        set_obj(12, 8'd56, 8'd50, 8'hAC, 8'h00);
        run_scan(40, 1'b0, 0, 0, 5);
        check(count === 4'd4, "four objects, three of them at the same x");
        check(list[23:16] === 8'hB9, "the smaller x comes first");
        check(list[32*1 + 16 +: 8] === 8'hA5 && list[32*2 + 16 +: 8] === 8'hA7 && list[32*3 + 16 +: 8] === 8'hAC,
              "the three at x = 50 follow in oam order, 5 then 7 then 12");

        // dma hides objects. all objects hidden for the whole scan
        run_scan(40, 1'b0, 1, 0, 5);
        check(count === 4'd0, "dma active for the whole scan: every object is read as off-screen");
        // dma starts partway: objects looked at before the start are kept
        clear_oam;
        for (i = 0; i < 8; i = i + 1) set_obj(i, 8'd56, 8'd10 + i, 8'h30 + i, 8'h00);
        run_scan(40, 1'b0, 2, 8, 5);      // dma from dot 8, so objects 0 to 3 (dots 0, 2, 4, 6) are seen
        check(count === 4'd4, "dma starting on dot 8: objects 0 to 3 were seen, 4 to 7 were hidden");
        run_scan(40, 1'b0, 0, 0, 5);
        check(count === 4'd8, "the next scan with dma off picks all 8 again, the list was cleared and rebuilt");

        // ================= random =============================================
        for (s = 0; s < 600; s = s + 1) begin
            r = $random;
            gap = (r[1:0] == 2'd0) ? 2 : 0;
            ny  = (($random & 32'h7FFFFFFF) % 154);
            for (i = 0; i < 40; i = i + 1) begin
                r = $random;
                // y near the edges of the line's range half the time
                if (r[0]) set_obj(i, ny + 16 - 3 + (($random & 32'h7FFFFFFF) % 22), 8'd0, 8'd0, 8'd0);
                else      set_obj(i, $random, 8'd0, 8'd0, 8'd0);
                r = $random;
                case (r[3:0])
                    0: omem[4*i+1] = 8'd0;
                    1: omem[4*i+1] = 8'd8;
                    2: omem[4*i+1] = 8'd167;
                    3: omem[4*i+1] = 8'd168;
                    4: omem[4*i+1] = 8'd255;
                    5, 6, 7: omem[4*i+1] = 8'd40 + r[5:4];     // lots of equal x
                    default: omem[4*i+1] = $random;
                endcase
                omem[4*i+2] = $random;
                omem[4*i+3] = $random;
            end
            r = $random;
            dma_mode = (r[3:0] < 12) ? 0 : ((r[3:0] < 14) ? 1 : 2);
            dma_from = (($random & 32'h7FFFFFFF) % 80);
            run_scan(ny, $random, dma_mode, dma_from, 20 + (($random & 32'h7FFFFFFF) % 40));
        end

        check(bad_dot === 0,  "after every dot, count and list matched the golden model, 600 random scans and the directed ones");
        check(bad_hold === 0, "count and list never moved on a clock without ce_gb");
        $display("      %0d scans run", scans_run);

        // reset clears the list
        @(negedge clk); rst = 1'b1; #1;
        check(count === 4'd0 && list === 320'd0, "async reset clears the list and the count");
        rst = 1'b0;

        $display("");
        if (errors == 0) $display("ALL %0d CHECKS PASSED - oam scan verified against the golden model", checks);
        else             $display("%0d of %0d checks failed", errors, checks);
        $finish;
    end

endmodule
