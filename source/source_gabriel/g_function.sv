// $Id: $
// File name:   g_function.sv
// Created:     4/11/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Module for the g function in key generation
module g_function
(
  input wire [31:0] input_word,
  input wire [7:0] current_round_constant,
  output reg [31:0] gee
);

  wire [31:0] rotated_word;
  reg [7:0] xor_word;

  assign rotated_word = {input_word[23:0], input_word[31:24]};

  s_box_lookup SUBS0 (rotated_word[31:24], xor_word);
  s_box_lookup SUBS1 (rotated_word[23:16], gee[23:16]);
  s_box_lookup SUBS2 (rotated_word[15:8], gee[15:8]);
  s_box_lookup SUBS3 (rotated_word[7:0], gee[7:0]);

 assign gee[31:24] = xor_word ^ current_round_constant;

endmodule
