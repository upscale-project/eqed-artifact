//////////////////////////////////////////
////// n2_irf_mp_128x72_cust
//////////////////////////////////////////


`ifndef FPGA

module exu_irf_array (
  clk, 
  tcu_array_wr_inhibit, 
  a_rd_en_p0, 
  a_rd_en_p1, 
  a_rd_en_p2, 
  a_rd_tid, 
  a_rd_addr_p0, 
  a_rd_addr_p1, 
  a_rd_addr_p2, 
  a_wr_en_p0, 
  a_wr_tid_p0, 
  a_wr_addr_p0, 
  a_wr_data_p0, 
  a_wr_en_p1, 
  a_wr_tid_p1, 
  a_wr_addr_p1, 
  a_wr_data_p1, 
  a_save_tid, 
  a_save_global_tid, 
  a_save_global_addr, 
  a_save_even_addr, 
  a_save_local_addr, 
  a_save_odd_addr, 
  a_save_global_en, 
  a_save_even_en, 
  a_save_local_en, 
  a_save_odd_en, 
  a_restore_tid, 
  a_restore_global_tid, 
  a_restore_global_addr, 
  a_restore_even_addr, 
  a_restore_odd_addr, 
  a_restore_local_addr, 
  a_restore_global_en, 
  a_restore_even_en, 
  a_restore_local_en, 
  a_restore_odd_en, 
  a_rd_data_p0, 
  a_rd_data_p1, 
  a_rd_data_p2);
wire [6:0] thr_rs1;
wire [6:0] thr_rs2;
wire [6:0] thr_rs3;
wire [6:0] thr_rd_w;
wire [6:0] thr_rd_w2;
wire rd_en_p0;
wire rd_en_p1;
wire rd_en_p2;
wire wr_en_p0;
wire wr_en_p1;
wire p0_rd_eq_wr;
wire p1_rd_eq_wr;
wire p2_rd_eq_wr;


input		clk;

input		tcu_array_wr_inhibit;

input		a_rd_en_p0;
input		a_rd_en_p1;
input		a_rd_en_p2;
input  [1:0]	a_rd_tid;
input  [4:0]	a_rd_addr_p0;
input  [4:0]	a_rd_addr_p1;
input  [4:0]	a_rd_addr_p2;

input		a_wr_en_p0;
input  [1:0]	a_wr_tid_p0;
input  [4:0]	a_wr_addr_p0;
input  [71:0]	a_wr_data_p0;

input		a_wr_en_p1;
input  [1:0]	a_wr_tid_p1;
input  [4:0]	a_wr_addr_p1;
input  [71:0]	a_wr_data_p1;


input  [1:0]	a_save_tid;
input  [1:0]	a_save_global_tid;
input  [1:0]	a_save_global_addr;
input  [2:1]	a_save_even_addr;
input  [2:0]	a_save_local_addr;
input  [2:1]	a_save_odd_addr;
input		a_save_global_en;
input		a_save_even_en;
input		a_save_local_en;
input		a_save_odd_en;

input  [1:0]	a_restore_tid;
input  [1:0]	a_restore_global_tid;
input  [1:0]	a_restore_global_addr;
input  [2:1]	a_restore_even_addr;
input  [2:1]	a_restore_odd_addr;
input  [2:0]	a_restore_local_addr;
input		a_restore_global_en;
input		a_restore_even_en;
input		a_restore_local_en;
input		a_restore_odd_en;


output [71:0]	a_rd_data_p0;
output [71:0]	a_rd_data_p1;
output [71:0]	a_rd_data_p2;


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule
`endif // `ifndef FPGA


//////////////////////////////////////////
////// n2_frf_mp_256x78_cust
//////////////////////////////////////////


