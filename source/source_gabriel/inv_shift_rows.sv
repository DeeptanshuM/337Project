// $Id: $
// File name:   inv_shift_rows.sv
// Created:     4/16/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Module for the inverse shift rows step in AES
module inv_shift_rows
(
  input wire [127:0] input_block,
  output reg [127:0] shifted_block
);

assign shifted_block = {input_block[127:96], input_block[71:64], input_block[95:72], input_block[47:32], input_block[63:48], input_block[23:0], input_block[31:24]};

endmodule
