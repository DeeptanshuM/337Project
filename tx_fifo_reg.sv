// $Id: $
// File name:   tx_fifo_reg.sv
// Created:     4/16/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Registers of the fifo,
module tx_fifo_reg (
	input wire clk,
	input wire [2:0] tail_ptr,
	input wire [1:0] head_side,
	input wire [2:0] head_ptr,
	input wire [127:0] data_in,
	input wire WE,
	output reg [31:0] tx_fifo_out
);

	reg [5:0][3:0][31:0] arr;
	wire [5:0][3:0][31:0] temp_arr;
	
	always_comb begin : OUTPUT_LOGIC
		tx_fifo_out = arr[head_ptr][head_side];
	end
	genvar i;
	genvar j;

	generate
		for (i = 0; i < 6; i = i + 1) begin
			for (j = 0; j < 4; j = j + 1) begin
				always_ff @(posedge clk) begin : REG_LOGIC
					arr[i][j] = temp_arr[i][j];
				end
			end
		end
	endgenerate

	generate
		for (i = 0; i < 6; i = i + 1) begin
			assign temp_arr[i][0] = (WE == 1'b1 && tail_ptr == i ? data_in[127:96] : arr[i][0]);
			assign temp_arr[i][1] = (WE == 1'b1 && tail_ptr == i ? data_in[95:64]  : arr[i][1]);
			assign temp_arr[i][2] = (WE == 1'b1 && tail_ptr == i ? data_in[63:32]  : arr[i][2]);
			assign temp_arr[i][3] = (WE == 1'b1 && tail_ptr == i ? data_in[31:0]   : arr[i][3]);
		end
	endgenerate
endmodule
