// $Id: $
// File name:   shift_rows.sv
// Created:     4/16/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Module for the shift rows step in AES

module shift_rows
  (
   input wire [127:0] i_data,
   output reg [127:0] o_data
   );

   assign o_data = {i_data[127:96], i_data[87:64], i_data[95:88], i_data[47:32], i_data[63:48], i_data[7:0], i_data[31:8]};
   
endmodule

