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
		if(n.find("spare")>=0):
			return True
	return False
	
def filter_arb(x): 
	names1 =["arbdec", "arb", "arbadr", "arbdat"]
	#####if x[0] == "l2t" and x[1] =="arbadr" and x[2] == "ff_arbdp_addr_c12" : return False #RDMA
	if x[0] == "l2t" and x[1] =="arbdec" and x[2] == "ff_mb_data_read_data0" : return False #mbist
	if x[0] == "l2t" and x[1] =="arbdec" and x[2] == "ff_mb_data_read_data1" : return False #mbist
	return x[0] == "l2t" and x[1] in names1
	
def filter_tag(x): 
	names1 =["tagctl", "tagd", "tagdp", "tagl_2", "tagl_1", "tag"]
	if x[0] == "l2t" and x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_reg_d_lft" : return False #redundant array eFuse
	if x[0] == "l2t" and x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_reg_d_rgt" : return False #redundant array eFuse
	if x[0] == "l2t" and x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_reg_en_lft" : return False #redundant array eFuse
	if x[0] == "l2t" and x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_reg_en_rgt" : return False #redundant array eFuse
	if x[0] == "l2t" and x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_rid_lft" : return False #redundant array eFuse
	if x[0] == "l2t" and x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_rid_rgt" : return False #redundant array eFuse
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_tag_siu_req_state" : return False #SIU
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_inc_rdma_cnt_c4" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_misbuf_rdma_reg_vld_c2" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_rdma_inst_c2" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_rdma_inst_c3" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_rdma_reg_vld" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_rdma_vld_px0_p" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_rdma_vld_px1" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_rdmard_cnt" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_sel_rdma_inval_vec_c4" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_sel_rdma_inval_vec_c5" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_set_rdma_reg_vld_c4" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_tag_rdma_ev_en_c3" : return False #RDMA
	#####if x[0] == "l2t" and x[1] =="tagctl" and x[2] == "ff_tag_rdma_wr_comp_c4" : return False #RDMA
	return x[0] == "l2t" and x[1] in names1

 
def filter_array(x): 
	names1 =["ctr", "quad_bot_right", "quad_bot_left", "quad_top_right", "quad_top_left", "tag", "evctag", "perif_io"]
	if(x[-1][:7] == "red_col" or x[-1][:7] == "red_odd" or x[-1][:8] == "red_even"):	#registers for redundant column
		return False 		
	if(x[0] == "l2d" and x[1] == "ctr" and x[2] == "tstmod"): # test mode?
		return False 		
	return x[0] == "l2d" and x[1] in names1

def filter_dir(x): 
	names1 =["dc_row2", "dc_row2_ctl", "dc_row0_ctl", "dc_out_col3", "dc_out_col2", "dc_out_col1", "dc_out_col0", "dc_row0"
			, "ic_row2_ctl", "ic_row0_ctl", "ic_row2", "out_col3", "out_col2", "out_col1", "out_col0", "ic_row0"			
			, "dirrep", "dirvec"]
	return x[0] == "l2t" and x[1] in names1
	
def filter_iq(x): 
	names1 =["iqarray", "iqu", "ique"]
	return x[0] == "l2t" and x[1] in names1

def filter_oq(x): 
	names1 =["oque", "oqarray", "oqu"]
	#####if(x[0] == "l2t" and x[1] == "oqu" and x[2] == "ff_rdma_inv_c7"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "oqu" and x[2] == "ff_rdma_req_state_0"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "oqu" and x[2] == "ff_rdma_state"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "oqu" and x[2] == "ff_rdma_to_xbarq_c7"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "oqu" and x[2] == "ff_rdma_wr_comp_c5"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "oqu" and x[2] == "ff_rdma_wr_comp_c52"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "oqu" and x[2] == "ff_rdma_inv_c7"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "oqu" and x[2] == "ff_rdma_inv_c7"): return False # RDMA
	return x[0] == "l2t" and x[1] in names1
 
def filter_wb(x): 
	names1t =["wbtag", "wbuf", "wbufrpt", "evctag"]
	names1b =["evict", "wb_array1", "wb_array2", "wb_array3", "wb_array4"]
	#####if x[0] == "l2t" and x[1] =="evctag" and x[2] =="ff_wb_rdma_write_addr": return False #rdma	
	#####if(x[0] == "l2b" and x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice"): return False # RDMA
	#####if(x[0] == "l2b" and x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice_v1"): return False # RDMA
	#####if(x[0] == "l2b" and x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice_v2"): return False # RDMA
	#####if(x[0] == "l2b" and x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice_v3"): return False # RDMA
	#####if(x[0] == "l2b" and x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice_v4"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "wbuf" and x[2] == "ff_l2t_l2b_rdma_rdwl_r0"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "wbuf" and x[2] == "ff_latched_rdma_read_en"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "wbuf" and x[2] == "ff_latched_rdmad_read_wl"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "wbufrpt" and x[2] == "ff_latched_rdma_read_en"): return False # RDMA
	return (x[0] == "l2t" and x[1] in names1t) or (x[0] == "l2b" and x[1] in names1b)

def filter_decc(x): 
	names1 =["decc", "deccck"]
	return x[0] == "l2t" and x[1] in names1
	
def filter_fb(x): 
	names1t =["fbtag", "filbuf"]
	names1b =["fbd", "fb_array1", "fb_array2", "fb_array3", "fb_array4"]
	#####if(x[0] == "l2t" and x[1] == "filbuf" and x[2] == "ff_rdma_inst_c2"): return False # RDMA
	return (x[0] == "l2t" and x[1] in names1t) or (x[0] == "l2b" and x[1] in names1b)
	
def filter_mb(x): 
	names1 =["mbtag", "mbdata", "misbuf"]
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_dep_rdmat_mbid_d1"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_mb_rdma_count_c4"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_bit"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c4"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c5"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c52"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c6"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c7"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c8"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_inst_c2"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_inst_c3"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdma_reg_vld_c3"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "misbuf" and x[2] == "ff_rdmatb_dep_rdy_en_d1"): return False # RDMA
	return x[0] == "l2t" and x[1] in names1	 

def filter_vuad(x): 
	names1 =["subarray_11", "subarray_10", "subarray_9", "subarray_8", "subarray_3", "subarray_2", "subarray_1", "subarray_0", "usaloc", "vlddir", "vuadpm", "vuad"]
	return x[0] == "l2t" and x[1] in names1
	
def filter_csr(x): 
	names1 =["csreg", "csr"]
	if(x[0] == "l2t" and x[1] == "csr" and x[2] == "ff_bist_registrer"): return False # not used at all
	#####if(x[0] == "l2t" and x[1] == "csreg" and x[2] == "ff_rdmard_cerr_c13"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "csreg" and x[2] == "ff_rdmard_notdata_err_c13"): return False # RDMA
	#####if(x[0] == "l2t" and x[1] == "csreg" and x[2] == "ff_rdmard_uerr_c13"): return False # RDMA
	if(x[0] == "l2t" and x[1] == "csr" and x[2] == "ff_debug_address_inpipe"): return False # debug
	return x[0] == "l2t" and x[1] in names1

def filter_siu(x): 
	names1t =["snpd", "snp"]
	names1b =["siu_interface"]
	return (x[0] == "l2t" and x[1] in names1t) or (x[0] == "l2b" and x[1] in names1b)
	
def filter_rdma(x): 
	names1t =["rdmat", "rdmatag", "rdmarpt"]
	names1b =["rdmard","rdma_array1", "rdma_array2", "rdma_array3", "rdma_array4"]
	return (x[0] == "l2t" and x[1] in names1t) or (x[0] == "l2b" and x[1] in names1b)

def filter_excluded(x):
	if(x[0] == "l2t"):
		if(x[2] == "efuse_l2d_header"): return True	#eFuse
		if(x[1] == "mb0"): return True	#MBIST					#clock gated!
		if(x[1] == "mb2_control"): return True	#MBIST			#clock gated!
		if(x[1] == "right_ffrptr"): return True	#Repeater
		if(x[1] == "left_ffrptr"): return True	#Repeater
		#####if(x[1] == "rdmat"): return True	#RDMA
		#####if(x[1] == "rdmatag"): return True	#RDMA
		#####if(x[1] == "rdmarpt"): return True	#RDMA
		#####if(x[1] == "snpd"): return True	#SIU
		#####if(x[1] == "snp"): return True	#SIU
		if(x[1] == "shadow_scan"): return True	#scan?
		if(x[1] == "l2drpt"): return True	#Repeater
		if(x[1] == "mbist"): return True	#MBIST				#clock gated!
		if(x[1] == "dmologic"): return True	#DMO
		if(x[1] == "l2t_clk_header"): return True	#clk?
		#####if x[1] =="evctag" and x[2] =="ff_wb_rdma_write_addr": return True #rdma
		if x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_reg_d_lft" : return True #redundant array eFuse
		if x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_reg_d_rgt" : return True #redundant array eFuse
		if x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_reg_en_lft" : return True #redundant array eFuse	
		if x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_reg_en_rgt" : return True #redundant array eFuse	
		if x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_rid_lft" : return True #redundant array eFuse
		if x[1] =="tag" and x[2][:4] == "quad" and x[3][:4] == "bank" and x[4] == "lat_rid_rgt" : return True #redundant array eFuse	
		#####if x[1] =="tagctl" and x[2] == "ff_tag_siu_req_state" : return True #SIU
		#####if x[1] =="tagctl" and x[2] == "ff_inc_rdma_cnt_c4" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_misbuf_rdma_reg_vld_c2" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_rdma_inst_c2" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_rdma_inst_c3" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_rdma_reg_vld" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_rdma_vld_px0_p" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_rdma_vld_px1" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_rdmard_cnt" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_sel_rdma_inval_vec_c4" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_sel_rdma_inval_vec_c5" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_set_rdma_reg_vld_c4" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_tag_rdma_ev_en_c3" : return True #RDMA
		#####if x[1] =="tagctl" and x[2] == "ff_tag_rdma_wr_comp_c4" : return True #RDMA
		if x[1] =="csr" and x[2] == "ff_bist_registrer" : return True #redundant array eFuse	
		if x[1] =="csreg" and x[2] == "ff_bist_reg_write_en_d1" : return True #redundant array eFuse	
		#####if(x[1] == "csreg" and x[2] == "ff_rdmard_cerr_c13"): return True # RDMA
		#####if(x[1] == "csreg" and x[2] == "ff_rdmard_notdata_err_c13"): return True # RDMA
		#####if(x[1] == "csreg" and x[2] == "ff_rdmard_uerr_c13"): return True # RDMA
		#####if(x[1] == "filbuf" and x[2] == "ff_rdma_inst_c2"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_dep_rdmat_mbid_d1"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_mb_rdma_count_c4"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_bit"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c4"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c5"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c52"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c6"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c7"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_comp_rdy_c8"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_inst_c2"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_inst_c3"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdma_reg_vld_c3"): return True # RDMA
		#####if(x[1] == "misbuf" and x[2] == "ff_rdmatb_dep_rdy_en_d1"): return True # RDMA
		#####if(x[1] == "oqu" and x[2] == "ff_rdma_inv_c7"): return True # RDMA
		#####if(x[1] == "oqu" and x[2] == "ff_rdma_req_state_0"): return True # RDMA
		#####if(x[1] == "oqu" and x[2] == "ff_rdma_state"): return True # RDMA
		#####if(x[1] == "oqu" and x[2] == "ff_rdma_to_xbarq_c7"): return True # RDMA
		#####if(x[1] == "oqu" and x[2] == "ff_rdma_wr_comp_c5"): return True # RDMA
		#####if(x[1] == "oqu" and x[2] == "ff_rdma_wr_comp_c52"): return True # RDMA
		#####if(x[1] == "oqu" and x[2] == "ff_rdma_inv_c7"): return True # RDMA
		#####if(x[1] == "oqu" and x[2] == "ff_rdma_inv_c7"): return True # RDMA
		#####if(x[1] == "wbuf" and x[2] == "ff_l2t_l2b_rdma_rdwl_r0"): return True # RDMA
		#####if(x[1] == "wbuf" and x[2] == "ff_latched_rdma_read_en"): return True # RDMA
		#####if(x[1] == "wbuf" and x[2] == "ff_latched_rdmad_read_wl"): return True # RDMA
		#####if(x[1] == "wbufrpt" and x[2] == "ff_latched_rdma_read_en"): return True # RDMA
		#####if(x[1] == "arbadr" and x[2] == "ff_arbdp_addr_c12"): return True # RDMA
		if(x[1] =="arbdec" and x[2] == "ff_mb_data_read_data0") : return True #mbist
		if(x[1] =="arbdec" and x[2] == "ff_mb_data_read_data1") : return True #mbist
		if(x[1] == "csr" and x[2] == "ff_debug_address_inpipe"): return True # debug
	elif(x[0] == "l2b"):
		if(x[2] == "efuse_l2d_header"): return True	#eFuse
		#####if(x[1] == "rdma_array1"): return True	#RDMA
		#####if(x[1] == "rdma_array2"): return True	#RDMA
		#####if(x[1] == "rdma_array3"): return True	#RDMA
		#####if(x[1] == "rdma_array4"): return True	#RDMA
		#####if(x[1] == "siu_interface"): return True	#SIU
		#####if(x[1] == "rdmard"): return True	#RDMA
		if(x[1] == "mb0"): return True	#MBIST
		if(x[1] == "clock_header"): return True	#clk?
		#####if(x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice"): return True # RDMA
		#####if(x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice_v1"): return True # RDMA
		#####if(x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice_v2"): return True # RDMA
		#####if(x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice_v3"): return True # RDMA
		#####if(x[1] == "evict" and x[2] == "ff_rdma_control_regs_slice_v4"): return True # RDMA
	elif(x[0] == "l2d"):
		if(x[1] == "l2d_clk_header"): return True	#clk?
		if(x[-1][:7] == "red_col" or x[-1][:7] == "red_odd" or x[-1][:8] == "red_even"): return True	#registers for redundant column
		if(x[1] == "ctr" and x[2] == "tstmod"): return True # test mode?
	return False
	
