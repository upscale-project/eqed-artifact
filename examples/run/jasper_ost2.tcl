
analyze -sv09 -f ost2.flist 
elaborate -disable_auto_bbox -top eqed_ost2
clock clk
reset -expression eqed_rst
set_engine_mode {B Bm}
autoprove
