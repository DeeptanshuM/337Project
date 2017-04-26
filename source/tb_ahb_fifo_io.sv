// $Id: $
// File name:   tb_ahb_fifo_io.sv
// Created:     4/20/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Test bench for top level i/o modules .
`timescale 1ns / 10ps
module tb_ahb_fifo_io();
	parameter CLK_PERIOD				= 5;
	typedef enum bit [3:0] {SINGLE, INCR} burstType;
	typedef enum bit [1:0] {IDLE, BUZ, NONSEQ, SEQ} htransType;

	integer tb_test_case_num;

	reg          tb_HCLK;
	reg          tb_HRESETn;
	reg          tb_HSELx;
	reg  [31:0]  tb_HADDR;
	reg  [ 2:0]  tb_HBURST;
	reg  [ 3:0]  tb_HPROT;
	reg  [ 2:0]  tb_HSIZE;
	reg  [ 1:0]  tb_HTRANS;
	reg  [31:0]  tb_HWDATA;
	reg          tb_HWRITE;
	reg  [ 3:0]  tb_status;
	reg [127:0]  tb_data_in;
	reg 	     tb_tx_enq;
	reg 	     tb_rcv_deq;
	reg          tb_fix_error;
	reg  [31:0]  tb_HRDATA;
	reg          tb_HREADY;
	reg [ 1:0]   tb_HRESP;
	reg          tb_is_encrypt_pulse;
	reg          tb_is_decrypt_pulse;
	reg          tb_key_in;
	reg [127:0]  tb_rcv_fifo_out;
	reg          tb_tx_fifo_full;
	reg          tb_tx_fifo_empty;
	reg          tb_rcv_fifo_full;
	reg          tb_rcv_fifo_empty;
	reg          tb_framing_error;

	ahb_fifo_io DUT (
		.HCLK(tb_HCLK),
		.HRESETn(tb_HRESETn),
		.HSELx(tb_HSELx),
		.HADDR(tb_HADDR),
		.HBURST(tb_HBURST),
		.HPROT(tb_HPROT),
		.HWDATA(tb_HWDATA),
		.HSIZE(tb_HSIZE),
		.HTRANS(tb_HTRANS),
		.HWRITE(tb_HWRITE),
		.status(tb_status),
		.data_in(tb_data_in),
		.tx_enq(tb_tx_enq),
		.rcv_deq(tb_rcv_deq),
		.fix_error(tb_fix_error),
		.HRDATA(tb_HRDATA),
		.HREADY(tb_HREADY),
		.HRESP(tb_HRESP),
		.is_encrypt_pulse(tb_is_encrypt_pulse),
		.is_decrypt_pulse(tb_is_decrypt_pulse),
		.key_in(tb_key_in),
		.rcv_fifo_out(tb_rcv_fifo_out),
		.tx_fifo_full(tb_tx_fifo_full),
		.tx_fifo_empty(tb_tx_fifo_empty),
		.rcv_fifo_full(tb_rcv_fifo_full),
		.rcv_fifo_empty(tb_rcv_fifo_empty),
		.framing_error(tb_framing_error)
	);

	always
	begin : CLK_GEN
		tb_HCLK = 1'b0;
		#(CLK_PERIOD / 2.0);
		tb_HCLK = 1'b1;
		#(CLK_PERIOD / 2.0);
	end

	task reset_dut;
	begin
		// Activate the design's reset (does not need to be synchronize with clock)
		tb_HRESETn = 1'b0;		
		// Wait for a couple clock cycles
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
		// Release the reset
		@(negedge tb_HCLK);
		tb_HRESETn = 1'b1;
		// Wait for a while before activating the design
		@(posedge tb_HCLK);
		@(posedge tb_HCLK);
	end
	endtask

	task chk_rcv_fifo_out;
		input [127:0] data;
	begin
		assert(data == tb_rcv_fifo_out)
		begin
			$info("Test Case #%0d: Had a correct tb_rcv_fifo_out value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect tb_rcv_fifo_out value ******************************", tb_test_case_num);
		end
	end
	endtask

	task chk_HRDATA;
		input [31:0] data;
	begin
		assert(data == tb_HRDATA)
		begin
			$info("Test Case #%0d: Had a correct tb_HRDATA value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect tb_HRDATA value ******************************", tb_test_case_num);
		end
	end
	endtask

	task chk_rcv_tx_empty_full;
		input e_rcv_empty;
		input e_rcv_full;
		input e_tx_empty;
		input e_tx_full;
	begin
		assert(e_tx_full == tb_tx_fifo_full)
		begin
			$info("Test Case #%0d: Had a correct FIFO tb_tx_fifo_full value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect FIFO tb_tx_fifo_full value ******************************", tb_test_case_num);
		end
		assert(e_tx_empty == tb_tx_fifo_empty)
		begin
			$info("Test Case #%0d: Had a correct FIFO tb_tx_fifo_empty value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect FIFO tb_tx_fifo_empty value ******************************", tb_test_case_num);
		end
		assert(e_rcv_full == tb_rcv_fifo_full)
		begin
			$info("Test Case #%0d: Had a correct FIFO tb_rcv_fifo_full value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect FIFO tb_rcv_fifo_full value ******************************", tb_test_case_num);
		end
		assert(e_rcv_empty == tb_rcv_fifo_empty)
		begin
			$info("Test Case #%0d: Had a correct FIFO tb_rcv_fifo_empty value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect FIFO tb_rcv_fifo_empty value ******************************", tb_test_case_num);
		end
	end
	endtask

	task send_key;
		input [127:0] key;
	begin
		@(posedge tb_HCLK); #0.5ns;
		tb_HSELx = 1'b1;
		tb_HADDR = 32'h10;
		tb_HBURST = INCR;
		tb_HTRANS = NONSEQ;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b1;
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h14;
		tb_HTRANS = SEQ;
		tb_HWDATA = key[127:96];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h18;
		tb_HTRANS = SEQ;
		tb_HWDATA = key[95:64];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h1C;
		tb_HTRANS = SEQ;
		tb_HWDATA = key[63:32];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = '0;
		tb_HTRANS = IDLE;
		tb_HSELx = 1'b0;
		tb_HBURST = '0;
		tb_HWDATA = key[31:0];
		@(posedge tb_HCLK); #0.5ns;
		tb_HWDATA = '0;
	end
	endtask

	task send_key_and1block;
		input [127:0] key;
		input [127:0] dat;
	begin
		@(posedge tb_HCLK); #0.5ns;
		tb_HSELx = 1'b1;
		tb_HADDR = 32'h10;
		tb_HBURST = INCR;
		tb_HTRANS = NONSEQ;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b1;
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h14;
		tb_HTRANS = SEQ;
		tb_HWDATA = key[127:96];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h18;
		tb_HTRANS = SEQ;
		tb_HWDATA = key[95:64];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h1C;
		tb_HTRANS = SEQ;
		tb_HWDATA = key[63:32];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h40;
		tb_HTRANS = NONSEQ;
		tb_HBURST = INCR;
		tb_HWDATA = key[31:0];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h44;
		tb_HTRANS = SEQ;
		tb_HBURST = INCR;
		tb_HWDATA = dat[127:96];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h48;
		tb_HTRANS = SEQ;
		tb_HBURST = INCR;
		tb_HWDATA = dat[95:64];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h4B;
		tb_HTRANS = SEQ;
		tb_HBURST = INCR;
		tb_HWDATA = dat[63:32];
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = '0;
		tb_HTRANS = '0;
		tb_HBURST = '0;
		tb_HWDATA = dat[31:0];
		tb_HSELx = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
		tb_HWDATA = '0;
	end
	endtask

	task send_4blocks;
		input [127:0] dat1;
		input [127:0] dat2;
		input [127:0] dat3;
		input [127:0] dat4;
	begin
		@(posedge tb_HCLK); #0.5ns; tb_HSELx = 1'b1; tb_HADDR = 32'h40;	tb_HTRANS = NONSEQ;tb_HBURST = INCR;
		tb_HWDATA = '0;
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h44;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat1[127:96];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h48;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat1[95:64];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h4C;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat1[63:32];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h50;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat1[31:0];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h54;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat2[127:96];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h58;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat2[95:64];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h5C;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat2[63:32];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h60;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat2[31:0];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h64;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat3[127:96];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h68;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat3[95:64];
		chk_rcv_fifo_out("0987654321234567");
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h6C;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat3[63:32];
		tb_rcv_deq = 1'b1;
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h70;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat3[31:0];
		tb_rcv_deq = 1'b0;
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h74;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat4[127:96];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h78;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat4[95:64];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h7C;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat4[63:32];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = '0;	tb_HTRANS = '0;tb_HBURST = '0;
		tb_HWDATA = dat4[31:0];
		tb_HSELx = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
		tb_HWDATA = '0;
	end
	endtask

	task chk_HREADY;
		input _HREADY;
	begin
		assert(_HREADY == tb_HREADY)
		begin
			$info("Test Case #%0d: Had a correct _HREADY value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect _HREADY value ******************************", tb_test_case_num);
		end
	end
	endtask
	task chk_HRESP;
		input _HRESP;
	begin
		assert(_HRESP == tb_HRESP)
		begin
			$info("Test Case #%0d: Had a correct tb_HRESP value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect tb_HRESP value ******************************", tb_test_case_num);
		end
	end
	endtask
	task chk_is_encrypt_pulse;
		input _is_encrypt_pulse;
	begin
		assert(_is_encrypt_pulse == tb_is_encrypt_pulse)
		begin
			$info("Test Case #%0d: Had a correct _is_encrypt_pulse value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect _is_encrypt_pulse value ******************************", tb_test_case_num);
		end
	end
	endtask
	task chk_is_decrypt_pulse;
		input _is_decrypt_pulse;
	begin
		assert(_is_decrypt_pulse == tb_is_decrypt_pulse)
		begin
			$info("Test Case #%0d: Had a correct _is_decrypt_pulse value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect _is_decrypt_pulse value ******************************", tb_test_case_num);
		end
	end
	endtask
	task deq_data;
	begin
		@(posedge tb_HCLK); #0.5ns;
		tb_rcv_deq = 1'b1;
		@(posedge tb_HCLK); #0.5ns;
		tb_rcv_deq = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
	end
	endtask

	task send_tx_fifo_data;
		input [127:0] data;
	begin
		@(posedge tb_HCLK); #0.5ns;
		tb_data_in = data;		@(posedge tb_HCLK); #0.5ns;tb_HADDR = '0;	tb_HTRANS = '0;tb_HBURST = '0;
		tb_HSELx = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
		tb_HWDATA = '0;
		tb_tx_enq = 1'b1;
		@(posedge tb_HCLK); #0.5ns;
		tb_tx_enq = 1'b0;
	end
	endtask

	task send_error;
	begin
		@(posedge tb_HCLK); #0.5ns;
		tb_HSELx = 1'b1;
		tb_HADDR = 32'h128;
		tb_HBURST = INCR;
		tb_HTRANS = NONSEQ;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b1;
		@(posedge tb_HCLK); #1ns;
		chk_HREADY(0); chk_HRESP(1);
		@(posedge tb_HCLK); #1ns;
		chk_HREADY(1); chk_HRESP(1);
		tb_HSELx = 1'b0;
		tb_HADDR = 32'h128;
		tb_HBURST = INCR;
		tb_HTRANS = NONSEQ;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b1;
		@(posedge tb_HCLK); #1ns;
	end
	endtask

	task get_data1_block;
	begin
		@(posedge tb_HCLK); #0.5ns;
		tb_HSELx = 1'b1;
		tb_HADDR = 32'h80;
		tb_HBURST = INCR;
		tb_HTRANS = NONSEQ;
		tb_HWRITE = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h84;
		tb_HTRANS = SEQ;
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h88;
		tb_HTRANS = SEQ;
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h8C;
		tb_HTRANS = SEQ;
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = '0;
		tb_HTRANS = IDLE;		@(posedge tb_HCLK); #0.5ns;tb_HADDR = '0;	tb_HTRANS = '0;tb_HBURST = '0;
		tb_HSELx = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
		tb_HWDATA = '0;
		tb_HSELx = 1'b0;
		tb_HBURST = '0;
		tb_HWDATA = '0;
		@(posedge tb_HCLK); #1ns;
	end
	endtask


	task select_decrypt;
	begin
		@(posedge tb_HCLK); #1ns;
		tb_HSELx = 1'b1;
		tb_HADDR = 32'h08;
		tb_HBURST = SINGLE;
		tb_HTRANS = NONSEQ;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b1;
		@(posedge tb_HCLK); #0.5ns;
		tb_HWDATA = '0;
		tb_HBURST = SINGLE;
		tb_HTRANS = IDLE;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b0;
	end
	endtask

	task select_encrypt;
	begin
		@(posedge tb_HCLK); #1ns;
		tb_HSELx = 1'b1;
		tb_HADDR = 32'h04;
		tb_HBURST = SINGLE;
		tb_HTRANS = NONSEQ;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b1;
		@(posedge tb_HCLK); #1ns;
		tb_HSELx = 1'b0;
		tb_HADDR = 32'h0;
		tb_HBURST = SINGLE;
		tb_HTRANS = IDLE;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b0;
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
		@(posedge tb_HCLK); #0.5ns;
		tb_tx_enq = 1'b1;
		tb_data_in = data;
		@(posedge tb_HCLK); #0.5ns;
		tb_data_in = data2;
		@(posedge tb_HCLK); #0.5ns;
		tb_data_in = data3;
		@(posedge tb_HCLK); #0.5ns;
		tb_data_in = data4;
		@(posedge tb_HCLK); #0.5ns;
		tb_data_in = data5;
		@(posedge tb_HCLK); #0.5ns;
		tb_data_in = data6;
		@(posedge tb_HCLK); #0.5ns;
		tb_tx_enq = 1'b0;
		@(posedge tb_HCLK); #0.5ns;

	end
	endtask
	integer i;

	task get_data6_block;
	begin
		@(posedge tb_HCLK); #0.5ns;
		tb_HSELx = 1'b1;
		tb_HADDR = 32'h80;
		tb_HBURST = INCR;
		tb_HTRANS = NONSEQ;
		tb_HWRITE = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = 32'h84;
		tb_HTRANS = SEQ;
		for (i = 32'h88; i < 32'hE0; i = i + 4) begin
			@(posedge tb_HCLK); #0.5ns;
			tb_HADDR = i;
		end
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = '0;
		tb_HTRANS = IDLE;
		tb_HSELx = 1'b0;
		tb_HBURST = '0;
		tb_HWDATA = '0;
		@(posedge tb_HCLK); #1ns;
	end
	endtask

	task get_status;
	begin
		@(posedge tb_HCLK); #0.5ns;
		tb_HSELx = 1'b1;
		tb_HADDR = 32'h00;
		tb_HBURST = SINGLE;
		tb_HTRANS = NONSEQ;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b0;
		@(posedge tb_HCLK); #1ns;
		tb_HSELx = 1'b0;
		tb_HADDR = 32'h0;
		tb_HBURST = SINGLE;
		tb_HTRANS = IDLE;
		tb_HWDATA = '0;
		tb_HWRITE = 1'b0;
	end
	endtask

	initial begin
		tb_test_case_num = 0;
		tb_HSELx = '0;
		tb_HADDR = '0;
		tb_HBURST = SINGLE;
		tb_HTRANS = IDLE;
		tb_HWDATA = '0;
		tb_HWRITE = '0;
		tb_HPROT = '0;
		tb_HSIZE = 2;
		tb_status = 4'b0100;
		tb_status = '0;
		tb_data_in = '0;
		tb_tx_enq = '0;
		tb_rcv_deq = '0;
		tb_fix_error = '0;
		// TEST 0 : TEST AFTER RESET
		reset_dut();
		chk_rcv_tx_empty_full(1,0,1,0);
		tb_test_case_num = tb_test_case_num + 1;
		// TEST 1 : TEST AFTER SENDING A KEY
		send_key("ZXCVBNMASDFGHJKL");
		tb_status = 4'b1100;
		@(posedge tb_HCLK); @(posedge tb_HCLK); #1ns;
		chk_rcv_fifo_out("ZXCVBNMASDFGHJKL");
		tb_test_case_num = tb_test_case_num + 1;
		// TEST 2 : TEST AFTER DEQUEINING
		deq_data();
		chk_rcv_tx_empty_full(1,0,1,0);
		tb_test_case_num = tb_test_case_num + 1;
		// TEST 3 : TEST AFTER SENDING KEY AND DATA
		send_key_and1block("zxcvbnmasdfghjkl","1234567890123456");
		chk_rcv_fifo_out("zxcvbnmasdfghjkl");
		deq_data();
		@(posedge tb_HCLK); #1ns;
		chk_rcv_fifo_out("1234567890123456");
		deq_data();
		#0.5ns;
		chk_rcv_tx_empty_full(1,0,1,0);
		tb_test_case_num = tb_test_case_num + 1;
		// TEST 4 : BURST SEND ALL 4 BLOCKS
		send_4blocks("0987654321234567",",./;[]\=-_+)(*&^","MNBVCXZLKJHGFDSA","poiuytrewqasdfgh");
		chk_rcv_fifo_out(",./;[]\=-_+)(*&^");
		deq_data();
		@(posedge tb_HCLK); #1ns;
		chk_rcv_fifo_out("MNBVCXZLKJHGFDSA");
		deq_data();
		@(posedge tb_HCLK); #1ns;
		chk_rcv_fifo_out("poiuytrewqasdfgh");
		deq_data();
		@(posedge tb_HCLK); #1ns;
		chk_rcv_tx_empty_full(1,0,1,0);
		tb_test_case_num = tb_test_case_num + 1;
		// TEST 5 : read data
		send_tx_fifo_data("1234567891234567");
		get_data1_block();
		tb_test_case_num = tb_test_case_num + 1;

		// TEST 6 : test send error
		send_error();		
		tb_test_case_num = tb_test_case_num + 1;

		// TEST 7 : TEST SELECT DECRYPT
		select_decrypt();
		#0.5ns;
		chk_is_decrypt_pulse(1);
		tb_test_case_num = tb_test_case_num + 1;
		// TEST 8 : TEST SELECT ENCRYPT
		select_encrypt();
		#0.5ns;
		chk_is_encrypt_pulse(1);
		tb_test_case_num = tb_test_case_num + 1;
		// TEST 9 : FILL THE TX FIFO
		send_burst_all("0123456789ABCDEF", "zxcvbnmasdfghqwe", "ZXCVBNMASDFGHJKL", "poiuytrewqasdfgh","~!@#$%^&*()_+?><","!@#$%^&*&^%$#@!~");
		get_data6_block();
		tb_test_case_num = tb_test_case_num + 1;

		// TEST 10 : GET THE STATUS
		tb_status = 4'h41;
		get_status();
//		chk_HRDATA(4'b1);

		// TEST 11 : TEST AFTER RESET and test for error when sending block
		tb_status = 4'b0100;
		reset_dut();
		@(posedge tb_HCLK); #0.5ns; tb_HSELx = 1'b1; tb_HADDR = 32'h40;	tb_HTRANS = NONSEQ;tb_HBURST = INCR;
		tb_HWDATA = '0;
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = '0;	tb_HTRANS = '0;tb_HBURST = '0;
		tb_HSELx = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
		tb_HWDATA = '0;

	end
endmodule
