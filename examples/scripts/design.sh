#!/bin/csh

source OpenSPARCT2.cshrc.linux

set VLIB = $QHOME/modeltech/plat/vlib
set VMAP = $QHOME/modeltech/plat/vmap
set VLOG = $QHOME/modeltech/plat/vlog

echo "Compiling design in " $DV_ROOT

mkdir Output_Results

$VLOG spc_wrapper.v spc_checker_bind.sv spc_checker.sv +define+FORMAL_TOOL +define+NOINITMEM +define+INITIALIZERO -f spc_rtl.flist -f qed.flist -f libs.flist -l Output_Results/vlog.rpt

