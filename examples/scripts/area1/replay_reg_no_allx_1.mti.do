# Configuration file for check sva check1.reg_no_allx safety
onerror {resume}
proc zi_silent { args } { }
global PathSeparator
if ![info exists PathSeparator] { zi_silent [set PathSeparator "/"] }
zi_silent [set ziOldPathSeparator "$PathSeparator"]
zi_silent [set PathSeparator "/"]
if ![info exists zprefix] { zi_silent [set zprefix {xtest}] }
set zsig "/$zprefix"
append zsig {/clk}
catch {add wave -noupdate -expand -group {Primary Clocks} -radix binary -format Logic "$zsig"}
set zsig "/$zprefix"
append zsig {/check1/clk}
catch {add wave -noupdate -expand -group {Property Signals} -radix binary -format Logic "$zsig"}
WaveRestoreCursors {{Cursor 1} {0 ns} 0} {{Start} {0 ns} 1} {{Firing} {10 ns} 1}
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ns} {30 ns}
zi_silent [set PathSeparator "$ziOldPathSeparator"]
