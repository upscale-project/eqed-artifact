#!/bin/bash


# Run script for the E-QED example in the CAV\'17 example
#
# This script applies the necessary patches to:
#             1. Analyzes the two module for Design Block localization
#             2. Generate the RTL with muxes for FF analysis
#             3. Find the list of FF candidates
#             4. Apply NCC (Neighbor Consistency Checking) to reduce the list
#

clear

printf "Press any key to run the E-QED paper example\n"

read RES

printf "Copying original Paper Example RTL...\n"

(set -x;
cp ../source/paper_ex/paper_ex.v .)


# Loop through all modules and check consistency

bug_module=none

for module in dm nm; do

  printf "Patching original Paper Example RTL to setup consistency check for module %s...\n" "$module"

  (set -x; cp paper_ex.v paper_ex.sv;
  patch paper_ex.sv -i patch_files/paper_ex/LDB_"$module".patch)

  printf "\nCheck module %s for consistency\n\n" "$module"

  printf "Press any key to launch JasperGold\n"
  read RES

  (set -x; jaspergold -batch -tcl jasper_paper_ex.tcl)

  printf "\ngrep jgproject/jg.log for cover property paper_ex.C_check_%s\n\n" "$module"

  printf "RESULT: "

  if (grep -o 'The cover property "paper_ex.C_check_'"$module"'" was proven unreachable' jgproject/jg.log); then

    printf "\nConsistency Check for %s: FAILED\n\n" "$module"
    bug_module=$module

  elif (grep -o 'The cover property "paper_ex.C_check_'"$module"'" was covered' jgproject/jg.log); then

      printf "\nConsistency Check for %s: PASSED\n" "$module"

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
  printf "\nThe bug has been localized to module %s\n\n" "$bug_module"
fi

printf "Press any key to update RTL for FF localization\n"
read RES

printf "Patching original Paper Example RTL to add mux for each FF in module %s\n" "$bug_module"

(set -x;
cp paper_ex.v paper_ex.sv;
patch paper_ex.sv -i patch_files/paper_ex/paper_ex_add_mux.patch)  

printf "\nPatching the E-QED decoder controller, MISRs and the E-QED check property\n"

(set -x;
patch paper_ex.sv -i patch_files/paper_ex/FF_search1.patch) 


printf "\nPress any key to start FF localization\n"

read RES

no_more_candidates=0
iteration=1

while [ "$no_more_candidates" = 0 ]; do

  (set -x; jaspergold -batch -tcl jasper_paper_ex.tcl)

  printf "\ngrep jgproject/jg.log for cover property paper_ex.C_check_%s_with_ff\n\n" "$bug_module"

  printf "RESULT: "

  if (grep -o 'The cover property "paper_ex.C_check_'"$bug_module"'_with_ff" was covered' jgproject/jg.log); then

    printf "\nProperty covered: Candidate found!\n\n "
    iteration=$((iteration+1))
    (set -x;
    patch paper_ex.sv -i patch_files/paper_ex/FF_search"$iteration".patch)

  elif (grep -o 'The cover property "paper_ex.C_check_'"$bug_module"'_with_ff" was proven unreachable' jgproject/jg.log); then

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
cat patch_files/paper_ex/all_candidates.txt

printf "Press any key to run Neighbor Consistency Checking (NCC)\n"
read RES

cat patch_files/paper_ex/ncc.txt

#Source the number of traces
source patch_files/paper_ex/ncc_count

printf "\nOutput from NCC\n" > ncc_output

for ncc_i in $(seq 1 $ncc_count); do

  printf "Check trace %s with ncc...\n" "$ncc_i"

  (set -x;
  patch paper_ex.sv -i patch_files/paper_ex/FF_ncc"$ncc_i".patch)

  (set -x;
  jaspergold -batch -tcl jasper_paper_ex.tcl)

  printf "\ngrep jgproject/jg.log for cover property paper_ex.C_check_ncc_%s\n\n" "$ncc_i"

  printf "RESULT: "

  if (grep -o 'The cover property "paper_ex.C_check_ncc_'"$ncc_i"'" was covered' jgproject/jg.log); then

    printf "Trace %s: PASSED NCC\n" "$ncc_i" >> ncc_output

  elif (grep -o 'The cover property "paper_ex.C_check_ncc_'"$ncc_i"'" was proven unreachable' jgproject/jg.log); then

    printf "Trace %s: FAILED NCC\n" "$ncc_i" >> ncc_output

  else

    printf "Error: Unexpected JasperGold output during FF analysis\n"
    printf "Please check jgproject/jg.log\n"
    exit 1

  fi

done

#Print the results from NCC
cat ncc_output

printf "\nExpected NCC Result:\n"

#Print the expected results of NCC
cat patch_files/paper_ex/expected_ncc_result.txt

cat patch_files/paper_ex/final_candidates.txt

printf "E-QED done\n\n"
