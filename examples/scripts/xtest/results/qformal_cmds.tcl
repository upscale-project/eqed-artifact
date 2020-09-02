# do directives.tcl
netlist clock clk -period 5 -waveform 0 2.5
# end do directives.tcl
formal compile -d counter_tb
formal verify -effort high
