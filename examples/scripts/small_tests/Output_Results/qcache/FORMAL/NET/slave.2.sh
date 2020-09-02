#! /bin/bash
cd /rsghome/esingh/scratch0-esingh/questa/small_tests
export ZI_MPI_EXEC_LOADED=1
trap 'disown $PID ; kill -KILL $PID' TERM INT
/cad/mentor/qformal/linux_x86_64/lib/mpiexec -n 1 /cad/mentor/qformal/linux_x86_64/bin/qverifyfk -od Output_Results -tool prove -init test.init -rtl_init_values -simulation_semantics -effort unlimited -timeout 2h -import_db Output_Results/formal_compile.db -mode slave -slave_id 3 -mpiport 'tag#0$port#43349$description#rsg3.stanford.edu$ifname#171.64.74.219$' < /dev/null &
PID=$!
wait ${PID}
wait ${PID}
if [ "$?" -ne "0" ]; then 
  /cad/mentor/qformal/linux_x86_64/lib/mpiexec -n 1 /cad/mentor/qformal/linux_x86_64/bin/qverifyfk -od Output_Results -tool prove -init test.init -rtl_init_values -simulation_semantics -effort unlimited -timeout 2h -import_db Output_Results/formal_compile.db -mode slave -slave_id 3 -mpiport 'tag#0$port#43349$description#rsg3.stanford.edu$ifname#171.64.74.219$' -monitor < /dev/null
fi
