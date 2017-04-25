// AES: mix columns 

module mix_columns
  (
   input reg [127:0]  i_data,
   output reg [127:0] o_data
   );
   
   // COEFF [02,03,01,01]
   mix_columns_byte MC_B0
    (.i_data({i_data[127:120],i_data[95:88],i_data[63:56],i_data[31:24]}),
     .i_coeff({4'b0010,4'b0011,4'b0001,4'b0001}),
     .o_data(o_data[127:120]));
   
   mix_columns_byte MC_B1 
    (.i_data({i_data[119:112],i_data[87:80],i_data[55:48],i_data[23:16]}),
     .i_coeff({4'b0010,4'b0011,4'b0001,4'b0001}),
     .o_data(o_data[119:112]));
   
   mix_columns_byte MC_B2 
    (.i_data({i_data[111:104],i_data[79:72],i_data[47:40],i_data[15:8]}),
     .i_coeff({4'b0010,4'b0011,4'b0001,4'b0001}),
     .o_data(o_data[111:104]));
   
   mix_columns_byte MC_B3 
    (.i_data({i_data[103:96],i_data[71:64],i_data[39:32],i_data[7:0]}),
     .i_coeff({4'b0010,4'b0011,4'b0001,4'b0001}),
     .o_data(o_data[103:96]));
   
   // COEFF [01,02,03,01]
   mix_columns_byte MC_B4 
    (.i_data({i_data[127:120],i_data[95:88],i_data[63:56],i_data[31:24]}),
     .i_coeff({4'b0001,4'b0010,4'b0011,4'b0001}),
     .o_data(o_data[95:88]));
   
   mix_columns_byte MC_B5 
    (.i_data({i_data[119:112],i_data[87:80],i_data[55:48],i_data[23:16]}),
     .i_coeff({4'b0001,4'b0010,4'b0011,4'b0001}),
     .o_data(o_data[87:80]));
   
   mix_columns_byte MC_B6 
    (.i_data({i_data[111:104],i_data[79:72],i_data[47:40],i_data[15:8]}),
     .i_coeff({4'b0001,4'b0010,4'b0011,4'b0001}),
     .o_data(o_data[79:72]));
   
   mix_columns_byte MC_B7 
    (.i_data({i_data[103:96],i_data[71:64],i_data[39:32],i_data[7:0]}),
     .i_coeff({4'b0001,4'b0010,4'b0011,4'b0001}),
     .o_data(o_data[71:64]));


   // COEFF [01,01,02,03]
   mix_columns_byte MC_B8 
    (.i_data({i_data[127:120],i_data[95:88],i_data[63:56],i_data[31:24]}),
     .i_coeff({4'b0001,4'b0001,4'b0010,4'b0011}),
     .o_data(o_data[63:56]));
   
   mix_columns_byte MC_B9 
    (.i_data({i_data[119:112],i_data[87:80],i_data[55:48],i_data[23:16]}),
     .i_coeff({4'b0001,4'b0001,4'b0010,4'b0011}),
     .o_data(o_data[55:48]));
   
   mix_columns_byte MC_B10 
    (.i_data({i_data[111:104],i_data[79:72],i_data[47:40],i_data[15:8]}),
     .i_coeff({4'b0001,4'b0001,4'b0010,4'b0011}),
     .o_data(o_data[47:40]));
   
   mix_columns_byte MC_B11 
    (.i_data({i_data[103:96],i_data[71:64],i_data[39:32],i_data[7:0]}),
     .i_coeff({4'b0001,4'b0001,4'b0010,4'b0011}),
     .o_data(o_data[39:32]));

   
   // COEFF [03,01,01,02]
   mix_columns_byte MC_B12 
    (.i_data({i_data[127:120],i_data[95:88],i_data[63:56],i_data[31:24]}),
     .i_coeff({4'b0011,4'b0001,4'b0001,4'b0010}),
     .o_data(o_data[31:24]));
   
   mix_columns_byte MC_B13 
    (.i_data({i_data[119:112],i_data[87:80],i_data[55:48],i_data[23:16]}),
     .i_coeff({4'b0011,4'b0001,4'b0001,4'b0010}),
     .o_data(o_data[23:16]));
   
   mix_columns_byte MC_B14 
    (.i_data({i_data[111:104],i_data[79:72],i_data[47:40],i_data[15:8]}),
     .i_coeff({4'b0011,4'b0001,4'b0001,4'b0010}),
     .o_data(o_data[15:8]));
   
   mix_columns_byte MC_B15 
    (.i_data({i_data[103:96],i_data[71:64],i_data[39:32],i_data[7:0]}),
     .i_coeff({4'b0011,4'b0001,4'b0001,4'b0010}),
     .o_data(o_data[7:0]));


endmodule
