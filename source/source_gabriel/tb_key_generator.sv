// $Id: $
// File name:   tb_key_generator.sv
// Created:     4/13/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: testbench for key_generator

`timescale 1ns / 100ps

module tb_key_generator ();

	// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
	
	// Shared Test Variables
	reg tb_clk;

	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	// Default Config Test Variables & constants
	reg	tb_n_rst;
	reg	[3:0] tb_read_addr;
	reg	tb_WE_key_generation;
	reg	[127:0] tb_input_key;
	reg	[127:0] tb_round_key_0;
	reg	[127:0] tb_round_key_x;
	reg	tb_generation_done;
	
	// Declare test bench signals
	integer tb_test_case;
	reg	[127:0] tb_expected_round_key_0;
	reg	[127:0] tb_expected_round_key_x;
	reg	tb_expected_generation_done;
	
	
	// DUT port map
	key_generator DUT(.clk(tb_clk), .n_rst(tb_n_rst), .read_addr(tb_read_addr), .WE_key_generation(tb_WE_key_generation), .original_key(tb_input_key), .round_key_0(tb_round_key_0), .round_key_x(tb_round_key_x), .generation_done(tb_generation_done));
	
	// Test bench process
	initial
	begin
		//initialize and then wait
		tb_test_case = 0;
		tb_n_rst = 0;

		tb_read_addr = 4'b0;
		tb_WE_key_generation = 0;
		tb_input_key = 128'b01110100011010000110100101110011011010010111001101110100011010000110010101101011011001010111100100110000001100000011000000110000;
		//Key: thisisthekey -> with padding: thisisthekey0000

		tb_expected_round_key_0 = 0;
		tb_expected_round_key_x = 0 ;
		tb_expected_generation_done = 0;

		# (1);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		# (1);

		$info("%h, %h, %b", tb_round_key_0, tb_round_key_x, tb_generation_done);

		//TEST CASE ONE: WE not asserted
		@ (negedge tb_clk);
		tb_test_case = 1;
		tb_n_rst = 1;
		tb_read_addr = 4'b1;
		tb_WE_key_generation = 0;
		tb_input_key = 128'b01110100011010000110100101110011011010010111001101110100011010000110010101101011011001010111100100110000001100000011000000110000;
		//Key: thisisthekey -> with padding: thisisthekey0000

		tb_expected_round_key_0 = 0;
		tb_expected_round_key_x = 0 ;
		tb_expected_generation_done = 0;

		$info("%h, %h, %b", tb_round_key_0, tb_round_key_x, tb_generation_done);
		
		//TEST CASE TWO: WE asserted
		//NOTE: AROUND 10 CLOCK CYCLES TO FINISH GENERATING
		@ (negedge tb_clk);
		tb_test_case = 1;
		tb_n_rst = 1;
		tb_read_addr = 4'b1;
		tb_WE_key_generation = 1;
		tb_oinput_key = 128'b01110100011010000110100101110011011010010111001101110100011010000110010101101011011001010111100100110000001100000011000000110000;
		//Key: thisisthekey -> with padding: thisisthekey0000

		tb_expected_round_key_0 = 128'h7468697369737468656b657930303030;
		tb_expected_round_key_x = 128'h716c6d77181f191f7d747c664d444c56;
		tb_expected_generation_done = 0;

		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);

		$info("%h, %h, %b", tb_round_key_0, tb_round_key_x, tb_generation_done);

/*
		//TEST CASE ONE TEST WRITE TO FIFO
		// Initialize test inputs for DUT
		@ (negedge tb_clk);
		tb_n_rst = 0;
		@ (negedge tb_clk);
		tb_n_rst = 1;
		@ (negedge tb_clk);
		tb_test_case = 1;
		tb_n_rst = 1;
		tb_write_enable = 1;
		tb_write_data = 8'b11110000;
		tb_expected_read_data = 8'b11110000;
	
		@ (posedge tb_clk);
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (posedge tb_clk);
		@ (posedge tb_clk);
		# (1);

		if(tb_expected_read_data == tb_read_data) begin
			$info("Correct read_data value for test case %d!", tb_test_case);
		end
		else begin
			$info("Incorrect read_data value for test case %d!", tb_test_case);
		end

		//TEST CASE TWO TEST WRITE THEN READ 
		// Initialize test inputs for DUT
		@ (negedge tb_clk);
		tb_n_rst = 0;
		@ (negedge tb_clk);
		tb_n_rst = 1;
		@ (negedge tb_clk);
		tb_test_case = 2;
		tb_write_enable = 1;
		tb_write_data = 8'b11110000;
		@ (posedge tb_clk);
		@ (posedge tb_clk);

		@ (negedge tb_clk);
		tb_read_enable = 1;
		tb_expected_read_data = 8'b11110000;
	
		@ (posedge tb_clk);
		@ (posedge tb_clk);
		@ (posedge tb_clk);

		if(tb_expected_read_data == tb_read_data) begin
			$info("Correct read_data value for test case %d!", tb_test_case);
		end
		else begin
			$info("Incorrect read_data value for test case %d!", tb_test_case);
		end

		//TEST CASE THREE FULL FIFO
		// Initialize test inputs for DUT
		@ (negedge tb_clk);
		tb_n_rst = 0;
		@ (negedge tb_clk);
		tb_n_rst = 1;
		@ (negedge tb_clk);
		tb_test_case = 3;

		//write 8 bytes
		tb_write_data = 8'b11111111;
		tb_write_enable = 1;
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (negedge tb_clk);
		tb_write_data = 8'b11111111;
		tb_write_enable = 1;
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (negedge tb_clk);
		tb_write_data = 8'b11111111;
		tb_write_enable = 1;
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (negedge tb_clk);
		tb_write_data = 8'b11111111;
		tb_write_enable = 1;
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (negedge tb_clk);
		tb_write_data = 8'b11111111;
		tb_write_enable = 1;
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (negedge tb_clk);
		tb_write_data = 8'b11111111;
		tb_write_enable = 1;
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (negedge tb_clk);
		tb_write_data = 8'b11111111;
		tb_write_enable = 1;
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (negedge tb_clk);
		tb_write_data = 8'b11111111;
		tb_write_enable = 1;
		@ (negedge tb_clk);
		tb_write_enable = 0;

		@ (posedge tb_clk);

		if(tb_expected_fifo_full == tb_fifo_full) begin
			$info("Correct fifo_full value for test case %d!", tb_test_case);
		end
		else begin
			$info("Incorrect fifo_full value for test case %d!", tb_test_case);
		end

		//TEST CASE FOUR EMPTY FIFO
		@ (negedge tb_clk);
		tb_test_case = 4;

		tb_read_enable = 1;
		@ (negedge tb_clk);
		tb_read_enable = 0;
		@ (negedge tb_clk);
		@ (negedge tb_clk);
		@ (negedge tb_clk);

		tb_read_enable = 1;
		@ (negedge tb_clk);
		tb_read_enable = 0;
		@ (negedge tb_clk);
		@ (negedge tb_clk);
		@ (negedge tb_clk);

		tb_read_enable = 1;
		@ (negedge tb_clk);
		tb_read_enable = 0;
		@ (negedge tb_clk);
		@ (negedge tb_clk);
		@ (negedge tb_clk);

		tb_read_enable = 1;
		@ (negedge tb_clk);
		tb_read_enable = 0;
		@ (negedge tb_clk);
		@ (negedge tb_clk);
		@ (negedge tb_clk);

		tb_read_enable = 1;
		@ (negedge tb_clk);
		tb_read_enable = 0;
		@ (negedge tb_clk);
		@ (negedge tb_clk);
		@ (negedge tb_clk);

		tb_read_enable = 1;
		@ (negedge tb_clk);
		tb_read_enable = 0;
		@ (negedge tb_clk);
		@ (negedge tb_clk);
		@ (negedge tb_clk);

		tb_read_enable = 1;
		@ (negedge tb_clk);
		tb_read_enable = 0;
		@ (negedge tb_clk);
		@ (negedge tb_clk);
		@ (negedge tb_clk);

		tb_read_enable = 1;
		@ (negedge tb_clk);
		tb_read_enable = 0;
		@ (negedge tb_clk);
		@ (negedge tb_clk);
		@ (negedge tb_clk);


		if(tb_expected_fifo_empty == tb_fifo_empty) begin
			$info("Correct fifo_empty value for test case %d!", tb_test_case);
		end
		else begin
			$info("Incorrect fifo_empty value for test case %d!", tb_test_case);
		end
*/

	end
	
endmodule
