// gclk 50-50
module l2c_wrapper_2 (/*AUTOARG*/ gclk, rst
   // Outputs
   );
   //                                                       I/O     constraint

input rst;

//////////////////////////////////////////////////////////////////////////////
// l2b0 Interface with l2t0
//////////////////////////////////////////////////////////////////////////////

wire           l2t0_l2b0_fbrd_en_c3;   	// PINDEF:RIGHT // rd en for a fill operation or fb bypass
wire   [2:0]   l2t0_l2b0_fbrd_wl_c3 ;  	// PINDEF:RIGHT // read entry
wire   [15:0]  l2t0_l2b0_fbwr_wen_r2 ; 	// PINDEF:RIGHT // mcu Fill or store in OFF mode.
wire   [2:0]   l2t0_l2b0_fbwr_wl_r2 ;  	// PINDEF:RIGHT // mcu Fill entry.
wire           l2t0_l2b0_fbd_stdatasel_c3; // PINDEF:RIGHT 	// select store data in OFF mode
wire   [77:0]  l2t0_l2d0_stdecc_c2;    	// PINDEF:BOT // store data goes to l2b and l2d0
wire           l2t0_l2b0_evict_en_r0;	// PINDEF:RIGHT
wire   [3:0]   l2t0_l2b0_wbwr_wen_c6;  	// PINDEF:RIGHT // write en
wire   [2:0]   l2t0_l2b0_wbwr_wl_c6;   	// PINDEF:RIGHT // from wbctl
wire           l2t0_l2b0_wbrd_en_r0;   	// PINDEF:RIGHT // triggerred by a wr_ack from mcu
wire   [2:0]   l2t0_l2b0_wbrd_wl_r0;	// PINDEF:RIGHT
wire   [2:0]   l2t0_l2b0_ev_dword_r0;	// PINDEF:RIGHT
wire   [15:0]  l2t0_l2b0_rdma_wren_s2;	// PINDEF:RIGHT
wire   [ 1:0]  l2t0_l2b0_rdma_wrwl_s2;	// PINDEF:RIGHT
wire           l2t0_l2b0_rdma_rden_r0;	// PINDEF:RIGHT
wire   [ 1:0]  l2t0_l2b0_rdma_rdwl_r0;	// PINDEF:RIGHT
wire           l2t0_l2b0_ctag_en_c7;	// PINDEF:RIGHT
wire   [31:0]  l2t0_l2b0_ctag_c7;	// PINDEF:BOT	//Ctag<23:0>= {Ordered,PES bits,read bit, tag[15:0]} Phase 2 : SIU inteface and packet format change 2/7/04
wire           l2t0_l2b0_req_en_c7;	// PINDEF:RIGHT
wire   [ 3:0]  l2t0_l2b0_word_c7;	// PINDEF:RIGHT
wire           l2t0_l2b0_word_vld_c7;	// PINDEF:RIGHT

wire   [31:0]  sii_l2t0_req;		// PINDEF:BOT
wire   [ 6:0]  sii_l2b0_ecc;		// PINDEF:BOT

assign sii_l2t0_req = 'b0;
assign sii_l2b0_ecc = 'b0; 

//// Outputs

wire          l2b0_sio_ctag_vld;	// PINDEF:RIGHT
wire  [31:0]  l2b0_sio_data;		// PINDEF:BOT
wire          l2b0_sio_ue_err;		// PINDEF:RIGHT
wire          l2b0_l2t0_rdma_uerr_c10;	// PINDEF:RIGHT
wire          l2b0_l2t0_rdma_cerr_c10;	// PINDEF:RIGHT
wire		l2b0_l2t0_rdma_notdata_c10; // PINDEF:RIGHT
wire          l2b0_l2t0_ev_uerr_r5;	// PINDEF:RIGHT
wire          l2b0_l2t0_ev_cerr_r5;	// PINDEF:RIGHT

//  Phase 2 : SIU interface changes : 2/5/04 
wire	[1:0]	l2b0_sio_parity;		// PINDEF:RIGHT 

//////////////////////////////////////////////////////////////////////////////
// l2b0 Interface with l2d0
//////////////////////////////////////////////////////////////////////////////
wire   [623:0]  l2d0_l2b0_decc_out_c7;  // PINDEF:TOP

//// Outputs

wire  [623:0]  l2b0_l2d0_fbdecc_c4;	// PINDEF:TOP 
//////////////////////////////////////////////////////////////////////////////
// l2b0 Interface with the DRAM
//////////////////////////////////////////////////////////////////////////////

wire   [127:0]  mcu_l2b01_data_r2;	// PINDEF:BOT
wire   [27:0]   mcu_l2b01_ecc_r2;	// PINDEF:BOT
wire		select_delay_mcu;

//// Outputs

wire           l2b0_mcu_data_mecc_r5;	// PINDEF:BOT
wire  [63:0]   l2b0_mcu_wr_data_r5;	// PINDEF:BOT
wire           l2b0_mcu_data_vld_r5;	// PINDEF:BOT
//////////////////////////////////////////////////////////////////////////////
// Global Signals
//////////////////////////////////////////////////////////////////////////////

input		 gclk;
wire            rst_por_;	
wire            rst_wmr_;	
wire            rst_wmr_protect;	
wire		 scan_in;	
wire		 tcu_pce_ov;
wire		 tcu_clk_stop;
wire		 tcu_aclk;
wire		 tcu_bclk;
wire		 tcu_scan_en;
wire		 tcu_muxtest;
wire		 tcu_dectest;
wire           ccu_slow_cmp_sync_en;
wire           ccu_cmp_slow_sync_en;

assign            rst_por_ = 1'b0;	
assign            rst_wmr_ = 1'b0;	
assign            rst_wmr_protect = 1'b0;	
assign		 scan_in = 1'b0;	
assign		 tcu_pce_ov = 1'b0;
assign		 tcu_clk_stop = 1'b0;
assign		 tcu_aclk = 1'b0;
assign		 tcu_bclk = 1'b0;
assign		 tcu_scan_en = 1'b0;
assign		 tcu_muxtest = 1'b0;
assign		 tcu_dectest = 1'b0;


 
wire            tcu_se_scancollar_in;
wire            tcu_se_scancollar_out;
wire            tcu_array_wr_inhibit;
wire            tcu_atpg_mode;
wire            tcu_array_bypass;
wire		 cluster_arst_l;

wire           l2b0_scan_out;	
wire           l2b1_scan_out;			

// Mbist pins
wire 		tcu_mbist_bisi_en;
wire 		tcu_l2b_mbist_start;
wire 		tcu_l2b_mbist_scan_in;
wire 		tcu_mbist_user_mode;

assign            tcu_se_scancollar_in = 1'b0;
assign            tcu_se_scancollar_out = 1'b0;
assign            tcu_array_wr_inhibit = 1'b0;
assign            tcu_atpg_mode = 1'b0;
assign            tcu_array_bypass = 1'b0;
assign		 cluster_arst_l = 1'b1;

assign 		tcu_mbist_bisi_en = 1'b0;
assign 		tcu_l2b_mbist_start = 1'b0;
assign 		tcu_l2b_mbist_scan_in = 1'b0;
assign 		tcu_mbist_user_mode = 1'b0;


///// Outputs

wire		l2b_tcu_mbist_done;
wire		l2b_tcu_mbist_fail;
wire		l2b_tcu_mbist_scan_out;

// Debug ports
wire		l2b_dbg_sio_ctag_vld;
wire		l2b_dbg_sio_ack_type;
wire		l2b_dbg_sio_ack_dest;

assign		l2b_dbg_sio_ctag_vld = 1'b0;
assign		l2b_dbg_sio_ack_type = 1'b0;
assign		l2b_dbg_sio_ack_dest = 1'b0;


