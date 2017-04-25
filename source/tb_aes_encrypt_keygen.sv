// $Id: $
// File name:   tb_aes_block.sv
// Created:     4/15/2017
// Author:      Kent Gauen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Test bench for top level module aes_encryption/
`timescale 1ns / 10ps
module tb_aes_encrypt_keygen();
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
   reg [3:0]	tb_round_key_addr;

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

   //Key generation vars
   reg [127:0] tb_input_key;
   reg tb_WE_key_generation;

   aes_encryption AES_ENCRYPTION (.clk(tb_clk), .n_rst(tb_n_rst),.read_fifo(tb_read_fifo),.is_full(tb_is_full),.fifo_in(tb_i_data), .round_key_input(tb_round_key_input), .round_key_0(tb_round_key_0), .round_key_addr(tb_round_key_addr), .data_output(tb_o_data), .data_done(tb_data_done), .data_valid(tb_data_valid));

   key_generator KEY_GEN (.clk(tb_clk), .n_rst(tb_n_rst), .read_addr(tb_round_key_addr), .WE_key_generation(tb_WE_key_generation), .input_key(tb_input_key), .round_key_0(tb_round_key_0), .round_key_x(round_key_input));

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
	//key generator
	tb_input_key = 128'b01111001011000010111100101100010011011110110100101101100011001010111001001101101011000010110101101100101011100100111001100100001; 

	enc_counter = 0;
	key_counter = 0;
	tb_test_case_num = 0;
	tb_test_sample_num = 0;
	tb_n_rst = 1;

	#(1ns);
	load_file;

	#(1ns);	
	tb_n_rst = 0;
	#(1ns);	
	tb_n_rst = 1;
	tb_read_fifo = 0;
	tb_is_full = 0;
	@(negedge tb_clk);
	tb_WE_key_generation = 1;
	@(negedge tb_clk);
	tb_WE_key_generation = 0;
	@(negedge tb_clk);
	
	#(100*CLK_PERIOD);
	$info("-----------------------------------============================-------------------------\n");
	$info("-----------------------------------============================-------------------------\n");
	$info("-----------------------------------============================-------------------------\n");
	$info("-----------------------------------============================-------------------------\n");
	$info("enc_counter: %0d",enc_counter);
	
	//single test
	tb_i_data = tb_i_data_vector[0];
	tbe_o_data = tbe_o_data_vector[0];
	$info("tb_i_data: %0h",tb_i_data);
	@(negedge tb_clk);
	tb_read_fifo = 1;
	@(negedge tb_clk);
	tb_read_fifo = 0;
	//$info("TBE: %b",tbe_o_data);
	while(!tb_data_done)
	  begin
	     @(negedge tb_clk);
	  end
	check_output;
	tb_test_sample_num = tb_test_sample_num + 1;


	// for(i = 0;i<enc_counter;i=i+1)
	//   begin
	//      tb_i_data = tb_i_data_vector[i];
	//      tbe_o_data = tbe_o_data_vector[i];
	//      $info("tb_i_data: %0d",tb_i_data);
	//      @(negedge tb_clk);
	//      tb_read_fifo = 1;
	//      @(negedge tb_clk);
	//      tb_read_fifo = 0;
	//      //$info("TBE: %b",tbe_o_data);
	//      while(!tb_data_done)
	//        begin
	// 	  @(negedge tb_clk);
	//        end
	//      check_output;
	//      tb_test_sample_num = tb_test_sample_num + 1;
	//   end
     end

/*
   always@(posedge tb_clk) begin
      if (!$feof(enc_file)) begin
	 scan_file = $fread(captured_data_A,enc_file);
	 scan_file = $fread(captured_data_B,enc_file);
	 tb_i_data_vector[enc_counter] <= captured_data_A;
	 tbe_o_data_vector[enc_counter] <= captured_data_B;
	 enc_counter <= enc_counter + 1;
	 $info("enc_counter: %0h",captured_data_A);
      end
      if (!$feof(key_file)) begin
	 scan_file = $fread(captured_data_A,key_file);
	 if (key_counter == 0)
	   begin
	      tb_round_key_0 <= captured_data_A;
	   end
	 else
	   tb_round_key_vector[key_counter-1] <= captured_data_A;
	 key_counter <= key_counter + 1;
	 //$info("key_data: %0h",captured_data_A);
      end
   end
*/
/*
   always@(posedge tb_clk,negedge tb_n_rst)begin
      if(tb_n_rst == 0)
	tb_round_key_input <= tb_round_key_vector[0];
      else
	tb_round_key_input <= tb_round_key_vector[tb_round_key_addr];
      $info("tb_round_key_addr: %4b",tb_round_key_addr);
      $info("tb_round_key_input: %0h",tb_round_key_input);
   end
*/
endmodule
