import sys
import os
import stat

fp = open(sys.argv[1],"r")

def pre_filter(x): 
	for n in x:
		if(n.find("spare")>=0):
			return True
		if(n.find("msff1")>=0):
			if("mac_a" in x or "mac_b" in x or "mac_c" in x):
				return True
	return False
	
def filter_tst(x): 
	names1 =["tstgr", "tstgl"]
	return x[1] in names1
	
def filter_pcx(x): 
	names1 =["pcx"]
	return x[1] in names1
	
def filter_cpx(x): 
	names1 =["cpx"]
	return x[1] in names1

def filter_clk(x): 
	names1 =["clk_ccx"]
	return x[1] in names1
	
def filter_excluded(x):	
	return False
	
def classify_ff(s):
	if(pre_filter(s)): return "excluded"
	
	if(filter_tst(s)): 
		if(is_ECC_protected(s)): return "tst_ECC"
		else: return "tst"
	elif(filter_pcx(s)): 
		if(is_ECC_protected(s)): return "pcx_ECC"
		else: return "pcx"
	elif(filter_cpx(s)): 
		if(is_ECC_protected(s)): return "cpx_ECC"
		else: return "cpx"
	elif(filter_clk(s)): 
		if(is_ECC_protected(s)): return "clk_ECC"
		else: return "clk"
	elif(filter_excluded(s)): return "excluded"
	else : 
		print s
		return ""
	
ffcs = {"tst":[],"pcx":[],"cpx":[],"clk":[]
		,"tst_ECC":[],"pcx_ECC":[],"cpx_ECC":[],"clk_ECC":[]
		,"excluded":[]}

comparison_ignore_list = [
	#["l2t","arbadr","ff_arbdp_addr_c12","d0_0","q"],				#Error reporting
]

comparison_ignore_list_array = [
	#["l2d","ctr","j3"],
	["ccx","cpx","cpx_dpa","cpx_dps7","cpx_mac8"],
	["ccx","cpx","cpx_dpa","cpx_dps6","cpx_mac8"],
	["ccx","cpx","cpx_dpa","cpx_dps5","cpx_mac8"],
	["ccx","cpx","cpx_dpa","cpx_dps4","cpx_mac8"],
	["ccx","cpx","cpx_dpa","cpx_dps3","cpx_mac8"],
	["ccx","cpx","cpx_dpa","cpx_dps2","cpx_mac8"],
	["ccx","cpx","cpx_dpa","cpx_dps1","cpx_mac8"],
	["ccx","cpx","cpx_dpa","cpx_dps0","cpx_mac8"],
	["ccx","pcx","pcx_dpa","pcx_dps8"],
]

conditional_comparison_list = [
	#[["l2t","evctag","ff_mcu_read_addr","d0_0","q"],["l2t","l2t_mcu_rd_req"],"1'b1"],
]

conditional_comparison_list_inv = [
	[["ccx","pcx","pcx_arbr8","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr8","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl8","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl8","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbr7","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr7","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl7","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl7","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbr6","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr6","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl6","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl6","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbr5","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr5","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl5","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl5","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbr4","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr4","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl4","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl4","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbr3","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr3","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl3","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl3","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbr2","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr2","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl2","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl2","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbr1","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr1","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl1","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl1","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbr0","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbr0","arc","fifo_empty_a"],"1'b1"],
	[["ccx","pcx","pcx_arbl0","arc","dff_rptr","d0_0","q"],["ccx","pcx","pcx_arbl0","arc","fifo_empty_a"],"1'b1"],
	
	[["ccx","cpx","cpx_arbr7","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbr7","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbl7","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbl7","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbr6","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbr6","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbl6","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbl6","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbr5","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbr5","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbl5","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbl5","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbr4","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbr4","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbl4","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbl4","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbr3","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbr3","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbl3","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbl3","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbr2","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbr2","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbl2","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbl2","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbr1","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbr1","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbl1","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbl1","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbr0","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbr0","arc","fifo_empty_a"],"1'b1"],
	[["ccx","cpx","cpx_arbl0","arc","dff_rptr","d0_0","q"],["ccx","cpx","cpx_arbl0","arc","fifo_empty_a"],"1'b1"],
	
	

#	[["l2t","misbuf","ff_misbuf_filbuf_fbid_0123","d0_0","q"],["l2t","misbuf","way_fbid_vld[3:0]"],"4'b0000"],	
]
	
