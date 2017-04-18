// $Id: $
// File name:   tb_inv_shift_rows.sv
// Created:     4/16/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: testbench for inv_shift_rows

`timescale 1ns / 100ps

module tb_inv_shift_rows ();

	// Default Config Test Variables & constants
	reg	[127:0] tb_input_block;
	reg	[127:0] tb_shifted_block;
	reg	[127:0] tb_expected;

	// DUT port map
	inv_shift_rows DUT(.input_block(tb_input_block), .shifted_block(tb_shifted_block));
	
	// Test bench process
	initial
	begin
		//initialize and then wait
		tb_input_block = 128'b00011111110100001001011011011000001100011111001100110000010110100000110100010011101010001110100001000100110101011001111101110010; 
		tb_expected = 128'b00011111110100001001011011011000010110100011000111110011001100001010100011101000000011010001001111010101100111110111001001000100;

		if (tb_input_block == tb_expected) begin
			$info("It matches-----------------------------");
		end

	end
	
endmodule
