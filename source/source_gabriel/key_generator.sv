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
  input wire [127:0] original_key,
  output reg [127:0] round_key_0,
  output reg [127:0] round_key_x,
  output reg generation_done
);

reg [127:0] round_key[1:10];
reg [31:0] gee_word;
reg [7:0] round_constant;
reg [127:0] current_key_input;
reg [127:0] select_og_key;
reg [31:0] wordZero, nextwordZero, nextwordOne, nextwordTwo, nextwordThree;
reg [31:0] wordOne;
reg [31:0] wordTwo;
reg [31:0] wordThree;
reg [3:0] round_count;

typedef enum bit [3:0] {IDLE, ROUND1, ROUND2, ROUND3, ROUND4, ROUND5, ROUND6, ROUND7, ROUND8, ROUND9, ROUND10, DONEGEN} stateType;
  stateType state;
  stateType nextstate;

assign round_key_0 = original_key;

g_function GFUNCTION (.input_word(wordThree), .current_round_constant(round_constant), .gee(gee_word));

always_comb begin
  if (WE_key_generation) begin
    select_og_key =  original_key;
  end
  else begin
    select_og_key = current_key_input;
  end
end

always_ff @ (posedge clk, negedge n_rst) begin
  if (n_rst == 0) begin
    current_key_input <= 128'b0;
    state <= IDLE;
    wordZero <= original_key[127:96];
    wordOne <= original_key[95:64];
    wordTwo <= original_key[63:32];
    wordThree <= original_key[31:0];
    round_count <= 0;
  end
  else begin
    if (WE_key_generation) begin
      current_key_input <= select_og_key;
      state <= nextstate;
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
    nextwordOne = nextwordZero ^ wordOne;
    nextwordTwo = nextwordOne ^ wordTwo;
    nextwordThree = nextwordTwo ^ wordThree;
  end
end

always_comb begin : NXT_LOGIC

  nextstate = state;

  case(state)

    IDLE: begin
      if (WE_key_generation) begin
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
