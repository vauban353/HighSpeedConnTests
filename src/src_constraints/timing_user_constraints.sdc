#set_clock_groups constraints added between Tx, Rx Recovered clock of tranceiver and 40 MHz oscillator clock
set_clock_groups -name {asyn1} -asynchronous -group [ get_clocks { PF_XCVR_0_0/I_XCVR/LANE0/RX_CLK_R } ] -group [ get_clocks { PF_XCVR_0_0/I_XCVR/LANE0/TX_CLK_R } ] -group [ get_clocks {PF_CLK_DIV_C0_0/PF_CLK_DIV_C0_0/I_CD/Y_DIV} ]
