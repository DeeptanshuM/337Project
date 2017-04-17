// $Id: $
// File name:   rcv_counter_head.sv
// Created:     4/15/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Head index counter to keep track of row of head.
module rcv_counter_head (
	input wire clk,
	input wire n_rst,
	input wire rcv_deq,
	output reg [1:0] head_ptr,
	output reg head_tog
);
	wire sys_clr;
	assign sys_clr = 1'b0;
	reg temp_head_tog;
	wire rollover_flag;
	always_ff @(posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			head_tog <= '0;
		end else begin
			head_tog <= temp_head_tog;
		end
	end
	always_comb begin
		temp_head_tog = head_tog;
		if (rollover_flag) begin
			temp_head_tog = ~head_tog;
		end
	end
	fifo_flex_counter #(.NUM_CNT_BITS(2)) FLEXCNT
	(
		.clk(clk),
		.n_rst(n_rst),
		.clear(sys_clr),
		.count_enable(rcv_deq),
		.rollover_val(2'b10),
		.count_out(head_ptr),
		.rollover_flag(rollover_flag)
	);
endmodule
