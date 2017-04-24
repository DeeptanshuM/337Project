module incriment_state
  (
   input reg [4:0] i_state,
   output reg [4:0] o_state
   );

   always_comb begin
      o_state[3:0] = i_state[3:0] + 1;
      if (i_state[4] == 1 && i_state[3:0] > 10)
	o_state[4] = 0;
      else
	o_state[4] = i_state[4];
   end
endmodule
