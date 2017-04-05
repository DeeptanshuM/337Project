/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Mar 28 21:19:49 2017
/////////////////////////////////////////////////////////////


module mux_4bits ( l_table, data_i, data_o );
  input [0:3] l_table;
  input [0:3] data_i;
  output [0:3] data_o;
  wire   n1, n2;
  assign data_o[2] = 1'b0;
  assign data_o[1] = 1'b0;
  assign data_o[0] = 1'b0;

  MUX2X1 U2 ( .B(n1), .A(n2), .S(data_i[3]), .Y(data_o[3]) );
  MUX2X1 U3 ( .B(l_table[1]), .A(l_table[3]), .S(data_i[2]), .Y(n2) );
  MUX2X1 U4 ( .B(l_table[0]), .A(l_table[2]), .S(data_i[2]), .Y(n1) );
endmodule

