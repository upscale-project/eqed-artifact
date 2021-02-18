#!/bin/bash


# Run script for the E-QED example in the CAV\'17 example
#
# This script applies the necessary patches to:
#             1. Analyzes the two module for Design Block localization
#             2. Generate the RTL with muxes for FF analysis
#             3. Find the list of FF candidates
#             4. Apply NCC (Neighbor Consistency Checking) to reduce the list
#


echo "Press any key to run the E-QED paper example
"
read RES

echo "Copying original Paper Example RTL...
"

(set -x;
cp ../source/paper_ex/paper_ex.v .)

echo "Patching original Paper Example RTL to setup consistency check for module dm...
"

(set -x;
cp paper_ex.v paper_ex.sv;
patch paper_ex.sv -i patch_files/paper_ex/LDB_dm.patch)

echo "
Check module dm for consistency
"

echo "Press any key to launch JasperGold
"
read RES

(set -x;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property unreachable
"
echo "Consistency Check for dm: FAILED
"

echo "Press any key to continue to module nm
"
read RES

echo "Patching original Paper Example RTL to setup consistency check for module nm...
"
(set -x;
cp paper_ex.v paper_ex.sv;
patch paper_ex.sv -i patch_files/paper_ex/LDB_nm.patch) 


echo "Check module nm for consistency
"
(set -x;
jaspergold -batch -tcl jasper_paper_ex.tcl) 

echo "
Property covered
"
echo "Consistency Check for nm: PASSED 
"

echo "
The bug has been localized to module dm
"
echo "Press any key to update RTL for FF localization
"
read RES

echo "Patching original Paper Example RTL to add mux for each FF in module dm...
"

(set -x;
cp paper_ex.v paper_ex.sv;
patch paper_ex.sv -i patch_files/paper_ex/paper_ex_add_mux.patch)  


echo "Patching the E-QED decoder controller, MISRs and the E-QED check property
"

(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_search1.patch) 


echo "Press any key to start FF localization
"
read RES

echo "Search for FF candidate to satisfy signature consistency...
"
(set -x;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property covered
"
echo "Add FF 6, Cycle 4 to candidates
"

echo "Search for next candidate...
"
(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_search2.patch;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property covered
"
echo "Add FF 7, Cycle 2 to candidates
"

echo "Search for next candidate...
"
(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_search3.patch;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property covered
"
echo "Add FF 3, Cycle 3 to candidates
"
echo "Search for next candidate...
"
(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_search4.patch;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property covered
"
echo "Add FF 4, Cycle 1 to candidates
"
echo "Search for next candidate...
"
(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_search5.patch;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property covered
"
echo "Add FF 3, Cycle 1 to candidates
"
echo "Search for next candidate...
"
(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_search6.patch;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property unreachable
"
echo "No more candidates exist.
"
echo "4 FF candidates found: 
FF 6 (Cycle 4), FF 7 (Cycle 2), FF 3 (Cycle 3,1), FF 4 (Cycle 1)

3 traces found

Note FF 3 is a candidate in two traces. 
See README in /examples/run/ for additional details.
"

echo "Press any key to run Neighbor Consistency Checking (NCC)
"
read RES

echo "Adding nm, the neighboring module and update check for NCC
"
(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_ncc1.patch) 


echo "Check trace 1 with NCC...
"
(set -x;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property covered
"
echo "Trace 1: PASSED NCC
"
echo "Update and check trace 2 with NCC...
"
(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_ncc2.patch;
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property unreachble
"
echo "Trace 2: FAILED NCC
"

echo "
Update and check trace 3 with NCC...
"
(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_ncc3.patch; 
jaspergold -batch -tcl jasper_paper_ex.tcl)


echo "
Property unreachble
"
echo "
Trace 3: FAILED NCC
"

echo "Final Candidates:
FF 6 (Cycle 4)
FF 3 (Cycle 3)
"


echo "E-QED done"
