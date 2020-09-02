netlist clock cmp_gclk_c2_ccx_left -period 300 -waveform {0 150}
netlist clock cmp_gclk_c2_ccx_right -period 300 -waveform {0 150}
###formal netlist constraint rst 1’b0
###assertion compile exclude -name dut.P6
###netlist blackbox pci_ctrl

