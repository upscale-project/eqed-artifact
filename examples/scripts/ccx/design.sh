#!/bin/csh

source OpenSPARCT2.cshrc.linux

set VLIB = $QHOME/modeltech/plat/vlib
set VMAP = $QHOME/modeltech/plat/vmap
set VLOG = $QHOME/modeltech/plat/vlog

echo "Compiling design in " $DV_ROOT

mkdir Output_Results

$VLOG +define+FORMAL_TOOL +define+NOINITMEM +define+INITIALIZERO ccx_wrapper.sv  -f $DV_ROOT/design/sys/iop/ccx/ccx_rtl.flist -f libs.flist -l Output_Results/vlog.rpt

