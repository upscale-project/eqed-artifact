#!/bin/bash
ccx_submodule_num=8
ccx_submodule_names=( clk cpx pcx tst clk_ECC cpx_ECC pcx_ECC tst_ECC )
ccx_submodule_ff_num_max=( 52 21052 40861 41181 41181 41181 41181 41181 )
for ((i=0;i<$ccx_submodule_num;i=i+1))
do
	if [ $1 -lt ${ccx_submodule_ff_num_max[$i]} ]
	then
		echo ${ccx_submodule_names[$i]}
		break
	fi
done
