// =============================================================================
// Project      : GameBoy Emulator
// File         : bus_master.v
// Author       : Aaron Luebbert
// Date         : 2026-10-05
// Description  : testbench helper, not synthesizable. a cpu-style bus master
//                  that drives and samples the bus the way the interface
//                  contract (section 1) says the cpu does:
//                  - addr, write data, and we are set right after one ce_m
//                    edge and held for the whole m-cycle
//                  - read data is sampled ON the ce_m edge that ends the
//                    m-cycle, before any register updates on that edge
//                  sampling on the edge instead of after it is the whole
//                  point. a testbench that reads after the edge cannot see
//                  a read register that only settles on that edge, which is
//                  how a stale read bug hid through every earlier test.
//
//                  the testbench owns ce_m and shares it with the dut, so
//                  the enable relationship is the real one, one ce_m in
//                  four clocks. use it from the testbench as bm.read(addr),
//                  bm.write(addr, data), and bm.rd for the last read value.
//
//                  write_short holds a write for only part of an m-cycle,
//                  ending before the ce_m edge, so it must not commit.
//
//                  late is high for the last clock before the ce_m edge that
//                  ends an access. a testbench can use it to make a signal
//                  change exactly on that edge, which is how a ppu mode
//                  transition landing on an access's edge is modeled.
//
//                  write_now and read_now start the access immediately
//                  instead of waiting for alignment. the caller must already
//                  be at the first negedge after a ce_m edge, which lets a
//                  test land an access's ce_m edge on a chosen tick.
// Revision     : 1.1 - added late, write_now, and read_now
//                  1.0 - initial implementation
// =============================================================================
`timescale 1ns / 1ps

module bus_master (
    input  wire        clk,
    input  wire        ce_m,
    output reg  [15:0] addr,
    output reg  [7:0]  wdata,
    output reg         we,
    output reg         sel,    // high for the whole access, a stand-in for the decoder
    output reg         late,   // high for the last clock before the sampling edge
    input  wire [7:0]  rdata   // what the cpu would see on its data_in
);

    reg [7:0] rd;              // the value sampled by the last read

    initial begin
        addr = 16'h0000; wdata = 8'h00; we = 1'b0; sel = 1'b0; late = 1'b0; rd = 8'h00;
    end

    // wait for the negedge that follows a ce_m edge, the start of an m-cycle
    task align;
        begin
            @(posedge clk);
            while (!ce_m) @(posedge clk);
            @(negedge clk);
        end
    endtask

    // run to the ce_m edge that ends the access and sample on it. ce_m is
    // high for the whole clock before its edge, so the negedge that sees it
    // high is in the last clock of the access
    task finish_access;
        begin
            @(negedge clk);
            while (!ce_m) @(negedge clk);
            late = 1'b1;
            @(posedge clk);
            rd = rdata;          // before the edge's register updates
            @(negedge clk);
            we = 1'b0;
            sel = 1'b0;
            late = 1'b0;
        end
    endtask

    task write(input [15:0] a, input [7:0] d);
        begin
            align;
            addr = a; wdata = d; we = 1'b1; sel = 1'b1;
            finish_access;
        end
    endtask

    task read(input [15:0] a);
        begin
            align;
            addr = a; wdata = 8'h00; we = 1'b0; sel = 1'b1;
            finish_access;
        end
    endtask

    // a write released after 2 clocks, before the ce_m edge
    task write_short(input [15:0] a, input [7:0] d);
        begin
            align;
            addr = a; wdata = d; we = 1'b1; sel = 1'b1;
            repeat (2) @(posedge clk);
            @(negedge clk);
            we = 1'b0;
            sel = 1'b0;
        end
    endtask

    task write_now(input [15:0] a, input [7:0] d);
        begin
            addr = a; wdata = d; we = 1'b1; sel = 1'b1;
            finish_access;
        end
    endtask

    task read_now(input [15:0] a);
        begin
            addr = a; wdata = 8'h00; we = 1'b0; sel = 1'b1;
            finish_access;
        end
    endtask

endmodule