`ifndef FPGA
module fgu_frf_array (
  clk, 
  tcu_array_wr_inhibit, 
  r1_valid, 
  r1_addr, 
  r2_valid, 
  r2_addr, 
  w1_valid, 
  w1_addr, 
  w2_valid, 
  w2_addr, 
  w1_data, 
  w2_data, 
  r1_data, 
  r2_data);


   input          clk;

   input          tcu_array_wr_inhibit;

   // -----------------------------------------------------------------------
   // Reading controls
   // -----------------------------------------------------------------------
   input          r1_valid;
   input    [7:0] r1_addr;
   input          r2_valid;
   input    [7:0] r2_addr;
 
   // -----------------------------------------------------------------------
   // Writing controls 
   // -----------------------------------------------------------------------
   input          w1_valid;
   input    [7:0] w1_addr;
   input          w2_valid;
   input    [7:0] w2_addr;

   // -----------------------------------------------------------------------
   // Write data ports
   // -----------------------------------------------------------------------
   input   [38:0] w1_data;
   input   [38:0] w2_data;


   // -----------------------------------------------------------------------
   // Read output ports
   // -----------------------------------------------------------------------
   output  [38:0] r1_data;
   output  [38:0] r2_data;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule  // fgu_frf_array

`endif


//////////////////////////////////////////
////// n2_icd_sp_16p5kb_cust
//////////////////////////////////////////



`ifndef FPGA

module n2_icd_lft_sb_array (
  adr_ac_h, 
  adr_ac_l, 
  rd_en_a_l, 
  quaden_f_l, 
  wr_word_en_ac_l, 
  wr_waysel0_ac_l, 
  wr_waysel1_ac_l, 
  din0_a, 
  din1_a, 
  rd_worden_ac_l, 
  l1clk, 
  reg_d_lft, 
  reg_en_lft, 
  vnw_ary, 
  dout_wy0_bc, 
  dout_wy1_bc, 
  dout_wy2_bc, 
  dout_wy3_bc);


input [5:0] 	adr_ac_h ;
input [5:0] 	adr_ac_l ;
input       	rd_en_a_l ;
input       	quaden_f_l ;
input [1:0] 	wr_word_en_ac_l ;
input [3:0] 	wr_waysel0_ac_l ;
input [3:0] 	wr_waysel1_ac_l ;
input [16:0] 	din0_a ;
input [16:0] 	din1_a ;
input [1:0]  	rd_worden_ac_l ;
input        	l1clk ;

input [4:0]     reg_d_lft;
input [1:0]     reg_en_lft;

input		vnw_ary;

output [16:0] 	dout_wy0_bc ;
output [16:0] 	dout_wy1_bc ;
output [16:0] 	dout_wy2_bc ;
output [16:0] 	dout_wy3_bc ;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule
`endif 	// `ifndef FPGA


`ifndef FPGA
module n2_icd_rgt_sb_array (
  adr_ac_h, 
  adr_ac_l, 
  rd_en_a_l, 
  quaden_f_l, 
  wr_word_en_ac_l, 
  wr_waysel0_ac_l, 
  wr_waysel1_ac_l, 
  din0_a, 
  din1_a, 
  rd_worden_ac_l, 
  l1clk, 
  vnw_ary, 
  reg_d_rgt, 
  reg_en_rgt, 
  dout_wy0_bc, 
  dout_wy1_bc, 
  dout_wy2_bc, 
  dout_wy3_bc);


input [5:0] 	adr_ac_h ;
input [5:0] 	adr_ac_l ;
input       	rd_en_a_l ;
input       	quaden_f_l ;
input [1:0] 	wr_word_en_ac_l ;
input [3:0] 	wr_waysel0_ac_l ;
input [3:0] 	wr_waysel1_ac_l ;
input [32:17] 	din0_a ;
input [32:17] 	din1_a ;
input [1:0]  	rd_worden_ac_l ;
input        	l1clk ;

input		vnw_ary;

input [4:0]     reg_d_rgt;
input [1:0]     reg_en_rgt;

output [15:0] 	dout_wy0_bc ;
output [15:0] 	dout_wy1_bc ;
output [15:0] 	dout_wy2_bc ;
output [15:0] 	dout_wy3_bc ;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule
`endif	// `ifndef FPGA

//////////////////////////////////////////
////// n2_dva_dp_32x32_cust
//////////////////////////////////////////

module n2_dva_dp_32x32_array (
  clk, 
  rd_addr, 
  wr_addr, 
  din, 
  bit_wen, 
  rd_en, 
  wr_en, 
  dout);

input		clk;
input	[4:0]	rd_addr;
input	[4:0]	wr_addr;
input	[31:0]	din;
input	[31:0]	bit_wen;
input		rd_en;
input		wr_en;
   