def classify_ff(s):
	if(pre_filter_mbist(s)): return "excluded"
	
	if(filter_arb(s)): 
		if(is_ECC_protected(s)): return "arb_ECC"
		else: return "arb"
	elif(filter_tag(s)): 
		if(is_ECC_protected(s)): return "tag_ECC"
		else: return "tag"
	elif(filter_array(s)):
		if(is_ECC_protected(s)): return "array_ECC"
		else: return "array"
	elif(filter_dir(s)):
		if(is_ECC_protected(s)): return "dir_ECC"
		else: return "dir"
	elif(filter_iq(s)):
		if(is_ECC_protected(s)): return "iq_ECC"
		else: return "iq"
	elif(filter_oq(s)):
		if(is_ECC_protected(s)): return "oq_ECC"
		else: return "oq"
	elif(filter_wb(s)):
		if(is_ECC_protected(s)): return "wb_ECC"
		else: return "wb"
	elif(filter_mb(s)):
		if(is_ECC_protected(s)): return "mb_ECC"
		else: return "mb"
	elif(filter_fb(s)):
		if(is_ECC_protected(s)): return "fb_ECC"
		else: return "fb"
	elif(filter_decc(s)):
		if(is_ECC_protected(s)): return "decc_ECC"
		else: return "decc"
	elif(filter_vuad(s)):
		if(is_ECC_protected(s)): return "vuad_ECC"
		else: return "vuad"
	elif(filter_csr(s)):
		if(is_ECC_protected(s)): return "csr_ECC"
		else: return "csr"
	elif(filter_siu(s)):
		if(is_ECC_protected(s)): return "siu_ECC"
		else: return "siu"
	elif(filter_rdma(s)):
		if(is_ECC_protected(s)): return "rdma_ECC"
		else: return "rdma"
	elif(filter_excluded(s)): return "excluded"
	else : 
		print s
		return ""
	
ffcs = {"arb":[],"tag":[],"array":[],"dir":[],"iq":[],"oq":[],"wb":[],"mb":[],"fb":[],"decc":[],"vuad":[],"csr":[],"siu":[],"rdma":[]
		,"arb_ECC":[],"tag_ECC":[],"array_ECC":[],"dir_ECC":[],"iq_ECC":[],"oq_ECC":[],"wb_ECC":[],"mb_ECC":[],"fb_ECC":[],"decc_ECC":[],"vuad_ECC":[],"csr_ECC":[],"siu_ECC":[],"rdma_ECC":[]
		,"excluded":[]}

