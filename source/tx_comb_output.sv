// $Id: $
// File name:   tx_comb_output.sv
// Created:     4/16/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Combinational output of tx_fifo.
module tx_comb_output (
	input wire [2:0] head_ptr,
	input wire [1:0] head_side,
	input wire [2:0] tail_ptr,
	input wire tail_tog,
	input wire head_tog,
	output reg full,
	output reg empty
);
	always_comb begin 
		empty = 1'b0;
		full = 1'b0;
		if (head_ptr == tail_ptr && tail_tog == head_tog && head_side == 3'b0) begin
			empty = 1'b1;
		end
		if (head_ptr == tail_ptr && tail_tog != head_tog) begin
			full = 1'b1;
		end
	end
endmodule
