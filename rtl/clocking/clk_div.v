`timescale 1ns / 1ps

module clk_div (
    input  wire clk_100m,  // shared 100MHz clock, the only real clock in the design
    input  wire rst,       // active-high, matches cpu.v / memory_map.v convention
    output reg  ce_gb,     // ~4.194304MHz enable, one clk_100m cycle wide
    output reg  ce_vga     // 25MHz enable, one clk_100m cycle wide
);

    // -------------------------------------------------------------------
    // gb-rate enable, nco / phase-accumulator divider
    // 100MHz doesn't divide evenly into 4.194304MHz (100e6/4194304 ~= 23.84)
    // so a plain counter would run at the wrong average rate. this
    // accumulator hits the exact average rate instead, at the cost of a
    // little jitter in individual pulse spacing
    // -------------------------------------------------------------------
    localparam integer W         = 32;
    localparam [31:0]  INCREMENT = 32'd180143985; // round(2^32 * 4.194304MHz / 100MHz)

    reg  [W-1:0] gb_acc;
    wire [W:0]   gb_acc_next = {1'b0, gb_acc} + INCREMENT;

    always @(posedge clk_100m or posedge rst) begin
        if (rst) begin
            gb_acc <= {W{1'b0}};
            ce_gb  <= 1'b0;
        end
        else begin
            gb_acc <= gb_acc_next[W-1:0];
            ce_gb  <= gb_acc_next[W]; // registered overflow bit, clean single-cycle pulse
        end
    end

    // -------------------------------------------------------------------
    // vga-rate enable, plain mod-4 counter
    // 100MHz/25MHz = 4 exactly, no accumulator needed here - this is the
    // one case where a straightforward counter is both simpler and exact
    // -------------------------------------------------------------------
    reg [1:0] vga_count;

    always @(posedge clk_100m or posedge rst) begin
        if (rst) begin
            vga_count <= 2'd0;
            ce_vga    <= 1'b0;
        end
        else if (vga_count == 2'd3) begin
            vga_count <= 2'd0;
            ce_vga    <= 1'b1; // one cycle wide, fires every 4th clk_100m edge
        end
        else begin
            vga_count <= vga_count + 2'd1;
            ce_vga    <= 1'b0;
        end
    end

endmodule
