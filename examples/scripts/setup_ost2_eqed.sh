#!/bin/bash


// Setup E-QED for OpenSPARC T2
// This script applies the necessary patches to generate the RTL with muxes for FF analysis
// and the top level files for E-QED formal analysis


echo "Copying original OpenSPARC T2 RTL..."
cd ../source
cp -r OST2_orig_rtl/* OST2_rtl_ff/.

echo "Applying patches to add muxes for each FF..."
patch -p0 < add_mux.patch

echo "Creating top level .sv files for each module..."
cd ../scripts
cp ../source/OST2_orig_rtl/cpu/rtl/cpu.v spc_eqed.sv
cp ../source/OST2_orig_rtl/cpu/rtl/cpu.v ccx_eqed.sv
cp ../source/OST2_orig_rtl/cpu/rtl/cpu.v l2c_eqed.sv
cp ../source/OST2_orig_rtl/cpu/rtl/cpu.v mcu_eqed.sv

echo "Applying patches to each .sv file..."
patch -p0 < spc.patch
patch -p0 < ccx.patch
patch -p0 < l2c.patch
patch -p0 < mcu.patch

echo "Done"
