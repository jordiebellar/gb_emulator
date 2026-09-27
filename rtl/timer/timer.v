// =============================================================================
// Project      : GameBoy Emulator
// File         : timer.v
// Author       : Jordie Bellar
// Date         : 2026-09-12
// Description  : Implements the GameBoy timer. Responsible for managing
//                the DIV, TIMA, TMA, and TAC registers, and generating
//                timer interrupts as needed.
// Revision     : 1.0 - Initial implementation
// =============================================================================
`timescale 1ns / 1ps
module timer(
    input wire clk,                // Clock signal
    input wire rst,                // Reset signal
    input wire ce_gb,              // GameBoy T clock enable
    input wire ce_m,               // Memory M clock enable
    input wire [15:0] addr,        // Address bus
    input wire [7:0] data_in,      // Data bus input
    input wire we,                 // Write enable
    input wire sel,                // Chip select
    output reg [7:0] data_out,     // Data bus output
    output wire stall,             // Stall signal
    output wire irq_timer          // Timer interrupt request
);

reg [15:0] sys_cnt;              // System counter
wire [7:0] div = sys_cnt[15:8];   // DIV register (upper 8 bits of system counter)

reg [7:0] tima;                  // TIMA register FF05
reg [7:0] tma;                   // TMA register FF06
reg [2:0] tac;                   // TAC register FF07 [2] enable, [1:0] input clock select

reg [1:0] ovf_state;              // Overflow state machine
localparam OVF_NONE  = 2'b00;     // Normal counting
localparam OVF_DELAY  = 2'b01;     // M-cycle after overflow: TIMA reads 00
localparam OVF_RELOAD  = 2'b10;     // M-cycle of reload

// Write enable signals for the DIV and TAC registers
wire div_write = sel && we && ce_m && (addr[1:0] == 2'b00);
wire tac_write = sel && we && ce_m && (addr[1:0] == 2'b11);

wire tima_write = sel && we && ce_m && (addr[1:0] == 2'b01);
wire tma_write = sel && we && ce_m && (addr[1:0] == 2'b10);

// Next state logic for the system counter, TAC, TMA, and TIMA registers
wire [15:0] cnt_next = div_write ? 16'h0000 : ce_gb ? sys_cnt + 16'h0001 : sys_cnt;
wire [2:0] tac_next = tac_write ? data_in[2:0] : tac;
wire [7:0] tma_next = tma_write ? data_in : tma;

// Timer input and tick signals
wire timer_in_now = tac[2] & sel_bit(sys_cnt, tac[1:0]);
wire timer_in_next = tac_next[2] & sel_bit(cnt_next, tac_next[1:0]);
wire tima_tick = timer_in_now & ~timer_in_next;

// Reload signal for TIMA after overflow
wire reload_now = (ovf_state == OVF_DELAY) && ce_m && !tima_write;

// Timer interrupt request assignment
assign irq_timer = reload_now;

function sel_bit;
    input [15:0] cnt;
    input [1:0] s;
    case (s)
        2'b00: sel_bit = cnt[9]; // 4096 Hz
        2'b01: sel_bit = cnt[3]; // 262144 Hz
        2'b10: sel_bit = cnt[5]; // 65536 Hz
        2'b11: sel_bit = cnt[7]; // 16384 Hz
        default: sel_bit = 1'b0;
    endcase
endfunction

always @(posedge clk or posedge rst) begin
    if (rst) begin
        sys_cnt <= 16'h0000;
        tac <= 3'b000;
    end
    else begin
        sys_cnt <= cnt_next;
        tac <= tac_next;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        tima <= 8'h00;
        tma <= 8'h00;
        ovf_state <= OVF_NONE;
    end
    else begin
        // Update TIMA based on write and tick conditions
        tma <= tma_next;
        case (ovf_state)
            // Normal counting state
            OVF_NONE: begin
                if (tima_write) begin
                    tima <= data_in;
                end
                else if (tima_tick) begin
                    if (tima == 8'hFF) begin
                        tima <= 8'h00;
                        ovf_state <= OVF_DELAY;
                    end
                    else begin
                        tima <= tima + 8'h01;
                    end
                end
            end

            // M-cycle after overflow: TIMA reads 00
            OVF_DELAY: begin
                if (ce_m) begin
                    if (tima_write) begin
                        tima <= data_in;
                        ovf_state <= OVF_NONE;
                    end
                    else begin
                        tima <= tma_next;
                        ovf_state <= OVF_RELOAD;
                    end
                end
            end

            // M-cycle of reload
            OVF_RELOAD: begin
                if (ce_m) begin
                    tima <= tma_next;
                    ovf_state <= OVF_NONE;
                end
            end

            default: begin
                ovf_state <= OVF_NONE;
            end

        endcase
    end
end

// Data output logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_out <= 8'h00;
    end
    else if (sel) begin
        // Select data output based on address
        case (addr[1:0])
            2'b00: data_out <= div;
            2'b01: data_out <= tima;
            2'b10: data_out <= tma;
            2'b11: data_out <= {5'b11111, tac};
        endcase
    end
    else begin
        data_out <= 8'h00;
    end
end

assign stall = 1'b0;

endmodule