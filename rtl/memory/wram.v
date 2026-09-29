// =============================================================================
// Project      : GameBoy Emulator
// File         : wram.v
// Author       : Aaron Luebbert
// Date         : 2026-09-29
// Description  : work ram storage, 8kb, 0xC000-0xDFFF plus its echo mirror
//                  at 0xE000-0xFDFF, folded down via address masking.
//                  read and write both commit on sel && ce_m (interface
//                  contract rev 2, section 3) - no autonomous updates, so
//                  post-edge equals current automatically. data_out is
//                  driven to 0 whenever sel is low (section 3 rule).
// Revision     : 2.0 - ce split into ce_gb/ce_m (ce_gb unused, storage has
//                  no t-cycle behavior); write/read commit moved from
//                  ce to sel && ce_m; added the data_out=0-when-deselected
//                  gate.
// =============================================================================
`timescale 1ns / 1ps

module wram (
    input  wire        clk,
    input  wire        ce_gb,    // unused - storage has no autonomous t-cycle behavior
    input  wire        ce_m,
    input  wire        rst,      // unused for storage, kept for interface consistency
    input  wire [15:0] addr,
    input  wire [7:0]  data_in,
    input  wire        we,
    input  wire        sel,
    output wire [7:0]  data_out,
    output wire        stall     // wram never blocks the cpu
);

    assign stall = 1'b0;

    reg [7:0] mem [0:8191];
    reg [7:0] rdata;

    integer i;
    initial begin
        for (i = 0; i < 8192; i = i + 1)
            mem[i] = 8'h00;
        rdata = 8'h00;
    end

    always @(posedge clk) begin
        if (sel && ce_m) begin
            if (we)
                mem[addr[12:0]] <= data_in;
            rdata <= we ? data_in : mem[addr[12:0]];
        end
    end

    assign data_out = sel ? rdata : 8'h00;

endmodule