# Import source files
import_files -hdl_source {./src/src_hdl/pattern_chk.v}
import_files -hdl_source {./src/src_hdl/pattern_gen.v}

build_design_hierarchy 

# Create, configure and generate core components
source ./src/src_components/INIT_MONITOR.tcl
source ./src/src_components/PF_CLK_DIV_C0.tcl
source ./src/src_components/PF_OSC_0.tcl
source ./src/src_components/PF_TX_PLL_0.tcl
source ./src/src_components/PF_XCVR_0.tcl
source ./src/src_components/PF_XCVR_REF_CLK_0.tcl
source ./src/src_components/Reset_sync_rx.tcl
source ./src/src_components/Reset_sync_tx.tcl


# Generate SmartDesign Components
source ./src/src_components/Reset_Block.tcl
build_design_hierarchy 
build_design_hierarchy 
source ./src/src_components/top.tcl

# Set top level module
build_design_hierarchy 
set_root -module {top::work} 

save_project
puts "Design generated successfully\n"
