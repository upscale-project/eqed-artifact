

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

The final candidates are:

FF 6 at cycle 4
FF 3 at cycle 3

Note that during the initial FF analysis, FF 3 is also a candidate in another 
trace. This additional level of aliasing is due to the relatively simple example shown
as well as the small size of the MISRs. In the CAV'17 paper, we observed that one of 
parameters for the MISR was the number of MISR bits per input signal. From our emperical 
analysis, we selected this value to be 8 and 4. Within this example, it is much smaller 
at 3 and 2 respectively at the input and output of the module dm, in order to make the
example easier to follow. For larger, more complex designs and larger MISRs like the 
OpenSPARC T2, we observed that it is practically impossible for the same FF to appear as
a single bit error candidate in multiple traces while still satifying the same final 
signature. 




