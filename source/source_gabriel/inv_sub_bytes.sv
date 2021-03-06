// $Id: $
// File name:   inv_sub_bytes.sv
// Created:     4/16/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Module for the inverse sub bytes step in AES
module inv_sub_bytes
(
  input wire [127:0] input_block,
  output reg [127:0] subbed_block
);

inv_s_box_lookup ISUB1 (.input_word(input_block[127:120]), .substituted_word(subbed_block[127:120]));
inv_s_box_lookup ISUB2 (.input_word(input_block[119:112]), .substituted_word(subbed_block[119:112]));
inv_s_box_lookup ISUB3 (.input_word(input_block[111:104]), .substituted_word(subbed_block[111:104]));
inv_s_box_lookup ISUB4 (.input_word(input_block[103:96]), .substituted_word(subbed_block[103:96]));
inv_s_box_lookup ISUB5 (.input_word(input_block[95:88]), .substituted_word(subbed_block[95:88]));
inv_s_box_lookup ISUB6 (.input_word(input_block[87:80]), .substituted_word(subbed_block[87:80]));
inv_s_box_lookup ISUB7 (.input_word(input_block[79:72]), .substituted_word(subbed_block[79:72]));
inv_s_box_lookup ISUB8 (.input_word(input_block[71:64]), .substituted_word(subbed_block[71:64]));
inv_s_box_lookup ISUB9 (.input_word(input_block[63:56]), .substituted_word(subbed_block[63:56]));
inv_s_box_lookup ISUB10 (.input_word(input_block[55:48]), .substituted_word(subbed_block[55:48]));
inv_s_box_lookup ISUB11 (.input_word(input_block[47:40]), .substituted_word(subbed_block[47:40]));
inv_s_box_lookup ISUB12 (.input_word(input_block[39:32]), .substituted_word(subbed_block[39:32]));
inv_s_box_lookup ISUB13 (.input_word(input_block[31:24]), .substituted_word(subbed_block[31:24]));
inv_s_box_lookup ISUB14 (.input_word(input_block[23:16]), .substituted_word(subbed_block[23:16]));
inv_s_box_lookup ISUB15 (.input_word(input_block[15:8]), .substituted_word(subbed_block[15:8]));
inv_s_box_lookup ISUB16 (.input_word(input_block[7:0]), .substituted_word(subbed_block[7:0]));

endmodule

