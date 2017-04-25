onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/fifo_in
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_key_input
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_key_0
add wave -noupdate /tb_aes_encryption/AES_ENCRYPTION/round_key_addr
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/data_output
add wave -noupdate /tb_aes_encryption/AES_ENCRYPTION/clk
add wave -noupdate /tb_aes_encryption/AES_ENCRYPTION/n_rst
add wave -noupdate /tb_aes_encryption/AES_ENCRYPTION/read_fifo
add wave -noupdate /tb_aes_encryption/AES_ENCRYPTION/is_full
add wave -noupdate /tb_aes_encryption/AES_ENCRYPTION/data_done
add wave -noupdate /tb_aes_encryption/AES_ENCRYPTION/data_valid
add wave -noupdate -radix binary /tb_aes_encryption/AES_ENCRYPTION/round_state_output
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_block_0_0
add wave -noupdate -radix binary /tb_aes_encryption/AES_ENCRYPTION/round_state_0
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_block_0_1
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_block_0_2
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_block_1_0
add wave -noupdate -radix binary /tb_aes_encryption/AES_ENCRYPTION/round_state_1
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_block_1_1
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_block_1_2
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_block_2_0
add wave -noupdate -radix binary /tb_aes_encryption/AES_ENCRYPTION/round_state_2_0
add wave -noupdate -radix hexadecimal /tb_aes_encryption/AES_ENCRYPTION/round_block_2_1
add wave -noupdate -radix binary /tb_aes_encryption/AES_ENCRYPTION/round_state_2_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {517500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 168
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
WaveRestoreZoom {512989 ps} {666355 ps}