//////////////////////////////////////////////////////////////////////////////
// Efuse related ports
//////////////////////////////////////////////////////////////////////////////
// to l2d0 fuse related ports
wire	[9:0]	l2b_l2d_rvalue;
wire	[6:0]	l2b_l2d_rid;
wire		l2b_l2d_wr_en;
wire		l2b_l2d_fuse_clr;

// from l2d0 fuse related ports
wire	[9:0]	l2d_l2b_fuse_data;

// efu to l2b0
wire		efu_l2b_fuse_data;
wire		efu_l2b_fuse_xfer_en;
wire		efu_l2b_fuse_clr;

assign		l2d_l2b_fuse_data = 'b0;
assign		efu_l2b_fuse_data = 1'b0;
assign		efu_l2b_fuse_xfer_en = 1'b0;
assign		efu_l2b_fuse_clr = 1'b0;

// l2b0 to efu
wire		l2b_efu_fuse_xfer_en;
wire		l2b_efu_fuse_data;

//////////////////////////////////////////////////////////////////////////////



l2b l2b0(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3t0 ), // ( gl_io_cmp_sync_en_c3t ), - for int6.1
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3t0 ), // ( gl_cmp_io_sync_en_c3t ), - for int6.1
  .select_delay_mcu ( 1'b0 ),

  .gclk                     ( cmp_gclk_c3_l2b0 ), // cmp_gclk_c0_r[1]), 
  .tcu_clk_stop ( gl_l2b0_clk_stop ),	// staged clk_stop
  .rst_por_                 (gl_l2_por_c3t0 			), // ( gl_l2_por_c3t ), - for int6.1
  .rst_wmr_                 (gl_l2_wmr_c3t0 			), // ( gl_l2_wmr_c3t ), - for int6.1
  .l2t_l2b_fbrd_en_c3       (l2t0_l2b0_fbrd_en_c3        ),// scbuf
  .l2t_l2b_fbrd_wl_c3       (l2t0_l2b0_fbrd_wl_c3        ),
  .l2t_l2b_fbwr_wen_r2      (l2t0_l2b0_fbwr_wen_r2       ),
  .l2t_l2b_fbwr_wl_r2       (l2t0_l2b0_fbwr_wl_r2        ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t0_l2b0_fbd_stdatasel_c3  ),
  .l2t_l2b_stdecc_c2        (l2t0_l2d0_stdecc_c2[ 77 : 0 ]         ),
  .l2t_l2b_evict_en_r0      (l2t0_l2b0_evict_en_r0       ),
  .l2t_l2b_wbwr_wen_c6      (l2t0_l2b0_wbwr_wen_c6       ),
  .l2t_l2b_wbwr_wl_c6       (l2t0_l2b0_wbwr_wl_c6        ),
  .l2t_l2b_wbrd_en_r0       (l2t0_l2b0_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t0_l2b0_wbrd_wl_r0        ),
  .l2t_l2b_ev_dword_r0      (l2t0_l2b0_ev_dword_r0       ),
  .l2t_l2b_rdma_wren_s2     (l2t0_l2b0_rdma_wren_s2      ),
  .l2t_l2b_rdma_wrwl_s2     (l2t0_l2b0_rdma_wrwl_s2      ),
  .l2t_l2b_rdma_rden_r0     (l2t0_l2b0_rdma_rden_r0      ),
  .l2t_l2b_rdma_rdwl_r0     (l2t0_l2b0_rdma_rdwl_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t0_l2b0_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t0_l2b0_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_req_en_c7        (l2t0_l2b0_req_en_c7         ),
  .l2t_l2b_word_c7          (l2t0_l2b0_word_c7           ),
  .l2t_l2b_word_vld_c7      (l2t0_l2b0_word_vld_c7       ),
  .sii_l2t_req              (sii_l2t0_req                ),
  .sii_l2b_ecc              (sii_l2b0_ecc[ 6 : 0 ]           ),
  .l2b_l2d_rvalue          (l2b_l2d_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b_l2d_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b_l2d_wr_en),
  .l2b_l2d_fuse_clr        (l2b_l2d_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d_l2b_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b_dbg_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b_dbg_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b_dbg_sio_ack_dest	 ),
  .l2b_sio_ctag_vld         (l2b0_sio_ctag_vld           ),
  .l2b_sio_data             (l2b0_sio_data[ 31 : 0 ]         ),
  .l2b_sio_parity           (l2b0_sio_parity[ 1 : 0 ]        ),     
  .l2b_sio_ue_err           (l2b0_sio_ue_err             ),
  .l2b_l2t_rdma_uerr_c10    (l2b0_l2t0_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b0_l2t0_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b0_l2t0_rdma_notdata_c10  ),
  .l2b_l2t_ev_uerr_r5       (l2b0_l2t0_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b0_l2t0_ev_cerr_r5        ),
  .l2d_l2b_decc_out_c7      (l2d0_l2b0_decc_out_c7       ),
  .l2b_l2d_fbdecc_c4        (l2b0_l2d0_fbdecc_c4         ),
  .mcu_l2b_data_r2          (mcu_l2b01_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu_l2b01_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b_mbist_start        ),
  .l2b_tcu_mbist_done       (l2b_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b0_mcu_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b0_mcu_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b0_mcu_data_vld_r5       ),
  .scan_in                  (scan_in           ),
  .scan_out                 (l2b0_scan_out               ),
  .rst_wmr_protect(rst_wmr_protect),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_scan_en(tcu_scan_en),
  .tcu_muxtest(tcu_muxtest),
  .tcu_dectest(tcu_dectest),
  .tcu_se_scancollar_in(tcu_se_scancollar_in),
  .tcu_se_scancollar_out(tcu_se_scancollar_out),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .tcu_atpg_mode(tcu_atpg_mode),
  .tcu_array_bypass(tcu_array_bypass),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_user_mode(tcu_mbist_user_mode)
//.so                       (                            )
        );
//________________________________________________________________
   

//////////////////////////////////////////////////////////////////////////////
// l2b1 Interface with l2t1
//////////////////////////////////////////////////////////////////////////////

wire           l2t1_l2b1_fbrd_en_c3;   	// PINDEF:RIGHT // rd en for a fill operation or fb bypass
wire   [2:0]   l2t1_l2b1_fbrd_wl_c3 ;  	// PINDEF:RIGHT // read entry
wire   [15:0]  l2t1_l2b1_fbwr_wen_r2 ; 	// PINDEF:RIGHT // mcu Fill or store in OFF mode.
wire   [2:0]   l2t1_l2b1_fbwr_wl_r2 ;  	// PINDEF:RIGHT // mcu Fill entry.
wire           l2t1_l2b1_fbd_stdatasel_c3; // PINDEF:RIGHT 	// select store data in OFF mode
wire   [77:0]  l2t1_l2d1_stdecc_c2;    	// PINDEF:BOT // store data goes to l2b and l2d1
wire           l2t1_l2b1_evict_en_r0;	// PINDEF:RIGHT
wire   [3:0]   l2t1_l2b1_wbwr_wen_c6;  	// PINDEF:RIGHT // write en
wire   [2:0]   l2t1_l2b1_wbwr_wl_c6;   	// PINDEF:RIGHT // from wbctl
wire           l2t1_l2b1_wbrd_en_r0;   	// PINDEF:RIGHT // triggerred by a wr_ack from mcu
wire   [2:0]   l2t1_l2b1_wbrd_wl_r0;	// PINDEF:RIGHT
wire   [2:0]   l2t1_l2b1_ev_dword_r0;	// PINDEF:RIGHT
wire   [15:0]  l2t1_l2b1_rdma_wren_s2;	// PINDEF:RIGHT
wire   [ 1:0]  l2t1_l2b1_rdma_wrwl_s2;	// PINDEF:RIGHT
wire           l2t1_l2b1_rdma_rden_r0;	// PINDEF:RIGHT
wire   [ 1:0]  l2t1_l2b1_rdma_rdwl_r0;	// PINDEF:RIGHT
wire           l2t1_l2b1_ctag_en_c7;	// PINDEF:RIGHT
wire   [31:0]  l2t1_l2b1_ctag_c7;	// PINDEF:BOT	//Ctag<23:0>= {Ordered,PES bits,read bit, tag[15:0]} Phase 2 : SIU inteface and packet format change 2/7/04
wire           l2t1_l2b1_req_en_c7;	// PINDEF:RIGHT
wire   [ 3:0]  l2t1_l2b1_word_c7;	// PINDEF:RIGHT
wire           l2t1_l2b1_word_vld_c7;	// PINDEF:RIGHT

wire   [31:0]  sii_l2t1_req;		// PINDEF:BOT
wire   [ 6:0]  sii_l2b1_ecc;		// PINDEF:BOT

assign sii_l2t0_req = 'b0;
assign sii_l2b0_ecc = 'b0; 


//// Outputs

wire          l2b1_sio_ctag_vld;	// PINDEF:RIGHT
wire  [31:0]  l2b1_sio_data;		// PINDEF:BOT
wire          l2b1_sio_ue_err;		// PINDEF:RIGHT
wire          l2b1_l2t1_rdma_uerr_c10;	// PINDEF:RIGHT
wire          l2b1_l2t1_rdma_cerr_c10;	// PINDEF:RIGHT
wire		l2b1_l2t1_rdma_notdata_c10; // PINDEF:RIGHT
wire          l2b1_l2t1_ev_uerr_r5;	// PINDEF:RIGHT
wire          l2b1_l2t1_ev_cerr_r5;	// PINDEF:RIGHT

//  Phase 2 : SIU interface changes : 2/5/04 
wire	[1:0]	l2b1_sio_parity;		// PINDEF:RIGHT 

//////////////////////////////////////////////////////////////////////////////
// l2b1 Interface with l2d1
//////////////////////////////////////////////////////////////////////////////
wire   [623:0]  l2d1_l2b1_decc_out_c7;  // PINDEF:TOP

//// Outputs

wire  [623:0]  l2b1_l2d1_fbdecc_c4;	// PINDEF:TOP 
//////////////////////////////////////////////////////////////////////////////
// l2b1 Interface with the DRAM
//////////////////////////////////////////////////////////////////////////////


//// Outputs

wire           l2b1__mcu_data_mecc_r5;	// PINDEF:BOT
wire  [63:0]   l2b1_mcu_wr_data_r5;	// PINDEF:BOT
wire           l2b1_mcu_data_vld_r5;	// PINDEF:BOT





l2b l2b1(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3t ),
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3t ),
  .select_delay_mcu ( 1'b0 ),


  .gclk                     ( cmp_gclk_c3_l2b1 ), // cmp_gclk_c0_r[2]		 ), 
  .tcu_clk_stop ( gl_l2b1_clk_stop ),	// staged clk_stop
  .rst_por_                 ( gl_l2_por_c3t ), 
  .rst_wmr_                 ( gl_l2_wmr_c3t ), 
  .l2t_l2b_fbrd_en_c3       (l2t1_l2b1_fbrd_en_c3        ),// scbuf
  .l2t_l2b_fbrd_wl_c3       (l2t1_l2b1_fbrd_wl_c3        ),
  .l2t_l2b_fbwr_wen_r2      (l2t1_l2b1_fbwr_wen_r2       ),
  .l2t_l2b_fbwr_wl_r2       (l2t1_l2b1_fbwr_wl_r2        ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t1_l2b1_fbd_stdatasel_c3  ),
  .l2t_l2b_stdecc_c2        (l2t1_l2d1_stdecc_c2[ 77 : 0 ]         ),
  .l2t_l2b_evict_en_r0      (l2t1_l2b1_evict_en_r0       ),
  .l2t_l2b_wbwr_wen_c6      (l2t1_l2b1_wbwr_wen_c6       ),
  .l2t_l2b_wbwr_wl_c6       (l2t1_l2b1_wbwr_wl_c6        ),
  .l2t_l2b_wbrd_en_r0       (l2t1_l2b1_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t1_l2b1_wbrd_wl_r0        ),
  .l2t_l2b_ev_dword_r0      (l2t1_l2b1_ev_dword_r0       ),
  .l2t_l2b_rdma_wren_s2     (l2t1_l2b1_rdma_wren_s2      ),
  .l2t_l2b_rdma_wrwl_s2     (l2t1_l2b1_rdma_wrwl_s2      ),
  .l2t_l2b_rdma_rden_r0     (l2t1_l2b1_rdma_rden_r0      ),
  .l2t_l2b_rdma_rdwl_r0     (l2t1_l2b1_rdma_rdwl_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t1_l2b1_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t1_l2b1_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_req_en_c7        (l2t1_l2b1_req_en_c7         ),
  .l2t_l2b_word_c7          (l2t1_l2b1_word_c7           ),
  .l2t_l2b_word_vld_c7      (l2t1_l2b1_word_vld_c7       ),
  .sii_l2t_req              (sii_l2t1_req                ),
  .sii_l2b_ecc              (sii_l2b1_ecc[ 6 : 0 ]           ),
  .l2b_l2d_rvalue          (l2b_l2d_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b_l2d_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b_l2d_wr_en),
  .l2b_l2d_fuse_clr        (l2b_l2d_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d_l2b_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b_dbg_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b_dbg_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b_dbg_sio_ack_dest	 ),
  .l2b_sio_ctag_vld         (l2b1_sio_ctag_vld           ),
  .l2b_sio_data             (l2b1_sio_data[ 31 : 0 ]         ),
  .l2b_sio_parity           (l2b1_sio_parity[ 1 : 0 ]        ),     
  .l2b_sio_ue_err           (l2b1_sio_ue_err             ),
  .l2b_l2t_rdma_uerr_c10    (l2b1_l2t1_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b1_l2t1_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b1_l2t1_rdma_notdata_c10  ),
  .l2b_l2t_ev_uerr_r5       (l2b1_l2t1_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b1_l2t1_ev_cerr_r5        ),
  .l2d_l2b_decc_out_c7      (l2d1_l2b1_decc_out_c7       ),
  .l2b_l2d_fbdecc_c4        (l2b1_l2d1_fbdecc_c4         ),
  .mcu_l2b_data_r2          (mcu_l2b01_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu_l2b01_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b_mbist_start_ccxlff        ),
  .l2b_tcu_mbist_done       (l2b_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b1_mcu_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b1_mcu_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b1_mcu_data_vld_r5       ),
  .scan_in                  (l2b0_scan_out               ),
  .scan_out                 (l2b1_scan_out               ),
  .rst_wmr_protect(rst_wmr_protect),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_scan_en(tcu_scan_en),
  .tcu_muxtest(tcu_muxtest),
  .tcu_dectest(tcu_dectest),
  .tcu_se_scancollar_in(tcu_se_scancollar_in),
  .tcu_se_scancollar_out(tcu_se_scancollar_out),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .tcu_atpg_mode(tcu_atpg_mode),
  .tcu_array_bypass(tcu_array_bypass),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_user_mode(tcu_mbist_user_mode)
//.so                       (                            )
        );
//________________________________________________________________
   
/////// stagging flop


wire [ 191 : 0 ] unconnectedt0lff;
wire [ 191 : 0 ] unconnectedt1lff;
wire [ 191 : 0 ] unconnectedt2lff;
wire [ 191 : 0 ] unconnectedt3lff;
wire [ 191 : 0 ] unconnectedt4lff;
wire [ 191 : 0 ] unconnectedt5lff;
wire [ 191 : 0 ] unconnectedt6lff;
wire [ 191 : 0 ] unconnectedt7lff;
wire [ 191 : 0 ] unconnectedt0rff;
wire [ 191 : 0 ] unconnectedt1rff;
wire [ 191 : 0 ] unconnectedt2rff;
wire [ 191 : 0 ] unconnectedt3rff;
wire [ 191 : 0 ] unconnectedt4rff;
wire [ 191 : 0 ] unconnectedt5rff;
wire [ 191 : 0 ] unconnectedt6rff;
wire [ 191 : 0 ] unconnectedt7rff;


////////////////////////////////////////////////////////////////////////////// 
// l2t0 CCX interface 
////////////////////////////////////////////////////////////////////////////// 
`define	PCX_WIDTH	130  //PCX payload packet width , BS and SR 11/12/03 N2 Xbar Packet format change
`define	PCX_WIDTH_LESS1	129  //PCX payload packet width , BS and SR 11/12/03 N2 Xbar Packet format change
`define	CPX_WIDTH	146  //CPX payload packet width, BS and SR 11/12/03 N2 Xbar Packet format change
`define	CPX_WIDTH_LESS1	145  //CPX payload packet width, BS and SR 11/12/03 N2 Xbar Packet format change
//Outputs 
wire [7:0]     sctag0_cpx_req_cq;   // l2t to processor request // 
wire           sctag0_cpx_atom_cq; // 
wire [`CPX_WIDTH_LESS1:0]  sctag0_cpx_data_ca;  // l2t to cpx data pkt // 
wire           sctag0_pcx_stall_pq; // l2t to pcx IQ_full stall // 
 
//Inputs
wire		pcx_sctag0_data_rdy_px1; // 
wire [`PCX_WIDTH_LESS1:0]  pcx_sctag0_data_px2;   // 
wire		pcx_sctag0_atm_px1; // 
wire	[7:0]	cpx_sctag0_grant_cx; // 

//////////////////////////////////////////////////////////////////////////////
// NCU interface : BS 03/25/04 for partial bank/core modes support
//////////////////////////////////////////////////////////////////////////////

wire           ncu_l2t_pm;   // 0:all 8 banks available, 1:partial mode 
			      //and need to look at each *ba* signals)
wire		ncu_l2t_ba01; // 0:bank0 and bank1 unavailable, 1:both banks available 
wire           ncu_l2t_ba23; // 0:bank2 and bank3 unavailable, 1:both banks available
wire           ncu_l2t_ba45; // 0:bank4 and bank5 unavailable, 1:both banks available
wire           ncu_l2t_ba67; // 0:bank6 and bank7 unavailable, 1:both banks available

wire           ncu_spc0_core_enable_status; // 0 : spc0 unavailable, 1 : available
wire           ncu_spc1_core_enable_status; // 0 : spc1 unavailable, 1 : available
wire           ncu_spc2_core_enable_status; // 0 : spc2 unavailable, 1 : available
wire           ncu_spc3_core_enable_status; // 0 : spc3 unavailable, 1 : available
wire           ncu_spc4_core_enable_status; // 0 : spc4 unavailable, 1 : available
wire           ncu_spc5_core_enable_status; // 0 : spc5 unavailable, 1 : available
wire           ncu_spc6_core_enable_status; // 0 : spc6 unavailable, 1 : available
wire           ncu_spc7_core_enable_status; // 0 : spc7 unavailable, 1 : available

assign           ncu_l2t_pm = 1'b0;    // 0:all 8 banks available, 1:partial mode 
			      //and need to look at each *ba* signals)
assign		ncu_l2t_ba01 = 1'b0;  // 0:bank0 and bank1 unavailable, 1:both banks available 
assign           ncu_l2t_ba23 = 1'b0;  // 0:bank2 and bank3 unavailable, 1:both banks available
assign           ncu_l2t_ba45 = 1'b0;  // 0:bank4 and bank5 unavailable, 1:both banks available
assign           ncu_l2t_ba67 = 1'b0;  // 0:bank6 and bank7 unavailable, 1:both banks available

assign           ncu_spc0_core_enable_status = 1'b0;  // 0 : spc0 unavailable, 1 : available
assign           ncu_spc1_core_enable_status = 1'b0;  // 0 : spc1 unavailable, 1 : available
assign           ncu_spc2_core_enable_status = 1'b0;  // 0 : spc2 unavailable, 1 : available
assign           ncu_spc3_core_enable_status = 1'b0;  // 0 : spc3 unavailable, 1 : available
assign           ncu_spc4_core_enable_status = 1'b0;  // 0 : spc4 unavailable, 1 : available
assign           ncu_spc5_core_enable_status = 1'b0;  // 0 : spc5 unavailable, 1 : available
assign           ncu_spc6_core_enable_status = 1'b0;  // 0 : spc6 unavailable, 1 : available
assign           ncu_spc7_core_enable_status = 1'b0;  // 0 : spc7 unavailable, 1 : available


 
////////////////////////////////////////////////////////////////////////////// 
// Interface with l2d0 
////////////////////////////////////////////////////////////////////////////// 
//Input 
wire [155:0]   l2d0_l2t0_decc_c6;    // From data of l2d_data.v // 

//Output
wire	[15:0]	l2t0_l2d0_way_sel_c2; // 
wire	      	l2t0_l2d0_rd_wr_c2; // 
wire	[8:0]	l2t0_l2d0_set_c2; // 
wire	[3:0]	l2t0_l2d0_col_offset_c2; // 
wire	[15:0]	l2t0_l2d0_word_en_c2; // 
wire          l2t0_l2d0_fbrd_c3;   // From arb of l2t_arb_ctl.sv // 
wire          l2t0_l2d0_fb_hit_c3; // bypass data from Fb  // 


 
////////////////////////////////////////////////////////////////////////////// 
// Interface with l2b0 
////////////////////////////////////////////////////////////////////////////// 

//Shared signals declared for l2b0 
 
////////////////////////////////////////////////////////////////////////////// 
// Interface with the MCU0  
////////////////////////////////////////////////////////////////////////////// 
 
// Outputs 
wire			l2t0_mcu0_rd_req; // 
wire			l2t0_mcu0_rd_dummy_req; // 
wire [2:0]  		l2t0_mcu0_rd_req_id; // 
wire [39:7] 		l2t0_mcu0_addr; // 
wire                  l2t0_mcu0_addr_5;// 
wire        		l2t0_mcu0_wr_req; // 
 
// Inputs
wire         		mcu0_l2t0_rd_ack; // 
wire         		mcu0_l2t0_wr_ack; // 
wire  [1:0]   		mcu0_l2t0_chunk_id_r0; // 
wire         		mcu0_l2t0_data_vld_r0; // 
wire  [2:0]   		mcu0_l2t0_rd_req_id_r0; // 
wire			mcu0_l2t0_secc_err_r2 ; // 
wire			mcu0_l2t0_mecc_err_r2 ; // 
wire			mcu0_l2t0_scb_mecc_err; // 
wire			mcu0_l2t0_scb_secc_err; // 

  
 
////////////////////////////////////////////////////////////////////////////// 
// Snoop / RDMA  interface. 
////////////////////////////////////////////////////////////////////////////// 

//Inputs
wire           	l2t_siu_delay;
wire			sii_l2t_req_vld ;  // 
wire	[31:0]		sii_l2t_req; // 
wire   [6:0]          sii_l2b_ecc; // RAS implementation 10/14/04

assign           	l2t_siu_delay = 'b0;
assign			sii_l2t_req_vld  = 'b0;  // 
assign			sii_l2t_req = 'b0; // 
assign                  sii_l2b_ecc = 'b0; // RAS implementation 10/14/04


//Outputs
wire			l2t_sii_iq_dequeue; // 
wire			l2t_sii_wib_dequeue; // 
 
 
 
////////////////////////////////////////////////////////////////////////////// 
// Global IOs 
////////////////////////////////////////////////////////////////////////////// 

//Declared with l2b0

 
//////////////////////////////////////////////////////////////////////////////
// DEBUG ports
//////////////////////////////////////////////////////////////////////////////

wire		l2t_dbg_sii_iq_dequeue;
wire		l2t_dbg_sii_wib_dequeue;
wire	[5:0] 	l2t_dbg_xbar_vcid;
wire		l2t_dbg_err_event;
wire		l2t_dbg_pa_match; 
 
////////////////////////////////////////////////////////////////////////////// 
// Efuse interface signals 
////////////////////////////////////////////////////////////////////////////// 
wire		efu_l2t_fuse_clr;
wire		efu_l2t_fuse_xfer_en;
wire		efu_l2t_fuse_data;
wire		l2t_efu_fuse_data;
wire		l2t_efu_fuse_xfer_en;
///////////////////////////////////////////////////////////////////////////////// 
// MBIST related pins
//////////////////////////////////////////////////////////////////////////////

wire           tcu_l2t_mbist_start;
wire           tcu_l2t_mbist_scan_in;
wire     	l2t_tcu_mbist_done;
wire     	l2t_tcu_mbist_fail;
wire    	l2t_tcu_mbist_scan_out;


assign		l2t_dbg_sii_iq_dequeue = 1'b0;
assign		l2t_dbg_sii_wib_dequeue = 1'b0;
assign	 	l2t_dbg_xbar_vcid = 6'b000000;
assign		l2t_dbg_err_event = 1'b0;
assign		l2t_dbg_pa_match = 1'b0; 

assign		efu_l2t_fuse_clr = 1'b0;
assign		efu_l2t_fuse_xfer_en = 1'b0;
assign		efu_l2t_fuse_data = 1'b0;
assign		l2t_efu_fuse_data = 1'b0;
assign		l2t_efu_fuse_xfer_en = 1'b0;

assign           tcu_l2t_mbist_start = 1'b0;
assign           tcu_l2t_mbist_scan_in = 1'b0;

assign     	l2t_tcu_mbist_done = 1'b0;
assign     	l2t_tcu_mbist_fail = 1'b0;
assign    	l2t_tcu_mbist_scan_out = 1'b0;



/////////////////////////////////////////////////////////////////////////////////
// Repeaters
/////////////////////////////////////////////////////////////////////////////////

wire vnw_ary0;

wire [23:0] l2t_rep_out0_unused;
wire [23:0] l2t_rep_out1_unused;
wire [23:0] l2t_rep_out2_unused;
wire [23:0] l2t_rep_out3_unused;
wire [23:0] l2t_rep_out4_unused;
wire [23:0] l2t_rep_out5_unused;
wire [23:0] l2t_rep_out6_unused;
wire [23:0] l2t_rep_out7_unused;
wire [23:0] l2t_rep_out8_unused;
wire [23:0] l2t_rep_out9_unused;
wire [23:0] l2t_rep_out10_unused;
wire [23:0] l2t_rep_out11_unused;
wire [23:0] l2t_rep_out12_unused;
wire [23:0] l2t_rep_out13_unused;
wire [23:0] l2t_rep_out14_unused;
wire [23:0] l2t_rep_out15_unused;
wire [23:0] l2t_rep_out16_unused;
wire [23:0] l2t_rep_out17_unused;
wire [23:0] l2t_rep_out18_unused;
wire [23:0] l2t_rep_out19_unused;

wire	[191:0]	l2t_lstg_in;
wire	[191:0]	l2t_rstg_in;
wire	[191:0]	l2t_lstg_out;
wire	[191:0]	l2t_rstg_out;


/////////////////////////////////////////////////////////////////////////////////
// shadow scan 
/////////////////////////////////////////////////////////////////////////////////
wire		tcu_l2t_shscan_scan_in;
wire		tcu_l2t_shscan_aclk;	
wire		tcu_l2t_shscan_bclk;   	
wire		tcu_l2t_shscan_scan_en;
wire		tcu_l2t_shscan_pce_ov;	
wire		tcu_l2t_shscan_clk_stop;
wire		l2t_tcu_shscan_scan_out;

assign		tcu_l2t_shscan_scan_in = 1'b0;
assign		tcu_l2t_shscan_aclk = 1'b0;	
assign		tcu_l2t_shscan_bclk = 1'b0;   	
assign		tcu_l2t_shscan_scan_en = 1'b0;
assign		tcu_l2t_shscan_pce_ov = 1'b0;	
assign		tcu_l2t_shscan_clk_stop = 1'b0;


/////////////////////////////////////////////////////////////////////////////////
// DMO interface changes
/////////////////////////////////////////////////////////////////////////////////
wire	[7:0]	tcu_l2t_coresel;	// 1= select current bank dmo out
wire		tcu_l2t_tag_or_data_sel;// 1= tag read data 0 = data read data
wire	[38:0]	l2t_tcu_dmo_out_prev;	// dmo wire from prev bank
wire	[38:0]	l2t_tcu_dmo_out;	// dmo output from this bank

assign		tcu_l2t_coresel = 'b0;	// 1= select current bank dmo out
assign		tcu_l2t_tag_or_data_sel = 1'b0;// 1= tag read data 0 = data read data
assign		l2t_tcu_dmo_out_prev = 'b0;	// dmo wire from prev bank
assign		l2t_tcu_dmo_out = 'b0;	// dmo output from this bank

//////////////////////////////////////////////////////////////////////////////

wire			      l2t1_mcu0_rd_req_t0lff;
wire			      l2t1_mcu0_rd_dummy_req_t0lff;
wire	[2:0]		      l2t1_mcu0_rd_req_id_t0lff;
wire			      l2t1_mcu0_wr_req_t0lff;
wire			      l2t1_mcu0_addr_5_t0lff;
wire	[ 39 : 0 ]	      l2t1_mcu0_addr_t0lff;


// Outputs 
wire			l2t1_mcu0_rd_req; // 
wire			l2t1_mcu0_rd_dummy_req; // 
wire  [2:0]  		l2t1_mcu0_rd_req_id; // 
wire  [39:0] 		l2t1_mcu0_addr; // 
wire                  l2t1_mcu0_addr_5;// 
wire        		l2t1_mcu0_wr_req; // 



l2t l2t0(
.l2t_lstg_in		    ({
                              148'b0,
			      l2t1_mcu0_rd_req,
			      l2t1_mcu0_rd_dummy_req,
			      l2t1_mcu0_rd_req_id[ 2 : 0 ],
			      l2t1_mcu0_wr_req,
			      l2t1_mcu0_addr_5,
			      l2t1_mcu0_addr[ 39 : 31 ],
			      4'b0,
			      l2t1_mcu0_addr[ 30 : 7 ]}
                            ),
  .l2t_lstg_out		    ({
                              unconnectedt0lff[ 191 : 44 ],
			      l2t1_mcu0_rd_req_t0lff,
			      l2t1_mcu0_rd_dummy_req_t0lff,
			      l2t1_mcu0_rd_req_id_t0lff[ 2 : 0 ],
			      l2t1_mcu0_wr_req_t0lff,
			      l2t1_mcu0_addr_5_t0lff,
			      l2t1_mcu0_addr_t0lff[ 39 : 31 ],
			      unconnectedt0lff[ 27 : 24 ],
			      l2t1_mcu0_addr_t0lff[ 30 : 7 ]}
                            ),
//  .l2t_lstg_in		    (192'b0),
//  .l2t_lstg_out		    (unconnectedt0lff[191:0]),
//  .l2t_rstg_in		    (192'b0),
//  .l2t_rstg_out		    (unconnectedt0rff[191:0]),
  .l2t_rstg_in       	    ({111'b0,
                             l2b0_sio_parity[ 1 : 0 ],
                             79'b0
                             }
                            ),
  .l2t_rstg_out		    ({unconnectedt0rff[ 191 : 81 ],
                             2'b0,
                             unconnectedt0rff[ 78 : 0 ]
                             }
                            ),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (39'b0                       ), 
  .l2t_tcu_dmo_out          (l2t_tcu_dmo_out[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (1'b0                        ),
  .tcu_l2t_tag_or_data_sel  (1'b0             ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3t ),
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3t ),
  .l2t_dbg_sii_iq_dequeue   (l2t_dbg_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t_dbg_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t_dbg_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t_dbg_err_event		 ),
  .l2t_dbg_pa_match	    (l2t_dbg_pa_match		 ),
  .l2t_cpx_req_cq           (sctag0_cpx_req_cq[ 7 : 0 ]      ),// sctag
  .l2t_cpx_atom_cq          (sctag0_cpx_atom_cq          ),
  .l2t_cpx_data_ca          (sctag0_cpx_data_ca[ 145 : 0 ]),
  .l2t_pcx_stall_pq         (sctag0_pcx_stall_pq         ),
  .pcx_l2t_data_rdy_px1     (pcx_sctag0_data_rdy_px1     ),
  .pcx_l2t_data_px2         (pcx_sctag0_data_px2[ 129 : 0 ]),
  .pcx_l2t_atm_px1          (pcx_sctag0_atm_px1          ),
  .cpx_l2t_grant_cx         (cpx_sctag0_grant_cx[ 7 : 0 ]    ),
  .l2t_rst_fatal_error      (l2t0_rst_fatal_error        ),
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_way_sel_c2       (l2t0_l2d0_way_sel_c2        ),
  .l2t_l2d_rd_wr_c2         (l2t0_l2d0_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t0_l2d0_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_col_offset_c2    (l2t0_l2d0_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_word_en_c2       (l2t0_l2d0_word_en_c2        ),
  .l2t_l2d_fbrd_c3          (l2t0_l2d0_fbrd_c3           ),
  .l2t_l2d_fb_hit_c3        (l2t0_l2d0_fb_hit_c3         ),
  .l2t_l2d_stdecc_c2        (l2t0_l2d0_stdecc_c2[ 77 : 0 ]         ),
  .l2d_l2t_decc_c6          (l2d0_l2t0_decc_c6           ),
//  .l2t_l2b_stdecc_c3        (l2t0_l2b0_stdecc_c3[77:0]   ),
  .l2t_l2b_fbrd_en_c3       (l2t0_l2b0_fbrd_en_c3        ),
  .l2t_l2b_fbrd_wl_c3       (l2t0_l2b0_fbrd_wl_c3[ 2 : 0 ]   ),
  .l2t_l2b_fbwr_wen_r2      (l2t0_l2b0_fbwr_wen_r2[ 15 : 0 ] ),
  .l2t_l2b_fbwr_wl_r2       (l2t0_l2b0_fbwr_wl_r2[ 2 : 0 ]   ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t0_l2b0_fbd_stdatasel_c3  ),
  .l2t_l2b_wbwr_wen_c6      (l2t0_l2b0_wbwr_wen_c6[ 3 : 0 ]  ),
  .l2t_l2b_wbwr_wl_c6       (l2t0_l2b0_wbwr_wl_c6[ 2 : 0 ]   ),
  .l2t_l2b_wbrd_en_r0       (l2t0_l2b0_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t0_l2b0_wbrd_wl_r0[ 2 : 0 ]   ),
  .l2t_l2b_ev_dword_r0      (l2t0_l2b0_ev_dword_r0[ 2 : 0 ]  ),
  .l2t_l2b_evict_en_r0      (l2t0_l2b0_evict_en_r0       ),
  .l2b_l2t_ev_uerr_r5       (l2b0_l2t0_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b0_l2t0_ev_cerr_r5        ),
  .l2t_l2b_rdma_wren_s2     (l2t0_l2b0_rdma_wren_s2[ 15 : 0 ]),
  .l2t_l2b_rdma_wrwl_s2     (l2t0_l2b0_rdma_wrwl_s2[ 1 : 0 ] ),
  .l2t_l2b_rdma_rdwl_r0     (l2t0_l2b0_rdma_rdwl_r0[ 1 : 0 ] ),
  .l2t_l2b_rdma_rden_r0     (l2t0_l2b0_rdma_rden_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t0_l2b0_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t0_l2b0_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_word_c7          (l2t0_l2b0_word_c7[ 3 : 0 ]      ),
  .l2t_l2b_req_en_c7        (l2t0_l2b0_req_en_c7         ),
  .l2t_l2b_word_vld_c7      (l2t0_l2b0_word_vld_c7       ),
  .l2b_l2t_rdma_uerr_c10    (l2b0_l2t0_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b0_l2t0_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b0_l2t0_rdma_notdata_c10  ),
  .l2t_mcu_rd_req           (l2t0_mcu0_rd_req            ),
  .l2t_mcu_rd_dummy_req     (l2t0_mcu0_rd_dummy_req      ),
  .l2t_mcu_rd_req_id        (l2t0_mcu0_rd_req_id[ 2 : 0 ]    ),
  .l2t_mcu_addr             (l2t0_mcu0_addr[ 39 : 7 ]        ),
  .l2t_mcu_addr_5           (l2t0_mcu0_addr_5            ),
  .l2t_mcu_wr_req           (l2t0_mcu0_wr_req            ),
  .mcu_l2t_rd_ack           (mcu0_l2t0_rd_ack            ),
  .mcu_l2t_wr_ack           (mcu0_l2t0_wr_ack            ),
  .mcu_l2t_chunk_id_r0      (mcu0_l2t0_chunk_id_r0[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu0_l2t0_data_vld_r0       ),
  .mcu_l2t_rd_req_id_r0     (mcu0_l2t0_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu0_l2t0_secc_err_r2       ),
  .mcu_l2t_mecc_err_r2      (mcu0_l2t0_mecc_err_r2       ),
  .mcu_l2t_scb_mecc_err     (mcu0_l2t0_scb_mecc_err      ),
  .mcu_l2t_scb_secc_err     (mcu0_l2t0_scb_secc_err      ),
  .sii_l2t_req_vld          (sii_l2t_req_vld            ),
  .sii_l2t_req              (sii_l2t_req[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b_ecc[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t_sii_wib_dequeue        ),
  .rst_por_                 ( rst_por ), 
  .rst_wmr_                 ( rst_wmr ), 
  .scan_in                  (scan_out           ),
  .scan_out                 (scan_out               ),
  .efu_l2t_fuse_clr          (efu_l2t_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t_fuse_data      ),                       
  .l2t_efu_fuse_data         (l2t_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t_efu_fuse_xfer_en      ),                       
  .tcu_mbist_bisi_en              (tcu_mbist_bisi_en),
  .tcu_l2t_mbist_start            (tcu_l2t_mbist_start_t1lff),
  .tcu_l2t_mbist_scan_in          (tcu_l2t_mbist_scan_in),
  .l2t_tcu_mbist_done             (l2t_tcu_mbist_done),
  .l2t_tcu_mbist_fail             (l2t_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out         (l2t_tcu_mbist_scan_out),
  .gclk                      	  ( gclk ), // cmp_gclk_c1_r[2]            ), 
  .tcu_clk_stop ( gl_l2t0_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t0_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t_shscan_clk_stop),
  .vnw_ary                            (vnw_ary0),
  .l2t_rep_in0                        (24'b0),
  .l2t_rep_in1                        (24'b0),
  .l2t_rep_in2                        (24'b0),
  .l2t_rep_in3                        (24'b0),
  .l2t_rep_in4                        (24'b0),
  .l2t_rep_in5                        (24'b0),
  .l2t_rep_in6                        (24'b0),
  .l2t_rep_in7                        (24'b0),
  .l2t_rep_in8                        (24'b0),
  .l2t_rep_in9                        (24'b0),
  .l2t_rep_in10                       (24'b0),
  .l2t_rep_in11                       (24'b0),
  .l2t_rep_in12                       (24'b0),
  .l2t_rep_in13                       (24'b0),
  .l2t_rep_in14                       (24'b0),
  .l2t_rep_in15                       (24'b0),
  .l2t_rep_in16                       (24'b0),
  .l2t_rep_in17                       (24'b0),
  .l2t_rep_in18                       (24'b0),
  .l2t_rep_in19                       (24'b0),
  .l2t_rep_out0                       (l2t_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t_rep_out19_unused[ 23 : 0 ]),
  .ncu_l2t_pm(ncu_l2t_pm),
  .ncu_l2t_ba01(ncu_l2t_ba01),
  .ncu_l2t_ba23(ncu_l2t_ba23),
  .ncu_l2t_ba45(ncu_l2t_ba45),
  .ncu_l2t_ba67(ncu_l2t_ba67),
  .ncu_spc0_core_enable_status(ncu_spc0_core_enable_status),
  .ncu_spc1_core_enable_status(ncu_spc1_core_enable_status),
  .ncu_spc2_core_enable_status(ncu_spc2_core_enable_status),
  .ncu_spc3_core_enable_status(ncu_spc3_core_enable_status),
  .ncu_spc4_core_enable_status(ncu_spc4_core_enable_status),
  .ncu_spc5_core_enable_status(ncu_spc5_core_enable_status),
  .ncu_spc6_core_enable_status(ncu_spc6_core_enable_status),
  .ncu_spc7_core_enable_status(ncu_spc7_core_enable_status),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_scan_en(tcu_scan_en),
  .tcu_muxtest(tcu_muxtest),
  .tcu_dectest(tcu_dectest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .tcu_se_scancollar_in(tcu_se_scancollar_in),
  .tcu_se_scancollar_out(tcu_se_scancollar_out),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .tcu_array_bypass(tcu_array_bypass),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_user_mode(tcu_mbist_user_mode)
        );
//________________________________________________________________

/////// stagging flop

////////////////////////////////////////////////////////////////////////////// 
// l2t1 CCX interface 
////////////////////////////////////////////////////////////////////////////// 

//Outputs 
wire [7:0]     sctag1_cpx_req_cq;   // l2t to processor request // 
wire           sctag1_cpx_atom_cq; // 
wire [`CPX_WIDTH_LESS1:0]  sctag1_cpx_data_ca;  // l2t to cpx data pkt // 
wire           sctag1_pcx_stall_pq; // l2t to pcx IQ_full stall // 
 
//Inputs
wire		pcx_sctag1_data_rdy_px1; // 
wire [`PCX_WIDTH_LESS1:0]  pcx_sctag1_data_px2;   // 
wire		pcx_sctag1_atm_px1; // 
wire	[7:0]	cpx_sctag1_grant_cx; // 

////////////////////////////////////////////////////////////////////////////// 
// Interface with l2d1 
////////////////////////////////////////////////////////////////////////////// 
//Input 
wire [155:0]   l2d1_l2t1_decc_c6;    // From data of l2d_data.v //
 
//Output
wire	[15:0]	l2t1_l2d1_way_sel_c2; // 
wire	      	l2t1_l2d1_rd_wr_c2; // 
wire	[8:0]	l2t1_l2d1_set_c2; // 
wire	[3:0]	l2t1_l2d1_col_offset_c2; // 
wire	[15:0]	l2t1_l2d1_word_en_c2; // 
wire          l2t1_l2d1_fbrd_c3;   // From arb of l2t_arb_ctl.sv // 
wire          l2t1_l2d1_fb_hit_c3; // bypass data from Fb  // 

 
////////////////////////////////////////////////////////////////////////////// 
// Interface with l2b1 
////////////////////////////////////////////////////////////////////////////// 

//Shared signals declared for l2b1 
 
////////////////////////////////////////////////////////////////////////////// 
// Interface with the MCU1  
////////////////////////////////////////////////////////////////////////////// 
 
 
// Inputs
wire         		mcu0_l2t1_rd_ack; // 
wire         		mcu0_l2t1_wr_ack; // 
wire  [1:0]   		mcu0_l2t1_chunk_id_r0; // 
wire         		mcu0_l2t1_data_vld_r0; // 
wire  [2:0]   		mcu0_l2t1_rd_req_id_r0; // 
wire			mcu0_l2t1_secc_err_r2 ; // 
wire			mcu0_l2t1_mecc_err_r2 ; // 
wire			mcu0_l2t1_scb_mecc_err; // 
wire			mcu0_l2t1_scb_secc_err; // 



//assign

l2t l2t1(
  .l2t_lstg_in		    (
                             {5'b0,
                              2'b00,
                              59'b0,
                              52'b0,
			      11'b0,
			      63'b0}
                            ),
  .l2t_rstg_in		    (
                             {77'b0,
                              34'b0,
			      25'b0,
			      56'b0}
                            ),
  .l2t_lstg_out		    (
                             {unconnectedt1lff[ 191 : 186 ],
                              1'b0,
                              unconnectedt1lff[  184  :  126  ],
                              4'b0,
                              unconnectedt1lff[  121  :  74  ],
			      3'b0,
                              unconnectedt1lff[ 70 : 65 ],
                              2'b0,
                              unconnectedt1lff[ 62 : 0 ]
                             }
                            ),
  .l2t_rstg_out		   (
                            {unconnectedt1rff[ 191 : 115 ],
			     3'b0,
			     unconnectedt1rff[ 80 : 56 ],
                             12'b0,
			     unconnectedt1rff[ 43 : 0 ]}
                           ),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (39'b0                       ), 
  .l2t_tcu_dmo_out          (l2t_tcu_dmo_out[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (1'b0                        ),
  .tcu_l2t_tag_or_data_sel  (1'b0               ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3t ),
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3t ),
  .l2t_dbg_sii_iq_dequeue   (l2t_dbg_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t_dbg_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t_dbg_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t_dbg_err_event		 ),
  .l2t_dbg_pa_match	    (l2t_dbg_pa_match		 ),
  .l2t_cpx_req_cq           (sctag1_cpx_req_cq[ 7 : 0 ]      ),// sctag
  .l2t_cpx_atom_cq          (sctag1_cpx_atom_cq          ),
  .l2t_cpx_data_ca          (sctag1_cpx_data_ca[ 145 : 0 ]),
  .l2t_pcx_stall_pq         (sctag1_pcx_stall_pq         ),
  .pcx_l2t_data_rdy_px1     (pcx_sctag1_data_rdy_px1     ),
  .pcx_l2t_data_px2         (pcx_sctag1_data_px2[ 129 : 0 ]),
  .pcx_l2t_atm_px1          (pcx_sctag1_atm_px1          ),
  .cpx_l2t_grant_cx         (cpx_sctag1_grant_cx[ 7 : 0 ]    ),
  .l2t_rst_fatal_error      (l2t1_rst_fatal_error),
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_way_sel_c2       (l2t1_l2d1_way_sel_c2        ),
  .l2t_l2d_rd_wr_c2         (l2t1_l2d1_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t1_l2d1_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_col_offset_c2    (l2t1_l2d1_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_word_en_c2       (l2t1_l2d1_word_en_c2        ),
  .l2t_l2d_fbrd_c3          (l2t1_l2d1_fbrd_c3           ),
  .l2t_l2d_fb_hit_c3        (l2t1_l2d1_fb_hit_c3         ),
  .l2t_l2d_stdecc_c2        (l2t1_l2d1_stdecc_c2[ 77 : 0 ]         ),
  .l2d_l2t_decc_c6          (l2d1_l2t1_decc_c6           ),
 // .l2t_l2b_stdecc_c3        (l2t1_l2b1_stdecc_c3[77:0]   ),
  .l2t_l2b_fbrd_en_c3       (l2t1_l2b1_fbrd_en_c3        ),
  .l2t_l2b_fbrd_wl_c3       (l2t1_l2b1_fbrd_wl_c3[ 2 : 0 ]   ),
  .l2t_l2b_fbwr_wen_r2      (l2t1_l2b1_fbwr_wen_r2[ 15 : 0 ] ),
  .l2t_l2b_fbwr_wl_r2       (l2t1_l2b1_fbwr_wl_r2[ 2 : 0 ]   ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t1_l2b1_fbd_stdatasel_c3  ),
  .l2t_l2b_wbwr_wen_c6      (l2t1_l2b1_wbwr_wen_c6[ 3 : 0 ]  ),
  .l2t_l2b_wbwr_wl_c6       (l2t1_l2b1_wbwr_wl_c6[ 2 : 0 ]   ),
  .l2t_l2b_wbrd_en_r0       (l2t1_l2b1_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t1_l2b1_wbrd_wl_r0[ 2 : 0 ]   ),
  .l2t_l2b_ev_dword_r0      (l2t1_l2b1_ev_dword_r0[ 2 : 0 ]  ),
  .l2t_l2b_evict_en_r0      (l2t1_l2b1_evict_en_r0       ),
  .l2b_l2t_ev_uerr_r5       (l2b1_l2t1_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b1_l2t1_ev_cerr_r5        ),
  .l2t_l2b_rdma_wren_s2     (l2t1_l2b1_rdma_wren_s2[ 15 : 0 ]),
  .l2t_l2b_rdma_wrwl_s2     (l2t1_l2b1_rdma_wrwl_s2[ 1 : 0 ] ),
  .l2t_l2b_rdma_rdwl_r0     (l2t1_l2b1_rdma_rdwl_r0[ 1 : 0 ] ),
  .l2t_l2b_rdma_rden_r0     (l2t1_l2b1_rdma_rden_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t1_l2b1_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t1_l2b1_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_word_c7          (l2t1_l2b1_word_c7[ 3 : 0 ]      ),
  .l2t_l2b_req_en_c7        (l2t1_l2b1_req_en_c7         ),
  .l2t_l2b_word_vld_c7      (l2t1_l2b1_word_vld_c7       ),
  .l2b_l2t_rdma_uerr_c10    (l2b1_l2t1_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b1_l2t1_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b1_l2t1_rdma_notdata_c10  ),
  .l2t_mcu_rd_req           (l2t1_mcu0_rd_req            ),
  .l2t_mcu_rd_dummy_req     (l2t1_mcu0_rd_dummy_req      ),
  .l2t_mcu_rd_req_id        (l2t1_mcu0_rd_req_id[ 2 : 0 ]    ),
  .l2t_mcu_addr             (l2t1_mcu0_addr[ 39 : 7 ]        ),
  .l2t_mcu_addr_5           (l2t1_mcu0_addr_5            ),
  .l2t_mcu_wr_req           (l2t1_mcu0_wr_req            ),
  .mcu_l2t_rd_ack           (mcu0_l2t1_rd_ack            ),
  .mcu_l2t_wr_ack           (mcu0_l2t1_wr_ack            ),
  .mcu_l2t_chunk_id_r0      (mcu0_l2t1_chunk_id_r0[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu0_l2t1_data_vld_r0       ),
  .mcu_l2t_rd_req_id_r0     (mcu0_l2t1_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu0_l2t1_secc_err_r2       ),
  .mcu_l2t_mecc_err_r2      (mcu0_l2t1_mecc_err_r2       ),
  .mcu_l2t_scb_mecc_err     (mcu0_l2t1_scb_mecc_err      ),
  .mcu_l2t_scb_secc_err     (mcu0_l2t1_scb_secc_err      ),
  .sii_l2t_req_vld          (sii_l2t_req_vld            ),
  .sii_l2t_req              (sii_l2t_req[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b_ecc[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t_sii_wib_dequeue        ),
  .rst_por_                 ( rst_por ), 
  .rst_wmr_                 ( rst_wmr ), 
  .scan_in                  (scan_out           ),
  .scan_out                 (scan_out               ),
  .efu_l2t_fuse_clr          (efu_l2t_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t_fuse_data      ),                       
  .l2t_efu_fuse_data         (l2t_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t_efu_fuse_xfer_en      ),                       
  .tcu_mbist_bisi_en              (tcu_mbist_bisi_en),
  .tcu_l2t_mbist_start            (tcu_l2t_mbist_start_t1lff),
  .tcu_l2t_mbist_scan_in          (tcu_l2t_mbist_scan_in),
  .l2t_tcu_mbist_done             (l2t_tcu_mbist_done),
  .l2t_tcu_mbist_fail             (l2t_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out         (l2t_tcu_mbist_scan_out),
  .gclk                      	  ( gclk ), // cmp_gclk_c1_r[2]            ), 
  .tcu_clk_stop ( gl_l2t0_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t0_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t_shscan_clk_stop),
  .vnw_ary                            (vnw_ary0),
  .l2t_rep_in0                        (24'b0),
  .l2t_rep_in1                        (24'b0),
  .l2t_rep_in2                        (24'b0),
  .l2t_rep_in3                        (24'b0),
  .l2t_rep_in4                        (24'b0),
  .l2t_rep_in5                        (24'b0),
  .l2t_rep_in6                        (24'b0),
  .l2t_rep_in7                        (24'b0),
  .l2t_rep_in8                        (24'b0),
  .l2t_rep_in9                        (24'b0),
  .l2t_rep_in10                       (24'b0),
  .l2t_rep_in11                       (24'b0),
  .l2t_rep_in12                       (24'b0),
  .l2t_rep_in13                       (24'b0),
  .l2t_rep_in14                       (24'b0),
  .l2t_rep_in15                       (24'b0),
  .l2t_rep_in16                       (24'b0),
  .l2t_rep_in17                       (24'b0),
  .l2t_rep_in18                       (24'b0),
  .l2t_rep_in19                       (24'b0),
  .l2t_rep_out0                       (l2t_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t_rep_out19_unused[ 23 : 0 ]),
  .ncu_l2t_pm(ncu_l2t_pm),
  .ncu_l2t_ba01(ncu_l2t_ba01),
  .ncu_l2t_ba23(ncu_l2t_ba23),
  .ncu_l2t_ba45(ncu_l2t_ba45),
  .ncu_l2t_ba67(ncu_l2t_ba67),
  .ncu_spc0_core_enable_status(ncu_spc0_core_enable_status),
  .ncu_spc1_core_enable_status(ncu_spc1_core_enable_status),
  .ncu_spc2_core_enable_status(ncu_spc2_core_enable_status),
  .ncu_spc3_core_enable_status(ncu_spc3_core_enable_status),
  .ncu_spc4_core_enable_status(ncu_spc4_core_enable_status),
  .ncu_spc5_core_enable_status(ncu_spc5_core_enable_status),
  .ncu_spc6_core_enable_status(ncu_spc6_core_enable_status),
  .ncu_spc7_core_enable_status(ncu_spc7_core_enable_status),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_scan_en(tcu_scan_en),
  .tcu_muxtest(tcu_muxtest),
  .tcu_dectest(tcu_dectest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .tcu_se_scancollar_in(tcu_se_scancollar_in),
  .tcu_se_scancollar_out(tcu_se_scancollar_out),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .tcu_array_bypass(tcu_array_bypass),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_user_mode(tcu_mbist_user_mode)
        );
//________________________________________________________________






   reg [3:0]                clk_cntr;

   always @ (posedge gclk) begin : gl_io_cmp_sync_gen
      if (rst) begin
         clk_cntr <= 4'b0000;
      end else begin
         clk_cntr <= clk_cntr + 1;
      end   
   end
   
   // gl_cmp_io_sync_en_c3t0 generator   
   assign gl_io_cmp_sync_en_c3t0 = (clk_cntr == 4'b0000) ? 1'b1 : 1'b0;
   // gl_io_cmp_sync_en_c3t0 generator
   assign gl_cmp_io_sync_en_c3t0 = (clk_cntr == 4'b0010) ? 1'b1 : 1'b0;
   
endmodule // spc_wrapper
