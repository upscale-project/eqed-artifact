#!/bin/bash
mcu_submodule_num=28
mcu_submodule_names=( addrdp clk drif fbd fbdiwr l2if l2rdmx lndskw rdata rdpctl readdp ucb wdqrf wrdp addrdp_ECC clk_ECC drif_ECC fbd_ECC fbdiwr_ECC l2if_ECC l2rdmx_ECC lndskw_ECC rdata_ECC rdpctl_ECC readdp_ECC ucb_ECC wdqrf_ECC wrdp_ECC )
mcu_submodule_ff_num_max=( 1280 1361 4396 6732 6733 7275 8091 8455 8985 9710 9982 10914 11258 12007 12007 12007 12007 14263 14291 14291 14419 16435 16435 16435 16725 16725 16725 16789 )
for ((i=0;i<$mcu_submodule_num;i=i+1))
do
	if [ $1 -lt ${mcu_submodule_ff_num_max[$i]} ]
	then
		echo ${mcu_submodule_names[$i]}
		break
	fi
done
