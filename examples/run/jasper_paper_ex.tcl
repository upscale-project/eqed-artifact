
analyze -sv09 -f paper_ex.flist 
elaborate -disable_auto_bbox -top paper_ex
clock clk
reset -expression rst 
set_engine_mode {B Bm}
autoprove
