// $Id: $
// File name:   rcv_counter_tail.sv
// Created:     4/15/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Tail index counter to keep track of the row of the tail.
module rcv_counter_tail (
	input wire clk,
	input wire n_rst,
	input wire count_en2,
	output reg [1:0] tail_ptr,
	output reg tail_tog
);
	reg temp_tail_tog;
	wire rollover_flag;
	wire sys_clr;
	assign sys_clr = 1'b0;
	always_ff @(posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			tail_tog <= '0;
		end else begin
			tail_tog <= temp_tail_tog;
		end
	end
	always_comb begin
		temp_tail_tog = tail_tog;
		if ((2'b10 == tail_ptr) && (count_en2 == 1'b1)) begin
			temp_tail_tog = ~tail_tog;
		end
	end
	fifo_flex_counter #(.NUM_CNT_BITS(2)) FLEXCNT
	(
		.clk(clk),
		.n_rst(n_rst),
		.count_enable(count_en2),
		.rollover_val(2'b10),
		.clear(sys_clr),
		.count_out(tail_ptr),
		.rollover_flag(rollover_flag)
	);
endmodule
