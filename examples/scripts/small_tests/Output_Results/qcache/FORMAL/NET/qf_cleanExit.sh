#! /bin/bash
cd /rsghome/esingh/scratch0-esingh/questa/small_tests
touch /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET/qf_cleanExit.LOCK
export ZI_MPI_EXEC_LOADED=1
 /cad/mentor/qformal/linux_x86_64/lib/mpiexec -n 1 /cad/mentor/qformal/linux_x86_64/bin/qverifyfk  -od Output_Results -tool prove -init test.init -rtl_init_values -simulation_semantics -effort unlimited -timeout 2h -import_db Output_Results/formal_compile.db -mode slave -slave_id 5 -force_shutdown -mpiport 'tag#0$port#43349$description#rsg3.stanford.edu$ifname#171.64.74.219$' < /dev/null 
rm -f /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET/qf_cleanExit.LOCK > /dev/null
