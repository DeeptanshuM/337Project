// $Id: $
// File name:   theWrapperFile.sv
// Created:     4/23/2017
// Author:      Deeptanshu Malik
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: top level wrapper file


module theWrapperFile
(
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

output reg  [31:0]  HRDATA,
output wire         HREADY,
output wire [ 1:0]  HRESP,

);

wire [127:0]  data_in;
wire 	    tx_enq;
wire 	    rcv_deq;
wire          fix_error;
wire         is_encrypt_pulse;
wire         is_decrypt_pulse;
wire         key_in;
wire [127:0] rcv_fifo_out;
wire         tx_fifo_full;
wire         tx_fifo_empty;
wire         rcv_fifo_full;
wire         rcv_fifo_empty;
wire         framing_error;
reg [4:0] status_bits;
reg read_fifo, is_encrypt, data_done,data_valid;
wire [127:0] rx_fifo_out,round_key_0,round_key_input;
reg [4:0]   read_addr, status_bits;


ahb_fifo_io AHB (
.HCLK(HCLK),
.HRESETn(HRESETn),
.HSELx(HSELx),
.HADDR(HADDR),
.HWDATA(HWDATA),
.HBURST(HBURST),
.HPROT(HPROT),
.HSIZE(HSIZE),
.HTRANS(HTRANS),
.HWRITE(HWRITE),
.status(status_bits),
.data_in(data_in),
.tx_enq(tx_enq),
.rcv_deq(rcv_deq),
.fix_error(fix_error),
.HRDATA(HRDATA),
.HREADY(HREADY),
.HRESP(HRESP),
.is_encrypt_pulse(is_encrypt_pulse),
.is_decrypt_pulse(is_decrypt_pulse),
.key_in(key_in),
.rcv_fifo_out(rcv_fifo_out),
.tx_fifo_full(tx_fifo_full),
.tx_fifo_empty(tx_fifo_empty),
.rcv_fifo_full(rcv_fifo_full),
.rcv_fifo_empty(rcv_fifo_empty),
.framing_error(framing_error)
);

MCU jhfgd
(
.clk(HCLK),
.n_reset(HRESETn),
.key_in(key_in),
.is_decryption_pulse(is_decrypt_pulse),
.is_encryption_pulse(is_encrypt_pulse),
.emptyRx(rcv_fifo_empty),
.fullRx(rcv_fifo_full),
.emptyTx(tx_fifo_empty),
.fullTx(tx_fifo_full),
.data_done(data_done),
.accepted(data_valid),
.is_encrypt(is_encrypt_pulse),
.is_decrypt(is_decrypt_pulse),
.read_fifo(read_fifo),
.rcv_deq(rcv_deq),
.trans_enq(tx_enq),
.status_bits(status_bits)
)

aes_block AES
(
.clk(HCLK),
.n_reset(HRESETn),
.read_fifo(read_fifo),
.is_encrypt(is_encrypt_pulse),
.is_decrypt(is_decrypt_pulse),
.tx_fifo_full(tx_fifo_full),
.rx_fifo_out(rcv_fifo_out),
.round_key_0(round_key_0),
.round_key_input(round_key_input),
.read_addr(read_addr),
.tx_fifo_in(data_in),
.data_done(data_done),
.data_valid(data_valid)
);

key_generator KEYGEN
(
.clk(HCLK),
.n_reset(HRESETn),
.read_addr(read_addr),
.WE_key_generation(read_fifo_KeyGen),
.original_key(rcv_fifo_out),
.round_key_0(round_key_0),
.round_key_x(round_key_input),
//output reg generation_done
);

endmodule
