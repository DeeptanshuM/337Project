// $Id: $
// File name:   key_generator.sv
// Created:     4/11/2017
// Author:      Gabriel Chen
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Module to generate the 11 round keys and then provide them when called
module key_generator
(
  input wire clk,
  input wire n_rst,
  input wire [3:0] read_addr,
  input wire WE_key_generation,
  input wire [127:0] input_key,
  output reg [127:0] round_key_0,
  output reg [127:0] round_key_x,
  output reg generation_done
);

reg [127:0] round_key[1:10];
reg [31:0] gee_word;
reg [7:0] round_constant;
reg [127:0] original_key;
reg [127:0] tmp_original_key;
reg [31:0] wordZero, nextwordZero, nextwordOne, nextwordTwo, nextwordThree;
reg [31:0] wordOne;
reg [31:0] wordTwo;
reg [31:0] wordThree;
reg [3:0] round_count;
reg startGen;

typedef enum bit [3:0] {IDLE, ROUND1, ROUND2, ROUND3, ROUND4, ROUND5, ROUND6, ROUND7, ROUND8, ROUND9, ROUND10, DONEGEN} stateType;
  stateType state;
  stateType nextstate;

assign round_key_0 = original_key;

g_function GFUNCTION (.input_word(wordThree), .current_round_constant(round_constant), .gee(gee_word));

always_comb begin
  if (WE_key_generation) begin
    tmp_original_key = input_key;
  end
  else begin
    tmp_original_key = original_key;
  end
end

always_ff @ (posedge clk, negedge n_rst) begin
  if (n_rst == 0) begin
    original_key <= '0;
  end
  else begin
    original_key <= tmp_original_key;
  end
end

always_ff @ (posedge clk, negedge n_rst) begin
  if (n_rst == 0) begin
    state <= IDLE;
    wordZero <= 0;
    wordOne <= 0;
    wordTwo <= 0;
    wordThree <= 0;
    startGen <= 0;
    round_count <= 0;
    round_key[1] <= 0;
    round_key[2] <= 0;
    round_key[3] <= 0;
    round_key[4] <= 0;
    round_key[5] <= 0;
    round_key[6] <= 0;
    round_key[7] <= 0;
    round_key[8] <= 0;
    round_key[9] <= 0;
    round_key[10] <= 0;
  end
  else begin
    if (WE_key_generation) begin
      state <= nextstate;
      wordZero <= input_key[127:96];
      wordOne <= input_key[95:64];
      wordTwo <= input_key[63:32];
      wordThree <= input_key[31:0];
      startGen <= 1;
    end
    if (startGen) begin
      wordZero <= nextwordZero;
      wordOne <= nextwordOne;
      wordTwo <= nextwordTwo;
      wordThree <= nextwordThree;

      if (round_count < 11) begin
        round_count <= round_count + 1;
      end
      round_key[round_count] <= {wordZero, wordOne, wordTwo, wordThree};
    end
    if (generation_done) begin
      round_key_x <= round_key[read_addr];
    end
  end
end

always_comb begin

  if (!generation_done) begin
    nextwordZero = gee_word ^ wordZero;
    nextwordOne = gee_word ^ wordZero ^ wordOne;
    nextwordTwo = gee_word ^ wordZero ^ wordOne ^ wordTwo;
    nextwordThree = gee_word ^ wordZero ^ wordOne ^ wordTwo ^ wordThree;
  end
  else begin
    nextwordZero = 0;
    nextwordOne = 0;
    nextwordTwo = 0;
    nextwordThree = 0;
  end
end

always_comb begin : NXT_LOGIC

  nextstate = state;

  case(state)

    IDLE: begin
      if (startGen) begin
        nextstate = ROUND1;
      end
    end
    ROUND1: begin
      nextstate = ROUND2;
    end
    ROUND2: begin
      nextstate = ROUND3;
    end
    ROUND3: begin
      nextstate = ROUND4;
    end
    ROUND4: begin
      nextstate = ROUND5;
    end
    ROUND5: begin
      nextstate = ROUND6;
    end
    ROUND6: begin
      nextstate = ROUND7;
    end
    ROUND7: begin
      nextstate = ROUND8;
    end
    ROUND8: begin
      nextstate = ROUND9;
    end
    ROUND9: begin
      nextstate = ROUND10;
    end
    ROUND10: begin
      nextstate = DONEGEN;
    end
    DONEGEN: begin
    end	

  endcase
end

always_comb begin :OUT_LOGIC
    round_constant = 1;
    generation_done = 0;

  case(state)
    IDLE: begin
      round_constant = 8'b00000001;
    end
    ROUND1: begin
      round_constant = 8'b00000010;
    end
    ROUND2: begin
      round_constant = 8'b00000100;
    end
    ROUND3: begin
      round_constant = 8'b00001000;
    end
    ROUND4: begin
      round_constant = 8'b00010000;
    end
    ROUND5: begin
      round_constant = 8'b00100000;
    end
    ROUND6: begin
      round_constant = 8'b01000000;
    end
    ROUND7: begin
      round_constant = 8'b10000000;
    end
    ROUND8: begin
      round_constant = 8'b00011011;
    end
    ROUND9: begin
      round_constant = 8'b00110110;
    end
    DONEGEN: begin
      generation_done = 1;
    end
  endcase

end

endmodule
