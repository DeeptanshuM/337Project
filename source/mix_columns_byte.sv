// AES: mix columns for a single byte

module mix_columns_byte
  (
   input reg [31:0]  i_data,
   input reg [0:31]  i_coeff,
   output reg [7:0] o_data
   );
   
   assign aes_mul = 8'b00011011;
   integer 		    i,j;
   integer 		    idx;
   reg [7:0] 		    curr;

   always_comb begin
      o_data = '0;
      for(i=0;i<4;i=i+1) begin
	 idx = 8*i;
	 curr = i_data[idx+:8];
	 // $display("i-loop:%h,%h",i,j);
	 // $display("i_coeff:%h",i_coeff[idx+:8]);
	 for(j=1;j<i_coeff[idx+:8];j=j+1) begin
	    //$display("j-loop:%h,%h",i,j);
	    curr = (curr << 1) ^ aes_mul;
	 end
	 o_data = o_data ^ curr;
      end
   end
   
endmodule
