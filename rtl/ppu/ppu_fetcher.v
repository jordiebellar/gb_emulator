// =============================================================================
// Project      : GameBoy Emulator
// File         : ppu_fetcher.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : the mode 3 pixel pipeline. a background and window tile
//                  fetcher feeding a pixel fifo, sprite fetches that stall
//                  it, and the mixer that picks each pixel. runs only while
//                  active is high (the ppu is in mode 3), and sits reset
//                  otherwise.
//
//                  background fetcher, per pan docs: get tile, get tile data
//                  low, get tile data high take 2 dots each, then the push
//                  is attempted on the last dot of the high step and
//                  retried every dot until it succeeds. after a push the
//                  fetcher restarts at get tile on the next dot.
//
//                  pixel fifo, per pan docs: a row of 8 pixels is pushed only
//                  when the fifo is empty, and a pixel pops every dot while
//                  there is one. the fetch takes 6 dots and a row lasts 8,
//                  so the next row is ready and waiting by the time the
//                  last pixel of the current one pops, and output is steady
//                  at one pixel per dot.
//
//                  startup: two 6 dot tile fetches before the first pixel
//                  pops, so 12 dots, then one pixel per dot. per pan docs
//                  one of the two is simply discarded, here the first, a
//                  dummy fetch whose row is never pushed. the first scx % 8
//                  pops are discarded, which pauses output for that many
//                  dots. so pixel x appears on dot 12 + (scx & 7) + x of
//                  mode 3 and mode 3 lasts 172 + (scx & 7) dots, before any
//                  window or sprite.
//
//                  window, per pan docs. a y condition latches during mode
//                  2 of a line where ly equals wy and stays set until
//                  vblank. the window starts on the pixel where the pixel
//                  count equals wx - 7, if the y condition is set, lcdc bit
//                  5 enables it, and lcdc bit 0 is set. when it starts the
//                  fifo is flushed and the fetcher restarts on the window
//                  tile map, lcdc bit 6 picks which, at window tile 0 and
//                  the window's own row counter. the restart is what costs
//                  the documented 6 dots, one tile fetch into an empty fifo,
//                  it falls out of the fetch, it is not added. the window row counter goes up by one at the
//                  end of every line the window was drawn on and clears at
//                  vblank, so a line where the window is hidden does not
//                  advance it. wx below 7 puts the window's left edge off
//                  the screen, handled here by discarding the first 7 - wx
//                  window pixels. wx of 167 and up never starts a window.
//
//                  sprites. the oam scan gives a list of up to 10 objects
//                  sorted by x, then oam index, see ppu_oam_scan. when the
//                  next pixel to show is the left edge of the next object in
//                  the list, pixel output and the background fetcher stop
//                  for the penalty from the pan docs rendering page, the
//                  OBJ penalty algorithm, then the object's row is merged
//                  into an 8 pixel object shifter and output goes on.
//                  the penalty for an object is 6 dots for fetching its
//                  tile, plus, if no earlier object already took this
//                  background or window tile, the number of that tile's
//                  pixels strictly right of the object's leftmost pixel,
//                  minus 2, or zero if that is negative. an object at oam x
//                  of 0 always costs 11. objects are skipped, with no
//                  penalty, while lcdc bit 1 is clear.
//
//                  mixing. each popped pixel meets the object shifter's
//                  front pixel. an object pixel wins when it is not color 0
//                  and lcdc bit 1 is set, unless its priority bit is set and
//                  the background pixel is not color 0. lcdc bit 0 clear
//                  makes the background color 0. when merging objects the
//                  first one in is kept wherever it is not transparent,
//                  which is the pan docs drawing priority since the list is
//                  in priority order.
//
//                  outputs: pixel_color is the color index that won, and
//                  pixel_pal says which palette applies, 0 bgp, 1 obp0, 2
//                  obp1. the ppu applies the palette. output is
//                  combinational from registered state and is valid during
//                  the dot it describes, consume it on the edge that ends
//                  that dot. line_done is high on the dot that shows pixel
//                  159, it is the fifo_done ppu_mode_fsm waits for.
//
//                  vram_addr is an offset from 0x8000 for the vram render
//                  port. each memory read lands on the last dot of its step.
//
//                  choices the docs leave open, revisit against mooneye and
//                  the mealybug tests if mid-line register writes matter:
//                  - scx & 7 is sampled on every dot before mode 3 begins
//                  - scy, wx, and lcdc are sampled live. the penalty for an
//                    object uses scx as sampled at the start of the line
//                  - which of the two startup fetches is the discarded one
//                    pan docs does not say. here it is the first, and the
//                    second fetches the first tile for real. the same on
//                    screen for a static picture
//                  - an object at x = 0 counts as having taken background
//                    tile -1, so a following object on that tile pays only
//                    the 6 dots. pan docs does not say
//                  - pan docs rendering and pixel fifo pages disagree on the
//                    x = 0 object when scx & 7 is not zero. this follows
//                    the rendering page, always 11
//                  - objects fetch their rows from vram while stalled, from
//                    the list the scan made, not from oam again
//                  - not modeled: wx written mid-line, wx = 0 shifting the
//                    window by scx & 7, wx = 166 on the dmg, the window
//                    pixel inserted when lcdc bit 5 is cleared on a tile
//                    edge, object fetch cancelling, objects with wx = 7
//                    and window starting on the same pixel in hardware order
// Revision     : 2.0 - window, sprites, and mixing added. the fifo is now
//                  the pan docs push-when-empty 8 pixel fifo with a dummy
//                  first fetch, replacing the 16 pixel fifo with an 8 pixel
//                  reserve, which could not flush and refill in the 6 dots
//                  the window costs. new ports for the
//                  window registers, the object list, lcd enable, and the
//                  mode 2 flag, and pixel_pal on the output.
//                  1.0 - initial implementation, background only
// =============================================================================
`timescale 1ns / 1ps

module ppu_fetcher (
    input  wire         clk,
    input  wire         ce_gb,
    input  wire         rst,
    input  wire         active,       // high while the ppu is in mode 3
    input  wire         lcd_en,       // lcdc bit 7
    input  wire         oam_scan,     // high while the ppu is in mode 2

    input  wire [7:0]   ly,
    input  wire [7:0]   scx,
    input  wire [7:0]   scy,
    input  wire [7:0]   lcdc,
    input  wire [7:0]   wy,
    input  wire [7:0]   wx,

    input  wire [319:0] spr_list,     // from ppu_oam_scan, object k at [32k +: 32]
    input  wire [3:0]   spr_count,

    output reg  [12:0]  vram_addr,    // offset from 0x8000
    input  wire [7:0]   vram_data,

    output wire         pixel_valid,
    output wire [1:0]   pixel_color,  // color index of the winning pixel
    output wire [1:0]   pixel_pal,    // 0 bgp, 1 obp0, 2 obp1
    output wire [7:0]   pixel_x,      // 0 to 159
    output wire         line_done
);

    localparam S_TILE0 = 3'd0;
    localparam S_TILE1 = 3'd1;
    localparam S_LO0   = 3'd2;
    localparam S_LO1   = 3'd3;
    localparam S_HI0   = 3'd4;
    localparam S_HI1   = 3'd5;
    localparam S_PUSH  = 3'd6;

    reg [2:0]  fstate;
    reg [4:0]  fetch_x;
    reg [7:0]  tile_idx;
    reg [7:0]  lo_r;
    reg [7:0]  hi_r;
    reg [15:0] fifo;      // 8 pixels x 2 bits, the head is bits 1:0
    reg [3:0]  count;
    reg        dummy;     // the first fetch of the line is thrown away
    reg [2:0]  discard;
    reg [2:0]  scx_lat;   // scx & 7 as it was when the line began
    reg [7:0]  x_cnt;

    reg        in_win;    // the window has started on this line

    reg        ycond;     // the window y condition
    reg [7:0]  wlc;       // the window row counter

    reg [3:0]  sp_ptr;    // next object in the list
    reg        stalling;  // an object is being fetched
    reg [3:0]  stall_cnt;
    reg [7:0]  sp_lo;
    reg        last_valid;
    reg [6:0]  last_t;    // the background or window tile the last object took
    reg        last_win;
    reg [31:0] obj;       // 8 object pixels, 4 bits each, {priority, palette, color}, front is 3:0

    // --- the window ------------------------------------------------------
    wire       win_on  = lcdc[5] && lcdc[0] && ycond;
    wire [7:0] xw      = (wx < 8'd7) ? 8'd0 : (wx - 8'd7);

    // --- address generation for the background and window ------------------
    wire [7:0]  y_bg     = ly + scy;               // wraps at 256 on its own
    wire [7:0]  y_row    = in_win ? wlc : y_bg;
    wire [4:0]  map_row  = y_row[7:3];
    wire [2:0]  tile_row = y_row[2:0];
    wire [4:0]  map_col  = in_win ? fetch_x : (scx[7:3] + fetch_x);
    wire        map_hi   = in_win ? lcdc[6] : lcdc[3];
    wire [12:0] map_base = map_hi ? 13'h1C00 : 13'h1800;
    wire [12:0] map_addr = map_base + {3'b000, map_row, 5'b00000} + {8'b0, map_col};

    // lcdc bit 4 set: tiles at 0x8000, indexed unsigned. clear: tiles at
    // 0x9000, indexed signed. flipping the index msb turns the signed case
    // into an unsigned offset from 0x8800
    wire [12:0] tile_base = lcdc[4] ? {1'b0, tile_idx, 4'b0000}
                                    : (13'h0800 + {1'b0, ~tile_idx[7], tile_idx[6:0], 4'b0000});
    wire [12:0] data_lo   = tile_base + {9'b0, tile_row, 1'b0};
    wire [12:0] data_hi   = data_lo + 13'd1;

    // --- the next object in the list ---------------------------------------
    wire [31:0] sp_head = spr_list[32*sp_ptr +: 32];
    wire [7:0]  sp_y    = sp_head[7:0];
    wire [7:0]  sp_x    = sp_head[15:8];
    wire [7:0]  sp_tile = sp_head[23:16];
    wire [7:0]  sp_attr = sp_head[31:24];
    wire        sp_pending = (sp_ptr < spr_count);

    // the object's row, after any vertical flip, and its tile
    wire [8:0]  row9    = {1'b0, ly} + 9'd16 - {1'b0, sp_y};
    wire        tall    = lcdc[2];
    wire [3:0]  r       = sp_attr[6] ? ((tall ? 4'd15 : 4'd7) - row9[3:0]) : row9[3:0];
    wire [7:0]  sp_tidx = tall ? {sp_tile[7:1], r[3]} : sp_tile;
    wire [12:0] sp_lo_addr = {1'b0, sp_tidx, r[2:0], 1'b0};
    wire [12:0] sp_hi_addr = sp_lo_addr + 13'd1;

    always @(*) begin
        if (stalling) begin
            vram_addr = (stall_cnt == 4'd0) ? sp_hi_addr : sp_lo_addr;
        end
        else begin
            case (fstate)
                S_TILE0, S_TILE1: vram_addr = map_addr;
                S_LO0,   S_LO1:   vram_addr = data_lo;
                default:          vram_addr = data_hi;
            endcase
        end
    end

    // --- fifo pop and push ---------------------------------------------------
    wire       pop_ok          = active && !stalling && (count != 4'd0);
    wire [3:0] count_after_pop = count - {3'b0, pop_ok};
    wire       push_attempt    = (fstate == S_HI1) || (fstate == S_PUSH);
    wire       push_ok         = active && push_attempt && !dummy && (count_after_pop == 4'd0);

    wire [7:0] hi_now = (fstate == S_HI1) ? vram_data : hi_r;

    // pixel 0 is the leftmost, bit 7 of each tile byte
    reg [15:0] row16;
    integer i;
    always @(*) begin
        for (i = 0; i < 8; i = i + 1)
            row16[2*i +: 2] = {hi_now[7-i], lo_r[7-i]};
    end

    // --- the events at the point a pixel would be shown --------------------
    wire at_pixel  = pop_ok && (discard == 3'd0) && (x_cnt < 8'd160);

    wire win_start = at_pixel && !in_win && win_on && (wx <= 8'd166) && (x_cnt == xw);

    wire spr_trig  = at_pixel && !win_start && lcdc[1] && sp_pending &&
                     ({1'b0, sp_x} <= ({1'b0, x_cnt} + 9'd8));

    wire visible_pop = at_pixel && !win_start && !spr_trig;

    // --- the object penalty, from the pan docs rendering page --------------
    // the object's leftmost pixel is at screen x sp_x - 8, which is negative
    // for an object partly off the left edge
    wire signed [9:0] xp_s   = {2'b00, sp_x} - 10'sd8;
    wire              sp_left0 = (sp_x == 8'd0);
    wire              sp_in_win = in_win && (xp_s >= $signed({2'b00, xw}));

    // position along the tile row the pixel is in: window coordinates once
    // the window is on, otherwise background coordinates, shifted by scx & 7
    wire signed [9:0] p_pos  = sp_in_win ? (xp_s - $signed({2'b00, xw}))
                                         : (xp_s + $signed({7'b0, scx_lat}));
    wire [2:0]        p_in_tile = p_pos[2:0];
    wire [6:0]        p_tile    = p_pos[9:3];     // floor of p_pos / 8

    wire              considered = last_valid && (last_t == p_tile) && (last_win == sp_in_win);

    // pixels of the tile strictly to the right of the leftmost pixel, minus 2
    wire [3:0] wait_dots = sp_left0 ? 4'd5 :
                           considered ? 4'd0 :
                           (p_in_tile >= 3'd5) ? 4'd0 : (4'd5 - {1'b0, p_in_tile});
    wire [3:0] penalty   = wait_dots + 4'd6;       // 6 to 11

    // --- merging the object's row into the object shifter --------------------
    wire [7:0] m_lo = sp_lo;
    wire [7:0] m_hi = vram_data;      // on the last stall dot vram_addr is the high byte
    reg  [15:0] sprow;
    always @(*) begin
        for (i = 0; i < 8; i = i + 1)
            sprow[2*i +: 2] = sp_attr[5] ? {m_hi[i], m_lo[i]} : {m_hi[7-i], m_lo[7-i]};
    end

    // an object partly off the left edge loses its first 8 - x pixels
    wire [4:0] shift_in = (sp_x < 8'd8) ? (5'd8 - {2'b00, sp_x[2:0]}) : 5'd0;

    reg [31:0] obj_merged;
    reg [4:0]  src;
    integer    k;
    always @(*) begin
        obj_merged = obj;
        for (k = 0; k < 8; k = k + 1) begin
            src = k[4:0] + shift_in;
            if (src < 5'd8 && sprow[2*src +: 2] != 2'b00 && obj[4*k +: 2] == 2'b00)
                obj_merged[4*k +: 4] = {sp_attr[7], sp_attr[4], sprow[2*src +: 2]};
        end
    end

    // --- mixing ----------------------------------------------------------
    wire [1:0] bg_color   = lcdc[0] ? fifo[1:0] : 2'b00;   // lcdc bit 0 clear blanks the background
    wire [3:0] o0         = obj[3:0];
    wire       obj_opaque = lcdc[1] && (o0[1:0] != 2'b00);
    wire       use_obj    = obj_opaque && !(o0[3] && (bg_color != 2'b00));

    assign pixel_valid = active && visible_pop;
    assign pixel_color = use_obj ? o0[1:0] : bg_color;
    assign pixel_pal   = use_obj ? (o0[2] ? 2'd2 : 2'd1) : 2'd0;
    assign pixel_x     = x_cnt;
    assign line_done   = pixel_valid && (x_cnt == 8'd159);

    // --- window y condition and row counter, they live across lines ----------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ycond <= 1'b0;
            wlc   <= 8'd0;
        end
        else if (ce_gb) begin
            if (!lcd_en || ly >= 8'd144) begin
                ycond <= 1'b0;
                wlc   <= 8'd0;
            end
            else begin
                if (oam_scan && ly == wy) ycond <= 1'b1;
                if (line_done && in_win)  wlc   <= wlc + 8'd1;
            end
        end
    end

    // --- the pipeline ------------------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fstate     <= S_TILE0;
            fetch_x    <= 5'd0;
            tile_idx   <= 8'd0;
            lo_r       <= 8'd0;
            hi_r       <= 8'd0;
            fifo       <= 16'd0;
            count      <= 4'd0;
            dummy      <= 1'b1;
            discard    <= 3'd0;
            scx_lat    <= 3'd0;
            x_cnt      <= 8'd0;
            in_win     <= 1'b0;
            sp_ptr     <= 4'd0;
            stalling   <= 1'b0;
            stall_cnt  <= 4'd0;
            sp_lo      <= 8'd0;
            last_valid <= 1'b0;
            last_t     <= 7'd0;
            last_win   <= 1'b0;
            obj        <= 32'd0;
        end
        else if (ce_gb) begin
            if (!active) begin
                // idle between lines, ready for the first dot of mode 3
                fstate     <= S_TILE0;
                fetch_x    <= 5'd0;
                tile_idx   <= 8'd0;
                lo_r       <= 8'd0;
                hi_r       <= 8'd0;
                fifo       <= 16'd0;
                count      <= 4'd0;
                dummy      <= 1'b1;
                discard    <= scx[2:0];
                scx_lat    <= scx[2:0];
                x_cnt      <= 8'd0;
                in_win     <= 1'b0;
                sp_ptr     <= 4'd0;
                stalling   <= 1'b0;
                stall_cnt  <= 4'd0;
                sp_lo      <= 8'd0;
                last_valid <= 1'b0;
                last_t     <= 7'd0;
                last_win   <= 1'b0;
                obj        <= 32'd0;
            end
            else if (stalling) begin
                // an object is being fetched, the fifo and the background
                // fetcher wait. the low byte is read two dots before the
                // end, the high byte on the last dot, which is also the dot
                // the row is merged
                if (stall_cnt == 4'd1) sp_lo <= vram_data;
                if (stall_cnt == 4'd0) begin
                    obj      <= obj_merged;
                    stalling <= 1'b0;
                    sp_ptr   <= sp_ptr + 4'd1;
                end
                else begin
                    stall_cnt <= stall_cnt - 4'd1;
                end
            end
            else if (win_start) begin
                // flush the fifo and start over on the window. this dot
                // counts as the first step of the new fetch
                fifo     <= 16'd0;
                count    <= 4'd0;
                fstate   <= S_TILE1;
                fetch_x  <= 5'd0;
                in_win   <= 1'b1;
                discard  <= (wx < 8'd7) ? (3'd7 - wx[2:0]) : 3'd0;
                last_valid <= 1'b0;
            end
            else if (spr_trig) begin
                // this dot is the first of the penalty, so penalty - 2 dots
                // remain after the next one
                stalling   <= 1'b1;
                stall_cnt  <= penalty - 4'd2;
                last_valid <= 1'b1;
                last_t     <= sp_left0 ? 7'h7F : p_tile;
                last_win   <= sp_left0 ? 1'b0  : sp_in_win;
            end
            else begin
                fifo  <= push_ok ? row16 : (pop_ok ? (fifo >> 2) : fifo);
                count <= push_ok ? 4'd8 : count_after_pop;

                if (pop_ok) begin
                    if (discard != 3'd0) discard <= discard - 3'd1;
                    else if (x_cnt < 8'd160) begin
                        x_cnt <= x_cnt + 8'd1;
                        obj   <= {4'b0000, obj[31:4]};
                    end
                end

                case (fstate)
                    S_TILE0: fstate <= S_TILE1;
                    S_TILE1: begin tile_idx <= vram_data; fstate <= S_LO0; end
                    S_LO0:   fstate <= S_LO1;
                    S_LO1:   begin lo_r <= vram_data; fstate <= S_HI0; end
                    S_HI0:   fstate <= S_HI1;
                    S_HI1: begin
                        if (dummy) begin
                            // the first fetch of the line is thrown away, and
                            // the next one fetches the same tile for real
                            dummy  <= 1'b0;
                            fstate <= S_TILE0;
                        end
                        else if (push_ok) begin
                            fstate  <= S_TILE0;
                            fetch_x <= fetch_x + 5'd1;
                        end
                        else begin
                            hi_r   <= vram_data;
                            fstate <= S_PUSH;
                        end
                    end
                    S_PUSH: begin
                        if (push_ok) begin
                            fstate  <= S_TILE0;
                            fetch_x <= fetch_x + 5'd1;
                        end
                    end
                    default: fstate <= S_TILE0;
                endcase
            end
        end
    end

endmodule