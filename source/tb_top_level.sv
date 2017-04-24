// $Id: $
// File name:   tb_top_level.sv
// Created:     4/23/2017
// Author:      Deeptanshu Malik
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Top level test bench.

`timescale 1ns / 10ps
module tb_top_level();

//gameplan is to follow flowchart for top level design

/*
1. Send data from master

2. Demonstrate that ahb is functioning - DrJ said so

3. Encrypt/Decrypt data from fifo - multiple examples of this
*/
parameter CLK_PERIOD				= 5;

typedef enum bit [3:0] {SINGLE, INCR} burstType;
typedef enum bit [1:0] {IDLE, BUZ, NONSEQ, SEQ} htransType;

integer tb_test_case_num;
//integer i;
//integer j;

//  DUT inputs and outputs
reg          tb_HCLK;
reg          tb_HRESETn;
reg          tb_HSELx;
reg  [31:0]  tb_HADDR;
reg  [31:0]  tb_HWDATA;
reg  [ 2:0]  tb_HBURST;
reg  [ 3:0]  tb_HPROT;
reg  [ 2:0]  tb_HSIZE;
reg  [ 1:0]  tb_HTRANS;
reg          tb_HWRITE;
reg  [31:0]   tb_HRDATA;
reg          tb_HREADY;
reg [ 1:0]   tb_HRESP;

reg [15:0][31:0] tb_out_data;

// DUT portmap
theWrapperFile DUT
(
	.HCLK(tb_HCLK),
	.HRESETn(tb_HRESETn),
	.HSELx(tb_HSELx),
	.HADDR(tb_HADDR),
	.HWDATA(tb_HWDATA),
	.HBURST(tb_HBURST),
	.HPROT(tb_HPROT),
	.HSIZE(tb_HSIZE),
	.HTRANS(tb_HTRANS),
	.HWRITE(tb_HWRITE),
	.HRDATA(tb_HRDATA),
	.HREADY(tb_HREADY),
	.HRESP(tb_HRESP)
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
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h6C;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat3[63:32];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h70;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat3[31:0];
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



task get_data4_block;
	output [15:0][31:0] output_arr;
	integer i, j;
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
		for (i = 32'h88, j = 0; i < 32'hC0; i = i + 4, j = j + 1) begin
			@(posedge tb_HCLK); #0.5ns;
			output_arr[j] = tb_HRDATA;
			tb_HADDR = i;
		end
		@(posedge tb_HCLK); #0.5ns;
		output_arr[15] = tb_HRDATA;
		tb_HADDR = '0;
		tb_HTRANS = IDLE;
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
		@(posedge tb_HCLK); #1ns;
		tb_HSELx = 1'b0;
		tb_HADDR = 32'h0;
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

		// TEST 0 : TEST AFTER RESET
		reset_dut();
		tb_test_case_num = tb_test_case_num + 1;
		
		// TEST 1 : TEST AFTER SENDING A KEY
		send_key("ZXCVBNMASDFGHJKL");
		@(posedge tb_HCLK); @(posedge tb_HCLK); #1ns;
		tb_test_case_num = tb_test_case_num + 1;
		
		// TEST 2 : TEST AFTER SENDING KEY AND DATA
		reset_dut();
		send_key("ZXCVBNMASDFGHJKL");
		send_4blocks("1234567890123456","1234567890123456","1234567890123456","1234567890123456");
		@(posedge tb_HCLK); #1ns;
		#0.5ns;

		// TEST 3 : TEST AFTER SENDING KEY AND DATA AND THEN GETTING DATA
		reset_dut();
		send_key("ZXCVBNMASDFGHJKL");
		send_4blocks("1234567890123456","1234567890123456","1234567890123456","1234567890123456");
		get_data4_block(tb_out_data);
		@(posedge tb_HCLK); #1ns;
		#0.5ns;
	end
endmodule
