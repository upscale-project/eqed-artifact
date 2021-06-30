#!/bin/bash


# Run script for the E-QED OpenSPARC T2 examples in the CAV'17 paper
#
# This script applies the necessary patches to analyze the modules for 
# Design Block localization
#

clear

# Export global variable for OST2 file references
export DV_ROOT=$(cd ../source/OST2_orig_rtl; pwd)

#printf "Please enter the E-QED OpenSPARC T2 example to run\n\n"

OST2_EX=3

printf "\nDesign Module Localization Results for Example 3\n" "$OST2_EX" > LDM_result.txt

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

for module in mcu0; do

  printf "Patching original OpenSPARC T2 RTL to setup consistency check for module %s...\n" "$module"

  (set -x; patch eqed_ost2.sv -i patch_files/example_"$OST2_EX"/LDB_"$module".patch)

  printf "\nCheck module %s for consistency\n\n" "$module"

  printf "JasperGold will start in 5 seconds\n"
  sleep 5s

  (set -x; jaspergold -batch -tcl jasper_ost2_"$module".tcl)

  printf "\ngrep jgproject/jg.log for cover property eqed_ost2.C_check_%s\n\n" "$module"

  printf "RESULT: "

  if (grep -o 'The cover property "eqed_ost2.C_check_'"$module"'" was proven unreachable' jgproject/jg.log); then

    printf "\nConsistency Check for %s: FAILED\n" "$module"
    printf "\nConsistency Check for %s: FAILED\n" "$module" >> LDM_result.txt
    bug_module=$module

  elif (grep -o 'The cover property "eqed_ost2.C_check_'"$module"'" was covered' jgproject/jg.log); then

    printf "\nConsistency Check for %s: PASSED\n" "$module"
    printf "\nConsistency Check for %s: PASSED\n" "$module" >> LDM_result.txt

  else

    printf "\nERROR: Unexpected JasperGold Output during Consistency Check\n"
    printf "Please check jgproject/jg.log\n"
    exit 1

  fi

done


if [ "$bug_module" = none ]; then
  printf "\nAll modules passed the Consistency Check\n"
  exit 1
else
  cat LDM_result.txt
  printf "\nThe bug has been localized to module %s\n\n" "$bug_module"
fi

printf "E-QED Localization to Design Module done\n\n"
