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
   reg 	   tb_clk;
   reg	   tb_n_rst;
   reg [127:0] tb_i_data;
   reg 	   tb_read_fifo;
   reg 	   tb_is_full;
   reg [127:0] tb_round_key_input;
   reg [127:0]	tb_round_key_0;
   reg [4:0]	tb_round_key_addr;

   //output
   reg [127:0] 	tb_o_data;
   reg		tb_data_done;
   reg		tb_data_valid;

   //expected output
   reg [127:0]		     tbe_o_data;
   reg 			     tbe_data_done;
   reg 			     tbe_data_valid;
   
   //test bench vars
   integer 	     i;
   integer tb_test_case_num;
   integer tb_test_sample_num;

   //data file vars
   integer enc_file;
   integer key_file;
   integer scan_file;
   logic signed [127:0] captured_data_A;
   logic signed [127:0] captured_data_B;
   reg [127:0] tb_round_key_vector[10];
   reg [127:0] 	       tb_i_data_vector[NUMBER_OF_TESTS];
   reg [127:0] 	       tbe_o_data_vector[NUMBER_OF_TESTS];
   reg [31:0] 	       enc_counter;
   reg [31:0] 	       key_counter;

   aes_encryption AES_ENCRYPTION (.clk(tb_clk), .n_rst(tb_n_rst),.read_fifo(tb_read_fifo),.is_full(tb_is_full),.fifo_in(tb_i_data), .round_key_input(tb_round_key_input), .round_key_0(tb_round_key_0), .round_key_addr(tb_round_key_addr), .data_output(tb_o_data), .data_done(tb_data_done), .data_valid(tb_data_valid));

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
	 key_file = $fopen("./AES python implementation/round_keys.bin","rb");
	 if(key_file == 0)begin
	    $display("key_file handle was NULL.");
	    $finish;
	 end
      end
   endtask

   initial
     begin
	$display("INIT");
	enc_counter = 0;
	key_counter = 0;
	tb_test_case_num = 0;
	tb_test_sample_num = 0;
	tb_n_rst = 1;
	tb_read_fifo = 1;
	tb_is_full = 0;

	#(1ns);
	$display("PRE");
	load_file;
	$display("HERE");
	
	#(1000*CLK_PERIOD);
	for(i = 0;i<enc_counter;i=i+1)
	  begin
	     tb_i_data = tb_i_data_vector[i];
	     tbe_o_data = tbe_o_data_vector[i];
	     //$info("TBE: %b",tbe_o_data);
	     while(!tb_data_done)
	       begin
	       end
	     check_output;
	     tb_test_sample_num = tb_test_sample_num + 1;
	  end
     end

   always@(posedge tb_clk) begin
      if (!$feof(enc_file)) begin
	 scan_file = $fread(captured_data_A,enc_file);
	 scan_file = $fread(captured_data_B,enc_file);
	 tb_i_data_vector[enc_counter] <= captured_data_A;
	 tbe_o_data_vector[enc_counter] <= captured_data_B;
	 enc_counter <= enc_counter + 1;
	 //$info("enc_counter: %0d",enc_counter);
      end
      if (!$feof(key_file)) begin
	 scan_file = $fread(captured_data_A,key_file);
	 if (key_counter == 0)
	   tb_round_key_0 <= captured_data_A;
	 else
	   tb_round_key_vector[key_counter-1] <= captured_data_A;
	 key_counter <= key_counter + 1;
	 //$info("key_counter: %0h",captured_data_A);
      end
   end
   
   always@(posedge tb_clk,negedge tb_n_rst)begin
      if(tb_n_rst)
	tb_round_key_input <= tb_round_key_vector[0];
      else
	tb_round_key_input <= tb_round_key_vector[tb_round_key_addr[3:0]];
      $info("round key addr: %0b",tb_round_key_addr[3:0]);
   end

endmodule
