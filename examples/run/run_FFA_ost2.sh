#!/bin/bash


# Run script for the E-QED OpenSPARC T2 examples in the CAV'17 paper
#
# This script applies the necessary patches to:
#             1. Generate the RTL with muxes for FF analysis
#             2. Find the list of FF candidates
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

source patch_files/example_"$OST2_EX"/bug_module

if [ "$bug_module" = none ]; then
  printf "\nAll modules passed the Consistency Check\n"
  exit 1
else
  printf "\nThe bug has been localized to module %s\n\n" "$bug_module"
fi

printf "Press any key to update RTL for FF localization\n"
read RES

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

while [ "$no_more_candidates" = 0 ]; do

  (set -x; jaspergold -batch -tcl jasper_ff_ost2.tcl)

  printf "\ngrep jgproject/jg.log for cover property eqed_ost2.C_check_%s_with_ff\n\n" "$bug_module"

  printf "RESULT: "

  if (grep -o 'The cover property "eqed_ost2.C_check_'"$bug_module"'_with_ff" was covered' jgproject/jg.log); then

    printf "\nProperty covered: Candidate found!\n\n "
    iteration=$((iteration+1))
    (set -x;
    patch eqed_ost2.sv -i patch_files/example_"$OST2_EX"/FF_search"$iteration".patch)

  elif (grep -o 'The cover property "eqed_ost2.C_check_'"$bug_module"'_with_ff" was proven unreachable' jgproject/jg.log); then

    no_more_candidates=1
    printf "Property unreachable: No more candidates exist.\n\n"

  else

    printf "Error: Unexpected JasperGold output during FF analysis\n"
    printf "Please check jgproject/jg.log\n"
    exit 1

  fi
done

final=$((iteration-1))

#Print the results of FF analysis
printf "%s FF/Cycle Candidates Found\n" "$final"

#Print the expected results
cat patch_files/example"$OST2_EX"/all_candidates.txt

printf "E-QED FF localization done\n\n"
