# Define clocks
netlist clock gclk spc.lb.frl1clk spc.lb.l1clk_pm1  -period 10 -waveform {0 5}

netlist constant cluster_arst_l 1'b1
netlist constant scan_in 1'b0
#netlist cosntant tcu_pce_ov   = 1'b0;
netlist constant tcu_clk_stop 1'b0
netlist constant tcu_spc_aclk 1'b0             
netlist constant tcu_spc_bclk 1'b0             
netlist constant tcu_dectest 1'b1              
netlist constant tcu_muxtest 1'b1              
netlist constant tcu_spc_scan_en 1'b0          
netlist constant tcu_spc_array_wr_inhibit 1'b0 
netlist constant tcu_spc_se_scancollar_in 1'b0 
netlist constant tcu_spc_se_scancollar_out 1'b0
netlist constant tcu_atpg_mode 1'b0            
netlist constant rst_wmr_protect 1'b0
netlist constant tcu_spc_shscan_pce_ov   1'b0 
netlist constant tcu_spc_shscan_clk_stop 1'b0
netlist constant tcu_spc_shscan_aclk     1'b0
netlist constant tcu_spc_shscan_bclk     1'b0
netlist constant tcu_spc_shscan_scan_in  1'b0
netlist constant tcu_spc_shscan_scan_en  1'b0
netlist constant tcu_spc_shscanid        3'b000
netlist constant tcu_spc_mbist_scan_in  1'b0
netlist constant tcu_mbist_bisi_en      1'b0    
netlist constant tcu_spc_mbist_start    1'b0  
netlist constant tcu_mbist_user_mode    1'b0
netlist constant const_cpuid  3'b000  
netlist constant tcu_ss_mode  1'b0
netlist constant tcu_do_mode  1'b0
netlist constant tcu_ss_request  1'b0
netlist constant tcu_spc_lbist_start    1'b0
netlist constant tcu_spc_lbist_scan_in  1'b0
netlist constant tcu_spc_lbist_pgm      1'b0
netlist constant tcu_spc_test_mode      1'b0
# netlist constant cpx_spc_data_cx  {146{1'b0}}

# netlist constant rst 1'b0
# Constrain rst
#formal netlist constraint rst 1'b0 
# formal netlist constraint cluster_arst_l 1'b1

# cut at instruction
# netlist cutpoint spc.dec.ifu_buf0_inst0
