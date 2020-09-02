#! /bin/bash
cd /rsghome/esingh/scratch0-esingh/questa/small_tests
touch /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET/qf_killJobs.LOCK
for j in "24836 24845 24857 24865"
  do
  kill -s TERM  $j
  done
usrJobList=`cat /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET/user_joblist`
for j in "${usrJobList[@]}"
  do
    if [ "$j" != "" ] 
    then
      kill -s TERM  $j
    fi 
  done
rm -f /scratch0/esingh/questa/small_tests/Output_Results/qcache/FORMAL/NET/qf_killJobs.LOCK > /dev/null