comparison_ignore_list = [
	#["l2t","tagdp","ff_lru_state","d0_0","q"],			#Only way change. do we need to refect this in simics?
	#["l2t","tagdp","ff_lru_state_quad0","d0_0","q"],	#Only way change. do we need to refect this in simics?
	#["l2t","tagdp","ff_lru_state_quad1","d0_0","q"],	#Only way change. do we need to refect this in simics?
	#["l2t","tagdp","ff_lru_state_quad2","d0_0","q"],	#Only way change. do we need to refect this in simics?
	#["l2t","tagdp","ff_lru_state_quad3","d0_0","q"],	#Only way change. do we need to refect this in simics?
	["l2t","tagdp","ff_lru_way_c3","d0_0","q"],			#Only way change. do we need to refect this in simics?
	["l2t","tagdp","ff_lru_way_c3_1","d0_0","q"],		#Only way change. do we need to refect this in simics?
	["l2t","tagctl","ff_encoded_lru_c4","d0_0","q"],	#Only way change. do we need to refect this in simics?
	["l2t","tagdp","ff_lru_quad_muxsel_c2","d0_0","q"],	#Only way change. do we need to refect this in simics?
	["l2t","csr","ff_csr_l2_control_reg_steering","d0_0","q"],	#Only affects error reporting
	["l2t","csr","ff_csr_l2_erraddr_d1","d0_0","q"],	#Only affects error reporting
	["l2t","csr","ff_csr_l2_erritid_d1","d0_0","q"],	#Only affects error reporting
	["l2t","csr","ff_csr_l2_errstate_d1","d0_0","q"],	#Only affects error reporting
	["l2t","csr","ff_csr_l2_errsynd_d1","d0_0","q"],	#Only affects error reporting
	["l2t","csr","ff_csr_l2_notdata_addr_d1","d0_0","q"],	#Only affects error reporting
	["l2t","csr","ff_csr_l2_notdata_vcid_d1","d0_0","q"],	#Only affects error reporting
	["l2t","csr","ff_l2_compare_register","d0_0","q"],	#Only affects error reporting
	["l2t","csr","ff_l2_mask_register","d0_0","q"],		#Only affects error reporting
	["l2t","filbuf","ff_fb_cerr","d0_0","q"],			#Only affects error reporting
	["l2t","filbuf","ff_fb_uerr","d0_0","q"],			#Only affects error reporting
	#["l2t","filbuf","ff_l2_rd_state","d0_0","q"],			#Only fill buf location change. do we need to refect this in simics?
	#["l2t","filbuf","ff_l2_rd_state_quad0","d0_0","q"],			#Only fill buf location change. do we need to refect this in simics?
	#["l2t","filbuf","ff_l2_rd_state_quad1","d0_0","q"],			#Only fill buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state_quad0","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state_quad1","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state_quad2","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state_quad3","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state_quad4","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state_quad5","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state_quad6","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#	["l2t","misbuf","ff_l2_state_quad7","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state","d0_0","q"],				#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state_quad0","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state_quad1","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state_quad2","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state_quad3","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state_quad4","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state_quad5","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state_quad6","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","misbuf","ff_mcu_state_quad7","d0_0","q"],			#Only miss buf location change. do we need to refect this in simics?
	#["l2t","wbuf","ff_quad_state","d0_0","q"],			#Only wb buf location change. do we need to refect this in simics?
	#["l2t","wbuf","ff_quad0_state","d0_0","q"],			#Only wb buf location change. do we need to refect this in simics?
	#["l2t","wbuf","ff_quad1_state","d0_0","q"],			#Only wb buf location change. do we need to refect this in simics?
	#["l2t","wbuf","ff_quad2_state","d0_0","q"],			#Only wb buf location change. do we need to refect this in simics?
	["l2t","arb","ff_dir_addr_c8","d0_0","q"],			#Error reporting
	["l2t","arb","ff_dir_addr_c9","d0_0","q"],			#Error reporting
	["l2t","arb","ff_dir_addr_cnt_c4","d0_0","q"],			#Error reporting
	["l2t","arb","ff_dir_addr_cnt_c5","d0_0","q"],			#Error reporting
	["l2t","arb","ff_dir_addr_cnt_c52","d0_0","q"],			#Error reporting
	["l2t","arb","ff_dir_addr_cnt_c6","d0_0","q"],			#Error reporting
	["l2t","arb","ff_dir_addr_cnt_c7","d0_0","q"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[0]"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[1]"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[2]"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[3]"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[4]"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[5]"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[6]"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[7]"],			#Error reporting
	["l2t","arbadr","ff_data_ecc_idx","d0_0","q[8]"],			#Error reporting
	["l2t","evctag","ff_mb_read_data","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_mbf_entry_d2","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_rqtyp_d2","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_stinst_0","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_stinst_1","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_stinst_2","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_stinst_3","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_stinst_4","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_stinst_5","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_stinst_6","d0_0","q"],			#array buffer
	["l2t","filbuf","ff_stinst_7","d0_0","q"],			#array buffer
	["l2t","ique","ff_l2t_mb2_wdata","d0_0","q"],			#array buffer
	["l2t","arbdec","ff_mb_data_read_data0","d0_0","q"],
	["l2t","arbdec","ff_mb_data_read_data1","d0_0","q"],
		
	["l2t","arb","ff_dir_addr_cnt","d0_0","q"],			#Does not have functional difference
	["l2t","dirrep","ff_dc_rd_en_c4","d0_0","q"],			#Does not have functional difference
	["l2t","dirrep","ff_ic_rd_en_c4","d0_0","q"],			#Does not have functional difference
	["l2t","dirrep","ff_inval_addrbit4_c4","d0_0","q[0]"],			#Does not have functional difference
	
	["l2t","iqu","ff_array_wr_ptr","d0_0","q"],			#Extra cycle will solve
	["l2t","iqu","ff_array_rd_ptr","d0_0","q"],			#Extra cycle will solve
	["l2t","ique","ff_iq_array_rd_data_c2_1","d0_0","q"],			#Extra cycle will solve
	["l2t","ique","ff_iq_array_rd_data_c2_2","d0_0","q"],			#Extra cycle will solve
	#["l2t","oqu","ff_enc_wr_ptr_d2","d0_0","q"],			#Extra cycle will solve
	["l2t","iqu","ff_array_wr_ptr_plus1","d0_0","q"],			#Does not matter
	#["l2t","oqu","ff_oq_cnt_plus1_d1","d0_0","q"],			#Does not matter
	#["l2t","oqu","ff_oq_cnt_minus1_d1","d0_0","q"],			#Does not matter
	["l2t","evctag","ff_shifted_index","d0_0","q"],			#temporary
	["l2t","tagd","ff_ecc_staging1_4","d0_0","q"],			#temporary
	["l2t","tagd","ff_ecc_staging5_8","d0_0","q"],			#temporary
	["l2t","tag","ff_rd_en","d0_0","q"],			#temporary
	["l2b","evict","ff_wb_control_regs_slice_v1","d0_0","q"],			#temporary
	["l2b","evict","ff_wb_control_regs_slice_v2","d0_0","q"],			#temporary
	["l2b","evict","ff_wb_control_regs_slice_v3","d0_0","q"],			#temporary
	["l2b","evict","ff_wb_control_regs_slice_v4","d0_0","q"],			#temporary
	["l2t","wbuf","ff_latched_wb_read_wl","d0_0","q"],			#temporary
	["l2t","wbuf","ff_l2t_l2b_wbrd_wl_r0","d0_0","q"],			#temporary
	
	#excluded FFs
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[8]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[9]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[10]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[11]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[12]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[13]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[14]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[15]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[16]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[17]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[18]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[19]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[20]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[21]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[22]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[23]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[24]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[25]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[26]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[27]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[28]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[29]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[30]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[31]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[32]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[33]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[34]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[35]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[36]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[37]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[38]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[39]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[40]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[41]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[42]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[43]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[44]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[45]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[46]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[47]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[48]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[49]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[50]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[51]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[52]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[53]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[54]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[55]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[56]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[57]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[58]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[59]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[60]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[61]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[62]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[63]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[64]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[65]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[66]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[67]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[68]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[69]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[70]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[71]"],			#unused
	["l2b","mb0","mbist_misc_output_reg","d0_0","q[72]"],			#unused
	["l2t","snpd","ff_instr1_entry","d0_0","q"],			#temporary
	["l2t","snpd","ff_addr1_1_MERGED","d0_0","q"],			#temporary
	["l2t","snpd","ff_data0_1","d0_0","q"],					#temporary
	["l2t","snpd","ff_data0_2","d0_0","q"],					#temporary
	["l2t","snpd","ff_data1_1","d0_0","q"],					#temporary
	["l2t","snpd","ff_data1_2","d0_0","q"],					#temporary
	["l2t","snpd","ff_addr0_2","d0_0","q"],					#temporary
	["l2t","snpd","ff_addr1_2","d0_0","q"],					#temporary
	["l2t","snpd","ff_MERGED","d0_0","q"],					#temporary
	["l2t","snpd","ff_snp_rd_ptr_d1_5_MERGED","d0_0","q"],					#temporary
	["l2t","snpd","ff_instr0_entry","d0_0","q"],					#temporary
	
	["l2t","dc_out_col0","ff_mbist_dirin_rddata_out_c52","d0_0","q"],	#mbist
	["l2t","dc_out_col0","ff_mbist_wdata_r2_r3_split2","d0_0","q"],		#mbist
	["l2t","dc_out_col0","ff_mbist_wdata_r2_r3_split1","d0_0","q"],		#mbist
	["l2t","dc_out_col0","ff_lookup_cmp_data","d0_0","q"],				#mbist
	["l2t","dc_out_col1","ff_mbist_dirin_rddata_out_c52","d0_0","q"],	#mbist
	["l2t","dc_out_col1","ff_mbist_wdata_r2_r3_split2","d0_0","q"],		#mbist
	["l2t","dc_out_col1","ff_mbist_wdata_r2_r3_split1","d0_0","q"],		#mbist
	["l2t","dc_out_col1","ff_lookup_cmp_data","d0_0","q"],				#mbist
	["l2t","dc_out_col2","ff_mbist_dirin_rddata_out_c52","d0_0","q"],	#mbist
	["l2t","dc_out_col2","ff_mbist_wdata_r2_r3_split2","d0_0","q"],		#mbist
	["l2t","dc_out_col2","ff_mbist_wdata_r2_r3_split1","d0_0","q"],		#mbist
	["l2t","dc_out_col2","ff_lookup_cmp_data","d0_0","q"],				#mbist
	["l2t","dc_out_col3","ff_mbist_dirin_rddata_out_c52","d0_0","q"],	#mbist
	["l2t","dc_out_col3","ff_mbist_wdata_r2_r3_split2","d0_0","q"],		#mbist
	["l2t","dc_out_col3","ff_mbist_wdata_r2_r3_split1","d0_0","q"],		#mbist
	["l2t","dc_out_col3","ff_lookup_cmp_data","d0_0","q"],				#mbist
	["l2t","out_col0","ff_mbist_dirin_rddata_out_c52","d0_0","q"],		#mbist
	["l2t","out_col0","ff_mbist_wdata_r2_r3_split2","d0_0","q"],		#mbist
	["l2t","out_col0","ff_mbist_wdata_r2_r3_split1","d0_0","q"],		#mbist
	["l2t","out_col0","ff_lookup_cmp_data","d0_0","q"],					#mbist
	["l2t","out_col1","ff_mbist_dirin_rddata_out_c52","d0_0","q"],		#mbist
	["l2t","out_col1","ff_mbist_wdata_r2_r3_split2","d0_0","q"],		#mbist
	["l2t","out_col1","ff_mbist_wdata_r2_r3_split1","d0_0","q"],		#mbist
	["l2t","out_col1","ff_lookup_cmp_data","d0_0","q"],					#mbist
	["l2t","out_col2","ff_mbist_dirin_rddata_out_c52","d0_0","q"],		#mbist
	["l2t","out_col2","ff_mbist_wdata_r2_r3_split2","d0_0","q"],		#mbist
	["l2t","out_col2","ff_mbist_wdata_r2_r3_split1","d0_0","q"],		#mbist
	["l2t","out_col2","ff_lookup_cmp_data","d0_0","q"],					#mbist
	["l2t","out_col3","ff_mbist_dirin_rddata_out_c52","d0_0","q"],		#mbist
	["l2t","out_col3","ff_mbist_wdata_r2_r3_split2","d0_0","q"],		#mbist
	["l2t","out_col3","ff_mbist_wdata_r2_r3_split1","d0_0","q"],		#mbist
	["l2t","out_col3","ff_lookup_cmp_data","d0_0","q"],					#mbist
	["l2t","rdmat","ff_mb_run","d0_0","q"],								# do nothing?
	["l2d","ctr","tstmod","msff_buf_out_fine","d0_0","q"],						# do nothing?
	["l2d","ctr","tstmod","msff_buf_out_corse","d0_0","q"],						# do nothing?
	["l2d","ctr","tstmod","msff_buf_out_bot","d0_0","q"],						# do nothing?
	["l2d","ctr","tstmod","msff_buf_out_top","d0_0","q"],						# do nothing?
	["l2t","evctag","ff_wb_rdma_write_addr","d0_0","q"],				# temporary
	["l2t","snp","ff_rd_ptr","d0_0","q"],				# temporary
	["l2t","snp","ff_wr_ptr","d0_0","q"],				# temporary
	["l2t","snp","ff_winv_rq_active_s2","d0_0","q"],				# temporary
	["l2t","snp","ff_winv_rq_active_s2_1","d0_0","q"],				# temporary
	["l2t","evctag","ff_other_cam_match","d0_0","q"],				# mbist
	["l2t","dirvec","ff_cam_tst_failed00","d0_0","q"],				# mbist
	["l2t","tagd","ff_piped_vuad0","d0_0","q"],				# mbist
	["l2t","tagd","ff_piped_vuad1","d0_0","q"],				# mbist
	["l2b","evict","ff_fb_rw_fail","d0_0","q"],				# mbist
	["l2b","fbd","ff_fb_rw_fail","d0_0","q"],				# mbist
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_1","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_2","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_3","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_4","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_5","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_6","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_7","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_8","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_9","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_10","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_11","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_12","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_13","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_14","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_15","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c9_16","d0_0","q"],				# temporary
	["l2b","rdmard","ff_l2d_l2b_decc_out_c10","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_1","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_2","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_3","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_4","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_5","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_6","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_7","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_8","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_9","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_10","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_11","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_12","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_13","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_14","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_15","d0_0","q"],				# temporary
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_16","d0_0","q"],				# temporary
	["l2t","arbdec","ff_inst_size_c8","d0_0","q[10]"],				# mbist
	["l2t","arbdec","ff_inst_size_c8","d0_0","q[11]"],				# mbist
	["l2t","arbdec","ff_inst_size_c8","d0_0","q[12]"],				# mbist
	["l2t","arbdec","ff_inst_size_c8","d0_0","q[13]"],				# mbist
	["l2t","arbdec","ff_inst_size_c8","d0_0","q[14]"],				# mbist
	["l2t","arbdec","ff_inst_size_c8","d0_0","q[15]"],				# mbist
	["l2t","arbdec","ff_inst_size_c8","d0_0","q[16]"],				# mbist
	["l2t","arbdec","ff_inst_size_c8","d0_0","q[17]"],				# mbist
	["l2t","arbadr","ff_arbdp_addr_c12","d0_0","q"],				#Error reporting
]


