module incriment_state
  (
   input wire [4:0] i_state,
   output wire [4:0] o_state
   );

   assign o_state = i_state + 1;

endmodule
