// =============================================================================
// Project      : GameBoy Emulator
// File         : timer.v
// Author       : Jordie Bellar
// Date         : 2026-09-12
// Description  : Implements the GameBoy timer. Responsible for managing
//                the DIV, TIMA, TMA, and TAC registers, and generating
//                timer interrupts as needed.
//
//                Edge ordering: on every M-cycle edge the timer's own update
//                (tick, overflow, reload) happens first, then the CPU's
//                access. Writes override a same-edge tick; reads return the
//                post-update (next-state) value.
//
//                Overflow (Pan Docs, Timer Obscure Behaviour):
//                  - end of cycle A: TIMA FF -> 00, reload pending
//                  - end of cycle B: TIMA <- TMA, interrupt strobe
//                  - TIMA write on the overflow edge cancels (rule 1)
//                  - TIMA write on the reload edge is ignored (rule 2)
//                  - TMA write on the reload edge reaches TIMA (rule 3)
//
//                Design choice (not stated in the docs): a glitch tick on
//                the reload edge is overridden by the reload.
// Revision     : 1.0 - Initial implementation
//                1.1 - Hardware-first edge ordering, next-state reads,
//                      single-flag overflow sequencing
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
    output reg [7:0] data_out,     // Data bus output (combinational, post-edge value)
    output wire stall,             // Stall signal
    output wire irq_timer          // Timer interrupt request (strobe on reload edge)
);

reg [15:0] sys_cnt;              // System counter
wire [7:0] div = sys_cnt[15:8];   // DIV register (upper 8 bits of system counter)

reg [7:0] tima;                  // TIMA register FF05
reg [7:0] tma;                   // TMA register FF06
reg [2:0] tac;                   // TAC register FF07 [2] enable, [1:0] input clock select

reg ovf_pending;                 // TIMA overflowed on the last M-cycle edge; reload due on the next

// Multiplexer: which system counter bit clocks TIMA for a given TAC select
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

// Write enable signals, committing on this clock's edge
wire div_write = sel && we && ce_m && (addr[1:0] == 2'b00);
wire tima_write = sel && we && ce_m && (addr[1:0] == 2'b01);
wire tma_write = sel && we && ce_m && (addr[1:0] == 2'b10);
wire tac_write = sel && we && ce_m && (addr[1:0] == 2'b11);

// Next state logic for the system counter, TAC, and TMA registers
wire [15:0] cnt_next = div_write ? 16'h0000 : ce_gb ? sys_cnt + 16'h0001 : sys_cnt;
wire [2:0] tac_next = tac_write ? data_in[2:0] : tac;
wire [7:0] tma_next = tma_write ? data_in : tma;

// Timer input and tick signals (falling edge of selected bit AND enable, on this edge)
wire timer_in_now = tac[2] & sel_bit(sys_cnt, tac[1:0]);
wire timer_in_next = tac_next[2] & sel_bit(cnt_next, tac_next[1:0]);
wire tima_tick = timer_in_now & ~timer_in_next;

// Reload signal: edge ending cycle B
wire reload_now = ovf_pending && ce_m;

// Timer interrupt request assignment
assign irq_timer = reload_now;

// Next state logic for TIMA and the overflow flag. Order is the priority:
// reload, then CPU write, then tick.
reg [7:0] tima_next;
reg ovf_next;
always @(*) begin
    tima_next = tima;
    ovf_next = ovf_pending;
    if (reload_now) begin
        tima_next = tma_next;          // Rules 2 and 3: TIMA write ignored, TMA write reaches TIMA
        ovf_next = 1'b0;
    end
    else if (tima_write) begin
        tima_next = data_in;           // Access after the tick: write wins (rule 1 on overflow edge)
    end
    else if (tima_tick) begin
        if (tima == 8'hFF) begin
            tima_next = 8'h00;         // Overflow: end of cycle A
            ovf_next = 1'b1;
        end
        else begin
            tima_next = tima + 8'h01;
        end
    end
end

// System counter and TAC registers
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

// TIMA, TMA, and overflow registers
always @(posedge clk or posedge rst) begin
    if (rst) begin
        tima <= 8'h00;
        tma <= 8'h00;
        ovf_pending <= 1'b0;
    end
    else begin
        tima <= tima_next;
        tma <= tma_next;
        ovf_pending <= ovf_next;
    end
end

// Data output logic: post-edge values, so a read sees this edge's update
always @(*) begin
    if (sel) begin
        case (addr[1:0])
            2'b00: data_out = cnt_next[15:8];
            2'b01: data_out = tima_next;
            2'b10: data_out = tma_next;
            2'b11: data_out = {5'b11111, tac_next};
            default: data_out = 8'h00;
        endcase
    end
    else begin
        data_out = 8'h00;
    end
end

assign stall = 1'b0;

endmodule