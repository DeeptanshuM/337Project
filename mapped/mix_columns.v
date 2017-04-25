/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Apr 24 23:17:58 2017
/////////////////////////////////////////////////////////////


module mix_columns ( i_data, o_data );
  input [127:0] i_data;
  output [127:0] o_data;

  tri   \*Logic1* ;
  tri   \*Logic0* ;
  tri   [127:0] i_data;
  tri   [127:0] o_data;
  tri   net3;

  mix_columns_byte MC_B0 ( .i_data({i_data[127:120], i_data[95:88], 
        i_data[63:56], i_data[31:24]}), .i_coeff({1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 
        1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}), 
        .o_data(o_data[127:120]) );
  mix_columns_byte MC_B1 ( .i_data({i_data[119:112], i_data[87:80], 
        i_data[55:48], i_data[23:16]}), .i_coeff({1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 
        1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}), 
        .o_data(o_data[119:112]) );
  mix_columns_byte MC_B2 ( .i_data({i_data[111:104], i_data[79:72], 
        i_data[47:40], i_data[15:8]}), .i_coeff({1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 
        1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}), 
        .o_data(o_data[111:104]) );
  mix_columns_byte MC_B3 ( .i_data({i_data[103:96], i_data[71:64], 
        i_data[39:32], i_data[7:0]}), .i_coeff({1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 
        1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}), 
        .o_data(o_data[103:96]) );
  mix_columns_byte MC_B4 ( .i_data({i_data[127:120], i_data[95:88], 
        i_data[63:56], i_data[31:24]}), .i_coeff({1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 
        1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}), 
        .o_data(o_data[95:88]) );
  mix_columns_byte MC_B5 ( .i_data({i_data[119:112], i_data[87:80], 
        i_data[55:48], i_data[23:16]}), .i_coeff({1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 
        1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}), 
        .o_data(o_data[87:80]) );
  mix_columns_byte MC_B6 ( .i_data({i_data[111:104], i_data[79:72], 
        i_data[47:40], i_data[15:8]}), .i_coeff({1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 
        1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}), 
        .o_data(o_data[79:72]) );
  mix_columns_byte MC_B7 ( .i_data({i_data[103:96], i_data[71:64], 
        i_data[39:32], i_data[7:0]}), .i_coeff({1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 
        1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}), 
        .o_data(o_data[71:64]) );
  mix_columns_byte MC_B8 ( .i_data({i_data[127:120], i_data[95:88], 
        i_data[63:56], i_data[31:24]}), .i_coeff({1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1}), 
        .o_data(o_data[63:56]) );
  mix_columns_byte MC_B9 ( .i_data({i_data[119:112], i_data[87:80], 
        i_data[55:48], i_data[23:16]}), .i_coeff({1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1}), 
        .o_data(o_data[55:48]) );
  mix_columns_byte MC_B10 ( .i_data({i_data[111:104], i_data[79:72], 
        i_data[47:40], i_data[15:8]}), .i_coeff({1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1}), 
        .o_data(o_data[47:40]) );
  mix_columns_byte MC_B11 ( .i_data({i_data[103:96], i_data[71:64], 
        i_data[39:32], i_data[7:0]}), .i_coeff({1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1}), 
        .o_data(o_data[39:32]) );
  mix_columns_byte MC_B12 ( .i_data({i_data[127:120], i_data[95:88], 
        i_data[63:56], i_data[31:24]}), .i_coeff({1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0}), 
        .o_data(o_data[31:24]) );
  mix_columns_byte MC_B13 ( .i_data({i_data[119:112], i_data[87:80], 
        i_data[55:48], i_data[23:16]}), .i_coeff({1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0}), 
        .o_data(o_data[23:16]) );
  mix_columns_byte MC_B14 ( .i_data({i_data[111:104], i_data[79:72], 
        i_data[47:40], i_data[15:8]}), .i_coeff({1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0}), 
        .o_data(o_data[15:8]) );
  mix_columns_byte MC_B15 ( .i_data({i_data[103:96], i_data[71:64], 
        i_data[39:32], i_data[7:0]}), .i_coeff({1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0}), 
        .o_data(o_data[7:0]) );
endmodule

