/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Apr 26 01:52:31 2017
/////////////////////////////////////////////////////////////


module MCU ( clk, n_reset, generation_done, key_in, is_decryption_pulse, 
        is_encryption_pulse, emptyRx, fullRx, emptyTx, fullTx, data_done, 
        accepted, is_encrypt, read_fifo, rcv_deq, trans_enq, mcu_key_in, 
        status_bits );
  output [3:0] status_bits;
  input clk, n_reset, generation_done, key_in, is_decryption_pulse,
         is_encryption_pulse, emptyRx, fullRx, emptyTx, fullTx, data_done,
         accepted;
  output is_encrypt, read_fifo, rcv_deq, trans_enq, mcu_key_in;
  wire   trans_enq, flagKeyGenDone, tmp_flagKeyGenDone, n22, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75,
         n76, n77, n78, n79;
  wire   [3:0] state;
  assign trans_enq = data_done;
  assign is_encrypt = status_bits[2];

  DFFSR \status_bits_reg[2]  ( .D(n49), .CLK(clk), .R(1'b1), .S(n_reset), .Q(
        status_bits[2]) );
  DFFSR \status_bits_reg[1]  ( .D(n22), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        status_bits[1]) );
  DFFSR \status_bits_reg[0]  ( .D(fullRx), .CLK(clk), .R(n_reset), .S(1'b1), 
        .Q(status_bits[0]) );
  DFFSR \state_reg[0]  ( .D(n48), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        state[0]) );
  DFFSR \state_reg[3]  ( .D(n47), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        state[3]) );
  DFFSR \state_reg[1]  ( .D(n46), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        state[1]) );
  DFFSR \state_reg[2]  ( .D(n45), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        state[2]) );
  DFFSR flagKeyGenDone_reg ( .D(tmp_flagKeyGenDone), .CLK(clk), .R(n_reset), 
        .S(1'b1), .Q(flagKeyGenDone) );
  DFFSR \status_bits_reg[3]  ( .D(flagKeyGenDone), .CLK(clk), .R(n_reset), .S(
        1'b1), .Q(status_bits[3]) );
  OAI21X1 U53 ( .A(n50), .B(n51), .C(n52), .Y(tmp_flagKeyGenDone) );
  INVX1 U54 ( .A(flagKeyGenDone), .Y(n52) );
  NAND2X1 U55 ( .A(n53), .B(n54), .Y(n51) );
  OAI21X1 U56 ( .A(n55), .B(n56), .C(n57), .Y(rcv_deq) );
  NAND2X1 U57 ( .A(n58), .B(n59), .Y(n56) );
  OAI21X1 U58 ( .A(is_decryption_pulse), .B(n60), .C(n61), .Y(n49) );
  INVX1 U59 ( .A(is_encryption_pulse), .Y(n61) );
  INVX1 U60 ( .A(status_bits[2]), .Y(n60) );
  OAI21X1 U61 ( .A(n58), .B(n62), .C(n63), .Y(n48) );
  OAI21X1 U62 ( .A(key_in), .B(n64), .C(n65), .Y(n63) );
  OAI21X1 U63 ( .A(n64), .B(n66), .C(n67), .Y(n65) );
  INVX1 U64 ( .A(emptyRx), .Y(n66) );
  OAI21X1 U65 ( .A(n54), .B(n53), .C(n68), .Y(n47) );
  NAND2X1 U66 ( .A(state[3]), .B(n69), .Y(n68) );
  NAND3X1 U67 ( .A(n53), .B(n54), .C(generation_done), .Y(n69) );
  XNOR2X1 U68 ( .A(state[2]), .B(n70), .Y(n53) );
  AOI22X1 U69 ( .A(state[1]), .B(state[0]), .C(n70), .D(state[2]), .Y(n54) );
  XNOR2X1 U70 ( .A(state[0]), .B(n59), .Y(n70) );
  OR2X1 U71 ( .A(n71), .B(n72), .Y(n46) );
  OAI22X1 U72 ( .A(n73), .B(n74), .C(n59), .D(n62), .Y(n72) );
  OAI21X1 U73 ( .A(emptyRx), .B(n64), .C(n75), .Y(n71) );
  AND2X1 U74 ( .A(n67), .B(n57), .Y(n75) );
  NAND3X1 U75 ( .A(n58), .B(n59), .C(n76), .Y(n64) );
  NAND3X1 U76 ( .A(n57), .B(n67), .C(n77), .Y(n45) );
  AOI22X1 U77 ( .A(n78), .B(state[2]), .C(read_fifo), .D(n74), .Y(n77) );
  INVX1 U78 ( .A(accepted), .Y(n74) );
  INVX1 U79 ( .A(n73), .Y(read_fifo) );
  INVX1 U80 ( .A(n62), .Y(n78) );
  NAND3X1 U81 ( .A(n73), .B(n55), .C(n57), .Y(n62) );
  NAND3X1 U82 ( .A(state[1]), .B(n58), .C(n76), .Y(n73) );
  NAND3X1 U83 ( .A(state[1]), .B(n58), .C(n79), .Y(n67) );
  INVX1 U84 ( .A(n55), .Y(n79) );
  NAND2X1 U85 ( .A(state[2]), .B(n50), .Y(n55) );
  INVX1 U86 ( .A(state[3]), .Y(n50) );
  INVX1 U87 ( .A(state[0]), .Y(n58) );
  INVX1 U88 ( .A(emptyTx), .Y(n22) );
  INVX1 U89 ( .A(n57), .Y(mcu_key_in) );
  NAND3X1 U90 ( .A(state[0]), .B(n59), .C(n76), .Y(n57) );
  NOR2X1 U91 ( .A(state[3]), .B(state[2]), .Y(n76) );
  INVX1 U92 ( .A(state[1]), .Y(n59) );
endmodule

