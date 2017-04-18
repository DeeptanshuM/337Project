// $Id: $
// File name:   tb_inv_sub_bytes.sv
// Created:     4/16/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: testbench for inv_sub_bytes

`timescale 1ns / 100ps

module tb_inv_sub_bytes ();

	// Default Config Test Variables & constants
	reg	[127:0] tb_input_block;
	reg	[127:0] tb_subbed_block;
	reg	[127:0] tb_expected;

	// DUT port map
	inv_sub_bytes DUT(.input_block(tb_input_block), .subbed_block(tb_subbed_block));
	
	// Test bench process
	initial
	begin
		//initialize and then wait
		tb_input_block = 128'b00101010001101000001010101011100001011111011010111011000010001100010110000101001111111101100000110110000010101111001110101101010;
		tb_expected = 128'b10010101001010000010111110100111010011101101001000101101100110000100001001001100000011001101110111111100110110100111010101011000;

		if (tb_input_block == tb_expected) begin
			$info("It matches-----------------------------");
		end

	end
	
endmodule
