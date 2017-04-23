// $Id: $
// File name:   ahb_slave.sv
// Created:     4/18/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Implementation of ahb slave interface.
module ahb_slave (
	input wire          HCLK,
	input wire          HRESETn,
	input wire          HSELx,
	input wire  [31:0]  HADDR,
	input wire  [ 2:0]  HBURST,
	input wire  [ 3:0]  HPROT,
	input wire  [ 2:0]  HSIZE,
	input wire  [ 1:0]  HTRANS,
	input wire  [31:0]  HWDATA,
	input wire          HWRITE,
	input wire  [31:0]  data_out,
	input wire  [ 4:0]  status,
	input wire          rcv_fifo_full,
	input wire          rcv_fifo_empty,
	input wire          tx_fifo_empty,
	output reg  [31:0]  HRDATA,
	output wire         HREADY,
	output wire [ 1:0]  HRESP,
	output wire         rcv_enq_word,
	output wire         tx_deq_word,
	output wire         is_encrypt_pulse,
	output wire         is_decrypt_pulse,
	output wire         key_in
);
	reg [31:0] status_padded;
	reg is_status;

	always_comb begin
		HRDATA = data_out;
		if (is_status) begin
			HRDATA = status_padded;
		end
	end

	always_ff @(posedge HCLK, negedge HRESETn) begin 
		if (HRESETn == 0) begin
			status_padded = '0;
		end
		else begin
			status_padded = {27'b0, status};
		end
	end

	ahb_regs REGS (
		.HCLK(HCLK),
		.HRESETn(HRESETn),
		.HSELx(HSELx),
		.HADDR(HADDR),
		.HPROT(HPROT),
		.HBURST(HBURST),
		.HSIZE(HSIZE),
		.HWRITE(HWRITE),
		.HTRANS(HTRANS),
		.rcv_fifo_full(rcv_fifo_full),
		.rcv_fifo_empty(rcv_fifo_empty),
		.tx_fifo_empty(tx_fifo_empty),
		.rcv_enq_word(rcv_enq_word),
		.tx_deq_word(tx_deq_word),
		.is_encrypt_pulse(is_encrypt_pulse),
		.is_decrypt_pulse(is_decrypt_pulse),
		.key_in(key_in),
		.is_status(is_status),
		.HREADY(HREADY),
		.HRESP(HRESP)
	);
endmodule
