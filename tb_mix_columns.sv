// $Id: $
// File name:   tb_mix_columns.sv
// Created:     4/15/2017
// Author:      Kent Gauen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Test bench for top level module mix_columns/
`timescale 1ns / 10ps
module tb_mix_columns();
   parameter CLK_PERIOD				= 4;
   parameter NUMBER_OF_TESTS = 500;
   // -=-=-=-=- MIX COLUMNS -=-=-=-=-

   //input
   reg [127:0]	     tb_i_data;

   
   //output
   reg [127:0] 	     tb_o_data;

   //expected output
   reg [127:0]		     tbe_o_data;
   
   mix_columns MIX_COLUMNS (.i_data(tb_i_data),.o_data(tb_o_data));

   //test bench vars
   integer 	     i;
   integer tb_test_case_num;
   integer tb_test_sample_num;
   reg 	   tb_clk;

   //data file vars
   integer data_file;
   integer scan_file;
   logic signed [127:0] captured_data_A;
   logic signed [127:0] captured_data_B;
   reg [127:0] 	       tb_i_data_vector[NUMBER_OF_TESTS];
   reg [127:0] 	       tbe_o_data_vector[NUMBER_OF_TESTS];
   reg [31:0] 	       test_counter;


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
	 data_file = $fopen("./AES python implementation/mixColEncrypt.txt","rb");
	 if(data_file == 0)begin
	    $display("data_file handle was NULL.");
	    $finish;
	 end
      end
   endtask

   initial
     begin
	test_counter = 0;
	tb_test_case_num = 0;
	tb_test_sample_num = 0;
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
      if (!$feof(data_file)) begin
	 scan_file = $fread(captured_data_A,data_file);
	 scan_file = $fread(captured_data_B,data_file);
	 tb_i_data_vector[test_counter] <= captured_data_A;
	 tbe_o_data_vector[test_counter] <= captured_data_B;
	 test_counter <= test_counter + 1;
      end
   end
   

endmodule
