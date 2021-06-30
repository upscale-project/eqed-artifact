clear -all
analyze -sv09 -f ost2.flist 
elaborate -disable_auto_bbox -top eqed_ost2
clock clk -both_edges
reset -init_state reset.init
set_engine_mode {B Bm}
autoprove -effort high
