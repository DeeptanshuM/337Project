onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_AES_toplevel/tb_test_case_num
add wave -noupdate /tb_AES_toplevel/tb_HCLK
add wave -noupdate /tb_AES_toplevel/tb_HRESETn
add wave -noupdate /tb_AES_toplevel/tb_HSELx
add wave -noupdate /tb_AES_toplevel/tb_HADDR
add wave -noupdate -radix ascii /tb_AES_toplevel/tb_HWDATA
add wave -noupdate /tb_AES_toplevel/tb_HBURST
add wave -noupdate /tb_AES_toplevel/tb_HPROT
add wave -noupdate /tb_AES_toplevel/tb_HSIZE
add wave -noupdate /tb_AES_toplevel/tb_HTRANS
add wave -noupdate /tb_AES_toplevel/tb_HWRITE
add wave -noupdate /tb_AES_toplevel/tb_HRDATA
add wave -noupdate /tb_AES_toplevel/tb_HREADY
add wave -noupdate /tb_AES_toplevel/tb_HRESP
add wave -noupdate /tb_AES_toplevel/tb_out_data
add wave -noupdate -divider AES
add wave -noupdate /tb_AES_toplevel/DUT/AES/clk
add wave -noupdate /tb_AES_toplevel/DUT/AES/n_rst
add wave -noupdate /tb_AES_toplevel/DUT/AES/read_fifo
add wave -noupdate /tb_AES_toplevel/DUT/AES/is_encrypt
add wave -noupdate /tb_AES_toplevel/DUT/AES/tx_fifo_full
add wave -noupdate /tb_AES_toplevel/DUT/AES/rx_fifo_out
add wave -noupdate /tb_AES_toplevel/DUT/AES/round_key_0
add wave -noupdate /tb_AES_toplevel/DUT/AES/round_key_10
add wave -noupdate /tb_AES_toplevel/DUT/AES/round_key_input
add wave -noupdate /tb_AES_toplevel/DUT/AES/read_addr
add wave -noupdate /tb_AES_toplevel/DUT/AES/tx_fifo_in
add wave -noupdate /tb_AES_toplevel/DUT/AES/data_done
add wave -noupdate /tb_AES_toplevel/DUT/AES/data_valid
add wave -noupdate /tb_AES_toplevel/DUT/AES/enc_round_key_addr
add wave -noupdate /tb_AES_toplevel/DUT/AES/dec_round_key_addr
add wave -noupdate /tb_AES_toplevel/DUT/AES/enc_data_output
add wave -noupdate /tb_AES_toplevel/DUT/AES/dec_data_output
add wave -noupdate /tb_AES_toplevel/DUT/AES/enc_data_done
add wave -noupdate /tb_AES_toplevel/DUT/AES/dec_data_done
add wave -noupdate /tb_AES_toplevel/DUT/AES/enc_data_valid
add wave -noupdate /tb_AES_toplevel/DUT/AES/dec_data_valid
add wave -noupdate -divider MCU
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/generation_done
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/key_in
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/is_decryption_pulse
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/is_encryption_pulse
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/emptyRx
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/fullRx
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/emptyTx
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/fullTx
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/data_done
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/accepted
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/is_encrypt
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/read_fifo
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/rcv_deq
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/trans_enq
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/mcu_key_in
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/status_bits
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/flagKeyGenDone
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/tmp_flagKeyGenDone
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/state
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/nxt_state
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/tmp_status_bits_2
add wave -noupdate /tb_AES_toplevel/DUT/jhfgd/read_fifo_KeyGen
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HCLK
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HRESETn
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HSELx
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HADDR
add wave -noupdate -radix ascii /tb_AES_toplevel/DUT/AHB/HWDATA
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HBURST
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HPROT
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HSIZE
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HTRANS
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HWRITE
add wave -noupdate /tb_AES_toplevel/DUT/AHB/status
add wave -noupdate /tb_AES_toplevel/DUT/AHB/data_in
add wave -noupdate /tb_AES_toplevel/DUT/AHB/tx_enq
add wave -noupdate /tb_AES_toplevel/DUT/AHB/rcv_deq
add wave -noupdate /tb_AES_toplevel/DUT/AHB/fix_error
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HRDATA
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HREADY
add wave -noupdate /tb_AES_toplevel/DUT/AHB/HRESP
add wave -noupdate /tb_AES_toplevel/DUT/AHB/is_encrypt_pulse
add wave -noupdate /tb_AES_toplevel/DUT/AHB/is_decrypt_pulse
add wave -noupdate /tb_AES_toplevel/DUT/AHB/key_in
add wave -noupdate -radix ascii /tb_AES_toplevel/DUT/AHB/rcv_fifo_out
add wave -noupdate /tb_AES_toplevel/DUT/AHB/tx_fifo_full
add wave -noupdate /tb_AES_toplevel/DUT/AHB/tx_fifo_empty
add wave -noupdate /tb_AES_toplevel/DUT/AHB/rcv_fifo_full
add wave -noupdate /tb_AES_toplevel/DUT/AHB/rcv_fifo_empty
add wave -noupdate /tb_AES_toplevel/DUT/AHB/framing_error
add wave -noupdate /tb_AES_toplevel/DUT/AHB/data_out
add wave -noupdate /tb_AES_toplevel/DUT/AHB/tx_deq_word
add wave -noupdate /tb_AES_toplevel/DUT/AHB/rcv_enq_word
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/clk
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/n_rst
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/HWDATA
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/rcv_deq
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/rcv_enq_word
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/fix_error
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/rcv_fifo_out
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/full
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/empty
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/framing_error
add wave -noupdate -radix unsigned /tb_AES_toplevel/DUT/AHB/RCV_FIFO/tail_side
add wave -noupdate -radix unsigned /tb_AES_toplevel/DUT/AHB/RCV_FIFO/tail_ptr
add wave -noupdate -radix unsigned /tb_AES_toplevel/DUT/AHB/RCV_FIFO/head_ptr
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/sync_clr
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/WE
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/count_en1
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/count_en2
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/tail_tog
add wave -noupdate /tb_AES_toplevel/DUT/AHB/RCV_FIFO/head_tog
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2181120 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 237
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2162122 ps} {2359331 ps}
