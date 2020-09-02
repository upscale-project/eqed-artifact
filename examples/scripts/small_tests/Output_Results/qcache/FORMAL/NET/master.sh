#! /bin/bash
cd /rsghome/esingh/scratch0-esingh/questa/small_tests
export ZI_MPI_EXEC_LOADED=1
/cad/mentor/qformal/linux_x86_64/lib/mpiexec -errfile-pattern /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET/master.stderr -n 1 /cad/mentor/qformal/linux_x86_64/bin/qverifyfk -jobs 4 -od Output_Results -tool prove -init test.init -rtl_init_values -simulation_semantics -effort unlimited -timeout 2h -import_db Output_Results/formal_compile.db -netcache /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET -mode master < /dev/null 
