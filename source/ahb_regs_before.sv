// $Id: $
// File name:   ahb_regs.sv
// Created:     4/18/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Place to store the registers as outputs of AHB.
module ahb_regs (
	input wire       clk,
	input wire       n_rst,
	input wire [1:0] HTRANS,
	input wire [3:0] opcode,
	input wire       rcv_fifo_full,
	input wire       rcv_fifo_empty,
	input wire       tx_fifo_empty,
	output reg       rcv_enq_word,
	output reg       tx_deq_word,
	output reg       is_encrypt_pulse,
	output reg       is_decrypt_pulse,
	output reg       key_in,
	output reg       is_status,
	output reg       HREADY,
	output reg [1:0] HRESP
);
	parameter BUZ = 2'b01;
	typedef enum bit [3:0] {NOP, OUTPUT_BUR, INPUT_BUR, KEY_BUR, LAST_KEY_WORD_BUR, GET_STATUS,
				ENCRYPT, DECRYPT, BUSY, ERROR, OUTPUT_BUR_BUSY, INPUT_BUR_BUSY, KEY_BUR_BUSY} opcodeType;
	typedef enum bit [2:0] {IDLE, ERR1, ERR2, BEEZ, OUT_BUR_BUSY, IN_BUR_BUSY, K_BUR_BUSY} errType;

	errType state;
	errType nextState;

	reg tmp_rcv_enq_word;
	reg tmp_tx_deq_word;
	reg tmp_is_encrypt_pulse;
	reg tmp_is_decrypt_pulse;
	reg tmp_key_in;
	reg tmp_is_status;
	reg t_key_in;
	
	always_ff @ (negedge n_rst, posedge clk) begin : FSM_LOGIC
		if (n_rst == 1'b0) begin
			state <= IDLE;
		end else begin
			state <= nextState;
		end
	end

	always_comb begin : NXT_ST_LOGIC
		nextState = state;
		case (state)
			IDLE: begin
				if (opcode == ERROR) begin
					nextState = ERR1;
				end
				else if (opcode == BUSY) begin
					nextState = BEEZ;
				end
				else if (opcode == OUTPUT_BUR_BUSY) begin
					nextState = OUT_BUR_BUSY;
				end
				else if (opcode == INPUT_BUR_BUSY) begin
					nextState = IN_BUR_BUSY;
				end
				else if (opcode == KEY_BUR_BUSY) begin
					nextState = K_BUR_BUSY;
				end
			end
			ERR1: begin
				nextState = ERR2;
			end
			ERR2: begin
				nextState = IDLE;
			end
			BEEZ: begin
				if (HTRANS != BUZ) begin
					nextState = IDLE;
				end
			end
			OUT_BUR_BUSY: begin
				if (!tx_fifo_empty) begin
					nextState = IDLE;
				end
			end
			IN_BUR_BUSY: begin
				if (!rcv_fifo_full) begin
					nextState = IDLE;
				end
			end
			K_BUR_BUSY: begin
				if (rcv_fifo_empty) begin
					nextState = IDLE;
				end
			end
		endcase
	end

	always_comb begin : OUTPUT_LOGIC
		HREADY = 1'b1;
		HRESP = 2'b00;
		case (state)
			IDLE: begin
				//do nothing
			end
			ERR1: begin
				HREADY = 1'b0;
				HRESP = 2'b01;
			end
			ERR2: begin
				HREADY = 1'b1;
				HRESP = 2'b01;
			end
			BEEZ: begin
				HREADY = 1'b0;
			end
			OUT_BUR_BUSY: begin
				HREADY = 1'b0;
			end
			IN_BUR_BUSY: begin
				HREADY = 1'b0;
			end
			K_BUR_BUSY: begin
				HREADY = 1'b0;
			end
		endcase
	end

	always_ff @ (negedge n_rst, posedge clk) begin : REG_LOGIC
		if (n_rst == 1'b0) begin
			rcv_enq_word <= 1'b0;
			tx_deq_word <= 1'b0;
			is_encrypt_pulse <= 1'b0;
			is_decrypt_pulse <= 1'b0;
			key_in <= 1'b0;
			t_key_in <= 1'b0;
			is_status <= 1'b0;
		end else begin
			rcv_enq_word <= tmp_rcv_enq_word && (nextState == IDLE);
			tx_deq_word <= tmp_tx_deq_word && (nextState == IDLE);
			is_encrypt_pulse <= tmp_is_encrypt_pulse;
			is_decrypt_pulse <= tmp_is_decrypt_pulse;
			key_in <= t_key_in;
			t_key_in <= tmp_key_in;
			is_status <= tmp_is_status;
		end
	end

	always_comb begin : REG_NXT_STATE
		tmp_rcv_enq_word = 1'b0;
		tmp_tx_deq_word = 1'b0;
		tmp_is_encrypt_pulse = 1'b0;
		tmp_is_decrypt_pulse = 1'b0;
		tmp_key_in = 1'b0;
		tmp_is_status = 1'b0;

		if (opcode == OUTPUT_BUR) begin
			tmp_tx_deq_word = 1'b1;
		end
		else if (opcode == INPUT_BUR) begin
			tmp_rcv_enq_word = 1'b1;
		end
		else if (opcode == KEY_BUR) begin
			tmp_rcv_enq_word = 1'b1;
		end
		else if (opcode == LAST_KEY_WORD_BUR) begin
			tmp_rcv_enq_word = 1'b1;
			tmp_key_in = 1'b1;
		end
		else if (opcode == GET_STATUS) begin
			tmp_is_status = 1'b1;
		end
		else if (opcode == ENCRYPT) begin
			tmp_is_encrypt_pulse = 1'b1;
		end
		else if (opcode == DECRYPT) begin
			tmp_is_decrypt_pulse = 1'b1;
		end
	end	
endmodule
