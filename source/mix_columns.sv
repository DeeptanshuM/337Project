// AES: mix columns 

module mix_columns
  (
   input reg [127:0]  i_data,
   input reg [4:0] i_state,
   output reg [127:0] o_data
   );
   
   reg [127:0] 	      mix_out;

   always_comb begin
      if(i_state[3:0] == 4'b1001)
	o_data = i_data;
      else
	o_data = mix_out;
   end
   
   // COEFF [02,03,01,01]
   mix_columns_byte MC_B0
     (.i_data(i_data[127:96]),
      .i_coeff({4'b0010,4'b0011,4'b0001,4'b0001}),
      .o_data(mix_out[127:120]));
   
   mix_columns_byte MC_B1 
     (.i_data(i_data[95:64]),
      .i_coeff({4'b0010,4'b0011,4'b0001,4'b0001}),
      .o_data(mix_out[95:88]));
   
   mix_columns_byte MC_B2 
     (.i_data(i_data[63:32]),
      .i_coeff({4'b0010,4'b0011,4'b0001,4'b0001}),
      .o_data(mix_out[63:56]));
   
   mix_columns_byte MC_B3 
    (.i_data(i_data[31:0]),
     .i_coeff({4'b0010,4'b0011,4'b0001,4'b0001}),
     .o_data(mix_out[31:24]));
   
   // COEFF [01,02,03,01]
   mix_columns_byte MC_B4 
     (.i_data(i_data[127:96]),
     .i_coeff({4'b0001,4'b0010,4'b0011,4'b0001}),
     .o_data(mix_out[119:112]));
   
   mix_columns_byte MC_B5 
     (.i_data(i_data[95:64]),
     .i_coeff({4'b0001,4'b0010,4'b0011,4'b0001}),
     .o_data(mix_out[87:80]));
   
   mix_columns_byte MC_B6 
     (.i_data(i_data[63:32]),
     .i_coeff({4'b0001,4'b0010,4'b0011,4'b0001}),
     .o_data(mix_out[55:48]));
   
   mix_columns_byte MC_B7 
    (.i_data(i_data[31:0]),
     .i_coeff({4'b0001,4'b0010,4'b0011,4'b0001}),
     .o_data(mix_out[23:16]));


   // COEFF [01,01,02,03]
   mix_columns_byte MC_B8 
     (.i_data(i_data[127:96]),
     .i_coeff({4'b0001,4'b0001,4'b0010,4'b0011}),
     .o_data(mix_out[111:104]));
   
   mix_columns_byte MC_B9 
     (.i_data(i_data[95:64]),
     .i_coeff({4'b0001,4'b0001,4'b0010,4'b0011}),
     .o_data(mix_out[79:72]));
   
   mix_columns_byte MC_B10 
     (.i_data(i_data[63:32]),
     .i_coeff({4'b0001,4'b0001,4'b0010,4'b0011}),
     .o_data(mix_out[47:40]));
   
   mix_columns_byte MC_B11 
    (.i_data(i_data[31:0]),
     .i_coeff({4'b0001,4'b0001,4'b0010,4'b0011}),
     .o_data(mix_out[15:8]));

   
   // COEFF [03,01,01,02]
   mix_columns_byte MC_B12 
     (.i_data(i_data[127:96]),
     .i_coeff({4'b0011,4'b0001,4'b0001,4'b0010}),
     .o_data(mix_out[103:96]));
   
   mix_columns_byte MC_B13 
     (.i_data(i_data[95:64]),
     .i_coeff({4'b0011,4'b0001,4'b0001,4'b0010}),
     .o_data(mix_out[71:64]));
   
   mix_columns_byte MC_B14 
     (.i_data(i_data[63:32]),
     .i_coeff({4'b0011,4'b0001,4'b0001,4'b0010}),
     .o_data(mix_out[39:32]));
   
   mix_columns_byte MC_B15 
    (.i_data(i_data[31:0]),
     .i_coeff({4'b0011,4'b0001,4'b0001,4'b0010}),
     .o_data(mix_out[7:0]));


endmodule
