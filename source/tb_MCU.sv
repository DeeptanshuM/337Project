// $Id: $
// File name:   MCU.sv
// Created:     4/16/2017
// Author:      Deeptanshu Malik
// Lab Section: 3
// Version:     1.0  Initial Design Entry
// Description: MCU tb
module tb_MCU();

parameter CLK_PERIOD = 5;
integer tb_test_num;

reg tb_clk;
reg tb_n_reset;
reg tb_generation_done;
reg tb_key_in;
reg tb_is_decryption_pulse;
reg tb_is_encryption_pulse;
reg tb_emptyRx;
reg tb_fullRx;
reg tb_emptyTx;
reg tb_fullTx;
reg tb_data_done;
reg tb_accepted;
reg tb_is_encrypt;
reg tb_read_fifo;
reg tb_rcv_deq;
reg tb_trans_enq;
reg tb_mcu_key_in;
reg [3:0] tb_status_bit;

// DUT portmap
MCU djkdfsajkhhjksdajk
(
	.clk(tb_clk),
	.n_reset(tb_n_reset),
	.generation_done(tb_generation_done),
	.key_in(tb_key_in),
	.is_decryption_pulse(tb_is_decryption),
	.is_encryption_pulse(tb_is_encryption),
	.emptyRx(tb_emptyRx),
	.fullRx(tb_fullRx),
	.emptyTx(tb_emptyTx),
	.fullTx(tb_fullTx),
	.data_done(tb_data_done),
	.accepted(tb_accepted),
	.is_encrypt(tb_is_encrypt),
	.read_fifo(tb_read_fifo),
	.rcv_deq(tb_rcv_deq),
	.trans_enq(tb_trans_enq),
	.mcu_key_in(tb_mcu_key_in),
	.status_bits(tb_status_bits)
);

always
begin : CLK_GEN
        tb_clk = 1'b0;
        #(CLK_PERIOD / 2.0);
        tb_clk = 1'b1;
        #(CLK_PERIOD / 2.0);
end

task reset_dut;
begin
        // Activate the design's reset (does not need to be synchronize with clock)
        tb_n_reset = 1'b0;
        // Wait for a couple clock cycles
        @(posedge tb_clk);
        @(posedge tb_clk);
        // Release the reset
        @(negedge tb_clk);
        tb_n_reset = 1'b1;
        // Wait for a while before activating the design
        @(posedge tb_clk);
        @(posedge tb_clk);
end
endtask

task is_status_bits_After_reset;
        begin
                assert if(tb_status_bits == 4'b0100)
                begin
                        $info("Test Case #%0d: Had correct status bits after reset", tb_test_num);
                end else begin
                        $error("Test Case #%0d: Had incorrect status bits after reset", tb_test_num);
                end
        end

initial begin
	//UNO: test after reset
	tb_test_num = tb_test_num + 1;
	reset_dut;
	is_status_bits_After_reset;
end

endmodule
