onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_AES_toplevel/tb_test_case_num
add wave -noupdate /tb_AES_toplevel/tb_HCLK
add wave -noupdate /tb_AES_toplevel/tb_HRESETn
add wave -noupdate /tb_AES_toplevel/tb_HSELx
add wave -noupdate /tb_AES_toplevel/tb_HADDR
add wave -noupdate /tb_AES_toplevel/tb_HWDATA
add wave -noupdate -radix ascii /tb_AES_toplevel/tb_HWDATA
add wave -noupdate -radix binary /tb_AES_toplevel/tb_HBURST
add wave -noupdate -radix binary /tb_AES_toplevel/tb_HPROT
add wave -noupdate -radix binary /tb_AES_toplevel/tb_HSIZE
add wave -noupdate -radix binary /tb_AES_toplevel/tb_HTRANS
add wave -noupdate -radix binary /tb_AES_toplevel/tb_HWRITE
add wave -noupdate -divider {OUTPUT SIGNALS}
add wave -noupdate -radix hexadecimal /tb_AES_toplevel/tb_HRDATA
add wave -noupdate -radix ascii /tb_AES_toplevel/tb_HRDATA
add wave -noupdate -radix binary /tb_AES_toplevel/tb_HREADY
add wave -noupdate -radix binary /tb_AES_toplevel/tb_HRESP
add wave -noupdate -divider {128 BIT OUTPUT DATA (Hex)}
add wave -noupdate -radix hexadecimal -childformat {{{/tb_AES_toplevel/tb_data_rcv[3]} -radix hexadecimal} {{/tb_AES_toplevel/tb_data_rcv[2]} -radix hexadecimal} {{/tb_AES_toplevel/tb_data_rcv[1]} -radix hexadecimal} {{/tb_AES_toplevel/tb_data_rcv[0]} -radix hexadecimal}} -expand -subitemconfig {{/tb_AES_toplevel/tb_data_rcv[3]} {-height 17 -radix hexadecimal} {/tb_AES_toplevel/tb_data_rcv[2]} {-height 17 -radix hexadecimal} {/tb_AES_toplevel/tb_data_rcv[1]} {-height 17 -radix hexadecimal} {/tb_AES_toplevel/tb_data_rcv[0]} {-height 17 -radix hexadecimal}} /tb_AES_toplevel/tb_data_rcv
add wave -noupdate -divider {128 BIT OUTPUT DATA (ASCII)}
add wave -noupdate -radix ascii -childformat {{{/tb_AES_toplevel/tb_data_rcv[3]} -radix ascii} {{/tb_AES_toplevel/tb_data_rcv[2]} -radix ascii} {{/tb_AES_toplevel/tb_data_rcv[1]} -radix ascii} {{/tb_AES_toplevel/tb_data_rcv[0]} -radix ascii}} -subitemconfig {{/tb_AES_toplevel/tb_data_rcv[3]} {-height 17 -radix ascii} {/tb_AES_toplevel/tb_data_rcv[2]} {-height 17 -radix ascii} {/tb_AES_toplevel/tb_data_rcv[1]} {-height 17 -radix ascii} {/tb_AES_toplevel/tb_data_rcv[0]} {-height 17 -radix ascii}} /tb_AES_toplevel/tb_data_rcv
add wave -noupdate -divider AES
add wave -noupdate -radix binary /tb_AES_toplevel/DUT/read_fifo
add wave -noupdate -radix binary /tb_AES_toplevel/DUT/AES/data_done
add wave -noupdate -radix hexadecimal /tb_AES_toplevel/DUT/data_in
add wave -noupdate -radix hexadecimal /tb_AES_toplevel/DUT/rcv_fifo_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{DSSC #3} {2022563 ps} 1} {{Write Key} {2042874 ps} 1} {{Read status} {2067767 ps} 1} {{Burst Write Data for Encryption} {2102801 ps} 1} {{End of Burst Write} {2188313 ps} 1} {{Keep Reading Status Reg} {2249038 ps} 1} {{Burst Read Processed Data} {2362863 ps} 1} {{End of Read / Start of Write} {2446934 ps} 1} {{Change to Decryption Mode} {6414924 ps} 1} {{Burst Write Data for Decryption} {6422937 ps} 1} {{Start Burst Read Processed Data} {6671328 ps} 1} {{End of operation} {10718799 ps} 1} {{End of Burst Read} {6758882 ps} 1} {{AES read} {2138199 ps} 1} {{AES output} {2338813 ps} 1}
quietly wave cursor active 13
configure wave -namecolwidth 249
configure wave -valuecolwidth 112
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
WaveRestoreZoom {1840374 ps} {2769142 ps}
