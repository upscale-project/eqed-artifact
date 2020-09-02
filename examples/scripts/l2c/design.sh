#!/bin/csh

source OpenSPARCT2.cshrc.linux

set VLIB = $QHOME/modeltech/plat/vlib
set VMAP = $QHOME/modeltech/plat/vmap
set VLOG = $QHOME/modeltech/plat/vlog

echo "Compiling design in " $DV_ROOT

mkdir Output_Results

$VLOG l2c_wrapper_2.v l2c_checker2.sv +define+FORMAL_TOOL +define+NOINITMEM +define+INITIALIZERO -f l2t.flist -f l2t_rtl.flist -f l2b.flist -f l2b_rtl.flist -f libs.flist -l Output_Results/vlog.rpt