conditional_comparison_list_task_variable = [
#	[["ccx","pcx","pcx_arbr8","ard","i_dff_fmem0","c0_0","l1en"],"ard_valid_mask_pcxr8[0]","1'b1"],
#	[["ccx","pcx","pcx_arbr8","ard","i_dff_fmem0","d0_0","q"],"ard_valid_mask_pcxr8[0]","1'b1"],

#	[["l2t","oqu","ff_oq0_out","d0_0","q"],"oqu_valid_mask[0]","1'b1"],	
]

conditional_comparison_list_one_hot = [
#	[["l2t","filbuf","ff_l2_rd_state","d0_0","q"],4],			#Only fill buf location change. do we need to refect this in simics?
]

def needs_special_comparison_rule(s):
	for name in comparison_ignore_list:		
		if s[0:len(name)-2] == name[0:len(name)-2]:
			return True
	for name in comparison_ignore_list_array:		
		if s[0:len(name)] == name[0:len(name)]:
			return True
	for condition in conditional_comparison_list:	
		name = condition[0]
		if s[0:len(name)-2] == name[0:len(name)-2]:
			return True
	for condition in conditional_comparison_list_inv:	
		name = condition[0]
		if s[0:len(name)-2] == name[0:len(name)-2]:
			return True	
	for condition in conditional_comparison_list_task_variable:	
		name = condition[0]
		if s[0:len(name)-2] == name[0:len(name)-2]:
			return True
	for condition in conditional_comparison_list_one_hot:	
		name = condition[0]
		if s[0:len(name)-2] == name[0:len(name)-2]:
			return True
	if s[0] == "ccx" and (s[1] == "pcx" or s[1] == "cpx") and (s[2].startswith("pcx_arb") or s[2].startswith("cpx_arb")) and s[3] == "ard" and s[4].startswith("i_dff_fmem"):
		return True #ARD	
	return False

def is_ECC_protected(s):
	return False

	
def addIgnoredComparisons(fc):
	for name in comparison_ignore_list:
		name2 = ".".join(name[1:])
		fc.write("if(tb_top.cpu."+name[0]+"."+name2+" != tb_top.cpu.noerror_"+name[0]+"."+name2+") begin\r\n")
		fc.write("	$display(\"pending FF error ignored : tb_top.cpu."+name[0]+"."+name2+"\");\r\n")	
		fc.write("end \r\n")
		
