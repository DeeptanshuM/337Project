// $Id: $
// File name:   tb_shift_rows.sv
// Created:     4/16/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: testbench for shift_rows

`timescale 1ns / 100ps

module tb_shift_rows ();

	// Default Config Test Variables & constants
	reg	[127:0] tb_input_block;
	reg	[127:0] tb_shifted_block;
	reg	[127:0] tb_expected;

	// DUT port map
	shift_rows DUT(.input_block(tb_input_block), .shifted_block(tb_shifted_block));
	
	// Test bench process
	initial
	begin
		//initialize and then wait
		tb_input_block = 128'b11010101010111010100000001000000001101111000000010101111111001001110110010111010001010001111000000101011001100001111100010010111;
		tb_expected = 128'b11010101010111010100000001000000100000001010111111100100001101110010100011110000111011001011101010010111001010110011000011111000;

		if (tb_input_block == tb_expected) begin
			$info("It matches-----------------------------");
		end

	end
	
endmodule
