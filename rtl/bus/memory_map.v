// =============================================================================
// Project      : GameBoy Emulator
// File         : memory_map.v
// Author       : Jordie Bellar
// Date         : 2026-08-03
// Description  : Memory map for the GameBoy emulator.
// Revision     : 1.0 - Initial implementation
// =============================================================================
`timescale 1ns / 1ps
module memory_map (
    input wire  clk,
    input wire  rst,
    input wire  [15:0] addr,
    input wire  [7:0] data_in,
    input wire  we,
    output reg  [7:0] data_out,
    output reg [7:0] ie,       // 0xFFFF
    output reg [7:0] if_reg    // 0xFF0F
);

initial begin
    $readmemh("rom.hex", rom);
end

reg [7:0] rom [0:32767]; // 32KB ROM
reg [7:0] wram [0:8191]; // 8KB Work RAM

always @(posedge clk or posedge rst) begin
    if (rst) begin
        ie <= 8'h00;
        if_reg <= 8'h00;
    end
    else begin
        if (we) begin
            // Write operation
            // Write to IE
            if (addr == 16'hFFFF) ie <= data_in;
            // Write to IF
            else if (addr == 16'hFF0F) if_reg <= data_in;
            // Write to Working RAM
            else if (addr >= 16'hC000 && addr <= 16'hDFFF) wram[addr - 16'hC000] <= data_in;
        end 
            else begin
            // Read operation
            // Read IE
            if (addr == 16'hFFFF) data_out <= ie;
            // Read IF
            else if (addr == 16'hFF0F) data_out <= if_reg;
            // Read ROM
            else if (addr >= 16'h0000 && addr <= 16'h7FFF) begin
                data_out <= rom[addr];
            end
            // Read RAM
            else if (addr >= 16'hC000 && addr <= 16'hDFFF) begin
                data_out <= wram[addr - 16'hC000];
            end
            // UNMAPPED ADDRESS
            else begin
                data_out <= 8'hFF; // Default value for unmapped addresses
            end
        end
    end
end

endmodule

