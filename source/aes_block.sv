// the AES block as seen in the highest level diagram

module aes_block
  (
   input wire clk,n_rst,rx_fifo_out,read_fifo,round_key_input,round_key_0,is_encrypt,tx_fifo_full,
   output reg tx_fifo_in,data_done,read_addr
   );
   
   wire        enc_round_key_addr,enc_data_output,enc_data_done;
   wire        dec_round_key_addr,dec_data_output,dec_data_done;
   
   aes_encryption E_AES
   (
    //inputs
    .clk(clk),
    .n_rst(n_rst),
    .read_fifo(read_fifo),
    .fifo_in(rx_fifo_out),
    .round_key_input(round_key_input),
    .round_key_0(round_key_0),
    .is_full(tx_fifo_full),
    //outputs
    .round_key_addr(enc_round_key_addr),
    .data_output(enc_data_output),
    .data_done(enc_data_done)
    );

   aes_decryption D_AES
   (
    //inputs
    .clk(clk),
    .n_rst(n_rst),
    .read_fifo(read_fifo),
    .fifo_in(rx_fifo_out),
    .round_key_input(round_key_input),
    .round_key_0(round_key_0),
    .is_full(tx_fifo_full),
    //outputs
    .round_key_addr(dec_round_key_addr),
    .data_output(dec_data_output),
    .data_done(dec_data_done)
    );


   always_comb begin
      if(is_encrypt)
	begin
	   read_addr = enc_round_key_addr;
	   data_done = enc_data_done;
	   tx_fifo_in = enc_data_output;
	end
      else
	begin
	   read_addr = dec_round_key_addr;
	   data_done = dec_data_done;
	   tx_fifo_in = dec_data_output;
	end
   end
   

endmodule


