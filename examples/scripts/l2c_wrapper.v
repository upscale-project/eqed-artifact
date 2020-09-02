// gclk 50-50
module l2c_wrapper (/*AUTOARG*/
   // Outputs
   );
   //                                                       I/O     constraint

//////////////////////////////////////////////////////////////////////////////
// Interface with l2t
//////////////////////////////////////////////////////////////////////////////

wire           l2t0_l2b0_fbrd_en_c3;   	// PINDEF:RIGHT // rd en for a fill operation or fb bypass
wire   [2:0]   l2t0_l2b0_fbrd_wl_c3 ;  	// PINDEF:RIGHT // read entry
wire   [15:0]  l2t0_l2b0_fbwr_wen_r2 ; 	// PINDEF:RIGHT // mcu Fill or store in OFF mode.
wire   [2:0]   l2t0_l2b0_fbwr_wl_r2 ;  	// PINDEF:RIGHT // mcu Fill entry.
wire           l2t0_l2b0_fbd_stdatasel_c3; // PINDEF:RIGHT 	// select store data in OFF mode
wire   [77:0]  l2t0_l2b0_stdecc_c2;    	// PINDEF:BOT // store data goes to l2b and l2d0
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
// Interface with l2d0
//////////////////////////////////////////////////////////////////////////////
wire   [623:0]  l2d0_l2b0_decc_out_c7;  // PINDEF:TOP

//// Outputs

wire  [623:0]  l2b0_l2d0_fbdecc_c4;	// PINDEF:TOP 
//////////////////////////////////////////////////////////////////////////////
// Interface with the DRAM
//////////////////////////////////////////////////////////////////////////////

wire   [127:0]  mcu_l2b01_data_r2;	// PINDEF:BOT
wire   [27:0]   mcu_l2b01_ecc_r2;	// PINDEF:BOT
wire		select_delay_mcu;

//// Outputs

wire           l2b0_evict_l2b_mcu_data_mecc_r5;	// PINDEF:BOT
wire  [63:0]   evict_l2b0_mcu_wr_data_r5;	// PINDEF:BOT
wire           evict_l2b0_mcu_data_vld_r5;	// PINDEF:BOT
//////////////////////////////////////////////////////////////////////////////
// Global Signals
//////////////////////////////////////////////////////////////////////////////

wire		 gclk;
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


wire            tcu_se_scancollar_in;
wire            tcu_se_scancollar_out;
wire            tcu_array_wr_inhibit;
wire            tcu_atpg_mode;
wire            tcu_array_bypass;
wire		 cluster_arst_l;


wire           scan_out;		

// Mbist pins
wire 		tcu_mbist_bisi_en;
wire 		tcu_l2b0_mbist_start;
wire 		tcu_l2b0_mbist_scan_in;
wire 		tcu_mbist_user_mode;

///// Outputs

wire		l2b0_tcu_mbist_done;
wire		l2b0_tcu_mbist_fail;
wire		l2b0_tcu_mbist_scan_out;

// Debug ports
wire		l2b0_dbg0_sio_ctag_vld;
wire		l2b0_dbg0_sio_ack_type;
wire		l2b0_dbg0_sio_ack_dest;
//////////////////////////////////////////////////////////////////////////////
// Efuse related ports
//////////////////////////////////////////////////////////////////////////////
// to l2d0 fuse related ports
wire	[9:0]	l2b0_l2d0_rvalue;
wire	[6:0]	l2b0_l2d0_rid;
wire		l2b0_l2d0_wr_en;
wire		l2b0_l2d0_fuse_clr;

// from l2d0 fuse related ports
wire	[9:0]	l2d0_l2b0_fuse_read_data;

// efu to l2b0
wire		efu_l2b0_fuse_data;
wire		efu_l2b0_fuse_xfer_en;
wire		efu_l2b0_fuse_clr;


// l2b0 to efu
wire		l2b0_efu_fuse_xfer_en;
wire		l2b0_efu_fuse_data;

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
  .l2b_l2d_rvalue          (l2b0_l2d0_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b0_l2d0_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b0_l2d0_wr_en),
  .l2b_l2d_fuse_clr        (l2b0_l2d0_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d0_l2b0_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b0246_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b0_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b0_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b0_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b0_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b0_dbg0_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b0_dbg0_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b0_dbg0_sio_ack_dest	 ),
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
  .mcu_l2b_data_r2          (mcu0_l2b01_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu0_l2b01_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b0_mbist_start_ccxlff        ),
  .l2b_tcu_mbist_done       (l2b0_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b0_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b0_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b0_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b0_mcu0_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b0_mcu0_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b0_mcu0_data_vld_r5       ),
  .scan_in                  (tcu_soch_scan_out           ),
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
