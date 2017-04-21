// $Id: $
// File name:   tb_sub_bytes.sv
// Created:     4/16/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: testbench for sub_bytes

`timescale 1ns / 100ps

module tb_sub_bytes ();

	// Default Config Test Variables & constants
	reg	[127:0] tb_input_block;
	reg	[127:0] tb_subbed_block;
	reg	[127:0] tb_expected;

	// DUT port map
	sub_bytes DUT(.input_block(tb_input_block), .subbed_block(tb_subbed_block));
	
	// Test bench process
	initial
	begin
		//initialize and then wait
		tb_input_block = 128'b01111000010000011001010100110011111010110011001100010100110100100010000110110001011101001110000111000111010100101011011010001110;
		tb_expected = 128'b10111100100000110010101011000011111010011100001111111010101101011111110111001000100100101111100011000110000000000100111000011001;

		if (tb_input_block == tb_expected) begin
			$info("It matches-----------------------------");
		end

	end
	
endmodule