module sub_bytes_byte
  (
   input wire [7:0]  l_table[7:0],
   input wire [7:0] i_data ,
   output wire [7:0] o_data
   );

   assign o_data = l_table[i_data[7:4]][i_data[3:0]];
     
endmodule
