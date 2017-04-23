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
input wire  [ 7:0]  status,
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
output wire         framing_error,
output reg [4:0] status_bits
);

//input wire 	      clk,n_rst,read_fifo,is_encrypt,tx_fifo_full,
//input wire [127:0] rx_fifo_out,round_key_0,round_key_input,
//output reg [4:0]   read_addr,
//output reg 	      tx_fifo_in,data_done,data_valid
reg read_fifo, is_encrypt, data_done,data_valid,

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
.status(status),
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
.framing_error(),     ///?????????
.data_done(data_done),
.accepted(data_valid),
.is_encrypt(is_encrypt_pulse),
.is_decrypt(is_decrypt_pulse),
.read_fifo(read_fifo),
.rcv_deq(), ////????
.fix_error(), ///???
.trans_enq(), ////????
.status_bits() /////????
)

aes_block AES
(
.clk(HCLK),
.n_reset(HRESETn),
.read_fifo(read_fifo),
.is_encrypt(is_encrypt_pulse),
.is_decrypt(is_decrypt_pulse),
.tx_fifo_full(tx_fifo_full),
input wire [127:0] rx_fifo_out,round_key_0,round_key_input, ///???????
output reg [4:0]   read_addr,  ////??????
output reg 	      tx_fifo_in,  /////>?
.data_done(data_done),
.data_valid(data_valid)
);

endmodule
