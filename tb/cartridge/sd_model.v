// =============================================================================
// Project      : GameBoy Emulator
// File         : sd_model.v
// Author       : Aaron Luebbert
// Date         : 2026-11-09
// Description  : behavioral sd card in spi mode, for simulation only. it
//                  answers the commands sd_spi sends - cmd0, cmd8, cmd55,
//                  acmd41, cmd58, cmd16 and cmd17 - with the response framing
//                  a real card uses, including a gap of NCR idle bytes before
//                  r1 and before the data token. the card stays in the idle
//                  state for the first IDLE_ACMDS acmd41 calls, like a real
//                  card that needs a moment to power up.
//
//                  the image is a plain byte array, load it from the testbench
//                  with $readmemh into img. SDHC = 1 gives block addressing,
//                  SDHC = 0 a byte addressed version 1 card (cmd8 is illegal).
//
//                  counters for the testbench: reads (cmd17 count) and
//                  last_sector.
// Revision     : 1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module sd_model #(
    parameter integer SECTORS    = 8192,
    parameter integer SDHC       = 1,
    parameter integer IDLE_ACMDS = 3,
    parameter integer NCR        = 2
) (
    input  wire sck,
    input  wire cs_n,
    input  wire mosi,
    output reg  miso
);

    reg [7:0] img [0:SECTORS*512-1];

    integer reads;
    integer last_sector;
    integer cmd_count;

    // shift registers
    reg [7:0] rx_sh;
    integer   rbits;
    reg [7:0] cmdb [0:5];
    integer   cmdn;

    reg [7:0] txq [0:1023];
    integer   qh, qt;
    reg [7:0] tx_sh;
    integer   tbits;

    reg       idle_st;
    reg       app_cmd;
    integer   acmd_cnt;

    integer i;
    reg [31:0] arg;
    integer    sec;

    task push(input [7:0] b);
        begin txq[qt] = b; qt = qt + 1; end
    endtask

    task push_ncr;
        integer k;
        begin for (k = 0; k < NCR; k = k + 1) push(8'hFF); end
    endtask

    task run_cmd;
        reg [5:0] idx;
        begin
            idx = cmdb[0][5:0];
            arg = {cmdb[1], cmdb[2], cmdb[3], cmdb[4]};
            cmd_count = cmd_count + 1;
            push_ncr;
            if (app_cmd) begin
                app_cmd = 1'b0;
                if (idx == 6'd41) begin
                    acmd_cnt = acmd_cnt + 1;
                    if (acmd_cnt >= IDLE_ACMDS) idle_st = 1'b0;
                    push(idle_st ? 8'h01 : 8'h00);
                end
                else push(8'h04);
            end
            else begin
                case (idx)
                    6'd0: begin idle_st = 1'b1; acmd_cnt = 0; push(8'h01); end
                    6'd8: begin
                        if (SDHC != 0) begin
                            push(8'h01); push(8'h00); push(8'h00); push(8'h01); push(8'hAA);
                        end
                        else push(8'h05);
                    end
                    6'd55: begin app_cmd = 1'b1; push(idle_st ? 8'h01 : 8'h00); end
                    6'd58: begin
                        push(idle_st ? 8'h01 : 8'h00);
                        push(SDHC != 0 ? 8'hC0 : 8'h80); push(8'hFF); push(8'h80); push(8'h00);
                    end
                    6'd16: push(8'h00);
                    6'd17: begin
                        sec = (SDHC != 0) ? arg : (arg >> 9);
                        reads = reads + 1;
                        last_sector = sec;
                        push(8'h00);
                        push_ncr;
                        push(8'hFE);
                        for (i = 0; i < 512; i = i + 1) push(img[sec * 512 + i]);
                        push(8'hAB); push(8'hCD);
                    end
                    default: push(8'h04);
                endcase
            end
        end
    endtask

    initial begin
        miso = 1'b1;
        reads = 0; last_sector = -1; cmd_count = 0;
        rbits = 0; cmdn = 0; qh = 0; qt = 0; tbits = 0; tx_sh = 8'hFF;
        idle_st = 1'b1; app_cmd = 1'b0; acmd_cnt = 0;
    end

    // take the next byte to send, 0xff when nothing is queued, and put its
    // top bit on miso
    task load_next;
        begin
            if (qh < qt) begin tx_sh = txq[qh]; qh = qh + 1; end
            else tx_sh = 8'hFF;
            miso   = tx_sh[7];
            tx_sh  = {tx_sh[6:0], 1'b1};
            tbits  = 1;
        end
    endtask

    // chip select edge resets the framing, the card has the first bit ready
    // as soon as it is selected
    always @(negedge cs_n) begin
        rbits = 0; cmdn = 0; qh = 0; qt = 0;
        load_next;
    end

    always @(posedge cs_n) begin
        rbits = 0; cmdn = 0; qh = 0; qt = 0; tbits = 0;
        miso = 1'b1;
    end

    // mosi is sampled on the rising edge
    always @(posedge sck) begin
        if (!cs_n) begin
            rx_sh = {rx_sh[6:0], mosi};
            rbits = rbits + 1;
            if (rbits == 8) begin
                rbits = 0;
                if (cmdn == 0) begin
                    if (rx_sh[7:6] == 2'b01) begin cmdb[0] = rx_sh; cmdn = 1; end
                end
                else begin
                    cmdb[cmdn] = rx_sh;
                    cmdn = cmdn + 1;
                    if (cmdn == 6) begin cmdn = 0; run_cmd; end
                end
            end
        end
    end

    // the card shifts on the falling edge. after the eighth one it loads the
    // next byte, so its top bit is there for the next rising edge
    always @(negedge sck) begin
        if (!cs_n) begin
            if (tbits == 8) load_next;
            else begin
                miso  = tx_sh[7];
                tx_sh = {tx_sh[6:0], 1'b1};
                tbits = tbits + 1;
            end
        end
    end

endmodule
