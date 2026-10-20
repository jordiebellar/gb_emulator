// =============================================================================
// Project      : GameBoy Emulator
// File         : oam_dma.v
// Author       : Aaron Luebbert
// Date         : 2026-10-06
// Description  : oam dma unit, the register at 0xFF46 and the engine behind
//                  it. writing the register starts a transfer of 160 bytes
//                  from 0xXX00-0xXX9F, XX being the value written, into oam
//                  at 0xFE00-0xFE9F, one byte per m-cycle, 160 m-cycles in
//                  all, per pan docs. everything runs on ce_m.
//
//                  the unit is a bus master for the length of a transfer. it
//                  puts the source address on dma_addr for a whole m-cycle
//                  and takes the byte from dma_rdata on the ce_m edge that
//                  ends it, the same way the cpu samples reads. gb_top
//                  steers dma_addr onto the memory side of the bus while
//                  dma_active is high. each byte goes to oam through the dma
//                  write port, dma_we high on the clock of the ce_m edge, so
//                  it lands whatever mode the ppu is in.
//
//                  timeline, with the register write committing on ce_m edge
//                  W and cycle k meaning the m-cycle that ends on edge W + k:
//                    cycle 1 .. START_DELAY - the start delay, nothing moves
//                    next 160 cycles - byte i is read in cycle
//                      START_DELAY + 1 + i and written on the edge that ends it
//                  dma_active is high for exactly those 160 cycles. it is
//                  the unit's state during the m-cycle that the committing
//                  edge ends, so it is what oam and the oam scan want as is,
//                  and what cpu_blocked uses.
//
//                  a write to the register during a transfer is a restart.
//                  the running transfer carries on through the start delay,
//                  so there is no gap in dma_active, and then the new one
//                  begins from byte 0 with the new source.
//
//                  cpu access during a transfer, per pan docs on dmg: the cpu
//                  reaches only hram. here that is everything from 0xFF00 up,
//                  hram, the io registers, and ie, with 0xFF46 itself
//                  readable, which mooneye's reg_read test depends on.
//                  cpu_blocked is high when a transfer is running and
//                  cpu_addr is below 0xFF00. gb_top should then drop the
//                  access, writes ignored and reads returning 0xFF.
//
//                  choices the docs leave open, to settle with mooneye's
//                  oam_dma_start, oam_dma_restart, oam_dma_timing, and
//                  sources tests once a cpu runs them:
//                  - START_DELAY, 1 m-cycle by default
//                  - source values 0xE0 to 0xFF read from 0xC0 to 0xDF, the
//                    echo of work ram. pan docs only lists 0x00 to 0xDF
//                  - during a transfer a blocked cpu read returns 0xFF. on a
//                    real dmg it can return the byte the dma is moving
//                  - the first byte of a restart's old transfer is not
//                    modeled differently from any other
//                  - the register powers up as 0xFF, its value after the
//                    boot rom
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module oam_dma #(
    parameter START_DELAY = 1
) (
    input  wire        clk,
    input  wire        ce_m,
    input  wire        rst,

    // slave interface for 0xFF46, sel from memory_map's sel_oam_dma
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output wire [7:0]  data_out,

    // the unit as bus master, reading the source
    output wire [15:0] dma_addr,
    input  wire [7:0]  dma_rdata,

    // oam dma write port, to the ppu
    output wire        dma_we,
    output wire [7:0]  dma_waddr,
    output wire [7:0]  dma_wdata,

    output wire        dma_active,

    // the cpu's address, for the access gate
    input  wire [15:0] cpu_addr,
    output wire        cpu_blocked
);

    reg [7:0] src_reg;      // what the register reads back
    reg       run;          // a transfer is running
    reg [7:0] idx;          // byte 0 to 159 of the running transfer
    reg [7:0] run_hi;       // source page of the running transfer
    reg       pend;         // a start is waiting out the start delay
    reg [3:0] pcnt;         // m-cycles of the start delay left
    reg [7:0] new_hi;       // source page of the pending start

    // 0xE0 to 0xFF are read as the echo of 0xC0 to 0xDF
    function [7:0] map_hi(input [7:0] v);
        begin
            map_hi = (v[7:5] == 3'b111) ? {3'b110, v[4:0]} : v;
        end
    endfunction

    wire wr_start = sel && we && ce_m;

    assign dma_active = run;
    assign dma_addr   = {run_hi, idx};
    assign dma_we     = run && ce_m;
    assign dma_waddr  = idx;
    assign dma_wdata  = dma_rdata;
    assign data_out   = sel ? src_reg : 8'h00;
    assign cpu_blocked = run && (cpu_addr[15:8] != 8'hFF);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            src_reg <= 8'hFF;
            run     <= 1'b0;
            idx     <= 8'd0;
            run_hi  <= 8'd0;
            pend    <= 1'b0;
            pcnt    <= 4'd0;
            new_hi  <= 8'd0;
        end
        else if (ce_m) begin
            // the running transfer moves one byte on every edge
            if (run) begin
                if (idx == 8'd159) begin
                    run <= 1'b0;
                    idx <= 8'd0;
                end
                else begin
                    idx <= idx + 8'd1;
                end
            end

            // a pending start counts down its delay and then takes over
            if (pend) begin
                if (pcnt <= 4'd1) begin
                    run    <= 1'b1;
                    idx    <= 8'd0;
                    run_hi <= new_hi;
                    pend   <= 1'b0;
                end
                else begin
                    pcnt <= pcnt - 4'd1;
                end
            end

            // a write to the register begins the start delay. with a delay of
            // 0 the transfer starts on the very next cycle
            if (wr_start) begin
                src_reg <= data_in;
                new_hi  <= map_hi(data_in);
                if (START_DELAY == 0) begin
                    run    <= 1'b1;
                    idx    <= 8'd0;
                    run_hi <= map_hi(data_in);
                    pend   <= 1'b0;
                end
                else begin
                    pend <= 1'b1;
                    pcnt <= START_DELAY[3:0];
                end
            end
        end
    end

endmodule