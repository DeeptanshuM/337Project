// $Id: $
// File name:   rcv_counter_idx.sv
// Created:     4/15/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Side index pointer of tail to the fifo.
module rcv_counter_idx (
	input wire clk,
	input wire n_rst,
	input wire count_en1,
	input wire sync_clr,
	output reg [1:0] tail_side
);
	fifo_flex_counter #(.NUM_CNT_BITS(2)) FLEXCNT
	(
		.clk(clk),
		.n_rst(n_rst),
		.clear(sync_clr),
		.count_enable(count_en1),
		.rollover_val(2'b11),
		.count_out(tail_side)
	);
endmodule
