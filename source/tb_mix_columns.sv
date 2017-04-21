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
   localparam TB_TEST_VEC_SIZE = 10;	

   // -=-=-=-=- MIX COLUMNS -=-=-=-=-

   //input
   reg [7:0]	     tb_write_enable;
   reg [7:0] 	     tb_write_data;
   
   //output
   reg 	     tb_s_sda_out;
   reg 	     tb_fifo_empty;
   reg 	     tb_fifo_full;

   //expected output
   reg 	     tbe_s_sda_out;
   reg 	     tbe_fifo_empty;
   reg 	     tbe_fifo_full;
  (
   input reg [127:0]  i_data,
   output reg [127:0] o_data


   mix_columns MIX_COLUMNS (.i_data(tb_i_data),.o_data(tb_o_data));

   initial begin
      #(CLK_PERIOD);
   end
   
	
endmodule