output	[31:0]	dout;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule



//////////////////////////////////////////
////// n2_ict_sp_1920b_cust
//////////////////////////////////////////

module n2_ict_sp_1920b_array (
  clk, 
  rd_en_b, 
  wr_en_w_b, 
  rd_en_a, 
  wrreq_a, 
  addr, 
  wr_inhibit, 
  din, 
  dout);


`define WIDTH 30


input			clk;
input	     		rd_en_b;	// comes on negedge
input	     		wr_en_w_b;	// comes on negedge (way specific)
input	     		rd_en_a;	// comes on posedge
input	     		wrreq_a;	// comes on posedge (not way specific)
input	[6-1:0]	addr;		// comes on negedge
input			wr_inhibit;	// async

input	[30-1:0]	din;		// comes on posedge
output	[30-1:0]	dout;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule


//////////////////////////////////////////
////// n2_dca_sp_9kb_cust
//////////////////////////////////////////

module n2_dca_sp_9kb_subbank (
  l1clk, 
  l1clk_wr, 
  rd_en_b, 
  rd_en_a, 
  wr_en_a, 
  wr_en_b, 
  wr_inh_b, 
  addr_b, 
  byte_wr_en_b, 
  wr_waysel_b, 
  wr_data_a, 
  red_data, 
  red_en, 
  vnw_ary, 
  w0_rdata_h, 
  w0_rdata_l, 
  w1_rdata_h, 
  w1_rdata_l);

// way0 and way1 are interleaved physically across 2 subbanks
//        [288,277,..................,145,144] -- xdec -- [143,142,.............,1,0]
//          H   L   H   L       H   L   H   L  -- xdec --  L   H   L   H      L H L H      
// way1 = [288,287,284,283,...,151,150,147,146 -- xdec -- 141,140,137,136,...,5,4,1,0
// way0 = [286,285,282,281,...,149,148,145,144 -- xdec -- 143,142,139,138,...,7,6,3,2

input		l1clk;          // l1clk from l1clk_header
input		l1clk_wr;       // l1clk from l1clk_header
input		rd_en_b;        // e_cycle b_phase signal
input		rd_en_a;        // m_cycle a_phase signal
input		wr_en_a;        // m_cycle a_phase signal
input		wr_en_b;        // e_cycle b_phase signal
input		wr_inh_b;       // e_cycle b_phase signal
input   [10:3]	addr_b;         // e_cycle b_phase signal
input   [7:0]	byte_wr_en_b;   // e_cycle b_phase signal
input   [1:0]	wr_waysel_b;    // e_cycle b_phase signal

input   [71:0]	wr_data_a;   // m_cycle a_phase signal

input	[5:0]	red_data;
input	[1:0]	red_en;

input		vnw_ary;

output  [35:0]	w0_rdata_h;     // m_cycle b_phase clock-like signal    
output  [35:0]	w0_rdata_l;     // m_cycle b_phase clock-like signal    
output  [35:0]	w1_rdata_h;     // m_cycle b_phase clock-like signal    
output  [35:0]	w1_rdata_l;     // m_cycle b_phase clock-like signal    


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif


endmodule

//////////////////////////////////////////
////// n2_com_dp_32x152_cust
//////////////////////////////////////////

module n2_com_dp_32x152_cust_n2_com_array_macro__rows_32__width_152__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[4:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[4:0]	wr_adr;
input	[152-1:0]	din;
output	[152-1:0]	dout; 


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule

//////////////////////////////////////////
////// n2_com_dp_64x84_cust
//////////////////////////////////////////

module n2_com_dp_64x84_cust_n2_com_array_macro__rows_64__width_84__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[5:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[5:0]	wr_adr;
input	[84-1:0]	din;
output	[84-1:0]	dout; 


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule 


//////////////////////////////////////////
////// n2_dta_sp_1920b_cust
//////////////////////////////////////////

module n2_dta_sp_1920b_array (
  clk, 
  rd_en_b, 
  wr_en_b, 
  rd_en_a, 
  wr_en_a, 
  addr, 
  wr_inhibit, 
  din, 
  dout);
wire rd_en_b_unused;
	

`define	WIDTH 30

