#!/bin/bash


# Run script for the E-QED OpenSPARC T2 examples in the CAV'17 paper
#
# This script applies the necessary patches to:
#             1. Analyzes the modules for Design Block localization
#             2. Generate the RTL with muxes for FF analysis
#             3. Find the list of FF candidates
#             4. Apply NCC (Neighbor Consistency Checking) to reduce the list
#

clear

# Export global variable for OST2 file references
export DV_ROOT=$(cd ../source/OST2_orig_rtl; pwd)

printf "Please enter the E-QED OpenSPARC T2 example to run\n\n"

read -r OST2_EX

printf "Copying original OpenSPARC T2 top-level RTL...\n\n"

(set -x;
cp ../source/OST2_orig_rtl/design/sys/iop/cpu/rtl/cpu.v .)

printf "Patch original OpenSPARC T2 top-level RTL to prepare for formal analysis...\n\n"

(set -x; cp cpu.v eqed_ost2.sv;
patch eqed_ost2.sv -i patch_files/ost2/reduce_design.patch)

printf "...add Signature Blocks...\n\n"

(set -x; patch eqed_ost2.sv -i patch_files/ost2/add_sb.patch)

# Loop through all modules and check consistency

bug_module=none

# for module in spc0 spc1 spc2 spc3 spc4 spc5 spc6 spc7 ccx l2c0 l2c1 l2c2 l2c3 l2c4 l2c5 l2c6 l2c7 mcu0 mcu1 mcu2 mcu3; do
for module in l2c0 ccx mcu0; do

  printf "Patching original OpenSPARC T2 RTL to setup consistency check for module %s...\n" "$module"

  (set -x; patch eqed_ost2.sv -i patch_files/example_"$OST2_EX"/LDB_"$module".patch)

#  printf "\nCheck module %s for consistency\n\n" "$module"

#  printf "JasperGold will start in 5 seconds\n"
#  sleep 5s

#  (set -x; jaspergold -batch -tcl jasper_ost2_"$module".tcl)

#  printf "\ngrep jgproject/jg.log for cover property eqed_ost2.C_check_%s\n\n" "$module"

#  printf "RESULT: "

#  if (grep -o 'The cover property "eqed_ost2.C_check_'"$module"'" was proven unreachable' jgproject/jg.log); then

#    printf "\nConsistency Check for %s: FAILED\n" "$module"
#    printf "\nConsistency Check for %s: FAILED\n" "$module" >> LDM_result.txt
#    bug_module=$module

#  elif (grep -o 'The cover property "eqed_ost2.C_check_'"$module"'" was covered' jgproject/jg.log); then

#    printf "\nConsistency Check for %s: PASSED\n" "$module"
#    printf "\nConsistency Check for %s: PASSED\n" "$module" >> LDM_result.txt

#  else

#    printf "\nERROR: Unexpected JasperGold Output during Consistency Check\n"
#    printf "Please check jgproject/jg.log\n"
#    exit 1

#  fi

done


#if [ "$bug_module" = none ]; then
#  printf "\nAll modules passed the Consistency Check\n"
#  exit 1
#else
#  cat LDM_result.txt
#  printf "\nThe bug has been localized to module %s\n\n" "$bug_module"
#fi

#printf "Press any key to update RTL for FF localization\n"
#read RES

printf "Patching original OpenSPARC T2 RTL to add mux for each FF\n"

(set -x;
cp cl_rtl_ext.v cl_rtl_ext.v.with_mux;
patch cl_rtl_ext.v.with_mux patch_files/ost2/add_mux.patch)  


printf "\nPatching the E-QED decoder controller, MISRs and the E-QED check property\n"

(set -x;
patch eqed_ost2.sv -i patch_files/example_"$OST2_EX"/FF_search1.patch) 


printf "\nPress any key to start FF localization\n"

read RES

no_more_candidates=0
iteration=1

while [ "$iteration" != 21 ]; do

#  (set -x; jaspergold -batch -tcl jasper_ff_ost2.tcl)

#  printf "\ngrep jgproject/jg.log for cover property eqed_ost2.C_check_%s_with_ff\n\n" "$bug_module"

#  printf "RESULT: "

#  if (grep -o 'The cover property "eqed_ost2.C_check_'"$bug_module"'_with_ff" was covered' jgproject/jg.log); then

#    printf "\nProperty covered: Candidate found!\n\n "
    iteration=$((iteration+1))
    (set -x;
    patch eqed_ost2.sv -i patch_files/example_"$OST2_EX"/FF_search"$iteration".patch)

#  elif (grep -o 'The cover property "eqed_ost2.C_check_'"$bug_module"'_with_ff" was proven unreachable' jgproject/jg.log); then

#    no_more_candidates=1
#    printf "Property unreachable: No more candidates exist.\n\n"

#  else

#    printf "Error: Unexpected JasperGold output during FF analysis\n"
#    printf "Please check jgproject/jg.log\n"
#    exit 1

#  fi
done

printf "E-QED done\n\n"
