// $Id: $
// File name:   tb_AES_toplevel.sv
// Created:     4/23/2017
// Author:      Deeptanshu Malik
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Top level test bench.

`timescale 1ns / 10ps

module tb_AES_toplevel();
parameter INPUT_READY = 1;
parameter DATA_DONE  = 2;
parameter ENCRYPT_NOT_DECRYPT = 4;
parameter KEY_GEN_DONE  = 8;
parameter CLK_PERIOD				= 5;
parameter NUMBER_OF_TESTS = 500;

typedef enum bit [3:0] {SINGLE, INCR} burstType;
typedef enum bit [1:0] {IDLE, BUZ, NONSEQ, SEQ} htransType;

integer tb_test_case_num;

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
reg [3:0][127:0] tb_data_rcv;

//data file vars
integer data_file_raw, data_file_to_write_encrypt, data_file_to_write_decrypt, data_file_expected;
integer scan_file;
logic signed [127:0] captured_data_A;
logic signed [127:0] captured_data_B;
reg [127:0] 	       tb_i_data_vector[NUMBER_OF_TESTS];
reg [127:0] 	       tbe_o_data_vector[NUMBER_OF_TESTS];
reg [31:0] 	       test_counter;
reg [31:0] tmp_status;

//output
reg [127:0] 	     tb_o_data;

//expected output
reg [127:0]		     tbe_o_data;

// DUT portmap
AES_toplevel DUT
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
		tb_HWDATA = '0;tb_HWRITE = 1'b1;
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
		tb_HWDATA = '0;tb_HWRITE = 1'b0;
	end
endtask

task send_1block;
	input [127:0] dat1;
	begin
		@(posedge tb_HCLK); #0.5ns; tb_HSELx = 1'b1; tb_HADDR = 32'h40;	tb_HTRANS = NONSEQ;tb_HBURST = INCR;
		tb_HWDATA = '0;tb_HWRITE = 1'b1;
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h44;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat1[127:96];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h48;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat1[95:64];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = 32'h4C;	tb_HTRANS = SEQ;tb_HBURST = INCR;
		tb_HWDATA = dat1[63:32];
		@(posedge tb_HCLK); #0.5ns;tb_HADDR = '0;	tb_HTRANS = '0;tb_HBURST = '0;
		tb_HWDATA = dat1[31:0];
		tb_HSELx = 1'b0;
		@(posedge tb_HCLK); #0.5ns;
		tb_HWDATA = '0;tb_HWRITE = 1'b0;
	end
endtask

task get_data4_block;
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
		tb_out_data[0] = tb_HRDATA;
		for (i = 32'h88, j = 1; i < 32'hC0; i = i + 4, j = j + 1) begin
			@(posedge tb_HCLK); #0.5ns;
			tb_HADDR = i;
			#2ns;
			tb_out_data[j] = tb_HRDATA;
		end
		@(posedge tb_HCLK); #0.5ns;
		tb_HADDR = '0;
		tb_HTRANS = IDLE;
		tb_HSELx = 1'b0;
		tb_HBURST = '0;
		tb_HWDATA = '0;
		#2ns;
		tb_out_data[15] = tb_HRDATA;
		@(posedge tb_HCLK); #1ns;
	end
endtask

task get_data1_block;
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
		tb_out_data[0] = tb_HRDATA;
		for (i = 32'h88, j = 1; i < 32'h90; i = i + 4, j = j + 1) begin
			@(posedge tb_HCLK); #0.5ns;
			tb_HADDR = i;
			#2ns;
			tb_out_data[j] = tb_HRDATA;
//			@(posedge tb_HCLK); #0.5ns;
//			tb_out_data[j] = tb_HRDATA;
//			tb_HADDR = i;
		end
		@(posedge tb_HCLK); #0.5ns;
		tb_out_data[3] = tb_HRDATA;
		tb_HADDR = '0;
		tb_HTRANS = IDLE;
		tb_HSELx = 1'b0;
		tb_HBURST = '0;
		tb_HWDATA = '0;
		#2ns;
		tb_out_data[j] = tb_HRDATA;
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
		tmp_status = tb_HRDATA;
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

task load_file_to_read;
      string filename;
      begin
	 data_file_raw = $fopen("./AES python implementation/BeforeEncryptTest.txt","rb");
	 data_file_expected = $fopen("./AES python implementation/AfterEncryptTest.txt","rb");
	 if(data_file_raw == 0 || data_file_expected == 0)begin
	    $display("data_file handle was NULL.");
	    $finish;
	 end
      end
endtask

//MARK: not tested
task load_file_to_write;
      string filename;
      begin
	 data_file_to_write_encrypt = $fopen("./AES python implementation/output_encrypt.txt","wb");
	 data_file_to_write_decrypt = $fopen("./AES python implementation/output_decrypt.txt","wb");
	 if(data_file_to_write_encrypt == 0 || data_file_to_write_decrypt == 0) begin
	    $display("data_file handle was NULL.");
	    $finish;
	 end
      end
endtask

task check_output;
    begin
	 if(tbe_o_data == tb_o_data)
	   $info("Test Case #%0d Sample #%0d: correct_output", tb_test_case_num, tb_test_case_num);
	 else
	   begin
	      $error("Test Case #%0d Sample #%0d: INCORRECT OUTPUT", tb_test_case_num, tb_test_case_num);
	      //$info("should be: %b, but is: %b",tbe_o_data,tb_o_data);
	      //$info("input: %h",tb_i_data);
	      $info("should be: %h, but is: %h",tbe_o_data,tb_o_data);
	   end
     end
   endtask

integer input_idx;

task send_4blocks_from_file_encrypt;
      begin
           send_4blocks(tb_i_data_vector[input_idx],tb_i_data_vector[input_idx+1],tb_i_data_vector[input_idx+2],tb_i_data_vector[input_idx+3]);	
           input_idx = input_idx + 4;
      end
endtask

task send_4blocks_from_file_decrypt;
      begin
           send_4blocks(tbe_o_data_vector[input_idx],tbe_o_data_vector[input_idx+1],tbe_o_data_vector[input_idx+2],tbe_o_data_vector[input_idx+3]);	
           input_idx = input_idx + 4;
      end
endtask

task send_1block_from_file_encrypt;
	begin
	send_1block(tb_i_data_vector[input_idx]);
        input_idx = input_idx + 1;
	end
endtask

task send_1block_from_file_decrypt;
	begin
	send_1block(tbe_o_data_vector[input_idx]);
        input_idx = input_idx + 1;
	end
endtask

//MARK: not tested
task write_4blocks_to_file_encrypt;
     	integer i, j;
	reg [7:0] tmp;
      begin
	//$fseek(data_file, 0, `SEEK_END);
	for (i = 0; i < 16; i=i+1) begin
		if (i % 4 == 0)
			tb_data_rcv[3 - i / 4] = {tb_out_data[i],tb_out_data[i+1],tb_out_data[i+2],tb_out_data[i+3]};
		tmp = tb_out_data[i][31:24];
		tb_out_data[i][31:24] = tb_out_data[i][7:0];
		tb_out_data[i][7:0] = tmp;
	
		tmp = tb_out_data[i][23:16];
		tb_out_data[i][23:16] = tb_out_data[i][15:8];
		tb_out_data[i][15:8] = tmp;		

		$fwrite(data_file_to_write_encrypt,"%u",tb_out_data[i]);
