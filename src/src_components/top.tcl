# Creating SmartDesign top
set sd_name {top}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_RXD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REF_CLK_PAD_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE0_TXD_P} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LANE_ARST_N} -port_direction {OUT}

sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_0_IN} -port_direction {IN} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_1_IN} -port_direction {IN} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_2_IN} -port_direction {IN} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_3_IN} -port_direction {IN} 
sd_create_scalar_port -sd_name {top} -port_name {VIO_ENABLE_IN} -port_direction {IN} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_OUT} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_0_LED} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_1_LED} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_2_LED} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_MODE_3_LED} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {VIO_ENABLE_LED} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {VIO_ENABLE} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {LED7} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_REF_CLK} -port_direction {OUT} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_REF_CLK_PAD_P} -port_direction {IN} 
sd_create_scalar_port -sd_name {top} -port_name {TEST_REF_CLK_PAD_N} -port_direction {IN} 


# Add DFN1_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_0}



# Add DFN1_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_1}



# Add DFN1_2 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_2}



# Add DFN1_3 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_3}



# Add INIT_component_0 instance
sd_instantiate_component -sd_name {top} -component_name {PFSOC_INIT_MONITOR_C0} -instance_name {}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:PCIE_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:USRAM_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:SRAM_INIT_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:USRAM_INIT_FROM_SNVM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:USRAM_INIT_FROM_UPROM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:USRAM_INIT_FROM_SPI_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:SRAM_INIT_FROM_SNVM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:SRAM_INIT_FROM_UPROM_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:SRAM_INIT_FROM_SPI_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PFSOC_INIT_MONITOR_C0_0:AUTOCALIB_DONE}



# Add pattern_chk_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pattern_chk} -hdl_file {hdl\pattern_chk.v} -instance_name {pattern_chk_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {pattern_chk_0:RESET_EN} -value {VCC}



# Add pattern_gen_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {pattern_gen} -hdl_file {hdl\pattern_gen.v} -instance_name {pattern_gen_0}



# Add PF_CLK_DIV_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_CLK_DIV_C0} -instance_name {PF_CLK_DIV_C0_0}



# Add PF_OSC_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_OSC_0} -instance_name {PF_OSC_0_0}



# Add PF_TX_PLL_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_TX_PLL_0} -instance_name {PF_TX_PLL_0_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_TX_PLL_0_0:PLL_LOCK}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_TX_PLL_0_0:CLK_125}



# Add PF_XCVR_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_0} -instance_name {PF_XCVR_0_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE0_RX_IDLE}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE0_LOS} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_XCVR_0_0:LANE0_TX_DISPFNC} -value {GND}



# Add PF_XCVR_REF_CLK_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_XCVR_REF_CLK_0} -instance_name {PF_XCVR_REF_CLK_0_0}



# Add Reset_Block_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {Reset_Block} -instance_name {Reset_Block_0}

# Add test reference Clock
create_and_configure_core -core_vlnv {Actel:SgCore:PF_XCVR_REF_CLK:1.0.103} -component_name {PF_XCVR_TEST_REF_CLK_C0} -params {"ENABLE_FAB_CLK_0:true" "ENABLE_FAB_CLK_1:false" "ENABLE_REF_CLK_0:true" "ENABLE_REF_CLK_1:false" "REF_CLK_MODE_0:DIFFERENTIAL" "REF_CLK_MODE_1:LVCMOS"} 
sd_instantiate_component -sd_name {top} -component_name {PF_XCVR_TEST_REF_CLK_C0} -instance_name {} 
#sd_connect_pin_to_port -sd_name {top} -pin_name {PF_XCVR_TEST_REF_CLK_C0_0:REF_CLK} -port_name {} 
#sd_rename_port -sd_name {top} -current_port_name {REF_CLK} -new_port_name {TEST_REF_CLK} 
sd_mark_pins_unused -sd_name {top} -pin_names {PF_XCVR_TEST_REF_CLK_C0_0:REF_CLK} 
sd_connect_pins -sd_name {top} -pin_names {"PF_XCVR_TEST_REF_CLK_C0_0:REF_CLK_PAD_P" "TEST_REF_CLK_PAD_P"} 
sd_connect_pins -sd_name {top} -pin_names {"PF_XCVR_TEST_REF_CLK_C0_0:REF_CLK_PAD_N" "TEST_REF_CLK_PAD_N"} 
# sd_connect_pins -sd_name {top} -pin_names {"LED7" "PF_XCVR_TEST_REF_CLK_C0_0:REF_CLK"} 

create_and_configure_core -core_vlnv {Actel:SgCore:PF_CLK_DIV:1.0.103} -component_name {PF_CLK_DIV_C1} -params {"DIVIDER:5" "ENABLE_BIT_SLIP:false" "ENABLE_SRESET:false"} 
sd_instantiate_component -sd_name {top} -component_name {PF_CLK_DIV_C1} -instance_name {} 
sd_connect_pins -sd_name {top} -pin_names {"PF_CLK_DIV_C1_0:CLK_IN" "PF_XCVR_TEST_REF_CLK_C0_0:FAB_REF_CLK"} 
sd_connect_pins -sd_name {top} -pin_names {"LED7" "PF_CLK_DIV_C1_0:CLK_OUT" "TEST_REF_CLK"} 

# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0:CLK" "DFN1_1:CLK" "DFN1_2:CLK" "DFN1_3:CLK" "PF_XCVR_0_0:LANE0_RX_CLK_R" "Reset_Block_0:RX_clk" "pattern_chk_0:clk_i" }


sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0:D" "DFN1_3:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0:Q" "pattern_chk_0:start_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_1:Q" "DFN1_2:D" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_2:Q" "pattern_chk_0:clear_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PFSOC_INIT_MONITOR_C0_0:DEVICE_INIT_DONE" "Reset_Block_0:INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PFSOC_INIT_MONITOR_C0_0:FABRIC_POR_N" "Reset_Block_0:FPGA_POR_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PFSOC_INIT_MONITOR_C0_0:XCVR_INIT_DONE" "PF_XCVR_0_0:CTRL_ARST_N" "PF_XCVR_0_0:LANE0_PCS_ARST_N" "PF_XCVR_0_0:LANE0_PMA_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_N" "PF_XCVR_0_0:LANE0_RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_RXD_P" "PF_XCVR_0_0:LANE0_RXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_N" "PF_XCVR_0_0:LANE0_TXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE0_TXD_P" "PF_XCVR_0_0:LANE0_TXD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LANE_ARST_N" "pattern_chk_0:LANE_ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CLK_DIV_C0_0:CLK_IN" "PF_OSC_0_0:RCOSC_160MHZ_GL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_CLK_DIV_C0_0:CLK_OUT" "PF_XCVR_0_0:CTRL_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_TX_PLL_0_0:REF_CLK" "PF_XCVR_0_0:LANE0_CDR_REF_CLK_0" "PF_XCVR_REF_CLK_0_0:REF_CLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_READY" "Reset_Block_0:RX_ready" "pattern_chk_0:RX_READY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_VAL" "pattern_chk_0:rx_val_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_TX_CLK_R" "Reset_Block_0:TX_clk" "pattern_gen_0:clk_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_TX_CLK_STABLE" "Reset_Block_0:TX_clk_stable" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_REF_CLK_0_0:REF_CLK_PAD_N" "REF_CLK_PAD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_REF_CLK_0_0:REF_CLK_PAD_P" "REF_CLK_PAD_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Reset_Block_0:Pattern_chk_rst_n" "pattern_chk_0:ARST_N" "pattern_chk_0:reset_n_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Reset_Block_0:Pattern_gen_rst_n" "pattern_gen_0:reset_n_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"pattern_chk_0:generate_err" "pattern_gen_0:generate_err_i" }



sd_connect_pins -sd_name {top} -pin_names {"TEST_MODE_0_IN" "TEST_MODE_0_LED" "TEST_MODE_OUT"} 
sd_connect_pins -sd_name {top} -pin_names {"TEST_MODE_1_IN" "TEST_MODE_1_LED"} 
sd_connect_pins -sd_name {top} -pin_names {"TEST_MODE_2_IN" "TEST_MODE_2_LED"} 
sd_connect_pins -sd_name {top} -pin_names {"TEST_MODE_3_IN" "TEST_MODE_3_LED"} 

sd_instantiate_macro -sd_name {top} -macro_name {AND2} -instance_name {AND2_0} 
sd_connect_pins -sd_name {top} -pin_names {"AND2_0:Y" "VIO_ENABLE_LED" "VIO_ENABLE"} 
sd_connect_pins -sd_name {top} -pin_names {"AND2_0:A" "VIO_ENABLE_IN"} 
sd_connect_pins -sd_name {top} -pin_names {"AND2_0:B" "Reset_Block_0:Pattern_gen_rst_n"} 


# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_8B10B_RX_K" "pattern_chk_0:Rx_K_Char_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_8B10B_TX_K" "pattern_gen_0:Tx_K_Char_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_CODE_VIOLATION" "pattern_chk_0:LCV_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_DATA" "pattern_chk_0:data_in_i" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_RX_DISPARITY_ERROR" "pattern_chk_0:DISP_ERR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_XCVR_0_0:LANE0_TX_DATA" "pattern_gen_0:data_out_o" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_TX_PLL_0_0:CLKS_TO_XCVR" "PF_XCVR_0_0:CLKS_FROM_TXPLL_0" }


sd_create_scalar_port -sd_name {top} -port_name {START} -port_direction {IN} 
sd_create_scalar_port -sd_name {top} -port_name {CLEAR} -port_direction {IN} 
sd_connect_pins -sd_name {top} -pin_names {"DFN1_3:D" "START" "Reset_Block_0:Start"} 
sd_connect_pins -sd_name {top} -pin_names {"CLEAR" "DFN1_1:D"} 
sd_connect_pin_to_port -sd_name {top} -pin_name {pattern_chk_0:error_o} -port_name {} 
sd_connect_pin_to_port -sd_name {top} -pin_name {pattern_chk_0:rx_val_o} -port_name {} 
sd_connect_pin_to_port -sd_name {top} -pin_name {pattern_chk_0:lock_o} -port_name {} 
#sd_connect_pin_to_port -sd_name {top} -pin_name {pattern_chk_0:error_count_o} -port_name {} 

sd_connect_pins_to_constant -sd_name {top} -pin_names {Reset_Block_0:BANK_x_VDDI_STATUS} -value {VCC} 
sd_connect_pins_to_constant -sd_name {top} -pin_names {Reset_Block_0:BANK_y_VDDI_STATUS} -value {VCC} 


sd_connect_pin_to_port -sd_name {top} -pin_name {pattern_chk_0:generate_err} -port_name {} 

sd_mark_pins_unused -sd_name {top} -pin_names {pattern_chk_0:error_count_o}

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign top
generate_component -component_name ${sd_name}
