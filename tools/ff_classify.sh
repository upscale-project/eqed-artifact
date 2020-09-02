#!/bin/bash
l2_submodule_num=28
l2_submodule_names=( arb array csr decc dir fb iq mb oq rdma siu tag vuad wb arb_ECC array_ECC csr_ECC decc_ECC dir_ECC fb_ECC iq_ECC mb_ECC oq_ECC rdma_ECC siu_ECC tag_ECC vuad_ECC wb_ECC )
l2_submodule_ff_num_max=( 2359 3493 3967 4192 7332 7976 8663 10694 12108 13948 14468 16226 17207 18369 18464 22442 22442 22602 22602 23722 23722 23722 23722 23722 23722 24282 25659 27019 )
for ((i=0;i<$l2_submodule_num;i=i+1))
do
	if [ $1 -lt ${l2_submodule_ff_num_max[$i]} ]
	then
		echo ${l2_submodule_names[$i]}
		break
	fi
done
