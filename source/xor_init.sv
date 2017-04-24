// AES: XOR_INIT modules

module xor_init
  (
   input wire [127:0] i_round_block,
   input wire [4:0]   i_round_state,
   input wire [127:0] i_round_key_0,
   output reg [127:0] o_round_block
   );

   always_comb begin
      o_round_block = i_round_block;
      if (i_round_state[3:0] == 4'b0000)
	o_round_block = i_round_block ^ i_round_key_0;
   end
   
endmodule
