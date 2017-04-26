onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/fifo_in
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_key_10
add wave -noupdate -radix binary /tb_aes_decryption/AES_DECRYPTION/round_key_addr
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_key_input
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/data_output
add wave -noupdate -radix binary /tb_aes_decryption/AES_DECRYPTION/round_state_0
add wave -noupdate -radix binary /tb_aes_decryption/AES_DECRYPTION/round_state_1
add wave -noupdate -radix binary /tb_aes_decryption/AES_DECRYPTION/round_state_2_0
add wave -noupdate -radix binary /tb_aes_decryption/AES_DECRYPTION/round_state_2_1
add wave -noupdate -radix binary /tb_aes_decryption/AES_DECRYPTION/round_state_output
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_block_0_0
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_block_0_1
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_block_0_2
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_block_0_3
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_block_1_0
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_block_1_1
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_block_2_0
add wave -noupdate -radix hexadecimal /tb_aes_decryption/AES_DECRYPTION/round_block_2_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 202
configure wave -valuecolwidth 214
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
configure wave -timelineunits ps
update
WaveRestoreZoom {126045 ps} {1889130 ps}
