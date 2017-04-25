# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {rcv_fifo_fsm.sv rcv_counter_tail.sv rcv_counter_head.sv rcv_counter_idx.sv rcv_comb_output.sv rcv_fifo_reg.sv fifo_flex_counter.sv tx_fifo_fsm.sv tx_counter_tail.sv tx_counter_head.sv tx_counter_idx.sv tx_comb_output.sv tx_fifo_reg.sv  tx_fifo.sv rcv_fifo.sv ahb_regs.sv ahb_slave.sv aes_block.sv aes_encryption.sv aes_decryption.sv sub_bytes.sv inv_sub_bytes.sv shift_rows.sv inv_shift_rows.sv s_box_lookup.sv inv_s_box_lookup.sv mix_columns.sv inv_mix_columns.sv mix_columns_byte.sv data_block_select.sv xor_init.sv round_key_adder.sv incriment_state.sv key_generator.sv g_function.sv ahb_fifo_io.sv MCU.sv AES_toplevel.sv}
elaborate AES_toplevel -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW
 create_clock "HCLK" -name "HCLK" -period 5.0

# Step 3: Compile the design
#compile -map_effort high -incremental_mapping
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/AES_toplevel.rep
report_area >> reports/AES_toplevel.rep
report_power -hier >> reports/AES_toplevel.rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/AES_toplevel.v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