//		for(j = 31; j >= 0; j = j - 8) begin
//    			$fwrite(data_file_to_write,"%c",tb_out_data[i][j -: 7]);
//		end
	end
      end
endtask

task write_4blocks_to_file_decrypt;
     	integer i, j;
	reg [7:0] tmp;
      begin
	//$fseek(data_file, 0, `SEEK_END);
	for (i = 0; i < 16; i=i+1) begin
		if (i % 4 == 0)
			tb_data_rcv[3 - i / 4] = {tb_out_data[i],tb_out_data[i+1],tb_out_data[i+2],tb_out_data[i+3]};
		tmp = tb_out_data[i][31:24];
		tb_out_data[i][31:24] = tb_out_data[i][7:0];
		tb_out_data[i][7:0] = tmp;
	
		tmp = tb_out_data[i][23:16];
		tb_out_data[i][23:16] = tb_out_data[i][15:8];
		tb_out_data[i][15:8] = tmp;

		$fwrite(data_file_to_write_decrypt,"%u",tb_out_data[i]);
//		for(j = 31; j >= 0; j = j - 8) begin
//    			$fwrite(data_file_to_write,"%c",tb_out_data[i][j -: 7]);
//		end
	end
      end
endtask

task write_1block_to_file_encrypt;
     	integer i, j;
	reg [7:0] tmp;
      begin
	for (i = 0; i < 4; i=i+1) begin
		if (i % 4 == 0)
			tb_data_rcv[3] = {tb_out_data[i],tb_out_data[i+1],tb_out_data[i+2],tb_out_data[i+3]};
		tmp = tb_out_data[i][31:24];
		tb_out_data[i][31:24] = tb_out_data[i][7:0];
		tb_out_data[i][7:0] = tmp;
	
		tmp = tb_out_data[i][23:16];
		tb_out_data[i][23:16] = tb_out_data[i][15:8];
		tb_out_data[i][15:8] = tmp;

		$fwrite(data_file_to_write_encrypt,"%u",tb_out_data[i]);
	end
      end
