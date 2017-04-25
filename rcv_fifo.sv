// $Id: $
// File name:   rcv_fifo.sv
// Created:     4/5/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Receiver fifo module.
//  
module rcv_fifo
(
	input wire clk,
	input wire n_rst,
	input wire [31:0] HWDATA,
	input wire rcv_deq,
	input wire rcv_enq_word,
	input wire fix_error,
	output wire [127:0] rcv_fifo_out,
	output wire full,
	output wire empty, 
	output wire framing_error
);
	wire [1:0] tail_side;
	wire [1:0] tail_ptr;
	wire [1:0] head_ptr;
	wire sync_clr;
	wire WE;
	wire count_en1;	
	wire count_en2;
	wire tail_tog;
	wire head_tog;
/*
	reg [31:0] temp;
	always_ff @(posedge clk) begin
		temp <= HWDATA;
	end
*/	
	rcv_fifo_fsm FSM (
		.clk(clk),
		.n_rst(n_rst),
		.rcv_enq_word(rcv_enq_word),
		.full(full),
		.tail_side(tail_side),
		.fix_error(fix_error),
		.count_en1(count_en1),
		.count_en2(count_en2),
		.sync_clr(sync_clr),
		.WE(WE)
	);

	rcv_counter_tail TAIL_PTR (
		.clk(clk),
		.n_rst(n_rst),
		.count_en2(count_en2),
		.tail_ptr(tail_ptr),
		.tail_tog(tail_tog)
	);

	rcv_counter_head HEAD_PTR (
		.clk(clk),
		.n_rst(n_rst),
		.rcv_deq(rcv_deq),
		.head_ptr(head_ptr),
		.head_tog(head_tog)
	);

	rcv_counter_idx TAIL_IDX (
		.clk(clk),
		.n_rst(n_rst),
		.count_en1(count_en1),
		.sync_clr(sync_clr),
		.tail_side(tail_side)
	);

	rcv_comb_output COMB_OUT (
		.head_ptr(head_ptr),
		.tail_side(tail_side),
		.tail_ptr(tail_ptr),
		.tail_tog(tail_tog),
		.head_tog(head_tog),
		.full(full),
		.empty(empty),
		.framing_error(framing_error)
	);

	rcv_fifo_reg FIFO_REG (
		.clk(clk),
		.tail_ptr(tail_ptr),
		.tail_side(tail_side),
		.head_ptr(head_ptr),
		.HWDATA(HWDATA),
		.WE(WE),
		.rcv_fifo_out(rcv_fifo_out)
	);

endmodule 
