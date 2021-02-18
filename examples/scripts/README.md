Run scripts for E-QED

1) Setup the OpenSPARC T2 RTL SVA files
setup_sa_ost2_eqed.sh

2) Run signature consistency checks
run_cc.sh
   Options: -ex (example) <number>
   
3) Modify the OpenSPARC T2 RTL for FF analysis
setup_ff_ost2_eqed.sh

4) Run single error flip-flop analysis
run_fa.sh
   Options: -ex (example) <number>

5) Run neighbor consistency check
run_ncc.sh
   Options: -ex (example) <number>
