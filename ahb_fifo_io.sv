// $Id: $
// File name:   ahb_fifo_io.sv
// Created:     4/20/2017
// Author:      Natat Sombuntham
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Top level module for AHB slave module, receiver fifo, and transmittor fifo.
module ahb_fifo_io (
	input wire          HCLK,
	input wire          HRESETn,
	input wire          HSELx,
	input wire  [31:0]  HADDR,
	input wire  [31:0]  HWDATA,
	input wire  [ 2:0]  HBURST,
	input wire  [ 3:0]  HPROT,
	input wire  [ 2:0]  HSIZE,
	input wire  [ 1:0]  HTRANS,
	input wire          HWRITE,
	input wire  [ 3:0]  status,
	input wire [127:0]  data_in,
	input wire 	    tx_enq,
	input wire 	    rcv_deq,
	input wire          fix_error,
	output reg  [31:0]  HRDATA,
	output wire         HREADY,
	output wire [ 1:0]  HRESP,
	output wire         is_encrypt_pulse,
	output wire         is_decrypt_pulse,
	output wire         key_in,
	output wire [127:0] rcv_fifo_out,
	output wire         tx_fifo_full,
	output wire         tx_fifo_empty,
	output wire         rcv_fifo_full,
	output wire         rcv_fifo_empty,
	output wire         framing_error
);
	reg [31:0] data_out;
	reg tx_deq_word;
	reg rcv_enq_word;

	ahb_slave AHB_SLAVE (
		.HCLK(HCLK),
		.HRESETn(HRESETn),
		.HSELx(HSELx),
		.HADDR(HADDR),
		.HBURST(HBURST),
		.HPROT(HPROT),
		.HSIZE(HSIZE),
		.HTRANS(HTRANS),
		.HWDATA(HWDATA),
		.HWRITE(HWRITE),
		.data_out(data_out),
		.status(status),
		.rcv_fifo_full(rcv_fifo_full),
		.rcv_fifo_empty(rcv_fifo_empty),
		.tx_fifo_empty(tx_fifo_empty),
		.HRDATA(HRDATA),
		.HREADY(HREADY),
		.HRESP(HRESP),
		.rcv_enq_word(rcv_enq_word),
		.tx_deq_word(tx_deq_word),
		.is_encrypt_pulse(is_encrypt_pulse),
		.is_decrypt_pulse(is_decrypt_pulse),
		.key_in(key_in)
	);

	rcv_fifo RCV_FIFO (
		.clk(HCLK),
		.n_rst(HRESETn),
		.HWDATA(HWDATA),
		.rcv_deq(rcv_deq),
		.rcv_enq_word(rcv_enq_word),
		.fix_error(fix_error),
		.rcv_fifo_out(rcv_fifo_out),
		.full(rcv_fifo_full),
		.empty(rcv_fifo_empty),
		.framing_error(framing_error)
	);

	tx_fifo TX_FIFO (
		.clk(HCLK),
		.n_rst(HRESETn),
		.data_in(data_in),
		.tx_enq(tx_enq),
		.tx_deq_word(tx_deq_word),
		.full(tx_fifo_full),
		.empty(tx_fifo_empty),
		.tx_fifo_out(data_out)
	);

endmodule
