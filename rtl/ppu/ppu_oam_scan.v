// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_oam_scan.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : the oam scan that runs during mode 2. over the 80 dots of
//                  mode 2 it looks at the 40 objects in oam order, two dots
//                  each, and picks the first 10 that overlap the current
//                  line. per pan docs only the y coordinate is checked, so
//                  an object at x = 0 or x >= 168, which is never visible,
//                  still uses up one of the 10 places.
//
//                  an object is on the line when ly + 16 is at least its y
//                  and less than its y plus the object height, 8 or 16
//                  depending on lcdc bit 2 (obj_tall).
//
//                  the picked objects are kept in a list sorted by x, and
//                  by oam index where x is equal. pan docs gives that as
//                  the order objects are considered on a line, left to
//                  right, and as the drawing priority, smaller x wins and
//                  ties go to the earlier object. each new object is
//                  inserted at its place in the list as it is found, after
//                  every object with an x less than or equal to its own,
//                  which is what keeps equal x in oam order. the list is
//                  flattened into one vector, object k at [32k +: 32], each
//                  one the 32 bit entry from oam, {attributes, tile, x, y}.
//                  count says how many of the 10 places hold an object.
//
//                  the object at oam index e is looked at on dot 2e of mode
//                  2 and the list updates on that dot's edge. the list and
//                  count are cleared on the first dot of mode 2 and then
//                  hold their value through mode 3 and the rest of the
//                  line, which is when the fetcher uses them.
//
//                  if oam dma is running while an object is looked at, pan
//                  docs says most ppu revisions read it as off-screen, so
//                  it is skipped. it still counts as looked at, the next
//                  object is on the next two dots as usual.
//
//                  scan_active is the ppu being in mode 2. the counter is
//                  held at 0 whenever it is low, and runs once per ce_gb
//                  while it is high.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module ppu_oam_scan (
    input  wire         clk,
    input  wire         ce_gb,
    input  wire         rst,

    input  wire         scan_active,   // the ppu is in mode 2
    input  wire [7:0]   ly,
    input  wire         obj_tall,      // lcdc bit 2, 1 for 8 x 16 objects
    input  wire         dma_active,

    output wire [5:0]   entry_idx,     // to oam
    input  wire [31:0]  entry_data,    // from oam, {attributes, tile, x, y}

    output reg  [319:0] list,
    output reg  [3:0]   count
);

    reg [6:0] cnt;   // dots since mode 2 began, 0 to 79

    assign entry_idx = cnt[6:1];

    wire [7:0] ob_y = entry_data[7:0];
    wire [7:0] ob_x = entry_data[15:8];

    // ly + 16 - y, wide enough to go negative
    wire [8:0] diff   = {1'b0, ly} + 9'd16 - {1'b0, ob_y};
    wire [4:0] height = obj_tall ? 5'd16 : 5'd8;
    wire       in_range = !diff[8] && (diff[7:0] < {3'b000, height});

    wire       valid = in_range && !dma_active;

    integer     k;
    reg  [3:0]  base_cnt;
    reg  [3:0]  pos;
    reg  [319:0] nl;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt   <= 7'd0;
            count <= 4'd0;
            list  <= 320'd0;
        end
        else if (ce_gb) begin
            if (!scan_active) begin
                cnt <= 7'd0;
            end
            else begin
                cnt <= cnt + 7'd1;

                // an object is looked at on every second dot
                if (!cnt[0]) begin
                    base_cnt = (cnt == 7'd0) ? 4'd0 : count;
                    if (cnt == 7'd0) count <= 4'd0;

                    if (valid && base_cnt < 4'd10) begin
                        // its place is after every object with x <= its own
                        pos = 4'd0;
                        for (k = 0; k < 10; k = k + 1)
                            if (k < base_cnt && list[32*k + 8 +: 8] <= ob_x)
                                pos = pos + 4'd1;

                        nl = list;
                        for (k = 0; k < 10; k = k + 1) begin
                            if (k == pos)     nl[32*k +: 32] = entry_data;
                            else if (k > pos) nl[32*k +: 32] = list[32*(k-1) +: 32];
                        end
                        list  <= nl;
                        count <= base_cnt + 4'd1;
                    end
                end
            end
        end
    end

endmodule