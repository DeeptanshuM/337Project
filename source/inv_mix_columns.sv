// AES: mix columns 

module inv_mix_columns
  (
   input reg [127:0]  i_data,
   output reg [127:0] o_data
   );
   
   wire [7:0] 	       aes_mul; // x^8 mod AES_MOD = 00011011
   assign aes_mul = 8'b00011011;
   
   //assign o_data[7:0] = i_data[7:0];

   // NOT IMPLEMENTED
   assign o_data = i_data;
   // always_comb begin
      
   // end
   

endmodule
