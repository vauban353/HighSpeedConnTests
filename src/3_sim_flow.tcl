file copy -force "./src/src_stimulus/wave.do" "./$Prjname/simulation/wave.do"

import_files -stimulus "./src/src_stimulus/top.v"
build_design_hierarchy
organize_tool_files -tool {SIM_PRESYNTH} -file ./${Prjname}/stimulus/top.v -module {top::work} -input_type {stimulus}
set_modelsim_options -use_automatic_do_file 1 -sim_runtime $SimTime \
					 -tb_module_name {test_pcs} \
					 -log_all_signals 1 \
					 -include_do_file 1\
					 -disable_pulse_filtering 1 \
					 -resolution {1ps} \
					 -timeunit 1 \
					 -timeunit_base {ns} \
					 -precision 1 \
					 -precision_base {ps}			
					 
catch [run_tool -name {SIM_PRESYNTH}]
save_project
puts "Simulation completed successfully\n"
