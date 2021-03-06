// $Id: $
// File name:   MCU.sv
// Created:     4/16/2017
// Author:      Deeptanshu Malik
// Lab Section: 3
// Version:     1.0  Initial Design Entry
// Description: MCU tb
`timescale 1ns / 10ps
module tb_MCU();

   parameter CLK_PERIOD = 5;
   integer tb_test_num;

   reg 	   tb_clk;
   reg 	   tb_n_reset;
   reg 	   tb_generation_done;
   reg 	   tb_key_in;
   reg 	   tb_is_decryption_pulse;
   reg 	   tb_is_encryption_pulse;
   reg 	   tb_emptyRx;
   reg 	   tb_fullRx;
   reg 	   tb_emptyTx;
   reg 	   tb_fullTx;
   reg 	   tb_data_done;
   reg 	   tb_accepted;
   reg 	   tb_is_encrypt;
   reg 	   tb_read_fifo;
   reg 	   tb_rcv_deq;
   reg 	   tb_trans_enq;
   reg 	   tb_mcu_key_in;
   reg [3:0] tb_status_bits;

   // DUT portmap
   MCU djkdfsajkhhjksdajk
     (
      //input
      .clk(tb_clk),
      .n_reset(tb_n_reset),
      .generation_done(tb_generation_done),
      .key_in(tb_key_in),
      .is_decryption_pulse(tb_is_decryption_pulse),
      .is_encryption_pulse(tb_is_encryption_pulse),
      .emptyRx(tb_emptyRx),
      .fullRx(tb_fullRx),
      .emptyTx(tb_emptyTx),
      .fullTx(tb_fullTx),
      .data_done(tb_data_done),
      .accepted(tb_accepted),
      //output
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

   initial begin
      tb_generation_done = 0;
      tb_key_in = 0;
      tb_is_decryption_pulse = 0;
      tb_is_encryption_pulse = 1;
      tb_emptyRx = 1;
      tb_fullRx = 0;
      tb_emptyTx = 0;
      tb_fullTx = 0;
      tb_data_done = 0;
      tb_accepted = 0;
      
      //reset
      @(posedge tb_clk);
      reset_dut;
      @(posedge tb_clk);
      //assert (tb_is_encrypt == 1)
      //        begin
      //                $info("Test Case #%0d: Passed: default is_encrypt value is correct", tb_test_num);
      //        end else begin
      //                $error("Test Case #%0d: Failed: default is_encrypt value is not correct", tb_test_num);
      //        end
      @(posedge tb_clk);

      //assert key_in
      tb_key_in = 1;
      @(posedge tb_clk);
      tb_key_in = 0;
      @(posedge tb_clk);
      @(posedge tb_clk);
      tb_generation_done = 1;
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);

      //when receiver fifo is not empty
      tb_emptyRx = 0;
      @(posedge tb_clk);
      tb_emptyRx = 1;

      //when AES is ready to accept data
      #10;
      tb_accepted = 1;
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      tb_accepted = 0;
      
      
   end

endmodule
