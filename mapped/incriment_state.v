/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 18 00:56:33 2017
/////////////////////////////////////////////////////////////


module incriment_state ( i_state, o_state );
  input [4:0] i_state;
  output [4:0] o_state;
  wire   n1, n2, n3, n4;

  XOR2X1 U2 ( .A(i_state[4]), .B(n1), .Y(o_state[4]) );
  NOR2X1 U3 ( .A(n2), .B(n3), .Y(n1) );
  INVX1 U4 ( .A(i_state[3]), .Y(n3) );
  XNOR2X1 U5 ( .A(i_state[3]), .B(n2), .Y(o_state[3]) );
  NAND3X1 U6 ( .A(i_state[1]), .B(i_state[0]), .C(i_state[2]), .Y(n2) );
  XNOR2X1 U7 ( .A(i_state[2]), .B(n4), .Y(o_state[2]) );
  NAND2X1 U8 ( .A(i_state[1]), .B(i_state[0]), .Y(n4) );
  XNOR2X1 U9 ( .A(i_state[1]), .B(o_state[0]), .Y(o_state[1]) );
  INVX1 U10 ( .A(i_state[0]), .Y(o_state[0]) );
endmodule

