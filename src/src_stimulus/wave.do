onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Pattern_Generator
add wave -noupdate /test_pcs/top_0/pattern_gen_0/clk_i
add wave -noupdate /test_pcs/top_0/pattern_gen_0/generate_err_i
add wave -noupdate /test_pcs/top_0/pattern_gen_0/reset_n_i
add wave -noupdate /test_pcs/top_0/pattern_gen_0/data_out_o
add wave -noupdate /test_pcs/top_0/pattern_gen_0/Tx_K_Char_o
add wave -noupdate -divider XCVR_CLOCKS_RESETS
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_PCS_ARST_N
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_PMA_ARST_N
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/TX_BIT_CLK_0
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/TX_PLL_LOCK_0
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/TX_PLL_REF_CLK_0
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_CDR_REF_CLK_0
add wave -noupdate -divider XCVR_TX_SIDE
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_TX_CLK_STABLE
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_TX_CLK_R
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_TX_DISPFNC
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_8B10B_TX_K
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_TX_DATA
add wave -noupdate -divider XCVR_RX_SIDE
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_RX_IDLE
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_RX_READY
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_RX_VAL
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_RX_CODE_VIOLATION
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_RX_DISPARITY_ERROR
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_8B10B_RX_K
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_RX_CLK_R
add wave -noupdate /test_pcs/top_0/PF_XCVR_0_0/LANE0_RX_DATA
add wave -noupdate -divider Pattern_Checker
add wave -noupdate /test_pcs/top_0/pattern_chk_0/clk_i
add wave -noupdate /test_pcs/top_0/pattern_chk_0/reset_n_i
add wave -noupdate /test_pcs/top_0/pattern_chk_0/start_i
add wave -noupdate /test_pcs/top_0/pattern_chk_0/clear_i
add wave -noupdate /test_pcs/top_0/pattern_chk_0/rx_val_i
add wave -noupdate /test_pcs/top_0/pattern_chk_0/rx_val_o
add wave -noupdate /test_pcs/top_0/pattern_chk_0/Rx_K_Char_i
add wave -noupdate /test_pcs/top_0/pattern_chk_0/data_in_i
add wave -noupdate /test_pcs/top_0/pattern_chk_0/error_count_o
add wave -noupdate /test_pcs/top_0/pattern_chk_0/error_o
add wave -noupdate /test_pcs/top_0/pattern_chk_0/lock_o
add wave -noupdate /test_pcs/top_0/UART_INTERFACE_0/start
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {368000 ps} 0} {{Cursor 2} {30035590 ps} 0} {{Cursor 3} {30202988 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 376
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {1371500 ps} {3107932 ps}
