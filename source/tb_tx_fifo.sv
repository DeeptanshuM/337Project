// $Id: $
// File name:   tb_tx_fifo.sv
// Created:     4/16/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Test bench for transmittor fifo.
`timescale 1ns / 10ps
module tb_tx_fifo();
	parameter CLK_PERIOD				= 4;
	
/*
	input wire clk,
	input wire n_rst,
	input wire [127:0] data_in,
	input wire tx_enq,
	input wire tx_deq_word,
	output wire full,
	output wire empty,
	output wire [31:0] tx_fifo_out
*/

	reg tb_clk;
	reg tb_n_rst;
	reg [127:0] tb_data_in;
	reg tb_tx_enq;
	reg tb_tx_deq_word;
	reg [31:0] tb_tx_fifo_out;
	reg tb_full;
	reg tb_empty;

	integer tb_test_case_num;

	tx_fifo DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.data_in(tb_data_in),
		.tx_enq(tb_tx_enq),
		.tx_deq_word(tb_tx_deq_word),
		.tx_fifo_out(tb_tx_fifo_out),
		.full(tb_full),
		.empty(tb_empty)
	);

	always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2.0);
	end

	task reset_dut;
	begin
		// Activate the design's reset (does not need to be synchronize with clock)
		tb_n_rst = 1'b0;
		
		// Wait for a couple clock cycles
		@(posedge tb_clk);
		@(posedge tb_clk);
		
		// Release the reset
		@(negedge tb_clk);
		tb_n_rst = 1'b1;
		
		// Wait for a while before activating the design
		@(posedge tb_clk);
		@(posedge tb_clk);
	end
	endtask

	task chk_full_empty;
		input exp_full;
		input exp_empty;
	begin
		assert(exp_full == tb_full)
		begin
			$info("Test Case #%0d: Had a correct FIFO FULL value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect FIFO FULL value ******************************", tb_test_case_num);
		end
		assert(exp_empty == tb_empty)
		begin
			$info("Test Case #%0d: Had a correct FIFO EMPTY value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect FIFO EMPTY value ******************************", tb_test_case_num);
		end
	end
	endtask

	task send_data;
		input [127:0] data;
	begin
		@(negedge tb_clk);
		tb_data_in = data;
		tb_tx_enq = 1'b1;
		@(negedge tb_clk);
		tb_tx_enq = 1'b0;
	end
	endtask

	task send_burst;
		input [127:0] data;
		input [127:0] data2;
		input [127:0] data3;
		input [127:0] data4;
	begin
		@(negedge tb_clk);
		tb_tx_enq = 1'b1;
		tb_data_in = data;
		@(negedge tb_clk);
		tb_data_in = data2;
		@(negedge tb_clk);
		tb_data_in = data3;
		@(negedge tb_clk);
		tb_data_in = data4;
		@(negedge tb_clk);
		tb_tx_enq = 1'b0;
		@(negedge tb_clk);

	end
	endtask

	task send_burst_all;
		input [127:0] data;
		input [127:0] data2;
		input [127:0] data3;
		input [127:0] data4;
		input [127:0] data5;
		input [127:0] data6;
	begin
		@(negedge tb_clk);
		tb_tx_enq = 1'b1;
		tb_data_in = data;
		@(negedge tb_clk);
		tb_data_in = data2;
		@(negedge tb_clk);
		tb_data_in = data3;
		@(negedge tb_clk);
		tb_data_in = data4;
		@(negedge tb_clk);
		tb_data_in = data5;
		@(negedge tb_clk);
		tb_data_in = data6;
		@(negedge tb_clk);
		tb_tx_enq = 1'b0;
		@(negedge tb_clk);

	end
	endtask

	task deq_data;
	begin
		@(negedge tb_clk);
		tb_tx_deq_word = 1'b1;
		@(negedge tb_clk);
		tb_tx_deq_word = 1'b0;
		@(negedge tb_clk);
	end
	endtask

	task deq_burst_128;
	begin
		@(negedge tb_clk);
		tb_tx_deq_word = 1'b1;
		@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);
		tb_tx_deq_word = 1'b0;
		@(negedge tb_clk);
	end
	endtask

	task deq_burst_full2empty;
	begin
		@(negedge tb_clk);
		tb_tx_deq_word = 1'b1;
		@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);
		@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);
		@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);
		@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);
		@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);
		@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);@(negedge tb_clk);
		tb_tx_deq_word = 1'b0;
		@(negedge tb_clk);
	end
	endtask

	task chk_output;
		input [31:0] data;
	begin
		assert(data == tb_tx_fifo_out)
		begin
			$info("Test Case #%0d: Had a correct FIFO DATA value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect FIFO DATA value ******************************", tb_test_case_num);
		end
	end
	endtask
	
	reg e_full;
	reg e_empty;
	initial begin
		tb_tx_deq_word = 1'b0;
		tb_tx_enq = 1'b0;
		tb_n_rst = 1'b1;
		tb_test_case_num = 0;
		//TEST 0 TEST AFTER RESET
		reset_dut();
		e_full = 1'b0;
		e_empty = 1'b1;
		chk_full_empty(e_full, e_empty);
		tb_test_case_num = tb_test_case_num + 1;


		//TEST1 TEST AFTER ONE ENQUEUE
		send_data({32'hAA, 32'hBB, 32'hCC, 32'hDD});
		e_full = 1'b0;
		e_empty = 1'b0;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);
		chk_output(32'hAA);
		tb_test_case_num = tb_test_case_num + 1;

		//TEST2 TEST AFTER THREE MORE ENQUEUES
		send_data({32'hEE, 32'hFF, 32'h11, 32'h22});
		send_data({32'h33, 32'h44, 32'h55, 32'h66});
		send_data({32'h77, 32'h88, 32'h99, 32'hAA});
		e_full = 1'b0;
		e_empty = 1'b0;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);
		chk_output(32'hAA);
		tb_test_case_num = tb_test_case_num + 1;

		//TEST3 TEST AFTER ONE DEQUEUE
		deq_data();
		e_full = 1'b0;
		e_empty = 1'b0;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);
		chk_output(32'hBB);
		tb_test_case_num = tb_test_case_num + 1;

		//TEST4 TEST AFTER SENDING BURST
		deq_data(); chk_output(32'hCC);
		deq_data(); chk_output(32'hDD);
		deq_data(); chk_output(32'hEE);
		deq_data(); chk_output(32'hFF);
		deq_data(); chk_output(32'h11);
		e_full = 1'b0;
		e_empty = 1'b0;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);
		tb_test_case_num = tb_test_case_num + 1;
		deq_burst_128();  chk_output(32'h55);
		reset_dut();


		//TEST5 TEST deq
		send_burst("0123456789ABCDEF", "zxcvbnmasdfghqwe", "ZXCVBNMASDFGHJKL", "poiuytrewqasdfgh");
		e_full = 1'b0;
		e_empty = 1'b0;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);
		tb_test_case_num = tb_test_case_num + 1;
		chk_output("0123");
		deq_data(); chk_output("4567");
		deq_data(); chk_output("89AB");
		deq_data(); chk_output("CDEF");
		deq_data(); chk_output("zxcv");
		deq_data(); chk_output("bnma");
		deq_data(); chk_output("sdfg");
		deq_data(); chk_output("hqwe");
		deq_data(); chk_output("ZXCV");
		deq_data(); chk_output("BNMA");
		deq_data(); chk_output("SDFG");
		deq_data(); chk_output("HJKL");
		deq_data(); chk_output("poiu");
		deq_data(); chk_output("ytre");
		deq_data(); chk_output("wqas");
		deq_data(); chk_output("dfgh");
		deq_data(); 
		tb_test_case_num = tb_test_case_num + 1;

		//TEST5 TEST deq
		send_burst("0123456789ABCDEF", "zxcvbnmasdfghqwe", "ZXCVBNMASDFGHJKL", "poiuytrewqasdfgh");
		e_full = 1'b0;
		e_empty = 1'b0;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);
		tb_test_case_num = tb_test_case_num + 1;
		deq_burst_128();
		deq_burst_128();
		deq_burst_128();
		deq_burst_128();
		e_full = 1'b0;
		e_empty = 1'b1;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);
		tb_test_case_num = tb_test_case_num + 1;

		//TEST5 TEST deq
		send_burst_all("0123456789ABCDEF", "zxcvbnmasdfghqwe", "ZXCVBNMASDFGHJKL", "poiuytrewqasdfgh","~!@#$%^&*()_+?><","!@#$%^&*&^%$#@!~");
		e_full = 1'b1;
		e_empty = 1'b0;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);
		chk_output("0123");
		tb_test_case_num = tb_test_case_num + 1;
		deq_burst_full2empty();
		e_full = 1'b0;
		e_empty = 1'b1;
		@(negedge tb_clk);
		chk_full_empty(e_full, e_empty);

	end
endmodule
