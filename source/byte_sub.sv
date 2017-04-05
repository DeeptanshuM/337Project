module byte_sub
  (
   input wire [0:7]  l_table[0:3][0:3],
   input wire [0:7]  data_i,
   output wire [0:7] data_o
   );

   
   assign data_o = l_table[data_i[0:3]][data_i[4:7]];
     
endmodule
