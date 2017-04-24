// $Id: $
// File name:   rcv_comb_output.sv
// Created:     4/15/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Combinational output block of rcv fifo.
module rcv_comb_output (
	input wire [1:0] head_ptr,
	input wire [1:0] tail_side,
	input wire [1:0] tail_ptr,
	input wire tail_tog,
	input wire head_tog,
	output reg full,
	output reg empty,
	output reg framing_error
);
	always_comb begin 
		empty = 1'b0;
		full = 1'b0;
		framing_error = 1'b0;
		if (head_ptr == tail_ptr && tail_tog == head_tog && tail_side == 2'b0) begin
			empty = 1'b1;
		end
		if (head_ptr == tail_ptr && tail_tog != head_tog) begin
			full = 1'b1;
		end
		if (tail_side != 0) begin
			framing_error = 1'b1;
		end
	end
endmodule
