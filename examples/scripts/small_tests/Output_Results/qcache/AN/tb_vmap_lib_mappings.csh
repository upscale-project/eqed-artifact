#!/bin/csh -f


set vlib_exec = "/cad/mentor/qformal/linux_x86_64/modeltech/plat/vlib"
if (! -e $vlib_exec) then
  echo "** ERROR: vlib path '$vlib_exec' does not exist"
  exit 1
endif

set vmap_exec = "/cad/mentor/qformal/linux_x86_64/modeltech/plat/vmap"
if (! -e $vmap_exec) then
  echo "** ERROR: vmap path '$vmap_exec' does not exist"
  exit 1
endif

cp -f /scratch0/esingh/questa/small_tests/Output_Results/qcache/AN/modelsim.ini .

# $vlib_exec /scratch0/esingh/questa/small_tests/./work
if($status == 0) then
  $vmap_exec -modelsimini modelsim.ini work /scratch0/esingh/questa/small_tests/./work
else
  echo "** Error: Library mapping failed. (Command: 'vlib /scratch0/esingh/questa/small_tests/./work')"
endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../std
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini std /cad/mentor/qformal/share/modeltech/linux_x86_64/../std
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../std')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../ieee
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini ieee /cad/mentor/qformal/share/modeltech/linux_x86_64/../ieee
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../ieee')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../vital2000
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini vital2000 /cad/mentor/qformal/share/modeltech/linux_x86_64/../vital2000
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../vital2000')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../verilog
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini verilog /cad/mentor/qformal/share/modeltech/linux_x86_64/../verilog
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../verilog')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../std_developerskit
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini std_developerskit /cad/mentor/qformal/share/modeltech/linux_x86_64/../std_developerskit
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../std_developerskit')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../synopsys
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini synopsys /cad/mentor/qformal/share/modeltech/linux_x86_64/../synopsys
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../synopsys')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../modelsim_lib
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini modelsim_lib /cad/mentor/qformal/share/modeltech/linux_x86_64/../modelsim_lib
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../modelsim_lib')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../sv_std
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini sv_std /cad/mentor/qformal/share/modeltech/linux_x86_64/../sv_std
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../sv_std')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../avm
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini mtiAvm /cad/mentor/qformal/share/modeltech/linux_x86_64/../avm
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../avm')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../rnm
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini mtiRnm /cad/mentor/qformal/share/modeltech/linux_x86_64/../rnm
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../rnm')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../ovm-2.1.2
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini mtiOvm /cad/mentor/qformal/share/modeltech/linux_x86_64/../ovm-2.1.2
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../ovm-2.1.2')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../uvm-1.1d
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini mtiUvm /cad/mentor/qformal/share/modeltech/linux_x86_64/../uvm-1.1d
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../uvm-1.1d')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../upf_lib
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini mtiUPF /cad/mentor/qformal/share/modeltech/linux_x86_64/../upf_lib
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../upf_lib')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../pa_lib
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini mtiPA /cad/mentor/qformal/share/modeltech/linux_x86_64/../pa_lib
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../pa_lib')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../floatfixlib
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini floatfixlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../floatfixlib
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../floatfixlib')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../mc2_lib
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini mc2_lib /cad/mentor/qformal/share/modeltech/linux_x86_64/../mc2_lib
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../mc2_lib')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../osvvm
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini osvvm /cad/mentor/qformal/share/modeltech/linux_x86_64/../osvvm
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../osvvm')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../mgc_ams
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini mgc_ams /cad/mentor/qformal/share/modeltech/linux_x86_64/../mgc_ams
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../mgc_ams')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../ieee_env
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini ieee_env /cad/mentor/qformal/share/modeltech/linux_x86_64/../ieee_env
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../ieee_env')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../infact
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini infact /cad/mentor/qformal/share/modeltech/linux_x86_64/../infact
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../infact')"
# endif
# $vlib_exec /cad/mentor/qformal/share/modeltech/linux_x86_64/../vhdlopt_lib
# if($status == 0) then
#   $vmap_exec -modelsimini modelsim.ini vhdlopt_lib /cad/mentor/qformal/share/modeltech/linux_x86_64/../vhdlopt_lib
# else
#   echo "** Error: Library mapping failed. (Command: 'vlib /cad/mentor/qformal/share/modeltech/linux_x86_64/../vhdlopt_lib')"
# endif
# $vlib_exec /scratch0/esingh/questa/small_tests/.//Output_Results/qcache/AN/zin_vopt_work
if($status == 0) then
  $vmap_exec -modelsimini modelsim.ini z0in_work_ctrl /scratch0/esingh/questa/small_tests/.//Output_Results/qcache/AN/zin_vopt_work
else
  echo "** Error: Library mapping failed. (Command: 'vlib /scratch0/esingh/questa/small_tests/.//Output_Results/qcache/AN/zin_vopt_work')"
endif
