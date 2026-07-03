// =============================================================================
// Project      : GameBoy Emulator
// File         : memory_map.v
// Author       : Jordie Bellar
// Date         : 2026-07-03
// Description  : Memory map for the GameBoy emulator.
// Revision     : 1.0 - Initial implementation
// =============================================================================
`timescale 1ns / 1ps
module memory_map (
    input wire clk,
    input wire rst,
    input wire [15:0] addr,
    input wire [7:0] data_in,
    input wire we,
    output reg [7:0] data_out
);

initial begin
    $readmemh("rom.hex", rom);
end

reg [7:0] rom [0:32767]; // 32KB ROM
reg [7:0] wram [0:8191]; // 8KB Work RAM

always @(posedge clk) begin
    if (we) begin
        // Write operation
        if (addr >= 16'hC000 && addr <= 16'hDFFF) begin
            wram[addr - 16'hC000] <= data_in;
        end
    end 
    else begin
        // Read operation
        if (addr >= 16'h0000 && addr <= 16'h7FFF) begin
            data_out <= rom[addr];
        end else if (addr >= 16'hC000 && addr <= 16'hDFFF) begin
            data_out <= wram[addr - 16'hC000];
        end else begin
            data_out <= 8'hFF; // Default value for unmapped addresses
        end
    end
end

endmodule