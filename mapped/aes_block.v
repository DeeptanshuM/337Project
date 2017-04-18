/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 18 00:39:32 2017
/////////////////////////////////////////////////////////////


module aes_block ( clk, n_rst, rx_fifo_out, read_fifo, round_key_input, 
        round_key_0, is_encrypt, tx_fifo_full, tx_fifo_in, data_done, 
        read_addr );
  input clk, n_rst, rx_fifo_out, read_fifo, round_key_input, round_key_0,
         is_encrypt, tx_fifo_full;
  output tx_fifo_in, data_done, read_addr;
  wire   n4, n5, n6, n7;
  tri   clk;
  tri   n_rst;
  tri   rx_fifo_out;
  tri   read_fifo;
  tri   round_key_input;
  tri   round_key_0;
  tri   tx_fifo_full;
  tri   enc_round_key_addr;
  tri   enc_data_output;
  tri   enc_data_done;
  tri   dec_round_key_addr;
  tri   dec_data_output;
  tri   dec_data_done;

  aes_encryption E_AES ( .clk(clk), .n_rst(n_rst), .read_fifo(read_fifo), 
        .fifo_in(rx_fifo_out), .round_key_input(round_key_input), 
        .round_key_0(round_key_0), .is_full(tx_fifo_full), .round_key_addr(
        enc_round_key_addr), .data_output(enc_data_output), .data_done(
        enc_data_done) );
  aes_decryption D_AES ( .clk(clk), .n_rst(n_rst), .read_fifo(read_fifo), 
        .fifo_in(rx_fifo_out), .round_key_input(round_key_input), 
        .round_key_0(round_key_0), .is_full(tx_fifo_full), .round_key_addr(
        dec_round_key_addr), .data_output(dec_data_output), .data_done(
        dec_data_done) );
  INVX2 U1 ( .A(n7), .Y(data_done) );
  INVX2 U2 ( .A(n5), .Y(tx_fifo_in) );
  INVX2 U3 ( .A(n6), .Y(read_addr) );
  INVX2 U4 ( .A(is_encrypt), .Y(n4) );
  AOI22X1 U5 ( .A(dec_data_output), .B(n4), .C(is_encrypt), .D(enc_data_output), .Y(n5) );
  AOI22X1 U6 ( .A(dec_round_key_addr), .B(n4), .C(enc_round_key_addr), .D(
        is_encrypt), .Y(n6) );
  AOI22X1 U7 ( .A(dec_data_done), .B(n4), .C(enc_data_done), .D(is_encrypt), 
        .Y(n7) );
endmodule

