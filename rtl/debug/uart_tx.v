// =============================================================================
// Project      : GameBoy Emulator
// File         : uart_tx.v
// Author       : Jordie Bellar
// Date         : 2026-09-26
// Description  : Implements a UART transmitter module. Responsible for
//                serializing parallel data and transmitting it over the
//                UART TX line according to the specified baud rate.
// Revision     : 1.0 - Initial implementation
// =============================================================================
`timescale 1ns / 1ps
module uart_tx #(
    parameter CLK_HZ = 100_000_000,  // Default clock frequency: 100 MHz
    parameter BAUD = 115_200
)(
    input wire clk,
    input wire rst,
    input wire [7:0] data,
    input wire valid,
    output wire ready,
    output reg tx
);

// Calculate the number of clock cycles per UART bit
localparam integer CLKS_PER_BIT = CLK_HZ / BAUD;

// Calculate the number of bits required to count up to CLKS_PER_BIT
localparam integer CNT_W = $clog2(CLKS_PER_BIT);

localparam S_IDLE = 2'b00;
localparam S_START = 2'b01;
localparam S_DATA = 2'b10;
localparam S_STOP = 2'b11;

// Internal signals
reg [1:0] state;
reg [CNT_W-1:0] baud_cnt;
reg [2:0] bit_idx;
reg [7:0] shreg;

assign ready = (state == S_IDLE);

wire bit_done = (baud_cnt == CLKS_PER_BIT - 1);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= S_IDLE;
        baud_cnt <= {CNT_W{1'b0}};
        bit_idx <= 3'b0;
        shreg <= 8'b0;
        tx <= 1'b1; // Idle state for UART TX line is high
    end 
    else begin
        case (state)

            S_IDLE: begin
                tx <= 1'b1; // Idle state for UART TX line is high
                if (valid) begin
                    shreg <= data;
                    baud_cnt <= {CNT_W{1'b0}};
                    tx <= 1'b0; // Start bit
                    state <= S_START;
                end
            end

            S_START: begin
                if (bit_done) begin
                    baud_cnt <= {CNT_W{1'b0}};
                    tx <= shreg[0]; // Transmit the first data bit
                    shreg <= {1'b0, shreg[7:1]}; // Shift the data register to prepare the next bit
                    bit_idx <= 3'b0;
                    state <= S_DATA;
                end
                else begin
                    baud_cnt <= baud_cnt + 1'b1;
                end
            end

            S_DATA: begin
                if (bit_done) begin
                    baud_cnt <= {CNT_W{1'b0}};
                    if (bit_idx == 3'b111) begin
                        tx <= 1'b1; // Stop bit
                        state <= S_STOP;
                    end
                    else begin
                        tx <= shreg[0];
                        shreg <= {1'b0, shreg[7:1]};
                        bit_idx <= bit_idx + 1'b1;
                    end
                end
                else begin
                    baud_cnt <= baud_cnt + 1'b1;
                end
            end

            S_STOP: begin
                if (bit_done) begin
                    baud_cnt <= {CNT_W{1'b0}};
                    state <= S_IDLE;
                end
                else begin
                    baud_cnt <= baud_cnt + 1'b1;
                end
            end

            default: begin
                state <= S_IDLE;
            end
        endcase
    end
end

endmodule

                    
    