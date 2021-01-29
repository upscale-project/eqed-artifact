#!/bin/bash


// Setup E-QED for OpenSPARC T2
// This script applies the necessary patches to generate the RTL with muxes for FF analysis


echo "Copying original OpenSPARC T2 RTL..."
cd ../source
cp -r OST2_orig_rtl/* OST2_rtl_ff/.

echo "Applying patches to add muxes for each FF..."
patch -p0 < add_mux.patch

echo "Done"
