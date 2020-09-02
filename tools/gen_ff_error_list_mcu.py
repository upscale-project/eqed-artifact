import sys
import os
import stat

fp = open(sys.argv[1],"r")

def pre_filter_mbist(x): 
	for n in x:
		if(n.find("mbist")>=0):
			return True
		if(n.find("bist")>=0):
			return True
		if(n.find("bscan")>=0):
			return True
		if(n.find("spare")>=0):
			if(x[0] == "mcu" and x[1] == "drif" and x[2] == "spare0_flop"): return False
			if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "spare8_flop"): return False
			if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "spare10_flop"): return False
			if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "spare18_flop"): return False
			if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "spare20_flop"): return False
			if(x[0] == "mcu" and x[1] == "fdout" and x[2] == "spare0_flop"): return False		
			return True
		#####if(n.find("ucb")>=0):
		#####	return True
		#####if(n.find("dtm")>=0):
		#####	return True
		#####if(n.find("pdmc")>=0):
		#####	return True
	return False
	
def filter_wdqrf(x): 
	names1 =["wdqrf11", "wdqrf10", "wdqrf01", "wdqrf00"]
	return x[0] == "mcu" and x[1] in names1
	
def filter_fbd(x): 
	names1 =["fbd0", "fbd1","fbdic","fdoklu","fdout"]
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbfibportctl"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_ibtx_done_flag"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_ibtx_start"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbfibpgctl"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbfibpattbuf1"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbfibtxmsk"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbfibtxshft"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbfibpattbuf2"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbfibpatt2en"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbfibinit"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "ff_sbts_cnt"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_sbibistmisc"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_nbfibportctl"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_ibrx_done_flag"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_ibrx_start"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_nbfibpgctl"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_nbfibpattbuf1"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_nbfibrxmsk"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_nbfibrxshft"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_nbfibpattbuf2"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "pff_nbfibpatt2en"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "ff_rx_s0s1_match_dly"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "ff_err_fbxi"): return False # ibist
	if(x[0] == "mcu" and x[1] == "fbdic" and x[2] == "ff_fbr_injected"): return False # ibist
	return x[0] == "mcu" and x[1] in names1
	
	
def filter_lndskw(x): 
	names1 =["lndskw1", "lndskw0"]
	return x[0] == "mcu" and x[1] in names1
	
def filter_fbdiwr(x): 
	names1 =["fbdiwr"]
	return x[0] == "mcu" and x[1] in names1
	
def filter_wrdp(x): 
	names1 =["wrdp"]
	if(x[0] == "mcu" and x[1] == "wrdp" and x[2] == "u_wdqrf00_data"): return False # mbist
	if(x[0] == "mcu" and x[1] == "wrdp" and x[2] == "u_wdqrf01_data"): return False # mbist
	if(x[0] == "mcu" and x[1] == "wrdp" and x[2] == "u_wdqrf10_data"): return False # mbist
	if(x[0] == "mcu" and x[1] == "wrdp" and x[2] == "u_wdqrf11_data"): return False # mbist
	return x[0] == "mcu" and x[1] in names1
	
def filter_l2rdmx(x): 
	names1 =["l2rdmx"]
	return x[0] == "mcu" and x[1] in names1

def filter_readdp(x): 
	names1 =["readdp0","readdp1"]
	return x[0] == "mcu" and x[1] in names1

def filter_addrdp(x): 
	names1 =["addrdp"]
	return x[0] == "mcu" and x[1] in names1
	
def filter_clk(x): 
	names1 =["crcn","crcs","clkgen_io","clkgen_dr","clkgen_cmp"]
	return x[0] == "mcu" and x[1] in names1

def filter_rdata(x): 
	names1 =["rdata"]
	return x[0] == "mcu" and x[1] in names1
	
def filter_rdpctl(x): 
	names1 =["rdpctl"]
	return x[0] == "mcu" and x[1] in names1

def filter_ucb(x): 
	names1 =["ucb"]	
	return x[0] == "mcu" and x[1] in names1

def filter_drif(x): 
	names1 =["drif"]
	#####if(x[0] == "mcu" and x[1] == "drif" and x[2] == "pff_ext_mode_reg1"): return False # ext mode not used?
	#####if(x[0] == "mcu" and x[1] == "drif" and x[2] == "pff_ext_mode_reg2"): return False # ext mode not used?
	#####if(x[0] == "mcu" and x[1] == "drif" and x[2] == "pff_ext_mode_reg3"): return False # ext mode not used?
	return x[0] == "mcu" and x[1] in names1

def filter_l2if(x): 
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdmatb_dep_rdy_en_d1"): return False # RDMA
	names1 =["l2if0","l2if1"]
	return x[0] == "mcu" and x[1] in names1

def filter_excluded(x):
	if(x[0] == "mcu"):
		if(x[1] == "mbist"): return True	#MBIST
		if(x[1] == "bscan"): return True	#MBIST
		#####if(x[1] == "drif" and x[2] == "pff_ext_mode_reg1"): return True # ext mode not used?
		#####if(x[1] == "drif" and x[2] == "pff_ext_mode_reg2"): return True # ext mode not used?
		#####if(x[1] == "drif" and x[2] == "pff_ext_mode_reg3"): return True # ext mode not used?
		if(x[1] == "wrdp" and x[2] == "u_wdqrf00_data"): return True # mbist
		if(x[1] == "wrdp" and x[2] == "u_wdqrf01_data"): return True # mbist
		if(x[1] == "wrdp" and x[2] == "u_wdqrf10_data"): return True # mbist
		if(x[1] == "wrdp" and x[2] == "u_wdqrf11_data"): return True # mbist
		if(x[1] == "fbdic" and x[2] == "pff_sbfibportctl"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_ibtx_done_flag"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_ibtx_start"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_sbfibpgctl"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_sbfibpattbuf1"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_sbfibtxmsk"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_sbfibtxshft"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_sbfibpattbuf2"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_sbfibpatt2en"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_sbfibinit"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "ff_sbts_cnt"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_sbibistmisc"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_nbfibportctl"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_ibrx_done_flag"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_ibrx_start"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_nbfibpgctl"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_nbfibpattbuf1"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_nbfibrxmsk"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_nbfibrxshft"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_nbfibpattbuf2"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "pff_nbfibpatt2en"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "ff_rx_s0s1_match_dly"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "ff_err_fbxi"): return True # ibist
		if(x[1] == "fbdic" and x[2] == "ff_fbr_injected"): return True # ibist
	return False
	
def classify_ff(s):
	if(pre_filter_mbist(s)): return "excluded"
		
	if(filter_wdqrf(s)) :
		if(is_ECC_protected(s)): return "wdqrf_ECC"
		else: return "wdqrf"
	elif(filter_fbd(s)) :
		if(is_ECC_protected(s)): return "fbd_ECC"
		else: return "fbd"
	elif(filter_lndskw(s)) :
		if(is_ECC_protected(s)): return "lndskw_ECC"
		else: return "lndskw"
	elif(filter_fbdiwr(s)) :
		if(is_ECC_protected(s)): return "fbdiwr_ECC"
		else: return "fbdiwr"
	elif(filter_wrdp(s)) :	
		if(is_ECC_protected(s)): return "wrdp_ECC"
		else: return "wrdp"
	elif(filter_l2rdmx(s)) :
		if(is_ECC_protected(s)): return "l2rdmx_ECC"
		else: return "l2rdmx"
	elif(filter_readdp(s)) :
		if(is_ECC_protected(s)): return "readdp_ECC"
		else: return "readdp"
	elif(filter_addrdp(s)) :
		if(is_ECC_protected(s)): return "addrdp_ECC"
		else: return "addrdp"
	elif(filter_clk(s)) : 	
		if(is_ECC_protected(s)): return "clk_ECC"
		else: return "clk"
	elif(filter_rdata(s)) : 
		if(is_ECC_protected(s)): return "rdata_ECC"
		else: return "rdata"
	elif(filter_rdpctl(s)) :
		if(is_ECC_protected(s)): return "rdpctl_ECC"
		else: return "rdpctl"
	elif(filter_ucb(s)) : 	
		if(is_ECC_protected(s)): return "ucb_ECC"
		else: return "ucb"
	elif(filter_drif(s)) : 	
		if(is_ECC_protected(s)): return "drif_ECC"
		else: return "drif"
	elif(filter_l2if(s)) : 
		if(is_ECC_protected(s)): return "l2if_ECC"
		else: return "l2if"
	elif(filter_excluded(s)) : 		return "excluded"
	print s
	return ""
	
