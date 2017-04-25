module gf2_mult  
  (
   input reg [7:0]  i_data,
   input reg [3:0]  i_coeff,
   output reg [7:0] o_data
   );

   integer 	    i,j;
   reg [7:0] 	    out,res;
   wire [7:0] 	    aes_mul;
   assign aes_mul = 8'b00011011;

   always_comb
     begin
	out = '0;
	for(i=0;i<4;i=i+1)
	  begin
	     res = i_data;
	     if(i_coeff[i] == 1)
	       begin
		  for(j=0;j<i;j=j+1)
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
	       end // if (i_coeff[i] == 1)
	     else
	       res = 0;
	     out = out ^ res;
	  end
     end
