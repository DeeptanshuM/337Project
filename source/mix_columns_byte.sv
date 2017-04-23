// AES: mix columns for a single byte

module mix_columns_byte
  (
   input reg [31:0]  i_data,
   input reg [15:0]  i_coeff,
   output reg [7:0] o_data
   );

   

   wire [7:0] 	    aes_mul;
   assign aes_mul = 8'b00011011;

   // larger loop
   integer 	    i,c;
   integer 		    idx,jdx;
   reg [7:0] 		    curr;
   reg [3:0] 		    coeff;

   // inner loop
   integer 	    j,k;
   reg [7:0] 	    out,res;

   always_comb begin
      //$display("i_data:%h",i_data);
      //$display("i_coeff:%h",i_coeff);
      o_data = '0;
      for(i=0;i<4;i=i+1) begin
	 //idx = 8*(4-i)-1;
	 idx = 8*(4-i)-1;
	 jdx = 4*(4-i)-1;
	 curr = i_data[idx-:8];
	 coeff = i_coeff[jdx-:4];
	 //start gf2_mult
	 // $display("curr[%0d+8:%0d]:%h",i,i,curr);
	 // $display("coeff[%0d+8:%0d]:%h",i,i,coeff);
	 out = '0;
	 for(j=0;j<4;j=j+1)
	   begin
	      res = curr;
	      if(coeff[j] == 1)
		begin
		   for(k=0;k<j;k=k+1)
		     begin
			if(res[7] == 1)
			  begin
			     res = (res << 1) ^ aes_mul;
			  end
			else
			  begin
			     res = (res << 1);
			  end
		     end // for (j=0;j<i;j=j+1)
		end
	      else
		res = 0;
	      out = out ^ res;
	   end
	  //end gf2_mult
	      
	 // $display("out[%0d+8:%0d]:%h",i,i,out);
	 // $display("i_coeff:%h",coeff);
	 o_data = o_data ^ out;
	 //$display("o_data:%h",o_data);
      end
   end
   
endmodule
