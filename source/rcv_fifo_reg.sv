// $Id: $
// File name:   rcv_fifo_reg.sv
// Created:     4/15/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Registers to keep the data of the rcv_fifo.
module rcv_fifo_reg (
	input wire clk,
	input wire [1:0] tail_ptr,
	input wire [1:0] tail_side,
	input wire [1:0] head_ptr,
	input wire [31:0] HWDATA,
	input wire WE,
	output reg [127:0] rcv_fifo_out
);

	reg [2:0][3:0][31:0] arr;
	wire [2:0][3:0][31:0] temp_arr;
	
	always_comb begin : OUTPUT_LOGIC
		rcv_fifo_out = {arr[head_ptr][0], arr[head_ptr][1], arr[head_ptr][2], arr[head_ptr][3]};
	end
	genvar i;
	genvar j;

	generate
		for (i = 0; i < 3; i = i + 1) begin
			for (j = 0; j < 4; j = j + 1) begin
				always_ff @(posedge clk) begin : REG_LOGIC
					arr[i][j] = temp_arr[i][j];
				end
			end
		end
	endgenerate

	generate
		for (i = 0; i < 3; i = i + 1) begin
			for (j = 0; j < 4; j = j + 1) begin
				assign temp_arr[i][j] = (WE == 1'b1 && tail_ptr == i && tail_side == j ? HWDATA : arr[i][j]);
			end
		end
	endgenerate
endmodule
