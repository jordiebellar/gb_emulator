// =============================================================================
// Project      : GameBoy Emulator
// File         : fpga_blargg_top.v
// Author       : Jordie Bellar
// Date         : 2026-09-26
// Description  : Top-level module for the FPGA Blargg testbench. Integrates
//                the GameBoy emulator components and provides interfaces
//                for debugging and testing purposes.
// Revision     : 1.0 - Initial implementation
// =============================================================================
`timescale 1ns / 1ps
module fpga_blargg_top (
    input wire clk,
    input wire btnC,
    output wire RsTx,
    output wire [15:0] led
);

// Reset shift register and logic
reg [3:0] rst_sr = 4'hF;
always @(posedge clk or posedge btnC) begin
    if (btnC) begin
        rst_sr <= 4'hF;
    end
    else begin
        rst_sr <= {rst_sr[2:0], 1'b0};
    end
end
wire rst = rst_sr[3];

localparam [18:0] PH_INC = 19'd16384;
localparam [18:0] PH_MOD = 19'd390625;

reg [18:0] phase;
reg [1:0] tph;
reg ce_gb;
reg ce_m;

wire [18:0] phase_sum = phase + PH_INC;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        phase <= 19'd0;
        tph <= 2'd0;
        ce_gb <= 1'b0;
        ce_m <= 1'b0;
    end
    else begin
        ce_gb <= 1'b0;
        ce_m <= 1'b0;
        if (phase_sum >= PH_MOD) begin
            phase <= phase_sum - PH_MOD;
            ce_gb <= 1'b1;
            tph <= tph + 2'd1;
            if (tph == 2'd3) begin
                ce_m <= 1'b1;
            end
        end
        else begin
            phase <= phase_sum;
        end
    end
end


// CPU Bus
wire [15:0] addr;
wire [7:0] cpu_dout;
wire [7:0] cpu_din;
wire we;

// CPU <-> interrupt controller
wire [7:0] ie;
wire [7:0] if_reg;
wire [7:0] if_clear;
wire if_clear_we;

// Address decode
wire sel_rom  = (addr[15] == 1'b0);                                // 0000-7FFF
wire sel_wram = (addr[15:13] == 3'b110) ||                         // C000-DFFF
                ((addr[15:13] == 3'b111) && (addr < 16'hFE00));    // E000-FDFF echo
wire sel_sb   = (addr == 16'hFF01);                                // Serial data
wire sel_sc   = (addr == 16'hFF02);                                // Serial control
wire sel_tm   = (addr[15:2] == 14'h3FC1);                          // FF04-FF07
wire sel_ic   = (addr == 16'hFF0F) || (addr == 16'hFFFF);          // IF, IE
wire sel_hram = (addr >= 16'hFF80) && (addr != 16'hFFFF);          // FF80-FFFE   

// SM83 core
cpu #(
    .RESET_PC(16'h0100)
) cpu_i (
    .clk(clk), .ce_m(ce_m), .rst(rst),
    .data_in(cpu_din), .we(we), .addr(addr), .data_out(cpu_dout),
    .ie(ie), .if_reg(if_reg), 
    .if_clear(if_clear), .if_clear_we(if_clear_we)
);

// Interrupt controller and timer
wire [7:0] ic_dout;
wire [7:0] tm_dout;
wire       irq_timer;

interrupt_ctrl ic_i (
    .clk(clk), .rst(rst), .ce_gb(ce_gb), .ce_m(ce_m),
    .addr(addr), .data_in(cpu_dout), .we(we), .sel(sel_ic),
    .irq_vblank(1'b0), .irq_lcdstat(1'b0), .irq_timer(irq_timer),
    .irq_serial(1'b0), .irq_joypad(1'b0),
    .if_clear(if_clear), .if_clear_we(if_clear_we),
    .ie(ie), .if_reg(if_reg),
    .data_out(ic_dout), .stall()
);

timer tm_i (
    .clk(clk), .rst(rst), .ce_gb(ce_gb), .ce_m(ce_m),
    .addr(addr), .data_in(cpu_dout), .we(we), .sel(sel_tm),
    .data_out(tm_dout), .stall(),
    .irq_timer(irq_timer)
);

// Cartridge ROM
(* rom_style = "block" *) reg [7:0] rom [0:32767];  // 32KB ROM
reg [7:0] rom_q;

initial $readmemh("rom.hex", rom);

always @(posedge clk) begin
    rom_q <= rom[addr[14:0]];
end

// WRAM
(* ram_style = "block" *) reg [7:0] wram [0:8191];  // 8KB WRAM
reg [7:0] wram_q;

always @(posedge clk) begin
    if (sel_wram && we && ce_m) begin
        wram[addr[12:0]] <= cpu_dout;
    end
    wram_q <= wram[addr[12:0]];
end

// HRAM
reg [7:0] hram [0:127];  // 128 bytes HRAM
reg [7:0] hram_q;

always @(posedge clk) begin
    if (sel_hram && we && ce_m) begin
        hram[addr[6:0]] <= cpu_dout;
    end
    hram_q <= hram[addr[6:0]];
end

// Read mux back to CPU
wire [7:0] ser_d

endmodule