comparison_ignore_list_array = [
["l2d","ctr","j3"],
["l2d","quad_bot_left"],
["l2d","quad_bot_right"],
["l2d","quad_top_left"],
["l2d","quad_top_right"],
["l2t","dc_row0"],
["l2t","dc_row2"],
["l2t","ic_row0"],
["l2t","ic_row2"],
["l2b","fb_array1"],
["l2b","fb_array2"],
["l2b","fb_array3"],
["l2b","fb_array4"],
["l2t","fbtag"],
["l2t","iqarray"],
["l2t","mbtag"],
["l2t","oqarray"],
["l2t","tag","quad0"],
["l2t","tag","quad1"],
["l2t","tag","quad2"],
["l2t","tag","quad3"],
["l2t","subarray_0"],
["l2t","subarray_1"],
["l2t","subarray_10"],
["l2t","subarray_11"],
["l2t","subarray_2"],
["l2t","subarray_3"],
["l2t","subarray_8"],
["l2t","subarray_9"],
["l2b","wb_array1"],
["l2b","wb_array2"],
["l2b","wb_array3"],
["l2b","wb_array4"],
["l2t","wbtag"],
["l2t","dc_out_col0"],	#mbist, parity
["l2t","dc_out_col1"],	#mbist, parity
["l2t","dc_out_col2"],	#mbist, parity
["l2t","dc_out_col3"],	#mbist, parity
["l2t","out_col0"],	    #mbist, parity
["l2t","out_col1"],	    #mbist, parity
["l2t","out_col2"],	    #mbist, parity
["l2t","out_col3"],		#mbist, parity
["l2t","mbdata"],		
["l2t","oqu"],		#extra cycle will
["l2t","oque"],		#extra cycle will
["l2t","mbist"],		#clock gated
["l2t","mb0"],		#clock gated
["l2b","mb0"],		#clock gated
["l2t","mb2_control"],		#clock gated
["l2t","rdmatag"],		#clock gated
["l2t","shadow_scan"],		#unused?
["l2d","ctr","tstmod"],
["l2b","rdma_array1"],
["l2b","rdma_array2"],
["l2b","rdma_array3"],
["l2b","rdma_array4"],
]

