
#XCVR realted cores
set PF_XCVR_ERMver {3.1.200}
set PF_XCVR_REF_CLKver {1.0.103}
set PF_TX_PLLver {2.0.300}

#CCC and osc
set PF_CCCver {2.2.214}
set PF_OSCver {1.0.102}

#other cores
set PF_CLK_DIVver {1.0.103}
set PF_INIT_MONITORver {2.0.304}
set CORERESETver {2.3.100}
set COREFIFOver {3.0.101}
set COREUARTver {5.7.100}

#vault
#add_repository -location {www.actel-ip.com/repositories/in_test}
#change_vault_location -location {/home/APPS_Regression/captures/Vault/}

#tool profiles
set synprofile1 {Synplify Pro ME}
set simuprofile1 {ModelSim ME Pro}


#added for Rev F

#set die {MPF300T}
#set die_eval {MPF300TS}
set die_eval {MPFS025T}
#set die_splash {MPF300TS_ES}
set die_splash {MPF300T}
#set eval_package {FCG1152}
set eval_package {FCVG484}
set splash_package {FCVG484}
set eval_part_range {IND}
set splash_part_range {EXT}
#set splash_part_range {IND}

set die_devkit {RT4G150}
set devkit_package {1657 CG}
set devkit_part_range {MIL}


# A common procedure called by all tests.

# Computes the runtime for each command run in Libero

#

proc run_tool_wrapper { cmd } {

 

  # get tool name from the command

  #

  regexp {run_tool\s+-name\s+\{*(\w*)\}*} $cmd full1 tool;

 

  puts "Starting $tool command";

  set full_cmd "time \{ $cmd \}";

  set TIME_start [clock seconds];
  set runtime [ eval $full_cmd ];
  set TIME_taken [expr [clock seconds] - $TIME_start];
  puts "\nRUNTIME:$tool=$TIME_taken secs\n";
 	

  set runtime_secs [ expr [lindex $runtime 0]/1000000 ];

  puts "\nRUNTIME_bytime:$tool=$runtime_secs secs\n";

 

}

