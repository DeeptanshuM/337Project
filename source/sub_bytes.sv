// $Id: $
// File name:   sub_bytes.sv
// Created:     4/16/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Module for the sub bytes step in AES
module sub_bytes
(
  input wire [127:0] i_data,
  output reg [127:0] o_data
);

s_box_lookup SUB1 (.input_word(i_data[127:120]), .substituted_word(o_data[127:120]));
s_box_lookup SUB2 (.input_word(i_data[119:112]), .substituted_word(o_data[119:112]));
s_box_lookup SUB3 (.input_word(i_data[111:104]), .substituted_word(o_data[111:104]));
s_box_lookup SUB4 (.input_word(i_data[103:96]), .substituted_word(o_data[103:96]));
s_box_lookup SUB5 (.input_word(i_data[95:88]), .substituted_word(o_data[95:88]));
s_box_lookup SUB6 (.input_word(i_data[87:80]), .substituted_word(o_data[87:80]));
s_box_lookup SUB7 (.input_word(i_data[79:72]), .substituted_word(o_data[79:72]));
s_box_lookup SUB8 (.input_word(i_data[71:64]), .substituted_word(o_data[71:64]));
s_box_lookup SUB9 (.input_word(i_data[63:56]), .substituted_word(o_data[63:56]));
s_box_lookup SUB10 (.input_word(i_data[55:48]), .substituted_word(o_data[55:48]));
s_box_lookup SUB11 (.input_word(i_data[47:40]), .substituted_word(o_data[47:40]));
s_box_lookup SUB12 (.input_word(i_data[39:32]), .substituted_word(o_data[39:32]));
s_box_lookup SUB13 (.input_word(i_data[31:24]), .substituted_word(o_data[31:24]));
s_box_lookup SUB14 (.input_word(i_data[23:16]), .substituted_word(o_data[23:16]));
s_box_lookup SUB15 (.input_word(i_data[15:8]), .substituted_word(o_data[15:8]));
s_box_lookup SUB16 (.input_word(i_data[7:0]), .substituted_word(o_data[7:0]));

endmodule