endtask

task write_1block_to_file_decrypt;
     	integer i, j;
	reg [7:0] tmp;
      begin
	for (i = 0; i < 4; i=i+1) begin
		if (i % 4 == 0)
			tb_data_rcv[3] = {tb_out_data[i],tb_out_data[i+1],tb_out_data[i+2],tb_out_data[i+3]};
		tmp = tb_out_data[i][31:24];
		tb_out_data[i][31:24] = tb_out_data[i][7:0];
		tb_out_data[i][7:0] = tmp;
	
		tmp = tb_out_data[i][23:16];
		tb_out_data[i][23:16] = tb_out_data[i][15:8];
		tb_out_data[i][15:8] = tmp;

		$fwrite(data_file_to_write_decrypt,"%u",tb_out_data[i]);
	end
      end
endtask

task wait_key_gen;
	integer z;
	begin
		get_status;
		while (tmp_status[3] == 0) begin
			get_status;
		end
	end
endtask

task wait_output_done;
	integer z;
	begin
		get_status;
		while (tmp_status[1] == 0) begin
			get_status;
		end
	end
endtask

task chk_4data_blocks_encrypt;
	begin
		assert(tbe_o_data_vector[input_idx-4] == {tb_out_data[0],tb_out_data[1],tb_out_data[2],tb_out_data[3]})
		begin
			$info("Test Case #%0d, index #%0d: Had a correct HRDATA ENCRYPTION value", tb_test_case_num, input_idx);
		end else begin
			$error("Test Case #%0d, index #%0d: Had an incorrect HRDATA ENCRYPTION value ******************************", tb_test_case_num, input_idx);
		end
		assert(tbe_o_data_vector[input_idx-3] == {tb_out_data[4],tb_out_data[5],tb_out_data[6],tb_out_data[7]})
		begin
			$info("Test Case #%0d, index #%0d: Had a correct HRDATA ENCRYPTION value", tb_test_case_num, input_idx);
		end else begin
			$error("Test Case #%0d, index #%0d: Had an incorrect HRDATA ENCRYPTION value ******************************", tb_test_case_num, input_idx);
		end
		assert(tbe_o_data_vector[input_idx-2] == {tb_out_data[8],tb_out_data[9],tb_out_data[10],tb_out_data[11]})
		begin
			$info("Test Case #%0d, index #%0d: Had a correct HRDATA ENCRYPTION value", tb_test_case_num, input_idx);
		end else begin
			$error("Test Case #%0d, index #%0d: Had an incorrect HRDATA ENCRYPTION value ******************************", tb_test_case_num, input_idx);
		end
		assert(tbe_o_data_vector[input_idx-1] == {tb_out_data[12],tb_out_data[13],tb_out_data[14],tb_out_data[15]})
		begin
			$info("Test Case #%0d, index #%0d: Had a correct HRDATA ENCRYPTION value", tb_test_case_num, input_idx);
		end else begin
			$error("Test Case #%0d, index #%0d: Had an incorrect HRDATA ENCRYPTION value ******************************", tb_test_case_num, input_idx);
		end
	end
endtask


task chk_4data_blocks_decrypt;
	begin
		assert(tb_i_data_vector[input_idx-4] == {tb_out_data[0],tb_out_data[1],tb_out_data[2],tb_out_data[3]})
		begin
			$info("Test Case #%0d, index #%0d: Had a correct HRDATA DECRYPTION value", tb_test_case_num, input_idx);
		end else begin
			$error("Test Case #%0d, index #%0d: Had an incorrect HRDATA DECRYPTION value ******************************", tb_test_case_num, input_idx);
		end
		assert(tb_i_data_vector[input_idx-3] == {tb_out_data[4],tb_out_data[5],tb_out_data[6],tb_out_data[7]})
		begin
			$info("Test Case #%0d, index #%0d: Had a correct HRDATA DECRYPTIONt value", tb_test_case_num, input_idx);
		end else begin
			$error("Test Case #%0d, index #%0d: Had an incorrect HRDATA DECRYPTION value ******************************", tb_test_case_num, input_idx);
		end
		assert(tb_i_data_vector[input_idx-2] == {tb_out_data[8],tb_out_data[9],tb_out_data[10],tb_out_data[11]})
		begin
			$info("Test Case #%0d, index #%0d: Had a correct HRDATA DECRYPTION value", tb_test_case_num, input_idx);
		end else begin
			$error("Test Case #%0d, index #%0d: Had an incorrect HRDATA DECRYPTION value ******************************", tb_test_case_num, input_idx);
		end
		assert(tb_i_data_vector[input_idx-1] == {tb_out_data[12],tb_out_data[13],tb_out_data[14],tb_out_data[15]})
		begin
			$info("Test Case #%0d, index #%0d: Had a correct HRDATA DECRYPTION value", tb_test_case_num, input_idx);
		end else begin
			$error("Test Case #%0d, index #%0d: Had an incorrect HRDATA DECRYPTION value ******************************", tb_test_case_num, input_idx);
		end
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
	input [1:0] _HRESP;
	begin
		assert(_HRESP == tb_HRESP)
		begin
			$info("Test Case #%0d: Had a correct tb_HRESP value", tb_test_case_num);
		end else begin
			$error("Test Case #%0d: Had an incorrect tb_HRESP %d value ******************************", tb_test_case_num, tb_HRESP);
		end
	end
