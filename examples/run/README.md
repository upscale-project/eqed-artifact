

-------------------------------------------------------------------------------

# eqed-artifact/examples/run

This directory is the run area for the E-QED examples.

There are two main scripts:

1) run_paper_ex.sh : Run E-QED on the small example detailed in
                     the CAV'17 paper.

2) run_ost2.sh     : Run E-QED on the OpenSPARC T2 SoC to generate 
                     results from the CAV'17 paper.

The scripts and their dependencies are detailed further below.

In order to run these scripts, please ensure that a version of Cadence
Jaspergold is setup. These examples were tested with Jaspergold v16.09.002 

-------------------------------------------------------------------------------

--- run_paper_ex.sh ---

This script applies E-QED to the small verilog RTL example found at:
   /examples/source/paper_ex/paper_ex.v

The script updates the RTL with a sequence of patch files, found at:
   /examples/run/patch_files/paper_ex

Each iteration of Jaspergold uses the TCL script found at:
   /examples/run/jasper_paper_ex.tcl





