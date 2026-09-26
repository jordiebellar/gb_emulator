// =============================================================================
// Project      : GameBoy Emulator
// File         : interrupt_ctrl.v
// Author       : Jordie Bellar
// Date         : 2026-09-12
// Description  : Implements the GameBoy interrupt controller. Responsible for
//                managing the IE and IF registers, and handling interrupt
//                requests and acknowledgments.
// Revision     : 1.0 - Initial implementation
// =============================================================================

`timescale 1ns / 1ps
module interrupt_ctrl (
    input wire clk,                // Clock signal
    input wire rst,                // Reset signal
    input wire ce_gb,              // Clock enable for T cycle clock domain
    input wire ce_m,               // Clock enable for M cycle clock domain
    input wire [15:0] addr,        // Address bus
    input wire [7:0] data_in,      // Data input bus
    input wire we,                 // Write enable signal
    input wire sel,                // select signal
    input wire irq_vblank,         // VBlank interrupt request
    input wire irq_lcdstat,       // LCD STAT interrupt request
    input wire irq_timer,          // Timer interrupt request
    input wire irq_serial,         // Serial interrupt request
    input wire irq_joypad,         // Joypad interrupt request
    input wire [7:0] if_clear,     // IF register clear mask
    input wire if_clear_we,        // IF clear write enable
    output wire [7:0] ie,          // IE register
    output wire [7:0] if_reg,      // IF register
    output reg [7:0] data_out,     // Data output bus
    output wire stall              // Stall signal
);

localparam ADDR_IF = 16'hFF0F;  // Address of the IF register
localparam ADDR_IE = 16'hFFFF;  // Address of the IE register

// Internal registers for IE and IF
reg [7:0] ie_r;
reg [4:0] if_r;

// Concatenate the individual interrupt requests into a single bus for easier handling
wire [4:0] irq_req = {irq_joypad, irq_serial, irq_timer, irq_lcdstat, irq_vblank};

// Write enable signals for the IF and IE registers
wire bus_wr = sel && we && ce_m;
wire wr_if = bus_wr && (addr == ADDR_IF);
wire wr_ie = bus_wr && (addr == ADDR_IE);

// Next value computation for the IF register
reg [4:0] if_next;

// Combinational logic to determine the next value of the IF register based on writes, clears, and interrupt requests
always @(*) begin
    // Default assignment for the next IF register value
    if_next = if_r;
    if (wr_if) begin
        // Update the next IF register value based on the data input
        if_next = data_in[4:0];
    end
    if (ce_m && if_clear_we) begin
        // Clear the specified bits in the IF register based on the if_clear mask
        if_next = if_next & ~if_clear[4:0];
    end
    if (ce_gb) begin
        // Set the IF register bits corresponding to active interrupt requests
        if_next = if_next | irq_req;
    end
end

// Sequential logic for updating the IE and IF registers
always @(posedge clk or posedge rst) begin
    // Reset condition for the IE and IF registers
    if (rst) begin
        ie_r <= 8'b0;
        if_r <= 5'b0;
    end
    // Update condition for the IE and IF registers
    else begin
        // Update the IE register if a write to it is requested
        if (wr_ie) begin
            ie_r <= data_in;
        end
        // Update the IF register with the next computed value
        if_r <= if_next;
    end
end

// Sequential logic for updating the data output based on the selected address
always @(posedge clk or posedge rst) begin
    // Reset condition for the data output register
    if (rst) begin
        data_out <= 8'b0;
    end
    // Update condition for the data output register
    else if (sel) begin
        data_out <= (addr == ADDR_IE) ? ie_r : {3'b111, if_r};
    end
    // Default condition for the data output register
    else begin
        data_out <= 8'h00;
    end
end

// Combinational logic for the stall signal and output assignments
assign stall = 1'b0; // The stall signal is always low, indicating no stalling of the CPU.
assign ie = ie_r;
assign if_reg = {3'b000, if_r};

endmodule