endtask

task send_initial_data;
	begin
		@(posedge tb_HCLK); #0.5ns; tb_HSELx = 1'b1; tb_HADDR = 32'h40;	tb_HTRANS = NONSEQ;tb_HBURST = INCR; tb_HWDATA = '0;
		@(posedge tb_HCLK); #0.5ns; tb_HADDR = 32'h44; tb_HTRANS = NONSEQ;tb_HBURST = INCR; tb_HSELx = 1'b1; tb_HWDATA = tb_i_data_vector[3];
		#1.5ns;chk_HREADY(0);chk_HRESP(1);
		@(posedge tb_HCLK); #0.5ns; tb_HADDR = '0; tb_HTRANS = '0;tb_HBURST = '0; tb_HSELx = 1'b0;tb_HWDATA = '0;
		#1.5ns;chk_HREADY(1);chk_HRESP(1);
		@(posedge tb_HCLK); #1.5ns;
		chk_HREADY(1);chk_HRESP(0);
	end
endtask

integer cnt;
initial begin
		tb_HRESETn = '0;
		input_idx = 0;
		tb_test_case_num = 0;
		tb_HSELx = '0;
		tb_HADDR = '0;
		tb_HBURST = SINGLE;
		tb_HTRANS = IDLE;
		tb_HWDATA = '0;
		tb_HWRITE = '0;
		tb_HPROT = '0;
		tb_HSIZE = 2;
		cnt = 0;
		test_counter = 0;
		tb_out_data = '0;
		#(1ns);
		load_file_to_read;
		load_file_to_write;
		#(2000ns);
		// TEST 0 : TEST AFTER RESET
		reset_dut();
		tb_test_case_num = tb_test_case_num + 1;
		
		// TEST 1 : TRY SENDING DATA FOR ENCRYPTION
		send_initial_data;
		input_idx = 0;

		tb_test_case_num = tb_test_case_num + 1;
		
		// TEST 2 : TEST AFTER SENDING KEY AND DATA BLOCKS FOR ENCRYPTION
		send_key("thisisthekey0000");
		wait_key_gen;
		while (cnt < test_counter - 4) begin
			send_4blocks_from_file_encrypt;
			wait_output_done;
			get_data4_block;
			chk_4data_blocks_encrypt;
			write_4blocks_to_file_encrypt;
			cnt = cnt + 4;
		end 

		while (cnt < test_counter - 1) begin // take care when data % 4 != 0
			send_1block_from_file_encrypt;
			wait_output_done;
			get_data1_block;
			write_1block_to_file_encrypt;
			cnt = cnt + 1;
		end 

		// TEST 3 : TEST AFTER SENDING KEY AND DATA BLOCKS FOR DECRYPTION 
		
		select_decrypt;
		input_idx = 0;
		cnt = 0;
		while (cnt < test_counter - 4) begin
			send_4blocks_from_file_decrypt;
			wait_output_done;
			get_data4_block;
			chk_4data_blocks_decrypt;
			write_4blocks_to_file_decrypt;
			cnt = cnt + 4;
		end 
		while (cnt < test_counter - 1) begin // take care when data % 4 != 0
			send_1block_from_file_decrypt;
			wait_output_done;
			get_data1_block;
			write_1block_to_file_decrypt;
			cnt = cnt + 1;
		end 
	end

always@(posedge tb_HCLK) begin
      if (!$feof(data_file_raw)) begin
	 scan_file = $fread(captured_data_A,data_file_raw);
	 scan_file = $fread(captured_data_B,data_file_expected);
	 tb_i_data_vector[test_counter] <= captured_data_A;
	 tbe_o_data_vector[test_counter] <= captured_data_B;
	 test_counter <= test_counter + 1;
      end
   end

endmodule
