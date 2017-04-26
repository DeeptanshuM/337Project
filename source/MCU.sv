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
input wire generation_done,
input wire key_in,
input wire is_decryption_pulse,
input wire is_encryption_pulse,
input wire emptyRx,
input wire fullRx,
input wire emptyTx,
input wire fullTx,
input wire data_done,
input wire accepted,
output wire is_encrypt,
output wire read_fifo,
output wire rcv_deq,
output wire trans_enq,
output wire mcu_key_in,
output reg [3:0] status_bits
);

reg flagKeyGenDone;
wire tmp_flagKeyGenDone;

typedef enum bit [4:0] {
			IDLE,
			get_key,
			get_data,
			updateReceiver,
			didRead,
			enqueueTrans,
			dummy1, dummy2, dummy3
			} 
			stateType;

stateType state;
stateType nxt_state;
wire tmp_status_bits_2;
assign tmp_status_bits_2 = (is_encryption_pulse ? 1'b1 : (is_decryption_pulse ? 1'b0 : status_bits[2]));

always_ff @ (posedge clk, negedge n_reset) begin
  if (n_reset == 0) begin
	state <= IDLE;
	flagKeyGenDone <= 0;
	status_bits <= 4'b0100;
  end
  else begin
	state <= nxt_state;
	flagKeyGenDone <= tmp_flagKeyGenDone;
	//status_bits <= {flagKeyGenDone, is_encrypt, is_decrypt, !emptyTx, fullRx};
	status_bits[0] <= fullRx;
        status_bits[1] <= !emptyTx;
	status_bits[2] <= tmp_status_bits_2;
        status_bits[3] <= flagKeyGenDone;
  end
end

always_comb
begin: NXT_LOGIC
nxt_state = state;
case(state)
	IDLE: begin
	if(key_in)
		nxt_state = get_key;
	if(!emptyRx)
		nxt_state = get_data;
	//if(data_done)
	//	nxt_state = enqueueTrans;
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
	if (generation_done) begin
		nxt_state = IDLE;
	end
	end

	get_data: begin
	//nxt_state = didRead;
	if(!accepted)
	nxt_state = didRead;
	else
	nxt_state = get_data;
	end

	didRead: begin
	nxt_state = IDLE;
	end
	
	enqueueTrans: begin
		nxt_state = IDLE;
	end
endcase
end

assign tmp_flagKeyGenDone = ((state == dummy3) || flagKeyGenDone);
assign read_fifo_KeyGen = (state == get_key);
assign is_encrypt = status_bits[2];
assign read_fifo = (state == get_data);
assign rcv_deq = ((state == didRead) || (state == get_key));
assign trans_enq = data_done;
assign mcu_key_in = (state == get_key); 

endmodule
