#!/bin/csh


set VLIB = $QHOME/modeltech/plat/vlib
set VMAP = $QHOME/modeltech/plat/vmap
set VLOG = $QHOME/modeltech/plat/vlog

mkdir Output_Results

$VLOG small_example.sv -l Output_Results/vlog.rpt

