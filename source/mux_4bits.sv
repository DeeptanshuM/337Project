module mux_4bits
  (
   input wire 	     l_table[0:3],
   input wire [0:3]  data_i,
   output wire [0:3] data_o
   );

   assign data_o = l_table[data_i[0:3]];
     
endmodule
