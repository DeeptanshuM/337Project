// $Id: $
// File name:   tx_fifo_fsm.sv
// Created:     4/16/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: State machine for transmittor FIFO.
module tx_fifo_fsm
(
	input wire clk,
	input wire n_rst,
	input wire tx_deq_word,
	input wire empty,
	input wire [1:0] head_side,
	output reg count_en1,
	output reg count_en2
);
	typedef enum bit [1:0] {IDLE, INC_IDX, INC_BOTH} stateType;
	stateType state;
	stateType nextState;
	always_ff @ (negedge n_rst, posedge clk) begin : REG_LOGIC
		if (n_rst == 1'b0) begin
			state <= IDLE;
		end else begin
			state <= nextState;
		end
	end
	always_comb begin: NXT_LOGIC
		nextState = state;
		case (state)
			IDLE: begin
				if (tx_deq_word && !empty && head_side != 3) begin
					nextState = INC_IDX;
				end
				else if (tx_deq_word && !empty && head_side == 3) begin
					nextState = INC_BOTH;
				end
			end
			INC_IDX: begin
				if (tx_deq_word && !empty && head_side != 2) begin
					nextState = INC_IDX;
				end
				else if (tx_deq_word && !empty) begin
					nextState = INC_BOTH;
				end
				else begin
					nextState = IDLE;
				end
			end
			INC_BOTH: begin
				if (tx_deq_word && !empty) begin
					nextState = INC_IDX;
				end
				else begin
					nextState = IDLE;
				end
			end
		endcase
	end
	always_comb begin: OUTPUT_LOGIC
		count_en1 = 1'b0;
		count_en2 = 1'b0;
		case (state)
			IDLE: begin
				//do nothing
			end
			INC_IDX: begin
				count_en1 = 1'b1;
			end
			INC_BOTH: begin
				count_en1 = 1'b1;
				count_en2 = 1'b1;
			end
		endcase
	end
endmodule