def addConditionalComparisons(fc):
	for condition in conditional_comparison_list:
		name = condition[0]		
		name2 = ".".join(name[1:])
		comparison_signal = condition[1]
		comparison_signal2 = ".".join(comparison_signal[1:])
		comparison_value = condition[2]
		fc.write("if(tb_top.cpu."+name[0]+"."+name2+" != tb_top.cpu.noerror_"+name[0]+"."+name2+") begin\r\n")
		fc.write("	if(tb_top.cpu."+comparison_signal[0]+"."+comparison_signal2+" == "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+"."+name2+" while tb_top.cpu."+comparison_signal[0]+"."+comparison_signal2+" == "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+"."+name2+" while tb_top.cpu."+comparison_signal[0]+"."+comparison_signal2+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");
		
def addConditionalComparisonsInv(fc):
	for condition in conditional_comparison_list_inv:
		name = condition[0]		
		name2 = ".".join(name[1:])
		comparison_signal = condition[1]
		comparison_signal2 = ".".join(comparison_signal[1:])
		comparison_value = condition[2]
		fc.write("if(tb_top.cpu."+name[0]+"."+name2+" != tb_top.cpu.noerror_"+name[0]+"."+name2+") begin\r\n")
		fc.write("	if(tb_top.cpu."+comparison_signal[0]+"."+comparison_signal2+" != "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+"."+name2+" while tb_top.cpu."+comparison_signal[0]+"."+comparison_signal2+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+"."+name2+" while tb_top.cpu."+comparison_signal[0]+"."+comparison_signal2+" == "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");

#	[["ccx","pcx","pcx_arbr8","ard","i_dff_fmem0","c0_0","l1en"],"ard_valid_mask_pcxr8[0]","1'b1"],
#	[["ccx","pcx","pcx_arbr8","ard","i_dff_fmem0","d0_0","q"],"ard_valid_mask_pcxr8[0]","1'b1"],
		
def addConditionalComparisonsARD(fc,pcxcpx,lr,arbid,memid):
	name="ccx."+pcxcpx+"."+pcxcpx+"_arb"+lr+str(arbid)+".ard.i_dff_fmem"+str(memid)
	name_error="tb_top.cpu."+name
	name_noerror="tb_top.cpu.noerror_"+name
	comparison_signal = "ard_valid_mask_"+pcxcpx+lr+str(arbid)
	comparison_value = "1'b1"
	
	for postf in [".c0_0.l1en",".d0_0.q"]:
		name_e = name_error+postf
		name_n = name_noerror+postf
	
		fc.write("if("+name_e+" != "+name_n+") begin\r\n")
		fc.write("	if("+comparison_signal+" == "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : "+name_e+" while "+comparison_signal+" == "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : "+name_e+" while "+comparison_signal+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");
		
def addConditionalComparisonsARDs(fc):
	for lr in ["l","r"]:
		for arbid in reversed(range(9)):
			for memid in range(18):
				addConditionalComparisonsARD(fc,"pcx",lr,arbid,memid)
	for lr in ["l","r"]:
		for arbid in reversed(range(8)):
			for memid in range(18):
				addConditionalComparisonsARD(fc,"cpx",lr,arbid,memid)

		
		
def addConditionalComparisonsTaskVariable(fc):
	for condition in conditional_comparison_list_task_variable:
		name = condition[0]		
		name2 = ".".join(name[1:])
		comparison_signal = condition[1]
		comparison_value = condition[2]
		fc.write("if(tb_top.cpu."+name[0]+"."+name2+" != tb_top.cpu.noerror_"+name[0]+"."+name2+") begin\r\n")
		fc.write("	if("+comparison_signal+" == "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+"."+name2+" while "+comparison_signal+" == "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+"."+name2+" while "+comparison_signal+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");

def addARDValidMask(fc,pcxcpx,lr,arbid):
	pf = "_"+pcxcpx+lr+str(arbid)
	fc.write("case(tb_top.cpu.ccx."+pcxcpx+"."+pcxcpx+"_arb"+lr+str(arbid)+".arc.rptr_a)\r\n")
	fc.write("	0 : ard_rd_ptr_mask"+pf+" = 18'b111111111111111111;\r\n")
	fc.write("	1 : ard_rd_ptr_mask"+pf+" = 18'b011111111111111111;\r\n")
	fc.write("	2 : ard_rd_ptr_mask"+pf+" = 18'b001111111111111111;\r\n")
	fc.write("	3 : ard_rd_ptr_mask"+pf+" = 18'b000111111111111111;\r\n")
	fc.write("	4 : ard_rd_ptr_mask"+pf+" = 18'b000011111111111111;\r\n")
	fc.write("	5 : ard_rd_ptr_mask"+pf+" = 18'b000001111111111111;\r\n")
	fc.write("	6 : ard_rd_ptr_mask"+pf+" = 18'b000000111111111111;\r\n")
	fc.write("	7 : ard_rd_ptr_mask"+pf+" = 18'b000000011111111111;\r\n")
	fc.write("	8 : ard_rd_ptr_mask"+pf+" = 18'b000000001111111111;\r\n")
	fc.write("	9 : ard_rd_ptr_mask"+pf+" = 18'b000000000111111111;\r\n")
	fc.write("	10: ard_rd_ptr_mask"+pf+" = 18'b000000000011111111;\r\n")
	fc.write("	11: ard_rd_ptr_mask"+pf+" = 18'b000000000001111111;\r\n")
	fc.write("	12: ard_rd_ptr_mask"+pf+" = 18'b000000000000111111;\r\n")
	fc.write("	13: ard_rd_ptr_mask"+pf+" = 18'b000000000000011111;\r\n")
	fc.write("	14: ard_rd_ptr_mask"+pf+" = 18'b000000000000001111;\r\n")
	fc.write("	15: ard_rd_ptr_mask"+pf+" = 18'b000000000000000111;\r\n")
	fc.write("	16: ard_rd_ptr_mask"+pf+" = 18'b000000000000000011;\r\n")
	fc.write("	17: ard_rd_ptr_mask"+pf+" = 18'b000000000000000001;\r\n")
	fc.write("endcase\r\n")
	fc.write("case(tb_top.cpu.ccx."+pcxcpx+"."+pcxcpx+"_arb"+lr+str(arbid)+".arc.wptr_a)\r\n")
	fc.write("	0 : ard_wr_ptr_mask"+pf+" = 18'b000000000000000000;\r\n")
	fc.write("	1 : ard_wr_ptr_mask"+pf+" = 18'b100000000000000000;\r\n")
	fc.write("	2 : ard_wr_ptr_mask"+pf+" = 18'b110000000000000000;\r\n")
	fc.write("	3 : ard_wr_ptr_mask"+pf+" = 18'b111000000000000000;\r\n")
	fc.write("	4 : ard_wr_ptr_mask"+pf+" = 18'b111100000000000000;\r\n")
	fc.write("	5 : ard_wr_ptr_mask"+pf+" = 18'b111110000000000000;\r\n")
	fc.write("	6 : ard_wr_ptr_mask"+pf+" = 18'b111111000000000000;\r\n")
	fc.write("	7 : ard_wr_ptr_mask"+pf+" = 18'b111111100000000000;\r\n")
	fc.write("	8 : ard_wr_ptr_mask"+pf+" = 18'b111111110000000000;\r\n")
	fc.write("	9 : ard_wr_ptr_mask"+pf+" = 18'b111111111000000000;\r\n")
	fc.write("	10: ard_wr_ptr_mask"+pf+" = 18'b111111111100000000;\r\n")
	fc.write("	11: ard_wr_ptr_mask"+pf+" = 18'b111111111110000000;\r\n")
	fc.write("	12: ard_wr_ptr_mask"+pf+" = 18'b111111111111000000;\r\n")
	fc.write("	13: ard_wr_ptr_mask"+pf+" = 18'b111111111111100000;\r\n")
	fc.write("	14: ard_wr_ptr_mask"+pf+" = 18'b111111111111110000;\r\n")
	fc.write("	15: ard_wr_ptr_mask"+pf+" = 18'b111111111111111000;\r\n")
	fc.write("	16: ard_wr_ptr_mask"+pf+" = 18'b111111111111111100;\r\n")
	fc.write("	17: ard_wr_ptr_mask"+pf+" = 18'b111111111111111110;\r\n")
	fc.write("endcase\r\n")
	fc.write("if (tb_top.cpu.ccx."+pcxcpx+"."+pcxcpx+"_arb"+lr+str(arbid)+".arc.rptr_a < tb_top.cpu.ccx."+pcxcpx+"."+pcxcpx+"_arb"+lr+str(arbid)+".arc.wptr_a) begin\r\n")	
	fc.write("	ard_valid_mask"+pf+" = ard_rd_ptr_mask"+pf+" & ard_wr_ptr_mask"+pf+" ;\r\n")
	fc.write("end\r\n")
	fc.write("else if (tb_top.cpu.ccx."+pcxcpx+"."+pcxcpx+"_arb"+lr+str(arbid)+".arc.rptr_a > tb_top.cpu.ccx."+pcxcpx+"."+pcxcpx+"_arb"+lr+str(arbid)+".arc.wptr_a) begin\r\n")
	fc.write("	ard_valid_mask"+pf+" = ard_rd_ptr_mask"+pf+" | ard_wr_ptr_mask"+pf+" ;\r\n")
	fc.write("end\r\n")

def addARDValidMasks(fc):
	for lr in ["l","r"]:
		for arbid in reversed(range(9)):
			addARDValidMask(fc,"pcx",lr,arbid)
	for lr in ["l","r"]:
		for arbid in reversed(range(8)):
			addARDValidMask(fc,"cpx",lr,arbid)
			
def addARDValidMasks_variables(fc):
	for lr in ["l","r"]:
		for arbid in reversed(range(9)):
			pf = "_"+"pcx"+lr+str(arbid)
			fc.write("reg [17:0] ard_rd_ptr_mask"+pf+", ard_wr_ptr_mask"+pf+", ard_valid_mask"+pf+";\r\n")
	for lr in ["l","r"]:
		for arbid in reversed(range(8)):
			pf = "_"+"cpx"+lr+str(arbid)
			fc.write("reg [17:0] ard_rd_ptr_mask"+pf+", ard_wr_ptr_mask"+pf+", ard_valid_mask"+pf+";\r\n")
		
def addOneHotChecks(fc):
	for condition in conditional_comparison_list_one_hot:
		name = condition[0]		
		name2 = ".".join(name[1:])
		bitwidth = condition[1];
		fc.write("if(tb_top.cpu."+name[0]+"."+name2+" != tb_top.cpu.noerror_"+name[0]+"."+name2+") begin\r\n")		
		fc.write("	one_hotness_count = 0;\r\n")
		fc.write("	for(one_hotness_index = 0; one_hotness_index < "+str(bitwidth)+" ;one_hotness_index = one_hotness_index+1) begin\r\n")
		fc.write("		if( tb_top.cpu."+name[0]+"."+name2+"[one_hotness_index] != 1'b0 ) begin\r\n")
		fc.write("			one_hotness_count = one_hotness_count + 1;\r\n");
		fc.write("		end \r\n");
		fc.write("	end \r\n");
		fc.write("	if( one_hotness_count != 1 ) begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+"."+name2+" does not satisfy one-hotness %x \",tb_top.cpu."+name[0]+"."+name2+");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+"."+name2+" satisfies one-hotness\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");

		conditional_comparison_list_one_hot
	
def addSpecialComprisons(fc):
	addIgnoredComparisons(fc)
	addConditionalComparisons(fc)
	addConditionalComparisonsInv(fc)
	addARDValidMasks(fc)	
	addConditionalComparisonsARDs(fc)
	addConditionalComparisonsTaskVariable(fc)
	addOneHotChecks(fc)
	

	
for line in fp:
	s = line.strip()
	t = s.split(".")

	#exclude masters in M-S flip-flips
	if (t[-1] == "m" or (t[-1][:2] == "m[" and t[-1][-1] == "]")): continue
	
	ffcs[classify_ff(t)].append(s)

flat_ff_list = []
	
for ffc in sorted(ffcs):	
	print ffc,len(ffcs[ffc])
print ""

ff_id = 0
ffcs_sorted = []
for ffc in sorted(ffcs):	
	if(ffc=="excluded"): continue
	if(ffc.endswith("ECC")): continue
	print ffc,len(ffcs[ffc])
	ffcs_sorted.append(ffc)
	for ff in sorted(ffcs[ffc]):
		#print ff
		flat_ff_list.append(ff)
		ff_id += 1
ECC_protected_ff_id_start = ff_id
for ffc in sorted(ffcs):	
	if(ffc=="excluded"): continue
	if(ffc.endswith("ECC")):
		print ffc,len(ffcs[ffc])
		ffcs_sorted.append(ffc)
		for ff in sorted(ffcs[ffc]):
			#print ff
			flat_ff_list.append(ff)
			ff_id += 1
print "total:",ff_id, "ECC_protected_ff_id_start:", ECC_protected_ff_id_start

#ffc = "excluded"
#for ff in sorted(ffcs[ffc]):
	#print ff
	#flat_ff_list.append(ff)

#
dv_root = os.getenv('DV_ROOT')
vhfile_name = dv_root + "/verif/env/cmp/ff_injection/ff_injection_ccx.vh"
print vhfile_name
vhfile_name_compare = dv_root + "/verif/env/cmp/ff_injection/ff_compare_ccx.vh"
print vhfile_name_compare

try:
	f = open(vhfile_name,"w")
except IOError, e:
	print e.errno
	print e
	
try:
	fc = open(vhfile_name_compare,"w")
except IOError, e:
	print e.errno
	print e

	
f.write("task ff_injection_ccx;\r\n")
f.write("input integer ff_id;\r\n")
f.write("begin\r\n")
f.write("`ifdef FAULTY_CCX\r\n")
f.write("error_injection_cycle = global_cycle_cnt;\r\n")
f.write("case(ff_id)\r\n")

fc.write("task ff_compare_ccx;\r\n")
fc.write("integer mismatch_count;\r\n")
fc.write("integer one_hotness_count;\r\n")
fc.write("integer one_hotness_index;\r\n")
#fc.write("reg [15:0] oqu_rd_ptr_mask, oqu_wr_ptr_mask, oqu_valid_mask;\r\n")
addARDValidMasks_variables(fc)
fc.write("begin\r\n")
fc.write("mismatch_count = 0;\r\n")
fc.write("`ifdef FAULTY_CCX\r\n")

ff_id = 0
for ff in flat_ff_list:
	ff_s = ff.split(".")
	ff_s2 = list(ff_s);
	ff_j = ".".join(ff_s2)
	
	f.write(str(ff_id)+"\t:\t$my_invert(tb_top.cpu."+ff_j+");\r\n");
	
	if not needs_special_comparison_rule(ff_s):
		fc.write("if(tb_top.cpu."+ff_j+" != tb_top.cpu.noerror_"+ff_j+") begin\r\n");
		fc.write("mismatch_count = mismatch_count + 1;\r\n");
		fc.write("$display(\"pending FF error : tb_top.cpu."+ff_j+" %b - %b\",tb_top.cpu."+ff_j+",tb_top.cpu.noerror_"+ff_j+");\r\n");
		fc.write("end \r\n");
	
	ff_id += 1
	
f.write("endcase\r\n")
f.write("`else\r\n")
f.write("$display(\"Error injection to CCX is not enabled. Add -config_rtl=FAULTY_CCX to enable\");\r\n");
f.write("`endif //FAULTY_CCX\r\n")
f.write("end\r\n")
f.write("endtask\r\n")
f.close()

#special comparison rules
addSpecialComprisons(fc)

fc.write("`endif //FAULTY_CCX\r\n")
fc.write("vera_shell.ffMismatchCountSet(mismatch_count);\r\n")
fc.write("end\r\n")
fc.write("endtask\r\n")
fc.close()



#a file to be included in UncoreExternal.vr to setup the number of flip-flops.
vhfile_name = dv_root + "/verif/env/cmp/vera/include/ccx_ff_init.vri"
print vhfile_name
try:
	f = open(vhfile_name,"w")
except IOError, e:
	print e.errno
	print e
f.write("l2_ff_num = "+str(len(flat_ff_list))+";\r\n");
f.write("ECC_protected_ff_id_start = "+str(ECC_protected_ff_id_start)+";\r\n");
f.write("l2_submodule_num = "+str(len(ffcs)-1)+";\r\n");
f.write("l2_submodule_ff_num = new[l2_submodule_num];\r\n");
submodule_index = 0
for ffc in ffcs_sorted:	
	if(ffc=="excluded"): continue
	f.write("l2_submodule_ff_num["+str(submodule_index)+"] = "+str(len(ffcs[ffc]))+"; //"+ffc+"\r\n");
	submodule_index += 1
f.close()


#Flip-flop submodule classifier 
classifier_fname = dv_root + "/script/ff_classify_ccx.sh"
print classifier_fname
try:
	f = open(classifier_fname,"w")
except IOError, e:
	print e.errno
	print e
f.write("#!/bin/bash\n")
f.write("ccx_submodule_num="+str(len(ffcs)-1)+"\n")
f.write("ccx_submodule_names=( ") 
for ffc in ffcs_sorted:	
	if(ffc=="excluded"): continue
	f.write(ffc+" ")
f.write(")\n")
f.write("ccx_submodule_ff_num_max=( ") 
ff_idnum_acc= 0
for ffc in ffcs_sorted:	
	if(ffc=="excluded"): continue
	ff_idnum_acc += len(ffcs[ffc])
	f.write(str(ff_idnum_acc)+" ")
f.write(")\n")
f.write("for ((i=0;i<$ccx_submodule_num;i=i+1))\n")
f.write("do\n")
f.write("	if [ $1 -lt ${ccx_submodule_ff_num_max[$i]} ]\n")
f.write("	then\n")
f.write("		echo ${ccx_submodule_names[$i]}\n")
f.write("		break\n")
f.write("	fi\n")
f.write("done\n")
st = os.stat(classifier_fname)
os.chmod(classifier_fname, st.st_mode | stat.S_IEXEC)

