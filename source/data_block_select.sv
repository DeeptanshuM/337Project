// AES: data block select

module data_block_select
  (
   input wire 	      i_read_fifo,
   input wire [127:0] i_fifo_in,
   input wire [127:0] i_round_block,
   input wire [4:0]   i_round_state,
   output reg [127:0] o_block_out,
   output reg [4:0]   o_state_out
   );

   always_comb begin
      o_block_out = i_round_block;
      o_state_out = i_round_state;

      if(i_read_fifo && i_round_state[4] == 0)
	begin
	   o_block_out = i_fifo_in;
	   o_state_out = 5'b10000;
	end
   end

endmodule
