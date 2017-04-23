// $Id: $
// File name:   tb_aes_block.sv
// Created:     4/15/2017
// Author:      Kent Gauen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Test bench for top level module aes_encryption/
`timescale 1ns / 10ps
module tb_aes_encryption();
   parameter CLK_PERIOD				= 4;
   parameter NUMBER_OF_TESTS = 500;
   // -=-=-=-=- MIX COLUMNS -=-=-=-=-

   //input
   reg [127:0]	     tb_i_data;

   //output
   reg [127:0] 	     tb_o_data;

   //expected output
   reg [127:0]		     tbe_o_data;
   


   //test bench vars
   integer 	     i;
   integer tb_test_case_num;
   integer tb_test_sample_num;
   reg 	   tb_clk;
   reg	   tb_n_rst;

   reg [127:0]	tb_round_key_input;
   reg [127:0]	tb_round_key_0;
   reg [4:0]	tb_round_key_addr;
   reg		tb_data_done;
   reg		tb_data_valid;

   //data file vars
   integer enc_file;
   integer key_file;
   integer scan_file;
   logic signed [127:0] captured_data_input;
   logic signed [127:0] captured_data_output;
   reg [127:0] 	       tb_i_data_vector[NUMBER_OF_TESTS];
   reg [127:0] 	       tbe_o_data_vector[NUMBER_OF_TESTS];
   reg [31:0] 	       test_counter;

   aes_encryption AES_ENCRYPTION (.clk(tb_clk), .n_rst(tb_n_rst), .fifo_in(tb_i_data), .round_key_input(tb_round_key_input), .round_key_0(tb_round_key_0), .round_key_addr(tb_round_key_addr), .data_output(tb_o_data), .data_done(tb_data_done), .data_valid(tb_data_valid));

   always
     begin : CLK_GEN
	tb_clk = 0;
	#(CLK_PERIOD / 2.0);
	tb_clk = 1;
	#(CLK_PERIOD / 2.0);
     end

   task check_output;
     begin
	 if(tbe_o_data == tb_o_data)
	   $info("Test Case #%0d Sample #%0d: correct_output", tb_test_case_num, tb_test_sample_num);
	 else
	   begin
	      $error("Test Case #%0d Sample #%0d: INCORRECT OUTPUT", tb_test_case_num, tb_test_sample_num);
	      //$info("should be: %b, but is: %b",tbe_o_data,tb_o_data);
	      $info("input: %h",tb_i_data);
	      $info("should be: %h, but is: %h",tbe_o_data,tb_o_data);
	   end
     end
   endtask

   task load_file;
      string filename;
      begin
	 enc_file = $fopen("./AES python implementation/encryptTest.txt","rb");
	 if(enc_file == 0)begin
	    $display("enc_file handle was NULL.");
	    $finish;
	 end
	 key_file = $fopen("./AES python implementation/round_key.bin","rb");
	 if(key_file == 0)begin
	    $display("key_file handle was NULL.");
	    $finish;
	 end
      end
   endtask

   initial
     begin
	test_counter = 0;
	tb_test_case_num = 0;
	tb_test_sample_num = 0;
	tb_n_rst = 1;
	tb_read_fifo = 1;
	tb_is_full = 0;
	#(1ns);
	load_file;
	#(100000*CLK_PERIOD);
	for(i = 0;i<test_counter;i=i+1)
	  begin
	     tb_i_data = tb_i_data_vector[i];
	     tbe_o_data = tbe_o_data_vector[i];
	     //$info("TBE: %b",tbe_o_data);
	     #(1ns);
	     check_output;
	     tb_test_sample_num = tb_test_sample_num + 1;
	  end
     end

   always@(posedge tb_clk) begin
      if (!$feof(enc_file)) begin
	 scan_file = $fread(captured_data_input,enc_file);
	 scan_file = $fread(captured_data_output,enc_file);
	 tb_i_data_vector[test_counter] <= captured_data_input;
	 tbe_o_data_vector[test_counter] <= captured_data_output;
	 test_counter <= test_counter + 1;
      end
   end
   

endmodule