input			clk;
input	     		rd_en_b;	// comes on negedge
input	     		wr_en_b;	// comes on negedge (way specific)
input	     		rd_en_a;	// comes on posedge
input	     		wr_en_a;	// comes on posedge (not way specific)
input	[7-1:0]	addr;		// comes on negedge
input			wr_inhibit;	// async

input	[30-1:0]	din;		// comes on posedge
output	[30-1:0]	dout;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule


//////////////////////////////////////////
////// n2_stb_cm_64x45_cust
//////////////////////////////////////////


`ifndef FPGA
module n2_stb_cm_64x45_array (
  cam_rw_ptr, 
  cam_rw_tid, 
  wptr_vld, 
  rptr_vld, 
  camwr_data, 
  cam_vld, 
  cam_cm_tid, 
  cam_line_en, 
  cam_ldq, 
  stb_rdata, 
  stb_ld_partial_raw, 
  stb_cam_hit_ptr, 
  stb_cam_hit, 
  stb_cam_mhit, 
  clk, 
  tcu_array_wr_inhibit, 
  siclk);
wire [5:0] rw_addr;
wire write_vld;
wire read_vld;
wire [7:0] byte_overlap_mx;
wire [7:0] byte_match_mx;
wire [7:0] ptag_hit_mx;
wire [7:0] cam_hit;


input	[2:0]	cam_rw_ptr ;	// wr pointer for single port.
input	[2:0]	cam_rw_tid ;	// thread id for rw.
input		wptr_vld ;	// write pointer vld
input		rptr_vld ;	// read pointer vld

input	[44:0]	camwr_data ;	// data for compare/write
input		cam_vld ;	// cam is required.
input	[2:0]	cam_cm_tid ;	// thread id for cam operation.
input	[7:0]	cam_line_en;	// mask for squashing cam results (unflopped input)

input		cam_ldq ; 	// quad-ld cam.


output	[44:0]	stb_rdata;	// rd data from CAM RAM.
output		stb_ld_partial_raw ; // ld with partial raw.
output	[2:0]	stb_cam_hit_ptr ;
output		stb_cam_hit ;	  // any hit in stb
output		stb_cam_mhit ;	  // multiple hits in stb	

input		clk;
input		tcu_array_wr_inhibit;
input		siclk;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule
`endif


//////////////////////////////////////////
////// n2_com_dp_32x72_cust
//////////////////////////////////////////

