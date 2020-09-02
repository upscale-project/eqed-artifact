# Configuration file for check sva spc.exu0.irf.irf_array.chk0.cover_bug_active safety
onerror {resume}
proc zi_silent { args } { }
global PathSeparator
if ![info exists PathSeparator] { zi_silent [set PathSeparator "/"] }
zi_silent [set ziOldPathSeparator "$PathSeparator"]
zi_silent [set PathSeparator "/"]
if ![info exists zprefix] { zi_silent [set zprefix {spc_wrapper}] }
set zsig "/$zprefix"
append zsig {/gclk}
catch {add wave -noupdate -expand -group {Primary Clocks} -radix binary -format Logic "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/lb/frl1clk}
catch {add wave -noupdate -expand -group {Primary Clocks} -radix binary -format Logic "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/lb/l1clk_pm1}
catch {add wave -noupdate -expand -group {Primary Clocks} -radix binary -format Logic "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/dec/bug_active}
catch {add wave -noupdate -expand -group {Property Signals} -radix binary -format Logic "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/exu0/irf/irf_array/chk0/clk}
catch {add wave -noupdate -expand -group {Property Signals} -radix binary -format Logic "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/exu0/ect/i_byp_lth/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/dec/inst_history}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix binary -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/fgu/fac/fx4_00/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/fgu/fac/fx5_00/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/fgu/fac/fb_00/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/exu0/irf/i_wr_control_ff/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/lsu/dcc/dff_dec_inst1_m/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/fgu/fdc/cntl_lth/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/lsu/lmc/dff_thrd_byp_sel_m/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/lsu/dcc/dff_dec_inst_b/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/fgu/fdc/stall_lth/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/exu0/ect/i_mbist_lth/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/mb2/out_wr_mb_arrays_reg/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/lsu/dcc/dff_l2fill_b/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix binary -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/lsu/dcc/dff_ld_vld_w/d0_0/q}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix binary -format Literal "$zsig"}
set zsig "/$zprefix"
append zsig {/spc/dec/valid0_reg}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix binary -format Logic "$zsig"}
set zsig "/$zprefix"
append zsig {/rst}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix binary -format Logic "$zsig"}
set zsig "/$zprefix"
append zsig {/qed_inst0}
catch {add wave -noupdate -expand -group {Control Point Signals} -radix hexadecimal -format Literal "$zsig"}
WaveRestoreCursors {{Cursor 1} {0 ps} 0} {{Start} {0 ps} 1} {{Firing} {40 ps} 1}
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {50 ps}
zi_silent [set PathSeparator "$ziOldPathSeparator"]
