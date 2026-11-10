// =============================================================================
// Project      : GameBoy Emulator
// File         : mbc.v
// Author       : Aaron Luebbert
// Date         : 2026-11-09
// Description  : memory bank controller registers for mbc1, mbc3 and mbc5.
//                  the game writes into the rom address space (0000-7FFF) and
//                  the write lands in one of a few registers, picked by the
//                  top three address bits. this module holds those registers
//                  and turns them into the bank numbers the cartridge uses.
//                  which chip it behaves as comes from kind, which the
//                  cartridge decodes from the header byte at 0147.
//
//                  kind 0  no mapper, rom bank 1 is fixed at 4000
//                  kind 1  mbc1  0000 ram enable (low nibble a), 2000 bank
//                                low 5 bits (0 reads as 1), 4000 bank high
//                                2 bits or ram bank, 6000 mode
//                  kind 2  mbc3  0000 ram enable, 2000 bank 7 bits, 8 on a 4 mb cart (0 reads
//                                as 1), 4000 ram bank 0-3 or clock register
//                                8-c, 6000 clock latch (write 0 then 1)
//                  kind 3  mbc5  0000 ram enable (0a exactly), 2000 bank low
//                                8 bits, 3000 bank bit 8, 4000 ram bank
//
//                  rom_bank is the bank shown at 4000-7FFF, already masked to
//                  the size of the cartridge. rom_bank0 is the bank shown at
//                  0000-3FFF, which is bank 0 except on an mbc1 cart of 1 mb or
//                  more in mode 1, where bank 20, 40 or 60 appears there
//                  (multicart wiring is not supported)
//
//                  writes commit on ce_m like every other peripheral.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module mbc (
    input  wire        clk,
    input  wire        rst,
    input  wire        ce_m,
    input  wire        wr,            // a bus write to 0000-7FFF this cycle
    input  wire [2:0]  a_hi,          // addr[15:13]
    input  wire        a_12,          // addr[12], splits 2000 and 3000 for mbc5
    input  wire [7:0]  d,
    input  wire [1:0]  kind,
    input  wire [8:0]  rom_mask,
    output wire [8:0]  rom_bank,
    output wire [8:0]  rom_bank0,
    output wire        ram_en,
    output wire [3:0]  ram_sel,
    output reg         latch
);

    reg [3:0] ramg;
    reg       ramg5;            // mbc5 enable, set only by 0a
    reg [4:0] bank1;            // mbc1 low bank
    reg [1:0] bank2;            // mbc1 high bank
    reg       mode;
    reg [7:0] b3;               // mbc3 bank, the top bit only matters on a 4 mb cart (mbc30)
    reg [7:0] b5lo;             // mbc5 bank
    reg       b5hi;
    reg [3:0] rsel;             // mbc3 and mbc5 ram bank or clock select
    reg       arm;              // mbc3 latch, a zero was written

    wire do_wr = wr && ce_m;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ramg  <= 4'd0;
            ramg5 <= 1'b0;
            bank1 <= 5'd1;
            bank2 <= 2'd0;
            mode  <= 1'b0;
            b3    <= 8'd1;
            b5lo  <= 8'd1;
            b5hi  <= 1'b0;
            rsel  <= 4'd0;
            arm   <= 1'b0;
            latch <= 1'b0;
        end
        else begin
            latch <= 1'b0;
            if (do_wr) begin
                case (a_hi)
                    3'b000, 3'b001: begin               // 0000-3fff, split by a13 below
                        if (a_hi == 3'b000) begin       // 0000-1fff ram enable
                            ramg  <= d[3:0];
                            ramg5 <= (d == 8'h0A);
                        end
                        else begin                      // 2000-3fff bank
                            bank1 <= d[4:0];
                            b3    <= d;
                            if (a_12) b5hi <= d[0];
                            else      b5lo <= d;
                        end
                    end
                    3'b010: begin                       // 4000-5fff
                        bank2 <= d[1:0];
                        rsel  <= d[3:0];
                    end
                    default: begin                      // 6000-7fff
                        mode <= d[0];
                        if (d == 8'h00) arm <= 1'b1;
                        else begin
                            if (d == 8'h01 && arm) latch <= 1'b1;
                            arm <= 1'b0;
                        end
                    end
                endcase
            end
        end
    end

    wire [4:0] bank1_eff = (bank1 == 5'd0) ? 5'd1 : bank1;
    // the bank register is 7 bits wide on every mbc3 cart but the 4 mb one
    wire [7:0] b3_m      = rom_mask[7] ? b3 : {1'b0, b3[6:0]};
    wire [7:0] b3_eff    = (b3_m == 8'd0)  ? 8'd1 : b3_m;

    reg [8:0] bank_raw;
    always @(*) begin
        case (kind)
            2'd1:    bank_raw = {2'b00, bank2, bank1_eff};
            2'd2:    bank_raw = {1'b0, b3_eff};
            2'd3:    bank_raw = {b5hi, b5lo};
            default: bank_raw = 9'd1;
        endcase
    end

    assign rom_bank  = bank_raw & rom_mask;
    assign rom_bank0 = (kind == 2'd1 && mode) ? ({2'b00, bank2, 5'b00000} & rom_mask) : 9'd0;

    assign ram_en  = (kind == 2'd3) ? ramg5 :
                     (kind == 2'd0) ? 1'b1  : (ramg == 4'hA);

    assign ram_sel = (kind == 2'd1) ? (mode ? {2'b00, bank2} : 4'd0) :
                     (kind == 2'd0) ? 4'd0 : rsel;

endmodule
