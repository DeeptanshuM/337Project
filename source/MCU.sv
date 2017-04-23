// $Id: $
// File name:   MCU.sv
// Created:     4/16/2017
// Author:      Deeptanshu Malik
// Lab Section: 3
// Version:     1.0  Initial Design Entry
// Description: MCU
module MCU
(
input wire clk,
input wire n_reset,
input wire key_in,
input wire is_decryption_pulse,
input wire is_encryption_pulse,
input wire emptyRx,
input wire fullRx,
input wire emptyTx,
input wire fullTx,
input wire framing_error,
input wire data_done,
input wire accepted,
output wire is_encrypt,
output wire is_decrypt,
output wire read_fifo,
output wire rcv_deq,
output wire fix_error,
output wire trans_enq,
output wire read_fifo_KeyGen,
output reg [4:0] status_bits
);

reg flagKeyGenDone;
wire tmp_flagKeyGenDone;

typedef enum bit [4:0] {
			IDLE,
			get_key,
			decryption,
			encryption,
			get_data,
			fixReceiver,
			updateReceiver,
			didRead,
			enqueueTrans,
			dummy1, dummy2, dummy3
			} 
			stateType;

stateType state;
stateType nxt_state;

always_ff @ (posedge clk, negedge n_reset) begin
if (n_reset == 0) begin
	state <= IDLE;
	flagKeyGenDone <= 0;
end
else
	state <= nxt_state;
	flagKeyGenDone <= tmp_flagKeyGenDone;
end

always_comb
begin: NXT_LOGIC
nxt_state = state;
case(state)
	IDLE: begin
	if(key_in)
		nxt_state = get_key;
	if(is_decryption_pulse)
		nxt_state = decryption;
	if(is_encryption_pulse)
		nxt_state = encryption;
	if(!emptyRx && !framing_error)
		nxt_state = get_data;
	if(data_done)
		nxt_state = enqueueTrans;
	end

	get_key: begin
	nxt_state = dummy1;
	end

	dummy1: begin
	nxt_state = dummy2;
	end

	dummy2: begin
	nxt_state = dummy3;
	end

	dummy3: begin
	nxt_state = IDLE;
	end

	decryption: begin
	nxt_state = IDLE;
	end

	encryption: begin
	nxt_state = IDLE;
	end

	get_data: begin
	if(framing_error)
		nxt_state = fixReceiver;
	else
		nxt_state = didRead;
	end

	fixReceiver: begin
	nxt_state = IDLE;
	end

	didRead: begin
	if(accepted)
	nxt_state = IDLE;
	else
	nxt_state = get_data;
	end
	
	enqueueTrans: begin
		nxt_state = IDLE;
	end
endcase
end

assign tmp_flagKeyGenDone = ((state == dummy3) || flagKeyGenDone);
assign read_fifo_KeyGen= (state == get_key);
assign is_encrypt = (state == encryption);
assign is_decrypt = (state == decryption);
assign read_fifo = (state == get_data);
assign fix_error = (state == fixReceiver);
assign rcv_deq = accepted && (state == didRead);
assign trans_enq = (state == enqueueTrans);

assign status_bits[0] = fullRx;
assign status_bits[1] = !emptyTx;
assign status_bits[2] = is_decrypt;
assign status_bits[3] = is_encrypt;
assign status_bits[4] = flagKeyGenDone;;
endmodule
