/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 25 20:04:36 2017
/////////////////////////////////////////////////////////////


module incriment_state ( i_state, o_state );
  input [4:0] i_state;
  output [4:0] o_state;
  wire   n8, n9, n10;

  AND2X1 U11 ( .A(i_state[4]), .B(n8), .Y(o_state[4]) );
  OAI21X1 U12 ( .A(i_state[2]), .B(n9), .C(i_state[3]), .Y(n8) );
  XOR2X1 U13 ( .A(i_state[3]), .B(n10), .Y(o_state[3]) );
  AND2X1 U14 ( .A(n9), .B(i_state[2]), .Y(n10) );
  XOR2X1 U15 ( .A(i_state[2]), .B(n9), .Y(o_state[2]) );
  AND2X1 U16 ( .A(i_state[1]), .B(i_state[0]), .Y(n9) );
  XOR2X1 U17 ( .A(i_state[1]), .B(i_state[0]), .Y(o_state[1]) );
  INVX1 U18 ( .A(i_state[0]), .Y(o_state[0]) );
endmodule