module n2_com_dp_32x72_cust_n2_com_array_macro__rows_32__width_72__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[4:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[4:0]	wr_adr;
input	[72-1:0]	din;
output	[72-1:0]	dout; 


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule

//////////////////////////////////////////
////// n2_com_dp_32x84_cust
//////////////////////////////////////////


module n2_com_dp_32x84_cust_n2_com_array_macro__rows_32__width_84__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[4:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[4:0]	wr_adr;
input	[84-1:0]	din;
output	[84-1:0]	dout; 


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif


endmodule 


//////////////////////////////////////////
////// n2_tlb_tl_64x59_cust
//////////////////////////////////////////

`ifndef FPGA
module n2_tlb_tl_64x59_cam (
  l1clk, 
  tlb_bypass, 
  tlb_wr_flopped, 
  tlb_rd_flopped, 
  rw_index, 
  tlb_cam, 
  tlb_cam_flopped, 
  demap, 
  demap_context, 
  demap_all, 
  demap_real, 
  tte_tag, 
  tte_tag_flopped, 
  tte_page_size_mask, 
  tag_read_mux_control, 
  tlb_cam_hit, 
  context0_hit, 
  rd_tte_tag, 
  ram_wwl, 
  ram_rwl, 
  valid) ;




input		l1clk;

input		tlb_bypass;
input		tlb_wr_flopped;
input		tlb_rd_flopped;
input	[5:0] rw_index;
input		tlb_cam;
input		tlb_cam_flopped;
input		demap;
input		demap_context;
input		demap_all;
input		demap_real;

input	[65:0]	tte_tag;
input	[65:0]	tte_tag_flopped;
input	[2:0]	tte_page_size_mask;

input 		tag_read_mux_control;



output		tlb_cam_hit;
output		context0_hit;
output	[65:0]	rd_tte_tag;
output	[64-1:0] ram_wwl;
output	[64-1:0] ram_rwl;
output	[64-1:0] valid;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule
`endif // `ifndef FPGA

`ifndef FPGA
module n2_tlb_tl_64x59_ram (
  l1clk, 
  tlb_bypass, 
  tlb_cam_flopped, 
  ram_wwl, 
  ram_rwl, 
  tte_data, 
  va, 
  pa, 
  rd_tte_data) ;
wire any_wwl;
wire any_rwl;
wire [37:0] prd_data;
wire [39:13] tte_pa;




input		l1clk;

input		tlb_bypass;
input 		tlb_cam_flopped;
input	[64-1:0] ram_wwl;
input	[64-1:0] ram_rwl;

input	[37:0]	tte_data;
input	[39:11]	va;		// Incoming VA



output	[39:11]	pa;
output	[37:0]	rd_tte_data;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule
`endif // `ifndef FPGA


//////////////////////////////////////////
////// n2_tlb_tl_128x59_cust
//////////////////////////////////////////

`ifndef FPGA
module n2_tlb_tl_128x59_cam (
  l1clk, 
  tlb_bypass, 
  tlb_wr_flopped, 
  tlb_rd_flopped, 
  rw_index, 
  tlb_cam, 
  tlb_cam_flopped, 
  demap, 
  demap_context, 
  demap_all, 
  demap_real, 
  tte_tag, 
  tte_tag_flopped, 
  tte_page_size_mask, 
  tag_read_mux_control, 
  tlb_cam_hit, 
  context0_hit, 
  rd_tte_tag, 
  ram_wwl, 
  ram_rwl, 
  valid) ;



input		l1clk;

input		tlb_bypass;
input		tlb_wr_flopped;
input		tlb_rd_flopped;
input	[6:0] rw_index;
input		tlb_cam;
input		tlb_cam_flopped;
input		demap;
input		demap_context;
input		demap_all;
input		demap_real;

input	[65:0]	tte_tag;
input	[65:0]	tte_tag_flopped;
input	[2:0]	tte_page_size_mask;

input 		tag_read_mux_control;



output		tlb_cam_hit;
output		context0_hit;
output	[65:0]	rd_tte_tag;
output	[128-1:0] ram_wwl;
output	[128-1:0] ram_rwl;
output	[128-1:0] valid;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule
`endif 	// `ifndef FPGA

`ifndef FPGA
module n2_tlb_tl_128x59_ram (
  l1clk, 
  tlb_bypass, 
  tlb_cam_flopped, 
  ram_wwl, 
  ram_rwl, 
  tte_data, 
  va, 
  force_data_to_x, 
  pa, 
  rd_tte_data) ;




input		l1clk;

input		tlb_bypass;
input 		tlb_cam_flopped;
input	[128-1:0] ram_wwl;
input	[128-1:0] ram_rwl;

input	[37:0]	tte_data;
input	[39:11]	va;		// Incoming VA
input		force_data_to_x;



output	[39:11]	pa;
output	[37:0]	rd_tte_data;


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule
`endif 	// `ifndef FPGA


//////////////////////////////////////////
////// n2_mmu_cm_64x34s_cust 
//////////////////////////////////////////

module n2_mmu_cm_64x34s_cust_array	(

   // ram control
   clk,
   l2clk,
   rd_addr_array,
   wr_addr_array,
   wr_array,
   rd_array,
   lkup_en_array,
   hld_array,
   din_array, 
   key_array, 
   hit_array, 
   dout_array    

);




   // 
   input 		clk,l2clk;				// clk 
   input [5:0]		rd_addr_array;			// read port address in
   input [5:0]		wr_addr_array;			// write port address in
   input		wr_array;			// write port enable
   input		rd_array;			// read port enable
   input		lkup_en_array;			// enable CAM operation
   input		hld_array;			// enable CAM operation
   input [32:0] 	din_array;			// data in
   input [32:0] 	key_array;			// value to CAM against
   output [32:0] 	dout_array;			// data out
   output [63:0] 	hit_array;			// results of CAM operation

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule	// n2_mmu_cm_64x34s_cust_array



//////////////////////////////////////////
////// n2_l2t_sp_28kb_cust  
//////////////////////////////////////////


`define L2T_ARR_D_WIDTH            28
`define L2T_ARR_DEPTH              512
`define WAY_HIT_WIDTH              16
`define BADREAD                	   BADBADD 


`define  sh_index_lft		  5'b00000
`define  sh_index_rgt		  5'b00000

module n2_l2t_array (
  din, 
  addr_b, 
  l1clk_internal_v1, 
  l1clk_internal_v2, 
  ln1clk, 
  ln2clk, 
  rd_en_b, 
  rd_en_d1_a, 
  rpda_lft, 
  rpda_rgt, 
  rpdb_lft, 
  rpdb_rgt, 
  rpdc_lft, 
  rpdc_rgt, 
  w_inhibit_l, 
  wr_en_b, 
  wr_en_d1_a, 
  wr_way_b, 
  wr_way_b_l, 
  vnw_ary, 
  sao_mx0_h, 
  sao_mx0_l, 
  sao_mx1_h, 
  sao_mx1_l);


input	[`L2T_ARR_D_WIDTH - 1:0]	din;
input	[8:0]	 			addr_b;
input		 			l1clk_internal_v1;
input		 			l1clk_internal_v2;
input		 			ln1clk;
input		 			ln2clk;
input		 			rd_en_b;
input		 			rd_en_d1_a;
input	[1:0]	 			rpda_lft;
input	[1:0]	 			rpda_rgt;
input	[3:0]	 			rpdb_lft;
input	[3:0]	 			rpdb_rgt;
input	[3:0]	 			rpdc_lft;
input	[3:0]	 			rpdc_rgt;
input		 			w_inhibit_l;
input		 			wr_en_b;
input		 			wr_en_d1_a;
input   [1:0]	 			wr_way_b;
input   [1:0]	 			wr_way_b_l;

// Added vnw_ary pin for n2 for 2.0

input                                   vnw_ary;

output  [`L2T_ARR_D_WIDTH - 1:0]	sao_mx0_h;
output  [`L2T_ARR_D_WIDTH - 1:0]	sao_mx0_l;
output  [`L2T_ARR_D_WIDTH - 1:0]	sao_mx1_h;
output  [`L2T_ARR_D_WIDTH - 1:0]	sao_mx1_l;


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule

//////////////////////////////////////////
////// n2_l2d_sp_512kb_cust   
//////////////////////////////////////////

module n2_l2d_16kb_cust (
  waysel_c4, 
  waysel_err_c3, 
  set_c3b, 
  coloff_c3b_l, 
  coloff_c4_l, 
  coloff_c5, 
  wen_c3b, 
  readen_c5, 
  worden_c3b, 
  l1clk, 
  wrd_lo0_b_l, 
  wrd_lo1_b_l, 
  wrd_hi0_b_l, 
  wrd_hi1_b_l, 
  red_adr, 
  cred, 
  tstmodclk_l, 
  wee_l, 
  vnw_ary, 
  saout_lo0_bc_l, 
  saout_lo1_bc_l, 
  saout_hi0_bc_l, 
  saout_hi1_bc_l);
		
input [7:0] 	waysel_c4;		
input		waysel_err_c3;		// 	Active when multiple way sel is on
input [8:0]   	set_c3b;		//	After b-latch
input    	coloff_c3b_l;		//	After b-latch+inv
input    	coloff_c4_l;		//	stage+inv
input [1:0]   	coloff_c5;		//	2-stage
input         	wen_c3b;	 	//	Write-enable, after b-latch
input         	readen_c5;	 	//	
input [3:0]   	worden_c3b;		//	After b-latch
input         	l1clk;	 		//	After l1clk hdr
input [19:0]  	wrd_lo0_b_l;		//	
input [18:0]  	wrd_lo1_b_l;		//	
input [19:0]  	wrd_hi0_b_l;		//	
input [18:0]  	wrd_hi1_b_l;		//	
input [9:0]	red_adr;		// Redudancy address
input [77:0]	cred;			// Redudancy address
input		tstmodclk_l;		//NEW
input		wee_l;			//NEW
input           vnw_ary;                //NEW

//output		bnken_lat;	//	Address latch enable (1.5cycle)
output [19:0]  	saout_lo0_bc_l;		//	C5bc output from senseamp
output [18:0]  	saout_lo1_bc_l;		//	C5bc output from senseamp
output [19:0]  	saout_hi0_bc_l;		//	C5bc output from senseamp
output [18:0]  	saout_hi1_bc_l;		//	C5bc output from senseamp

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule

//////////////////////////////////////////
////// n2_l2t_dp_32x128_cust    
//////////////////////////////////////////

module n2_l2t_dp_32x128_cust_array (
  wr_en, 
  rd_en, 
  l1clk, 
  wr_addr, 
  rd_addr, 
  write_disable, 
  din, 
  dout) ;

input 		wr_en;
input 		rd_en;
input 		l1clk;
input 	[31:0] 	wr_addr;
input 	[31:0] 	rd_addr;
input 		write_disable;
input 	[127:0] din;

output 	[127:0] dout;


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule // rf_32x128d


//////////////////////////////////////////
////// n2_com_cm_32x40_cust     
//////////////////////////////////////////


module n2_com_cm_32x40_cust_array (
  l1clk, 
  wr_en, 
  rd_en, 
  tcu_array_wr_inhibit, 
  key, 
  wr_addr, 
  rd_addr, 
  din, 
  lookup_en, 
  bypass, 
  dout, 
  match, 
  match_idx);

input l1clk;
input wr_en;
input rd_en;

input tcu_array_wr_inhibit;
input [41:7] key;
input [31:0] wr_addr;
input [31:0] rd_addr;
input [41:0] din;
input lookup_en;
input bypass;

output [41:0] dout;
output [31:0] match;
output [31:0] match_idx;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif


endmodule


//////////////////////////////////////////
////// n2_com_cm_64x64_cust     
//////////////////////////////////////////

module dc_panel_array (
  l2clk, 
  wr_en, 
  rd_en, 
  cam_en, 
  rst_warm, 
  write_disable, 
  force_hit, 
  rw_addr, 
  inval_mask, 
  wr_data, 
  valid_bit, 
  bypass, 
  valid, 
  rd_data, 
  lkup_hit);

input          		l2clk;
input          		wr_en;
input          		rd_en;
input          		cam_en;
input          		rst_warm;
input          		write_disable;
input			force_hit;
input   [5:0]  		rw_addr;
input   [63:0] 		inval_mask;
input   [15:0] 		wr_data;
input   [63:0] 		valid_bit;
input			bypass;
output  [63:0] 		valid;
output  [15:0] 		rd_data;
output  [63:0] 		lkup_hit;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule


//////////////////////////////////////////
////// n2_com_cm_8x40_cust      
//////////////////////////////////////////

module n2_com_cm_8x40_cust_array (
  l1clk, 
  l2clk, 
  l1clk_mat, 
  wr_en, 
  rd_en, 
  write_disable, 
  key, 
  wr_addr, 
  rd_addr, 
  din, 
  lookup_en, 
  bypass, 
  dout, 
  match_p, 
  match_idx_p);

input l1clk;
input l2clk;
input l1clk_mat;
input wr_en;
input rd_en;
input write_disable;
input [39:7] key;
input [7:0] wr_addr;
input [7:0] rd_addr;
input [39:0] din;
input lookup_en;
input bypass;
output [39:0] dout;
output [7:0] match_p;
output [7:0] match_idx_p;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule


//////////////////////////////////////////
////// n2_l2t_dp_16x160_cust     
//////////////////////////////////////////

module n2_l2t_dp_16x160_cust_array (
  l1clk, 
  wr_en, 
  rd_en, 
  tcu_array_wr_inhibit, 
  word_wen, 
  wr_addr, 
  rd_addr, 
  din, 
  byte_wen, 
  dout);
input		l1clk;
input 		wr_en;
input 		rd_en;
input 		tcu_array_wr_inhibit;
input [3:0] 	word_wen;
input [3:0] 	wr_addr;
input [3:0] 	rd_addr;
input [159:0] 	din;
input [19:0] 	byte_wen;

output [159:0] 	dout;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule


//////////////////////////////////////////
////// n2_l2t_dp_32x160_cust      
//////////////////////////////////////////


module n2_l2t_dp_32x160_cust_array (
  l1clk, 
  wr_en, 
  rd_en, 
  tcu_array_wr_inhibit, 
  word_wen, 
  wr_addr, 
  rd_addr, 
  din, 
  dout);

input 		l1clk;
input 		wr_en;
input 		rd_en;
input 		tcu_array_wr_inhibit;
input [3:0] 	word_wen;
input [4:0] 	wr_addr;
input [4:0] 	rd_addr;
input [159:0] 	din;
output [159:0] 	dout;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule // rf_32x160


//////////////////////////////////////////
////// n2_mcu_32x72async_dp_cust       
//////////////////////////////////////////

module n2_mcu_32x72async_dp_cust_n2_com_array_macro__rows_32__width_72__z_array (
  rclk, 
  wclk, 
  rd_adr, 
  rd_en, 
  wr_en, 
  wr_adr, 
  din, 
  dout);

input		rclk;
input		wclk;
input	[4:0]	rd_adr;
input		rd_en;
input		wr_en;
input	[4:0]	wr_adr;
input	[72-1:0]	din;
output	[72-1:0]	dout; 

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule


//////////////////////////////////////////
////// n2_iom_sp_devtsb_cust        
//////////////////////////////////////////

module n2_iom_sp_1024b_cust (

  clk,
  adr_r,
  adr_w,
  rd,
  wr,
  din,
  dout

);


  input		 clk;
  input	[3:0]	 adr_r;
  input	[3:0]	 adr_w;
  input          rd;
  input	 	 wr;
  input  [63:0]  din;
  output [63:0]  dout;


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif


endmodule       // n2_iom_sp_1024b_cust



module n2_iom_sp_2048b_cust (

  clk,
  adr_r,
  adr_w,
  rd,
  wr,
  din,
  dout,
  efu_bits

);


  input		 clk;
  input	[4:0]	 adr_r;
  input	[4:0]	 adr_w;
  input          rd;
  input	 	 wr;
  input  [63:0]  din;
  input  [3:0]   efu_bits;
  output [63:0]  dout;

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule       // n2_iom_sp_2048b_cust


//////////////////////////////////////////
////// n2_dmu_dp_128x132s_cust         
//////////////////////////////////////////

module n2_dmu_dp_128x132s_cust_array	(

   // ram control
   clk,
   rd_addr_array,
   wr_addr_array,
   rd_array, 
   wr_array,
   din_array, 
   dout_array    

);




   // 
   input 		clk;				// clk 
   input [6:0]		rd_addr_array;			// read port address in
   input [6:0]		wr_addr_array;			// write port address in
   input		rd_array;			// read port enable
   input		wr_array;			// write port enable
   input [131:0] 	din_array;			// data in
   output [131:0] 	dout_array;			// data out

`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif


endmodule	// n2_dmu_dp_128x132s_cust_array


//////////////////////////////////////////
////// n2_dmu_dp_144x149s_cust          
//////////////////////////////////////////

module n2_dmu_dp_144x149s_cust_array	(

   // ram control
   clk,
   rd_addr_array,
   wr_addr_array,
   rd_array, 
   wr_array,
   din_array, 
   dout_array    

);




   // 
   input 		clk;				// clk 
   input [7:0]		rd_addr_array;			// read port address in
   input [7:0]		wr_addr_array;			// write port address in
   input		rd_array;			// read port enable
   input		wr_array;			// write port enable
   input [148:0] 	din_array;			// data in
   output [148:0] 	dout_array;			// data out



`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule	// n2_dmu_dp_144x149s_cust_array


//////////////////////////////////////////
////// n2_dmu_dp_512x60s_cust           
//////////////////////////////////////////

module n2_dmu_dp_512x60s_cust_array	(

   // ram control
   clk,
   rd_addr_array,
   wr_addr_array,
   rd_array, 
   wr_array,
   din_array, 
   dout_array    

);




   // 
   input 		clk;				// clk 
   input [8:0]		rd_addr_array;			// read port address in
   input [8:0]		wr_addr_array;			// write port address in
   input		rd_array;			// read port enable
   input		wr_array;			// write port enable
   input [59:0] 	din_array;			// data in
   output [59:0] 	dout_array;			// data out


`ifdef BLACK_BOX_FLOW
// synopsys translate_off
`endif

supply0 vss;
supply1 vdd;

`ifdef BLACK_BOX_FLOW
// synopsys translate_on
`endif

endmodule	// n2_dmu_dp_512x60s_cust_array