conditional_comparison_list = [
	[["l2t","evctag","ff_mcu_read_addr","d0_0","q"],["l2t","l2t_mcu_rd_req"],"1'b1"],
	[["l2t","csr","ff_csr_l2_control_reg_scb_int","d0_0","q"],["l2t","csr","csr_l2_control_reg[2]"],"1'b1"],
	[["l2t","csr","ff_scrub_count","d0_0","q"],["l2t","csr","csr_l2_control_reg[2]"],"1'b1"],
	[["l2t","filbuf","ff_way0","d0_0","q"],["l2t","filbuf","fb_way_vld[0]"],"1'b1"],
	[["l2t","filbuf","ff_way1","d0_0","q"],["l2t","filbuf","fb_way_vld[1]"],"1'b1"],
	[["l2t","filbuf","ff_way2","d0_0","q"],["l2t","filbuf","fb_way_vld[2]"],"1'b1"],
	[["l2t","filbuf","ff_way3","d0_0","q"],["l2t","filbuf","fb_way_vld[3]"],"1'b1"],
	[["l2t","filbuf","ff_way4","d0_0","q"],["l2t","filbuf","fb_way_vld[4]"],"1'b1"],
	[["l2t","filbuf","ff_way5","d0_0","q"],["l2t","filbuf","fb_way_vld[5]"],"1'b1"],
	[["l2t","filbuf","ff_way6","d0_0","q"],["l2t","filbuf","fb_way_vld[6]"],"1'b1"],
	[["l2t","filbuf","ff_way7","d0_0","q"],["l2t","filbuf","fb_way_vld[7]"],"1'b1"],	
	[["l2t","filbuf","ff_mbid0","d0_0","q"],["l2t","filbuf","fb_valid[0]"],"1'b1"],	
	[["l2t","filbuf","ff_mbid1","d0_0","q"],["l2t","filbuf","fb_valid[1]"],"1'b1"],	
	[["l2t","filbuf","ff_mbid2","d0_0","q"],["l2t","filbuf","fb_valid[2]"],"1'b1"],	
	[["l2t","filbuf","ff_mbid3","d0_0","q"],["l2t","filbuf","fb_valid[3]"],"1'b1"],	
	[["l2t","filbuf","ff_mbid4","d0_0","q"],["l2t","filbuf","fb_valid[4]"],"1'b1"],	
	[["l2t","filbuf","ff_mbid5","d0_0","q"],["l2t","filbuf","fb_valid[5]"],"1'b1"],	
	[["l2t","filbuf","ff_mbid6","d0_0","q"],["l2t","filbuf","fb_valid[6]"],"1'b1"],	
	[["l2t","filbuf","ff_mbid7","d0_0","q"],["l2t","filbuf","fb_valid[7]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid0","d0_0","q"],["l2t","misbuf","way_fbid_vld[0]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid1","d0_0","q"],["l2t","misbuf","way_fbid_vld[1]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid2","d0_0","q"],["l2t","misbuf","way_fbid_vld[2]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid3","d0_0","q"],["l2t","misbuf","way_fbid_vld[3]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid4","d0_0","q"],["l2t","misbuf","way_fbid_vld[4]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid5","d0_0","q"],["l2t","misbuf","way_fbid_vld[5]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid6","d0_0","q"],["l2t","misbuf","way_fbid_vld[6]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid7","d0_0","q"],["l2t","misbuf","way_fbid_vld[7]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid8","d0_0","q"],["l2t","misbuf","way_fbid_vld[8]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid9","d0_0","q"],["l2t","misbuf","way_fbid_vld[9]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid10","d0_0","q"],["l2t","misbuf","way_fbid_vld[10]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid11","d0_0","q"],["l2t","misbuf","way_fbid_vld[11]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid12","d0_0","q"],["l2t","misbuf","way_fbid_vld[12]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid13","d0_0","q"],["l2t","misbuf","way_fbid_vld[13]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid14","d0_0","q"],["l2t","misbuf","way_fbid_vld[14]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid15","d0_0","q"],["l2t","misbuf","way_fbid_vld[15]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid16","d0_0","q"],["l2t","misbuf","way_fbid_vld[16]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid17","d0_0","q"],["l2t","misbuf","way_fbid_vld[17]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid18","d0_0","q"],["l2t","misbuf","way_fbid_vld[18]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid19","d0_0","q"],["l2t","misbuf","way_fbid_vld[19]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid20","d0_0","q"],["l2t","misbuf","way_fbid_vld[20]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid21","d0_0","q"],["l2t","misbuf","way_fbid_vld[21]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid22","d0_0","q"],["l2t","misbuf","way_fbid_vld[22]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid23","d0_0","q"],["l2t","misbuf","way_fbid_vld[23]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid24","d0_0","q"],["l2t","misbuf","way_fbid_vld[24]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid25","d0_0","q"],["l2t","misbuf","way_fbid_vld[25]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid26","d0_0","q"],["l2t","misbuf","way_fbid_vld[26]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid27","d0_0","q"],["l2t","misbuf","way_fbid_vld[27]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid28","d0_0","q"],["l2t","misbuf","way_fbid_vld[28]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid29","d0_0","q"],["l2t","misbuf","way_fbid_vld[29]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid30","d0_0","q"],["l2t","misbuf","way_fbid_vld[30]"],"1'b1"],	
	[["l2t","misbuf","ff_fbid31","d0_0","q"],["l2t","misbuf","way_fbid_vld[31]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link0","d0_0","q"],["l2t","misbuf","mb_valid[0]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link1","d0_0","q"],["l2t","misbuf","mb_valid[1]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link2","d0_0","q"],["l2t","misbuf","mb_valid[2]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link3","d0_0","q"],["l2t","misbuf","mb_valid[3]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link4","d0_0","q"],["l2t","misbuf","mb_valid[4]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link5","d0_0","q"],["l2t","misbuf","mb_valid[5]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link6","d0_0","q"],["l2t","misbuf","mb_valid[6]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link7","d0_0","q"],["l2t","misbuf","mb_valid[7]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link8","d0_0","q"],["l2t","misbuf","mb_valid[8]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link9","d0_0","q"],["l2t","misbuf","mb_valid[9]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link10","d0_0","q"],["l2t","misbuf","mb_valid[10]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link11","d0_0","q"],["l2t","misbuf","mb_valid[11]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link12","d0_0","q"],["l2t","misbuf","mb_valid[12]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link13","d0_0","q"],["l2t","misbuf","mb_valid[13]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link14","d0_0","q"],["l2t","misbuf","mb_valid[14]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link15","d0_0","q"],["l2t","misbuf","mb_valid[15]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link16","d0_0","q"],["l2t","misbuf","mb_valid[16]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link17","d0_0","q"],["l2t","misbuf","mb_valid[17]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link18","d0_0","q"],["l2t","misbuf","mb_valid[18]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link19","d0_0","q"],["l2t","misbuf","mb_valid[19]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link20","d0_0","q"],["l2t","misbuf","mb_valid[20]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link21","d0_0","q"],["l2t","misbuf","mb_valid[21]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link22","d0_0","q"],["l2t","misbuf","mb_valid[22]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link23","d0_0","q"],["l2t","misbuf","mb_valid[23]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link24","d0_0","q"],["l2t","misbuf","mb_valid[24]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link25","d0_0","q"],["l2t","misbuf","mb_valid[25]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link26","d0_0","q"],["l2t","misbuf","mb_valid[26]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link27","d0_0","q"],["l2t","misbuf","mb_valid[27]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link28","d0_0","q"],["l2t","misbuf","mb_valid[28]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link29","d0_0","q"],["l2t","misbuf","mb_valid[29]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link30","d0_0","q"],["l2t","misbuf","mb_valid[30]"],"1'b1"],	
	[["l2t","misbuf","ff_next_link31","d0_0","q"],["l2t","misbuf","mb_valid[31]"],"1'b1"],	
	[["l2t","misbuf","ff_pfice_mbid","d0_0","q"],["l2t","misbuf","pf_ice_mbid_vld"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[0]"],["l2t","misbuf","mb_valid[0]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[1]"],["l2t","misbuf","mb_valid[1]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[2]"],["l2t","misbuf","mb_valid[2]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[3]"],["l2t","misbuf","mb_valid[3]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[4]"],["l2t","misbuf","mb_valid[4]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[5]"],["l2t","misbuf","mb_valid[5]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[6]"],["l2t","misbuf","mb_valid[6]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[7]"],["l2t","misbuf","mb_valid[7]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[8]"],["l2t","misbuf","mb_valid[8]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[9]"],["l2t","misbuf","mb_valid[9]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[10]"],["l2t","misbuf","mb_valid[10]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[11]"],["l2t","misbuf","mb_valid[11]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[12]"],["l2t","misbuf","mb_valid[12]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[13]"],["l2t","misbuf","mb_valid[13]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[14]"],["l2t","misbuf","mb_valid[14]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[15]"],["l2t","misbuf","mb_valid[15]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[16]"],["l2t","misbuf","mb_valid[16]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[17]"],["l2t","misbuf","mb_valid[17]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[18]"],["l2t","misbuf","mb_valid[18]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[19]"],["l2t","misbuf","mb_valid[19]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[20]"],["l2t","misbuf","mb_valid[20]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[21]"],["l2t","misbuf","mb_valid[21]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[22]"],["l2t","misbuf","mb_valid[22]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[23]"],["l2t","misbuf","mb_valid[23]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[24]"],["l2t","misbuf","mb_valid[24]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[25]"],["l2t","misbuf","mb_valid[25]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[26]"],["l2t","misbuf","mb_valid[26]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[27]"],["l2t","misbuf","mb_valid[27]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[28]"],["l2t","misbuf","mb_valid[28]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[29]"],["l2t","misbuf","mb_valid[29]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[30]"],["l2t","misbuf","mb_valid[30]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[31]"],["l2t","misbuf","mb_valid[31]"],"1'b1"],		
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[33]"],["l2t","misbuf","mb_valid[0]"],"1'b1"],		
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[34]"],["l2t","misbuf","mb_valid[1]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[35]"],["l2t","misbuf","mb_valid[2]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[36]"],["l2t","misbuf","mb_valid[3]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[37]"],["l2t","misbuf","mb_valid[4]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[38]"],["l2t","misbuf","mb_valid[5]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[39]"],["l2t","misbuf","mb_valid[6]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[40]"],["l2t","misbuf","mb_valid[7]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[41]"],["l2t","misbuf","mb_valid[8]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[42]"],["l2t","misbuf","mb_valid[9]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[43]"],["l2t","misbuf","mb_valid[10]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[44]"],["l2t","misbuf","mb_valid[11]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[45]"],["l2t","misbuf","mb_valid[12]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[46]"],["l2t","misbuf","mb_valid[13]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[47]"],["l2t","misbuf","mb_valid[14]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[48]"],["l2t","misbuf","mb_valid[15]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[49]"],["l2t","misbuf","mb_valid[16]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[50]"],["l2t","misbuf","mb_valid[17]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[51]"],["l2t","misbuf","mb_valid[18]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[52]"],["l2t","misbuf","mb_valid[19]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[53]"],["l2t","misbuf","mb_valid[20]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[54]"],["l2t","misbuf","mb_valid[21]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[55]"],["l2t","misbuf","mb_valid[22]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[56]"],["l2t","misbuf","mb_valid[23]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[57]"],["l2t","misbuf","mb_valid[24]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[58]"],["l2t","misbuf","mb_valid[25]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[59]"],["l2t","misbuf","mb_valid[26]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[60]"],["l2t","misbuf","mb_valid[27]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[61]"],["l2t","misbuf","mb_valid[28]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[62]"],["l2t","misbuf","mb_valid[29]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[63]"],["l2t","misbuf","mb_valid[30]"],"1'b1"],	
	[["l2t","misbuf","ff_vuad_ce_replay","d0_0","q[64]"],["l2t","misbuf","mb_valid[31]"],"1'b1"],	
	[["l2t","misbuf","ff_way0","d0_0","q"],["l2t","misbuf","mb_way_vld[0]"],"1'b1"],	
	[["l2t","misbuf","ff_way1","d0_0","q"],["l2t","misbuf","mb_way_vld[1]"],"1'b1"],	
	[["l2t","misbuf","ff_way2","d0_0","q"],["l2t","misbuf","mb_way_vld[2]"],"1'b1"],	
	[["l2t","misbuf","ff_way3","d0_0","q"],["l2t","misbuf","mb_way_vld[3]"],"1'b1"],	
	[["l2t","misbuf","ff_way4","d0_0","q"],["l2t","misbuf","mb_way_vld[4]"],"1'b1"],	
	[["l2t","misbuf","ff_way5","d0_0","q"],["l2t","misbuf","mb_way_vld[5]"],"1'b1"],	
	[["l2t","misbuf","ff_way6","d0_0","q"],["l2t","misbuf","mb_way_vld[6]"],"1'b1"],	
	[["l2t","misbuf","ff_way7","d0_0","q"],["l2t","misbuf","mb_way_vld[7]"],"1'b1"],	
	[["l2t","misbuf","ff_way8","d0_0","q"],["l2t","misbuf","mb_way_vld[8]"],"1'b1"],	
	[["l2t","misbuf","ff_way9","d0_0","q"],["l2t","misbuf","mb_way_vld[9]"],"1'b1"],	
	[["l2t","misbuf","ff_way10","d0_0","q"],["l2t","misbuf","mb_way_vld[10]"],"1'b1"],	
	[["l2t","misbuf","ff_way11","d0_0","q"],["l2t","misbuf","mb_way_vld[11]"],"1'b1"],	
	[["l2t","misbuf","ff_way12","d0_0","q"],["l2t","misbuf","mb_way_vld[12]"],"1'b1"],	
	[["l2t","misbuf","ff_way13","d0_0","q"],["l2t","misbuf","mb_way_vld[13]"],"1'b1"],	
	[["l2t","misbuf","ff_way14","d0_0","q"],["l2t","misbuf","mb_way_vld[14]"],"1'b1"],	
	[["l2t","misbuf","ff_way15","d0_0","q"],["l2t","misbuf","mb_way_vld[15]"],"1'b1"],	
	[["l2t","misbuf","ff_way16","d0_0","q"],["l2t","misbuf","mb_way_vld[16]"],"1'b1"],	
	[["l2t","misbuf","ff_way17","d0_0","q"],["l2t","misbuf","mb_way_vld[17]"],"1'b1"],	
	[["l2t","misbuf","ff_way18","d0_0","q"],["l2t","misbuf","mb_way_vld[18]"],"1'b1"],	
	[["l2t","misbuf","ff_way19","d0_0","q"],["l2t","misbuf","mb_way_vld[19]"],"1'b1"],	
	[["l2t","misbuf","ff_way20","d0_0","q"],["l2t","misbuf","mb_way_vld[20]"],"1'b1"],	
	[["l2t","misbuf","ff_way21","d0_0","q"],["l2t","misbuf","mb_way_vld[21]"],"1'b1"],	
	[["l2t","misbuf","ff_way22","d0_0","q"],["l2t","misbuf","mb_way_vld[22]"],"1'b1"],	
	[["l2t","misbuf","ff_way23","d0_0","q"],["l2t","misbuf","mb_way_vld[23]"],"1'b1"],	
	[["l2t","misbuf","ff_way24","d0_0","q"],["l2t","misbuf","mb_way_vld[24]"],"1'b1"],	
	[["l2t","misbuf","ff_way25","d0_0","q"],["l2t","misbuf","mb_way_vld[25]"],"1'b1"],	
	[["l2t","misbuf","ff_way26","d0_0","q"],["l2t","misbuf","mb_way_vld[26]"],"1'b1"],	
	[["l2t","misbuf","ff_way27","d0_0","q"],["l2t","misbuf","mb_way_vld[27]"],"1'b1"],	
	[["l2t","misbuf","ff_way28","d0_0","q"],["l2t","misbuf","mb_way_vld[28]"],"1'b1"],	
	[["l2t","misbuf","ff_way29","d0_0","q"],["l2t","misbuf","mb_way_vld[29]"],"1'b1"],	
	[["l2t","misbuf","ff_way30","d0_0","q"],["l2t","misbuf","mb_way_vld[30]"],"1'b1"],	
	[["l2t","misbuf","ff_way31","d0_0","q"],["l2t","misbuf","mb_way_vld[31]"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r4a","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r4"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r4b","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r4"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_1a","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_1b","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_1c","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_1d","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_2a","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_2b","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_2c","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_2d","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_3a","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_3b","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_3c","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_3d","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_4a","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_4b","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_4c","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r3_4d","d0_0","q"],["l2b","evict"," l2t_l2b_evict_en_r3"],"1'b1"],	
	[["l2t","wbuf","ff_mbid0","d0_0","q"],["l2t","wbuf","wb_mbid_vld[0]"],"1'b1"],	
	[["l2t","wbuf","ff_mbid1","d0_0","q"],["l2t","wbuf","wb_mbid_vld[1]"],"1'b1"],	
	[["l2t","wbuf","ff_mbid2","d0_0","q"],["l2t","wbuf","wb_mbid_vld[2]"],"1'b1"],	
	[["l2t","wbuf","ff_mbid3","d0_0","q"],["l2t","wbuf","wb_mbid_vld[3]"],"1'b1"],	
	[["l2t","wbuf","ff_mbid4","d0_0","q"],["l2t","wbuf","wb_mbid_vld[4]"],"1'b1"],	
	[["l2t","wbuf","ff_mbid5","d0_0","q"],["l2t","wbuf","wb_mbid_vld[5]"],"1'b1"],	
	[["l2t","wbuf","ff_mbid6","d0_0","q"],["l2t","wbuf","wb_mbid_vld[6]"],"1'b1"],	
	[["l2t","wbuf","ff_mbid7","d0_0","q"],["l2t","wbuf","wb_mbid_vld[7]"],"1'b1"],	
	[["l2t","evctag","ff_read_fb_tag_reg","d0_0","q"],["l2t","filbuf","filbuf_arb_vld_px1"],"1'b1"],	
	[["l2t","evctag","ff_read_mb_tag_reg","d0_0","q"],["l2t","misbuf","misbuf_arb_vld_px1"],"1'b1"],	
	[["l2t","arbdat","ff_read_mbdata_reg1","d0_0","q"],["l2t","misbuf","misbuf_arb_vld_px1"],"1'b1"],	
	[["l2t","arbdat","ff_read_mbdata_reg2","d0_0","q"],["l2t","misbuf","misbuf_arb_vld_px1"],"1'b1"],	
	[["l2t","arbdec","ff_read_mbdata_reg_inst1","d0_0","q"],["l2t","misbuf","misbuf_arb_vld_px1"],"1'b1"],	
	[["l2t","arbdec","ff_read_mbdata_reg_inst2","d0_0","q"],["l2t","misbuf","misbuf_arb_vld_px1"],"1'b1"],	
	[["l2t","misbuf","ff_fbf_enc_ld_mbid_r1","d0_0","q"],["l2t","filbuf","mcu_data_vld_r1"],"1'b1"],	
	[["l2t","filbuf","ff_l2_entry_px2","d0_0","q"],["l2t","arbdec","dummy_inst_muxsel_fbf_px2"],"1'b1"],	
	[["l2t","filbuf","ff_l2_way_px2","d0_0","q"],["l2t","arbdec","dummy_inst_muxsel_fbf_px2"],"1'b1"],	
	[["l2b","evict","ff_evict_l2b_mcu_wr_data_r5_d1","d0_0","q"],["l2b","evict","l2t_l2b_evict_en_r5_d1"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r5_31_0","d0_0","q"],["l2b","evict","l2t_l2b_evict_en_r5"],"1'b1"],	
	[["l2b","evict","ff_wb_array_dout_r5_63_32","d0_0","q"],["l2b","evict","l2t_l2b_evict_en_r5"],"1'b1"],	
	[["l2t","misbuf","ff_misbuf_filbuf_next_link_c4","d0_0","q"],["l2t","misbuf","misbuf_next_link_c4_from_valid_mb_entry"],"1'b1"],	
	[["l2t","misbuf","ff_enc_data_wr_wl_c4","d0_0","q"],["l2t","misbuf","misbuf_next_link_c4_from_valid_mb_entry"],"1'b1"],	
	[["l2t","misbuf","ff_enc_data_wr_wl_c5","d0_0","q"],["l2t","misbuf","misbuf_next_link_c5_from_valid_mb_entry"],"1'b1"],	
	[["l2t","misbuf","ff_enc_data_wr_wl_c52","d0_0","q"],["l2t","misbuf","misbuf_next_link_c52_from_valid_mb_entry"],"1'b1"],	
	[["l2t","misbuf","ff_enc_data_wr_wl_c6","d0_0","q"],["l2t","misbuf","misbuf_next_link_c6_from_valid_mb_entry"],"1'b1"],	
	[["l2t","misbuf","ff_enc_data_wr_wl_c7","d0_0","q"],["l2t","misbuf","misbuf_next_link_c7_from_valid_mb_entry"],"1'b1"],	
	[["l2t","misbuf","ff_enc_data_wr_wl_c7_1","d0_0","q"],["l2t","misbuf","misbuf_next_link_c7_from_valid_mb_entry"],"1'b1"],	
	[["l2t","misbuf","ff_enc_data_wr_wl_c8","d0_0","q"],["l2t","misbuf","misbuf_next_link_c8_from_valid_mb_entry"],"1'b1"],	
	[["l2t","misbuf","ff_enc_data_wr_wl_c9","d0_0","q"],["l2t","misbuf","misbuf_next_link_c9_from_valid_mb_entry"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_lo0_1","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_lo0_2","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_hi0_1","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_hi0_2","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_lo0_3","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_lo0_4","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_hi0_3","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_hi0_4","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_lo1_1","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_lo1_2","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_hi1_1","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_hi1_2","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_lo1_3","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_lo1_4","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_hi1_3","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2d","ctr","ff_l2b_l2d_fbdecc_c52_hi1_4","d0_0","q"],["l2d","ctr","cache_fb_hit_c52"],"1'b1"],	
	[["l2t","misbuf","ff_mbid","d0_0","q"],["l2t","misbuf","mbid_vld"],"1'b1"],	
	
	#excluded
	[["l2t","mbist","mbist_output_reg","d0_0","q"],["l2t","arbadr","ncu_l2t_pm_sync_n_ff2"],"1'b0"],			#ncu_l2t_pm_sync_n_ff2 should be 1 unless error is injected into it
	#[["l2t","snpd","ff_data0_1","d0_0","q"],["l2t","arb","snp_valid_px2"],"1'b0"],			#temporary
	#[["l2t","snpd","ff_data0_2","d0_0","q"],["l2t","arb","snp_valid_px2"],"1'b0"],			#temporary
	#[["l2t","snpd","ff_data1_1","d0_0","q"],["l2t","arb","snp_valid_px2"],"1'b0"],			#temporary
	#[["l2t","snpd","ff_data1_2","d0_0","q"],["l2t","arb","snp_valid_px2"],"1'b0"],			#temporary
	[["l2t","misbuf","ff_rdma_bit","d0_0","q"],["l2t","tagctl","rdma_vld_px0_p"],"1'b1"],			#temporary
	[["l2t","rdmat","ff_mbid0","d0_0","q"],["l2t","rdmat","rdma_mbid_vld[0]"],"1'b1"],			
	[["l2t","rdmat","ff_mbid1","d0_0","q"],["l2t","rdmat","rdma_mbid_vld[1]"],"1'b1"],			
	[["l2t","rdmat","ff_mbid2","d0_0","q"],["l2t","rdmat","rdma_mbid_vld[2]"],"1'b1"],			
	[["l2t","rdmat","ff_mbid3","d0_0","q"],["l2t","rdmat","rdma_mbid_vld[3]"],"1'b1"],			
	[["l2t","misbuf","ff_dep_rdmat_mbid_d1","d0_0","q"],["l2t","misbuf","rdmat_dep_rdy_en_d1"],"1'b1"],			
	
	
	[["l2t","filbuf","ff_misbuf_filbuf_fbid_d1","d0_0","q"],["l2t","filbuf","misbuf_filbuf_way_vld_d1"],"1'b1"],			
	[["l2t","filbuf","ff_misbuf_filbuf_way_d1","d0_0","q"],["l2t","filbuf","misbuf_filbuf_way_vld_d1"],"1'b1"],			
]





conditional_comparison_list_inv = [
	[["l2t","misbuf","ff_misbuf_filbuf_fbid_0123","d0_0","q"],["l2t","misbuf","way_fbid_vld[3:0]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_fbid_4567","d0_0","q"],["l2t","misbuf","way_fbid_vld[7:4]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_fbid_89ab","d0_0","q"],["l2t","misbuf","way_fbid_vld[11:8]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_fbid_cdef","d0_0","q"],["l2t","misbuf","way_fbid_vld[15:12]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_fbid_a0123","d0_0","q"],["l2t","misbuf","way_fbid_vld[19:16]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_fbid_a4567","d0_0","q"],["l2t","misbuf","way_fbid_vld[23:20]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_fbid_a89ab","d0_0","q"],["l2t","misbuf","way_fbid_vld[27:24]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_fbid_acdef","d0_0","q"],["l2t","misbuf","way_fbid_vld[31:28]"],"4'b0000"],
	[["l2t","misbuf","ff_misbuf_filbuf_way_0123","d0_0","q"],["l2t","misbuf","way_fbid_vld[3:0]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_way_4567","d0_0","q"],["l2t","misbuf","way_fbid_vld[7:4]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_way_89ab","d0_0","q"],["l2t","misbuf","way_fbid_vld[11:8]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_way_cdef","d0_0","q"],["l2t","misbuf","way_fbid_vld[15:12]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_way_a0123","d0_0","q"],["l2t","misbuf","way_fbid_vld[19:16]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_way_a4567","d0_0","q"],["l2t","misbuf","way_fbid_vld[23:20]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_way_a89ab","d0_0","q"],["l2t","misbuf","way_fbid_vld[27:24]"],"4'b0000"],	
	[["l2t","misbuf","ff_misbuf_filbuf_way_acdef","d0_0","q"],["l2t","misbuf","way_fbid_vld[31:28]"],"4'b0000"],
	[["l2t","misbuf","ff_fbf_enc_dep_mbid_c5","d0_0","q"],["l2t","filbuf","fill_complete_c5_dummy_noerrinjection[7:0]"],"8'b00000000"],
	
	[["l2t","snp","ff_rdmad_wr_entry_s2_d1","d0_0","q"],["l2t","snp","rdmadata_wen_s2[15:0]"],"16'b0000000000000000"],
	[["l2b","evict","ff_rdma_control_regs_slice_v1","d0_0","q"],["l2t","snp","rdmadata_wen_s2[15:0]"],"16'b0000000000000000"],
	[["l2b","evict","ff_rdma_control_regs_slice_v2","d0_0","q"],["l2t","snp","rdmadata_wen_s2[15:0]"],"16'b0000000000000000"],
	[["l2b","evict","ff_rdma_control_regs_slice_v3","d0_0","q"],["l2t","snp","rdmadata_wen_s2[15:0]"],"16'b0000000000000000"],
	[["l2b","evict","ff_rdma_control_regs_slice_v4","d0_0","q"],["l2t","snp","rdmadata_wen_s2[15:0]"],"16'b0000000000000000"],
]
	
conditional_comparison_list_task_variable = [
	[["l2t","oqu","ff_oq0_out","d0_0","q"],"oqu_valid_mask[0]","1'b1"],	
	[["l2t","oqu","ff_oq1_out","d0_0","q"],"oqu_valid_mask[1]","1'b1"],	
	[["l2t","oqu","ff_oq2_out","d0_0","q"],"oqu_valid_mask[2]","1'b1"],	
	[["l2t","oqu","ff_oq3_out","d0_0","q"],"oqu_valid_mask[3]","1'b1"],	
	[["l2t","oqu","ff_oq4_out","d0_0","q"],"oqu_valid_mask[4]","1'b1"],	
	[["l2t","oqu","ff_oq5_out","d0_0","q"],"oqu_valid_mask[5]","1'b1"],	
	[["l2t","oqu","ff_oq6_out","d0_0","q"],"oqu_valid_mask[6]","1'b1"],	
	[["l2t","oqu","ff_oq7_out","d0_0","q"],"oqu_valid_mask[7]","1'b1"],	
	[["l2t","oqu","ff_oq8_out" ,"d0_0","q"],"oqu_valid_mask[8]","1'b1"],	
	[["l2t","oqu","ff_oq9_out" ,"d0_0","q"],"oqu_valid_mask[9]","1'b1"],	
	[["l2t","oqu","ff_oq10_out","d0_0","q"],"oqu_valid_mask[10]","1'b1"],	
	[["l2t","oqu","ff_oq11_out","d0_0","q"],"oqu_valid_mask[11]","1'b1"],	
	[["l2t","oqu","ff_oq12_out","d0_0","q"],"oqu_valid_mask[12]","1'b1"],	
	[["l2t","oqu","ff_oq13_out","d0_0","q"],"oqu_valid_mask[13]","1'b1"],	
	[["l2t","oqu","ff_oq14_out","d0_0","q"],"oqu_valid_mask[14]","1'b1"],	
	[["l2t","oqu","ff_oq15_out","d0_0","q"],"oqu_valid_mask[15]","1'b1"],	
]

conditional_comparison_list_one_hot = [
	[["l2t","filbuf","ff_l2_rd_state","d0_0","q"],4],			#Only fill buf location change. do we need to refect this in simics?
	[["l2t","filbuf","ff_l2_rd_state_quad0","d0_0","q"],4],			#Only fill buf location change. do we need to refect this in simics?
	[["l2t","filbuf","ff_l2_rd_state_quad1","d0_0","q"],4],			#Only fill buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state","d0_0","q"],8],				#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state_quad0","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state_quad1","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state_quad2","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state_quad3","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state_quad4","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state_quad5","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state_quad6","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_l2_state_quad7","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state","d0_0","q"],8],				#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state_quad0","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state_quad1","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state_quad2","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state_quad3","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state_quad4","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state_quad5","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state_quad6","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","misbuf","ff_mcu_state_quad7","d0_0","q"],4],			#Only miss buf location change. do we need to refect this in simics?
	[["l2t","wbuf","ff_quad_state","d0_0","q"],3],			#Only wb buf location change. do we need to refect this in simics?
	[["l2t","wbuf","ff_quad0_state","d0_0","q"],4],			#Only wb buf location change. do we need to refect this in simics?
	[["l2t","wbuf","ff_quad1_state","d0_0","q"],4],			#Only wb buf location change. do we need to refect this in simics?
	[["l2t","wbuf","ff_quad2_state","d0_0","q"],4],			#Only wb buf location change. do we need to refect this in simics?
	[["l2t","tagdp","ff_lru_state","d0_0","q"],4],			#Only way change. do we need to refect this in simics?
	[["l2t","tagdp","ff_lru_state_quad0","d0_0","q"],4],	#Only way change. do we need to refect this in simics?
	[["l2t","tagdp","ff_lru_state_quad1","d0_0","q"],4],	#Only way change. do we need to refect this in simics?
	[["l2t","tagdp","ff_lru_state_quad2","d0_0","q"],4],	#Only way change. do we need to refect this in simics?
	[["l2t","tagdp","ff_lru_state_quad3","d0_0","q"],4],	#Only way change. do we need to refect this in simics?
]
def needs_special_comparison_rule(s):
	#if(len(s) >= 3):
	#	ffname = s[-3]
	#	if("_c1"  in ffname):	return True
	#	if("_c2"  in ffname):	return True
	#	if("_c3"  in ffname):	return True
	#	if("_c4"  in ffname):	return True
	#	if("_c5"  in ffname):	return True
	#	if("_c52" in ffname):	return True
	#	if("_c6"  in ffname):	return True
	#	if("_c7"  in ffname):	return True
	#	if("_c8"  in ffname):	return True
	#	if("_c9"  in ffname):	return True
	#	if("_c10" in ffname):	return True
	#	if("_c11" in ffname):	return True
	#	if("_c12" in ffname):	return True
	#	if("_c13" in ffname):	return True
	#	if("_px2" in ffname):	return True
	for ffname in s :
		#if (ffname == "mb0") : return True
		#if (ffname == "mb2_control") : return True
		#if (ffname == "mbist") : return True
		if("_mb0_"  in ffname):	return True
		if("_mb2_"  in ffname):	return True
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
	["l2b","evict","ff_wb_array_dout_r4a"],	
	["l2b","evict","ff_wb_array_dout_r4b"],	
	["l2b","evict","ff_wb_array_dout_r3_1a"],
	["l2b","evict","ff_wb_array_dout_r3_1b"],
	["l2b","evict","ff_wb_array_dout_r3_1c"],
	["l2b","evict","ff_wb_array_dout_r3_1d"],
	["l2b","evict","ff_wb_array_dout_r3_2a"],
	["l2b","evict","ff_wb_array_dout_r3_2b"],
	["l2b","evict","ff_wb_array_dout_r3_2c"],
	["l2b","evict","ff_wb_array_dout_r3_2d"],
	["l2b","evict","ff_wb_array_dout_r3_3a"],
	["l2b","evict","ff_wb_array_dout_r3_3b"],
	["l2b","evict","ff_wb_array_dout_r3_3c"],
	["l2b","evict","ff_wb_array_dout_r3_3d"],
	["l2b","evict","ff_wb_array_dout_r3_4a"],
	["l2b","evict","ff_wb_array_dout_r3_4b"],
	["l2b","evict","ff_wb_array_dout_r3_4c"],
	["l2b","evict","ff_wb_array_dout_r3_4d"],
	["l2b","fbd","ff_btu_l2b_decc_r3_1"],
	["l2b","fbd","ff_btu_l2b_decc_r3_2"],
	["l2b","fbd","ff_btu_l2b_decc_r3_3"],
	["l2b","fbd","ff_btu_l2b_decc_r3_4"],
	["l2b","fbd","ff_btu_l2b_decc_r3_1a"],
	["l2b","fbd","ff_btu_l2b_decc_r3_2a"],
	["l2b","fbd","ff_btu_l2b_decc_r3_3a"],
	["l2b","fbd","ff_btu_l2b_decc_r3_4a"],
	["l2b","fbd","ff_l2t_l2d_stdecc_c4_1"],
	["l2b","fbd","ff_l2t_l2d_stdecc_c4_2"],
	["l2b","fbd","ff_l2t_l2d_stdecc_c4_10"],
	["l2b","fbd","ff_l2t_l2d_stdecc_c4_11"],
	["l2b","wb_array1","ff_wdata_"],
	["l2b","wb_array2","ff_wdata_"],
	["l2b","wb_array3","ff_wdata_"],
	["l2b","wb_array4","ff_wdata_"],
	["l2b","fb_array1","ff_wdata_"],
	["l2b","fb_array2","ff_wdata_"],
	["l2b","fb_array3","ff_wdata_"],
	["l2b","fb_array4","ff_wdata_"],
	["l2d","ctr","j3"],
	["l2d","ctr","ff_l2d_decc_out_c6_"],
	["l2d","ctr","ff_l2b_l2d_fbdecc_c52_"],
	["l2d","ctr","ff_cache_decc_out_0_c52_d"],
	["l2d","ctr","ff_cache_decc_out_1_c52_d"],
	["l2d","ctr","ff_cache_decc_out_2_c52_d"],
	["l2d","ctr","ff_cache_decc_out_3_c52_d"],
	["l2d","ctr","ff_l2t_l2d_stdecc_c3"],
	["l2d","perif_io","ff_l2b_l2d_fbdecc_c5_"],
	["l2d","perif_io","ff_l2d_l2b_decc_out_c7_"],
	["l2d","perif_io","ff_l2d_l2t_decc_c6"],
	["l2t","arbdat","ff_data31to0_c2"],
	["l2t","arbdat","ff_data63to32_c2"],
	["l2t","decc","ff_data_rtn_c7_1split"]
]

def is_DATAECC_protected(s):
	for name in DATAECC_protected_list:		
		if s[0:len(name)-1] == name[0:len(name)-1]:
			if name[len(name)-1] in s[len(name)-1]:
				return True
	return False;

TAGECC_protected_list = [
	["l2t","tagd","buff_tagd_tag_wrdata_px2_buf"],	
	["l2t","arbadr","ff_tecc_corr_tag_c2"],	
	["l2t","tag","quad0","reg_din_"],	
	["l2t","tag","quad1","reg_din_"],	
	["l2t","tag","quad2","reg_din_"],	
	["l2t","tag","quad3","reg_din_"],	
	["l2t","tag","quad0","bank0","reg_tag_way"],	
	["l2t","tag","quad0","bank1","reg_tag_way"],	
	["l2t","tag","quad1","bank0","reg_tag_way"],	
	["l2t","tag","quad1","bank1","reg_tag_way"],	
	["l2t","tag","quad2","bank0","reg_tag_way"],	
	["l2t","tag","quad2","bank1","reg_tag_way"],	
	["l2t","tag","quad3","bank0","reg_tag_way"],	
	["l2t","tag","quad3","bank1","reg_tag_way"],	
]


def is_TAGECC_protected(s):
	for name in TAGECC_protected_list:		
		if s[0:len(name)-1] == name[0:len(name)-1]:
			if name[len(name)-1] in s[len(name)-1]:
				return True
	return False;
	
VUADECC_protected_list = [
	["l2t","vlddir","ff_valid_dirty_c2"],	
	["l2t","vlddir","ff_valid_clone_c2"],	
	["l2t","vlddir","ff_valid_dirty_c4"],	
	["l2t","vlddir","ff_used_and_alloc_c2"],	
	["l2t","vlddir","ff_used_alloc_c4"],	
	["l2t","subarray_0","ff_wdata_"],	
	["l2t","subarray_1","ff_wdata_"],	
	["l2t","subarray_2","ff_wdata_"],	
	["l2t","subarray_3","ff_wdata_"],	
	["l2t","subarray_8","ff_wdata_"],	
	["l2t","subarray_9","ff_wdata_"],	
	["l2t","subarray_10","ff_wdata_"],	
	["l2t","subarray_11","ff_wdata_"],	
]

def is_VUADECC_protected(s):
	for name in VUADECC_protected_list:		
		if s[0:len(name)-1] == name[0:len(name)-1]:
			if name[len(name)-1] in s[len(name)-1]:
				return True
	return False;

def is_ECC_protected(s):
	if(is_DATAECC_protected(s)): return True
	if(is_TAGECC_protected(s)): return True
	if(is_VUADECC_protected(s)): return True
	return False;

	
def addIgnoredComparisons(fc,l2_bank):
	for name in comparison_ignore_list:
		name2 = ".".join(name[1:])
		fc.write("if(tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(l2_bank)+"."+name2+") begin\r\n")
		fc.write("	$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+"\");\r\n")	
		fc.write("end \r\n")
		
def addConditionalComparisons(fc,l2_bank):
	for condition in conditional_comparison_list:
		name = condition[0]		
		name2 = ".".join(name[1:])
		comparison_signal = condition[1]
		comparison_signal2 = ".".join(comparison_signal[1:])
		comparison_value = condition[2]
		fc.write("if(tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(l2_bank)+"."+name2+") begin\r\n")
		fc.write("	if(tb_top.cpu."+comparison_signal[0]+str(l2_bank)+"."+comparison_signal2+" == "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" while tb_top.cpu."+comparison_signal[0]+str(l2_bank)+"."+comparison_signal2+" == "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" while tb_top.cpu."+comparison_signal[0]+str(l2_bank)+"."+comparison_signal2+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");
		
def addConditionalComparisonsInv(fc,l2_bank):
	for condition in conditional_comparison_list_inv:
		name = condition[0]		
		name2 = ".".join(name[1:])
		comparison_signal = condition[1]
		comparison_signal2 = ".".join(comparison_signal[1:])
		comparison_value = condition[2]
		fc.write("if(tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(l2_bank)+"."+name2+") begin\r\n")
		fc.write("	if(tb_top.cpu."+comparison_signal[0]+str(l2_bank)+"."+comparison_signal2+" != "+comparison_value+") begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" while tb_top.cpu."+comparison_signal[0]+str(l2_bank)+"."+comparison_signal2+" != "+comparison_value+"\");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" while tb_top.cpu."+comparison_signal[0]+str(l2_bank)+"."+comparison_signal2+" == "+comparison_value+"\");\r\n")
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

def addOQUValidMask(fc,l2_bank):
	fc.write("case(tb_top.cpu.l2t"+str(l2_bank)+".oqu.enc_rd_ptr)\r\n")
	fc.write("	0 : oqu_rd_ptr_mask = 15'b1111111111111111;\r\n")
	fc.write("	1 : oqu_rd_ptr_mask = 15'b0111111111111111;\r\n")
	fc.write("	2 : oqu_rd_ptr_mask = 15'b0011111111111111;\r\n")
	fc.write("	3 : oqu_rd_ptr_mask = 15'b0001111111111111;\r\n")
	fc.write("	4 : oqu_rd_ptr_mask = 15'b0000111111111111;\r\n")
	fc.write("	5 : oqu_rd_ptr_mask = 15'b0000011111111111;\r\n")
	fc.write("	6 : oqu_rd_ptr_mask = 15'b0000001111111111;\r\n")
	fc.write("	7 : oqu_rd_ptr_mask = 15'b0000000111111111;\r\n")
	fc.write("	8 : oqu_rd_ptr_mask = 15'b0000000011111111;\r\n")
	fc.write("	9 : oqu_rd_ptr_mask = 15'b0000000001111111;\r\n")
	fc.write("	10: oqu_rd_ptr_mask = 15'b0000000000111111;\r\n")
	fc.write("	11: oqu_rd_ptr_mask = 15'b0000000000011111;\r\n")
	fc.write("	12: oqu_rd_ptr_mask = 15'b0000000000001111;\r\n")
	fc.write("	13: oqu_rd_ptr_mask = 15'b0000000000000111;\r\n")
	fc.write("	14: oqu_rd_ptr_mask = 15'b0000000000000011;\r\n")
	fc.write("	15: oqu_rd_ptr_mask = 15'b0000000000000001;\r\n")
	fc.write("endcase\r\n")
	fc.write("case(tb_top.cpu.l2t"+str(l2_bank)+".oqu.enc_wr_ptr)\r\n")
	fc.write("	0 : oqu_wr_ptr_mask = 15'b0000000000000000;\r\n")
	fc.write("	1 : oqu_wr_ptr_mask = 15'b1000000000000000;\r\n")
	fc.write("	2 : oqu_wr_ptr_mask = 15'b1100000000000000;\r\n")
	fc.write("	3 : oqu_wr_ptr_mask = 15'b1110000000000000;\r\n")
	fc.write("	4 : oqu_wr_ptr_mask = 15'b1111000000000000;\r\n")
	fc.write("	5 : oqu_wr_ptr_mask = 15'b1111100000000000;\r\n")
	fc.write("	6 : oqu_wr_ptr_mask = 15'b1111110000000000;\r\n")
	fc.write("	7 : oqu_wr_ptr_mask = 15'b1111111000000000;\r\n")
	fc.write("	8 : oqu_wr_ptr_mask = 15'b1111111100000000;\r\n")
	fc.write("	9 : oqu_wr_ptr_mask = 15'b1111111110000000;\r\n")
	fc.write("	10: oqu_wr_ptr_mask = 15'b1111111111000000;\r\n")
	fc.write("	11: oqu_wr_ptr_mask = 15'b1111111111100000;\r\n")
	fc.write("	12: oqu_wr_ptr_mask = 15'b1111111111110000;\r\n")
	fc.write("	13: oqu_wr_ptr_mask = 15'b1111111111111000;\r\n")
	fc.write("	14: oqu_wr_ptr_mask = 15'b1111111111111100;\r\n")
	fc.write("	15: oqu_wr_ptr_mask = 15'b1111111111111110;\r\n")
	fc.write("endcase\r\n")
	fc.write("if (tb_top.cpu.l2t"+str(l2_bank)+".oqu.enc_rd_ptr < tb_top.cpu.l2t"+str(l2_bank)+".oqu.enc_wr_ptr) begin\r\n")	
	fc.write("	oqu_valid_mask = oqu_rd_ptr_mask & oqu_wr_ptr_mask ;\r\n")
	fc.write("end\r\n")
	fc.write("else if (tb_top.cpu.l2t"+str(l2_bank)+".oqu.enc_rd_ptr > tb_top.cpu.l2t"+str(l2_bank)+".oqu.enc_wr_ptr) begin\r\n")
	fc.write("	oqu_valid_mask = oqu_rd_ptr_mask | oqu_wr_ptr_mask ;\r\n")
	fc.write("end\r\n")
		
def addOneHotChecks(fc,l2_bank):
	for condition in conditional_comparison_list_one_hot:
		name = condition[0]		
		name2 = ".".join(name[1:])
		bitwidth = condition[1];
		fc.write("if(tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" != tb_top.cpu.noerror_"+name[0]+str(l2_bank)+"."+name2+") begin\r\n")		
		fc.write("	one_hotness_count = 0;\r\n")
		fc.write("	for(one_hotness_index = 0; one_hotness_index < "+str(bitwidth)+" ;one_hotness_index = one_hotness_index+1) begin\r\n")
		fc.write("		if( tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+"[one_hotness_index] != 1'b0 ) begin\r\n")
		fc.write("			one_hotness_count = one_hotness_count + 1;\r\n");
		fc.write("		end \r\n");
		fc.write("	end \r\n");
		fc.write("	if( one_hotness_count != 1 ) begin\r\n")
		fc.write("		mismatch_count = mismatch_count + 1;\r\n")
		fc.write("		$display(\"pending FF error : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" does not satisfy one-hotness %x \",tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+");\r\n")
		fc.write("	end \r\n");
		fc.write("	else begin \r\n");
		fc.write("		$display(\"pending FF error ignored : tb_top.cpu."+name[0]+str(l2_bank)+"."+name2+" satisfies one-hotness\");\r\n")
		fc.write("	end \r\n");
		fc.write("end \r\n");

		conditional_comparison_list_one_hot
	
def addSpecialComprisons(fc,l2_bank):
	addIgnoredComparisons(fc,l2_bank)
	addConditionalComparisons(fc,l2_bank)
	addConditionalComparisonsInv(fc,l2_bank)
	addOQUValidMask(fc,l2_bank)	
	addConditionalComparisonsTaskVariable(fc,l2_bank)
	addOneHotChecks(fc,l2_bank)
	

	
for line in fp:
	s = line.strip()
	t = s.split(".")
	
	if(t[0] == "n2_l2d_sp_512kb_cust"):
		t[0] = "l2d"
		s = ".".join(t)
		
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
vhfile_name = dv_root + "/verif/env/cmp/ff_injection/ff_injection_l2_bank"
print vhfile_name
vhfile_name_compare = dv_root + "/verif/env/cmp/ff_injection/ff_compare_l2_bank"
print vhfile_name_compare

for l2_bank in range(8):
#for l2_bank in range(1):
	try:
		f = open(vhfile_name+str(l2_bank)+".vh","w")
	except IOError, e:
		print e.errno
		print e
		
	try:
		fc = open(vhfile_name_compare+str(l2_bank)+".vh","w")
	except IOError, e:
		print e.errno
		print e
	
	if(l2_bank == 0):
		try:	
			f_ECC = open("ECC_protected_FFs.txt","w")
		except IOError, e:
			print e.errno
			print e
		try:	
			f_TAGECC = open("ECC_protected_FFs_TAG.txt","w")
		except IOError, e:
			print e.errno
			print e
		try:	
			f_VUADECC = open("ECC_protected_FFs_VUAD.txt","w")
		except IOError, e:
			print e.errno
			print e

		
	f.write("task ff_injection_l2_bank"+str(l2_bank)+";\r\n")
	f.write("input integer ff_id;\r\n")
	f.write("begin\r\n")
	f.write("`ifdef FAULTY_L2"+str(l2_bank)+"\r\n")
	f.write("`ifndef FAULTY_CCX\r\n")
	f.write("error_injection_cycle = global_cycle_cnt;\r\n")
	f.write("case(ff_id)\r\n")
	
	fc.write("task ff_compare_l2_bank"+str(l2_bank)+";\r\n")
	fc.write("integer mismatch_count;\r\n")
	fc.write("integer one_hotness_count;\r\n")
	fc.write("integer one_hotness_index;\r\n")
	fc.write("reg [15:0] oqu_rd_ptr_mask, oqu_wr_ptr_mask, oqu_valid_mask;\r\n")
	fc.write("begin\r\n")
	fc.write("mismatch_count = 0;\r\n")
	fc.write("`ifdef FAULTY_L2"+str(l2_bank)+"\r\n")
	fc.write("`ifndef FAULTY_CCX\r\n")

	ff_id = 0
	for ff in flat_ff_list:
		ff_s = ff.split(".")
		ff_s2 = list(ff_s);
		
		if(ff_s[0] == "l2t"):
			ff_s2[0] = "l2t" + str(l2_bank)
		elif(ff_s[0] == "l2b"):
			ff_s2[0] = "l2b" + str(l2_bank)
		elif(ff_s[0] == "l2d"):
			ff_s2[0] = "l2d" + str(l2_bank)
		ff_j = ".".join(ff_s2)
		
		#special name for tag srlatch. tag srlatch has different names for injection and comparion.
		if ff_s[0] == "l2t" and  ff_s[1] == "tag" and  ff_s[2][:4] == "quad" and  ff_s[3][:4] == "bank" and ff_s[4][:14] == "srlatch_sao_mx":
			f.write(str(ff_id)+"\t:\t$my_invert(tb_top.cpu."+ff_j+"_);\r\n");
		else:
			f.write(str(ff_id)+"\t:\t$my_invert(tb_top.cpu."+ff_j+");\r\n");
		
		if not needs_special_comparison_rule(ff_s):
			fc.write("if(tb_top.cpu."+ff_j+" != tb_top.cpu.noerror_"+ff_j+") begin\r\n");
			fc.write("mismatch_count = mismatch_count + 1;\r\n");
			fc.write("$display(\"pending FF error : tb_top.cpu."+ff_j+" %b - %b\",tb_top.cpu."+ff_j+",tb_top.cpu.noerror_"+ff_j+");\r\n");
			fc.write("end \r\n");
		
		if(l2_bank == 0):
			if is_DATAECC_protected(ff_s):
				f_ECC.write("%d %s\n" %(ff_id,ff_j));
		if(l2_bank == 0):
			if is_TAGECC_protected(ff_s):
				f_TAGECC.write("%d %s\n" %(ff_id,ff_j));
		if(l2_bank == 0):
			if is_VUADECC_protected(ff_s):
				f_VUADECC.write("%d %s\n" %(ff_id,ff_j));
			
		
		ff_id += 1
		
	f.write("endcase\r\n")
	f.write("`else\r\n")
	f.write("$display(\"Error injection to BANK "+str(l2_bank)+" is not enabled. Add -config_rtl=FAULTY_L2"+str(l2_bank)+" to enable\");\r\n");
	f.write("`endif //!FAULTY_CCX\r\n")
	f.write("`endif //FAULTY_L2"+str(l2_bank)+"\r\n")
	f.write("end\r\n")
	f.write("endtask\r\n")
	f.close()
	
	#special comparison rules
	addSpecialComprisons(fc,l2_bank)
	
	fc.write("`endif //!FAULTY_CCX\r\n")
	fc.write("`endif //FAULTY_L2"+str(l2_bank)+"\r\n")
	fc.write("vera_shell.ffMismatchCountSet(mismatch_count);\r\n")
	fc.write("end\r\n")
	fc.write("endtask\r\n")
	fc.close()
	
	f_ECC.close()
	
	

#a file to be included in UncoreExternal.vr to setup the number of flip-flops.
vhfile_name = dv_root + "/verif/env/cmp/vera/include/l2_ff_init.vri"
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
classifier_fname = dv_root + "/script/ff_classify.sh"
print classifier_fname
try:
	f = open(classifier_fname,"w")
except IOError, e:
	print e.errno
	print e
f.write("#!/bin/bash\n")
f.write("l2_submodule_num="+str(len(ffcs)-1)+"\n")
f.write("l2_submodule_names=( ") 
for ffc in ffcs_sorted:	
	if(ffc=="excluded"): continue
	f.write(ffc+" ")
f.write(")\n")
f.write("l2_submodule_ff_num_max=( ") 
ff_idnum_acc= 0
for ffc in ffcs_sorted:	
	if(ffc=="excluded"): continue
	ff_idnum_acc += len(ffcs[ffc])
	f.write(str(ff_idnum_acc)+" ")
f.write(")\n")
f.write("for ((i=0;i<$l2_submodule_num;i=i+1))\n")
f.write("do\n")
f.write("	if [ $1 -lt ${l2_submodule_ff_num_max[$i]} ]\n")
f.write("	then\n")
f.write("		echo ${l2_submodule_names[$i]}\n")
f.write("		break\n")
f.write("	fi\n")
f.write("done\n")
st = os.stat(classifier_fname)
os.chmod(classifier_fname, st.st_mode | stat.S_IEXEC)

