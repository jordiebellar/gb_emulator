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

initial $readmemh("rom.mem", rom);

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
wire [7:0] ser_dout; // Serail SB/SC read value

// CPU data input mux
assign cpu_din = sel_rom  ? rom_q  :
                 sel_wram ? wram_q :
                 sel_hram ? hram_q :
                 sel_ic   ? ic_dout :
                 sel_tm   ? tm_dout :
                 (sel_sb || sel_sc) ? ser_dout :
                 8'hFF;  // Default value for unmapped addresses

// Serial port: SB (FF01), SC (FF02), internal clock, no cable attached
reg [7:0] sb; // Serial data
reg       sc_start; // SC bit 7: transfer in progress
reg       sc_clk; // SC bit 0: internal clock
reg [12:0] ser_cnt; // T-cycles left

wire sb_write = sel_sb && we && ce_m;
wire sc_write = sel_sc && we && ce_m;

// Transfer finishes on this edge
wire ser_done = sc_start && sc_clk && ce_gb && (ser_cnt == 13'd1);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        sb <= 8'h00;
        sc_start <= 1'b0;
        sc_clk <= 1'b0;
        ser_cnt <= 13'd0;
    end
    else begin
        // Hardware update first
        if (ser_done) begin
            sc_start <= 1'b0;
            sb <= 8'hFF; // No cable: 1s shifted in
        end
        else if (sc_start && sc_clk && ce_gb) begin
            ser_cnt <= ser_cnt - 13'd1;
        end

        // CPU access
        if (sb_write) begin
            sb <= cpu_dout;
        end
        if (sc_write) begin
            sc_start <= cpu_dout[7];
            sc_clk <= cpu_dout[0];
            ser_cnt <= 13'd4096;
        end
    end
end

// Post edge reads
wire sc_start_next = ser_done ? 1'b0 : sc_start;
wire [7:0] sb_next = ser_done ? 8'hFF : sb;
assign ser_dout = sel_sc ? {sc_start_next, 6'b111111, sc_clk} : sb_next;

// Capture: each internal clock transfer's byte goes out the UART
wire capture = sc_write && cpu_dout[7] && cpu_dout[0];

reg [7:0] tx_byte;
reg       tx_valid;
wire      tx_ready;
reg [47:0] tail;
reg       passed;
reg         failed;
reg         activity;

// UART transmission logic for captured serial bytes
always @(posedge clk or posedge rst) begin
    if (rst) begin
        tx_byte  <= 8'h00;
        tx_valid <= 1'b0;
        tail     <= 48'h0;
        passed   <= 1'b0;
        failed   <= 1'b0;
        activity <= 1'b0;
    end
    else begin
        // Clear tx_valid if UART has taken the byte
        if (tx_valid && tx_ready)
            tx_valid <= 1'b0;
        // Capture new byte if available
        if (capture) begin
            tx_byte  <= sb;
            tx_valid <= 1'b1;
            tail     <= {tail[39:0], sb};
            activity <= ~activity;
            if ({tail[39:0], sb} == "Passed")       passed <= 1'b1;
            if ({tail[31:0], sb} == "ailed")        failed <= 1'b1;
        end
    end
end

// Instantiate UART transmitter for sending captured bytes
uart_tx #(
    .CLK_HZ(100_000_000), .BAUD(115_200)
) uart_i (
    .clk(clk), .rst(rst),
    .data(tx_byte), .valid(tx_valid), .ready(tx_ready),
    .tx(RsTx)
);

// LEDs
reg [25:0] heartbeat;
always @(posedge clk or posedge rst) begin
    if (rst) heartbeat <= 26'd0;
    else     heartbeat <= heartbeat + 26'd1;
end

assign led[15]   = passed;           // Test printed "Passed"
assign led[14]   = failed;           // Test printed "Failed"
assign led[13]   = activity;         // Toggles on every character
assign led[12:1] = 12'h000;
assign led[0]    = heartbeat[25];    // ~1.5 Hz: the design is running

endmodule