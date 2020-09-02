#! /bin/bash
cd /rsghome/esingh/scratch0-esingh/questa/small_tests
export ZI_MPI_EXEC_LOADED=1
usrJobId=0
setsid /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET/user_slave.sh &
usrJobId=$!
echo $usrJobId >> /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET/user_joblist
