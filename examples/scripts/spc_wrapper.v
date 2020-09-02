// gclk 50-50
module spc_wrapper (/*AUTOARG*/
   // Outputs
   scan_out, spc_tcu_shscan_scan_out, spc_tcu_mbist_fail,
   spc_tcu_mbist_done, spc_tcu_mbist_scan_out, spc_ss_complete,
   spc_hardstop_request, spc_softstop_request, spc_trigger_pulse,
   spc_efu_fuse_dxfer_en, spc_efu_fuse_ixfer_en, spc_efu_fuse_ddata,
   spc_efu_fuse_idata, spc_tcu_lbist_done, spc_tcu_lbist_scan_out,
   spc_dmo_dout, spc_pcx_req_pq, spc_pcx_atm_pq, spc_pcx_data_pa,
   spc_core_running_status, spc_dbg_instr_cmt_grp0,
   spc_dbg_instr_cmt_grp1,
   // Inputs
   rst, gclk, cluster_arst_l, cpx_spc_data_cx, pcx_spc_grant_px
   );
   //                                                       I/O     constraint
   input                  rst;
   
   input                  gclk;                         // input   clk  .gclk

   // scan signals
   wire [1:0]              scan_in;                      // input   0             .scan_in   
   wire                    tcu_pce_ov;                   // input   0             .tcu_pce_ov
   wire                    tcu_clk_stop;                 // input   X->0 @500     .tcu_clk_stop
   wire                    tcu_spc_aclk;                 // input   0             .tcu_aclk
   wire                    tcu_spc_bclk;                 // input   0             .tcu_bclk
   wire                    tcu_dectest;                  // input   1             .tcu_dectest
   wire                    tcu_muxtest;                  // input   1             .tcu_muxtest
   wire                    tcu_spc_scan_en;              // input   0             .tcu_scan_en
   wire                    tcu_spc_array_wr_inhibit;     // input   0             .tcu_array_wr_inhibit
   wire                    tcu_spc_se_scancollar_in;     // input   0             .tcu_se_scancollar_in
   wire                    tcu_spc_se_scancollar_out;    // input   0             .tcu_se_scancollar_out
   wire                    tcu_atpg_mode;                // input   0             .tcu_atpg_mode
   wire                    rst_wmr_protect;              // input   0             .rst_wmr_protect // scan related
   output [1:0]            scan_out;                     // output                .scan_out   

   assign scan_in      = 1'b0;             
   assign tcu_pce_ov   = 1'b0;    // X->0 @500         
   assign tcu_clk_stop = 1'b0;    
   assign tcu_spc_aclk = 1'b0;             
   assign tcu_spc_bclk = 1'b0;             
   assign tcu_dectest = 1'b1;              
   assign tcu_muxtest = 1'b1;              
   assign tcu_spc_scan_en = 1'b0;          
   assign tcu_spc_array_wr_inhibit = 1'b0; 
   assign tcu_spc_se_scancollar_in = 1'b0; 
   assign tcu_spc_se_scancollar_out = 1'b0;
   assign tcu_atpg_mode = 1'b0;            
   assign rst_wmr_protect = 1'b0;          
   
   // shadow scan signals
   wire                    tcu_spc_shscan_pce_ov;        // input   0     .tcu_spc_shscan_pce_ov
   wire                    tcu_spc_shscan_clk_stop;      // input   0     .tcu_spc_shscan_clk_stop
   wire                    tcu_spc_shscan_aclk;          // input   0     .tcu_spc_shscan_aclk
   wire                    tcu_spc_shscan_bclk;          // input   0     .tcu_spc_shscan_bclk
   wire                    tcu_spc_shscan_scan_in;       // input   0     .tcu_shscan_scan_in
   wire                    tcu_spc_shscan_scan_en;       // input   0     .tcu_spc_shscan_en
   wire [2:0]              tcu_spc_shscanid;             // input   3'h0  .tcu_shscanid
   output                  spc_tcu_shscan_scan_out;      // output  0     .spc_shscan_scan_out

   assign tcu_spc_shscan_pce_ov   = 1'b0; 
   assign tcu_spc_shscan_clk_stop = 1'b0;
   assign tcu_spc_shscan_aclk     = 1'b0;
   assign tcu_spc_shscan_bclk     = 1'b0;
   assign tcu_spc_shscan_scan_in  = 1'b0;
   assign tcu_spc_shscan_scan_en  = 1'b0;
   assign tcu_spc_shscanid        = 3'b000;
   
   // from RST
   input                   cluster_arst_l;               // input   1     .cluster_arst_l 

   // MBIST signals
   wire                    tcu_spc_mbist_scan_in;        // input   0     .tcu_spc_mbist_scan_in
   wire                    tcu_mbist_bisi_en;            // input   0     .tcu_mbist_bisi_en
   wire                    tcu_spc_mbist_start;          // input   0     .tcu_spc_mbist_start
   wire                    tcu_mbist_user_mode;          // input   0     .tcu_mbist_user_mode
   output                  spc_tcu_mbist_fail;           // output        .spc_mbist_fail   
   output                  spc_tcu_mbist_done;           // output        .spc_mbist_done
   output                  spc_tcu_mbist_scan_out;       // output       .spc_tcu_mbist_scan_out

   assign tcu_spc_mbist_scan_in = 1'b0;
   assign tcu_mbist_bisi_en     = 1'b0;    
   assign tcu_spc_mbist_start   = 1'b0;  
   assign tcu_mbist_user_mode   = 1'b0;  
   
   // CPUID
   wire [2:0]              const_cpuid;                  // input   3'b000           .const_cpuid

   assign const_cpuid = 3'b000;
   
   // Core enable signals from CMP
   wire                    tcu_ss_mode;                  // input   0    .tcu_ss_mode
   wire                    tcu_do_mode;                  // input   0    .tcu_do_mode
   wire                    tcu_ss_request;               // input   0    .tcu_ss_request
   wire                    ncu_cmp_tick_enable;          // input   1     .ncu_cmp_tick_enable   
   output                  spc_ss_complete;              // output       .spc_ss_complete

   assign tcu_ss_mode = 1'b0;        
   assign tcu_do_mode = 1'b0;        
   assign tcu_ss_request = 1'b0;     
   assign ncu_cmp_tick_enable = 1'b1;
   
   // RSTVADDR (POR address) control
   wire                    ncu_wmr_vec_mask;             // input   0     .ncu_wmr_vec_mask   

   assign ncu_wmr_vec_mask = 1'b0;
   
   // Debug signals
   output                  spc_hardstop_request;         // output       .spc_hardstop_request
   output                  spc_softstop_request;         // output       .spc_softstop_request
   output                  spc_trigger_pulse;            // output       .spc_trigger_pulse

   // partial core signals
   wire                    ncu_spc_pm;                   // input   0     .ncu_spc_pm
   wire                    ncu_spc_ba01;                 // input   1     .ncu_spc_ba01
   wire                    ncu_spc_ba23;                 // input   1     .ncu_spc_ba23
   wire                    ncu_spc_ba45;                 // input   1     .ncu_spc_ba45
   wire                    ncu_spc_ba67;                 // input   1     .ncu_spc_ba67

   assign ncu_spc_pm   = 1'b0;
   assign ncu_spc_ba01 = 1'b1;
   assign ncu_spc_ba23 = 1'b1;
   assign ncu_spc_ba45 = 1'b1;
   assign ncu_spc_ba67 = 1'b1;

   // EFUSE interface
   wire                    efu_spc_fuse_data;            // input   HiZ   .efu_spc_fuse_data
   wire                    efu_spc_fuse_ixfer_en;        // input   0     .efu_spc_fuse_ixfer_en
   wire                    efu_spc_fuse_iclr;            // input   0     .efu_spc_fuse_iclr
   wire                    efu_spc_fuse_dxfer_en;        // input   0     .efu_spc_fuse_dxfer_en
   wire                    efu_spc_fuse_dclr;            // input   0     .efu_spc_fuse_dclr
   output                  spc_efu_fuse_dxfer_en;        // output  0     .spc_efu_fuse_dxfer
   output                  spc_efu_fuse_ixfer_en;        // output  0     .spc_efu_fuse_ixfer
   output                  spc_efu_fuse_ddata;           // output  0     .spc_efu_fuse_ddata
   output                  spc_efu_fuse_idata;           // output  0     .spc_efu_fuse_idata

   assign efu_spc_fuse_data     = 1'b0;
   assign efu_spc_fuse_ixfer_en = 1'b0;
   assign efu_spc_fuse_iclr     = 1'b0;
   assign efu_spc_fuse_dxfer_en = 1'b0;
   assign efu_spc_fuse_dclr     = 1'b0;

   
   // VNW inputs
   wire                     vnw_ary0;                     // input   1'b1  .vnw_ary0
   wire                     vnw_ary1;                     // input   1'b1  .vnw_ary1

   assign vnw_ary0 = 1'b0;
   assign vnw_ary1 = 1'b0;

   // Logic BIST signals
   wire                     tcu_spc_lbist_start;          // input   0     .tcu_spc_lbist_start
   wire                     tcu_spc_lbist_scan_in;        // input   0     .tcu_spc_lbist_scan_in
   wire                     tcu_spc_lbist_pgm;            // input   0     .tcu_spc_lbist_pgm
   wire                     tcu_spc_test_mode;            // input   HiZ   .tcu_spc_test_mode
   output                   spc_tcu_lbist_done;           // output        .spc_tcu_lbist_done
   output                   spc_tcu_lbist_scan_out;       // output        .spc_tcu_lbist_scan_out

   assign tcu_spc_lbist_start   = 1'b0;
   assign tcu_spc_lbist_scan_in = 1'b0;
   assign tcu_spc_lbist_pgm     = 1'b0;
   assign tcu_spc_test_mode     = 1'b0;
   
   // DMO interface
   wire [35:0]              dmo_din;                      // input   36'h0 .dmo_din
   wire                     dmo_coresel;                  // input   0     .dmo_coresel
   wire                     dmo_icmuxctl;                 // input   0     .dmo_icmuxctl
   wire                     dmo_dcmuxctl;                 // input   0     .dmo_dcmuxctl   
   output [35:0]           spc_dmo_dout;                 // output        .dmo_dout

   assign dmo_din      = 36'h000000000;
   assign dmo_coresel  = 1'b0;         
   assign dmo_icmuxctl = 1'b0;         
   assign dmo_dcmuxctl = 1'b0;         
   
   // l2 index hashing
   wire                     ncu_spc_l2_idx_hash_en;       // input   0     .ncu_spc_l2_idx_hash_en
   assign ncu_spc_l2_idx_hash_en = 1'b0;

   // gasket <-> CPX interface
   // Incoming CPX packet
   input [145:0]             cpx_spc_data_cx;              // input        .cpx_spc_data_cx
   
   // gasket <-> PCX interface
   input [8:0]               pcx_spc_grant_px;             // input        .pcx_spc_grant_px

   // PCX request
   output [8:0]             spc_pcx_req_pq;               // output       .spc_pcx_req_pq
   output [8:0]             spc_pcx_atm_pq;               // output       .spc_pcx_atm_pq

   // PCX packet data
   output [129:0]           spc_pcx_data_pa;              // output       .spc_pcx_data_pa


   reg [7:0]                tcu_core_running;             // input   8'h0->8'h1 @1650 .tcu_core_running
   output [7:0]             spc_core_running_status;      // output  8'h0->8'h1 @2300 .spc_core_running_status

   always @ (posedge gclk) begin
      if (rst) begin
         tcu_core_running <= 8'b0000_0000;
      end else begin
         tcu_core_running <= 8'b0000_0001;
      end
   end
   
   wire [2:0]               power_throttle;               // input   0                .power_throttle
   assign power_throttle = 3'b000;
   
   output [1:0]            spc_dbg_instr_cmt_grp0;       // output  0->1->0          .spc_dbg_instr_cmt_grp0
   output [1:0]            spc_dbg_instr_cmt_grp1;       // output                   .spc_dbg_instr_cmt_grp1

   wire                    gl_io_cmp_sync_en_c3t0;       // input   clk start 500, T 400: 100, 300 r 800 .ccu_slow_cmp_sync_en
   wire                    gl_cmp_io_sync_en_c3t0;       // input   clk start 500, T 400: 100, 300 r 600 .ccu_cmp_slow_sync_en
   
   wire [3:0]               spc_revid_out;                // input   0     .hver_mask_minor_rev
   assign spc_revid_out = 4'b0000;

   wire [32:0]             qed_inst0;
   wire [127:0]            cpx_spc_const;
   wire [17:0]             cpx_spc_ctrl;

   assign cpx_spc_const = {128{1'b0}}; 
   wire [145:0]            cpx_spc_cx_d0;
   assign cpx_spc_cx_d0 = 'b0;
 
spc spc(
  .vnw_ary0                 (vnw_ary0),
  .vnw_ary1                 (vnw_ary1), 
  // .gclk                                ( cmp_gclk_c3_spc0 ), // cmp_gclk_c1_r[1]) , // linhai88
  .gclk                     (gclk),                                 
  .tcu_clk_stop             (tcu_clk_stop ),                    
  .cpx_spc_data_cx          (cpx_spc_cx_d0  ), 
  .pcx_spc_grant_px         (pcx_spc_grant_px  ),        
  .spc_pcx_req_pq           (spc_pcx_req_pq     ),        
  .spc_pcx_atm_pq           (spc_pcx_atm_pq     ),        
  .spc_pcx_data_pa          (spc_pcx_data_pa ),
  .spc_hardstop_request     (spc_hardstop_request),               
  .spc_softstop_request     (spc_softstop_request),               
  .spc_trigger_pulse        (spc_trigger_pulse),                  
  .tcu_ss_mode              (tcu_ss_mode),
  .tcu_do_mode              (tcu_do_mode),
  .tcu_ss_request           (tcu_ss_request), 
  .spc_ss_complete          (spc_ss_complete),       
  .tcu_aclk                 (tcu_spc_aclk                ),
  .tcu_bclk                 (tcu_spc_bclk                ),
  .tcu_scan_en              (tcu_spc_scan_en             ),
  .tcu_se_scancollar_in     (tcu_spc_se_scancollar_in    ),
  .tcu_se_scancollar_out    (tcu_spc_se_scancollar_out   ),
  .tcu_array_wr_inhibit     (tcu_spc_array_wr_inhibit    ),
  .tcu_core_running         (tcu_core_running            ),  
  .spc_core_running_status  (spc_core_running_status     ), 
  .const_cpuid              (const_cpuid                 ),          
  .power_throttle           (power_throttle              ),   
  .scan_out                 (scan_out                    ),     
  .scan_in                  (scan_in                     ),      
  .spc_dbg_instr_cmt_grp0   (spc_dbg_instr_cmt_grp0      ), 
  .spc_dbg_instr_cmt_grp1   (spc_dbg_instr_cmt_grp1      ), 
  .tcu_spc_mbist_start      (tcu_spc_mbist_start         ),      
  .spc_mbist_done           (spc_tcu_mbist_done          ),           
  .spc_mbist_fail           (spc_tcu_mbist_fail          ),           
  .tcu_spc_mbist_scan_in    (tcu_spc_mbist_scan_in       ),      
  .spc_tcu_mbist_scan_out   (spc_tcu_mbist_scan_out      ),      
  .dmo_din                  (dmo_din                     ), 
  .dmo_dout                 (spc_dmo_dout                ), 
  .dmo_coresel              (dmo_coresel                 ), 
  .tcu_spc_lbist_start      (tcu_spc_lbist_start         ), 
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in       ), 
  .spc_tcu_lbist_done       (spc_tcu_lbist_done          ), 
  .spc_tcu_lbist_scan_out   (spc_tcu_lbist_scan_out	 ), 
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ), 
  .tcu_shscan_aclk	    (tcu_spc_shscan_aclk	 ), 
  .tcu_shscan_bclk	    (tcu_spc_shscan_bclk	 ), 
  .tcu_shscan_scan_en	    (tcu_spc_shscan_scan_en	 ), 
  .tcu_shscanid		    (tcu_spc_shscanid     	 ), 
  .tcu_shscan_scan_in	    (tcu_spc_shscan_scan_in	 ), 
  .spc_shscan_scan_out	    (spc_tcu_shscan_scan_out	 ), 
  .tcu_shscan_clk_stop	    (tcu_spc_shscan_clk_stop	 ), 
  .efu_spc_fuse_data	    (efu_spc_fuse_data	         ), 
  .efu_spc_fuse_ixfer_en    (efu_spc_fuse_ixfer_en	 ), 
  .efu_spc_fuse_iclr	    (efu_spc_fuse_iclr		 ), 
  .efu_spc_fuse_dxfer_en    (efu_spc_fuse_dxfer_en	 ), 
  .efu_spc_fuse_dclr	    (efu_spc_fuse_dclr		 ), 
  .spc_efu_fuse_dxfer_en    (spc_efu_fuse_dxfer_en	 ), 
  .spc_efu_fuse_ixfer_en    (spc_efu_fuse_ixfer_en	 ), 
  .spc_efu_fuse_ddata	    (spc_efu_fuse_ddata          ), 
  .spc_efu_fuse_idata	    (spc_efu_fuse_idata	         ), 
  .ccu_slow_cmp_sync_en     (gl_io_cmp_sync_en_c3t0      ),         
  .ccu_cmp_slow_sync_en     (gl_cmp_io_sync_en_c3t0      ),         
  .hver_mask_minor_rev	    (spc_revid_out[ 3 : 0 ]      ), 
  .tcu_pce_ov               (tcu_pce_ov),                        
  .tcu_dectest              (tcu_dectest),                      
  .tcu_muxtest              (tcu_muxtest),                      
  .rst_wmr_protect          (rst_wmr_protect),              
  .cluster_arst_l           (cluster_arst_l),                
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en),          
  .tcu_mbist_user_mode      (tcu_mbist_user_mode),      
  .ncu_cmp_tick_enable      (ncu_cmp_tick_enable),      
  .ncu_wmr_vec_mask         (ncu_wmr_vec_mask),            
  .ncu_spc_pm               (ncu_spc_pm),                        
  .ncu_spc_ba01             (ncu_spc_ba01),                    
  .ncu_spc_ba23             (ncu_spc_ba23),                    
  .ncu_spc_ba45             (ncu_spc_ba45),                    
  .ncu_spc_ba67             (ncu_spc_ba67),                    
  .tcu_spc_lbist_pgm        (tcu_spc_lbist_pgm),          
  .tcu_spc_test_mode        (tcu_spc_test_mode),         
  .dmo_icmuxctl             (dmo_icmuxctl),                    
  .dmo_dcmuxctl             (dmo_dcmuxctl),                    
  .tcu_atpg_mode            (tcu_atpg_mode),                  
  .ncu_spc_l2_idx_hash_en   (ncu_spc_l2_idx_hash_en), 
  .qed_rst                  (1'b0),
  .qed_inst0                (qed_inst0) );   
   


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
