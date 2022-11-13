# Creating SmartDesign UART_INTERFACE
set sd_name {UART_INTERFACE}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {clk} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {reset} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rx_error} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rx_lock} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {rx_val} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {TX} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {clear} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {connect_o} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {genrate_err} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {start} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {error_count} -port_direction {IN} -port_range {[31:0]}


# Add COREUART_0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {COREUART_0} -instance_name {COREUART_0_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {COREUART_0_0:BIT8} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {COREUART_0_0:CSN} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {COREUART_0_0:ODD_N_EVEN} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {COREUART_0_0:OVERFLOW}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {COREUART_0_0:PARITY_EN} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {COREUART_0_0:PARITY_ERR}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {COREUART_0_0:FRAMING_ERR}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {COREUART_0_0:BAUD_VAL} -value {0001100101100}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {COREUART_0_0:BAUD_VAL_FRACTION} -value {110}



# Add FabUART_0 instance
sd_instantiate_hdl_module -sd_name ${sd_name} -hdl_module_name {FabUART} -hdl_file {hdl\FabUART.v} -instance_name {FabUART_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {FabUART_0:switch}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {FabUART_0:timer_switch}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:CLK" "FabUART_0:clk" "clk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:OEN" "FabUART_0:uart_oen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:RESET_N" "FabUART_0:reset" "reset" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:RX" "RX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:RXRDY" "FabUART_0:uart_rxrdy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:TX" "TX" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:TXRDY" "FabUART_0:uart_txrdy" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:WEN" "FabUART_0:uart_wen" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FabUART_0:clear" "clear" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FabUART_0:connect_o" "connect_o" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FabUART_0:genrate_err" "genrate_err" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FabUART_0:rx_error" "rx_error" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FabUART_0:rx_lock" "rx_lock" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FabUART_0:rx_val" "rx_val" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FabUART_0:start" "start" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:DATA_IN" "FabUART_0:uart_data_out" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREUART_0_0:DATA_OUT" "FabUART_0:uart_data_in" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FabUART_0:error_count" "error_count" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign UART_INTERFACE
generate_component -component_name ${sd_name}