ffcs = {"wdqrf":[],"fbd":[],"lndskw" :[],"fbdiwr" :[],"wrdp":[],"l2rdmx" :[],"readdp" :[],"addrdp" :[],"clk" :[],"rdata" :[],"rdpctl" :[],"ucb":[],"drif":[],"l2if":[]
		,"wdqrf_ECC":[],"fbd_ECC":[],"lndskw_ECC" :[],"fbdiwr_ECC" :[],"wrdp_ECC":[],"l2rdmx_ECC" :[],"readdp_ECC" :[],"addrdp_ECC" :[],"clk_ECC" :[],"rdata_ECC" :[],"rdpctl_ECC" :[],"ucb_ECC":[],"drif_ECC":[],"l2if_ECC":[]
		,"excluded":[]}

comparison_ignore_list = [
	["mcu","wrdp","u_scrub_wdata_63_0","d0_0","q"],
	["mcu","wrdp","u_scrub_wdata_127_64","d0_0","q"],
	["mcu","wrdp","u_scrub_wdata_191_128","d0_0","q"],
	["mcu","wrdp","u_scrub_wdata_255_192","d0_0","q"],
	["mcu","wrdp","u_scrub_wdata_319_256","d0_0","q"],
	["mcu","wrdp","u_scrub_wdata_383_320","d0_0","q"],
	["mcu","wrdp","u_scrub_wdata_447_384","d0_0","q"],
	["mcu","wrdp","u_scrub_wdata_511_448","d0_0","q"],
	["mcu","drif","ff_scrub_addr","d0_0","q"],
	["mcu","fbdic","ff_config_timeout_cnt","d0_0","q"],
	["mcu","fbdic","pff_config_timeout","d0_0","q"],
	["mcu","addrdp","l2b0_adr_queue","u_mcu_rd_adr_sync","d0_0","q"],	# temporary values. (crossing clock domain)
	["mcu","addrdp","l2b0_adr_queue","u_mcu_wr_adr_sync","d0_0","q"],	# temporary values. (crossing clock domain)
	["mcu","addrdp","l2b1_adr_queue","u_mcu_rd_adr_sync","d0_0","q"],	# temporary values. (crossing clock domain)
	["mcu","addrdp","l2b1_adr_queue","u_mcu_wr_adr_sync","d0_0","q"],	# temporary values. (crossing clock domain)
	["mcu","drif","ff_banks_open","d0_0","q"],	# power throttling
	["mcu","drif","ff_crit_sig","d0_0","q"],	# performance counter
	["mcu","drif","ff_perf_cnt0_reg","d0_0","q"],	# performance counter
	["mcu","drif","ff_perf_cnt1_reg","d0_0","q"],	# performance counter
	["mcu","drif","ff_ref_cnt","d0_0","q"],	# refresh counter. need to check refresh interval externally
	#["mcu","drif","pdmc0","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc1","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc2","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc3","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc4","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc5","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc6","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc7","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc8","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc9","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc10","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc11","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc12","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc13","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc14","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	#["mcu","drif","pdmc15","ff_pd_cnt","d0_0","q"],	# powerdown mode counter . assume power down mode is not used
	["mcu","drif","spare0_flop","q"],	# powerdown mode counter . assume power down mode is not used
	["mcu","drif","spare1_flop","q"],	# Unused spare register
	["mcu","drif","spare2_flop","q"],	# Unused spare register
	["mcu","drif","spare3_flop","q"],	# Unused spare register
	["mcu","drif","spare4_flop","q"],	# Unused spare register
	["mcu","drif","spare5_flop","q"],	# Unused spare register
	["mcu","drif","spare6_flop","q"],	# Unused spare register
	["mcu","drif","spare7_flop","q"],	# Unused spare register
	["mcu","drif","spare8_flop","q"],	# Unused spare register
	["mcu","drif","spare9_flop","q"],	# Unused spare register
	["mcu","drif","spare10_flop","q"],	# Unused spare register
	["mcu","drif","spare11_flop","q"],	# Unused spare register
	["mcu","drif","spare12_flop","q"],	# Unused spare register
	["mcu","drif","spare13_flop","q"],	# Unused spare register
	["mcu","drif","spare14_flop","q"],	# Unused spare register
	["mcu","drif","spare15_flop","q"],	# Unused spare register
	["mcu","drif","spare16_flop","q"],	# Unused spare register
	["mcu","drif","spare17_flop","q"],	# Unused spare register
	["mcu","drif","spare18_flop","q"],	# Unused spare register
	["mcu","drif","spare19_flop","q"],	# Unused spare register
	["mcu","drif","spare20_flop","q"],	# Unused spare register
	["mcu","drif","spare21_flop","q"],	# Unused spare register
	["mcu","drif","spare22_flop","q"],	# Unused spare register
	["mcu","drif","spare23_flop","q"],	# Unused spare register
	["mcu","drif","spare24_flop","q"],	# Unused spare register
	["mcu","drif","spare25_flop","q"],	# Unused spare register
	["mcu","drif","spare26_flop","q"],	# Unused spare register
	["mcu","drif","spare27_flop","q"],	# Unused spare register
	["mcu","drif","spare28_flop","q"],	# Unused spare register
	["mcu","drif","spare29_flop","q"],	# Unused spare register
	["mcu","drif","spare30_flop","q"],	# Unused spare register
	["mcu","drif","spare31_flop","q"],	# Unused spare register
	["mcu","drif","spare32_flop","q"],	# Unused spare register
	["mcu","drif","spare33_flop","q"],	# Unused spare register
	["mcu","drif","spare34_flop","q"],	# Unused spare register
	["mcu","drif","spare35_flop","q"],	# Unused spare register
	["mcu","drif","spare36_flop","q"],	# Unused spare register
	["mcu","drif","spare37_flop","q"],	# Unused spare register
	["mcu","drif","spare38_flop","q"],	# Unused spare register
	["mcu","drif","spare39_flop","q"],	# Unused spare register
	["mcu","drif","spare40_flop","q"],	# Unused spare register
	["mcu","drif","spare41_flop","q"],	# Unused spare register
	["mcu","drif","spare42_flop","q"],	# Unused spare register
	["mcu","drif","spare43_flop","q"],	# Unused spare register
	["mcu","drif","spare44_flop","q"],	# Unused spare register
	["mcu","drif","spare45_flop","q"],	# Unused spare register
	["mcu","drif","spare46_flop","q"],	# Unused spare register
	["mcu","drif","spare47_flop","q"],	# Unused spare register
	["mcu","drif","spare48_flop","q"],	# Unused spare register
	["mcu","crcn","spares","spare0_flop","q"],	# Unused spare register
	["mcu","crcs","spares","spare0_flop","q"],	# Unused spare register
	["mcu","fbdic","spare0_flop","q"],	# Unused spare register
	["mcu","fbdic","spare1_flop","q"],	# Unused spare register
	["mcu","fbdic","spare2_flop","q"],	# Unused spare register
	["mcu","fbdic","spare3_flop","q"],	# Unused spare register
	["mcu","fbdic","spare4_flop","q"],	# Unused spare register
	["mcu","fbdic","spare5_flop","q"],	# Unused spare register
	["mcu","fbdic","spare6_flop","q"],	# Unused spare register
	["mcu","fbdic","spare7_flop","q"],	# Unused spare register
	#["mcu","fbdic","spare8_flop","q"],	# this one is used
	["mcu","fbdic","spare9_flop","q"],	# Unused spare register
	#["mcu","fbdic","spare10_flop,"q"],	# this one is used
	["mcu","fbdic","spare11_flop","q"],	# Unused spare register
	["mcu","fbdic","spare12_flop","q"],	# Unused spare register
	["mcu","fbdic","spare13_flop","q"],	# Unused spare register
	["mcu","fbdic","spare14_flop","q"],	# Unused spare register
	["mcu","fbdic","spare15_flop","q"],	# Unused spare register
	["mcu","fbdic","spare16_flop","q"],	# Unused spare register
	["mcu","fbdic","spare17_flop","q"],	# Unused spare register
	#["mcu","fbdic","spare18_flop","q"],	# this one is used
	["mcu","fbdic","spare19_flop","q"],	# Unused spare register
	#["mcu","fbdic","spare20_flop","q"],	# this one is used
	["mcu","fbdic","spare21_flop","q"],	# Unused spare register
	["mcu","fdoklu","spares","spare0_flop","q"],	# Unused spare register
	["mcu","fdoklu","spares","spare1_flop","q"],	# Unused spare register
	["mcu","l2if0","spares","spare0_flop","q"],	# Unused spare register
	["mcu","l2if0","spares","spare1_flop","q"],	# Unused spare register
	["mcu","l2if0","spares","spare2_flop","q"],	# Unused spare register
	["mcu","l2if0","spares","spare3_flop","q"],	# Unused spare register
	["mcu","l2if1","spares","spare0_flop","q"],	# Unused spare register
	["mcu","l2if1","spares","spare1_flop","q"],	# Unused spare register
	["mcu","l2if1","spares","spare2_flop","q"],	# Unused spare register
	["mcu","l2if1","spares","spare3_flop","q"],	# Unused spare register
	["mcu","rdata","spares","spare0_flop","q"],	# Unused spare register
	["mcu","rdata","spares","spare1_flop","q"],	# Unused spare register
	["mcu","rdata","spares","spare2_flop","q"],	# Unused spare register
	["mcu","rdata","spares","spare3_flop","q"],	# Unused spare register
	["mcu","rdata","spares","spare4_flop","q"],	# Unused spare register
	["mcu","rdpctl","spares","spare0_flop","q"],	# Unused spare register
	["mcu","rdpctl","spares","spare1_flop","q"],	# Unused spare register
	["mcu","rdpctl","spares","spare2_flop","q"],	# Unused spare register
	["mcu","rdpctl","spares","spare3_flop","q"],	# Unused spare register
	["mcu","rdpctl","spares","spare4_flop","q"],	# Unused spare register
	["mcu","rdpctl","spares","spare5_flop","q"],	# Unused spare register
	["mcu","fdoklu","ff0_rptr0","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr1","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr2","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr3","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr4","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr5","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr6","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr7","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr8","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr9","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr10","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr11","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr12","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff0_rptr13","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr0","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr1","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr2","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr3","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr4","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr5","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr6","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr7","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr8","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr9","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr10","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr11","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr12","d0_0","q"],	# temporary value
	["mcu","fdoklu","ff1_rptr13","d0_0","q"],	# temporary value
	["mcu","fdout","ff_fsr0_data","d0_0","q"],	# temporary value
	["mcu","fdout","ff_fsr1_data","d0_0","q"],	# temporary value
	["mcu","l2rdmx","u_l2if0_ras_cas_addr","d0_0","q"],	# temporary value
	["mcu","l2rdmx","u_l2if1_ras_cas_addr","d0_0","q"],	# temporary value
	["mcu","l2rdmx","u_l2if_bank_rank_addr","d0_0","q"],	# temporary value
	["mcu","l2rdmx","u_l2t_cntl","d0_0","q"],	# temporary value
	["mcu","fbdic","pff_mcu_syndrome","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit54","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit55","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit56","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit57","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit58","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit59","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit60","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit61","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit62","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit63","d0_0","q"], #error reporting onlyu
	["mcu","rdpctl","pff_err_sts_bit63","d0_0","q"], #error reporting onlyu
	["mcu","fbdic","pff_mcu_syndrome","d0_0","q"], #error reporting onlyu
	["mcu","drif","reqq","woq","ff_pd_mode_wr_decr","d0_0","q"], #powerdown mode
	["mcu","drif","reqq","drq0","ff_pd_mode_rd_decr","d0_0","q"],	#powerdown mode
	["mcu","drif","reqq","drq1","ff_pd_mode_rd_decr","d0_0","q"],	#powerdown mode
	["mcu","drif","reqq","drq0","ff_rd_wr_val","d0_0","q"],	#temporary
	["mcu","drif","reqq","drq1","ff_rd_wr_val","d0_0","q"],	#temporary
	["mcu","drif","ff_req_id_d1","d0_0","q"],	#temporary
	["mcu","drif","ff_wr1_adr_d1","d0_0","q"],	#temporary
	["mcu","drif","ff_wr1_adr_d2","d0_0","q"],	#temporary
	["mcu","drif","ff_wr2_adr_d2","d0_0","q"],	#temporary
	["mcu","drif","ff_wr2_adr_d1","d0_0","q"],	#temporary
	["mcu","drif","ff_write1_data","d0_0","q"],	#temporary
	["mcu","drif","ff_write2_data","d0_0","q"],	#temporary
	["mcu","drif","ff_rank_dimm_picked","d0_0","q"],	#temporary
	["mcu","drif","ff_raw_match","d0_0","q"],	#temporary
	["mcu","drif","ff_rd_index_d1","d0_0","q"],	#temporary
	["mcu","wrdp","u_io_data_127_64","d0_0","q"],	#temporary
	["mcu","wrdp","u_io_data_63_0","d0_0","q"],	#temporary
	["mcu","wrdp","u_io_ecc_15_0","d0_0","q"],	#temporary
	["mcu","wrdp","u_wdata_127_64","d0_0","q"],	#temporary
	["mcu","wrdp","u_wdata_63_0","d0_0","q"],	#temporary
	["mcu","rdpctl","pff_err_syn","d0_0","q"],	#error reporting only
	["mcu","rdpctl","pff_err_addr_reg","d0_0","q"],	#error reporting only
	["mcu","rdpctl","ff_scrub_data_cnt","d0_0","q"],	#error reporting only
	["mcu","fdoklu","ff_link_cnt","d0_0","q"],	#this link counter itself does not make difference.
	["mcu","fdoklu","ff_link_cnt_eq_0_d1","d0_0","q"],	#this link counter itself does not make difference.
	["mcu","fdout","spare0_flop","q"],	#this link counter itself does not make difference.
	["mcu","rdpctl","pff_err_loc","d0_0","q"],	#error reporting only
	["mcu","rdpctl","pff_err_retry1","d0_0","q"],	#error reporting only
	["mcu","rdpctl","pff_err_retry2","d0_0","q"],	#error reporting only
	["mcu","rdpctl","pff_retry_reg_valid","d0_0","q"],	#error reporting only
	["mcu","fdoklu","ff_idle_lfsr","d0_0","q"],	#LFSR is shared with the golden model
	["mcu","rdata","ff_debug_signals","d0_0","q"],	#
	["mcu","fdoklu","sync_fbd0_framelock0","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock0","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock1","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock1","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock2","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock2","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock3","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock3","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock4","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock4","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock5","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock5","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock6","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock6","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock7","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock7","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock8","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock8","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock9","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock9","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock10","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock10","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock11","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock11","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock12","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock12","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock13","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd0_framelock13","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock0","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock0","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock1","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock1","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock2","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock2","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock3","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock3","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock4","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock4","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock5","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock5","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock6","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock6","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock7","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock7","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock8","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock8","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock9","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock9","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock10","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock10","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock11","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock11","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock12","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock12","xx1","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock13","xx0","q"],	#signal from fsr..
	["mcu","fdoklu","sync_fbd1_framelock13","xx1","q"],	#signal from fsr..
	["mcu","l2rdmx","u_bank0_l2wr_data","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_bank1_l2wr_data","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_l2_rd_data_127_64","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_l2_rd_data_127_64_dly1","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_l2_rd_data_127_64_dly2","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_l2_rd_data_191_128","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_l2_rd_data_255_192","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_l2_rd_data_64_0","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_l2_rd_data_64_0_dly1","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_l2_rd_data_64_0_dly2","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_rddata_127_64_p3","d0_0","q"],	#signal from fsr..
	["mcu","l2rdmx","u_rddata_63_0_p3","d0_0","q"],	#signal from fsr..
	
	["mcu","wrdp","u_wdqrf00_data","d0_0","q"], # mbist
	["mcu","wrdp","u_wdqrf01_data","d0_0","q"], # mbist
	["mcu","wrdp","u_wdqrf10_data","d0_0","q"], # mbist
	["mcu","wrdp","u_wdqrf11_data","d0_0","q"], # mbist
	["mcu","drif","ff_ucb_req","d0_0","q"], # mbist
	["mcu","drif","ff_ucb_req","d0_0","q"], # mbist
	["mcu","drif","pff_ext_mode_reg1","d0_0","q"], # mbist
	["mcu","drif","pff_ext_mode_reg2","d0_0","q"], # mbist
	["mcu","drif","pff_ext_mode_reg3","d0_0","q"], # mbist
	["mcu","fbdic","pff_sbfibportctl"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_ibtx_done_flag"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_ibtx_start"		,"d0_0","q"], #ibist
	["mcu","fbdic","pff_sbfibpgctl"		,"d0_0","q"], #ibist
	["mcu","fbdic","pff_sbfibpattbuf1"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_sbfibtxmsk"		,"d0_0","q"], #ibist
	["mcu","fbdic","pff_sbfibtxshft"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_sbfibpattbuf2"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_sbfibpatt2en"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_sbfibinit"		,"d0_0","q"], #ibist
	["mcu","fbdic","ff_sbts_cnt"		,"d0_0","q"], #ibist
	["mcu","fbdic","pff_sbibistmisc"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_nbfibportctl"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_ibrx_done_flag"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_ibrx_start"		,"d0_0","q"], #ibist
	["mcu","fbdic","pff_nbfibpgctl"		,"d0_0","q"], #ibist
	["mcu","fbdic","pff_nbfibpattbuf1"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_nbfibrxmsk"		,"d0_0","q"], #ibist
	["mcu","fbdic","pff_nbfibrxshft"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_nbfibpattbuf2"	,"d0_0","q"], #ibist
	["mcu","fbdic","pff_nbfibpatt2en"	,"d0_0","q"], #ibist
	["mcu","fbdic","ff_rx_s0s1_match_dly","d0_0","q"], #ibist
	["mcu","fbdic","ff_err_fbxi","d0_0","q"], #ibist
	["mcu","fbdic","ff_fbr_injected","d0_0","q"], #ibist
	
	#excluded
	["mcu","rdata","ff_data_word_cnt","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_rdata_rd_req_id","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_rdata_rd_req_id_d1","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_mecc_err_o","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_mecc_err_d1","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_secc_err_o","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_secc_err_d1","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_err_event_d1","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_err_event","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_fbd_error_d1","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_fbd_error","d0_0","q"],		#error reporting
	["mcu","rdata","ff_mcu_ucb_err_mode","d0_0","q"],		#error reporting
	["mcu","rdata","ff_wr_req_out_cnt","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_wr_req_out1_d1","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_wr_req_out1","d0_0","q"],		#error reporting
	["mcu","rdata","ff_ucb_wr_req_out0","d0_0","q"],		#error reporting

]
 
comparison_ignore_list_array = [
	["mcu","fbd0"],	#all ffs in fbd0 is temporary
	["mcu","fbd1"],	#all ffs in fbd1 is temporary
	["mcu","lndskw0"],	#all ffs in lndskw0 is temporary
	["mcu","lndskw1"],	#all ffs in lndskw1 is temporary
	["mcu","l2if0"],	#all ffs in l2if0 is temporary
	["mcu","l2if1"],	#all ffs in l2if1 is temporary
	["mcu","mbist"],	#mbist
	["mcu","bscan"],	#mbist
]

conditional_comparison_list = [
	#[["l2t","evctag","ff_mcu_read_addr","d0_0","q"],["l2t","l2t_mcu_rd_req"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_wr_adr_queue0","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[0]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_wr_adr_queue1","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[1]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_wr_adr_queue2","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[2]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_wr_adr_queue3","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[3]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_wr_adr_queue4","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[4]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_wr_adr_queue5","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[5]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_wr_adr_queue6","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[6]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_wr_adr_queue7","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[7]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_wr_adr_queue0","d0_0","q"],["mcu","drif","reqq","drq1","drq_wrbuf_valids[0]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_wr_adr_queue1","d0_0","q"],["mcu","drif","reqq","drq1","drq_wrbuf_valids[1]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_wr_adr_queue2","d0_0","q"],["mcu","drif","reqq","drq1","drq_wrbuf_valids[2]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_wr_adr_queue3","d0_0","q"],["mcu","drif","reqq","drq1","drq_wrbuf_valids[3]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_wr_adr_queue4","d0_0","q"],["mcu","drif","reqq","drq1","drq_wrbuf_valids[4]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_wr_adr_queue5","d0_0","q"],["mcu","drif","reqq","drq1","drq_wrbuf_valids[5]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_wr_adr_queue6","d0_0","q"],["mcu","drif","reqq","drq1","drq_wrbuf_valids[6]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_wr_adr_queue7","d0_0","q"],["mcu","drif","reqq","drq1","drq_wrbuf_valids[7]"],"1'b1"],	
	[["mcu","addrdp","l2b0_adr_queue","u_rd_adr_queue0","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[0]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_rd_adr_queue1","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[1]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_rd_adr_queue2","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[2]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_rd_adr_queue3","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[3]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_rd_adr_queue4","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[4]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_rd_adr_queue5","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[5]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_rd_adr_queue6","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[6]"],"1'b1"],
	[["mcu","addrdp","l2b0_adr_queue","u_rd_adr_queue7","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[7]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_rd_adr_queue0","d0_0","q"],["mcu","drif","reqq","drq1","drq_rdbuf_valids[0]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_rd_adr_queue1","d0_0","q"],["mcu","drif","reqq","drq1","drq_rdbuf_valids[1]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_rd_adr_queue2","d0_0","q"],["mcu","drif","reqq","drq1","drq_rdbuf_valids[2]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_rd_adr_queue3","d0_0","q"],["mcu","drif","reqq","drq1","drq_rdbuf_valids[3]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_rd_adr_queue4","d0_0","q"],["mcu","drif","reqq","drq1","drq_rdbuf_valids[4]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_rd_adr_queue5","d0_0","q"],["mcu","drif","reqq","drq1","drq_rdbuf_valids[5]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_rd_adr_queue6","d0_0","q"],["mcu","drif","reqq","drq1","drq_rdbuf_valids[6]"],"1'b1"],
	[["mcu","addrdp","l2b1_adr_queue","u_rd_adr_queue7","d0_0","q"],["mcu","drif","reqq","drq1","drq_rdbuf_valids[7]"],"1'b1"],
	#[["mcu","fbdic","pff_mcu_syndrome","d0_0","q"],["mcu","fbdic","fbdic_mcu_synd_valid"],"1'b1"],
	[["mcu","rdata","ff_qword_id","d0_0","q"],["mcu","rdata","mcu_l2t0_data_vld_r0"],"1'b1"],
	[["mcu","rdata","ff_rd_req_id","d0_0","q"],["mcu","rdata","mcu_l2t0_data_vld_r0"],"1'b1"],
	[["mcu","rdpctl","ff_qword_id","d0_0","q"],["mcu","rdata","mcu_l2t0_data_vld_r0"],"1'b1"],
	[["mcu","rdpctl","ff_rd_req_id","d0_0","q"],["mcu","rdata","mcu_l2t0_data_vld_r0"],"1'b1"],
	[["mcu","wdqrf00","dff_wr_addr","d0_0","q"],["mcu","wdqrf00","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf01","dff_wr_addr","d0_0","q"],["mcu","wdqrf01","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf10","dff_wr_addr","d0_0","q"],["mcu","wdqrf10","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf11","dff_wr_addr","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf00","dff_din_hi","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf00","dff_din_lo","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf01","dff_din_hi","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf01","dff_din_lo","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf10","dff_din_hi","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf10","dff_din_lo","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf11","dff_din_hi","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf11","dff_din_lo","d0_0","q"],["mcu","wdqrf11","wr_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf00","dff_rd_addr","d0_0","q"],["mcu","wdqrf00","rd_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf01","dff_rd_addr","d0_0","q"],["mcu","wdqrf01","rd_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf10","dff_rd_addr","d0_0","q"],["mcu","wdqrf10","rd_en_d1_qual"],"1'b1"],
	[["mcu","wdqrf11","dff_rd_addr","d0_0","q"],["mcu","wdqrf11","rd_en_d1_qual"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_ent0","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[0]"],"1'b1"], 
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_ent1","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[1]"],"1'b1"], 
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_ent2","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[2]"],"1'b1"], 
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_ent3","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[3]"],"1'b1"], 
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_ent4","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[4]"],"1'b1"], 
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_ent5","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[5]"],"1'b1"], 
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_ent6","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[6]"],"1'b1"], 
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_ent7","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdbuf_valids[7]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_ent0","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[0]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_ent1","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[1]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_ent2","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[2]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_ent3","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[3]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_ent4","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[4]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_ent5","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[5]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_ent6","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[6]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_ent7","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[7]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wrbuf_issued","d0_0","q[0]"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[0]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wrbuf_issued","d0_0","q[1]"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[1]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wrbuf_issued","d0_0","q[2]"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[2]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wrbuf_issued","d0_0","q[3]"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[3]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wrbuf_issued","d0_0","q[4]"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[4]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wrbuf_issued","d0_0","q[5]"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[5]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wrbuf_issued","d0_0","q[6]"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[6]"],"1'b1"],
	[["mcu","drif","reqq","drq0","ff_wrbuf_issued","d0_0","q[7]"],["mcu","drif","reqq","drq0","drq_wrbuf_valids[7]"],"1'b1"],
	[["mcu","rdpctl","ff_err_fifo_data","d0_0","q"],["mcu","rdpctl","rdpctl_err_fifo_enq"],"1'b1"],
	[["mcu","fbdic","ff_tcalibrate_cnt","d0_0","q"],["mcu","fbdic","fbdic_calibrate_state"],"1'b1"],
	[["mcu","fbdic","pff_tcalibrate_period","d0_0","q"],["mcu","fbdic","fbdic_calibrate_state"],"1'b1"],
	[["mcu","fbdic","ff_ch0_cap_reg","d0_0","q"],["mcu","fbdic","fbdic_train_seq"],"1'b1"],
	[["mcu","fbdic","pff_amb_test_param","d0_0","q"],["mcu","fbdic","fbdic_train_seq"],"1'b1"],
	[["mcu","fbdic","ff_tclktrain_timeout_cnt","d0_0","q"],["mcu","fbdic","fbdic_train_seq"],"1'b1"],
	[["mcu","fbdic","pff_tclktrain_timeout","d0_0","q"],["mcu","fbdic","fbdic_train_seq"],"1'b1"],
	[["mcu","fbdic","ff_testing_done","d0_0","q"],["mcu","fbdic","fbdic_train_seq"],"1'b1"],	
	
	[["mcu","rdata","ff_ucb_data_out","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","rdata_ucb_data_in","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","rdata_ucb_ack_nack","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","rdata_ucb_addr_in","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","rdata_ucb_rd_wr_vld","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ucb_data_out","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ucb_data_cpu","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ff_rdata_ucb_data_cpu","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ff_rdata_ucb_addr_cpu","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ff_ucb_err_inj","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ucb_data_in","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ucb_addr_in","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ucb_rd_wr_vld","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","rdata","ff_ucb_test_signals","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","drif","ff_ucb_data","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	
	[["mcu","drif","ff_ucb_req","d0_0","q"],["mcu","mcu_ncu_vld"],"1'b1"],	

]

conditional_comparison_list_arry = [
	[["mcu","ucb"],["mcu","mcu_ncu_vld"],"1'b1"],	
]

conditional_comparison_list_inv = [
	#[["l2t","misbuf","ff_misbuf_filbuf_fbid_0123","d0_0","q"],["l2t","misbuf","way_fbid_vld[3:0]"],"4'b0000"],	
	[["mcu","drif","errq","ff_rptr","d0_0","q"],["mcu","drif","errq","errq_empty"],"1'b1"],	#if queue is empty, pointers can point anywhere
	[["mcu","drif","errq","ff_wptr","d0_0","q"],["mcu","drif","errq","errq_empty"],"1'b1"],	#if queue is empty, pointers can point anywhere
	[["mcu","fbdic","latq","ff_rptr","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_wptr","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent0","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent1","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent2","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent3","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent4","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent5","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent6","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent7","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent8","d0_0","q" ],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent10","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent11","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent12","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent13","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent14","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent15","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent16","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent17","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent18","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent19","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent20","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent21","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent22","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent23","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent24","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent25","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent26","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent27","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent28","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent29","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent30","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty
	[["mcu","fbdic","latq","ff_ent31","d0_0","q"],["mcu","fbdic","latq","latq_empty"],"1'b1"],	# latq empty	
	[["mcu","rdpctl","otq","ff_ent0","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent1","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent2","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent3","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent4","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent5","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent6","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent7","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent8","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent9","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent10","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent11","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent12","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent13","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent14","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_ent15","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_rptr","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","rdpctl","otq","ff_wptr","d0_0","q"],["mcu","rdpctl","otq","otq_empty"],"1'b1"],	# otq empty	
	[["mcu","drif","reqq","woq","ff_raddr","d0_0","q"          ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_waddr","d0_0","q"          ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_error_ptr","d0_0","q"      ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_io_wdata_sel","d0_0","q"   ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_owr_ptr","d0_0","q"        ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_reg0","d0_0","q"           ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_reg15","d0_0","q"          ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_wdata_cnt","d0_0","q"      ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_wdata_l2bank","d0_0","q"   ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_wdq_entry_free","d0_0","q" ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_wdq_free_accum","d0_0","q" ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_wr_err_state","d0_0","q"   ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_wr_error_mode","d0_0","q"  ],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","woq","ff_wrq_clear_accum","d0_0","q"],["mcu","drif","reqq","woq","woq_empty"],"1'b1"], #woq empty
	[["mcu","drif","reqq","drq0","ff_rd_addr","d0_0","q"],				["mcu","drif","reqq","drq0","drq_rdq_empty"],"1'b1"],	#drq empty
	[["mcu","drif","reqq","drq0","ff_rd_collapse_fifo_cnt","d0_0","q"],["mcu","drif","reqq","drq0","drq_rdq_empty"],"1'b1"],	#drq empty
	[["mcu","drif","reqq","drq0","ff_wdq_out_cntr","d0_0","q "],		["mcu","drif","reqq","drq0","drq_wrq_empty"],"1'b1"],	#drq empty
	[["mcu","drif","reqq","drq0","ff_wr_addr","d0_0","q"],				["mcu","drif","reqq","drq0","drq_wrq_empty"],"1'b1"],	#drq empty
	[["mcu","drif","reqq","drq0","ff_wr_collapse_fifo_cnt","d0_0","q"],["mcu","drif","reqq","drq0","drq_wrq_empty"],"1'b1"],	#drq empty
	[["mcu","rdpctl","ff_fifo_deq_d1","d0_0","q"],["mcu","rdpctl","rdpctl_fifo_empty"],"1'b1"],	#otq empty
	[["mcu","fbdic","ff_latq_dout_reg","d0_0","q"],["mcu","fbdic","fbdic_latq_empty"],"1'b1"],	#latq empty
]



conditional_comparison_list_task_variable = [
	[["mcu","drif","errq","ff_ent0","d0_0","q"],"errq_valid_mask[0]","1'b1"],	
	[["mcu","drif","errq","ff_ent1","d0_0","q"],"errq_valid_mask[1]","1'b1"],	
	[["mcu","drif","errq","ff_ent2","d0_0","q"],"errq_valid_mask[2]","1'b1"],	
	[["mcu","drif","errq","ff_ent3","d0_0","q"],"errq_valid_mask[3]","1'b1"],	
	[["mcu","drif","errq","ff_ent4","d0_0","q"],"errq_valid_mask[4]","1'b1"],	
	[["mcu","drif","errq","ff_ent5","d0_0","q"],"errq_valid_mask[5]","1'b1"],	
	[["mcu","drif","errq","ff_ent6","d0_0","q"],"errq_valid_mask[6]","1'b1"],	
	[["mcu","drif","errq","ff_ent7","d0_0","q"],"errq_valid_mask[7]","1'b1"],	
	[["mcu","drif","errq","ff_ent8","d0_0","q"],"errq_valid_mask[8]","1'b1"],	
	[["mcu","drif","errq","ff_ent9","d0_0","q"],"errq_valid_mask[9]","1'b1"],	
	[["mcu","drif","errq","ff_ent10","d0_0","q"],"errq_valid_mask[10]","1'b1"],	
	[["mcu","drif","errq","ff_ent11","d0_0","q"],"errq_valid_mask[11]","1'b1"],	
	[["mcu","drif","errq","ff_ent12","d0_0","q"],"errq_valid_mask[12]","1'b1"],	
	[["mcu","drif","errq","ff_ent13","d0_0","q"],"errq_valid_mask[13]","1'b1"],	
	[["mcu","drif","errq","ff_ent14","d0_0","q"],"errq_valid_mask[14]","1'b1"],	
	[["mcu","drif","errq","ff_ent15","d0_0","q"],"errq_valid_mask[15]","1'b1"],	
	[["mcu","drif","errq","ff_ent16","d0_0","q"],"errq_valid_mask[16]","1'b1"],	
]

conditional_comparison_list_one_hot = [
	#[["l2t","filbuf","ff_l2_rd_state","d0_0","q"],4],			#Only fill buf location change. do we need to refect this in simics?
]
def needs_special_comparison_rule(s):
	for ffname in s :
		if("bist"  in ffname):	return True
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
	for condition in conditional_comparison_list_arry:	
		name = condition[0]
		if s[0:len(name)] == name[0:len(name)]:
			return True
	for condition in conditional_comparison_list_task_variable:	
		name = condition[0]
		if s[0:len(name)-2] == name[0:len(name)-2]:
			return True
	for condition in conditional_comparison_list_one_hot:	
		name = condition[0]
		if s[0:len(name)-2] == name[0:len(name)-2]:
			return True
	return False

	
DATAECC_protected_list = [
	#["l2b","evict","ff_wb_array_dout_r4a"],	
	["mcu","fbd0","frdbuf0","alat"]					,
	["mcu","fbd0","frdbuf1","alat"]                  ,
	["mcu","fbd0","frdbuf2","alat"]                  ,
	["mcu","fbd0","frdbuf3","alat"]                  ,
	["mcu","fbd0","frdbuf4","alat"]                  ,
	["mcu","fbd0","frdbuf5","alat"]                  ,
	["mcu","fbd0","frdbuf6","alat"]                  ,
	["mcu","fbd0","frdbuf7","alat"]                  ,
	["mcu","fbd0","frdbuf8","alat"]                  ,
	["mcu","fbd0","frdbuf9","alat"]                  ,
	["mcu","fbd0","frdbuf10","alat"]                 ,
	["mcu","fbd0","frdbuf11","alat"]                 ,
	["mcu","fbd0","frdbuf12","alat"]                 ,
	["mcu","fbd0","frdbuf13","alat"]                 ,
	["mcu","fbd0","frdbuf0","ff_buffer"]             ,
	["mcu","fbd0","frdbuf1","ff_buffer"]             ,
	["mcu","fbd0","frdbuf2","ff_buffer"]             ,
	["mcu","fbd0","frdbuf3","ff_buffer"]             ,
	["mcu","fbd0","frdbuf4","ff_buffer"]             ,
	["mcu","fbd0","frdbuf5","ff_buffer"]             ,
	["mcu","fbd0","frdbuf6","ff_buffer"]             ,
	["mcu","fbd0","frdbuf7","ff_buffer"]             ,
	["mcu","fbd0","frdbuf8","ff_buffer"]             ,
	["mcu","fbd0","frdbuf9","ff_buffer"]             ,
	["mcu","fbd0","frdbuf10","ff_buffer"]            ,
	["mcu","fbd0","frdbuf11","ff_buffer"]            ,
	["mcu","fbd0","frdbuf12","ff_buffer"]            ,
	["mcu","fbd0","frdbuf13","ff_buffer"]            ,
	["mcu","fbd0","frdbuf13","ff_buffer"]            ,
	["mcu","fbd0","frdbuf0","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf1","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf2","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf3","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf4","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf5","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf6","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf7","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf8","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf9","ff_data_sync"]          ,
	["mcu","fbd0","frdbuf10","ff_data_sync"]         ,
	["mcu","fbd0","frdbuf11","ff_data_sync"]         ,
	["mcu","fbd0","frdbuf12","ff_data_sync"]         ,
	["mcu","fbd0","frdbuf13","ff_data_sync"]         ,
	["mcu","fbd0","frdbuf13","ff_data_sync"]         ,
	["mcu","fbd1","frdbuf0","alat"]					,
	["mcu","fbd1","frdbuf1","alat"]                  ,
	["mcu","fbd1","frdbuf2","alat"]                  ,
	["mcu","fbd1","frdbuf3","alat"]                  ,
	["mcu","fbd1","frdbuf4","alat"]                  ,
	["mcu","fbd1","frdbuf5","alat"]                  ,
	["mcu","fbd1","frdbuf6","alat"]                  ,
	["mcu","fbd1","frdbuf7","alat"]                  ,
	["mcu","fbd1","frdbuf8","alat"]                  ,
	["mcu","fbd1","frdbuf9","alat"]                  ,
	["mcu","fbd1","frdbuf10","alat"]                 ,
	["mcu","fbd1","frdbuf11","alat"]                 ,
	["mcu","fbd1","frdbuf12","alat"]                 ,
	["mcu","fbd1","frdbuf13","alat"]                 ,
	["mcu","fbd1","frdbuf0","ff_buffer"]             ,
	["mcu","fbd1","frdbuf1","ff_buffer"]             ,
	["mcu","fbd1","frdbuf2","ff_buffer"]             ,
	["mcu","fbd1","frdbuf3","ff_buffer"]             ,
	["mcu","fbd1","frdbuf4","ff_buffer"]             ,
	["mcu","fbd1","frdbuf5","ff_buffer"]             ,
	["mcu","fbd1","frdbuf6","ff_buffer"]             ,
	["mcu","fbd1","frdbuf7","ff_buffer"]             ,
	["mcu","fbd1","frdbuf8","ff_buffer"]             ,
	["mcu","fbd1","frdbuf9","ff_buffer"]             ,
	["mcu","fbd1","frdbuf10","ff_buffer"]            ,
	["mcu","fbd1","frdbuf11","ff_buffer"]            ,
	["mcu","fbd1","frdbuf12","ff_buffer"]            ,
	["mcu","fbd1","frdbuf13","ff_buffer"]            ,
	["mcu","fbd1","frdbuf13","ff_buffer"]            ,
	["mcu","fbd1","frdbuf0","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf1","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf2","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf3","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf4","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf5","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf6","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf7","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf8","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf9","ff_data_sync"]          ,
	["mcu","fbd1","frdbuf10","ff_data_sync"]         ,
	["mcu","fbd1","frdbuf11","ff_data_sync"]         ,
	["mcu","fbd1","frdbuf12","ff_data_sync"]         ,
	["mcu","fbd1","frdbuf13","ff_data_sync"]         ,
	["mcu","fbd1","frdbuf13","ff_data_sync"]         ,
	["mcu","lndskw0","algnbf0","ff_buf"]            ,
	["mcu","lndskw0","algnbf1","ff_buf"]            ,
	["mcu","lndskw0","algnbf2","ff_buf"]            ,
	["mcu","lndskw0","algnbf3","ff_buf"]            ,
	["mcu","lndskw0","algnbf4","ff_buf"]            ,
	["mcu","lndskw0","algnbf5","ff_buf"]            ,
	["mcu","lndskw0","algnbf6","ff_buf"]            ,
	["mcu","lndskw0","algnbf7","ff_buf"]            ,
	["mcu","lndskw0","algnbf8","ff_buf"]            ,
	["mcu","lndskw0","algnbf9","ff_buf"]            ,
	["mcu","lndskw0","algnbf10","ff_buf"]           ,
	["mcu","lndskw0","algnbf11","ff_buf"]           ,
	["mcu","lndskw0","algnbf12","ff_buf"]           ,
	["mcu","lndskw0","algnbf13","ff_buf"]           ,
	["mcu","lndskw1","algnbf0","ff_buf"]            ,
	["mcu","lndskw1","algnbf1","ff_buf"]            ,
	["mcu","lndskw1","algnbf2","ff_buf"]            ,
	["mcu","lndskw1","algnbf3","ff_buf"]            ,
	["mcu","lndskw1","algnbf4","ff_buf"]            ,
	["mcu","lndskw1","algnbf5","ff_buf"]            ,
	["mcu","lndskw1","algnbf6","ff_buf"]            ,
	["mcu","lndskw1","algnbf7","ff_buf"]            ,
	["mcu","lndskw1","algnbf8","ff_buf"]            ,
	["mcu","lndskw1","algnbf9","ff_buf"]            ,
	["mcu","lndskw1","algnbf10","ff_buf"]           ,
	["mcu","lndskw1","algnbf11","ff_buf"]           ,
	["mcu","lndskw1","algnbf12","ff_buf"]           ,
	["mcu","lndskw1","algnbf13","ff_buf"]           ,
	["mcu","readdp0","u_rddata_in_63_0"]            ,
	["mcu","readdp0","u_rddata_in_127_64"]          ,
	["mcu","readdp1","u_rddata_in_63_0"]            ,
	["mcu","readdp1","u_rddata_in_127_64"]          ,
	["mcu","readdp0","u_rdecc_in_15_8"]          ,
	["mcu","readdp0","u_rdecc_in_7_0_par"]          ,
	["mcu","readdp1","u_rdecc_in_15_8"]          ,
	["mcu","readdp1","u_rdecc_in_7_0_par"]          ,
	["mcu","readdp0","u_rddata_in_127_64"]          ,
	["mcu","readdp0","u_rddata_in_63_0"]          ,
	["mcu","readdp1","u_rddata_in_127_64"]          ,
	["mcu","readdp1","u_rddata_in_63_0"]          ,
	["mcu","fbdiwr","u_ff_sbdata_crc_d1"]          ,
	["mcu","wrdp","u_io_data_63_0"]          ,
	["mcu","fdout","ff_fsr0_data"]          ,
	["mcu","fdout","ff_fsr1_data"]          ,
	["mcu","l2rdmx","u_rddata_127_64_p3"]          ,
	["mcu","l2rdmx","u_rddata_63_0_p3"]          ,
]

def is_DATAECC_protected(s):
	for name in DATAECC_protected_list:		
		if s[0:len(name)-1] == name[0:len(name)-1]:
			if name[len(name)-1] in s[len(name)-1]:
				if(s[-1] != "l1en"):
					return True
	return False;
	
def is_ECC_protected(s):
	if(is_DATAECC_protected(s)): return True
	return False;
	
def addIgnoredComparisons(fc,mcu_id):
	for name in comparison_ignore_list:
		name2 = ".".join(name[1:])
		fc.write("if(tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(mcu_id)+"."+name2+") begin\r\n")
		fc.write("	$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+"\");\r\n")	
		fc.write("end \r\n")
		
def addConditionalComparisons(fc,mcu_id):
	for condition in conditional_comparison_list:
		name = condition[0]		
		name2 = ".".join(name[1:])
		comparison_signal = condition[1]
		comparison_signal2 = ".".join(comparison_signal[1:])
		comparison_value = condition[2]
		fc.write("if(tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(mcu_id)+"."+name2+") begin\r\n")
		fc.write("	if(tb_top.cpu."+comparison_signal[0]+str(mcu_id)+"."+comparison_signal2+" == "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" while tb_top.cpu."+comparison_signal[0]+str(mcu_id)+"."+comparison_signal2+" == "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" while tb_top.cpu."+comparison_signal[0]+str(mcu_id)+"."+comparison_signal2+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");
		
def addConditionalComparisonsInv(fc,mcu_id):
	for condition in conditional_comparison_list_inv:
		name = condition[0]		
		name2 = ".".join(name[1:])
		comparison_signal = condition[1]
		comparison_signal2 = ".".join(comparison_signal[1:])
		comparison_value = condition[2]
		fc.write("if(tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(mcu_id)+"."+name2+") begin\r\n")
		fc.write("	if(tb_top.cpu."+comparison_signal[0]+str(mcu_id)+"."+comparison_signal2+" != "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" while tb_top.cpu."+comparison_signal[0]+str(mcu_id)+"."+comparison_signal2+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" while tb_top.cpu."+comparison_signal[0]+str(mcu_id)+"."+comparison_signal2+" == "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");
		

def addConditionalComparisonsTaskVariable(fc,l2_bank):
	for condition in conditional_comparison_list_task_variable:
		name = condition[0]		
		name2 = ".".join(name[1:])
		comparison_signal = condition[1]
		comparison_value = condition[2]
		fc.write("if(tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(l2_bank)+"."+name2+") begin\r\n")
		fc.write("	if("+comparison_signal+" == "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" while "+comparison_signal+" == "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" while "+comparison_signal+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");

		
def addOneHotChecks(fc,mcu_id):
	for condition in conditional_comparison_list_one_hot:
		name = condition[0]		
		name2 = ".".join(name[1:])
		bitwidth = condition[1];
		fc.write("if(tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(mcu_id)+"."+name2+") begin\r\n")		
		fc.write("	one_hotness_count = 0;\r\n")
		fc.write("	for(one_hotness_index = 0; one_hotness_index < "+str(bitwidth)+" ;one_hotness_index = one_hotness_index+1) begin\r\n")
		fc.write("		if( tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+"[one_hotness_index] != 1'b0 ) begin\r\n")
		fc.write("			one_hotness_count = one_hotness_count + 1;\r\n");
		fc.write("		end \r\n");
		fc.write("	end \r\n");
		fc.write("	if( one_hotness_count != 1 ) begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" does not satisfy one-hotness %x \",tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(mcu_id)+"."+name2+" satisfies one-hotness\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");

def addERRQValidMask(fc,mcu_id):
	#errq.wptr 	reg [16:0] errq_rptr_mask, errq_wptr_mask, errq_valid_mask
	fc.write("case(tb_top.cpu.mcu"+str(mcu_id)+".drif.errq.wptr)\r\n")
	fc.write("	0 : errq_rptr_mask = 17'b11111111111111111;\r\n")
	fc.write("	1 : errq_rptr_mask = 17'b01111111111111111;\r\n")
	fc.write("	2 : errq_rptr_mask = 17'b00111111111111111;\r\n")
	fc.write("	3 : errq_rptr_mask = 17'b00011111111111111;\r\n")
	fc.write("	4 : errq_rptr_mask = 17'b00001111111111111;\r\n")
	fc.write("	5 : errq_rptr_mask = 17'b00000111111111111;\r\n")
	fc.write("	6 : errq_rptr_mask = 17'b00000011111111111;\r\n")
	fc.write("	7 : errq_rptr_mask = 17'b00000001111111111;\r\n")
	fc.write("	8 : errq_rptr_mask = 17'b00000000111111111;\r\n")
	fc.write("	9 : errq_rptr_mask = 17'b00000000011111111;\r\n")
	fc.write("	10: errq_rptr_mask = 17'b00000000001111111;\r\n")
	fc.write("	11: errq_rptr_mask = 17'b00000000000111111;\r\n")
	fc.write("	12: errq_rptr_mask = 17'b00000000000011111;\r\n")
	fc.write("	13: errq_rptr_mask = 17'b00000000000001111;\r\n")
	fc.write("	14: errq_rptr_mask = 17'b00000000000000111;\r\n")
	fc.write("	15: errq_rptr_mask = 17'b00000000000000011;\r\n")
	fc.write("	16: errq_rptr_mask = 17'b00000000000000001;\r\n")
	fc.write("endcase\r\n")
	fc.write("case(tb_top.cpu.mcu"+str(mcu_id)+".drif.errq.rptr)\r\n")
	fc.write("	0 : errq_wptr_mask = 17'b00000000000000000;\r\n")
	fc.write("	1 : errq_wptr_mask = 17'b10000000000000000;\r\n")
	fc.write("	2 : errq_wptr_mask = 17'b11000000000000000;\r\n")
	fc.write("	3 : errq_wptr_mask = 17'b11100000000000000;\r\n")
	fc.write("	4 : errq_wptr_mask = 17'b11110000000000000;\r\n")
	fc.write("	5 : errq_wptr_mask = 17'b11111000000000000;\r\n")
	fc.write("	6 : errq_wptr_mask = 17'b11111100000000000;\r\n")
	fc.write("	7 : errq_wptr_mask = 17'b11111110000000000;\r\n")
	fc.write("	8 : errq_wptr_mask = 17'b11111111000000000;\r\n")
	fc.write("	9 : errq_wptr_mask = 17'b11111111100000000;\r\n")
	fc.write("	10: errq_wptr_mask = 17'b11111111110000000;\r\n")
	fc.write("	11: errq_wptr_mask = 17'b11111111111000000;\r\n")
	fc.write("	12: errq_wptr_mask = 17'b11111111111100000;\r\n")
	fc.write("	13: errq_wptr_mask = 17'b11111111111110000;\r\n")
	fc.write("	14: errq_wptr_mask = 17'b11111111111111000;\r\n")
	fc.write("	15: errq_wptr_mask = 17'b11111111111111100;\r\n")
	fc.write("	16: errq_wptr_mask = 17'b11111111111111110;\r\n")
	fc.write("endcase\r\n")
	fc.write("if (tb_top.cpu.mcu"+str(mcu_id)+".drif.errq.rptr < tb_top.cpu.mcu"+str(mcu_id)+".drif.errq.wptr) begin\r\n")	
	fc.write("	errq_valid_mask = errq_rptr_mask & errq_wptr_mask ;\r\n")
	fc.write("end\r\n")
	fc.write("else if (tb_top.cpu.mcu"+str(mcu_id)+".drif.errq.rptr > tb_top.cpu.mcu"+str(mcu_id)+".drif.errq.wptr) begin\r\n")
	fc.write("	errq_valid_mask = errq_rptr_mask | errq_wptr_mask ;\r\n")
	fc.write("end\r\n")
		
	
def addSpecialComprisons(fc,mcu_id):
	addIgnoredComparisons(fc,mcu_id)
	addConditionalComparisons(fc,mcu_id)
	addConditionalComparisonsInv(fc,mcu_id)
	addERRQValidMask(fc,mcu_id)	
	addConditionalComparisonsTaskVariable(fc,mcu_id)
	addOneHotChecks(fc,mcu_id)


	
for line in fp:
	s = line.strip()
	t = s.split(".")
	
	#exclude masters in M-S flip-flips
	if (t[-1] == "m" or (t[-1][:2] == "m[" and t[-1][-1] == "]")): continue
		
	#exclude scan flip-flops
	if (t[-1] == "l1"): continue

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


dv_root = os.getenv('DV_ROOT')
vhfile_name = dv_root + "/verif/env/fc/ff_injection/ff_injection_mcu"
print vhfile_name
vhfile_name_compare = dv_root + "/verif/env/fc/ff_injection/ff_compare_mcu"
print vhfile_name_compare

for mcu_id in range(4):
	try:
		f = open(vhfile_name+str(mcu_id)+".vh","w")
	except IOError, e:
		print e.errno
		print e
		
	try:
		fc = open(vhfile_name_compare+str(mcu_id)+".vh","w")
	except IOError, e:
		print e.errno
		print e
	
	if(mcu_id == 0):
		try:	
			f_ECC = open("ECC_protected_FFs_MCU.txt","w")
		except IOError, e:
			print e.errno
			print e

		
	f.write("task ff_injection_mcu_id"+str(mcu_id)+";\r\n")
	f.write("input integer ff_id;\r\n")
	f.write("begin\r\n")
	f.write("`ifdef FAULTY_MCU"+str(mcu_id)+"\r\n")
	f.write("`ifndef FAULTY_CCX\r\n")
	f.write("error_injection_cycle = global_cycle_cnt;\r\n")
	f.write("case(ff_id)\r\n")
	
	fc.write("task ff_compare_mcu_id"+str(mcu_id)+";\r\n")
	fc.write("integer mismatch_count;\r\n")
	fc.write("integer one_hotness_count;\r\n")
	fc.write("integer one_hotness_index;\r\n")
	fc.write("reg [16:0] errq_rptr_mask, errq_wptr_mask, errq_valid_mask;\r\n")
	fc.write("begin\r\n")
	fc.write("mismatch_count = 0;\r\n")
	fc.write("`ifdef FAULTY_MCU"+str(mcu_id)+"\r\n")
	fc.write("`ifndef FAULTY_CCX\r\n")
	
	ff_id = 0
	for ff in flat_ff_list:
		ff_s = ff.split(".")
		ff_s2 = list(ff_s);
		
		if(ff_s[0] == "mcu"):
			ff_s2[0] = "mcu" + str(mcu_id)
		ff_j = ".".join(ff_s2)
		
		f.write(str(ff_id)+"\t:\t$my_invert(tb_top.cpu."+ff_j+");\r\n");

		if not needs_special_comparison_rule(ff_s):
			fc.write("if(tb_top.cpu."+ff_j+" != tb_top.cpu.noerror_"+ff_j+") begin\r\n");
			fc.write("mismatch_count = mismatch_count + 1;\r\n");
			fc.write("$display(\"pending FF error : tb_top.cpu."+ff_j+" %b - %b\",tb_top.cpu."+ff_j+",tb_top.cpu.noerror_"+ff_j+");\r\n");
			fc.write("end \r\n");
		
		if(mcu_id == 0):
			if is_DATAECC_protected(ff_s):
				f_ECC.write("%d %s\n" %(ff_id,ff_j));
		
		ff_id += 1
	f.write("endcase\r\n")
	f.write("`else\r\n")
	f.write("$display(\"Error injection to MCU"+str(mcu_id)+" is not enabled. Add -config_rtl=FAULTY_MCU"+str(mcu_id)+" to enable\");\r\n");
	f.write("`endif //!FAULTY_CCX\r\n")
	f.write("`endif //FAULTY_MCU"+str(mcu_id)+"\r\n")
	f.write("end\r\n")
	f.write("endtask\r\n")
	f.close()
	
	#special comparison rules
	addSpecialComprisons(fc,mcu_id)
	
	fc.write("`endif //!FAULTY_CCX\r\n")
	fc.write("`endif //FAULTY_MCU"+str(mcu_id)+"\r\n")
	fc.write("vera_shell.ffMismatchCountSet(mismatch_count);\r\n")
	fc.write("end\r\n")
	fc.write("endtask\r\n")
	fc.close()
	
	f_ECC.close()

	

#a file to be included in UncoreExternal.vr to setup the number of flip-flops.
vhfile_name = dv_root + "/verif/env/fc/vera/include/mcu_ff_init.vri"
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
classifier_fname = dv_root + "/script/ff_classify_mcu.sh"
print classifier_fname
try:
	f = open(classifier_fname,"w")
except IOError, e:
	print e.errno
	print e
f.write("#!/bin/bash\n")
f.write("mcu_submodule_num="+str(len(ffcs)-1)+"\n")
f.write("mcu_submodule_names=( ") 
for ffc in ffcs_sorted:	
	if(ffc=="excluded"): continue
	f.write(ffc+" ")
f.write(")\n")
f.write("mcu_submodule_ff_num_max=( ") 
ff_idnum_acc= 0
for ffc in ffcs_sorted:	
	if(ffc=="excluded"): continue
	ff_idnum_acc += len(ffcs[ffc])
	f.write(str(ff_idnum_acc)+" ")
f.write(")\n")
f.write("for ((i=0;i<$mcu_submodule_num;i=i+1))\n")
f.write("do\n")
f.write("	if [ $1 -lt ${mcu_submodule_ff_num_max[$i]} ]\n")
f.write("	then\n")
f.write("		echo ${mcu_submodule_names[$i]}\n")
f.write("		break\n")
f.write("	fi\n")
f.write("done\n")
st = os.stat(classifier_fname)
os.chmod(classifier_fname, st.st_mode | stat.S_IEXEC)

