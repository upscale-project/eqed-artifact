//
// This file is modifed from cpu.v, part of the RTL for the OpenSPARC T2 
// Processor. The original copyright is printed below.
//
// ==== Copyright Header Begin =============
// 
// OpenSPARC T2 Processor File: cpu.v
// Copyright (C) 1995-2007 Sun Microsystems, Inc. All Rights Reserved
// 4150 Network Circle, Santa Clara, California 95054, U.S.A.
//
// * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER. 
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; version 2 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
// 
// For the avoidance of doubt, and except that if any non-GPL license 
// choice is available it will apply instead, Sun elects to use only 
// the General Public License version 2 (GPLv2) at this time for any 
// software where a choice of GPL license versions is made 
// available with the language indicating that GPLv2 or any later version 
// may be used, or where a choice of which version of the GPL is applied is 
// otherwise unspecified. 
//
// Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa Clara, 
// CA 95054 USA or visit www.sun.com if you need additional information or 
// have any questions. 
// 
// ==== Copyright Header End ==============
module eqed_ost2 (
//E-QED clk and rst
  clk,
  eqed_rst,
  L2T_VNW, 
  SPC_VNW, 
  L2D_VNW0, 
  L2D_VNW1, 
  FBDIMM0A_TX_P, 
  FBDIMM0A_TX_N, 
  FBDIMM0A_RX_P, 
  FBDIMM0A_RX_N, 
  FBDIMM0A_AMUX, 
  FBDIMM0B_TX_P, 
  FBDIMM0B_TX_N, 
  FBDIMM0B_RX_P, 
  FBDIMM0B_RX_N, 
  FBDIMM0B_AMUX, 
  FBDIMM1A_TX_P, 
  FBDIMM1A_TX_N, 
  FBDIMM1A_RX_P, 
  FBDIMM1A_RX_N, 
  FBDIMM1A_AMUX, 
  FBDIMM1B_TX_P, 
  FBDIMM1B_TX_N, 
  FBDIMM1B_RX_P, 
  FBDIMM1B_RX_N, 
  FBDIMM1B_AMUX, 
  FBDIMM2A_TX_P, 
  FBDIMM2A_TX_N, 
  FBDIMM2A_RX_P, 
  FBDIMM2A_RX_N, 
  FBDIMM2A_AMUX, 
  FBDIMM2B_TX_P, 
  FBDIMM2B_TX_N, 
  FBDIMM2B_RX_P, 
  FBDIMM2B_RX_N, 
  FBDIMM2B_AMUX, 
  FBDIMM3A_TX_P, 
  FBDIMM3A_TX_N, 
  FBDIMM3A_RX_P, 
  FBDIMM3A_RX_N, 
  FBDIMM3A_AMUX, 
  FBDIMM3B_TX_P, 
  FBDIMM3B_TX_N, 
  FBDIMM3B_RX_P, 
  FBDIMM3B_RX_N, 
  FBDIMM3B_AMUX, 
  FBDIMM1_REFCLK_P, 
  FBDIMM1_REFCLK_N, 
  FBDIMM2_REFCLK_P, 
  FBDIMM2_REFCLK_N, 
  FBDIMM3_REFCLK_P, 
  FBDIMM3_REFCLK_N, 
  VDDA_FSRL, 
  VDDD_FSRL, 
  VDDR_FSRL, 
  VDDT_FSRL, 
  VSSA_FSRL, 
  VDDA_FSRR, 
  VDDD_FSRR, 
  VDDR_FSRR, 
  VDDT_FSRR, 
  VSSA_FSRR, 
  VDDA_FSRB, 
  VDDD_FSRB, 
  VDDR_FSRB, 
  VDDT_FSRB, 
  VSSA_FSRB, 
  PEX_TX_P, 
  PEX_TX_N, 
  PEX_RX_P, 
  PEX_RX_N, 
  PEX_REFCLK_P, 
  PEX_REFCLK_N, 
  PEX_AMUX, 
  VDDT_PSR, 
  VDDD_PSR, 
  VDDC_PSR, 
  VDDA_PSR, 
  VDDR_PSR, 
  VSSA_PSR, 
  STCIQ, 
  TESTCLKT, 
  TESTCLKR, 
  STCID, 
  PLL_CMP_BYPASS, 
  STCICFG, 
  STCICLK, 
  PGRM_EN, 
  VDDO_PCM, 
  PLL_CMP_CLK_P, 
  PLL_CMP_CLK_N, 
  DIODE_TOP, 
  DIODE_BOT, 
  VDD_PLL_CMP_REG, 
  VDD_RNG_HV, 
  VDD_SENSE, 
  VSS_SENSE, 
  RNG_ANLG_CHAR_OUT, 
  PWRON_RST_L, 
  BUTTON_XIR_L, 
  PB_RST_L, 
  PEX_RESET_L, 
  SSI_SYNC_L, 
  VPP, 
  TMS, 
  TDI, 
  TRST_L, 
  TCK, 
  TESTMODE, 
  TDO, 
  DIVIDER_BYPASS, 
  DBG_DQ, 
  DBG_CK0, 
  TRIGIN, 
  TRIGOUT, 
  SSI_MISO, 
  SSI_EXT_INT_L, 
  SSI_SCK, 
  SSI_MOSI, 
  PMI, 
  VREG_SELBG_L, 
  PLL_CHAR_OUT, 
  PLL_TESTMODE, 
  PWR_THRTTL_0, 
  PWR_THRTTL_1, 
  PMO, 
  BURNIN);
wire arb_pio_all_npwdirty;
wire arb_pio_all_rddirty;
wire [5:0] arb_pio_dirtid_npwstatus;
wire [5:0] arb_pio_dirtid_rdstatus;
wire cluster_arst_l;
wire cmp_gclk_c0_rdp;
wire efu_niu_ram0_clr;
wire efu_niu_ram0_xfer_en;
wire efu_niu_ram1_clr;
wire efu_niu_ram1_xfer_en;
wire efu_niu_ram_data;
wire [31:0] fflp_debug_port;
wire fflp_pio_ack;
wire fflp_pio_err;
wire fflp_pio_intr;
wire [63:0] fflp_pio_rdata;
wire gl_io2x_out_c1b;
wire gl_io_out_c1b;
wire [31:0] ipp_debug_port;
wire ipp_dmc_dat_ack0;
wire ipp_dmc_dat_ack1;
wire ipp_dmc_dat_err0;
wire ipp_dmc_dat_err1;
wire [129:0] ipp_dmc_data0;
wire [129:0] ipp_dmc_data1;
wire ipp_dmc_ful_pkt0;
wire ipp_dmc_ful_pkt1;
wire ipp_pio_ack;
wire ipp_pio_err;
wire ipp_pio_intr;
wire [63:0] ipp_pio_rdata;
wire [31:0] mac_debug_port;
wire mac_pio_ack;
wire mac_pio_err;
wire mac_pio_intr0;
wire mac_pio_intr1;
wire [63:0] mac_pio_rdata;
wire meta_dmc_ack_client_rdmc;
wire [7:0] meta_dmc_ack_cmd;
wire [3:0] meta_dmc_ack_cmd_status;
wire [4:0] meta_dmc_ack_dma_num;
wire meta_dmc_ack_ready;
wire arb0_rcr_data_req;
wire arb0_rcr_req_accept;
wire arb0_rdc_data_req;
wire arb0_rdc_req_accept;
wire arb1_rbr_req_accept;
wire arb1_rbr_req_errors;
wire [15:0] meta1_rdmc_rbr_resp_byteenable;
wire meta_dmc_resp_client_rdmc;
wire [7:0] meta1_rdmc_rbr_resp_cmd;
wire [3:0] meta1_rdmc_rbr_resp_cmd_status;
wire meta_dmc_resp_complete_rdmc;
wire [127:0] meta1_rdmc_rbr_resp_data;
wire [3:0] meta_dmc_data_status;
wire meta_dmc_data_valid_rdmc;
wire [4:0] meta1_rdmc_rbr_resp_dma_num;
wire meta1_rdmc_rbr_resp_ready;
wire meta_dmc_resp_transfer_cmpl_rdmc;
wire [31:0] meta_arb_debug_port;
wire mif_pio_intr;
wire [31:0] ncu_niu_data;
wire ncu_niu_stall;
wire ncu_niu_vld;
wire rdp_rdmc_mbist_scan_in;
wire gl_rst_niu_wmr_c1b;
wire [31:0] smx_debug_port;
wire smx_pio_intr;
wire [31:0] smx_pio_status;
wire tcu_asic_aclk;
wire tcu_asic_bclk;
wire tcu_div_bypass;
wire tcu_mbist_bisi_en;
wire tcu_mbist_user_mode;
wire tcu_pce_ov;
wire tcu_rdp_rdmc_mbist_start;
wire tcu_asic_scan_en;
wire tcu_asic_se_scancollar_in;
wire tcu_asic_se_scancollar_out;
wire [31:0] tdmc_debug_port;
wire tdmc_pio_ack;
wire tdmc_pio_err;
wire [63:0] tdmc_pio_rdata;
wire [31:0] txc_debug_port;
wire txc_pio_ack;
wire txc_pio_err;
wire niu_txc_interrupts;
wire [63:0] txc_pio_rdata;
wire [31:0] zcp_debug_port;
wire zcp_dmc_ack0;
wire zcp_dmc_ack1;
wire [129:0] zcp_dmc_dat0;
wire [129:0] zcp_dmc_dat1;
wire zcp_dmc_dat_err0;
wire zcp_dmc_dat_err1;
wire zcp_dmc_ful_pkt0;
wire zcp_dmc_ful_pkt1;
wire zcp_pio_ack;
wire zcp_pio_err;
wire zcp_pio_intr;
wire [63:0] zcp_pio_rdata;
wire dmc_ipp_dat_req0;
wire dmc_ipp_dat_req1;
wire dmc_zcp_req0;
wire dmc_zcp_req1;
wire mac_reset0;
wire mac_reset1;
wire niu_efu_ram0_xfer_en;
wire niu_efu_ram1_xfer_en;
wire [31:0] niu_ncu_data;
wire niu_ncu_stall;
wire niu_ncu_vld;
wire [31:0] pio_arb_ctrl;
wire [31:0] pio_arb_debug_vector;
wire pio_arb_dirtid_clr;
wire pio_arb_dirtid_enable;
wire [5:0] pio_arb_np_threshold;
wire [5:0] pio_arb_rd_threshold;
wire pio_fflp_sel;
wire pio_ipp_sel;
wire pio_mac_sel;
wire [31:0] pio_smx_cfg_data;
wire pio_smx_clear_intr;
wire [31:0] pio_smx_ctrl;
wire [31:0] pio_smx_debug_vector;
wire pio_tdmc_sel;
wire pio_txc_sel;
wire pio_zcp_sel;
wire rdmc_meta_ack_accept;
wire [127:0] rcr_arb0_data;
wire rcr_arb0_data_valid;
wire rcr_arb0_req;
wire [63:0] rcr_arb0_req_address;
wire [15:0] rcr_arb0_req_byteenable;
wire [7:0] rcr_arb0_req_cmd;
wire [4:0] rcr_arb0_req_dma_num;
wire [1:0] rcr_arb0_req_func_num;
wire [13:0] rcr_arb0_req_length;
wire [1:0] rcr_arb0_req_port_num;
wire [3:0] rcr_arb0_status;
wire rcr_arb0_transfer_complete;
wire [127:0] rdc_arb0_data;
wire rdc_arb0_data_valid;
wire rdc_arb0_req;
wire [63:0] rdc_arb0_req_address;
wire [15:0] rdc_arb0_req_byteenable;
wire [7:0] rdc_arb0_req_cmd;
wire [4:0] rdc_arb0_req_dma_num;
wire [1:0] rdc_arb0_req_func_num;
wire [13:0] rdc_arb0_req_length;
wire [1:0] rdc_arb0_req_port_num;
wire [3:0] rdc_arb0_status;
wire rdc_arb0_transfer_complete;
wire rbr_arb1_req;
wire [63:0] rbr_arb1_req_address;
wire [7:0] rbr_arb1_req_cmd;
wire [4:0] rbr_arb1_req_dma_num;
wire [1:0] rbr_arb1_req_func_num;
wire [13:0] rbr_arb1_req_length;
wire [1:0] rbr_arb1_req_port_num;
wire rdmc_meta_resp_accept;
wire rdp_rdmc_mbist_scan_out;
wire rdp_rdmc_tcu_mbist_done;
wire rdp_rdmc_tcu_mbist_fail;
wire [39:0] rdp_tcu_dmo_dout;
wire tcu_asic_array_wr_inhibit;
wire tcu_soce_scan_out;
wire rdp_scan_out;
wire [63:0] pio_clients_wdata;
wire [19:0] pio_clients_addr;
wire pio_clients_rd;
wire [4:0] dbg1_niu_dbg_sel;
wire [1:0] niu_mio_debug_clock;
wire [31:0] niu_mio_debug_data;
wire niu_efu_ram0_data;
wire niu_efu_ram1_data;
wire gl_rdp_io_clk_stop;
wire [63:0] tdmc_pio_intr;
wire cmp_gclk_c0_tds;
wire dbg1_niu_resume;
wire dbg1_niu_stall;
wire efu_niu_ram_clr;
wire efu_niu_ram_xfer_en;
wire ncu_niu_ctag_cei;
wire ncu_niu_ctag_uei;
wire ncu_niu_d_pei;
wire tcu_soc4_scan_out;
wire sii_niu_bqdq;
wire sii_niu_oqdq;
wire [127:0] sio_niu_data;
wire sio_niu_datareq;
wire sio_niu_hdr_vld;
wire [7:0] sio_niu_parity;
wire gl_tds_io_clk_stop;
wire tcu_tds_smx_mbist_start;
wire tcu_tds_tdmc_mbist_start;
wire tds_mbist_scan_in;
wire txc_arb1_req;
wire [63:0] txc_arb1_req_address;
wire [7:0] txc_arb1_req_cmd;
wire [4:0] txc_arb1_req_dma_num;
wire [1:0] txc_arb1_req_func_num;
wire [13:0] txc_arb1_req_length;
wire [1:0] txc_arb1_req_port_num;
wire txc_dmc_dma0_getnxtdesc;
wire txc_dmc_dma0_inc_head;
wire txc_dmc_dma0_inc_pkt_cnt;
wire txc_dmc_dma0_mark_bit;
wire txc_dmc_dma0_reset_done;
wire txc_dmc_dma10_getnxtdesc;
wire txc_dmc_dma10_inc_head;
wire txc_dmc_dma10_inc_pkt_cnt;
wire txc_dmc_dma10_mark_bit;
wire txc_dmc_dma10_reset_done;
wire txc_dmc_dma11_getnxtdesc;
wire txc_dmc_dma11_inc_head;
wire txc_dmc_dma11_inc_pkt_cnt;
wire txc_dmc_dma11_mark_bit;
wire txc_dmc_dma11_reset_done;
wire txc_dmc_dma12_getnxtdesc;
wire txc_dmc_dma12_inc_head;
wire txc_dmc_dma12_inc_pkt_cnt;
wire txc_dmc_dma12_mark_bit;
wire txc_dmc_dma12_reset_done;
wire txc_dmc_dma13_getnxtdesc;
wire txc_dmc_dma13_inc_head;
wire txc_dmc_dma13_inc_pkt_cnt;
wire txc_dmc_dma13_mark_bit;
wire txc_dmc_dma13_reset_done;
wire txc_dmc_dma14_getnxtdesc;
wire txc_dmc_dma14_inc_head;
wire txc_dmc_dma14_inc_pkt_cnt;
wire txc_dmc_dma14_mark_bit;
wire txc_dmc_dma14_reset_done;
wire txc_dmc_dma15_getnxtdesc;
wire txc_dmc_dma15_inc_head;
wire txc_dmc_dma15_inc_pkt_cnt;
wire txc_dmc_dma15_mark_bit;
wire txc_dmc_dma15_reset_done;
wire txc_dmc_dma1_getnxtdesc;
wire txc_dmc_dma1_inc_head;
wire txc_dmc_dma1_inc_pkt_cnt;
wire txc_dmc_dma1_mark_bit;
wire txc_dmc_dma1_reset_done;
wire txc_dmc_dma2_getnxtdesc;
wire txc_dmc_dma2_inc_head;
wire txc_dmc_dma2_inc_pkt_cnt;
wire txc_dmc_dma2_mark_bit;
wire txc_dmc_dma2_reset_done;
wire txc_dmc_dma3_getnxtdesc;
wire txc_dmc_dma3_inc_head;
wire txc_dmc_dma3_inc_pkt_cnt;
wire txc_dmc_dma3_mark_bit;
wire txc_dmc_dma3_reset_done;
wire txc_dmc_dma4_getnxtdesc;
wire txc_dmc_dma4_inc_head;
wire txc_dmc_dma4_inc_pkt_cnt;
wire txc_dmc_dma4_mark_bit;
wire txc_dmc_dma4_reset_done;
wire txc_dmc_dma5_getnxtdesc;
wire txc_dmc_dma5_inc_head;
wire txc_dmc_dma5_inc_pkt_cnt;
wire txc_dmc_dma5_mark_bit;
wire txc_dmc_dma5_reset_done;
wire txc_dmc_dma6_getnxtdesc;
wire txc_dmc_dma6_inc_head;
wire txc_dmc_dma6_inc_pkt_cnt;
wire txc_dmc_dma6_mark_bit;
wire txc_dmc_dma6_reset_done;
wire txc_dmc_dma7_getnxtdesc;
wire txc_dmc_dma7_inc_head;
wire txc_dmc_dma7_inc_pkt_cnt;
wire txc_dmc_dma7_mark_bit;
wire txc_dmc_dma7_reset_done;
wire txc_dmc_dma8_getnxtdesc;
wire txc_dmc_dma8_inc_head;
wire txc_dmc_dma8_inc_pkt_cnt;
wire txc_dmc_dma8_mark_bit;
wire txc_dmc_dma8_reset_done;
wire txc_dmc_dma9_getnxtdesc;
wire txc_dmc_dma9_inc_head;
wire txc_dmc_dma9_inc_pkt_cnt;
wire txc_dmc_dma9_mark_bit;
wire txc_dmc_dma9_reset_done;
wire [15:0] txc_dmc_dma_nack_pkt_rd;
wire txc_dmc_nack_pkt_rd;
wire [43:0] txc_dmc_nack_pkt_rd_addr;
wire [15:0] txc_dmc_p0_dma_pkt_size_err;
wire txc_dmc_p0_pkt_size_err;
wire [43:0] txc_dmc_p0_pkt_size_err_addr;
wire [15:0] txc_dmc_p1_dma_pkt_size_err;
wire txc_dmc_p1_pkt_size_err;
wire [43:0] txc_dmc_p1_pkt_size_err_addr;
wire txc_meta_resp_accept;
wire arb1_txc_req_accept;
wire [5:0] dmc_meta1_req_trans_id;
wire dmc_txc_dma0_active;
wire dmc_txc_dma0_cacheready;
wire [63:0] dmc_txc_dma0_descriptor;
wire dmc_txc_dma0_eoflist;
wire dmc_txc_dma0_error;
wire [1:0] dmc_txc_dma0_func_num;
wire dmc_txc_dma0_gotnxtdesc;
wire [19:0] dmc_txc_dma0_page_handle;
wire dmc_txc_dma0_partial;
wire dmc_txc_dma0_reset_scheduled;
wire dmc_txc_dma10_active;
wire dmc_txc_dma10_cacheready;
wire [63:0] dmc_txc_dma10_descriptor;
wire dmc_txc_dma10_eoflist;
wire dmc_txc_dma10_error;
wire [1:0] dmc_txc_dma10_func_num;
wire dmc_txc_dma10_gotnxtdesc;
wire [19:0] dmc_txc_dma10_page_handle;
wire dmc_txc_dma10_partial;
wire dmc_txc_dma10_reset_scheduled;
wire dmc_txc_dma11_active;
wire dmc_txc_dma11_cacheready;
wire [63:0] dmc_txc_dma11_descriptor;
wire dmc_txc_dma11_eoflist;
wire dmc_txc_dma11_error;
wire [1:0] dmc_txc_dma11_func_num;
wire dmc_txc_dma11_gotnxtdesc;
wire [19:0] dmc_txc_dma11_page_handle;
wire dmc_txc_dma11_partial;
wire dmc_txc_dma11_reset_scheduled;
wire dmc_txc_dma12_active;
wire dmc_txc_dma12_cacheready;
wire [63:0] dmc_txc_dma12_descriptor;
wire dmc_txc_dma12_eoflist;
wire dmc_txc_dma12_error;
wire [1:0] dmc_txc_dma12_func_num;
wire dmc_txc_dma12_gotnxtdesc;
wire [19:0] dmc_txc_dma12_page_handle;
wire dmc_txc_dma12_partial;
wire dmc_txc_dma12_reset_scheduled;
wire dmc_txc_dma13_active;
wire dmc_txc_dma13_cacheready;
wire [63:0] dmc_txc_dma13_descriptor;
wire dmc_txc_dma13_eoflist;
wire dmc_txc_dma13_error;
wire [1:0] dmc_txc_dma13_func_num;
wire dmc_txc_dma13_gotnxtdesc;
wire [19:0] dmc_txc_dma13_page_handle;
wire dmc_txc_dma13_partial;
wire dmc_txc_dma13_reset_scheduled;
wire dmc_txc_dma14_active;
wire dmc_txc_dma14_cacheready;
wire [63:0] dmc_txc_dma14_descriptor;
wire dmc_txc_dma14_eoflist;
wire dmc_txc_dma14_error;
wire [1:0] dmc_txc_dma14_func_num;
wire dmc_txc_dma14_gotnxtdesc;
wire [19:0] dmc_txc_dma14_page_handle;
wire dmc_txc_dma14_partial;
wire dmc_txc_dma14_reset_scheduled;
wire dmc_txc_dma15_active;
wire dmc_txc_dma15_cacheready;
wire [63:0] dmc_txc_dma15_descriptor;
wire dmc_txc_dma15_eoflist;
wire dmc_txc_dma15_error;
wire [1:0] dmc_txc_dma15_func_num;
wire dmc_txc_dma15_gotnxtdesc;
wire [19:0] dmc_txc_dma15_page_handle;
wire dmc_txc_dma15_partial;
wire dmc_txc_dma15_reset_scheduled;
wire dmc_txc_dma1_active;
wire dmc_txc_dma1_cacheready;
wire [63:0] dmc_txc_dma1_descriptor;
wire dmc_txc_dma1_eoflist;
wire dmc_txc_dma1_error;
wire [1:0] dmc_txc_dma1_func_num;
wire dmc_txc_dma1_gotnxtdesc;
wire [19:0] dmc_txc_dma1_page_handle;
wire dmc_txc_dma1_partial;
wire dmc_txc_dma1_reset_scheduled;
wire dmc_txc_dma2_active;
wire dmc_txc_dma2_cacheready;
wire [63:0] dmc_txc_dma2_descriptor;
wire dmc_txc_dma2_eoflist;
wire dmc_txc_dma2_error;
wire [1:0] dmc_txc_dma2_func_num;
wire dmc_txc_dma2_gotnxtdesc;
wire [19:0] dmc_txc_dma2_page_handle;
wire dmc_txc_dma2_partial;
wire dmc_txc_dma2_reset_scheduled;
wire dmc_txc_dma3_active;
wire dmc_txc_dma3_cacheready;
wire [63:0] dmc_txc_dma3_descriptor;
wire dmc_txc_dma3_eoflist;
wire dmc_txc_dma3_error;
wire [1:0] dmc_txc_dma3_func_num;
wire dmc_txc_dma3_gotnxtdesc;
wire [19:0] dmc_txc_dma3_page_handle;
wire dmc_txc_dma3_partial;
wire dmc_txc_dma3_reset_scheduled;
wire dmc_txc_dma4_active;
wire dmc_txc_dma4_cacheready;
wire [63:0] dmc_txc_dma4_descriptor;
wire dmc_txc_dma4_eoflist;
wire dmc_txc_dma4_error;
wire [1:0] dmc_txc_dma4_func_num;
wire dmc_txc_dma4_gotnxtdesc;
wire [19:0] dmc_txc_dma4_page_handle;
wire dmc_txc_dma4_partial;
wire dmc_txc_dma4_reset_scheduled;
wire dmc_txc_dma5_active;
wire dmc_txc_dma5_cacheready;
wire [63:0] dmc_txc_dma5_descriptor;
wire dmc_txc_dma5_eoflist;
wire dmc_txc_dma5_error;
wire [1:0] dmc_txc_dma5_func_num;
wire dmc_txc_dma5_gotnxtdesc;
wire [19:0] dmc_txc_dma5_page_handle;
wire dmc_txc_dma5_partial;
wire dmc_txc_dma5_reset_scheduled;
wire dmc_txc_dma6_active;
wire dmc_txc_dma6_cacheready;
wire [63:0] dmc_txc_dma6_descriptor;
wire dmc_txc_dma6_eoflist;
wire dmc_txc_dma6_error;
wire [1:0] dmc_txc_dma6_func_num;
wire dmc_txc_dma6_gotnxtdesc;
wire [19:0] dmc_txc_dma6_page_handle;
wire dmc_txc_dma6_partial;
wire dmc_txc_dma6_reset_scheduled;
wire dmc_txc_dma7_active;
wire dmc_txc_dma7_cacheready;
wire [63:0] dmc_txc_dma7_descriptor;
wire dmc_txc_dma7_eoflist;
wire dmc_txc_dma7_error;
wire [1:0] dmc_txc_dma7_func_num;
wire dmc_txc_dma7_gotnxtdesc;
wire [19:0] dmc_txc_dma7_page_handle;
wire dmc_txc_dma7_partial;
wire dmc_txc_dma7_reset_scheduled;
wire dmc_txc_dma8_active;
wire dmc_txc_dma8_cacheready;
wire [63:0] dmc_txc_dma8_descriptor;
wire dmc_txc_dma8_eoflist;
wire dmc_txc_dma8_error;
wire [1:0] dmc_txc_dma8_func_num;
wire dmc_txc_dma8_gotnxtdesc;
wire [19:0] dmc_txc_dma8_page_handle;
wire dmc_txc_dma8_partial;
wire dmc_txc_dma8_reset_scheduled;
wire dmc_txc_dma9_active;
wire dmc_txc_dma9_cacheready;
wire [63:0] dmc_txc_dma9_descriptor;
wire dmc_txc_dma9_eoflist;
wire dmc_txc_dma9_error;
wire [1:0] dmc_txc_dma9_func_num;
wire dmc_txc_dma9_gotnxtdesc;
wire [19:0] dmc_txc_dma9_page_handle;
wire dmc_txc_dma9_partial;
wire dmc_txc_dma9_reset_scheduled;
wire dmc_txc_tx_addr_md;
wire [127:0] meta_dmc_data;
wire meta_dmc_data_valid_txc;
wire [63:0] meta_dmc_resp_address;
wire [15:0] meta_dmc_resp_byteenable;
wire meta_dmc_resp_client_txc;
wire [7:0] meta_dmc_resp_cmd;
wire [3:0] meta_dmc_resp_cmd_status;
wire meta_dmc_resp_complete_txc;
wire [4:0] meta_dmc_resp_dma_num;
wire [13:0] meta_dmc_resp_length;
wire [1:0] meta_dmc_resp_port_num;
wire meta_dmc_resp_ready;
wire [5:0] meta_dmc_resp_trans_id;
wire meta_dmc_resp_transfer_cmpl_txc;
wire niu_dbg1_stall_ack;
wire niu_efu_ram_data;
wire niu_efu_ram_xfer_en;
wire niu_ncu_ctag_ce;
wire niu_ncu_ctag_ue;
wire niu_ncu_d_pe;
wire [127:0] niu_sii_data;
wire niu_sii_datareq;
wire niu_sii_hdr_vld;
wire [7:0] niu_sii_parity;
wire niu_sii_reqbypass;
wire niu_sio_dq;
wire tds_scan_out;
wire tds_mbist_scan_out;
wire tds_smx_tcu_mbist_done;
wire tds_smx_tcu_mbist_fail;
wire [39:0] tds_tcu_dmo_dout;
wire tds_tdmc_tcu_mbist_done;
wire tds_tdmc_tcu_mbist_fail;
wire cmp_gclk_c0_rtx;
wire efu_niu_4k_clr;
wire efu_niu_4k_data;
wire efu_niu_4k_xfer_en;
wire efu_niu_cfifo0_clr;
wire efu_niu_cfifo0_xfer_en;
wire efu_niu_cfifo1_clr;
wire efu_niu_cfifo1_xfer_en;
wire efu_niu_cfifo_data;
wire efu_niu_ipp0_clr;
wire efu_niu_ipp0_xfer_en;
wire efu_niu_ipp1_clr;
wire efu_niu_ipp1_xfer_en;
wire efu_niu_mac01_sfro_data;
wire efu_niu_mac0_ro_clr;
wire efu_niu_mac0_ro_xfer_en;
wire efu_niu_mac0_sf_clr;
wire efu_niu_mac0_sf_xfer_en;
wire efu_niu_mac1_ro_clr;
wire efu_niu_mac1_ro_xfer_en;
wire efu_niu_mac1_sf_clr;
wire efu_niu_mac1_sf_xfer_en;
wire mac_rxc_ack0;
wire mac_rxc_ack1;
wire mac_rxc_ctrl0;
wire mac_rxc_ctrl1;
wire [63:0] mac_rxc_data0;
wire [63:0] mac_rxc_data1;
wire [22:0] mac_rxc_stat0;
wire [22:0] mac_rxc_stat1;
wire mac_rxc_tag0;
wire mac_rxc_tag1;
wire mac_txc_req0;
wire mac_txc_req1;
wire rtx_mbist_scan_in;
wire tcu_socf_scan_out;
wire [2:0] tcu_rtx_dmo_ctl;
wire gl_rtx_io_clk_stop;
wire tcu_rtx_rxc_ipp0_mbist_start;
wire tcu_rtx_rxc_ipp1_mbist_start;
wire tcu_rtx_rxc_mb5_mbist_start;
wire tcu_rtx_rxc_mb6_mbist_start;
wire tcu_rtx_rxc_zcp0_mbist_start;
wire tcu_rtx_rxc_zcp1_mbist_start;
wire tcu_rtx_txc_txe0_mbist_start;
wire tcu_rtx_txc_txe1_mbist_start;
wire niu_efu_4k_data;
wire niu_efu_4k_xfer_en;
wire niu_efu_cfifo0_data;
wire niu_efu_cfifo0_xfer_en;
wire niu_efu_cfifo1_data;
wire niu_efu_cfifo1_xfer_en;
wire niu_efu_ipp0_data;
wire niu_efu_ipp0_xfer_en;
wire niu_efu_ipp1_data;
wire niu_efu_ipp1_xfer_en;
wire niu_efu_mac0_ro_data;
wire niu_efu_mac0_ro_xfer_en;
wire niu_efu_mac0_sf_data;
wire niu_efu_mac0_sf_xfer_en;
wire niu_efu_mac1_ro_data;
wire niu_efu_mac1_ro_xfer_en;
wire niu_efu_mac1_sf_data;
wire niu_efu_mac1_sf_xfer_en;
wire rtx_mbist_scan_out;
wire rtx_rxc_ipp0_tcu_mbist_done;
wire rtx_rxc_ipp0_tcu_mbist_fail;
wire rtx_rxc_ipp1_tcu_mbist_done;
wire rtx_rxc_ipp1_tcu_mbist_fail;
wire rtx_rxc_mb5_tcu_mbist_done;
wire rtx_rxc_mb5_tcu_mbist_fail;
wire rtx_rxc_mb6_tcu_mbist_done;
wire rtx_rxc_mb6_tcu_mbist_fail;
wire rtx_rxc_zcp0_tcu_mbist_done;
wire rtx_rxc_zcp0_tcu_mbist_fail;
wire rtx_rxc_zcp1_tcu_mbist_done;
wire rtx_rxc_zcp1_tcu_mbist_fail;
wire [39:0] rtx_tcu_dmo_data_out;
wire rtx_txc_txe0_tcu_mbist_done;
wire rtx_txc_txe0_tcu_mbist_fail;
wire rtx_txc_txe1_tcu_mbist_done;
wire rtx_txc_txe1_tcu_mbist_fail;
wire rxc_mac_req0;
wire rxc_mac_req1;
wire rtx_scan_out;
wire txc_mac_abort0;
wire txc_mac_abort1;
wire txc_mac_ack0;
wire txc_mac_ack1;
wire [63:0] txc_mac_data0;
wire [63:0] txc_mac_data1;
wire [3:0] txc_mac_stat0;
wire [3:0] txc_mac_stat1;
wire txc_mac_tag0;
wire txc_mac_tag1;
wire [3:0] esr_mac_rclk_0;
wire [3:0] esr_mac_rclk_1;
wire [9:0] esr_mac_rxd0_0;
wire [9:0] esr_mac_rxd0_1;
wire [9:0] esr_mac_rxd1_0;
wire [9:0] esr_mac_rxd1_1;
wire [9:0] esr_mac_rxd2_0;
wire [9:0] esr_mac_rxd2_1;
wire [9:0] esr_mac_rxd3_0;
wire [9:0] esr_mac_rxd3_1;
wire esr_mac_tclk_0;
wire esr_mac_tclk_1;
wire cmp_gclk_c1_mac;
wire gl_mac_io_clk_stop;
wire mac_125rx_test_clk;
wire mac_125tx_test_clk;
wire mac_156rx_test_clk;
wire mac_156tx_test_clk;
wire mac_312rx_test_clk;
wire mac_312tx_test_clk;
wire mdi;
wire peu_mac_sbs_input;
wire gl_rst_mac_c1b;
wire tcu_soc5_scan_out;
wire [3:0] stspll_0;
wire [3:0] stspll_1;
wire [7:0] stsrx0_0;
wire [7:0] stsrx0_1;
wire [7:0] stsrx1_0;
wire [7:0] stsrx1_1;
wire [7:0] stsrx2_0;
wire [7:0] stsrx2_1;
wire [7:0] stsrx3_0;
wire [7:0] stsrx3_1;
wire [3:0] ststx0_0;
wire [3:0] ststx0_1;
wire [3:0] ststx1_0;
wire [3:0] ststx1_1;
wire [3:0] ststx2_0;
wire [3:0] ststx2_1;
wire [3:0] ststx3_0;
wire [3:0] ststx3_1;
wire tcu_sbs_acmode;
wire tcu_sbs_actestsignal;
wire tcu_sbs_aclk;
wire tcu_sbs_bclk;
wire tcu_sbs_clk;
wire tcu_sbs_enbspt;
wire tcu_sbs_enbsrx;
wire tcu_sbs_enbstx;
wire tcu_sbs_scan_en;
wire tcu_sbs_uclk;
wire tcu_mac_testmode;
wire [11:0] cfgpll_0;
wire [11:0] cfgpll_1;
wire [27:0] cfgrx0_0;
wire [27:0] cfgrx0_1;
wire [27:0] cfgrx1_0;
wire [27:0] cfgrx1_1;
wire [27:0] cfgrx2_0;
wire [27:0] cfgrx2_1;
wire [27:0] cfgrx3_0;
wire [27:0] cfgrx3_1;
wire [19:0] cfgtx0_0;
wire [19:0] cfgtx0_1;
wire [19:0] cfgtx1_0;
wire [19:0] cfgtx1_1;
wire [19:0] cfgtx2_0;
wire [19:0] cfgtx2_1;
wire [19:0] cfgtx3_0;
wire [19:0] cfgtx3_1;
wire [3:0] mac_esr_tclk_0;
wire [3:0] mac_esr_tclk_1;
wire [9:0] mac_esr_txd0_0;
wire [9:0] mac_esr_txd0_1;
wire [9:0] mac_esr_txd1_0;
wire [9:0] mac_esr_txd1_1;
wire [9:0] mac_esr_txd2_0;
wire [9:0] mac_esr_txd2_1;
wire [9:0] mac_esr_txd3_0;
wire [9:0] mac_esr_txd3_1;
wire mac_mcu_3_sbs_output;
wire mdoe;
wire mac_scan_out;
wire [15:0] testcfg_0;
wire [15:0] testcfg_1;
wire xaui_act_led_0;
wire xaui_act_led_1;
wire xaui_link_led_0;
wire xaui_link_led_1;
wire mio_mac_xaui_mdint1_l;
wire mio_mac_xaui_mdint0_l;
wire mdc;
wire [1:0] tcu_stcicfg;
wire tcu_stciclk;
wire esr_stcid;
wire stcid_1;
wire mio_esr_testclkr;
wire mio_esr_testclkt;
wire fdi_1;
wire efu_niu_fclk;
wire efu_niu_fclrz;
wire efu_niu_fdi;
wire esr_stciq;
wire niu_efu_fdo;
wire tcu_sbs_bsinitclk;
wire tcu_srd_atpgse;
wire [2:0] tcu_srd_atpgmode;
wire esr_atpgd;
wire esr_atpgq;
wire db0_scan_out;
wire cmp_gclk_c3_mio;
wire cmp_gclk_c2_mio_left;
wire cmp_gclk_c2_mio_right;
wire cmp_gclk_c1_mio;
wire gl_mio_clk_stop_c3t;
wire gl_mio_clk_stop_c2t;
wire gl_mio_clk_stop_c1t;
wire gl_io2x_sync_en_c3t0;
wire gl_io2x_sync_en_c2t;
wire gl_mio_io2x_sync_en_c1t;
wire gl_io_out_c3t;
wire pcmb0_mio_ro_in;
wire mio_tcu_tms;
wire mio_tcu_tdi;
wire mio_tcu_trst_l;
wire mio_tcu_tck;
wire mio_tcu_testmode;
wire mio_psr_testclkt;
wire mio_psr_testclkr;
wire [2:0] mio_spc_pwr_throttle_0;
wire [2:0] mio_spc_pwr_throttle_1;
wire mio_pcmb0_sel59;
wire mio_pcmb1_sel60;
wire mio_pcma_sel61;
wire mio_pcm_burnin;
wire mio_efu_prgm_en;
wire mio_scan_out;
wire db1_scan_out;
wire [7:0] dmu_mio_debug_bus_a;
wire [7:0] dmu_mio_debug_bus_b;
wire cmp_gclk_c3_db0;
wire gl_db0_clk_stop;
wire gl_io_out_c3b0;
wire gl_io2x_sync_en_c3t;
wire gl_io_cmp_sync_en_c3b;
wire tcu_aclk;
wire tcu_bclk;
wire tcu_scan_en;
wire dmu_ncu_wrack_vld;
wire [3:0] dmu_ncu_wrack_tag;
wire [31:0] dmu_ncu_data;
wire dmu_ncu_vld;
wire dmu_ncu_stall;
wire dmu_sii_hdr_vld;
wire dmu_sii_reqbypass;
wire dmu_sii_datareq;
wire dmu_sii_datareq16;
wire [127:0] dmu_sii_data;
wire [15:0] dmu_sii_be;
wire l2t0_dbg0_sii_iq_dequeue;
wire l2t2_dbg0_sii_iq_dequeue;
wire l2t0_dbg0_sii_wib_dequeue;
wire l2t2_dbg0_sii_wib_dequeue;
wire l2t0_dbg0_err_event;
wire l2t2_dbg0_err_event;
wire l2t0_dbg0_pa_match;
wire l2t2_dbg0_pa_match;
wire [5:0] l2t0_dbg0_xbar_vcid;
wire [5:0] l2t2_dbg0_xbar_vcid;
wire l2b0_dbg0_sio_ctag_vld;
wire l2b1_dbg0_sio_ctag_vld;
wire l2b2_dbg0_sio_ctag_vld;
wire l2b3_dbg0_sio_ctag_vld;
wire l2b0_dbg0_sio_ack_type;
wire l2b1_dbg0_sio_ack_type;
wire l2b2_dbg0_sio_ack_type;
wire l2b3_dbg0_sio_ack_type;
wire l2b0_dbg0_sio_ack_dest;
wire l2b1_dbg0_sio_ack_dest;
wire l2b2_dbg0_sio_ack_dest;
wire l2b3_dbg0_sio_ack_dest;
wire [1:0] spc0_dbg0_instr_cmt_grp0;
wire [1:0] spc0_dbg0_instr_cmt_grp1;
wire [1:0] spc2_dbg0_instr_cmt_grp0;
wire [1:0] spc2_dbg0_instr_cmt_grp1;
wire [165:0] dbg0_dbg1_debug_data;
wire dbg0_dbg1_l2t0_sii_iq_dequeue;
wire dbg0_dbg1_l2t2_sii_iq_dequeue;
wire dbg0_dbg1_l2t0_sii_wib_dequeue;
wire dbg0_dbg1_l2t2_sii_wib_dequeue;
wire dbg0_dbg1_l2t0_err_event;
wire dbg0_dbg1_l2t2_err_event;
wire dbg0_dbg1_l2t0_pa_match;
wire dbg0_dbg1_l2t2_pa_match;
wire [5:0] dbg0_dbg1_l2t0_xbar_vcid;
wire [5:0] dbg0_dbg1_l2t2_xbar_vcid;
wire dbg0_dbg1_l2b0_sio_ctag_vld;
wire dbg0_dbg1_l2b1_sio_ctag_vld;
wire dbg0_dbg1_l2b2_sio_ctag_vld;
wire dbg0_dbg1_l2b3_sio_ctag_vld;
wire dbg0_dbg1_l2b0_sio_ack_type;
wire dbg0_dbg1_l2b1_sio_ack_type;
wire dbg0_dbg1_l2b2_sio_ack_type;
wire dbg0_dbg1_l2b3_sio_ack_type;
wire dbg0_dbg1_l2b0_sio_ack_dest;
wire dbg0_dbg1_l2b1_sio_ack_dest;
wire dbg0_dbg1_l2b2_sio_ack_dest;
wire dbg0_dbg1_l2b3_sio_ack_dest;
wire [1:0] dbg0_dbg1_spc0_instr_cmt_grp0;
wire [1:0] dbg0_dbg1_spc0_instr_cmt_grp1;
wire [1:0] dbg0_dbg1_spc2_instr_cmt_grp0;
wire [1:0] dbg0_dbg1_spc2_instr_cmt_grp1;
wire [7:0] dbg0_mio_debug_bus_a;
wire [7:0] dbg0_mio_debug_bus_b;
wire tcu_soc6_scan_out;
wire dmu_dbg_err_event;
wire cmp_gclk_c1_db1;
wire gl_db1_clk_stop;
wire gl_io_out_c1m;
wire gl_io2x_sync_en_c1m;
wire gl_io_cmp_sync_en_c1m;
wire gl_cmp_io_sync_en_c1m;
wire rst_wmr_protect;
wire ccu_dbg1_serdes_dtm;
wire l2t1_dbg1_sii_iq_dequeue;
wire l2t3_dbg1_sii_iq_dequeue;
wire l2t4_dbg1_sii_iq_dequeue;
wire l2t5_dbg1_sii_iq_dequeue;
wire l2t6_dbg1_sii_iq_dequeue;
wire l2t7_dbg1_sii_iq_dequeue;
wire l2t1_dbg1_sii_wib_dequeue;
wire l2t3_dbg1_sii_wib_dequeue;
wire l2t4_dbg1_sii_wib_dequeue;
wire l2t5_dbg1_sii_wib_dequeue;
wire l2t6_dbg1_sii_wib_dequeue;
wire l2t7_dbg1_sii_wib_dequeue;
wire l2t1_dbg1_err_event;
wire l2t3_dbg1_err_event;
wire l2t4_dbg1_err_event;
wire l2t6_dbg1_err_event;
wire l2t7_dbg1_err_event;
wire l2t1_dbg1_pa_match;
wire l2t3_dbg1_pa_match;
wire l2t4_dbg1_pa_match;
wire l2t5_dbg1_pa_match;
wire l2t6_dbg1_pa_match;
wire l2t7_dbg1_pa_match;
wire [5:0] l2t1_dbg1_xbar_vcid;
wire [5:0] l2t3_dbg1_xbar_vcid;
wire [5:0] l2t4_dbg1_xbar_vcid;
wire [5:0] l2t5_dbg1_xbar_vcid;
wire [5:0] l2t6_dbg1_xbar_vcid;
wire [5:0] l2t7_dbg1_xbar_vcid;
wire l2b4_dbg1_sio_ctag_vld;
wire l2b5_dbg1_sio_ctag_vld;
wire l2b6_dbg1_sio_ctag_vld;
wire l2b7_dbg1_sio_ctag_vld;
wire l2b4_dbg1_sio_ack_type;
wire l2b5_dbg1_sio_ack_type;
wire l2b6_dbg1_sio_ack_type;
wire l2b7_dbg1_sio_ack_type;
wire l2b4_dbg1_sio_ack_dest;
wire l2b5_dbg1_sio_ack_dest;
wire l2b6_dbg1_sio_ack_dest;
wire l2b7_dbg1_sio_ack_dest;
wire [1:0] spc1_dbg1_instr_cmt_grp0;
wire [1:0] spc1_dbg1_instr_cmt_grp1;
wire [1:0] spc3_dbg1_instr_cmt_grp0;
wire [1:0] spc3_dbg1_instr_cmt_grp1;
wire [1:0] spc4_dbg1_instr_cmt_grp0;
wire [1:0] spc4_dbg1_instr_cmt_grp1;
wire [1:0] spc5_dbg1_instr_cmt_grp0;
wire [1:0] spc5_dbg1_instr_cmt_grp1;
wire [1:0] spc6_dbg1_instr_cmt_grp0;
wire [1:0] spc6_dbg1_instr_cmt_grp1;
wire [1:0] spc7_dbg1_instr_cmt_grp0;
wire [1:0] spc7_dbg1_instr_cmt_grp1;
wire mcu0_dbg1_crc21;
wire [3:0] mcu0_dbg1_rd_req_in_0;
wire [3:0] mcu0_dbg1_rd_req_in_1;
wire [4:0] mcu0_dbg1_rd_req_out;
wire mcu0_dbg1_wr_req_in_0;
wire mcu0_dbg1_wr_req_in_1;
wire [1:0] mcu0_dbg1_wr_req_out;
wire mcu0_dbg1_mecc_err;
wire mcu0_dbg1_secc_err;
wire mcu0_dbg1_fbd_err;
wire mcu0_dbg1_err_mode;
wire mcu0_dbg1_err_event;
wire mcu1_dbg1_crc21;
wire [3:0] mcu1_dbg1_rd_req_in_0;
wire [3:0] mcu1_dbg1_rd_req_in_1;
wire [4:0] mcu1_dbg1_rd_req_out;
wire mcu1_dbg1_wr_req_in_0;
wire mcu1_dbg1_wr_req_in_1;
wire [1:0] mcu1_dbg1_wr_req_out;
wire mcu1_dbg1_mecc_err;
wire mcu1_dbg1_secc_err;
wire mcu1_dbg1_fbd_err;
wire mcu1_dbg1_err_mode;
wire mcu1_dbg1_err_event;
wire mcu2_dbg1_crc21;
wire [3:0] mcu2_dbg1_rd_req_in_0;
wire [3:0] mcu2_dbg1_rd_req_in_1;
wire [4:0] mcu2_dbg1_rd_req_out;
wire mcu2_dbg1_wr_req_in_0;
wire mcu2_dbg1_wr_req_in_1;
wire [1:0] mcu2_dbg1_wr_req_out;
wire mcu2_dbg1_mecc_err;
wire mcu2_dbg1_secc_err;
wire mcu2_dbg1_fbd_err;
wire mcu2_dbg1_err_mode;
wire mcu2_dbg1_err_event;
wire mcu3_dbg1_crc21;
wire [3:0] mcu3_dbg1_rd_req_in_0;
wire [3:0] mcu3_dbg1_rd_req_in_1;
wire [4:0] mcu3_dbg1_rd_req_out;
wire mcu3_dbg1_wr_req_in_0;
wire mcu3_dbg1_wr_req_in_1;
wire [1:0] mcu3_dbg1_wr_req_out;
wire mcu3_dbg1_mecc_err;
wire mcu3_dbg1_secc_err;
wire mcu3_dbg1_fbd_err;
wire mcu3_dbg1_err_mode;
wire mcu3_dbg1_err_event;
wire dbg1_dmu_stall;
wire dmu_dbg1_stall_ack;
wire dbg1_dmu_resume;
wire [1:0] sii_dbg1_l2t0_req_ccxrff;
wire [1:0] sii_dbg1_l2t1_req_ccxrff;
wire [1:0] sii_dbg1_l2t2_req_ccxrff;
wire [1:0] sii_dbg1_l2t3_req_ccxrff;
wire [1:0] sii_dbg1_l2t4_req_ccxrff;
wire [1:0] sii_dbg1_l2t5_req_ccxrff;
wire [1:0] sii_dbg1_l2t6_req_ccxrff;
wire [1:0] sii_dbg1_l2t7_req_ccxrff;
wire ncu_dbg1_error_event;
wire ncu_dbg1_stall;
wire ncu_dbg1_vld;
wire [3:0] ncu_dbg1_data;
wire dbg1_ncu_stall;
wire dbg1_ncu_vld;
wire [3:0] dbg1_ncu_data;
wire dbg1_tcu_soc_hard_stop;
wire dbg1_tcu_soc_asrt_trigout;
wire tcu_mio_jtag_membist_mode;
wire mio_pll_testmode;
wire [165:0] dbg1_mio_dbg_dq;
wire dbg1_mio_drv_en_op_only;
wire dbg1_mio_drv_en_muxtest_op;
wire dbg1_mio_drv_en_muxbist_op;
wire dbg1_mio_drv_en_muxtest_inp;
wire dbg1_mio_drv_en_muxtestpll_inp;
wire dbg1_mio_sel_niu_debug_mode;
wire dbg1_mio_sel_pcix_debug_mode;
wire dbg1_mio_sel_soc_obs_mode;
wire [1:0] dbg1_mio_drv_imped;
wire dbg0_dbg1_l2b0_sio_ack_dest_ccxlff;
wire dbg0_dbg1_l2b0_sio_ack_type_ccxlff;
wire dbg0_dbg1_l2b0_sio_ctag_vld_ccxlff;
wire dbg0_dbg1_l2b1_sio_ack_dest_ccxlff;
wire dbg0_dbg1_l2b1_sio_ack_type_ccxlff;
wire dbg0_dbg1_l2b1_sio_ctag_vld_ccxlff;
wire dbg0_dbg1_l2b2_sio_ack_dest_ccxlff;
wire dbg0_dbg1_l2b2_sio_ack_type_ccxlff;
wire dbg0_dbg1_l2b2_sio_ctag_vld_ccxlff;
wire dbg0_dbg1_l2b3_sio_ack_dest_ccxlff;
wire dbg0_dbg1_l2b3_sio_ack_type_ccxlff;
wire dbg0_dbg1_l2b3_sio_ctag_vld_ccxlff;
wire dbg0_dbg1_l2t0_err_event_ccxlff;
wire dbg0_dbg1_l2t0_pa_match_ccxlff;
wire dbg0_dbg1_l2t0_sii_iq_dequeue_ccxlff;
wire dbg0_dbg1_l2t0_sii_wib_dequeue_ccxlff;
wire [5:0] dbg0_dbg1_l2t0_xbar_vcid_ccxlff;
wire dbg0_dbg1_l2t2_err_event_ccxlff;
wire dbg0_dbg1_l2t2_pa_match_ccxlff;
wire dbg0_dbg1_l2t2_sii_iq_dequeue_ccxlff;
wire dbg0_dbg1_l2t2_sii_wib_dequeue_ccxlff;
wire [5:0] dbg0_dbg1_l2t2_xbar_vcid_ccxlff;
wire dbg0_dbg1_spc0_instr_cmt_grp0_ccxlff_1;
wire dbg0_dbg1_spc0_instr_cmt_grp0_ccxlff_0;
wire dbg0_dbg1_spc0_instr_cmt_grp1_ccxlff_1;
wire dbg0_dbg1_spc0_instr_cmt_grp1_ccxlff_0;
wire dbg0_dbg1_spc2_instr_cmt_grp0_ccxlff_1;
wire dbg0_dbg1_spc2_instr_cmt_grp0_ccxlff_0;
wire dbg0_dbg1_spc2_instr_cmt_grp1_ccxlff_1;
wire dbg0_dbg1_spc2_instr_cmt_grp1_ccxlff_0;
wire cmp_gclk_c3_spc0;
wire gl_spc0_clk_stop;
wire [145:0] cpx_spc0_data_cx2;
wire [8:0] pcx_spc0_grant_px;
wire [8:0] spc0_pcx_req_pq;
wire [8:0] spc0_pcx_atm_pq;
wire [129:0] spc0_pcx_data_pa;
wire spc0_hardstop_request;
wire spc0_softstop_request;
wire spc0_trigger_pulse;
wire [7:0] tcu_ss_mode;
wire [7:0] tcu_do_mode;
wire tcu_ss_request_t1lff_0;
wire spc0_ss_complete;
wire tcu_spc0_aclk;
wire tcu_spc0_bclk;
wire tcu_spc0_scan_en;
wire tcu_spc0_se_scancollar_in;
wire tcu_spc0_se_scancollar_out;
wire tcu_spc0_array_wr_inhibit;
wire [7:0] ncu_spc0_core_running;
wire [7:0] spc0_ncu_core_running_status;
wire [1:0] spc0_tcu_scan_in;
wire [1:0] tcu_spc0_scan_out;
wire tcu_spc0_mbist_start_t1lff_0;
wire spc0_tcu_mbist_done;
wire spc0_tcu_mbist_fail;
wire tcu_spc0_mbist_scan_in;
wire spc0_tcu_mbist_scan_out;
wire [35:0] spc0_dmo_dout;
wire [7:0] tcu_spc_lbist_start;
wire [7:0] tcu_spc_lbist_scan_in;
wire spc0_tcu_lbist_done;
wire spc0_tcu_lbist_scan_out;
wire tcu_spc_shscan_pce_ov;
wire tcu_spc_shscan_aclk;
wire tcu_spc_shscan_bclk;
wire tcu_spc_shscan_scan_en;
wire [2:0] tcu_spc_shscanid;
wire tcu_spc0_shscan_scan_out;
wire spc0_tcu_shscan_scan_in;
wire tcu_spc0_shscan_clk_stop;
wire efu_spc0246_fuse_data;
wire efu_spc0_fuse_ixfer_en;
wire efu_spc0_fuse_iclr;
wire efu_spc0_fuse_dxfer_en;
wire efu_spc0_fuse_dclr;
wire spc0_efu_fuse_dxfer_en;
wire spc0_efu_fuse_ixfer_en;
wire spc0_efu_fuse_ddata;
wire spc0_efu_fuse_idata;
wire gl_io_cmp_sync_en_c3t0;
wire gl_cmp_io_sync_en_c3t0;
wire [3:0] spc_revid_out;
wire tcu_dectest;
wire tcu_muxtest;
wire ncu_cmp_tick_enable;
wire ncu_wmr_vec_mask;
wire ncu_spc_pm;
wire ncu_spc_ba01;
wire ncu_spc_ba23;
wire ncu_spc_ba45;
wire ncu_spc_ba67;
wire tcu_spc_lbist_pgm;
wire tcu_spc0_test_mode;
wire dmo_icmuxctl;
wire dmo_dcmuxctl;
wire cmp_gclk_c2_spc1;
wire gl_spc1_clk_stop;
wire [145:0] cpx_spc1_data_cx2;
wire [8:0] pcx_spc1_grant_px;
wire [8:0] spc1_pcx_req_pq;
wire [8:0] spc1_pcx_atm_pq;
wire [129:0] spc1_pcx_data_pa;
wire spc1_hardstop_request;
wire spc1_softstop_request;
wire spc1_trigger_pulse;
wire [7:0] tcu_ss_request;
wire spc1_ss_complete;
wire tcu_spc1_aclk;
wire tcu_spc1_bclk;
wire tcu_spc1_scan_en;
wire tcu_spc1_se_scancollar_in;
wire tcu_spc1_se_scancollar_out;
wire tcu_spc1_array_wr_inhibit;
wire [7:0] ncu_spc1_core_running;
wire [7:0] spc1_ncu_core_running_status;
wire [1:0] spc1_tcu_scan_in;
wire [1:0] tcu_spc1_scan_out;
wire [7:0] tcu_spc_mbist_start;
wire spc1_tcu_mbist_done;
wire spc1_tcu_mbist_fail;
wire tcu_spc1_mbist_scan_in;
wire spc1_tcu_mbist_scan_out;
wire [35:0] spc1_dmo_dout;
wire [5:0] dmo_coresel;
wire spc1_tcu_lbist_done;
wire spc1_tcu_lbist_scan_out;
wire tcu_spc1_shscan_scan_out;
wire spc1_tcu_shscan_scan_in;
wire tcu_spc1_shscan_clk_stop;
wire efu_spc1357_fuse_data;
wire efu_spc1_fuse_ixfer_en;
wire efu_spc1_fuse_iclr;
wire efu_spc1_fuse_dxfer_en;
wire efu_spc1_fuse_dclr;
wire spc1_efu_fuse_dxfer_en;
wire spc1_efu_fuse_ixfer_en;
wire spc1_efu_fuse_ddata;
wire spc1_efu_fuse_idata;
wire gl_io_cmp_sync_en_c2t;
wire gl_cmp_io_sync_en_c2t;
wire tcu_spc1_test_mode;
wire cmp_gclk_c3_spc2;
wire gl_spc2_clk_stop;
wire [145:0] cpx_spc2_data_cx2;
wire [8:0] pcx_spc2_grant_px;
wire [8:0] spc2_pcx_req_pq;
wire [8:0] spc2_pcx_atm_pq;
wire [129:0] spc2_pcx_data_pa;
wire spc2_hardstop_request;
wire spc2_softstop_request;
wire spc2_trigger_pulse;
wire tcu_ss_request_t3lff_2;
wire spc2_ss_complete;
wire tcu_spc2_aclk;
wire tcu_spc2_bclk;
wire tcu_spc2_scan_en;
wire tcu_spc2_se_scancollar_in;
wire tcu_spc2_se_scancollar_out;
wire tcu_spc2_array_wr_inhibit;
wire [7:0] ncu_spc2_core_running;
wire [7:0] spc2_ncu_core_running_status;
wire [1:0] spc2_tcu_scan_in;
wire [1:0] tcu_spc2_scan_out;
wire tcu_spc_mbist_start_t3lff_2;
wire spc2_tcu_mbist_done;
wire spc2_tcu_mbist_fail;
wire tcu_spc2_mbist_scan_in;
wire spc2_tcu_mbist_scan_out;
wire [35:0] spc2_dmo_dout;
wire spc2_tcu_lbist_done;
wire spc2_tcu_lbist_scan_out;
wire tcu_spc2_shscan_scan_out;
wire spc2_tcu_shscan_scan_in;
wire tcu_spc2_shscan_clk_stop;
wire efu_spc2_fuse_ixfer_en;
wire efu_spc2_fuse_iclr;
wire efu_spc2_fuse_dxfer_en;
wire efu_spc2_fuse_dclr;
wire spc2_efu_fuse_dxfer_en;
wire spc2_efu_fuse_ixfer_en;
wire spc2_efu_fuse_ddata;
wire spc2_efu_fuse_idata;
wire gl_cmp_io_sync_en_c3b;
wire tcu_spc2_test_mode;
wire cmp_gclk_c2_spc3;
wire gl_spc3_clk_stop;
wire [145:0] cpx_spc3_data_cx2;
wire [8:0] pcx_spc3_grant_px;
wire [8:0] spc3_pcx_req_pq;
wire [8:0] spc3_pcx_atm_pq;
wire [129:0] spc3_pcx_data_pa;
wire spc3_hardstop_request;
wire spc3_softstop_request;
wire spc3_trigger_pulse;
wire spc3_ss_complete;
wire tcu_spc3_aclk;
wire tcu_spc3_bclk;
wire tcu_spc3_scan_en;
wire tcu_spc3_se_scancollar_in;
wire tcu_spc3_se_scancollar_out;
wire tcu_spc3_array_wr_inhibit;
wire [7:0] ncu_spc3_core_running;
wire [7:0] spc3_ncu_core_running_status;
wire [1:0] spc3_tcu_scan_in;
wire [1:0] tcu_spc3_scan_out;
wire spc3_tcu_mbist_done;
wire spc3_tcu_mbist_fail;
wire tcu_spc3_mbist_scan_in;
wire spc3_tcu_mbist_scan_out;
wire [35:0] spc3_dmo_dout;
wire spc3_tcu_lbist_done;
wire spc3_tcu_lbist_scan_out;
wire tcu_spc3_shscan_scan_out;
wire spc3_tcu_shscan_scan_in;
wire tcu_spc3_shscan_clk_stop;
wire efu_spc3_fuse_ixfer_en;
wire efu_spc3_fuse_iclr;
wire efu_spc3_fuse_dxfer_en;
wire efu_spc3_fuse_dclr;
wire spc3_efu_fuse_dxfer_en;
wire spc3_efu_fuse_ixfer_en;
wire spc3_efu_fuse_ddata;
wire spc3_efu_fuse_idata;
wire gl_io_cmp_sync_en_c2b;
wire gl_cmp_io_sync_en_c2b;
wire tcu_spc3_test_mode;
wire cmp_gclk_c1_spc4;
wire gl_spc4_clk_stop;
wire [145:0] cpx_spc4_data_cx2;
wire [8:0] pcx_spc4_grant_px;
wire [8:0] spc4_pcx_req_pq;
wire [8:0] spc4_pcx_atm_pq;
wire [129:0] spc4_pcx_data_pa;
wire spc4_hardstop_request;
wire spc4_softstop_request;
wire spc4_trigger_pulse;
wire spc4_ss_complete;
wire tcu_spc4_aclk;
wire tcu_spc4_bclk;
wire tcu_spc4_scan_en;
wire tcu_spc4_se_scancollar_in;
wire tcu_spc4_se_scancollar_out;
wire tcu_spc4_array_wr_inhibit;
wire [7:0] ncu_spc4_core_running;
wire [7:0] spc4_ncu_core_running_status;
wire [1:0] spc4_tcu_scan_in;
wire [1:0] tcu_spc4_scan_out;
wire spc4_tcu_mbist_done;
wire spc4_tcu_mbist_fail;
wire tcu_spc4_mbist_scan_in;
wire spc4_tcu_mbist_scan_out;
wire [35:0] spc5_dmo_dout;
wire [35:0] spc4_dmo_dout;
wire spc4_tcu_lbist_done;
wire spc4_tcu_lbist_scan_out;
wire tcu_spc4_shscan_scan_out;
wire spc4_tcu_shscan_scan_in;
wire tcu_spc4_shscan_clk_stop;
wire efu_spc4_fuse_ixfer_en;
wire efu_spc4_fuse_iclr;
wire efu_spc4_fuse_dxfer_en;
wire efu_spc4_fuse_dclr;
wire spc4_efu_fuse_dxfer_en;
wire spc4_efu_fuse_ixfer_en;
wire spc4_efu_fuse_ddata;
wire spc4_efu_fuse_idata;
wire gl_io_cmp_sync_en_c1t;
wire gl_cmp_io_sync_en_c1t;
wire tcu_spc4_test_mode;
wire cmp_gclk_c2_spc5;
wire gl_spc5_clk_stop;
wire [145:0] cpx_spc5_data_cx2;
wire [8:0] pcx_spc5_grant_px;
wire [8:0] spc5_pcx_req_pq;
wire [8:0] spc5_pcx_atm_pq;
wire [129:0] spc5_pcx_data_pa;
wire spc5_hardstop_request;
wire spc5_softstop_request;
wire spc5_trigger_pulse;
wire spc5_ss_complete;
wire tcu_spc5_aclk;
wire tcu_spc5_bclk;
wire tcu_spc5_scan_en;
wire tcu_spc5_se_scancollar_in;
wire tcu_spc5_se_scancollar_out;
wire tcu_spc5_array_wr_inhibit;
wire [7:0] ncu_spc5_core_running;
wire [7:0] spc5_ncu_core_running_status;
wire [1:0] spc5_tcu_scan_in;
wire [1:0] tcu_spc5_scan_out;
wire spc5_tcu_mbist_done;
wire spc5_tcu_mbist_fail;
wire tcu_spc5_mbist_scan_in;
wire spc5_tcu_mbist_scan_out;
wire spc5_tcu_lbist_done;
wire spc5_tcu_lbist_scan_out;
wire tcu_spc5_shscan_scan_out;
wire spc5_tcu_shscan_scan_in;
wire tcu_spc5_shscan_clk_stop;
wire efu_spc5_fuse_ixfer_en;
wire efu_spc5_fuse_iclr;
wire efu_spc5_fuse_dxfer_en;
wire efu_spc5_fuse_dclr;
wire spc5_efu_fuse_dxfer_en;
wire spc5_efu_fuse_ixfer_en;
wire spc5_efu_fuse_ddata;
wire spc5_efu_fuse_idata;
wire tcu_spc5_test_mode;
wire cmp_gclk_c1_spc6;
wire gl_spc6_clk_stop;
wire [145:0] cpx_spc6_data_cx2;
wire [8:0] pcx_spc6_grant_px;
wire [8:0] spc6_pcx_req_pq;
wire [8:0] spc6_pcx_atm_pq;
wire [129:0] spc6_pcx_data_pa;
wire spc6_hardstop_request;
wire spc6_softstop_request;
wire spc6_trigger_pulse;
wire spc6_ss_complete;
wire tcu_spc6_aclk;
wire tcu_spc6_bclk;
wire tcu_spc6_scan_en;
wire tcu_spc6_se_scancollar_in;
wire tcu_spc6_se_scancollar_out;
wire tcu_spc6_array_wr_inhibit;
wire [7:0] ncu_spc6_core_running;
wire [7:0] spc6_ncu_core_running_status;
wire [1:0] spc6_tcu_scan_in;
wire [1:0] tcu_spc6_scan_out;
wire spc6_tcu_mbist_done;
wire spc6_tcu_mbist_fail;
wire tcu_spc6_mbist_scan_in;
wire spc6_tcu_mbist_scan_out;
wire [35:0] spc7_dmo_dout;
wire [35:0] spc6_dmo_dout;
wire spc6_tcu_lbist_done;
wire spc6_tcu_lbist_scan_out;
wire tcu_spc6_shscan_scan_out;
wire spc6_tcu_shscan_scan_in;
wire tcu_spc6_shscan_clk_stop;
wire efu_spc6_fuse_ixfer_en;
wire efu_spc6_fuse_iclr;
wire efu_spc6_fuse_dxfer_en;
wire efu_spc6_fuse_dclr;
wire spc6_efu_fuse_dxfer_en;
wire spc6_efu_fuse_ixfer_en;
wire spc6_efu_fuse_ddata;
wire spc6_efu_fuse_idata;
wire gl_io_cmp_sync_en_c1b;
wire gl_cmp_io_sync_en_c1b;
wire tcu_spc6_test_mode;
wire cmp_gclk_c2_spc7;
wire gl_spc7_clk_stop;
wire [145:0] cpx_spc7_data_cx2;
wire [8:0] pcx_spc7_grant_px;
wire [8:0] spc7_pcx_req_pq;
wire [8:0] spc7_pcx_atm_pq;
wire [129:0] spc7_pcx_data_pa;
wire spc7_hardstop_request;
wire spc7_softstop_request;
wire spc7_trigger_pulse;
wire spc7_ss_complete;
wire tcu_spc7_aclk;
wire tcu_spc7_bclk;
wire tcu_spc7_scan_en;
wire tcu_spc7_se_scancollar_in;
wire tcu_spc7_se_scancollar_out;
wire tcu_spc7_array_wr_inhibit;
wire [7:0] ncu_spc7_core_running;
wire [7:0] spc7_ncu_core_running_status;
wire [1:0] spc7_tcu_scan_in;
wire [1:0] tcu_spc7_scan_out;
wire spc7_tcu_mbist_done;
wire spc7_tcu_mbist_fail;
wire tcu_spc7_mbist_scan_in;
wire spc7_tcu_mbist_scan_out;
wire spc7_tcu_lbist_done;
wire spc7_tcu_lbist_scan_out;
wire tcu_spc7_shscan_scan_out;
wire spc7_tcu_shscan_scan_in;
wire tcu_spc7_shscan_clk_stop;
wire efu_spc7_fuse_ixfer_en;
wire efu_spc7_fuse_iclr;
wire efu_spc7_fuse_dxfer_en;
wire efu_spc7_fuse_dclr;
wire spc7_efu_fuse_dxfer_en;
wire spc7_efu_fuse_ixfer_en;
wire spc7_efu_fuse_ddata;
wire spc7_efu_fuse_idata;
wire tcu_spc7_test_mode;
wire gl_ccx_clk_stop;
wire [1:0] tcu_ccx_scan_out;
wire [1:0] ccx_scan_out;
wire [7:0] ncu_cpx_req_cq;
wire [7:0] cpx_ncu_grant_cx;
wire [145:0] ncu_cpx_data_ca;
wire ncu_pcx_stall_pq;
wire [129:0] pcx_ncu_data_px2;
wire [145:0] sctag0_cpx_data_ca;
wire [145:0] sctag1_cpx_data_ca;
wire [145:0] sctag2_cpx_data_ca;
wire [145:0] sctag3_cpx_data_ca;
wire [145:0] sctag4_cpx_data_ca;
wire [145:0] sctag5_cpx_data_ca;
wire [145:0] sctag6_cpx_data_ca;
wire [145:0] sctag7_cpx_data_ca;
wire pcx_ncu_data_rdy_px1;
wire [31:0] l2b1_sio_data;
wire [1:0] l2b1_sio_parity;
wire l2b1_sio_ctag_vld;
wire l2b1_sio_ue_err;
wire [31:0] l2b2_sio_data;
wire [1:0] l2b2_sio_parity;
wire l2b2_sio_ctag_vld;
wire l2b2_sio_ue_err;
wire [31:0] l2b3_sio_data;
wire [1:0] l2b3_sio_parity;
wire l2b3_sio_ctag_vld;
wire l2b3_sio_ue_err;
wire l2b0_tcu_mbist_done;
wire l2b0_tcu_mbist_fail;
wire tcu_l2b0_mbist_start;
wire l2b1_tcu_mbist_done;
wire l2b1_tcu_mbist_fail;
wire tcu_l2b1_mbist_start;
wire l2b2_tcu_mbist_done;
wire l2b2_tcu_mbist_fail;
wire tcu_l2b2_mbist_start;
wire l2b3_tcu_mbist_done;
wire l2b3_tcu_mbist_fail;
wire tcu_l2b3_mbist_start;
wire [31:0] l2b1_sio_data_ccxlff;
wire [1:0] l2b1_sio_parity_ccxlff;
wire l2b1_sio_ctag_vld_ccxlff;
wire l2b1_sio_ue_err_ccxlff;
wire [31:0] l2b2_sio_data_ccxlff;
wire [1:0] l2b2_sio_parity_ccxlff;
wire l2b2_sio_ctag_vld_ccxlff;
wire l2b2_sio_ue_err_ccxlff;
wire [31:0] l2b3_sio_data_ccxlff;
wire [1:0] l2b3_sio_parity_ccxlff;
wire l2b3_sio_ctag_vld_ccxlff;
wire l2b3_sio_ue_err_ccxlff;
wire l2b0_tcu_mbist_done_ccxlff;
wire l2b0_tcu_mbist_fail_ccxlff;
wire tcu_l2b0_mbist_start_ccxlff;
wire l2b1_tcu_mbist_done_ccxlff;
wire l2b1_tcu_mbist_fail_ccxlff;
wire tcu_l2b1_mbist_start_ccxlff;
wire l2b2_tcu_mbist_done_ccxlff;
wire l2b2_tcu_mbist_fail_ccxlff;
wire tcu_l2b2_mbist_start_ccxlff;
wire l2b3_tcu_mbist_done_ccxlff;
wire l2b3_tcu_mbist_fail_ccxlff;
wire tcu_l2b3_mbist_start_ccxlff;
wire [6:0] sii_l2b5_ecc;
wire [1:0] sii_dbg1_l2t0_req;
wire [1:0] sii_dbg1_l2t1_req;
wire [1:0] sii_dbg1_l2t2_req;
wire [1:0] sii_dbg1_l2t3_req;
wire [1:0] sii_dbg1_l2t4_req;
wire [1:0] sii_dbg1_l2t5_req;
wire [1:0] sii_dbg1_l2t6_req;
wire [1:0] sii_dbg1_l2t7_req;
wire [1:0] sii_tcu_mbist_done;
wire [1:0] sii_tcu_mbist_fail;
wire [1:0] tcu_sii_mbist_start;
wire tcu_sii_data;
wire tcu_sii_vld;
wire [6:0] sii_l2b6_ecc;
wire [6:0] sii_l2b7_ecc;
wire [159:2] ccx_rstg_out_unconnected;
wire [6:0] sii_l2b5_ecc_ccxrff;
wire sii_tcu_mbist_done_ccxrff_1;
wire sii_tcu_mbist_done_ccxrff_0;
wire sii_tcu_mbist_fail_ccxrff_1;
wire sii_tcu_mbist_fail_ccxrff_0;
wire tcu_sii_mbist_start_ccxrff_1;
wire tcu_sii_mbist_start_ccxrff_0;
wire tcu_sii_data_ccxrff;
wire tcu_sii_vld_ccxrff;
wire [6:0] sii_l2b6_ecc_ccxrff;
wire [6:0] sii_l2b7_ecc_ccxrff;
wire [191:0] cpu_rep0_out_unconnected;
wire [191:0] cpu_rep1_out_unconnected;
wire cmp_gclk_c3_l2d0;
wire gl_l2d0_clk_stop;
wire [15:0] l2t0_l2d0_way_sel_c2;
wire [3:0] l2t0_l2d0_col_offset_c2;
wire l2t0_l2d0_fb_hit_c3;
wire l2t0_l2d0_fbrd_c3;
wire l2t0_l2d0_rd_wr_c2;
wire [8:0] l2t0_l2d0_set_c2;
wire [15:0] l2t0_l2d0_word_en_c2;
wire [77:0] l2t0_l2d0_stdecc_c2;
wire [623:0] l2b0_l2d0_fbdecc_c4;
wire gl_l2_por_c3t0;
wire gl_l2_wmr_c3t0;
wire tcu_se_scancollar_in;
wire tcu_se_scancollar_out;
wire tcu_array_wr_inhibit;
wire l2t1_scan_out;
wire [9:0] l2b0_l2d0_rvalue;
wire [6:0] l2b0_l2d0_rid;
wire l2b0_l2d0_wr_en;
wire l2b0_l2d0_fuse_clr;
wire [9:0] l2d0_l2b0_fuse_data;
wire l2d0_scan_out;
wire [623:0] l2d0_l2b0_decc_out_c7;
wire [155:0] l2d0_l2t0_decc_c6;
wire cmp_gclk_c3_l2d1;
wire gl_l2d1_clk_stop;
wire l2d1_scan_out;
wire [623:0] l2b1_l2d1_fbdecc_c4;
wire gl_l2_por_c3t;
wire gl_l2_wmr_c3t;
wire [3:0] l2t1_l2d1_col_offset_c2;
wire l2t1_l2d1_fb_hit_c3;
wire l2t1_l2d1_fbrd_c3;
wire l2t1_l2d1_rd_wr_c2;
wire [8:0] l2t1_l2d1_set_c2;
wire [77:0] l2t1_l2d1_stdecc_c2;
wire [15:0] l2t1_l2d1_way_sel_c2;
wire [15:0] l2t1_l2d1_word_en_c2;
wire [9:0] l2b1_l2d1_rvalue;
wire [6:0] l2b1_l2d1_rid;
wire l2b1_l2d1_wr_en;
wire l2b1_l2d1_fuse_clr;
wire [9:0] l2d1_l2b1_fuse_data;
wire [623:0] l2d1_l2b1_decc_out_c7;
wire [155:0] l2d1_l2t1_decc_c6;
wire cmp_gclk_c3_l2d2;
wire gl_l2d2_clk_stop;
wire l2t3_scan_out;
wire l2d2_scan_out;
wire [623:0] l2b2_l2d2_fbdecc_c4;
wire gl_l2_por_c3b0;
wire gl_l2_wmr_c3b;
wire [3:0] l2t2_l2d2_col_offset_c2;
wire l2t2_l2d2_fb_hit_c3;
wire l2t2_l2d2_fbrd_c3;
wire l2t2_l2d2_rd_wr_c2;
wire [8:0] l2t2_l2d2_set_c2;
wire [77:0] l2t2_l2d2_stdecc_c2;
wire [15:0] l2t2_l2d2_way_sel_c2;
wire [15:0] l2t2_l2d2_word_en_c2;
wire [623:0] l2d2_l2b2_decc_out_c7;
wire [155:0] l2d2_l2t2_decc_c6;
wire [9:0] l2b2_l2d2_rvalue;
wire [6:0] l2b2_l2d2_rid;
wire l2b2_l2d2_wr_en;
wire l2b2_l2d2_fuse_clr;
wire [9:0] l2d2_l2b2_fuse_data;
wire cmp_gclk_c3_l2d3;
wire gl_l2d3_clk_stop;
wire l2d3_scan_out;
wire [9:0] l2b3_l2d3_rvalue;
wire [6:0] l2b3_l2d3_rid;
wire l2b3_l2d3_wr_en;
wire l2b3_l2d3_fuse_clr;
wire [9:0] l2d3_l2b3_fuse_data;
wire [623:0] l2b3_l2d3_fbdecc_c4;
wire [3:0] l2t3_l2d3_col_offset_c2;
wire l2t3_l2d3_fb_hit_c3;
wire l2t3_l2d3_fbrd_c3;
wire l2t3_l2d3_rd_wr_c2;
wire [8:0] l2t3_l2d3_set_c2;
wire [77:0] l2t3_l2d3_stdecc_c2;
wire [15:0] l2t3_l2d3_way_sel_c2;
wire [15:0] l2t3_l2d3_word_en_c2;
wire [623:0] l2d3_l2b3_decc_out_c7;
wire [155:0] l2d3_l2t3_decc_c6;
wire cmp_gclk_c1_l2d4;
wire gl_l2d4_clk_stop;
wire l2t5_scan_out;
wire l2d4_scan_out;
wire [9:0] l2b4_l2d4_rvalue;
wire [6:0] l2b4_l2d4_rid;
wire l2b4_l2d4_wr_en;
wire l2b4_l2d4_fuse_clr;
wire [9:0] l2d4_l2b4_fuse_data;
wire [623:0] l2b4_l2d4_fbdecc_c4;
wire gl_l2_por_c1t;
wire gl_l2_wmr_c1t;
wire [3:0] l2t4_l2d4_col_offset_c2;
wire l2t4_l2d4_fb_hit_c3;
wire l2t4_l2d4_fbrd_c3;
wire l2t4_l2d4_rd_wr_c2;
wire [8:0] l2t4_l2d4_set_c2;
wire [77:0] l2t4_l2d4_stdecc_c2;
wire [15:0] l2t4_l2d4_way_sel_c2;
wire [15:0] l2t4_l2d4_word_en_c2;
wire [623:0] l2d4_l2b4_decc_out_c7;
wire [155:0] l2d4_l2t4_decc_c6;
wire cmp_gclk_c1_l2d5;
wire gl_l2d5_clk_stop;
wire l2d5_scan_out;
wire [623:0] l2b5_l2d5_fbdecc_c4;
wire [3:0] l2t5_l2d5_col_offset_c2;
wire l2t5_l2d5_fb_hit_c3;
wire l2t5_l2d5_fbrd_c3;
wire l2t5_l2d5_rd_wr_c2;
wire [8:0] l2t5_l2d5_set_c2;
wire [77:0] l2t5_l2d5_stdecc_c2;
wire [15:0] l2t5_l2d5_way_sel_c2;
wire [15:0] l2t5_l2d5_word_en_c2;
wire [9:0] l2b5_l2d5_rvalue;
wire [6:0] l2b5_l2d5_rid;
wire l2b5_l2d5_wr_en;
wire l2b5_l2d5_fuse_clr;
wire [9:0] l2d5_l2b5_fuse_data;
wire [623:0] l2d5_l2b5_decc_out_c7;
wire [155:0] l2d5_l2t5_decc_c6;
wire cmp_gclk_c1_l2d6;
wire gl_l2d6_clk_stop;
wire l2t7_scan_out;
wire l2d6_scan_out;
wire [9:0] l2b6_l2d6_rvalue;
wire [6:0] l2b6_l2d6_rid;
wire l2b6_l2d6_wr_en;
wire l2b6_l2d6_fuse_clr;
wire [9:0] l2d6_l2b6_fuse_data;
wire [623:0] l2b6_l2d6_fbdecc_c4;
wire gl_l2_por_c1b;
wire gl_l2_wmr_c1b;
wire [3:0] l2t6_l2d6_col_offset_c2;
wire l2t6_l2d6_fb_hit_c3;
wire l2t6_l2d6_fbrd_c3;
wire l2t6_l2d6_rd_wr_c2;
wire [8:0] l2t6_l2d6_set_c2;
wire [77:0] l2t6_l2d6_stdecc_c2;
wire [15:0] l2t6_l2d6_way_sel_c2;
wire [15:0] l2t6_l2d6_word_en_c2;
wire [623:0] l2d6_l2b6_decc_out_c7;
wire [155:0] l2d6_l2t6_decc_c6;
wire cmp_gclk_c1_l2d7;
wire gl_l2d7_clk_stop;
wire l2d7_scan_out;
wire [9:0] l2b7_l2d7_rvalue;
wire [6:0] l2b7_l2d7_rid;
wire l2b7_l2d7_wr_en;
wire l2b7_l2d7_fuse_clr;
wire [9:0] l2d7_l2b7_fuse_data;
wire [623:0] l2b7_l2d7_fbdecc_c4;
wire [3:0] l2t7_l2d7_col_offset_c2;
wire l2t7_l2d7_fb_hit_c3;
wire l2t7_l2d7_fbrd_c3;
wire l2t7_l2d7_rd_wr_c2;
wire [8:0] l2t7_l2d7_set_c2;
wire [77:0] l2t7_l2d7_stdecc_c2;
wire [15:0] l2t7_l2d7_way_sel_c2;
wire [15:0] l2t7_l2d7_word_en_c2;
wire [623:0] l2d7_l2b7_decc_out_c7;
wire [155:0] l2d7_l2t7_decc_c6;
wire l2t1_mcu0_rd_req;
wire l2t1_mcu0_rd_dummy_req;
wire [2:0] l2t1_mcu0_rd_req_id;
wire l2t1_mcu0_wr_req;
wire l2t1_mcu0_addr_5;
wire [39:7] l2t1_mcu0_addr;
wire l2t1_mcu0_rd_req_t0lff;
wire l2t1_mcu0_rd_dummy_req_t0lff;
wire [2:0] l2t1_mcu0_rd_req_id_t0lff;
wire l2t1_mcu0_wr_req_t0lff;
wire l2t1_mcu0_addr_5_t0lff;
wire [39:7] l2t1_mcu0_addr_t0lff;
wire [1:0] l2b0_sio_parity;
wire [1:0] l2b0_sio_parity_t0rff;
wire [38:0] l2t0_dmo_dout;
wire dmo_tagmuxctl;
wire gl_io_cmp_sync_en_c3t;
wire gl_cmp_io_sync_en_c3t;
wire [7:0] sctag0_cpx_req_cq;
wire sctag0_cpx_atom_cq;
wire sctag0_pcx_stall_pq;
wire pcx_sctag0_data_rdy_px1;
wire [129:0] pcx_sctag0_data_px2;
wire pcx_sctag0_atm_px1;
wire [7:0] cpx_sctag0_grant_cx;
wire l2t0_rst_fatal_error;
wire l2t0_l2b0_fbrd_en_c3;
wire [2:0] l2t0_l2b0_fbrd_wl_c3;
wire [15:0] l2t0_l2b0_fbwr_wen_r2;
wire [2:0] l2t0_l2b0_fbwr_wl_r2;
wire l2t0_l2b0_fbd_stdatasel_c3;
wire [3:0] l2t0_l2b0_wbwr_wen_c6;
wire [2:0] l2t0_l2b0_wbwr_wl_c6;
wire l2t0_l2b0_wbrd_en_r0;
wire [2:0] l2t0_l2b0_wbrd_wl_r0;
wire [2:0] l2t0_l2b0_ev_dword_r0;
wire l2t0_l2b0_evict_en_r0;
wire l2b0_l2t0_ev_uerr_r5;
wire l2b0_l2t0_ev_cerr_r5;
wire [15:0] l2t0_l2b0_rdma_wren_s2;
wire [1:0] l2t0_l2b0_rdma_wrwl_s2;
wire [1:0] l2t0_l2b0_rdma_rdwl_r0;
wire l2t0_l2b0_rdma_rden_r0;
wire l2t0_l2b0_ctag_en_c7;
wire [31:0] l2t0_l2b0_ctag_c7;
wire [3:0] l2t0_l2b0_word_c7;
wire l2t0_l2b0_req_en_c7;
wire l2t0_l2b0_word_vld_c7;
wire l2b0_l2t0_rdma_uerr_c10;
wire l2b0_l2t0_rdma_cerr_c10;
wire l2b0_l2t0_rdma_notdata_c10;
wire l2t0_mcu0_rd_req;
wire l2t0_mcu0_rd_dummy_req;
wire [2:0] l2t0_mcu0_rd_req_id;
wire [39:7] l2t0_mcu0_addr;
wire l2t0_mcu0_addr_5;
wire l2t0_mcu0_wr_req;
wire mcu0_l2t0_rd_ack;
wire mcu0_l2t0_wr_ack;
wire [1:0] mcu0_l2t0_qword_id_r0;
wire mcu0_l2t0_data_vld_r0;
wire [2:0] mcu0_l2t0_rd_req_id_r0;
wire mcu0_l2t0_secc_err_r2;
wire mcu0_l2t0_mecc_err_r2;
wire mcu0_l2t0_scb_mecc_err;
wire mcu0_l2t0_scb_secc_err;
wire sii_l2t0_req_vld;
wire [31:0] sii_l2t0_req;
wire [6:0] sii_l2b0_ecc;
wire l2t0_sii_iq_dequeue;
wire l2t0_sii_wib_dequeue;
wire tcu_soc0_scan_out;
wire l2t0_scan_out;
wire efu_l2t0_fuse_clr;
wire efu_l2t0_fuse_xfer_en;
wire efu_l2t0246_fuse_data;
wire l2t0_efu_fuse_data;
wire l2t0_efu_fuse_xfer_en;
wire tcu_l2t0_mbist_start_t1lff;
wire tcu_l2t0_mbist_scan_in;
wire l2t0_tcu_mbist_done;
wire l2t0_tcu_mbist_fail;
wire l2t0_tcu_mbist_scan_out;
wire cmp_gclk_c3_l2t0;
wire gl_l2t0_clk_stop;
wire tcu_l2t0_shscan_scan_in;
wire tcu_l2t_shscan_aclk;
wire tcu_l2t_shscan_bclk;
wire tcu_l2t_shscan_scan_en;
wire tcu_l2t_shscan_pce_ov;
wire l2t0_tcu_shscan_scan_out;
wire tcu_l2t0_shscan_clk_stop;
wire [23:0] l2t0_rep_out0_unused;
wire [23:0] l2t0_rep_out1_unused;
wire [23:0] l2t0_rep_out2_unused;
wire [23:0] l2t0_rep_out3_unused;
wire [23:0] l2t0_rep_out4_unused;
wire [23:0] l2t0_rep_out5_unused;
wire [23:0] l2t0_rep_out6_unused;
wire [23:0] l2t0_rep_out7_unused;
wire [23:0] l2t0_rep_out8_unused;
wire [23:0] l2t0_rep_out9_unused;
wire [23:0] l2t0_rep_out10_unused;
wire [23:0] l2t0_rep_out11_unused;
wire [23:0] l2t0_rep_out12_unused;
wire [23:0] l2t0_rep_out13_unused;
wire [23:0] l2t0_rep_out14_unused;
wire [23:0] l2t0_rep_out15_unused;
wire [23:0] l2t0_rep_out16_unused;
wire [23:0] l2t0_rep_out17_unused;
wire [23:0] l2t0_rep_out18_unused;
wire [23:0] l2t0_rep_out19_unused;
wire [1:0] tcu_ncu_mbist_start;
wire l2t4_sii_iq_dequeue;
wire l2t4_sii_wib_dequeue;
wire l2t5_sii_iq_dequeue;
wire l2t5_sii_wib_dequeue;
wire tcu_l2t0_mbist_start;
wire tcu_mcu0_mbist_start;
wire tcu_mcu1_mbist_start;
wire [31:0] l2b0_sio_data;
wire l2b0_sio_ctag_vld;
wire l2b0_sio_ue_err;
wire mcu0_l2t1_rd_ack;
wire mcu0_l2t1_wr_ack;
wire [1:0] mcu0_l2t1_qword_id_r0;
wire mcu0_l2t1_data_vld_r0;
wire [2:0] mcu0_l2t1_rd_req_id_r0;
wire mcu0_l2t1_secc_err_r2;
wire mcu0_l2t1_mecc_err_r2;
wire mcu0_l2t1_scb_mecc_err;
wire mcu0_l2t1_scb_secc_err;
wire tcu_ncu_mbist_start_t1lff_0;
wire l2t4_sii_iq_dequeue_t1lff;
wire l2t4_sii_wib_dequeue_t1lff;
wire l2t5_sii_iq_dequeue_t1lff;
wire l2t5_sii_wib_dequeue_t1lff;
wire tcu_mcu0_mbist_start_t1lff;
wire tcu_mcu1_mbist_start_t1lff;
wire [62:0] unconnectedt1lff_t1lff;
wire [31:0] l2b0_sio_data_t1rff;
wire l2b0_sio_ctag_vld_t1rff;
wire l2b0_sio_ue_err_t1rff;
wire mcu0_l2t1_rd_ack_t1rff;
wire mcu0_l2t1_wr_ack_t1rff;
wire [1:0] mcu0_l2t1_qword_id_r0_t1rff;
wire mcu0_l2t1_data_vld_r0_t1rff;
wire [2:0] mcu0_l2t1_rd_req_id_r0_t1rff;
wire mcu0_l2t1_secc_err_r2_t1rff;
wire mcu0_l2t1_mecc_err_r2_t1rff;
wire mcu0_l2t1_scb_mecc_err_t1rff;
wire mcu0_l2t1_scb_secc_err_t1rff;
wire [38:0] l2t1_dmo_dout;
wire [5:0] dmo_l2tsel;
wire [7:0] sctag1_cpx_req_cq;
wire sctag1_cpx_atom_cq;
wire sctag1_pcx_stall_pq;
wire pcx_sctag1_data_rdy_px1;
wire [129:0] pcx_sctag1_data_px2;
wire pcx_sctag1_atm_px1;
wire [7:0] cpx_sctag1_grant_cx;
wire l2t1_rst_fatal_error;
wire l2t1_l2b1_fbrd_en_c3;
wire [2:0] l2t1_l2b1_fbrd_wl_c3;
wire [15:0] l2t1_l2b1_fbwr_wen_r2;
wire [2:0] l2t1_l2b1_fbwr_wl_r2;
wire l2t1_l2b1_fbd_stdatasel_c3;
wire [3:0] l2t1_l2b1_wbwr_wen_c6;
wire [2:0] l2t1_l2b1_wbwr_wl_c6;
wire l2t1_l2b1_wbrd_en_r0;
wire [2:0] l2t1_l2b1_wbrd_wl_r0;
wire [2:0] l2t1_l2b1_ev_dword_r0;
wire l2t1_l2b1_evict_en_r0;
wire l2b1_l2t1_ev_uerr_r5;
wire l2b1_l2t1_ev_cerr_r5;
wire [15:0] l2t1_l2b1_rdma_wren_s2;
wire [1:0] l2t1_l2b1_rdma_wrwl_s2;
wire [1:0] l2t1_l2b1_rdma_rdwl_r0;
wire l2t1_l2b1_rdma_rden_r0;
wire l2t1_l2b1_ctag_en_c7;
wire [31:0] l2t1_l2b1_ctag_c7;
wire [3:0] l2t1_l2b1_word_c7;
wire l2t1_l2b1_req_en_c7;
wire l2t1_l2b1_word_vld_c7;
wire l2b1_l2t1_rdma_uerr_c10;
wire l2b1_l2t1_rdma_cerr_c10;
wire l2b1_l2t1_rdma_notdata_c10;
wire sii_l2t1_req_vld;
wire [31:0] sii_l2t1_req;
wire [6:0] sii_l2b1_ecc;
wire l2t1_sii_iq_dequeue;
wire l2t1_sii_wib_dequeue;
wire gl_l2_por_c2t;
wire gl_l2_wmr_c2t;
wire efu_l2t1_fuse_clr;
wire efu_l2t1_fuse_xfer_en;
wire efu_l2t1357_fuse_data;
wire l2t1_efu_fuse_data;
wire l2t1_efu_fuse_xfer_en;
wire tcu_l2t1_mbist_start;
wire tcu_l2t1_mbist_scan_in;
wire l2t1_tcu_mbist_done;
wire l2t1_tcu_mbist_fail;
wire l2t1_tcu_mbist_scan_out;
wire cmp_gclk_c2_l2t1;
wire gl_l2t1_clk_stop;
wire tcu_l2t1_shscan_scan_in;
wire l2t1_tcu_shscan_scan_out;
wire tcu_l2t1_shscan_clk_stop;
wire [23:0] l2t1_rep_out0_unused;
wire [23:0] l2t1_rep_out1_unused;
wire [23:0] l2t1_rep_out2_unused;
wire [23:0] l2t1_rep_out3_unused;
wire [23:0] l2t1_rep_out4_unused;
wire [23:0] l2t1_rep_out5_unused;
wire [23:0] l2t1_rep_out6_unused;
wire [23:0] l2t1_rep_out7_unused;
wire [23:0] l2t1_rep_out8_unused;
wire [23:0] l2t1_rep_out9_unused;
wire [23:0] l2t1_rep_out10_unused;
wire [23:0] l2t1_rep_out11_unused;
wire [23:0] l2t1_rep_out12_unused;
wire [23:0] l2t1_rep_out13_unused;
wire [23:0] l2t1_rep_out14_unused;
wire [23:0] l2t1_rep_out15_unused;
wire [23:0] l2t1_rep_out16_unused;
wire [23:0] l2t1_rep_out17_unused;
wire [23:0] l2t1_rep_out18_unused;
wire [23:0] l2t1_rep_out19_unused;
wire l2t3_mcu1_rd_req;
wire l2t3_mcu1_rd_dummy_req;
wire [2:0] l2t3_mcu1_rd_req_id;
wire l2t3_mcu1_wr_req;
wire l2t3_mcu1_addr_5;
wire [39:7] l2t3_mcu1_addr;
wire l2t3_mcu1_rd_req_t2lff;
wire l2t3_mcu1_rd_dummy_req_t2lff;
wire [2:0] l2t3_mcu1_rd_req_id_t2lff;
wire l2t3_mcu1_wr_req_t2lff;
wire l2t3_mcu1_addr_5_t2lff;
wire [39:7] l2t3_mcu1_addr_t2lff;
wire [38:0] l2t2_dmo_dout;
wire [7:0] sctag2_cpx_req_cq;
wire sctag2_cpx_atom_cq;
wire sctag2_pcx_stall_pq;
wire pcx_sctag2_data_rdy_px1;
wire [129:0] pcx_sctag2_data_px2;
wire pcx_sctag2_atm_px1;
wire [7:0] cpx_sctag2_grant_cx;
wire l2t2_rst_fatal_error;
wire l2t2_l2b2_fbrd_en_c3;
wire [2:0] l2t2_l2b2_fbrd_wl_c3;
wire [15:0] l2t2_l2b2_fbwr_wen_r2;
wire [2:0] l2t2_l2b2_fbwr_wl_r2;
wire l2t2_l2b2_fbd_stdatasel_c3;
wire [3:0] l2t2_l2b2_wbwr_wen_c6;
wire [2:0] l2t2_l2b2_wbwr_wl_c6;
wire l2t2_l2b2_wbrd_en_r0;
wire [2:0] l2t2_l2b2_wbrd_wl_r0;
wire [2:0] l2t2_l2b2_ev_dword_r0;
wire l2t2_l2b2_evict_en_r0;
wire l2b2_l2t2_ev_uerr_r5;
wire l2b2_l2t2_ev_cerr_r5;
wire [15:0] l2t2_l2b2_rdma_wren_s2;
wire [1:0] l2t2_l2b2_rdma_wrwl_s2;
wire [1:0] l2t2_l2b2_rdma_rdwl_r0;
wire l2t2_l2b2_rdma_rden_r0;
wire l2t2_l2b2_ctag_en_c7;
wire [31:0] l2t2_l2b2_ctag_c7;
wire [3:0] l2t2_l2b2_word_c7;
wire l2t2_l2b2_req_en_c7;
wire l2t2_l2b2_word_vld_c7;
wire l2b2_l2t2_rdma_uerr_c10;
wire l2b2_l2t2_rdma_cerr_c10;
wire l2b2_l2t2_rdma_notdata_c10;
wire l2t2_mcu1_rd_req;
wire l2t2_mcu1_rd_dummy_req;
wire [2:0] l2t2_mcu1_rd_req_id;
wire [39:7] l2t2_mcu1_addr;
wire l2t2_mcu1_addr_5;
wire l2t2_mcu1_wr_req;
wire mcu1_l2t2_rd_ack;
wire mcu1_l2t2_wr_ack;
wire [1:0] mcu1_l2t2_qword_id_r0;
wire mcu1_l2t2_data_vld_r0;
wire [2:0] mcu1_l2t2_rd_req_id_r0;
wire mcu1_l2t2_secc_err_r2;
wire mcu1_l2t2_mecc_err_r2;
wire mcu1_l2t2_scb_mecc_err;
wire mcu1_l2t2_scb_secc_err;
wire sii_l2t2_req_vld;
wire [31:0] sii_l2t2_req;
wire [6:0] sii_l2b2_ecc;
wire l2t2_sii_iq_dequeue;
wire l2t2_sii_wib_dequeue;
wire tcu_soc1_scan_out;
wire l2t2_scan_out;
wire tcu_l2t2_mbist_start_t3lff;
wire tcu_l2t2_mbist_scan_in;
wire l2t2_tcu_mbist_done;
wire l2t2_tcu_mbist_fail;
wire l2t2_tcu_mbist_scan_out;
wire efu_l2t2_fuse_clr;
wire efu_l2t2_fuse_xfer_en;
wire l2t2_efu_fuse_data;
wire l2t2_efu_fuse_xfer_en;
wire cmp_gclk_c3_l2t2;
wire gl_l2t2_clk_stop;
wire tcu_l2t2_shscan_scan_in;
wire l2t2_tcu_shscan_scan_out;
wire tcu_l2t2_shscan_clk_stop;
wire [23:0] l2t2_rep_out0_unused;
wire [23:0] l2t2_rep_out1_unused;
wire [23:0] l2t2_rep_out2_unused;
wire [23:0] l2t2_rep_out3_unused;
wire [23:0] l2t2_rep_out4_unused;
wire [23:0] l2t2_rep_out5_unused;
wire [23:0] l2t2_rep_out6_unused;
wire [23:0] l2t2_rep_out7_unused;
wire [23:0] l2t2_rep_out8_unused;
wire [23:0] l2t2_rep_out9_unused;
wire [23:0] l2t2_rep_out10_unused;
wire [23:0] l2t2_rep_out11_unused;
wire [23:0] l2t2_rep_out12_unused;
wire [23:0] l2t2_rep_out13_unused;
wire [23:0] l2t2_rep_out14_unused;
wire [23:0] l2t2_rep_out15_unused;
wire [23:0] l2t2_rep_out16_unused;
wire [23:0] l2t2_rep_out17_unused;
wire [23:0] l2t2_rep_out18_unused;
wire [23:0] l2t2_rep_out19_unused;
wire l2t6_sii_iq_dequeue;
wire l2t6_sii_wib_dequeue;
wire l2t7_sii_iq_dequeue;
wire l2t7_sii_wib_dequeue;
wire tcu_l2t2_mbist_start;
wire mcu1_l2t3_rd_ack;
wire mcu1_l2t3_wr_ack;
wire [1:0] mcu1_l2t3_qword_id_r0;
wire mcu1_l2t3_data_vld_r0;
wire [2:0] mcu1_l2t3_rd_req_id_r0;
wire mcu1_l2t3_secc_err_r2;
wire mcu1_l2t3_mecc_err_r2;
wire mcu1_l2t3_scb_mecc_err;
wire mcu1_l2t3_scb_secc_err;
wire l2t6_sii_iq_dequeue_t3lff;
wire l2t6_sii_wib_dequeue_t3lff;
wire l2t7_sii_iq_dequeue_t3lff;
wire l2t7_sii_wib_dequeue_t3lff;
wire mcu1_l2t3_rd_ack_t3rff;
wire mcu1_l2t3_wr_ack_t3rff;
wire [1:0] mcu1_l2t3_qword_id_r0_t3rff;
wire mcu1_l2t3_data_vld_r0_t3rff;
wire [2:0] mcu1_l2t3_rd_req_id_r0_t3rff;
wire mcu1_l2t3_secc_err_r2_t3rff;
wire mcu1_l2t3_mecc_err_r2_t3rff;
wire mcu1_l2t3_scb_mecc_err_t3rff;
wire mcu1_l2t3_scb_secc_err_t3rff;
wire [38:0] l2t3_dmo_dout;
wire [7:0] sctag3_cpx_req_cq;
wire sctag3_cpx_atom_cq;
wire sctag3_pcx_stall_pq;
wire pcx_sctag3_data_rdy_px1;
wire [129:0] pcx_sctag3_data_px2;
wire pcx_sctag3_atm_px1;
wire [7:0] cpx_sctag3_grant_cx;
wire l2t3_rst_fatal_error;
wire l2t3_l2b3_fbrd_en_c3;
wire [2:0] l2t3_l2b3_fbrd_wl_c3;
wire [15:0] l2t3_l2b3_fbwr_wen_r2;
wire [2:0] l2t3_l2b3_fbwr_wl_r2;
wire l2t3_l2b3_fbd_stdatasel_c3;
wire [3:0] l2t3_l2b3_wbwr_wen_c6;
wire [2:0] l2t3_l2b3_wbwr_wl_c6;
wire l2t3_l2b3_wbrd_en_r0;
wire [2:0] l2t3_l2b3_wbrd_wl_r0;
wire [2:0] l2t3_l2b3_ev_dword_r0;
wire l2t3_l2b3_evict_en_r0;
wire l2b3_l2t3_ev_uerr_r5;
wire l2b3_l2t3_ev_cerr_r5;
wire [15:0] l2t3_l2b3_rdma_wren_s2;
wire [1:0] l2t3_l2b3_rdma_wrwl_s2;
wire [1:0] l2t3_l2b3_rdma_rdwl_r0;
wire l2t3_l2b3_rdma_rden_r0;
wire l2t3_l2b3_ctag_en_c7;
wire [31:0] l2t3_l2b3_ctag_c7;
wire [3:0] l2t3_l2b3_word_c7;
wire l2t3_l2b3_req_en_c7;
wire l2t3_l2b3_word_vld_c7;
wire l2b3_l2t3_rdma_uerr_c10;
wire l2b3_l2t3_rdma_cerr_c10;
wire l2b3_l2t3_rdma_notdata_c10;
wire sii_l2t3_req_vld;
wire [31:0] sii_l2t3_req;
wire [6:0] sii_l2b3_ecc;
wire l2t3_sii_iq_dequeue;
wire l2t3_sii_wib_dequeue;
wire gl_l2_por_c2b;
wire gl_l2_wmr_c2b;
wire tcu_l2t3_mbist_start;
wire tcu_l2t3_mbist_scan_in;
wire l2t3_tcu_mbist_done;
wire l2t3_tcu_mbist_fail;
wire l2t3_tcu_mbist_scan_out;
wire efu_l2t3_fuse_clr;
wire efu_l2t3_fuse_xfer_en;
wire l2t3_efu_fuse_data;
wire l2t3_efu_fuse_xfer_en;
wire cmp_gclk_c2_l2t3;
wire gl_l2t3_clk_stop;
wire tcu_l2t3_shscan_scan_in;
wire l2t3_tcu_shscan_scan_out;
wire tcu_l2t3_shscan_clk_stop;
wire [23:0] l2t3_rep_out0_unused;
wire [23:0] l2t3_rep_out1_unused;
wire [23:0] l2t3_rep_out2_unused;
wire [23:0] l2t3_rep_out3_unused;
wire [23:0] l2t3_rep_out4_unused;
wire [23:0] l2t3_rep_out5_unused;
wire [23:0] l2t3_rep_out6_unused;
wire [23:0] l2t3_rep_out7_unused;
wire [23:0] l2t3_rep_out8_unused;
wire [23:0] l2t3_rep_out9_unused;
wire [23:0] l2t3_rep_out10_unused;
wire [23:0] l2t3_rep_out11_unused;
wire [23:0] l2t3_rep_out12_unused;
wire [23:0] l2t3_rep_out13_unused;
wire [23:0] l2t3_rep_out14_unused;
wire [23:0] l2t3_rep_out15_unused;
wire [23:0] l2t3_rep_out16_unused;
wire [23:0] l2t3_rep_out17_unused;
wire [23:0] l2t3_rep_out18_unused;
wire [23:0] l2t3_rep_out19_unused;
wire [31:0] sii_l2t4_req;
wire sii_l2t4_req_vld;
wire [31:0] sii_l2t5_req;
wire sii_l2t5_req_vld;
wire [6:0] sii_l2b4_ecc;
wire l2t5_mcu2_rd_req;
wire l2t5_mcu2_rd_dummy_req;
wire [2:0] l2t5_mcu2_rd_req_id;
wire l2t5_mcu2_wr_req;
wire l2t5_mcu2_addr_5;
wire [39:7] l2t5_mcu2_addr;
wire [31:0] l2b4_sio_data;
wire [1:0] l2b4_sio_parity;
wire l2b4_sio_ctag_vld;
wire l2b4_sio_ue_err;
wire [31:0] sii_l2t4_req_t4lff;
wire sii_l2t4_req_vld_t4lff;
wire [31:0] sii_l2t5_req_t4lff;
wire sii_l2t5_req_vld_t4lff;
wire [6:0] sii_l2b4_ecc_t4lff;
wire [31:0] l2b0_sio_data_t4lff;
wire l2b0_sio_ctag_vld_t4lff;
wire l2b0_sio_ue_err_t4lff;
wire l2t5_mcu2_rd_req_t4lff;
wire l2t5_mcu2_rd_dummy_req_t4lff;
wire [2:0] l2t5_mcu2_rd_req_id_t4lff;
wire l2t5_mcu2_wr_req_t4lff;
wire l2t5_mcu2_addr_5_t4lff;
wire [39:7] l2t5_mcu2_addr_t4lff;
wire [31:0] l2b4_sio_data_t4rff;
wire [1:0] l2b4_sio_parity_t4rff;
wire l2b4_sio_ctag_vld_t4rff;
wire l2b4_sio_ue_err_t4rff;
wire [38:0] l2t5_dmo_dout;
wire [38:0] l2t4_dmo_dout;
wire [7:0] sctag4_cpx_req_cq;
wire sctag4_cpx_atom_cq;
wire sctag4_pcx_stall_pq;
wire pcx_sctag4_data_rdy_px1;
wire [129:0] pcx_sctag4_data_px2;
wire pcx_sctag4_atm_px1;
wire [7:0] cpx_sctag4_grant_cx;
wire l2t4_rst_fatal_error;
wire l2t4_l2b4_fbrd_en_c3;
wire [2:0] l2t4_l2b4_fbrd_wl_c3;
wire [15:0] l2t4_l2b4_fbwr_wen_r2;
wire [2:0] l2t4_l2b4_fbwr_wl_r2;
wire l2t4_l2b4_fbd_stdatasel_c3;
wire [3:0] l2t4_l2b4_wbwr_wen_c6;
wire [2:0] l2t4_l2b4_wbwr_wl_c6;
wire l2t4_l2b4_wbrd_en_r0;
wire [2:0] l2t4_l2b4_wbrd_wl_r0;
wire [2:0] l2t4_l2b4_ev_dword_r0;
wire l2t4_l2b4_evict_en_r0;
wire l2b4_l2t4_ev_uerr_r5;
wire l2b4_l2t4_ev_cerr_r5;
wire [15:0] l2t4_l2b4_rdma_wren_s2;
wire [1:0] l2t4_l2b4_rdma_wrwl_s2;
wire [1:0] l2t4_l2b4_rdma_rdwl_r0;
wire l2t4_l2b4_rdma_rden_r0;
wire l2t4_l2b4_ctag_en_c7;
wire [31:0] l2t4_l2b4_ctag_c7;
wire [3:0] l2t4_l2b4_word_c7;
wire l2t4_l2b4_req_en_c7;
wire l2t4_l2b4_word_vld_c7;
wire l2b4_l2t4_rdma_uerr_c10;
wire l2b4_l2t4_rdma_cerr_c10;
wire l2b4_l2t4_rdma_notdata_c10;
wire l2t4_mcu2_rd_req;
wire l2t4_mcu2_rd_dummy_req;
wire [2:0] l2t4_mcu2_rd_req_id;
wire [39:7] l2t4_mcu2_addr;
wire l2t4_mcu2_addr_5;
wire l2t4_mcu2_wr_req;
wire mcu2_l2t4_rd_ack;
wire mcu2_l2t4_wr_ack;
wire [1:0] mcu2_l2t4_qword_id_r0;
wire mcu2_l2t4_data_vld_r0;
wire [2:0] mcu2_l2t4_rd_req_id_r0;
wire mcu2_l2t4_secc_err_r2;
wire mcu2_l2t4_mecc_err_r2;
wire mcu2_l2t4_scb_mecc_err;
wire mcu2_l2t4_scb_secc_err;
wire gl_rst_l2_por_c1m;
wire gl_rst_l2_wmr_c1m;
wire tcu_soc2_scan_out;
wire l2t4_scan_out;
wire tcu_l2t4_mbist_start;
wire tcu_l2t4_mbist_scan_in;
wire l2t4_tcu_mbist_done;
wire l2t4_tcu_mbist_fail;
wire l2t4_tcu_mbist_scan_out;
wire efu_l2t4_fuse_clr;
wire efu_l2t4_fuse_xfer_en;
wire l2t4_efu_fuse_data;
wire l2t4_efu_fuse_xfer_en;
wire cmp_gclk_c1_l2t4;
wire gl_l2t4_clk_stop;
wire tcu_l2t4_shscan_scan_in;
wire l2t4_tcu_shscan_scan_out;
wire tcu_l2t4_shscan_clk_stop;
wire [23:0] l2t4_rep_out0_unused;
wire [23:0] l2t4_rep_out1_unused;
wire [23:0] l2t4_rep_out2_unused;
wire [23:0] l2t4_rep_out3_unused;
wire [23:0] l2t4_rep_out4_unused;
wire [23:0] l2t4_rep_out5_unused;
wire [23:0] l2t4_rep_out6_unused;
wire [23:0] l2t4_rep_out7_unused;
wire [23:0] l2t4_rep_out8_unused;
wire [23:0] l2t4_rep_out9_unused;
wire [23:0] l2t4_rep_out10_unused;
wire [23:0] l2t4_rep_out11_unused;
wire [23:0] l2t4_rep_out12_unused;
wire [23:0] l2t4_rep_out13_unused;
wire [23:0] l2t4_rep_out14_unused;
wire [23:0] l2t4_rep_out15_unused;
wire [23:0] l2t4_rep_out16_unused;
wire [23:0] l2t4_rep_out17_unused;
wire [23:0] l2t4_rep_out18_unused;
wire [23:0] l2t4_rep_out19_unused;
wire mcu1_tcu_mbist_fail;
wire [1:0] ncu_tcu_mbist_done;
wire [1:0] ncu_tcu_mbist_fail;
wire mcu0_tcu_mbist_done;
wire mcu0_tcu_mbist_fail;
wire mcu1_tcu_mbist_done;
wire mcu2_l2t5_rd_ack;
wire mcu2_l2t5_wr_ack;
wire [1:0] mcu2_l2t5_qword_id_r0;
wire mcu2_l2t5_data_vld_r0;
wire [2:0] mcu2_l2t5_rd_req_id_r0;
wire mcu2_l2t5_secc_err_r2;
wire mcu2_l2t5_mecc_err_r2;
wire mcu2_l2t5_scb_mecc_err;
wire mcu2_l2t5_scb_secc_err;
wire mcu1_tcu_mbist_fail_t5lff;
wire ncu_tcu_mbist_done_t5lff_0;
wire ncu_tcu_mbist_fail_t5lff_0;
wire [1:0] l2b0_sio_parity_t5lff;
wire l2t0_tcu_mbist_done_t5lff;
wire l2t0_tcu_mbist_fail_t5lff;
wire spc0_tcu_mbist_done_t5lff;
wire spc0_tcu_mbist_fail_t5lff;
wire mcu0_tcu_mbist_done_t5lff;
wire mcu0_tcu_mbist_fail_t5lff;
wire mcu1_tcu_mbist_done_t5lff;
wire spc0_softstop_request_t5lff;
wire spc0_hardstop_request_t5lff;
wire spc0_trigger_pulse_t5lff;
wire spc0_ss_complete_t5lff;
wire mcu2_l2t5_rd_ack_t5rff;
wire mcu2_l2t5_wr_ack_t5rff;
wire [1:0] mcu2_l2t5_qword_id_r0_t5rff;
wire mcu2_l2t5_data_vld_r0_t5rff;
wire [2:0] mcu2_l2t5_rd_req_id_r0_t5rff;
wire mcu2_l2t5_secc_err_r2_t5rff;
wire mcu2_l2t5_mecc_err_r2_t5rff;
wire mcu2_l2t5_scb_mecc_err_t5rff;
wire mcu2_l2t5_scb_secc_err_t5rff;
wire l2t5_dbg1_err_event;
wire [7:0] sctag5_cpx_req_cq;
wire sctag5_cpx_atom_cq;
wire sctag5_pcx_stall_pq;
wire pcx_sctag5_data_rdy_px1;
wire [129:0] pcx_sctag5_data_px2;
wire pcx_sctag5_atm_px1;
wire [7:0] cpx_sctag5_grant_cx;
wire l2t5_rst_fatal_error;
wire l2t5_l2b5_fbrd_en_c3;
wire [2:0] l2t5_l2b5_fbrd_wl_c3;
wire [15:0] l2t5_l2b5_fbwr_wen_r2;
wire [2:0] l2t5_l2b5_fbwr_wl_r2;
wire l2t5_l2b5_fbd_stdatasel_c3;
wire [3:0] l2t5_l2b5_wbwr_wen_c6;
wire [2:0] l2t5_l2b5_wbwr_wl_c6;
wire l2t5_l2b5_wbrd_en_r0;
wire [2:0] l2t5_l2b5_wbrd_wl_r0;
wire [2:0] l2t5_l2b5_ev_dword_r0;
wire l2t5_l2b5_evict_en_r0;
wire l2b5_l2t5_ev_uerr_r5;
wire l2b5_l2t5_ev_cerr_r5;
wire [15:0] l2t5_l2b5_rdma_wren_s2;
wire [1:0] l2t5_l2b5_rdma_wrwl_s2;
wire [1:0] l2t5_l2b5_rdma_rdwl_r0;
wire l2t5_l2b5_rdma_rden_r0;
wire l2t5_l2b5_ctag_en_c7;
wire [31:0] l2t5_l2b5_ctag_c7;
wire [3:0] l2t5_l2b5_word_c7;
wire l2t5_l2b5_req_en_c7;
wire l2t5_l2b5_word_vld_c7;
wire l2b5_l2t5_rdma_uerr_c10;
wire l2b5_l2t5_rdma_cerr_c10;
wire l2b5_l2t5_rdma_notdata_c10;
wire tcu_l2t5_mbist_start;
wire tcu_l2t5_mbist_scan_in;
wire l2t5_tcu_mbist_done;
wire l2t5_tcu_mbist_fail;
wire l2t5_tcu_mbist_scan_out;
wire efu_l2t5_fuse_clr;
wire efu_l2t5_fuse_xfer_en;
wire l2t5_efu_fuse_data;
wire l2t5_efu_fuse_xfer_en;
wire cmp_gclk_c2_l2t5;
wire gl_l2t5_clk_stop;
wire tcu_l2t5_shscan_scan_in;
wire l2t5_tcu_shscan_scan_out;
wire tcu_l2t5_shscan_clk_stop;
wire [23:0] l2t5_rep_out0_unused;
wire [23:0] l2t5_rep_out1_unused;
wire [23:0] l2t5_rep_out2_unused;
wire [23:0] l2t5_rep_out3_unused;
wire [23:0] l2t5_rep_out4_unused;
wire [23:0] l2t5_rep_out5_unused;
wire [23:0] l2t5_rep_out6_unused;
wire [23:0] l2t5_rep_out7_unused;
wire [23:0] l2t5_rep_out8_unused;
wire [23:0] l2t5_rep_out9_unused;
wire [23:0] l2t5_rep_out10_unused;
wire [23:0] l2t5_rep_out11_unused;
wire [23:0] l2t5_rep_out12_unused;
wire [23:0] l2t5_rep_out13_unused;
wire [23:0] l2t5_rep_out14_unused;
wire [23:0] l2t5_rep_out15_unused;
wire [23:0] l2t5_rep_out16_unused;
wire [23:0] l2t5_rep_out17_unused;
wire [23:0] l2t5_rep_out18_unused;
wire [23:0] l2t5_rep_out19_unused;
wire [31:0] sii_l2t6_req;
wire sii_l2t6_req_vld;
wire [31:0] sii_l2t7_req;
wire sii_l2t7_req_vld;
wire l2t7_mcu3_rd_req;
wire l2t7_mcu3_rd_dummy_req;
wire [2:0] l2t7_mcu3_rd_req_id;
wire l2t7_mcu3_wr_req;
wire l2t7_mcu3_addr_5;
wire [39:7] l2t7_mcu3_addr;
wire [31:0] sii_l2t6_req_t6lff;
wire sii_l2t6_req_vld_t6lff;
wire [31:0] sii_l2t7_req_t6lff;
wire sii_l2t7_req_vld_t6lff;
wire l2t7_mcu3_rd_req_t6lff;
wire l2t7_mcu3_rd_dummy_req_t6lff;
wire [2:0] l2t7_mcu3_rd_req_id_t6lff;
wire l2t7_mcu3_wr_req_t6lff;
wire l2t7_mcu3_addr_5_t6lff;
wire [39:7] l2t7_mcu3_addr_t6lff;
wire [38:0] l2t7_dmo_dout;
wire [38:0] l2t6_dmo_dout;
wire [7:0] sctag6_cpx_req_cq;
wire sctag6_cpx_atom_cq;
wire sctag6_pcx_stall_pq;
wire pcx_sctag6_data_rdy_px1;
wire [129:0] pcx_sctag6_data_px2;
wire pcx_sctag6_atm_px1;
wire [7:0] cpx_sctag6_grant_cx;
wire l2t6_rst_fatal_error;
wire l2t6_l2b6_fbrd_en_c3;
wire [2:0] l2t6_l2b6_fbrd_wl_c3;
wire [15:0] l2t6_l2b6_fbwr_wen_r2;
wire [2:0] l2t6_l2b6_fbwr_wl_r2;
wire l2t6_l2b6_fbd_stdatasel_c3;
wire [3:0] l2t6_l2b6_wbwr_wen_c6;
wire [2:0] l2t6_l2b6_wbwr_wl_c6;
wire l2t6_l2b6_wbrd_en_r0;
wire [2:0] l2t6_l2b6_wbrd_wl_r0;
wire [2:0] l2t6_l2b6_ev_dword_r0;
wire l2t6_l2b6_evict_en_r0;
wire l2b6_l2t6_ev_uerr_r5;
wire l2b6_l2t6_ev_cerr_r5;
wire [15:0] l2t6_l2b6_rdma_wren_s2;
wire [1:0] l2t6_l2b6_rdma_wrwl_s2;
wire [1:0] l2t6_l2b6_rdma_rdwl_r0;
wire l2t6_l2b6_rdma_rden_r0;
wire l2t6_l2b6_ctag_en_c7;
wire [31:0] l2t6_l2b6_ctag_c7;
wire [3:0] l2t6_l2b6_word_c7;
wire l2t6_l2b6_req_en_c7;
wire l2t6_l2b6_word_vld_c7;
wire l2b6_l2t6_rdma_uerr_c10;
wire l2b6_l2t6_rdma_cerr_c10;
wire l2b6_l2t6_rdma_notdata_c10;
wire l2t6_mcu3_rd_req;
wire l2t6_mcu3_rd_dummy_req;
wire [2:0] l2t6_mcu3_rd_req_id;
wire [39:7] l2t6_mcu3_addr;
wire l2t6_mcu3_addr_5;
wire l2t6_mcu3_wr_req;
wire mcu3_l2t6_rd_ack;
wire mcu3_l2t6_wr_ack;
wire [1:0] mcu3_l2t6_qword_id_r0;
wire mcu3_l2t6_data_vld_r0;
wire [2:0] mcu3_l2t6_rd_req_id_r0;
wire mcu3_l2t6_secc_err_r2;
wire mcu3_l2t6_mecc_err_r2;
wire mcu3_l2t6_scb_mecc_err;
wire mcu3_l2t6_scb_secc_err;
wire tcu_soc3_scan_out;
wire l2t6_scan_out;
wire tcu_l2t6_mbist_start;
wire tcu_l2t6_mbist_scan_in;
wire l2t6_tcu_mbist_done;
wire l2t6_tcu_mbist_fail;
wire l2t6_tcu_mbist_scan_out;
wire efu_l2t6_fuse_clr;
wire efu_l2t6_fuse_xfer_en;
wire l2t6_efu_fuse_data;
wire l2t6_efu_fuse_xfer_en;
wire cmp_gclk_c1_l2t6;
wire gl_l2t6_clk_stop;
wire tcu_l2t6_shscan_scan_in;
wire l2t6_tcu_shscan_scan_out;
wire tcu_l2t6_shscan_clk_stop;
wire [23:0] l2t6_rep_out0_unused;
wire [23:0] l2t6_rep_out1_unused;
wire [23:0] l2t6_rep_out2_unused;
wire [23:0] l2t6_rep_out3_unused;
wire [23:0] l2t6_rep_out4_unused;
wire [23:0] l2t6_rep_out5_unused;
wire [23:0] l2t6_rep_out6_unused;
wire [23:0] l2t6_rep_out7_unused;
wire [23:0] l2t6_rep_out8_unused;
wire [23:0] l2t6_rep_out9_unused;
wire [23:0] l2t6_rep_out10_unused;
wire [23:0] l2t6_rep_out11_unused;
wire [23:0] l2t6_rep_out12_unused;
wire [23:0] l2t6_rep_out13_unused;
wire [23:0] l2t6_rep_out14_unused;
wire [23:0] l2t6_rep_out15_unused;
wire [23:0] l2t6_rep_out16_unused;
wire [23:0] l2t6_rep_out17_unused;
wire [23:0] l2t6_rep_out18_unused;
wire [23:0] l2t6_rep_out19_unused;
wire mcu3_l2t7_rd_ack;
wire mcu3_l2t7_wr_ack;
wire [1:0] mcu3_l2t7_qword_id_r0;
wire mcu3_l2t7_data_vld_r0;
wire [2:0] mcu3_l2t7_rd_req_id_r0;
wire mcu3_l2t7_secc_err_r2;
wire mcu3_l2t7_mecc_err_r2;
wire mcu3_l2t7_scb_mecc_err;
wire mcu3_l2t7_scb_secc_err;
wire l2t2_tcu_mbist_done_t7lff;
wire l2t2_tcu_mbist_fail_t7lff;
wire spc2_tcu_mbist_done_t7lff;
wire spc2_tcu_mbist_fail_t7lff;
wire spc2_softstop_request_t7lff;
wire spc2_hardstop_request_t7lff;
wire spc2_trigger_pulse_t7lff;
wire spc2_ss_complete_t7lff;
wire mcu3_l2t7_rd_ack_t7rff;
wire mcu3_l2t7_wr_ack_t7rff;
wire [1:0] mcu3_l2t7_qword_id_r0_t7rff;
wire mcu3_l2t7_data_vld_r0_t7rff;
wire [2:0] mcu3_l2t7_rd_req_id_r0_t7rff;
wire mcu3_l2t7_secc_err_r2_t7rff;
wire mcu3_l2t7_mecc_err_r2_t7rff;
wire mcu3_l2t7_scb_mecc_err_t7rff;
wire mcu3_l2t7_scb_secc_err_t7rff;
wire [7:0] sctag7_cpx_req_cq;
wire sctag7_cpx_atom_cq;
wire sctag7_pcx_stall_pq;
wire pcx_sctag7_data_rdy_px1;
wire [129:0] pcx_sctag7_data_px2;
wire pcx_sctag7_atm_px1;
wire [7:0] cpx_sctag7_grant_cx;
wire l2t7_rst_fatal_error;
wire l2t7_l2b7_fbrd_en_c3;
wire [2:0] l2t7_l2b7_fbrd_wl_c3;
wire [15:0] l2t7_l2b7_fbwr_wen_r2;
wire [2:0] l2t7_l2b7_fbwr_wl_r2;
wire l2t7_l2b7_fbd_stdatasel_c3;
wire [3:0] l2t7_l2b7_wbwr_wen_c6;
wire [2:0] l2t7_l2b7_wbwr_wl_c6;
wire l2t7_l2b7_wbrd_en_r0;
wire [2:0] l2t7_l2b7_wbrd_wl_r0;
wire [2:0] l2t7_l2b7_ev_dword_r0;
wire l2t7_l2b7_evict_en_r0;
wire l2b7_l2t7_ev_uerr_r5;
wire l2b7_l2t7_ev_cerr_r5;
wire [15:0] l2t7_l2b7_rdma_wren_s2;
wire [1:0] l2t7_l2b7_rdma_wrwl_s2;
wire [1:0] l2t7_l2b7_rdma_rdwl_r0;
wire l2t7_l2b7_rdma_rden_r0;
wire l2t7_l2b7_ctag_en_c7;
wire [31:0] l2t7_l2b7_ctag_c7;
wire [3:0] l2t7_l2b7_word_c7;
wire l2t7_l2b7_req_en_c7;
wire l2t7_l2b7_word_vld_c7;
wire l2b7_l2t7_rdma_uerr_c10;
wire l2b7_l2t7_rdma_cerr_c10;
wire l2b7_l2t7_rdma_notdata_c10;
wire tcu_l2t7_mbist_start;
wire tcu_l2t7_mbist_scan_in;
wire l2t7_tcu_mbist_done;
wire l2t7_tcu_mbist_fail;
wire l2t7_tcu_mbist_scan_out;
wire efu_l2t7_fuse_clr;
wire efu_l2t7_fuse_xfer_en;
wire l2t7_efu_fuse_data;
wire l2t7_efu_fuse_xfer_en;
wire cmp_gclk_c2_l2t7;
wire gl_l2t7_clk_stop;
wire tcu_l2t7_shscan_scan_in;
wire l2t7_tcu_shscan_scan_out;
wire tcu_l2t7_shscan_clk_stop;
wire [23:0] l2t7_rep_out0_unused;
wire [23:0] l2t7_rep_out1_unused;
wire [23:0] l2t7_rep_out2_unused;
wire [23:0] l2t7_rep_out3_unused;
wire [23:0] l2t7_rep_out4_unused;
wire [23:0] l2t7_rep_out5_unused;
wire [23:0] l2t7_rep_out6_unused;
wire [23:0] l2t7_rep_out7_unused;
wire [23:0] l2t7_rep_out8_unused;
wire [23:0] l2t7_rep_out9_unused;
wire [23:0] l2t7_rep_out10_unused;
wire [23:0] l2t7_rep_out11_unused;
wire [23:0] l2t7_rep_out12_unused;
wire [23:0] l2t7_rep_out13_unused;
wire [23:0] l2t7_rep_out14_unused;
wire [23:0] l2t7_rep_out15_unused;
wire [23:0] l2t7_rep_out16_unused;
wire [23:0] l2t7_rep_out17_unused;
wire [23:0] l2t7_rep_out18_unused;
wire [23:0] l2t7_rep_out19_unused;
wire cmp_gclk_c3_l2b0;
wire gl_l2b0_clk_stop;
wire efu_l2b0246_fuse_data;
wire efu_l2b0_fuse_xfer_en;
wire efu_l2b0_fuse_clr;
wire l2b0_efu_fuse_xfer_en;
wire l2b0_efu_fuse_data;
wire [127:0] mcu0_l2b01_data_r2;
wire [27:0] mcu0_l2b01_ecc_r2;
wire tcu_l2b0_mbist_scan_in;
wire l2b0_tcu_mbist_scan_out;
wire l2b0_mcu0_data_mecc_r5;
wire [63:0] l2b0_mcu0_wr_data_r5;
wire l2b0_mcu0_data_vld_r5;
wire tcu_soch_scan_out;
wire l2b0_scan_out;
wire cmp_gclk_c3_l2b1;
wire gl_l2b1_clk_stop;
wire efu_l2b1357_fuse_data;
wire efu_l2b1_fuse_xfer_en;
wire efu_l2b1_fuse_clr;
wire l2b1_efu_fuse_xfer_en;
wire l2b1_efu_fuse_data;
wire tcu_l2b1_mbist_scan_in;
wire l2b1_tcu_mbist_scan_out;
wire l2b1_mcu0_data_mecc_r5;
wire [63:0] l2b1_mcu0_wr_data_r5;
wire l2b1_mcu0_data_vld_r5;
wire l2b1_scan_out;
wire cmp_gclk_c3_l2b2;
wire gl_l2b2_clk_stop;
wire efu_l2b2_fuse_xfer_en;
wire efu_l2b2_fuse_clr;
wire l2b2_efu_fuse_xfer_en;
wire l2b2_efu_fuse_data;
wire [127:0] mcu1_l2b23_data_r2;
wire [27:0] mcu1_l2b23_ecc_r2;
wire tcu_l2b2_mbist_scan_in;
wire l2b2_tcu_mbist_scan_out;
wire l2b2_mcu1_data_mecc_r5;
wire [63:0] l2b2_mcu1_wr_data_r5;
wire l2b2_mcu1_data_vld_r5;
wire l2b2_scan_out;
wire cmp_gclk_c3_l2b3;
wire gl_l2b3_clk_stop;
wire efu_l2b3_fuse_xfer_en;
wire efu_l2b3_fuse_clr;
wire l2b3_efu_fuse_xfer_en;
wire l2b3_efu_fuse_data;
wire tcu_l2b3_mbist_scan_in;
wire l2b3_tcu_mbist_scan_out;
wire l2b3_mcu1_data_mecc_r5;
wire [63:0] l2b3_mcu1_wr_data_r5;
wire l2b3_mcu1_data_vld_r5;
wire l2b3_scan_out;
wire cmp_gclk_c1_l2b4;
wire gl_l2b4_clk_stop;
wire efu_l2b4_fuse_xfer_en;
wire efu_l2b4_fuse_clr;
wire l2b4_efu_fuse_xfer_en;
wire l2b4_efu_fuse_data;
wire [127:0] mcu2_l2b45_data_r2;
wire [27:0] mcu2_l2b45_ecc_r2;
wire tcu_l2b4_mbist_start;
wire l2b4_tcu_mbist_done;
wire l2b4_tcu_mbist_fail;
wire tcu_l2b4_mbist_scan_in;
wire l2b4_tcu_mbist_scan_out;
wire l2b4_mcu2_data_mecc_r5;
wire [63:0] l2b4_mcu2_wr_data_r5;
wire l2b4_mcu2_data_vld_r5;
wire l2b4_scan_out;
wire cmp_gclk_c1_l2b5;
wire gl_l2b5_clk_stop;
wire efu_l2b5_fuse_xfer_en;
wire efu_l2b5_fuse_clr;
wire l2b5_efu_fuse_xfer_en;
wire l2b5_efu_fuse_data;
wire l2b5_sio_ctag_vld;
wire [31:0] l2b5_sio_data;
wire [1:0] l2b5_sio_parity;
wire l2b5_sio_ue_err;
wire tcu_l2b5_mbist_start;
wire l2b5_tcu_mbist_done;
wire l2b5_tcu_mbist_fail;
wire tcu_l2b5_mbist_scan_in;
wire l2b5_tcu_mbist_scan_out;
wire l2b5_mcu2_data_mecc_r5;
wire [63:0] l2b5_mcu2_wr_data_r5;
wire l2b5_mcu2_data_vld_r5;
wire l2b5_scan_out;
wire cmp_gclk_c1_l2b6;
wire gl_l2b6_clk_stop;
wire efu_l2b6_fuse_xfer_en;
wire efu_l2b6_fuse_clr;
wire l2b6_efu_fuse_xfer_en;
wire l2b6_efu_fuse_data;
wire l2b6_sio_ctag_vld;
wire [31:0] l2b6_sio_data;
wire [1:0] l2b6_sio_parity;
wire l2b6_sio_ue_err;
wire [127:0] mcu3_l2b67_data_r2;
wire [27:0] mcu3_l2b67_ecc_r2;
wire tcu_l2b6_mbist_start;
wire l2b6_tcu_mbist_done;
wire l2b6_tcu_mbist_fail;
wire tcu_l2b6_mbist_scan_in;
wire l2b6_tcu_mbist_scan_out;
wire l2b6_mcu3_data_mecc_r5;
wire [63:0] l2b6_mcu3_wr_data_r5;
wire l2b6_mcu3_data_vld_r5;
wire l2b6_scan_out;
wire cmp_gclk_c1_l2b7;
wire gl_l2b7_clk_stop;
wire efu_l2b7_fuse_xfer_en;
wire efu_l2b7_fuse_clr;
wire l2b7_efu_fuse_xfer_en;
wire l2b7_efu_fuse_data;
wire l2b7_sio_ctag_vld;
wire [31:0] l2b7_sio_data;
wire [1:0] l2b7_sio_parity;
wire l2b7_sio_ue_err;
wire tcu_l2b7_mbist_start;
wire l2b7_tcu_mbist_done;
wire l2b7_tcu_mbist_fail;
wire tcu_l2b7_mbist_scan_in;
wire l2b7_tcu_mbist_scan_out;
wire l2b7_mcu3_data_mecc_r5;
wire [63:0] l2b7_mcu3_wr_data_r5;
wire l2b7_mcu3_data_vld_r5;
wire l2b7_scan_out;
wire cmp_gclk_c4_mcu0;
wire gl_mcu0_clk_stop;
wire gl_mcu0_dr_clk_stop;
wire gl_mcu0_io_clk_stop;
wire dr_gclk_c4_mcu0;
wire gl_dr_sync_en_c3t;
wire tcu_mcu0_fbd_clk_stop;
wire mcu0_pt_sync_out;
wire mcu1_pt_sync_out;
wire mcu2_pt_sync_out;
wire mcu3_pt_sync_out;
wire [3:0] mcu0_ncu_data;
wire mcu0_ncu_stall;
wire mcu0_ncu_vld;
wire [3:0] ncu_mcu0_data;
wire ncu_mcu0_stall;
wire ncu_mcu0_vld;
wire mcu0_ncu_ecc;
wire mcu0_ncu_fbr;
wire ncu_mcu0_ecci;
wire ncu_mcu0_fbui;
wire ncu_mcu0_fbri;
wire [119:0] mcu0_fsr0_data;
wire [119:0] mcu0_fsr1_data;
wire mcu0_fsr0_cfgpll_enpll;
wire mcu0_fsr1_cfgpll_enpll;
wire [1:0] mcu0_fsr01_cfgpll_lb;
wire [3:0] mcu0_fsr01_cfgpll_mpy;
wire mcu0_fsr0_cfgrx_enrx;
wire mcu0_fsr1_cfgrx_enrx;
wire mcu0_fsr0_cfgrx_align;
wire mcu0_fsr1_cfgrx_align;
wire [13:0] mcu0_fsr0_cfgrx_invpair;
wire [13:0] mcu0_fsr1_cfgrx_invpair;
wire [3:0] mcu0_fsr01_cfgrx_eq;
wire [2:0] mcu0_fsr01_cfgrx_cdr;
wire [2:0] mcu0_fsr01_cfgrx_term;
wire mcu0_fsr0_cfgtx_entx;
wire mcu0_fsr1_cfgtx_entx;
wire mcu0_fsr0_cfgtx_enidl;
wire mcu0_fsr1_cfgtx_enidl;
wire [9:0] mcu0_fsr0_cfgtx_invpair;
wire [9:0] mcu0_fsr1_cfgtx_invpair;
wire mcu0_fsr01_cfgtx_enftp;
wire [3:0] mcu0_fsr01_cfgtx_de;
wire [2:0] mcu0_fsr01_cfgtx_swing;
wire mcu0_fsr01_cfgtx_cm;
wire [1:0] mcu0_fsr01_cfgrtx_rate;
wire mcu0_fsr0_cfgrx_entest;
wire mcu0_fsr1_cfgrx_entest;
wire mcu0_fsr0_cfgtx_entest;
wire mcu0_fsr1_cfgtx_entest;
wire [9:0] mcu0_fsr0_cfgtx_bstx;
wire [9:0] mcu0_fsr1_cfgtx_bstx;
wire [167:0] fsr0_mcu0_data;
wire [167:0] fsr1_mcu0_data;
wire [13:0] fsr0_mcu0_rxbclk;
wire [13:0] fsr1_mcu0_rxbclk;
wire [2:0] fsr0_mcu0_stspll_lock;
wire [2:0] fsr1_mcu0_stspll_lock;
wire [11:0] mcu0_fsr0_testcfg;
wire [11:0] mcu0_fsr1_testcfg;
wire [13:0] fsr0_mcu0_stsrx_sync;
wire [13:0] fsr1_mcu0_stsrx_sync;
wire [13:0] fsr0_mcu0_stsrx_losdtct;
wire [13:0] fsr1_mcu0_stsrx_losdtct;
wire [13:0] fsr0_mcu0_stsrx_testfail;
wire [13:0] fsr1_mcu0_stsrx_testfail;
wire [13:0] fsr0_mcu0_stsrx_bsrxp;
wire [13:0] fsr1_mcu0_stsrx_bsrxp;
wire [13:0] fsr0_mcu0_stsrx_bsrxn;
wire [13:0] fsr1_mcu0_stsrx_bsrxn;
wire [9:0] fsr0_mcu0_ststx_testfail;
wire [9:0] fsr1_mcu0_ststx_testfail;
wire tcu_mcu0_mbist_scan_in;
wire mcu0_tcu_mbist_scan_out;
wire tcu_sbs_scan_in;
wire mcu0_sbs_scan_out;
wire mcu0_scan_out;
wire cmp_gclk_c4_mcu1;
wire gl_mcu1_dr_clk_stop;
wire gl_mcu1_clk_stop;
wire gl_mcu1_io_clk_stop;
wire dr_gclk_c4_mcu1;
wire tcu_mcu1_fbd_clk_stop;
wire [3:0] mcu1_ncu_data;
wire mcu1_ncu_stall;
wire mcu1_ncu_vld;
wire [3:0] ncu_mcu1_data;
wire ncu_mcu1_stall;
wire ncu_mcu1_vld;
wire mcu1_ncu_ecc;
wire mcu1_ncu_fbr;
wire ncu_mcu1_ecci;
wire ncu_mcu1_fbui;
wire ncu_mcu1_fbri;
wire [119:0] mcu1_fsr2_data;
wire [119:0] mcu1_fsr3_data;
wire mcu1_fsr2_cfgpll_enpll;
wire mcu1_fsr3_cfgpll_enpll;
wire [1:0] mcu1_fsr23_cfgpll_lb;
wire [3:0] mcu1_fsr23_cfgpll_mpy;
wire mcu1_fsr2_cfgrx_enrx;
wire mcu1_fsr3_cfgrx_enrx;
wire mcu1_fsr2_cfgrx_align;
wire mcu1_fsr3_cfgrx_align;
wire [13:0] mcu1_fsr2_cfgrx_invpair;
wire [13:0] mcu1_fsr3_cfgrx_invpair;
wire [3:0] mcu1_fsr23_cfgrx_eq;
wire [2:0] mcu1_fsr23_cfgrx_cdr;
wire [2:0] mcu1_fsr23_cfgrx_term;
wire mcu1_fsr2_cfgtx_entx;
wire mcu1_fsr3_cfgtx_entx;
wire mcu1_fsr2_cfgtx_enidl;
wire mcu1_fsr3_cfgtx_enidl;
wire [9:0] mcu1_fsr2_cfgtx_invpair;
wire [9:0] mcu1_fsr3_cfgtx_invpair;
wire mcu1_fsr23_cfgtx_enftp;
wire [3:0] mcu1_fsr23_cfgtx_de;
wire [2:0] mcu1_fsr23_cfgtx_swing;
wire mcu1_fsr23_cfgtx_cm;
wire [1:0] mcu1_fsr23_cfgrtx_rate;
wire mcu1_fsr2_cfgrx_entest;
wire mcu1_fsr3_cfgrx_entest;
wire mcu1_fsr2_cfgtx_entest;
wire mcu1_fsr3_cfgtx_entest;
wire [9:0] mcu1_fsr2_cfgtx_bstx;
wire [9:0] mcu1_fsr3_cfgtx_bstx;
wire [167:0] fsr2_mcu1_data;
wire [167:0] fsr3_mcu1_data;
wire [13:0] fsr2_mcu1_rxbclk;
wire [13:0] fsr3_mcu1_rxbclk;
wire [2:0] fsr2_mcu1_stspll_lock;
wire [2:0] fsr3_mcu1_stspll_lock;
wire [11:0] mcu1_fsr2_testcfg;
wire [11:0] mcu1_fsr3_testcfg;
wire [13:0] fsr2_mcu1_stsrx_sync;
wire [13:0] fsr3_mcu1_stsrx_sync;
wire [13:0] fsr2_mcu1_stsrx_losdtct;
wire [13:0] fsr3_mcu1_stsrx_losdtct;
wire [13:0] fsr2_mcu1_stsrx_testfail;
wire [13:0] fsr3_mcu1_stsrx_testfail;
wire [13:0] fsr2_mcu1_stsrx_bsrxp;
wire [13:0] fsr3_mcu1_stsrx_bsrxp;
wire [13:0] fsr2_mcu1_stsrx_bsrxn;
wire [13:0] fsr3_mcu1_stsrx_bsrxn;
wire [9:0] fsr2_mcu1_ststx_testfail;
wire [9:0] fsr3_mcu1_ststx_testfail;
wire tcu_mcu1_mbist_scan_in;
wire mcu1_tcu_mbist_scan_out;
wire mcu1_sbs_scan_out;
wire tcu_socc_scan_out;
wire mcu1_scan_out;
wire cmp_gclk_c0_mcu2;
wire gl_mcu2_dr_clk_stop;
wire gl_mcu2_io_clk_stop;
wire gl_mcu2_clk_stop;
wire dr_gclk_c0_mcu2;
wire gl_dr_sync_en_c1m;
wire tcu_mcu2_fbd_clk_stop;
wire [3:0] mcu2_ncu_data;
wire mcu2_ncu_stall;
wire mcu2_ncu_vld;
wire [3:0] ncu_mcu2_data;
wire ncu_mcu2_stall;
wire ncu_mcu2_vld;
wire mcu2_ncu_ecc;
wire mcu2_ncu_fbr;
wire ncu_mcu2_ecci;
wire ncu_mcu2_fbui;
wire ncu_mcu2_fbri;
wire [119:0] mcu2_fsr4_data;
wire [119:0] mcu2_fsr5_data;
wire mcu2_fsr4_cfgpll_enpll;
wire mcu2_fsr5_cfgpll_enpll;
wire [1:0] mcu2_fsr45_cfgpll_lb;
wire [3:0] mcu2_fsr45_cfgpll_mpy;
wire mcu2_fsr4_cfgrx_enrx;
wire mcu2_fsr5_cfgrx_enrx;
wire mcu2_fsr4_cfgrx_align;
wire mcu2_fsr5_cfgrx_align;
wire [13:0] mcu2_fsr4_cfgrx_invpair;
wire [13:0] mcu2_fsr5_cfgrx_invpair;
wire [3:0] mcu2_fsr45_cfgrx_eq;
wire [2:0] mcu2_fsr45_cfgrx_cdr;
wire [2:0] mcu2_fsr45_cfgrx_term;
wire mcu2_fsr4_cfgtx_entx;
wire mcu2_fsr5_cfgtx_entx;
wire mcu2_fsr4_cfgtx_enidl;
wire mcu2_fsr5_cfgtx_enidl;
wire [9:0] mcu2_fsr4_cfgtx_invpair;
wire [9:0] mcu2_fsr5_cfgtx_invpair;
wire mcu2_fsr45_cfgtx_enftp;
wire [3:0] mcu2_fsr45_cfgtx_de;
wire [2:0] mcu2_fsr45_cfgtx_swing;
wire mcu2_fsr45_cfgtx_cm;
wire [1:0] mcu2_fsr45_cfgrtx_rate;
wire mcu2_fsr4_cfgrx_entest;
wire mcu2_fsr5_cfgrx_entest;
wire mcu2_fsr4_cfgtx_entest;
wire mcu2_fsr5_cfgtx_entest;
wire [9:0] mcu2_fsr4_cfgtx_bstx;
wire [9:0] mcu2_fsr5_cfgtx_bstx;
wire [167:0] fsr4_mcu2_data;
wire [167:0] fsr5_mcu2_data;
wire [13:0] fsr4_mcu2_rxbclk;
wire [13:0] fsr5_mcu2_rxbclk;
wire [2:0] fsr4_mcu2_stspll_lock;
wire [2:0] fsr5_mcu2_stspll_lock;
wire [11:0] mcu2_fsr4_testcfg;
wire [11:0] mcu2_fsr5_testcfg;
wire [13:0] fsr4_mcu2_stsrx_sync;
wire [13:0] fsr5_mcu2_stsrx_sync;
wire [13:0] fsr4_mcu2_stsrx_losdtct;
wire [13:0] fsr5_mcu2_stsrx_losdtct;
wire [13:0] fsr4_mcu2_stsrx_testfail;
wire [13:0] fsr5_mcu2_stsrx_testfail;
wire [13:0] fsr4_mcu2_stsrx_bsrxp;
wire [13:0] fsr5_mcu2_stsrx_bsrxp;
wire [13:0] fsr4_mcu2_stsrx_bsrxn;
wire [13:0] fsr5_mcu2_stsrx_bsrxn;
wire [9:0] fsr4_mcu2_ststx_testfail;
wire [9:0] fsr5_mcu2_ststx_testfail;
wire tcu_mcu2_mbist_start;
wire mcu2_tcu_mbist_done;
wire mcu2_tcu_mbist_fail;
wire tcu_mcu2_mbist_scan_in;
wire mcu2_tcu_mbist_scan_out;
wire mcu3_sbs_scan_out;
wire mcu2_sbs_scan_out;
wire mcu2_scan_out;
wire cmp_gclk_c0_mcu3;
wire gl_mcu3_dr_clk_stop;
wire gl_mcu3_io_clk_stop;
wire gl_mcu3_clk_stop;
wire dr_gclk_c0_mcu3;
wire tcu_mcu3_fbd_clk_stop;
wire [3:0] mcu3_ncu_data;
wire mcu3_ncu_stall;
wire mcu3_ncu_vld;
wire [3:0] ncu_mcu3_data;
wire ncu_mcu3_stall;
wire ncu_mcu3_vld;
wire mcu3_ncu_ecc;
wire mcu3_ncu_fbr;
wire ncu_mcu3_ecci;
wire ncu_mcu3_fbui;
wire ncu_mcu3_fbri;
wire [119:0] mcu3_fsr6_data;
wire [119:0] mcu3_fsr7_data;
wire mcu3_fsr6_cfgpll_enpll;
wire mcu3_fsr7_cfgpll_enpll;
wire [1:0] mcu3_fsr67_cfgpll_lb;
wire [3:0] mcu3_fsr67_cfgpll_mpy;
wire mcu3_fsr6_cfgrx_enrx;
wire mcu3_fsr7_cfgrx_enrx;
wire mcu3_fsr6_cfgrx_align;
wire mcu3_fsr7_cfgrx_align;
wire [13:0] mcu3_fsr6_cfgrx_invpair;
wire [13:0] mcu3_fsr7_cfgrx_invpair;
wire [3:0] mcu3_fsr67_cfgrx_eq;
wire [2:0] mcu3_fsr67_cfgrx_cdr;
wire [2:0] mcu3_fsr67_cfgrx_term;
wire mcu3_fsr6_cfgtx_entx;
wire mcu3_fsr7_cfgtx_entx;
wire mcu3_fsr6_cfgtx_enidl;
wire mcu3_fsr7_cfgtx_enidl;
wire [9:0] mcu3_fsr6_cfgtx_invpair;
wire [9:0] mcu3_fsr7_cfgtx_invpair;
wire mcu3_fsr67_cfgtx_enftp;
wire [3:0] mcu3_fsr67_cfgtx_de;
wire [2:0] mcu3_fsr67_cfgtx_swing;
wire mcu3_fsr67_cfgtx_cm;
wire [1:0] mcu3_fsr67_cfgrtx_rate;
wire mcu3_fsr6_cfgrx_entest;
wire mcu3_fsr7_cfgrx_entest;
wire mcu3_fsr6_cfgtx_entest;
wire mcu3_fsr7_cfgtx_entest;
wire [9:0] mcu3_fsr6_cfgtx_bstx;
wire [9:0] mcu3_fsr7_cfgtx_bstx;
wire [167:0] fsr6_mcu3_data;
wire [167:0] fsr7_mcu3_data;
wire [13:0] fsr6_mcu3_rxbclk;
wire [13:0] fsr7_mcu3_rxbclk;
wire [2:0] fsr6_mcu3_stspll_lock;
wire [2:0] fsr7_mcu3_stspll_lock;
wire [11:0] mcu3_fsr6_testcfg;
wire [11:0] mcu3_fsr7_testcfg;
wire [13:0] fsr6_mcu3_stsrx_sync;
wire [13:0] fsr7_mcu3_stsrx_sync;
wire [13:0] fsr6_mcu3_stsrx_losdtct;
wire [13:0] fsr7_mcu3_stsrx_losdtct;
wire [13:0] fsr6_mcu3_stsrx_testfail;
wire [13:0] fsr7_mcu3_stsrx_testfail;
wire [13:0] fsr6_mcu3_stsrx_bsrxp;
wire [13:0] fsr7_mcu3_stsrx_bsrxp;
wire [13:0] fsr6_mcu3_stsrx_bsrxn;
wire [13:0] fsr7_mcu3_stsrx_bsrxn;
wire [9:0] fsr6_mcu3_ststx_testfail;
wire [9:0] fsr7_mcu3_ststx_testfail;
wire tcu_mcu3_mbist_start;
wire mcu3_tcu_mbist_done;
wire mcu3_tcu_mbist_fail;
wire tcu_mcu3_mbist_scan_in;
wire mcu3_tcu_mbist_scan_out;
wire ncu_scan_out;
wire mcu3_scan_out;
wire dr_gclk_c4_fsr0_2;
wire dr_gclk_c4_fsr0_1;
wire dr_gclk_c4_fsr0_0;
wire efu_mcu_fclk;
wire efu_mcu_fclrz;
wire efu_mcu_fdi;
wire [2:0] fsr0_fdo;
wire [2:0] fsr0_stciq;
wire tcu_stcid;
wire [7:0] mio_fsr_testclkr;
wire [7:0] mio_fsr_testclkt;
wire dr_gclk_c4_fsr1_2;
wire dr_gclk_c4_fsr1_1;
wire dr_gclk_c4_fsr1_0;
wire [2:0] fsr1_fdo;
wire [2:0] fsr1_stciq;
wire dr_gclk_c4_fsr2_2;
wire dr_gclk_c4_fsr2_1;
wire dr_gclk_c4_fsr2_0;
wire [2:0] fsr2_fdo;
wire [2:0] fsr2_stciq;
wire dr_gclk_c4_fsr3_2;
wire dr_gclk_c4_fsr3_1;
wire dr_gclk_c4_fsr3_0;
wire [2:0] fsr3_fdo;
wire [2:0] fsr3_stciq;
wire tcu_srd_atpgd;
wire fsr_left_atpgq;
wire dr_gclk_c0_fsr4_2;
wire dr_gclk_c0_fsr4_1;
wire dr_gclk_c0_fsr4_0;
wire [2:0] fsr4_fdo;
wire [2:0] fsr5_stciq;
wire [2:0] fsr4_stciq;
wire dr_gclk_c0_fsr5_2;
wire dr_gclk_c0_fsr5_1;
wire dr_gclk_c0_fsr5_0;
wire [2:0] fsr5_fdo;
wire [2:0] fsr6_stciq;
wire dr_gclk_c0_fsr6_2;
wire dr_gclk_c0_fsr6_1;
wire dr_gclk_c0_fsr6_0;
wire [2:0] fsr6_fdo;
wire [2:0] fsr7_stciq;
wire fsr_bottom_atpgq;
wire srd_tcu_atpgq;
wire dr_gclk_c2_fsr7_2;
wire dr_gclk_c2_fsr7_1;
wire dr_gclk_c2_fsr7_0;
wire [1:0] fsr7_fdo;
wire mcu_efu_fdo;
wire cmp_gclk_c3_sii;
wire gl_sii_clk_stop;
wire gl_sii_io_clk_stop;
wire sii_scan_out;
wire cmp_gclk_c1_sio;
wire gl_sio_clk_stop;
wire gl_sio_io_clk_stop;
wire sio_scan_out;
wire cmp_gclk_c3_ncu;
wire gl_ncu_io_clk_stop;
wire gl_ncu_clk_stop;
wire tcu_socg_scan_out;
wire cmp_gclk_c1_efu;
wire gl_efu_io_clk_stop;
wire gl_efu_clk_stop;
wire efu_scan_out;
wire [6:0] tcu_efu_rowaddr;
wire [4:0] tcu_efu_coladdr;
wire tcu_efu_read_en;
wire [2:0] tcu_efu_read_mode;
wire tcu_efu_read_start;
wire tcu_efu_fuse_bypass;
wire tcu_efu_dest_sample;
wire tcu_efu_data_in;
wire efu_tcu_data_out;
wire tcu_efu_updatedr;
wire tcu_efu_shiftdr;
wire tcu_efu_capturedr;
wire [6:0] tcu_efu_rvclr;
wire tck;
wire pcmb1_out;
wire pcma_out;
wire cmp_gclk_c3_rng;
wire rng_arst_l;
wire [1:0] rng_ch_sel;
wire rng_bypass;
wire mio_ccu_vreg_selbg_l;
wire [1:0] rng_vcoctrl_sel;
wire [1:0] rng_anlg_sel;
wire l2clk;
wire drl2clk;
wire cmp_gclk_c1_ccu;
wire rst_scan_out;
wire ccu_scan_out;
wire cmp_gclk_c1_tcu;
wire rst_tcu_pwron_rst_l;
wire ncu_spc0_core_enable_status;
wire ncu_spc1_core_enable_status;
wire ncu_spc2_core_enable_status;
wire ncu_spc3_core_enable_status;
wire ncu_spc4_core_enable_status;
wire ncu_spc5_core_enable_status;
wire ncu_spc6_core_enable_status;
wire ncu_spc7_core_enable_status;
wire dmu_scan_out;
wire peu_scan_out;
wire tcu_socd_scan_out;
wire tcu_peu_scan_out;
wire gl_dmu_peu_por_c3b;
wire gl_dmu_peu_wmr_c3b;
wire tcu_array_bypass;
wire sii_dmu_wrack_parity;
wire cmp_gclk_c3_dmu;
wire gl_dmu_io_clk_stop;
wire gl_io_out_c3b;
wire cmp_gclk_c3_peu;
wire gl_peu_io_clk_stop;
wire psr_peu_txbclk0;
wire [1:0] dmu_psr_rate_scale;
wire [3:0] peu_psr_pll_mpy;
wire [1:0] peu_psr_pll_lb;
wire psr_stciq_sds0;
wire efu_psr_fclk;
wire efu_psr_fclrz;
wire efu_psr_fdi;
wire psr_fdo_sds0;
wire psr_efu_fdo;
wire psr_peu_rxbclk_b3sds1;
wire psr_peu_rxbclk_b2sds1;
wire psr_peu_rxbclk_b1sds1;
wire psr_peu_rxbclk_b0sds1;
wire psr_peu_rxbclk_b3sds0;
wire psr_peu_rxbclk_b2sds0;
wire psr_peu_rxbclk_b1sds0;
wire psr_peu_rxbclk_b0sds0;
wire tcu_rst_scan_out;
wire gl_rst_io_clk_stop;
wire gl_rst_clk_stop;
wire stg1_ccx_clk_stop_c1b;
wire stg1_cmp_io_sync_en_c1b;
wire stg1_cmp_io_sync_en_c1t;
wire stg1_db0_clk_stop_c1b;
wire stg1_dmu_io_clk_stop_c1b;
wire stg1_dmu_peu_por_c1b;
wire stg1_dmu_peu_wmr_c1b;
wire stg1_dr_sync_en_c1t;
wire stg1_io2x_out_c1b;
wire stg1_io_cmp_sync_en_c1b;
wire stg1_io_cmp_sync_en_c1t;
wire stg1_io_out_c1b;
wire stg1_io_out_c1t;
wire stg1_rst_l2_por_c1b;
wire stg1_rst_l2_por_c1t;
wire stg1_rst_l2_wmr_c1b;
wire stg1_rst_l2_wmr_c1t;
wire stg1_l2b0_clk_stop_c1t;
wire stg1_l2b1_clk_stop_c1t;
wire stg1_l2b2_clk_stop_c1b;
wire stg1_l2b3_clk_stop_c1b;
wire stg1_l2b4_clk_stop_c1t;
wire stg1_l2b5_clk_stop_c1t;
wire stg1_l2d0_clk_stop_c1t;
wire stg1_l2d1_clk_stop_c1t;
wire stg1_l2d2_clk_stop_c1b;
wire stg1_l2d3_clk_stop_c1b;
wire stg1_l2d4_clk_stop_c1t;
wire stg1_l2d5_clk_stop_c1t;
wire stg1_l2d7_clk_stop_c1b;
wire stg1_l2t0_clk_stop_c1t;
wire stg1_l2t1_clk_stop_c1t;
wire stg1_l2t2_clk_stop_c1b;
wire stg1_l2t3_clk_stop_c1b;
wire stg1_l2t5_clk_stop_c1t;
wire stg1_l2t7_clk_stop_c1b;
wire stg1_mac_io_clk_stop_c1b;
wire stg1_mcu0_clk_stop_c1t;
wire stg1_mcu0_dr_clk_stop_c1t;
wire stg1_mcu0_io_clk_stop_c1t;
wire stg1_mcu1_clk_stop_c1t;
wire stg1_mcu1_dr_clk_stop_c1t;
wire stg1_mcu1_io_clk_stop_c1t;
wire stg1_mio_clk_stop_c1t;
wire stg1_io2x_sync_en_c1t;
wire stg1_ncu_clk_stop_c1b;
wire stg1_ncu_io_clk_stop_c1b;
wire stg1_peu_io_clk_stop_c1b;
wire stg1_rdp_io_clk_stop_c1b;
wire stg1_rst_niu_mac_c1b;
wire stg1_rst_niu_wmr_c1b;
wire stg1_tds_io_clk_stop_c1b;
wire stg1_rtx_io_clk_stop_c1b;
wire stg1_sii_clk_stop_c1b;
wire stg1_sii_io_clk_stop_c1b;
wire stg4_cmp_io_sync_en_c3t;
wire stg4_io_cmp_sync_en_c3t;
wire stg4_io_out_c3b;
wire stg4_l2_por_c3t;
wire stg4_l2_wmr_c3t;
wire stg1_spc0_clk_stop_c1t;
wire stg1_spc1_clk_stop_c1t;
wire stg1_spc2_clk_stop_c1b;
wire stg1_spc3_clk_stop_c1b;
wire stg1_spc4_clk_stop_c1t;
wire stg1_spc5_clk_stop_c1t;
wire stg1_spc6_clk_stop_c1b;
wire stg1_spc7_clk_stop_c1b;
wire stg2_ccx_clk_stop_c1b;
wire stg2_cmp_io_sync_en_c1b;
wire stg2_cmp_io_sync_en_c1t;
wire stg2_db0_clk_stop_c1b;
wire stg2_dmu_io_clk_stop_c1b;
wire stg2_dmu_peu_por_c1b;
wire stg2_dmu_peu_wmr_c1b;
wire stg2_dr_sync_en_c1t;
wire stg2_io_cmp_sync_en_c1b;
wire stg2_io_cmp_sync_en_c1t;
wire stg2_io_out_c1t;
wire stg2_io_out_c1b;
wire stg2_l2_por_c1b;
wire stg2_l2_por_c1t;
wire stg2_l2_wmr_c1b;
wire stg2_l2_wmr_c1t;
wire stg2_l2b0_clk_stop_c1t;
wire stg2_l2b1_clk_stop_c1t;
wire stg2_l2b2_clk_stop_c1b;
wire stg2_l2b3_clk_stop_c1b;
wire stg2_l2d0_clk_stop_c1t;
wire stg2_l2d1_clk_stop_c1t;
wire stg2_l2d2_clk_stop_c1b;
wire stg2_l2d3_clk_stop_c1b;
wire stg2_l2t0_clk_stop_c1t;
wire stg2_l2t1_clk_stop_c1t;
wire stg2_l2t2_clk_stop_c1b;
wire stg2_l2t3_clk_stop_c1b;
wire stg2_l2t5_clk_stop_c1t;
wire stg2_l2t7_clk_stop_c1b;
wire stg2_mio_io2x_sync_en_c1t;
wire stg2_mio_clk_stop_c1t;
wire stg2_ncu_clk_stop_c1b;
wire stg2_ncu_io_clk_stop_c1b;
wire stg2_peu_io_clk_stop_c1b;
wire stg2_sii_clk_stop_c1b;
wire stg2_sii_io_clk_stop_c1b;
wire stg2_spc0_clk_stop_c1t;
wire stg2_spc1_clk_stop_c1t;
wire stg2_spc2_clk_stop_c1b;
wire stg2_spc3_clk_stop_c1b;
wire stg2_spc5_clk_stop_c1t;
wire stg2_spc7_clk_stop_c1b;
wire stg3_ccx_clk_stop_c2b;
wire stg3_cmp_io_sync_en_c2b;
wire stg3_cmp_io_sync_en_c2t;
wire stg3_db0_clk_stop_c2b;
wire stg3_dmu_io_clk_stop_c2b;
wire stg3_dmu_peu_por_c2b;
wire stg3_dmu_peu_wmr_c2b;
wire stg3_dr_sync_en_c2t;
wire stg3_mio_io2x_sync_en_c2t;
wire stg3_io_cmp_sync_en_c2b;
wire stg3_io_cmp_sync_en_c2t;
wire stg3_io_out_c2b;
wire stg3_io_out_c2t;
wire stg3_l2_por_c2b;
wire stg3_l2_por_c2t;
wire stg3_l2_wmr_c2b;
wire stg3_l2_wmr_c2t;
wire stg3_l2b0_clk_stop_c2t;
wire stg3_l2b1_clk_stop_c2t;
wire stg3_l2b2_clk_stop_c2b;
wire stg3_l2b3_clk_stop_c2b;
wire stg3_l2d0_clk_stop_c2t;
wire stg3_l2d1_clk_stop_c2t;
wire stg3_l2d2_clk_stop_c2b;
wire stg3_l2d3_clk_stop_c2b;
wire stg3_l2t0_clk_stop_c2t;
wire stg3_l2t1_clk_stop_c2t;
wire stg3_l2t2_clk_stop_c2b;
wire stg3_l2t3_clk_stop_c2b;
wire stg3_l2t5_clk_stop_c2t;
wire stg3_l2t7_clk_stop_c2b;
wire stg3_mcu0_clk_stop_c2t;
wire stg2_mcu0_dr_clk_stop_c2b;
wire stg3_mcu0_io_clk_stop_c2t;
wire stg3_mcu1_clk_stop_c2t;
wire stg2_mcu1_dr_clk_stop_c2b;
wire stg3_mcu1_io_clk_stop_c2t;
wire stg3_mio_clk_stop_c2t;
wire stg3_ncu_clk_stop_c2b;
wire stg3_ncu_io_clk_stop_c2b;
wire stg3_peu_io_clk_stop_c2b;
wire stg3_sii_clk_stop_c2b;
wire stg3_sii_io_clk_stop_c2b;
wire stg3_spc0_clk_stop_c2t;
wire stg3_spc1_clk_stop_c2t;
wire stg3_spc2_clk_stop_c2b;
wire stg3_spc3_clk_stop_c2b;
wire stg3_spc5_clk_stop_c2t;
wire stg3_spc7_clk_stop_c2b;
wire stg4_cmp_io_sync_en_c3b;
wire stg4_db0_clk_stop_c3b;
wire stg4_dmu_io_clk_stop_c3b;
wire stg4_dmu_peu_por_c3b;
wire stg4_dmu_peu_wmr_c3b;
wire stg4_dr_sync_en_c3t;
wire stg4_mio_io2x_sync_en_c3t;
wire stg4_io_cmp_sync_en_c3b;
wire stg4_io_out_c3t;
wire stg4_l2_por_c3b;
wire stg4_l2_wmr_c3b;
wire stg4_l2b0_clk_stop_c3t;
wire stg4_l2b1_clk_stop_c3t;
wire stg4_l2b2_clk_stop_c3b;
wire stg4_l2b3_clk_stop_c3b;
wire stg4_l2d0_clk_stop_c3t;
wire stg4_l2d1_clk_stop_c3t;
wire stg4_l2d2_clk_stop_c3b;
wire stg4_l2d3_clk_stop_c3b;
wire stg4_l2t0_clk_stop_c3t;
wire stg4_l2t2_clk_stop_c3b;
wire stg4_mcu0_clk_stop_c3t;
wire stg4_mcu0_io_clk_stop_c3t;
wire stg4_mcu1_clk_stop_c3t;
wire stg4_mcu1_io_clk_stop_c3t;
wire stg4_mio_clk_stop_c3t;
wire stg4_ncu_clk_stop_c3b;
wire stg4_ncu_io_clk_stop_c3b;
wire stg4_peu_io_clk_stop_c3b;
wire stg4_sii_clk_stop_c3b;
wire stg4_sii_io_clk_stop_c3b;
wire stg4_spc0_clk_stop_c3t;
wire stg4_spc2_clk_stop_c3b;
wire stg2_mcu0_io_clk_stop_c1t;
wire stg2_mcu1_io_clk_stop_c1t;
wire stg1_io2x_sync_en_c1b;
wire stg2_mcu0_clk_stop_c1t;
wire stg2_mcu1_clk_stop_c1t;
wire stg3_io2x_sync_en_c2t;
wire tcu_atpg_mode;
wire ccu_mio_serdes_dtm;
wire tcu_mio_tdo;
wire tcu_mio_tdo_en;
wire tcu_mio_stciq;
wire mio_tcu_stcid;
wire [1:0] mio_tcu_stcicfg;
wire mio_tcu_stciclk;
wire mio_tcu_divider_bypass;
wire mio_tcu_pll_cmp_bypass;
wire mio_tcu_scan_in31;
wire tcu_mio_scan_out31;
wire [7:0] peu_mio_debug_bus_a;
wire [7:0] peu_mio_debug_bus_b;
wire [63:0] peu_mio_pipe_txdata;
wire [7:0] peu_mio_pipe_txdatak;
wire peu_mio_debug_clk;
wire mio_ccu_pll_char_in;
wire [5:0] mio_ccu_pll_div2;
wire mio_ccu_pll_trst_l;
wire mio_ccu_pll_clamp_fltr;
wire [6:0] mio_ccu_pll_div4;
wire mio_ext_dr_clk;
wire mio_ext_cmp_clk;
wire [1:0] ccu_mio_pll_char_out;
wire mio_tcu_io_ac_testmode;
wire mio_tcu_io_ac_testtrig;
wire mio_tcu_io_aclk;
wire mio_tcu_io_bclk;
wire [30:0] mio_tcu_io_scan_in;
wire mio_tcu_peu_clk_ext;
wire [5:0] mio_tcu_niu_clk_ext;
wire mio_tcu_io_scan_en;
wire [30:0] tcu_mio_pins_scan_out;
wire [39:0] tcu_mio_dmo_data;
wire tcu_mio_mbist_done;
wire tcu_mio_mbist_fail;
wire tcu_mio_dmo_sync;
wire mio_tcu_trigin;
wire tcu_mio_trigout;
wire rst_mio_pex_reset_l;
wire [5:0] rst_mio_rst_state;
wire mio_rst_pb_rst_l;
wire mio_rst_button_xir_l;
wire mio_rst_pwron_rst_l;
wire ncu_mio_ssi_mosi;
wire mio_ncu_ssi_miso;
wire ncu_mio_ssi_sck;
wire mio_ncu_ext_int_l;
wire rst_mio_ssi_sync_l;
wire tcu_mio_bs_scan_in;
wire tcu_mio_bs_highz_l;
wire mio_tcu_bs_scan_out;
wire tcu_mio_bs_scan_en;
wire tcu_mio_bs_clk;
wire tcu_mio_bs_aclk;
wire tcu_mio_bs_bclk;
wire tcu_mio_bs_uclk;
wire tcu_mio_bs_mode_ctl;
wire tcu_dbr_gateoff;
wire ncu_spc_l2_idx_hash_en;
wire cmp_gclk_c2_ccx_left;
wire cmp_gclk_c2_ccx_right;
wire ncu_l2t_pm;
wire ncu_l2t_ba01;
wire ncu_l2t_ba23;
wire ncu_l2t_ba45;
wire ncu_l2t_ba67;
wire ncu_mcu_pm;
wire ncu_mcu_ba01;
wire ncu_mcu_ba23;
wire ncu_mcu_ba45;
wire ncu_mcu_ba67;
wire rst_mcu_selfrsh;
wire tcu_mcu_testmode;
wire ccu_serdes_dtm;
wire tcu_sii_mbist_scan_in;
wire sii_tcu_mbist_scan_out;
wire ncu_sii_niuctag_uei;
wire ncu_sii_niuctag_cei;
wire ncu_sii_niua_pei;
wire ncu_sii_niud_pei;
wire ncu_sii_dmuctag_uei;
wire ncu_sii_dmuctag_cei;
wire ncu_sii_dmua_pei;
wire ncu_sii_dmud_pei;
wire ncu_sii_gnt;
wire ncu_sii_pm;
wire ncu_sii_ba01;
wire ncu_sii_ba23;
wire ncu_sii_ba45;
wire ncu_sii_ba67;
wire ncu_sii_l2_idx_hash_en;
wire sii_ncu_niuctag_ue;
wire sii_ncu_niuctag_ce;
wire sii_ncu_niua_pe;
wire sii_ncu_niud_pe;
wire sii_ncu_dmuctag_ue;
wire sii_ncu_dmuctag_ce;
wire sii_ncu_dmua_pe;
wire sii_ncu_dmud_pe;
wire [3:0] sii_ncu_syn_data;
wire sii_ncu_syn_vld;
wire [1:0] sii_ncu_dparity;
wire [31:0] sii_ncu_data;
wire sii_ncu_req;
wire [7:0] dmu_sii_parity;
wire dmu_sii_be_parity;
wire sii_dmu_wrack_vld;
wire [3:0] sii_dmu_wrack_tag;
wire sio_sii_opcc_ipcc_niu_by_deq;
wire [3:0] sio_sii_opcc_ipcc_niu_by_cnt;
wire sio_sii_opcc_ipcc_niu_or_deq;
wire sio_sii_opcc_ipcc_dmu_by_deq;
wire [3:0] sio_sii_opcc_ipcc_dmu_by_cnt;
wire sio_sii_opcc_ipcc_dmu_or_deq;
wire sio_sii_olc0_ilc0_dequeue;
wire sio_sii_olc1_ilc1_dequeue;
wire sio_sii_olc2_ilc2_dequeue;
wire sio_sii_olc3_ilc3_dequeue;
wire sio_sii_olc4_ilc4_dequeue;
wire sio_sii_olc5_ilc5_dequeue;
wire sio_sii_olc6_ilc6_dequeue;
wire sio_sii_olc7_ilc7_dequeue;
wire sio_tcu_vld;
wire sio_tcu_data;
wire [1:0] tcu_sio_mbist_start;
wire [1:0] sio_tcu_mbist_done;
wire [1:0] sio_tcu_mbist_fail;
wire tcu_sio_mbist_scan_in;
wire sio_tcu_mbist_scan_out;
wire sio_dmu_hdr_vld;
wire [127:0] sio_dmu_data;
wire [7:0] sio_dmu_parity;
wire sio_ncu_ctag_ue;
wire sio_ncu_ctag_ce;
wire ncu_sio_ctag_cei;
wire ncu_sio_ctag_uei;
wire ncu_sio_d_pei;
wire tcu_ncu_mbist_scan_in;
wire ncu_tcu_mbist_scan_out;
wire [63:0] ncu_dmu_pio_data;
wire ncu_dmu_pio_hdr_vld;
wire ncu_dmu_mmu_addr_vld;
wire ncu_dmu_mondo_ack;
wire ncu_dmu_mondo_nack;
wire [5:0] ncu_dmu_mondo_id;
wire ncu_dmu_vld;
wire [31:0] ncu_dmu_data;
wire ncu_dmu_stall;
wire ncu_ccu_vld;
wire [3:0] ncu_ccu_data;
wire [3:0] ccu_ncu_data;
wire ccu_ncu_vld;
wire ccu_ncu_stall;
wire ncu_ccu_stall;
wire ncu_tcu_vld;
wire [7:0] ncu_tcu_data;
wire tcu_ncu_stall;
wire tcu_ncu_vld;
wire [7:0] tcu_ncu_data;
wire ncu_tcu_stall;
wire ncu_rst_vld;
wire [3:0] ncu_rst_data;
wire rst_ncu_stall;
wire rst_ncu_vld;
wire [3:0] rst_ncu_data;
wire ncu_rst_stall;
wire efu_ncu_fuse_data;
wire efu_ncu_srlnum0_xfer_en;
wire efu_ncu_srlnum1_xfer_en;
wire efu_ncu_srlnum2_xfer_en;
wire efu_ncu_fusestat_xfer_en;
wire efu_ncu_coreavl_xfer_en;
wire efu_ncu_bankavl_xfer_en;
wire rst_ncu_unpark_thread;
wire rst_ncu_xir_;
wire ncu_rst_xir_done;
wire ncu_spc0_core_available;
wire ncu_spc1_core_available;
wire ncu_spc2_core_available;
wire ncu_spc3_core_available;
wire ncu_spc4_core_available;
wire ncu_spc5_core_available;
wire ncu_spc6_core_available;
wire ncu_spc7_core_available;
wire ncu_rst_fatal_error;
wire [7:0] ncu_tcu_bank_avail;
wire tcu_sck_bypass;
wire dmu_ncu_wrack_par;
wire ncu_dmu_mondo_id_par;
wire dmu_ncu_d_pe;
wire ncu_dmu_d_pei;
wire dmu_ncu_siicr_pe;
wire ncu_dmu_siicr_pei;
wire dmu_ncu_ctag_ue;
wire ncu_dmu_ctag_uei;
wire dmu_ncu_ctag_ce;
wire ncu_dmu_ctag_cei;
wire dmu_ncu_ncucr_pe;
wire ncu_dmu_ncucr_pei;
wire dmu_ncu_ie;
wire ncu_dmu_iei;
wire efu_dmu_data;
wire efu_dmu_xfer_en;
wire efu_dmu_clr;
wire dmu_efu_xfer_en;
wire dmu_efu_data;
wire rng_data;
wire ccu_vco_aligned;
wire gclk_aligned;
wire ccu_cmp_io_sync_en;
wire ccu_io_cmp_sync_en;
wire ccu_io2x_sync_en;
wire ccu_dr_sync_en;
wire ccu_io2x_out;
wire ccu_io_out;
wire gl_ccu_io_clk_stop;
wire gl_ccu_clk_stop;
wire [1:0] tcu_ccu_mux_sel;
wire tcu_ccu_ext_cmp_clk;
wire tcu_ccu_ext_dr_clk;
wire tcu_ccu_clk_stretch;
wire rst_ccu_pll_;
wire rst_ccu_;
wire ccu_rst_change;
wire ccu_rst_sys_clk;
wire ccu_rst_sync_stable;
wire ccu_sys_cmp_sync_en;
wire ccu_cmp_sys_sync_en;
wire tcu_ccu_clk_stop;
wire tcu_ccu_io_clk_stop;
wire [3:0] jtag_revid_out;
wire tcu_spc0_clk_stop;
wire tcu_spc1_clk_stop;
wire tcu_spc2_clk_stop;
wire tcu_spc3_clk_stop;
wire tcu_spc4_clk_stop;
wire tcu_spc5_clk_stop;
wire tcu_spc6_clk_stop;
wire tcu_spc7_clk_stop;
wire tcu_l2d0_clk_stop;
wire tcu_l2d1_clk_stop;
wire tcu_l2d2_clk_stop;
wire tcu_l2d3_clk_stop;
wire tcu_l2d4_clk_stop;
wire tcu_l2d5_clk_stop;
wire tcu_l2d6_clk_stop;
wire tcu_l2d7_clk_stop;
wire tcu_l2t0_clk_stop;
wire tcu_l2t1_clk_stop;
wire tcu_l2t2_clk_stop;
wire tcu_l2t3_clk_stop;
wire tcu_l2t4_clk_stop;
wire tcu_l2t5_clk_stop;
wire tcu_l2t6_clk_stop;
wire tcu_l2t7_clk_stop;
wire tcu_l2b0_clk_stop;
wire tcu_l2b1_clk_stop;
wire tcu_l2b2_clk_stop;
wire tcu_l2b3_clk_stop;
wire tcu_l2b4_clk_stop;
wire tcu_l2b5_clk_stop;
wire tcu_l2b6_clk_stop;
wire tcu_l2b7_clk_stop;
wire tcu_mcu0_clk_stop;
wire tcu_mcu0_dr_clk_stop;
wire tcu_mcu0_io_clk_stop;
wire tcu_mcu1_clk_stop;
wire tcu_mcu1_dr_clk_stop;
wire tcu_mcu1_io_clk_stop;
wire tcu_mcu2_clk_stop;
wire tcu_mcu2_dr_clk_stop;
wire tcu_mcu2_io_clk_stop;
wire tcu_mcu3_clk_stop;
wire tcu_mcu3_dr_clk_stop;
wire tcu_mcu3_io_clk_stop;
wire tcu_ccx_clk_stop;
wire tcu_sii_clk_stop;
wire tcu_sii_io_clk_stop;
wire tcu_sio_clk_stop;
wire tcu_sio_io_clk_stop;
wire tcu_ncu_clk_stop;
wire tcu_ncu_io_clk_stop;
wire tcu_efu_clk_stop;
wire tcu_efu_io_clk_stop;
wire tcu_rst_clk_stop;
wire tcu_rst_io_clk_stop;
wire tcu_dmu_io_clk_stop;
wire tcu_rdp_io_clk_stop;
wire tcu_mac_io_clk_stop;
wire tcu_rtx_io_clk_stop;
wire tcu_tds_io_clk_stop;
wire tcu_peu_pc_clk_stop;
wire tcu_peu_io_clk_stop;
wire tcu_rst_efu_done;
wire tcu_test_protect;
wire [1:0] tcu_dmu_mbist_start;
wire tcu_dmu_mbist_scan_in;
wire [1:0] dmu_tcu_mbist_done;
wire [1:0] dmu_tcu_mbist_fail;
wire dmu_tcu_mbist_scan_out;
wire tcu_peu_mbist_start;
wire tcu_peu_mbist_scan_in;
wire peu_tcu_mbist_done;
wire peu_tcu_mbist_fail;
wire peu_tcu_mbist_scan_out;
wire rst_tcu_flush_init_req;
wire rst_tcu_flush_stop_req;
wire rst_tcu_asicflush_stop_req;
wire tcu_rst_asicflush_stop_ack;
wire tcu_rst_flush_init_ack;
wire tcu_rst_flush_stop_ack;
wire tcu_bisx_done;
wire tcu_rst_scan_mode;
wire rst_tcu_clk_stop;
wire rst_tcu_dbr_gen;
wire tcu_mio_clk_stop;
wire tcu_peu_entestcfg;
wire tcu_peu_clk_ext;
wire tcu_peu_testmode;
wire tcu_db0_clk_stop;
wire tcu_db1_clk_stop;
wire p2d_ce_int;
wire p2d_csr_ack;
wire [95:0] p2d_csr_rcd;
wire p2d_csr_req;
wire p2d_cto_req;
wire [4:0] p2d_cto_tag;
wire p2d_drain;
wire [7:0] p2d_ecd_rptr;
wire [5:0] p2d_ech_rptr;
wire [7:0] p2d_erd_rptr;
wire [5:0] p2d_erh_rptr;
wire p2d_ibc_ack;
wire [127:0] p2d_idb_data;
wire [3:0] p2d_idb_dpar;
wire [127:0] p2d_ihb_data;
wire [3:0] p2d_ihb_dpar;
wire d2p_ihb_rd;
wire d2p_idb_rd;
wire [6:0] p2d_ihb_wptr;
wire [2:0] p2d_mps;
wire p2d_oe_int;
wire [4:0] p2d_spare;
wire p2d_ue_int;
wire p2d_npwr_stall_en;
wire rst_dmu_async_por_;
wire d2p_csr_ack;
wire [95:0] d2p_csr_rcd;
wire d2p_csr_req;
wire d2p_cto_ack;
wire [5:0] d2p_ech_wptr;
wire [7:0] d2p_edb_addr;
wire [127:0] d2p_edb_data;
wire [3:0] d2p_edb_dpar;
wire d2p_edb_we;
wire [5:0] d2p_ehb_addr;
wire [127:0] d2p_ehb_data;
wire [3:0] d2p_ehb_dpar;
wire d2p_ehb_we;
wire [5:0] d2p_erh_wptr;
wire [7:0] d2p_ibc_nhc;
wire [11:0] d2p_ibc_pdc;
wire [7:0] d2p_ibc_phc;
wire d2p_ibc_req;
wire [7:0] d2p_idb_addr;
wire [5:0] d2p_ihb_addr;
wire [4:0] d2p_spare;
wire dmu_psr_pll_en_sds0;
wire dmu_psr_pll_en_sds1;
wire dmu_psr_rx_en_b0_sds0;
wire dmu_psr_rx_en_b1_sds0;
wire dmu_psr_rx_en_b2_sds0;
wire dmu_psr_rx_en_b3_sds0;
wire dmu_psr_rx_en_b0_sds1;
wire dmu_psr_rx_en_b1_sds1;
wire dmu_psr_rx_en_b2_sds1;
wire dmu_psr_rx_en_b3_sds1;
wire dmu_psr_tx_en_b0_sds0;
wire dmu_psr_tx_en_b1_sds0;
wire dmu_psr_tx_en_b2_sds0;
wire dmu_psr_tx_en_b3_sds0;
wire dmu_psr_tx_en_b0_sds1;
wire dmu_psr_tx_en_b1_sds1;
wire dmu_psr_tx_en_b2_sds1;
wire dmu_psr_tx_en_b3_sds1;
wire [15:0] d2p_req_id;
wire [9:0] psr_peu_rd_b0sds0;
wire [9:0] psr_peu_rd_b1sds0;
wire [9:0] psr_peu_rd_b2sds0;
wire [9:0] psr_peu_rd_b3sds0;
wire [9:0] psr_peu_rd_b0sds1;
wire [9:0] psr_peu_rd_b1sds1;
wire [9:0] psr_peu_rd_b2sds1;
wire [9:0] psr_peu_rd_b3sds1;
wire psr_peu_bsrxn_b0sds0;
wire psr_peu_bsrxn_b1sds0;
wire psr_peu_bsrxn_b2sds0;
wire psr_peu_bsrxn_b3sds0;
wire psr_peu_bsrxn_b0sds1;
wire psr_peu_bsrxn_b1sds1;
wire psr_peu_bsrxn_b2sds1;
wire psr_peu_bsrxn_b3sds1;
wire psr_peu_bsrxp_b0sds0;
wire psr_peu_bsrxp_b1sds0;
wire psr_peu_bsrxp_b2sds0;
wire psr_peu_bsrxp_b3sds0;
wire psr_peu_bsrxp_b0sds1;
wire psr_peu_bsrxp_b1sds1;
wire psr_peu_bsrxp_b2sds1;
wire psr_peu_bsrxp_b3sds1;
wire psr_peu_losdtct_b0sds0;
wire psr_peu_losdtct_b1sds0;
wire psr_peu_losdtct_b2sds0;
wire psr_peu_losdtct_b3sds0;
wire psr_peu_losdtct_b0sds1;
wire psr_peu_losdtct_b1sds1;
wire psr_peu_losdtct_b2sds1;
wire psr_peu_losdtct_b3sds1;
wire psr_peu_sync_b0sds0;
wire psr_peu_sync_b1sds0;
wire psr_peu_sync_b2sds0;
wire psr_peu_sync_b3sds0;
wire psr_peu_sync_b0sds1;
wire psr_peu_sync_b1sds1;
wire psr_peu_sync_b2sds1;
wire psr_peu_sync_b3sds1;
wire psr_peu_rx_tstfail_b0sds0;
wire psr_peu_rx_tstfail_b1sds0;
wire psr_peu_rx_tstfail_b2sds0;
wire psr_peu_rx_tstfail_b3sds0;
wire psr_peu_rx_tstfail_b0sds1;
wire psr_peu_rx_tstfail_b1sds1;
wire psr_peu_rx_tstfail_b2sds1;
wire psr_peu_rx_tstfail_b3sds1;
wire psr_peu_rdtcip_b0sds0;
wire psr_peu_rdtcip_b1sds0;
wire psr_peu_rdtcip_b2sds0;
wire psr_peu_rdtcip_b3sds0;
wire psr_peu_rdtcip_b0sds1;
wire psr_peu_rdtcip_b1sds1;
wire psr_peu_rdtcip_b2sds1;
wire psr_peu_rdtcip_b3sds1;
wire psr_peu_tx_tstfail_b0sds0;
wire psr_peu_tx_tstfail_b1sds0;
wire psr_peu_tx_tstfail_b2sds0;
wire psr_peu_tx_tstfail_b3sds0;
wire psr_peu_tx_tstfail_b0sds1;
wire psr_peu_tx_tstfail_b1sds1;
wire psr_peu_tx_tstfail_b2sds1;
wire psr_peu_tx_tstfail_b3sds1;
wire psr_peu_lock_sds0;
wire psr_peu_lock_sds1;
wire [9:0] peu_psr_td_b0sds0;
wire [9:0] peu_psr_td_b1sds0;
wire [9:0] peu_psr_td_b2sds0;
wire [9:0] peu_psr_td_b3sds0;
wire [9:0] peu_psr_td_b0sds1;
wire [9:0] peu_psr_td_b1sds1;
wire [9:0] peu_psr_td_b2sds1;
wire [9:0] peu_psr_td_b3sds1;
wire peu_psr_invpair_b0sds0;
wire peu_psr_invpair_b1sds0;
wire peu_psr_invpair_b2sds0;
wire peu_psr_invpair_b3sds0;
wire peu_psr_invpair_b0sds1;
wire peu_psr_invpair_b1sds1;
wire peu_psr_invpair_b2sds1;
wire peu_psr_invpair_b3sds1;
wire [15:0] peu_psr_rx_lane_ctl_0;
wire [15:0] peu_psr_rx_lane_ctl_1;
wire [15:0] peu_psr_rx_lane_ctl_2;
wire [15:0] peu_psr_rx_lane_ctl_3;
wire [15:0] peu_psr_rx_lane_ctl_4;
wire [15:0] peu_psr_rx_lane_ctl_5;
wire [15:0] peu_psr_rx_lane_ctl_6;
wire [15:0] peu_psr_rx_lane_ctl_7;
wire [1:0] peu_psr_rdtct_b0sds0;
wire [1:0] peu_psr_rdtct_b1sds0;
wire [1:0] peu_psr_rdtct_b2sds0;
wire [1:0] peu_psr_rdtct_b3sds0;
wire [1:0] peu_psr_rdtct_b0sds1;
wire [1:0] peu_psr_rdtct_b1sds1;
wire [1:0] peu_psr_rdtct_b2sds1;
wire [1:0] peu_psr_rdtct_b3sds1;
wire peu_psr_enidl_b0sds0;
wire peu_psr_enidl_b1sds0;
wire peu_psr_enidl_b2sds0;
wire peu_psr_enidl_b3sds0;
wire peu_psr_enidl_b0sds1;
wire peu_psr_enidl_b1sds1;
wire peu_psr_enidl_b2sds1;
wire peu_psr_enidl_b3sds1;
wire peu_psr_bstx_b0sds0;
wire peu_psr_bstx_b1sds0;
wire peu_psr_bstx_b2sds0;
wire peu_psr_bstx_b3sds0;
wire peu_psr_bstx_b0sds1;
wire peu_psr_bstx_b1sds1;
wire peu_psr_bstx_b2sds1;
wire peu_psr_bstx_b3sds1;
wire [9:0] peu_psr_tx_lane_ctl_0;
wire [9:0] peu_psr_tx_lane_ctl_1;
wire [9:0] peu_psr_tx_lane_ctl_2;
wire [9:0] peu_psr_tx_lane_ctl_3;
wire [9:0] peu_psr_tx_lane_ctl_4;
wire [9:0] peu_psr_tx_lane_ctl_5;
wire [9:0] peu_psr_tx_lane_ctl_6;
wire [9:0] peu_psr_tx_lane_ctl_7;
wire [7:0] peu_psr_txbclkin;
wire [15:0] peu_psr_testcfg_sds0;
wire [15:0] peu_psr_testcfg_sds1;
wire rst_l2_por_;
wire rst_l2_wmr_;
wire rst_niu_mac_;
wire rst_niu_wmr_;
wire rst_dmu_peu_por_;
wire rst_dmu_peu_wmr_;

//E-QED Inputs
input clk;
input eqed_rst;

input   [ 7 : 0 ]       L2T_VNW;
input   [ 7 : 0 ]       SPC_VNW;
input   [ 7 : 0 ]       L2D_VNW0;
input   [ 7 : 0 ]       L2D_VNW1; 

output 	[ 9 : 0 ]	FBDIMM0A_TX_P;
output 	[ 9 : 0 ]	FBDIMM0A_TX_N;
input 	[ 13 : 0 ]	FBDIMM0A_RX_P;
input 	[ 13 : 0 ]	FBDIMM0A_RX_N;
output 	[ 2 : 0 ]	FBDIMM0A_AMUX;

output 	[ 9 : 0 ]	FBDIMM0B_TX_P;
output 	[ 9 : 0 ]	FBDIMM0B_TX_N;
input 	[ 13 : 0 ]	FBDIMM0B_RX_P;
input 	[ 13 : 0 ]	FBDIMM0B_RX_N;
output 	[ 2 : 0 ]	FBDIMM0B_AMUX;

output 	[ 9 : 0 ]	FBDIMM1A_TX_P;
output 	[ 9 : 0 ]	FBDIMM1A_TX_N;
input 	[ 13 : 0 ]	FBDIMM1A_RX_P;
input 	[ 13 : 0 ]	FBDIMM1A_RX_N;
output 	[ 2 : 0 ]	FBDIMM1A_AMUX;

output 	[ 9 : 0 ]	FBDIMM1B_TX_P;
output 	[ 9 : 0 ]	FBDIMM1B_TX_N;
input 	[ 13 : 0 ]	FBDIMM1B_RX_P;
input 	[ 13 : 0 ]	FBDIMM1B_RX_N;
output 	[ 2 : 0 ]	FBDIMM1B_AMUX;

output 	[ 9 : 0 ]	FBDIMM2A_TX_P;
output 	[ 9 : 0 ]	FBDIMM2A_TX_N;
input 	[ 13 : 0 ]	FBDIMM2A_RX_P;
input 	[ 13 : 0 ]	FBDIMM2A_RX_N;
output 	[ 2 : 0 ]	FBDIMM2A_AMUX;

output 	[ 9 : 0 ]	FBDIMM2B_TX_P;
output 	[ 9 : 0 ]	FBDIMM2B_TX_N;
input 	[ 13 : 0 ]	FBDIMM2B_RX_P;
input 	[ 13 : 0 ]	FBDIMM2B_RX_N;
output 	[ 2 : 0 ]	FBDIMM2B_AMUX;

output 	[ 9 : 0 ]	FBDIMM3A_TX_P;
output 	[ 9 : 0 ]	FBDIMM3A_TX_N;
input 	[ 13 : 0 ]	FBDIMM3A_RX_P;
input 	[ 13 : 0 ]	FBDIMM3A_RX_N;
output 	[ 2 : 0 ]	FBDIMM3A_AMUX;

output 	[ 9 : 0 ]	FBDIMM3B_TX_P;
output 	[ 9 : 0 ]	FBDIMM3B_TX_N;
input 	[ 13 : 0 ]	FBDIMM3B_RX_P;
input 	[ 13 : 0 ]	FBDIMM3B_RX_N;
output 	[ 2 : 0 ]	FBDIMM3B_AMUX;

input		FBDIMM1_REFCLK_P;
input		FBDIMM1_REFCLK_N;
input		FBDIMM2_REFCLK_P;
input		FBDIMM2_REFCLK_N;
input		FBDIMM3_REFCLK_P;
input		FBDIMM3_REFCLK_N;

input           VDDA_FSRL;
input           VDDD_FSRL;
input           VDDR_FSRL;
input           VDDT_FSRL;
input           VSSA_FSRL;

input           VDDA_FSRR;
input           VDDD_FSRR;
input           VDDR_FSRR;
input           VDDT_FSRR;
input           VSSA_FSRR;

input           VDDA_FSRB;
input           VDDD_FSRB;
input           VDDR_FSRB;
input           VDDT_FSRB;
input           VSSA_FSRB;

// PCI-E Bumps

output	[ 7 : 0 ]	PEX_TX_P ;
output	[ 7 : 0 ]	PEX_TX_N ;
input	[ 7 : 0 ]	PEX_RX_P ;
input	[ 7 : 0 ]	PEX_RX_N ;
input		PEX_REFCLK_P ;
input		PEX_REFCLK_N ;
output	[ 1 : 0 ]	PEX_AMUX ;

input		VDDT_PSR;    // PAD 
input		VDDD_PSR;    // PAD 
input		VDDC_PSR;    // PAD 
input		VDDA_PSR;    // PAD 
input		VDDR_PSR;    // PAD 
input		VSSA_PSR;    // PAD 


output			   STCIQ;
input			   TESTCLKT;		// moved out of NIU 
input			   TESTCLKR;
input			   STCID;
//input			   PLL_DR_BYPASS;
input			   PLL_CMP_BYPASS;
input	[ 1 : 0 ]		   STCICFG;
input			   STCICLK;
input			   PGRM_EN;
input			   VDDO_PCM; // PCM 1.5 Supply


//wire		scan_in		= 1'b0;


input          PLL_CMP_CLK_P;   // Reference clock input, either 133.333, 166.666, or 200 MHz.
input          PLL_CMP_CLK_N;   // Differential signal.
inout [ 2 : 0 ] 	DIODE_TOP; 
inout [ 2 : 0 ] 	DIODE_BOT; 
input 		VDD_PLL_CMP_REG; 	//  TBD - mh157021
input  		VDD_RNG_HV; 	//  TBD - mh157021
output			VDD_SENSE;
output			VSS_SENSE;
output			RNG_ANLG_CHAR_OUT;

input          PWRON_RST_L;    // Power On Reset 
input          BUTTON_XIR_L;   // Externally Initiated Reset
input          PB_RST_L;       // Like Niagara J_RST_L
output         PEX_RESET_L;    // To External PCI Express switch and
                                        // PCI Express Devices
//output         FATAL_ERROR;            // Fatal Error has ocurred in N2
output         SSI_SYNC_L;            // SSI SYNC signal to FPGA PLL

inout          VPP;              // High powered programming pin (efu)

//test
// input  [ 30:0] io_scan_in;
// input          io_srdes_scan_in;
// output [ 30:0] tcu_pins_scan_out;
// output         tcu_pin_srdes_scan_out;

//input          scan_in;

//jtag and test
input          TMS;
input          TDI;
input          TRST_L;
input          TCK;
input          TESTMODE;
output         TDO;

input           DIVIDER_BYPASS;         // Bypasses Clock Tree Dividers

//debug 
inout [ 165 : 0 ]  DBG_DQ;                 // Debug Outputs
                                        // DBG_DQ[113:0] also shares
                                        // function as following pins:
                                        //      CMP_CLK_EXT
                                        //      IO_CLK_EXT
                                        //      IO2X_CLK_EXT
                                        //      ACLK
                                        //      BCLK
                                        //      SCAN_EN
                                        //      AC_TESTMODE
                                        //      AC_TESTRIG
                                        //      SCAN_IN[31:0]
                                        //      SCAN_OUT[31:0]
                                        //      DMA_DATA[39:0]
                                        //      MBIST_DONE
                                        //      MBIST_FAIL

output          DBG_CK0;                // Debug Output CLK Unit 0
input           TRIGIN;                 // Stop clock based on external event;
                                        // TRIGIN controls BISI/BIST selection

output          TRIGOUT;                // DBG event signal to logic analyzer

// SSI 

input           SSI_MISO;               // SSI Master In, Slave Out
input           SSI_EXT_INT_L;          // SSI External Interrupt
output          SSI_SCK;                // SSI Clock
output          SSI_MOSI;               // SSI Master Out, Slave In




// misc pads

input   [ 1 : 0 ]   PMI;                    // process control monitor input
input           VREG_SELBG_L;           // Bandgap Select           
output  [ 1 : 0 ]   PLL_CHAR_OUT;           // PLL Char Out
input           PLL_TESTMODE;           // PLL Testmode Pin
input   [ 2 : 0 ]   PWR_THRTTL_0;           // Power Throttle pins grp 0
input   [ 2 : 0 ]   PWR_THRTTL_1;           // Power Throttle pins grp 1
output          PMO;                    // process control monitor output
input           BURNIN;                 // Sets Burnin Mode for PCM Modules


// Use global clk
assign cmp_gclk_c3_spc0 = clk;
assign cmp_gclk_c2_spc1 = clk;
assign cmp_gclk_c3_spc2 = clk;
assign cmp_gclk_c2_spc3 = clk;
assign cmp_gclk_c1_spc4 = clk;
assign cmp_gclk_c2_spc5 = clk;
assign cmp_gclk_c1_spc6 = clk;
assign cmp_gclk_c2_spc7 = clk;
assign cmp_gclk_c3_l2d0 = clk;
assign cmp_gclk_c3_l2d1 = clk;
assign cmp_gclk_c3_l2d2 = clk;
assign cmp_gclk_c3_l2d3 = clk;
assign cmp_gclk_c1_l2d4 = clk;
assign cmp_gclk_c1_l2d5 = clk;
assign cmp_gclk_c1_l2d6 = clk;
assign cmp_gclk_c1_l2d7 = clk;
assign cmp_gclk_c3_l2t0 = clk;
assign cmp_gclk_c2_l2t1 = clk;
assign cmp_gclk_c3_l2t2 = clk;
assign cmp_gclk_c2_l2t3 = clk;
assign cmp_gclk_c1_l2t4 = clk;
assign cmp_gclk_c2_l2t5 = clk;
assign cmp_gclk_c1_l2t6 = clk;
assign cmp_gclk_c2_l2t7 = clk;
assign cmp_gclk_c3_l2b0 = clk;
assign cmp_gclk_c3_l2b1 = clk;
assign cmp_gclk_c3_l2b2 = clk;
assign cmp_gclk_c3_l2b3 = clk;
assign cmp_gclk_c1_l2b4 = clk;
assign cmp_gclk_c1_l2b5 = clk;
assign cmp_gclk_c1_l2b6 = clk;
assign cmp_gclk_c1_l2b7 = clk;
assign cmp_gclk_c4_mcu0 = clk;
assign dr_gclk_c4_mcu0 = clk;
assign cmp_gclk_c4_mcu1 = clk;
assign dr_gclk_c4_mcu1 = clk;
assign cmp_gclk_c0_mcu2 = clk;
assign dr_gclk_c0_mcu2 = clk;
assign cmp_gclk_c0_mcu3 = clk;
assign dr_gclk_c0_mcu3 = clk;
assign cmp_gclk_c2_ccx_left = clk;
assign cmp_gclk_c2_ccx_right = clk;

  // clocks

  assign gl_spc0_clk_stop = 0;
  assign gl_spc1_clk_stop = 0;
  assign gl_spc2_clk_stop = 0;
  assign gl_spc3_clk_stop = 0;
  assign gl_spc4_clk_stop = 0;
  assign gl_spc5_clk_stop = 0;
  assign gl_spc6_clk_stop = 0;
  assign gl_spc7_clk_stop = 0;

  assign gl_ccx_clk_stop = 0;

  assign gl_l2d0_clk_stop = 0;
  assign gl_l2d1_clk_stop = 0;
  assign gl_l2d2_clk_stop = 0;
  assign gl_l2d3_clk_stop = 0;
  assign gl_l2d4_clk_stop = 0;
  assign gl_l2d5_clk_stop = 0;
  assign gl_l2d6_clk_stop = 0;
  assign gl_l2d7_clk_stop = 0;

  assign gl_l2t0_clk_stop = 0;
  assign gl_l2t1_clk_stop = 0;
  assign gl_l2t2_clk_stop = 0;
  assign gl_l2t3_clk_stop = 0;
  assign gl_l2t4_clk_stop = 0;
  assign gl_l2t5_clk_stop = 0;
  assign gl_l2t6_clk_stop = 0;
  assign gl_l2t7_clk_stop = 0;

  assign l2clk = clk;
  
  
    // initial partial bank values
   M_setup : assume property (
    (ncu_spc_pm == '0) 
    && (ncu_l2t_pm == '0) 
    && (ncu_sii_pm == '0) 
    && (ncu_mcu_pm == '0) 
    && (ncu_spc_ba01 == 1) 
    && (ncu_spc_ba23 == 1) 
    && (ncu_spc_ba45 == 1) 
    && (ncu_spc_ba67 == 1) 
    && (ncu_l2t_ba01 == 1) 
    && (ncu_l2t_ba23 == 1) 
    && (ncu_l2t_ba45 == 1) 
    && (ncu_l2t_ba67 == 1) 
    && (ncu_sii_ba01 == 1) 
    && (ncu_sii_ba23 == 1) 
    && (ncu_sii_ba45 == 1) 
    && (ncu_sii_ba67 == 1) 
    && (ncu_mcu_ba01 == 1) 
    && (ncu_mcu_ba23 == 1) 
    && (ncu_mcu_ba45 == 1) 
    && (ncu_mcu_ba67 == 1) 
    // TCU-L2
    && (l2b0.scan_in == '0) 
    && (l2b0.tcu_se_scancollar_in == 1'b0) 
    && (l2b0.tcu_se_scancollar_out == 1'b0) 
    && (l2b1.scan_in == '0) 
    && (l2b1.tcu_se_scancollar_in == 1'b0) 
    && (l2b1.tcu_se_scancollar_out == 1'b0) 
    && (l2d0.scan_in == '0) 
    && (l2d0.tcu_clk_stop == '0) 
    && (l2d1.scan_in == '0) 
    && (l2d1.tcu_clk_stop == '0) 
    && (l2t0.tcu_se_scancollar_in == 1'b0) 
    && (l2t0.tcu_se_scancollar_out == 1'b0) 
    && (l2t1.tcu_se_scancollar_in == 1'b0) 
    && (l2t1.tcu_se_scancollar_out == 1'b0) 
    && (l2b2.scan_in == '0) 
    && (l2b2.tcu_se_scancollar_in == 1'b0) 
    && (l2b2.tcu_se_scancollar_out == 1'b0) 
    && (l2b3.scan_in == '0) 
    && (l2b3.tcu_se_scancollar_in == 1'b0) 
    && (l2b3.tcu_se_scancollar_out == 1'b0) 
    && (l2d2.scan_in == '0) 
    && (l2d2.tcu_clk_stop == '0) 
    && (l2d3.scan_in == '0) 
    && (l2d3.tcu_clk_stop == '0) 
    && (l2t2.tcu_se_scancollar_in == 1'b0) 
    && (l2t2.tcu_se_scancollar_out == 1'b0) 
    && (l2t3.tcu_se_scancollar_in == 1'b0) 
    && (l2t3.tcu_se_scancollar_out == 1'b0) 
    && (l2b4.scan_in == '0) 
    && (l2b4.tcu_se_scancollar_in == 1'b0) 
    && (l2b4.tcu_se_scancollar_out == 1'b0) 
    && (l2b5.scan_in == '0) 
    && (l2b5.tcu_se_scancollar_in == 1'b0) 
    && (l2b5.tcu_se_scancollar_out == 1'b0) 
    && (l2d4.scan_in == '0) 
    && (l2d4.tcu_clk_stop == '0) 
    && (l2d5.scan_in == '0) 
    && (l2d5.tcu_clk_stop == '0) 
    && (l2t4.tcu_se_scancollar_in == 1'b0) 
    && (l2t4.tcu_se_scancollar_out == 1'b0) 
    && (l2t5.tcu_se_scancollar_in == 1'b0) 
    && (l2t5.tcu_se_scancollar_out == 1'b0) 
    && (l2b6.scan_in == '0) 
    && (l2b6.tcu_se_scancollar_in == 1'b0) 
    && (l2b6.tcu_se_scancollar_out == 1'b0) 
    && (l2b7.scan_in == '0) 
    && (l2b7.tcu_se_scancollar_in == 1'b0) 
    && (l2b7.tcu_se_scancollar_out == 1'b0) 
    && (l2d6.scan_in == '0) 
    && (l2d6.tcu_clk_stop == '0) 
    && (l2d7.scan_in == '0) 
    && (l2d7.tcu_clk_stop == '0) 
    && (l2t6.tcu_se_scancollar_in == 1'b0) 
    && (l2t6.tcu_se_scancollar_out == 1'b0) 
    && (l2t7.tcu_se_scancollar_in == 1'b0) 
    && (l2t7.tcu_se_scancollar_out == 1'b0) 
    && (ccx.cpx.cpx_dpa_scanin == 1'b0) 
/*    && (ccx.scan_in == '0) 
    && (ccx.tcu_aclk == '0) 
    && (ccx.tcu_bclk == '0) 
    && (ccx.tcu_pce_ov == '0) 
    && (ccx.tcu_scan_en == '0)  */
    && (rst_ncu_vld == 1'b0) 
    && (sii_l2b0_ecc == 7'b0) 
    && (sii_l2b1_ecc == 7'b0) 
    && (sii_l2b2_ecc == 7'b0) 
    && (sii_l2b3_ecc == 7'b0) 
    && (sii_l2b4_ecc == 7'b0) 
    && (sii_l2b5_ecc == 7'b0) 
    && (sii_l2b6_ecc == 7'b0) 
    && (sii_l2b7_ecc == 7'b0) 
    && (sii_l2t0_req == 32'b0) 
    && (sii_l2t0_req_vld == 1'b0) 
    && (sii_l2t1_req == 32'b0) 
    && (sii_l2t1_req_vld == 1'b0) 
    && (sii_l2t2_req == 32'b0) 
    && (sii_l2t2_req_vld == 1'b0) 
    && (sii_l2t3_req == 32'b0) 
    && (sii_l2t3_req_vld == 1'b0) 
    && (sii_l2t4_req == 32'b0) 
    && (sii_l2t4_req_vld == 1'b0) 
    && (sii_l2t5_req == 32'b0) 
    && (sii_l2t5_req_vld == 1'b0) 
    && (sii_l2t6_req == 32'b0) 
    && (sii_l2t6_req_vld == 1'b0) 
    && (sii_l2t7_req == 32'b0) 
    && (sii_l2t7_req_vld == 1'b0) 
    && (sii_ncu_syn_vld == 1'b0) 
    && (tck == '0) 
    && (tcu_aclk == '0) 
    && (tcu_array_bypass == '0) 
    && (tcu_array_wr_inhibit == '0) 
    && (tcu_bclk == '0) 
    && (tcu_dectest == 1) 
    && (tcu_div_bypass == 1'b0) 
    && (tcu_l2b0_mbist_scan_in == '0) 
    && (tcu_l2b0_mbist_start == '0) 
    && (tcu_l2b1_mbist_scan_in == '0) 
    && (tcu_l2b1_mbist_start == '0) 
    && (tcu_l2b2_mbist_scan_in == '0) 
    && (tcu_l2b2_mbist_start == '0) 
    && (tcu_l2b3_mbist_scan_in == '0) 
    && (tcu_l2b3_mbist_start == '0) 
    && (tcu_l2b4_mbist_scan_in == '0) 
    && (tcu_l2b4_mbist_start == '0) 
    && (tcu_l2b5_mbist_scan_in == '0) 
    && (tcu_l2b5_mbist_start == '0) 
    && (tcu_l2b6_mbist_scan_in == '0) 
    && (tcu_l2b6_mbist_start == '0) 
    && (tcu_l2b7_mbist_scan_in == '0) 
    && (tcu_l2b7_mbist_start == '0) 
    && (tcu_l2t0_mbist_scan_in == '0) 
    && (tcu_l2t0_mbist_start == '0) 
    && (tcu_l2t0_shscan_scan_in == '0) 
    && (tcu_l2t1_mbist_scan_in == '0) 
    && (tcu_l2t1_mbist_start == '0) 
    && (tcu_l2t1_shscan_scan_in == '0) 
    && (tcu_l2t2_mbist_scan_in == '0) 
    && (tcu_l2t2_mbist_start == '0) 
    && (tcu_l2t2_shscan_scan_in == '0) 
    && (tcu_l2t3_mbist_scan_in == '0) 
    && (tcu_l2t3_mbist_start == '0) 
    && (tcu_l2t3_shscan_scan_in == '0) 
    && (tcu_l2t4_mbist_scan_in == '0) 
    && (tcu_l2t4_mbist_start == '0) 
    && (tcu_l2t4_shscan_scan_in == '0) 
    && (tcu_l2t5_mbist_scan_in == '0) 
    && (tcu_l2t5_mbist_start == '0) 
    && (tcu_l2t5_shscan_scan_in == '0) 
    && (tcu_l2t6_mbist_scan_in == '0) 
    && (tcu_l2t6_mbist_start == '0) 
    && (tcu_l2t6_shscan_scan_in == '0) 
    && (tcu_l2t7_mbist_scan_in == '0) 
    && (tcu_l2t7_mbist_start == '0) 
    && (tcu_l2t7_shscan_scan_in == '0) 
    && (tcu_l2t_shscan_aclk == '0) 
    && (tcu_l2t_shscan_bclk == '0) 
    && (tcu_l2t_shscan_pce_ov == '0) 
    && (tcu_l2t_shscan_scan_en == '0) 
    && (tcu_mbist_bisi_en == '0) 
    && (tcu_muxtest == 1'b1) 
    && (tcu_pce_ov == '0) 
    && (tcu_atpg_mode == '0) 
    && (tcu_srd_atpgd == '0) 
    && (tcu_srd_atpgse == '0) 
    && (tcu_srd_atpgmode == 3'b0) 
    && (tcu_mbist_user_mode == '0) 
    && (tcu_scan_en == '0) 
    && (tcu_se_scancollar_in == '0) 
    && (tcu_se_scancollar_out == '0) 
    && (tcu_spc0_aclk == 1'b0) 
    && (tcu_spc0_array_wr_inhibit == 1'b0) 
    && (tcu_spc0_bclk == 1'b0) 
    && (tcu_spc0_mbist_scan_in == 1'b0) 
    && (tcu_spc0_scan_en == 1'b0) 
    && (tcu_spc0_scan_out == '0) 
    && (tcu_spc0_se_scancollar_in == 1'b0) 
    && (tcu_spc0_se_scancollar_out == 1'b0) 
    && (tcu_spc0_shscan_scan_out == 1'b0) 
    && (tcu_spc1_aclk == 1'b0) 
    && (tcu_spc1_array_wr_inhibit == 1'b0) 
    && (tcu_spc1_bclk == 1'b0) 
    && (tcu_spc1_mbist_scan_in == 1'b0) 
    && (tcu_spc1_scan_en == 1'b0) 
    && (tcu_spc1_scan_out == '0) 
    && (tcu_spc1_se_scancollar_in == 1'b0) 
    && (tcu_spc1_se_scancollar_out == 1'b0) 
    && (tcu_spc1_shscan_scan_out == 1'b0) 
    && (tcu_spc2_aclk == 1'b0) 
    && (tcu_spc2_array_wr_inhibit == 1'b0) 
    && (tcu_spc2_bclk == 1'b0) 
    && (tcu_spc2_mbist_scan_in == 1'b0) 
    && (tcu_spc2_scan_en == 1'b0) 
    && (tcu_spc2_scan_out == '0) 
    && (tcu_spc2_se_scancollar_in == 1'b0) 
    && (tcu_spc2_se_scancollar_out == 1'b0) 
    && (tcu_spc2_shscan_scan_out == 1'b0) 
    && (tcu_spc3_aclk == 1'b0) 
    && (tcu_spc3_array_wr_inhibit == 1'b0) 
    && (tcu_spc3_bclk == 1'b0) 
    && (tcu_spc3_mbist_scan_in == 1'b0) 
    && (tcu_spc3_scan_en == 1'b0) 
    && (tcu_spc3_scan_out == '0) 
    && (tcu_spc3_se_scancollar_in == 1'b0) 
    && (tcu_spc3_se_scancollar_out == 1'b0) 
    && (tcu_spc3_shscan_scan_out == 1'b0) 
    && (tcu_spc4_aclk == 1'b0) 
    && (tcu_spc4_array_wr_inhibit == 1'b0) 
    && (tcu_spc4_bclk == 1'b0) 
    && (tcu_spc4_mbist_scan_in == 1'b0) 
    && (tcu_spc4_scan_en == 1'b0) 
    && (tcu_spc4_scan_out == '0) 
    && (tcu_spc4_se_scancollar_in == 1'b0) 
    && (tcu_spc4_se_scancollar_out == 1'b0) 
    && (tcu_spc4_shscan_scan_out == 1'b0) 
    && (tcu_spc5_aclk == 1'b0) 
    && (tcu_spc5_array_wr_inhibit == 1'b0) 
    && (tcu_spc5_bclk == 1'b0) 
    && (tcu_spc5_mbist_scan_in == 1'b0) 
    && (tcu_spc5_scan_en == 1'b0) 
    && (tcu_spc5_scan_out == '0) 
    && (tcu_spc5_se_scancollar_in == 1'b0) 
    && (tcu_spc5_se_scancollar_out == 1'b0) 
    && (tcu_spc5_shscan_scan_out == 1'b0) 
    && (tcu_spc6_aclk == 1'b0) 
    && (tcu_spc6_array_wr_inhibit == 1'b0) 
    && (tcu_spc6_bclk == 1'b0) 
    && (tcu_spc6_mbist_scan_in == 1'b0) 
    && (tcu_spc6_scan_en == 1'b0) 
    && (tcu_spc6_scan_out == '0) 
    && (tcu_spc6_se_scancollar_in == 1'b0) 
    && (tcu_spc6_se_scancollar_out == 1'b0) 
    && (tcu_spc6_shscan_scan_out == 1'b0) 
    && (tcu_spc7_aclk == 1'b0) 
    && (tcu_spc7_array_wr_inhibit == 1'b0) 
    && (tcu_spc7_bclk == 1'b0) 
    && (tcu_spc7_mbist_scan_in == 1'b0) 
    && (tcu_spc7_scan_en == 1'b0) 
    && (tcu_spc7_scan_out == '0) 
    && (tcu_spc7_se_scancollar_in == 1'b0) 
    && (tcu_spc7_se_scancollar_out == 1'b0) 
    && (tcu_spc7_shscan_scan_out == 1'b0) 
    && (tcu_spc_mbist_start == '0) 
    && (tcu_spc_shscan_aclk == '0) 
    && (tcu_spc_shscan_bclk == '0) 
    && (tcu_spc_shscan_pce_ov == '0) 
    && (tcu_spc_shscan_scan_en == '0) 
    && (tcu_spc_shscanid == 3'b0) 
    && (L2T_VNW == 8'hff) 
    && (SPC_VNW == 8'hff) 
    && (L2D_VNW0 == 8'hff) 
    && (L2D_VNW1 == 8'hff)  
    && (tcu_do_mode == '0)  //in cmp_tasks
    && (tcu_ss_mode == '0)  //in cmp_tasks
    && (tcu_ss_request == '0) 
    && (dmo_coresel[5:0] == 6'h3f) 
    && (dmo_tagmuxctl == '0) 
    && (dmo_l2tsel[5:0] == 6'b0) 
    && (dmo_icmuxctl == '0) 
    && (dmo_dcmuxctl == '0) 
    && (tcu_spc_lbist_start[7:0] == 8'b0)  
// clock stop    
    && (tcu_ccx_clk_stop == '0) 
    && (tcu_l2b0_clk_stop == '0) 
    && (tcu_l2b1_clk_stop == '0) 
    && (tcu_l2b2_clk_stop == '0) 
    && (tcu_l2b3_clk_stop == '0) 
    && (tcu_l2b4_clk_stop == '0) 
    && (tcu_l2b5_clk_stop == '0) 
    && (tcu_l2b6_clk_stop == '0) 
    && (tcu_l2b7_clk_stop == '0) 
    && (tcu_l2d0_clk_stop == '0) 
    && (tcu_l2d1_clk_stop == '0) 
    && (tcu_l2d2_clk_stop == '0) 
    && (tcu_l2d3_clk_stop == '0) 
    && (tcu_l2d4_clk_stop == '0) 
    && (tcu_l2d5_clk_stop == '0) 
    && (tcu_l2d6_clk_stop == '0) 
    && (tcu_l2d7_clk_stop == '0) 
    && (tcu_l2t0_clk_stop == '0) 
    && (tcu_l2t0_shscan_clk_stop == '0) 
    && (tcu_l2t1_clk_stop == '0) 
    && (tcu_l2t1_shscan_clk_stop == '0) 
    && (tcu_l2t2_clk_stop == '0) 
    && (tcu_l2t2_shscan_clk_stop == '0) 
    && (tcu_l2t3_clk_stop == '0) 
    && (tcu_l2t3_shscan_clk_stop == '0) 
    && (tcu_l2t4_clk_stop == '0) 
    && (tcu_l2t4_shscan_clk_stop == '0) 
    && (tcu_l2t5_clk_stop == '0) 
    && (tcu_l2t5_shscan_clk_stop == '0) 
    && (tcu_l2t6_clk_stop == '0) 
    && (tcu_l2t6_shscan_clk_stop == '0) 
    && (tcu_l2t7_clk_stop == '0) 
    && (tcu_l2t7_shscan_clk_stop == '0) 
// done in cmp_tasks.v
    && (tcu_spc0_clk_stop == '0) 
    && (tcu_spc0_shscan_clk_stop == '0) 
    && (tcu_spc1_clk_stop == '0) 
    && (tcu_spc1_shscan_clk_stop == '0) 
    && (tcu_spc2_clk_stop == '0) 
    && (tcu_spc2_shscan_clk_stop == '0) 
    && (tcu_spc3_clk_stop == '0) 
    && (tcu_spc3_shscan_clk_stop == '0) 
    && (tcu_spc4_clk_stop == '0) 
    && (tcu_spc4_shscan_clk_stop == '0) 
    && (tcu_spc5_clk_stop == '0) 
    && (tcu_spc5_shscan_clk_stop == '0) 
    && (tcu_spc6_clk_stop == '0) 
    && (tcu_spc6_shscan_clk_stop == '0) 
    && (tcu_spc7_clk_stop == '0) 
    && (tcu_spc7_shscan_clk_stop == '0) 
    && (cluster_arst_l == 1) 
    && (efu_spc0_fuse_ixfer_en == '0) 
    && (efu_spc0_fuse_iclr == '0) 
    && (efu_spc0_fuse_dxfer_en == '0) 
    && (efu_spc0_fuse_dclr == '0) 
    && (tcu_spc_lbist_pgm == '0) 
    && (tcu_spc_lbist_scan_in == '0) 
    && (spc_revid_out[3:0] == '0) 
/*    && (spc0.cluster_arst_l == 1'b1)
    && (spc0.scan_in == 1'b0)
    && (spc0.tcu_pce_ov == 1'b0)
    && (spc0.tcu_clk_stop == 1'b0)
    && (spc0.tcu_spc_aclk == 1'b0)
    && (spc0.tcu_spc_bclk == 1'b0)
    && (spc0.tcu_dectest == 1'b1)
    && (spc0.tcu_muxtest == 1'b1)
    && (spc0.tcu_spc_scan_en == 1'b0)
    && (spc0.tcu_spc_array_wr_inhibit == 1'b0)
    && (spc0.tcu_spc_se_scancollar_in == 1'b0)
    && (spc0.tcu_spc_se_scancollar_out == 1'b0)
    && (spc0.tcu_atpg_mode == 1'b0)
    && (spc0.rst_wmr_protect == 1'b0)
    && (spc0.tcu_spc_shscan_pce_ov   == 1'b0)
    && (spc0.tcu_spc_shscan_clk_stop == 1'b0)
    && (spc0.tcu_spc_shscan_aclk     == 1'b0)
    && (spc0.tcu_spc_shscan_bclk     == 1'b0)
    && (spc0.tcu_spc_shscan_scan_in  == 1'b0)
    && (spc0.tcu_spc_shscan_scan_en  == 1'b0)
    && (spc0.tcu_spc_shscanid        == 3'b000)
    && (spc0.tcu_spc_mbist_scan_in  == 1'b0)
    && (spc0.tcu_mbist_bisi_en      == 1'b0)
    && (spc0.tcu_spc_mbist_start    == 1'b0)
    && (spc0.tcu_mbist_user_mode    == 1'b0)
    && (spc0.const_cpuid  == 3'b000)
    && (spc0.tcu_ss_mode  == 1'b0)
    && (spc0.tcu_do_mode  == 1'b0)
    && (spc0.tcu_ss_request  == 1'b0)
    && (spc0.tcu_spc_lbist_start    == 1'b0)
    && (spc0.tcu_spc_lbist_scan_in  == 1'b0)
    && (spc0.tcu_spc_lbist_pgm      == 1'b0)
    && (spc0.tcu_spc_test_mode      == 1'b0)*/
	);


//     assign tcu_do_mode = 0; //in cmp_tasks
//     assign tcu_ss_mode = 0; //in cmp_tasks

    assign tcu_ss_request = 0;

//________________________________________________________________
// E-QED signals and signature analyzers


reg [11:0] M_count;
wire m_rst;
wire m_rst2;

always @(posedge clk) begin
   if (eqed_rst) begin
     M_count <= 11'b0 ;
   end else begin
     M_count <= M_count + 1;
   end
end

assign m_rst = (M_count == 11'h3FF) || eqed_rst;
assign m_rst2 = (M_count == 11'h7FF) || eqed_rst;


// SPC-CCX interface
wire [147:0] eqed_spc0_ccx;
wire [154:0] eqed_ccx_spc0;
wire [147:0] eqed_spc1_ccx;
wire [154:0] eqed_ccx_spc1;
wire [147:0] eqed_spc2_ccx;
wire [154:0] eqed_ccx_spc2;
wire [147:0] eqed_spc3_ccx;
wire [154:0] eqed_ccx_spc3;
wire [147:0] eqed_spc4_ccx;
wire [154:0] eqed_ccx_spc4;
wire [147:0] eqed_spc5_ccx;
wire [154:0] eqed_ccx_spc5;
wire [147:0] eqed_spc6_ccx;
wire [154:0] eqed_ccx_spc6;
wire [147:0] eqed_spc7_ccx;
wire [154:0] eqed_ccx_spc7;

// Collect the signals for the interface signature block
assign eqed_spc0_ccx = {spc0_pcx_req_pq, spc0_pcx_atm_pq, spc0_pcx_data_pa};
assign eqed_ccx_spc0 = {cpx_spc0_data_cx2, pcx_spc0_grant_px};
assign eqed_spc1_ccx = {spc1_pcx_req_pq, spc1_pcx_atm_pq, spc1_pcx_data_pa};
assign eqed_ccx_spc1 = {cpx_spc1_data_cx2, pcx_spc1_grant_px};
assign eqed_spc2_ccx = {spc2_pcx_req_pq, spc2_pcx_atm_pq, spc2_pcx_data_pa};
assign eqed_ccx_spc2 = {cpx_spc2_data_cx2, pcx_spc2_grant_px};
assign eqed_spc3_ccx = {spc3_pcx_req_pq, spc3_pcx_atm_pq, spc3_pcx_data_pa};
assign eqed_ccx_spc3 = {cpx_spc3_data_cx2, pcx_spc3_grant_px};
assign eqed_spc4_ccx = {spc4_pcx_req_pq, spc4_pcx_atm_pq, spc4_pcx_data_pa};
assign eqed_ccx_spc4 = {cpx_spc4_data_cx2, pcx_spc4_grant_px};
assign eqed_spc5_ccx = {spc5_pcx_req_pq, spc5_pcx_atm_pq, spc5_pcx_data_pa};
assign eqed_ccx_spc5 = {cpx_spc5_data_cx2, pcx_spc5_grant_px};
assign eqed_spc6_ccx = {spc6_pcx_req_pq, spc6_pcx_atm_pq, spc6_pcx_data_pa};
assign eqed_ccx_spc6 = {cpx_spc6_data_cx2, pcx_spc6_grant_px};
assign eqed_spc7_ccx = {spc7_pcx_req_pq, spc7_pcx_atm_pq, spc7_pcx_data_pa};
assign eqed_ccx_spc7 = {cpx_spc7_data_cx2, pcx_spc7_grant_px};

parameter SPC_CCX_B = 148;
parameter CCX_SPC_B = 155;

parameter SPC_CCX_SB_SIZE = 1184;
parameter CCX_SPC_SB_SIZE = 1240;

/*

// Declare the registers for the Signature Analyzer MISRs
reg [SPC_CCX_SB_SIZE:0] spc0_ccx_sa;
reg [CCX_SPC_SB_SIZE:0] ccx_spc0_sa;
reg [SPC_CCX_SB_SIZE:0] spc1_ccx_sa;
reg [CCX_SPC_SB_SIZE:0] ccx_spc1_sa;
reg [SPC_CCX_SB_SIZE:0] spc2_ccx_sa;
reg [CCX_SPC_SB_SIZE:0] ccx_spc2_sa;
reg [SPC_CCX_SB_SIZE:0] spc3_ccx_sa;
reg [CCX_SPC_SB_SIZE:0] ccx_spc3_sa;
reg [SPC_CCX_SB_SIZE:0] spc4_ccx_sa;
reg [CCX_SPC_SB_SIZE:0] ccx_spc4_sa;
reg [SPC_CCX_SB_SIZE:0] spc5_ccx_sa;
reg [CCX_SPC_SB_SIZE:0] ccx_spc5_sa;
reg [SPC_CCX_SB_SIZE:0] spc6_ccx_sa;
reg [CCX_SPC_SB_SIZE:0] ccx_spc6_sa;
reg [SPC_CCX_SB_SIZE:0] spc7_ccx_sa;
reg [CCX_SPC_SB_SIZE:0] ccx_spc7_sa;

// Declare the registers for the Signature Analyzer MISRs
reg [SPC_CCX_SB_SIZE:0] spc0_ccx_sa2;
reg [CCX_SPC_SB_SIZE:0] ccx_spc0_sa2;
reg [SPC_CCX_SB_SIZE:0] spc1_ccx_sa2;
reg [CCX_SPC_SB_SIZE:0] ccx_spc1_sa2;
reg [SPC_CCX_SB_SIZE:0] spc2_ccx_sa2;
reg [CCX_SPC_SB_SIZE:0] ccx_spc2_sa2;
reg [SPC_CCX_SB_SIZE:0] spc3_ccx_sa2;
reg [CCX_SPC_SB_SIZE:0] ccx_spc3_sa2;
reg [SPC_CCX_SB_SIZE:0] spc4_ccx_sa2;
reg [CCX_SPC_SB_SIZE:0] ccx_spc4_sa2;
reg [SPC_CCX_SB_SIZE:0] spc5_ccx_sa2;
reg [CCX_SPC_SB_SIZE:0] ccx_spc5_sa2;
reg [SPC_CCX_SB_SIZE:0] spc6_ccx_sa2;
reg [CCX_SPC_SB_SIZE:0] ccx_spc6_sa2;
reg [SPC_CCX_SB_SIZE:0] spc7_ccx_sa2;
reg [CCX_SPC_SB_SIZE:0] ccx_spc7_sa2;

always @(posedge clk) begin
    if (m_rst) begin
       spc0_ccx_sa <= 1;
       ccx_spc0_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc0_ccx_sa[0] <= spc0_ccx_sa[1147] ^ spc0_ccx_sa[1134] ^ spc0_ccx_sa[1133] ^ spc0_ccx_sa[1128] ^ eqed_spc0_ccx[0];
		   end else begin
			   spc0_ccx_sa[i] <= spc0_ccx_sa[i-1] ^ eqed_spc0_ccx[j]; 
		   end
		       spc0_ccx_sa[i+1] <= spc0_ccx_sa[i];
		       spc0_ccx_sa[i+2] <= spc0_ccx_sa[i+1];
	           spc0_ccx_sa[i+3] <= spc0_ccx_sa[i+2];
		       spc0_ccx_sa[i+4] <= spc0_ccx_sa[i+3];
		       spc0_ccx_sa[i+5] <= spc0_ccx_sa[i+4];
		       spc0_ccx_sa[i+6] <= spc0_ccx_sa[i+5];
			   spc0_ccx_sa[i+7] <= spc0_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc0_sa[0] <= ccx_spc0_sa[1239] ^ ccx_spc0_sa[1235] ^ ccx_spc0_sa[1233] ^ ccx_spc0_sa[1230] ^ eqed_ccx_spc0[0];
		   end else begin
			   ccx_spc0_sa[i] <= ccx_spc0_sa[i-1] ^ eqed_ccx_spc0[j]; 
		   end
		       ccx_spc0_sa[i+1] <= ccx_spc0_sa[i];
		       ccx_spc0_sa[i+2] <= ccx_spc0_sa[i+1];
	           ccx_spc0_sa[i+3] <= ccx_spc0_sa[i+2];
		       ccx_spc0_sa[i+4] <= ccx_spc0_sa[i+3];
		       ccx_spc0_sa[i+5] <= ccx_spc0_sa[i+4];
		       ccx_spc0_sa[i+6] <= ccx_spc0_sa[i+5];
			   ccx_spc0_sa[i+7] <= ccx_spc0_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       spc0_ccx_sa2 <= 1;
       ccx_spc0_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc0_ccx_sa2[0] <= spc0_ccx_sa2[1147] ^ spc0_ccx_sa2[1134] ^ spc0_ccx_sa2[1133] ^ spc0_ccx_sa2[1128] ^ eqed_spc0_ccx[0];
		   end else begin
			   spc0_ccx_sa2[i] <= spc0_ccx_sa2[i] ^ eqed_spc0_ccx[j]; 
		   end
		       spc0_ccx_sa2[i+1] <= spc0_ccx_sa2[i];
		       spc0_ccx_sa2[i+2] <= spc0_ccx_sa2[i+1];
	           spc0_ccx_sa2[i+3] <= spc0_ccx_sa2[i+2];
		       spc0_ccx_sa2[i+4] <= spc0_ccx_sa2[i+3];
		       spc0_ccx_sa2[i+5] <= spc0_ccx_sa2[i+4];
		       spc0_ccx_sa2[i+6] <= spc0_ccx_sa2[i+5];
			   spc0_ccx_sa2[i+7] <= spc0_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc0_sa2[0] <= ccx_spc0_sa2[1239] ^ ccx_spc0_sa2[1235] ^ ccx_spc0_sa2[1233] ^ ccx_spc0_sa2[1230] ^ eqed_ccx_spc0[0];
		   end else begin
			   ccx_spc0_sa2[i] <= ccx_spc0_sa2[i] ^ eqed_ccx_spc0[j]; 
		   end
		       ccx_spc0_sa2[i+1] <= ccx_spc0_sa2[i];
		       ccx_spc0_sa2[i+2] <= ccx_spc0_sa2[i+1];
	           ccx_spc0_sa2[i+3] <= ccx_spc0_sa2[i+2];
		       ccx_spc0_sa2[i+4] <= ccx_spc0_sa2[i+3];
		       ccx_spc0_sa2[i+5] <= ccx_spc0_sa2[i+4];
		       ccx_spc0_sa2[i+6] <= ccx_spc0_sa2[i+5];
			   ccx_spc0_sa2[i+7] <= ccx_spc0_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       spc1_ccx_sa <= 1;
       ccx_spc1_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc1_ccx_sa[0] <= spc1_ccx_sa[1147] ^ spc1_ccx_sa[1134] ^ spc1_ccx_sa[1133] ^ spc1_ccx_sa[1128] ^ eqed_spc1_ccx[0];
		   end else begin
			   spc1_ccx_sa[i] <= spc1_ccx_sa[i-1] ^ eqed_spc1_ccx[j]; 
		   end
		       spc1_ccx_sa[i+1] <= spc1_ccx_sa[i];
		       spc1_ccx_sa[i+2] <= spc1_ccx_sa[i+1];
	           spc1_ccx_sa[i+3] <= spc1_ccx_sa[i+2];
		       spc1_ccx_sa[i+4] <= spc1_ccx_sa[i+3];
		       spc1_ccx_sa[i+5] <= spc1_ccx_sa[i+4];
		       spc1_ccx_sa[i+6] <= spc1_ccx_sa[i+5];
			   spc1_ccx_sa[i+7] <= spc1_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc1_sa[0] <= ccx_spc1_sa[1239] ^ ccx_spc1_sa[1235] ^ ccx_spc1_sa[1233] ^ ccx_spc1_sa[1230] ^ eqed_ccx_spc1[0];
		   end else begin
			   ccx_spc1_sa[i] <= ccx_spc1_sa[i-1] ^ eqed_ccx_spc1[j]; 
		   end
		       ccx_spc1_sa[i+1] <= ccx_spc1_sa[i];
		       ccx_spc1_sa[i+2] <= ccx_spc1_sa[i+1];
	           ccx_spc1_sa[i+3] <= ccx_spc1_sa[i+2];
		       ccx_spc1_sa[i+4] <= ccx_spc1_sa[i+3];
		       ccx_spc1_sa[i+5] <= ccx_spc1_sa[i+4];
		       ccx_spc1_sa[i+6] <= ccx_spc1_sa[i+5];
			   ccx_spc1_sa[i+7] <= ccx_spc1_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       spc1_ccx_sa2 <= 1;
       ccx_spc1_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc1_ccx_sa2[0] <= spc1_ccx_sa2[1147] ^ spc1_ccx_sa2[1134] ^ spc1_ccx_sa2[1133] ^ spc1_ccx_sa2[1128] ^ eqed_spc1_ccx[0];
		   end else begin
			   spc1_ccx_sa2[i] <= spc1_ccx_sa2[i] ^ eqed_spc1_ccx[j]; 
		   end
		       spc1_ccx_sa2[i+1] <= spc1_ccx_sa2[i];
		       spc1_ccx_sa2[i+2] <= spc1_ccx_sa2[i+1];
	           spc1_ccx_sa2[i+3] <= spc1_ccx_sa2[i+2];
		       spc1_ccx_sa2[i+4] <= spc1_ccx_sa2[i+3];
		       spc1_ccx_sa2[i+5] <= spc1_ccx_sa2[i+4];
		       spc1_ccx_sa2[i+6] <= spc1_ccx_sa2[i+5];
			   spc1_ccx_sa2[i+7] <= spc1_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc1_sa2[0] <= ccx_spc1_sa2[1239] ^ ccx_spc1_sa2[1235] ^ ccx_spc1_sa2[1233] ^ ccx_spc1_sa2[1230] ^ eqed_ccx_spc1[0];
		   end else begin
			   ccx_spc1_sa2[i] <= ccx_spc1_sa2[i] ^ eqed_ccx_spc1[j]; 
		   end
		       ccx_spc1_sa2[i+1] <= ccx_spc1_sa2[i];
		       ccx_spc1_sa2[i+2] <= ccx_spc1_sa2[i+1];
	           ccx_spc1_sa2[i+3] <= ccx_spc1_sa2[i+2];
		       ccx_spc1_sa2[i+4] <= ccx_spc1_sa2[i+3];
		       ccx_spc1_sa2[i+5] <= ccx_spc1_sa2[i+4];
		       ccx_spc1_sa2[i+6] <= ccx_spc1_sa2[i+5];
			   ccx_spc1_sa2[i+7] <= ccx_spc1_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       spc2_ccx_sa <= 1;
       ccx_spc2_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc2_ccx_sa[0] <= spc2_ccx_sa[1147] ^ spc2_ccx_sa[1134] ^ spc2_ccx_sa[1133] ^ spc2_ccx_sa[1128] ^ eqed_spc2_ccx[0];
		   end else begin
			   spc2_ccx_sa[i] <= spc2_ccx_sa[i-1] ^ eqed_spc2_ccx[j]; 
		   end
		       spc2_ccx_sa[i+1] <= spc2_ccx_sa[i];
		       spc2_ccx_sa[i+2] <= spc2_ccx_sa[i+1];
	           spc2_ccx_sa[i+3] <= spc2_ccx_sa[i+2];
		       spc2_ccx_sa[i+4] <= spc2_ccx_sa[i+3];
		       spc2_ccx_sa[i+5] <= spc2_ccx_sa[i+4];
		       spc2_ccx_sa[i+6] <= spc2_ccx_sa[i+5];
			   spc2_ccx_sa[i+7] <= spc2_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc2_sa[0] <= ccx_spc2_sa[1239] ^ ccx_spc2_sa[1235] ^ ccx_spc2_sa[1233] ^ ccx_spc2_sa[1230] ^ eqed_ccx_spc2[0];
		   end else begin
			   ccx_spc2_sa[i] <= ccx_spc2_sa[i-1] ^ eqed_ccx_spc2[j]; 
		   end
		       ccx_spc2_sa[i+1] <= ccx_spc2_sa[i];
		       ccx_spc2_sa[i+2] <= ccx_spc2_sa[i+1];
	           ccx_spc2_sa[i+3] <= ccx_spc2_sa[i+2];
		       ccx_spc2_sa[i+4] <= ccx_spc2_sa[i+3];
		       ccx_spc2_sa[i+5] <= ccx_spc2_sa[i+4];
		       ccx_spc2_sa[i+6] <= ccx_spc2_sa[i+5];
			   ccx_spc2_sa[i+7] <= ccx_spc2_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       spc2_ccx_sa2 <= 1;
       ccx_spc2_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc2_ccx_sa2[0] <= spc2_ccx_sa2[1147] ^ spc2_ccx_sa2[1134] ^ spc2_ccx_sa2[1133] ^ spc2_ccx_sa2[1128] ^ eqed_spc2_ccx[0];
		   end else begin
			   spc2_ccx_sa2[i] <= spc2_ccx_sa2[i] ^ eqed_spc2_ccx[j]; 
		   end
		       spc2_ccx_sa2[i+1] <= spc2_ccx_sa2[i];
		       spc2_ccx_sa2[i+2] <= spc2_ccx_sa2[i+1];
	           spc2_ccx_sa2[i+3] <= spc2_ccx_sa2[i+2];
		       spc2_ccx_sa2[i+4] <= spc2_ccx_sa2[i+3];
		       spc2_ccx_sa2[i+5] <= spc2_ccx_sa2[i+4];
		       spc2_ccx_sa2[i+6] <= spc2_ccx_sa2[i+5];
			   spc2_ccx_sa2[i+7] <= spc2_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc2_sa2[0] <= ccx_spc2_sa2[1239] ^ ccx_spc2_sa2[1235] ^ ccx_spc2_sa2[1233] ^ ccx_spc2_sa2[1230] ^ eqed_ccx_spc2[0];
		   end else begin
			   ccx_spc2_sa2[i] <= ccx_spc2_sa2[i] ^ eqed_ccx_spc2[j]; 
		   end
		       ccx_spc2_sa2[i+1] <= ccx_spc2_sa2[i];
		       ccx_spc2_sa2[i+2] <= ccx_spc2_sa2[i+1];
	           ccx_spc2_sa2[i+3] <= ccx_spc2_sa2[i+2];
		       ccx_spc2_sa2[i+4] <= ccx_spc2_sa2[i+3];
		       ccx_spc2_sa2[i+5] <= ccx_spc2_sa2[i+4];
		       ccx_spc2_sa2[i+6] <= ccx_spc2_sa2[i+5];
			   ccx_spc2_sa2[i+7] <= ccx_spc2_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       spc3_ccx_sa <= 1;
       ccx_spc3_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc3_ccx_sa[0] <= spc3_ccx_sa[1147] ^ spc3_ccx_sa[1134] ^ spc3_ccx_sa[1133] ^ spc3_ccx_sa[1128] ^ eqed_spc3_ccx[0];
		   end else begin
			   spc3_ccx_sa[i] <= spc3_ccx_sa[i-1] ^ eqed_spc3_ccx[j]; 
		   end
		       spc3_ccx_sa[i+1] <= spc3_ccx_sa[i];
		       spc3_ccx_sa[i+2] <= spc3_ccx_sa[i+1];
	           spc3_ccx_sa[i+3] <= spc3_ccx_sa[i+2];
		       spc3_ccx_sa[i+4] <= spc3_ccx_sa[i+3];
		       spc3_ccx_sa[i+5] <= spc3_ccx_sa[i+4];
		       spc3_ccx_sa[i+6] <= spc3_ccx_sa[i+5];
			   spc3_ccx_sa[i+7] <= spc3_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc3_sa[0] <= ccx_spc3_sa[1239] ^ ccx_spc3_sa[1235] ^ ccx_spc3_sa[1233] ^ ccx_spc3_sa[1230] ^ eqed_ccx_spc3[0];
		   end else begin
			   ccx_spc3_sa[i] <= ccx_spc3_sa[i-1] ^ eqed_ccx_spc3[j]; 
		   end
		       ccx_spc3_sa[i+1] <= ccx_spc3_sa[i];
		       ccx_spc3_sa[i+2] <= ccx_spc3_sa[i+1];
	           ccx_spc3_sa[i+3] <= ccx_spc3_sa[i+2];
		       ccx_spc3_sa[i+4] <= ccx_spc3_sa[i+3];
		       ccx_spc3_sa[i+5] <= ccx_spc3_sa[i+4];
		       ccx_spc3_sa[i+6] <= ccx_spc3_sa[i+5];
			   ccx_spc3_sa[i+7] <= ccx_spc3_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       spc3_ccx_sa2 <= 1;
       ccx_spc3_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc3_ccx_sa2[0] <= spc3_ccx_sa2[1147] ^ spc3_ccx_sa2[1134] ^ spc3_ccx_sa2[1133] ^ spc3_ccx_sa2[1128] ^ eqed_spc3_ccx[0];
		   end else begin
			   spc3_ccx_sa2[i] <= spc3_ccx_sa2[i] ^ eqed_spc3_ccx[j]; 
		   end
		       spc3_ccx_sa2[i+1] <= spc3_ccx_sa2[i];
		       spc3_ccx_sa2[i+2] <= spc3_ccx_sa2[i+1];
	           spc3_ccx_sa2[i+3] <= spc3_ccx_sa2[i+2];
		       spc3_ccx_sa2[i+4] <= spc3_ccx_sa2[i+3];
		       spc3_ccx_sa2[i+5] <= spc3_ccx_sa2[i+4];
		       spc3_ccx_sa2[i+6] <= spc3_ccx_sa2[i+5];
			   spc3_ccx_sa2[i+7] <= spc3_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc3_sa2[0] <= ccx_spc3_sa2[1239] ^ ccx_spc3_sa2[1235] ^ ccx_spc3_sa2[1233] ^ ccx_spc3_sa2[1230] ^ eqed_ccx_spc3[0];
		   end else begin
			   ccx_spc3_sa2[i] <= ccx_spc3_sa2[i] ^ eqed_ccx_spc3[j]; 
		   end
		       ccx_spc3_sa2[i+1] <= ccx_spc3_sa2[i];
		       ccx_spc3_sa2[i+2] <= ccx_spc3_sa2[i+1];
	           ccx_spc3_sa2[i+3] <= ccx_spc3_sa2[i+2];
		       ccx_spc3_sa2[i+4] <= ccx_spc3_sa2[i+3];
		       ccx_spc3_sa2[i+5] <= ccx_spc3_sa2[i+4];
		       ccx_spc3_sa2[i+6] <= ccx_spc3_sa2[i+5];
			   ccx_spc3_sa2[i+7] <= ccx_spc3_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       spc4_ccx_sa <= 1;
       ccx_spc4_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc4_ccx_sa[0] <= spc4_ccx_sa[1147] ^ spc4_ccx_sa[1134] ^ spc4_ccx_sa[1133] ^ spc4_ccx_sa[1128] ^ eqed_spc4_ccx[0];
		   end else begin
			   spc4_ccx_sa[i] <= spc4_ccx_sa[i-1] ^ eqed_spc4_ccx[j]; 
		   end
		       spc4_ccx_sa[i+1] <= spc4_ccx_sa[i];
		       spc4_ccx_sa[i+2] <= spc4_ccx_sa[i+1];
	           spc4_ccx_sa[i+3] <= spc4_ccx_sa[i+2];
		       spc4_ccx_sa[i+4] <= spc4_ccx_sa[i+3];
		       spc4_ccx_sa[i+5] <= spc4_ccx_sa[i+4];
		       spc4_ccx_sa[i+6] <= spc4_ccx_sa[i+5];
			   spc4_ccx_sa[i+7] <= spc4_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc4_sa[0] <= ccx_spc4_sa[1239] ^ ccx_spc4_sa[1235] ^ ccx_spc4_sa[1233] ^ ccx_spc4_sa[1230] ^ eqed_ccx_spc4[0];
		   end else begin
			   ccx_spc4_sa[i] <= ccx_spc4_sa[i-1] ^ eqed_ccx_spc4[j]; 
		   end
		       ccx_spc4_sa[i+1] <= ccx_spc4_sa[i];
		       ccx_spc4_sa[i+2] <= ccx_spc4_sa[i+1];
	           ccx_spc4_sa[i+3] <= ccx_spc4_sa[i+2];
		       ccx_spc4_sa[i+4] <= ccx_spc4_sa[i+3];
		       ccx_spc4_sa[i+5] <= ccx_spc4_sa[i+4];
		       ccx_spc4_sa[i+6] <= ccx_spc4_sa[i+5];
			   ccx_spc4_sa[i+7] <= ccx_spc4_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       spc4_ccx_sa2 <= 1;
       ccx_spc4_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc4_ccx_sa2[0] <= spc4_ccx_sa2[1147] ^ spc4_ccx_sa2[1134] ^ spc4_ccx_sa2[1133] ^ spc4_ccx_sa2[1128] ^ eqed_spc4_ccx[0];
		   end else begin
			   spc4_ccx_sa2[i] <= spc4_ccx_sa2[i] ^ eqed_spc4_ccx[j]; 
		   end
		       spc4_ccx_sa2[i+1] <= spc4_ccx_sa2[i];
		       spc4_ccx_sa2[i+2] <= spc4_ccx_sa2[i+1];
	           spc4_ccx_sa2[i+3] <= spc4_ccx_sa2[i+2];
		       spc4_ccx_sa2[i+4] <= spc4_ccx_sa2[i+3];
		       spc4_ccx_sa2[i+5] <= spc4_ccx_sa2[i+4];
		       spc4_ccx_sa2[i+6] <= spc4_ccx_sa2[i+5];
			   spc4_ccx_sa2[i+7] <= spc4_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc4_sa2[0] <= ccx_spc4_sa2[1239] ^ ccx_spc4_sa2[1235] ^ ccx_spc4_sa2[1233] ^ ccx_spc4_sa2[1230] ^ eqed_ccx_spc4[0];
		   end else begin
			   ccx_spc4_sa2[i] <= ccx_spc4_sa2[i] ^ eqed_ccx_spc4[j]; 
		   end
		       ccx_spc4_sa2[i+1] <= ccx_spc4_sa2[i];
		       ccx_spc4_sa2[i+2] <= ccx_spc4_sa2[i+1];
	           ccx_spc4_sa2[i+3] <= ccx_spc4_sa2[i+2];
		       ccx_spc4_sa2[i+4] <= ccx_spc4_sa2[i+3];
		       ccx_spc4_sa2[i+5] <= ccx_spc4_sa2[i+4];
		       ccx_spc4_sa2[i+6] <= ccx_spc4_sa2[i+5];
			   ccx_spc4_sa2[i+7] <= ccx_spc4_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       spc5_ccx_sa <= 1;
       ccx_spc5_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc5_ccx_sa[0] <= spc5_ccx_sa[1147] ^ spc5_ccx_sa[1134] ^ spc5_ccx_sa[1133] ^ spc5_ccx_sa[1128] ^ eqed_spc5_ccx[0];
		   end else begin
			   spc5_ccx_sa[i] <= spc5_ccx_sa[i-1] ^ eqed_spc5_ccx[j]; 
		   end
		       spc5_ccx_sa[i+1] <= spc5_ccx_sa[i];
		       spc5_ccx_sa[i+2] <= spc5_ccx_sa[i+1];
	           spc5_ccx_sa[i+3] <= spc5_ccx_sa[i+2];
		       spc5_ccx_sa[i+4] <= spc5_ccx_sa[i+3];
		       spc5_ccx_sa[i+5] <= spc5_ccx_sa[i+4];
		       spc5_ccx_sa[i+6] <= spc5_ccx_sa[i+5];
			   spc5_ccx_sa[i+7] <= spc5_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc5_sa[0] <= ccx_spc5_sa[1239] ^ ccx_spc5_sa[1235] ^ ccx_spc5_sa[1233] ^ ccx_spc5_sa[1230] ^ eqed_ccx_spc5[0];
		   end else begin
			   ccx_spc5_sa[i] <= ccx_spc5_sa[i-1] ^ eqed_ccx_spc5[j]; 
		   end
		       ccx_spc5_sa[i+1] <= ccx_spc5_sa[i];
		       ccx_spc5_sa[i+2] <= ccx_spc5_sa[i+1];
	           ccx_spc5_sa[i+3] <= ccx_spc5_sa[i+2];
		       ccx_spc5_sa[i+4] <= ccx_spc5_sa[i+3];
		       ccx_spc5_sa[i+5] <= ccx_spc5_sa[i+4];
		       ccx_spc5_sa[i+6] <= ccx_spc5_sa[i+5];
			   ccx_spc5_sa[i+7] <= ccx_spc5_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       spc5_ccx_sa2 <= 1;
       ccx_spc5_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc5_ccx_sa2[0] <= spc5_ccx_sa2[1147] ^ spc5_ccx_sa2[1134] ^ spc5_ccx_sa2[1133] ^ spc5_ccx_sa2[1128] ^ eqed_spc5_ccx[0];
		   end else begin
			   spc5_ccx_sa2[i] <= spc5_ccx_sa2[i] ^ eqed_spc5_ccx[j]; 
		   end
		       spc5_ccx_sa2[i+1] <= spc5_ccx_sa2[i];
		       spc5_ccx_sa2[i+2] <= spc5_ccx_sa2[i+1];
	           spc5_ccx_sa2[i+3] <= spc5_ccx_sa2[i+2];
		       spc5_ccx_sa2[i+4] <= spc5_ccx_sa2[i+3];
		       spc5_ccx_sa2[i+5] <= spc5_ccx_sa2[i+4];
		       spc5_ccx_sa2[i+6] <= spc5_ccx_sa2[i+5];
			   spc5_ccx_sa2[i+7] <= spc5_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc5_sa2[0] <= ccx_spc5_sa2[1239] ^ ccx_spc5_sa2[1235] ^ ccx_spc5_sa2[1233] ^ ccx_spc5_sa2[1230] ^ eqed_ccx_spc5[0];
		   end else begin
			   ccx_spc5_sa2[i] <= ccx_spc5_sa2[i] ^ eqed_ccx_spc5[j]; 
		   end
		       ccx_spc5_sa2[i+1] <= ccx_spc5_sa2[i];
		       ccx_spc5_sa2[i+2] <= ccx_spc5_sa2[i+1];
	           ccx_spc5_sa2[i+3] <= ccx_spc5_sa2[i+2];
		       ccx_spc5_sa2[i+4] <= ccx_spc5_sa2[i+3];
		       ccx_spc5_sa2[i+5] <= ccx_spc5_sa2[i+4];
		       ccx_spc5_sa2[i+6] <= ccx_spc5_sa2[i+5];
			   ccx_spc5_sa2[i+7] <= ccx_spc5_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       spc6_ccx_sa <= 1;
       ccx_spc6_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc6_ccx_sa[0] <= spc6_ccx_sa[1147] ^ spc6_ccx_sa[1134] ^ spc6_ccx_sa[1133] ^ spc6_ccx_sa[1128] ^ eqed_spc6_ccx[0];
		   end else begin
			   spc6_ccx_sa[i] <= spc6_ccx_sa[i-1] ^ eqed_spc6_ccx[j]; 
		   end
		       spc6_ccx_sa[i+1] <= spc6_ccx_sa[i];
		       spc6_ccx_sa[i+2] <= spc6_ccx_sa[i+1];
	           spc6_ccx_sa[i+3] <= spc6_ccx_sa[i+2];
		       spc6_ccx_sa[i+4] <= spc6_ccx_sa[i+3];
		       spc6_ccx_sa[i+5] <= spc6_ccx_sa[i+4];
		       spc6_ccx_sa[i+6] <= spc6_ccx_sa[i+5];
			   spc6_ccx_sa[i+7] <= spc6_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc6_sa[0] <= ccx_spc6_sa[1239] ^ ccx_spc6_sa[1235] ^ ccx_spc6_sa[1233] ^ ccx_spc6_sa[1230] ^ eqed_ccx_spc6[0];
		   end else begin
			   ccx_spc6_sa[i] <= ccx_spc6_sa[i-1] ^ eqed_ccx_spc6[j]; 
		   end
		       ccx_spc6_sa[i+1] <= ccx_spc6_sa[i];
		       ccx_spc6_sa[i+2] <= ccx_spc6_sa[i+1];
	           ccx_spc6_sa[i+3] <= ccx_spc6_sa[i+2];
		       ccx_spc6_sa[i+4] <= ccx_spc6_sa[i+3];
		       ccx_spc6_sa[i+5] <= ccx_spc6_sa[i+4];
		       ccx_spc6_sa[i+6] <= ccx_spc6_sa[i+5];
			   ccx_spc6_sa[i+7] <= ccx_spc6_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       spc6_ccx_sa2 <= 1;
       ccx_spc6_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc6_ccx_sa2[0] <= spc6_ccx_sa2[1147] ^ spc6_ccx_sa2[1134] ^ spc6_ccx_sa2[1133] ^ spc6_ccx_sa2[1128] ^ eqed_spc6_ccx[0];
		   end else begin
			   spc6_ccx_sa2[i] <= spc6_ccx_sa2[i] ^ eqed_spc6_ccx[j]; 
		   end
		       spc6_ccx_sa2[i+1] <= spc6_ccx_sa2[i];
		       spc6_ccx_sa2[i+2] <= spc6_ccx_sa2[i+1];
	           spc6_ccx_sa2[i+3] <= spc6_ccx_sa2[i+2];
		       spc6_ccx_sa2[i+4] <= spc6_ccx_sa2[i+3];
		       spc6_ccx_sa2[i+5] <= spc6_ccx_sa2[i+4];
		       spc6_ccx_sa2[i+6] <= spc6_ccx_sa2[i+5];
			   spc6_ccx_sa2[i+7] <= spc6_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc6_sa2[0] <= ccx_spc6_sa2[1239] ^ ccx_spc6_sa2[1235] ^ ccx_spc6_sa2[1233] ^ ccx_spc6_sa2[1230] ^ eqed_ccx_spc6[0];
		   end else begin
			   ccx_spc6_sa2[i] <= ccx_spc6_sa2[i] ^ eqed_ccx_spc6[j]; 
		   end
		       ccx_spc6_sa2[i+1] <= ccx_spc6_sa2[i];
		       ccx_spc6_sa2[i+2] <= ccx_spc6_sa2[i+1];
	           ccx_spc6_sa2[i+3] <= ccx_spc6_sa2[i+2];
		       ccx_spc6_sa2[i+4] <= ccx_spc6_sa2[i+3];
		       ccx_spc6_sa2[i+5] <= ccx_spc6_sa2[i+4];
		       ccx_spc6_sa2[i+6] <= ccx_spc6_sa2[i+5];
			   ccx_spc6_sa2[i+7] <= ccx_spc6_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       spc7_ccx_sa <= 1;
       ccx_spc7_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc7_ccx_sa[0] <= spc7_ccx_sa[1147] ^ spc7_ccx_sa[1134] ^ spc7_ccx_sa[1133] ^ spc7_ccx_sa[1128] ^ eqed_spc7_ccx[0];
		   end else begin
			   spc7_ccx_sa[i] <= spc7_ccx_sa[i-1] ^ eqed_spc7_ccx[j]; 
		   end
		       spc7_ccx_sa[i+1] <= spc7_ccx_sa[i];
		       spc7_ccx_sa[i+2] <= spc7_ccx_sa[i+1];
	           spc7_ccx_sa[i+3] <= spc7_ccx_sa[i+2];
		       spc7_ccx_sa[i+4] <= spc7_ccx_sa[i+3];
		       spc7_ccx_sa[i+5] <= spc7_ccx_sa[i+4];
		       spc7_ccx_sa[i+6] <= spc7_ccx_sa[i+5];
			   spc7_ccx_sa[i+7] <= spc7_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc7_sa[0] <= ccx_spc7_sa[1239] ^ ccx_spc7_sa[1235] ^ ccx_spc7_sa[1233] ^ ccx_spc7_sa[1230] ^ eqed_ccx_spc7[0];
		   end else begin
			   ccx_spc7_sa[i] <= ccx_spc7_sa[i-1] ^ eqed_ccx_spc7[j]; 
		   end
		       ccx_spc7_sa[i+1] <= ccx_spc7_sa[i];
		       ccx_spc7_sa[i+2] <= ccx_spc7_sa[i+1];
	           ccx_spc7_sa[i+3] <= ccx_spc7_sa[i+2];
		       ccx_spc7_sa[i+4] <= ccx_spc7_sa[i+3];
		       ccx_spc7_sa[i+5] <= ccx_spc7_sa[i+4];
		       ccx_spc7_sa[i+6] <= ccx_spc7_sa[i+5];
			   ccx_spc7_sa[i+7] <= ccx_spc7_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       spc7_ccx_sa2 <= 1;
       ccx_spc7_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < SPC_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       spc7_ccx_sa2[0] <= spc7_ccx_sa2[1147] ^ spc7_ccx_sa2[1134] ^ spc7_ccx_sa2[1133] ^ spc7_ccx_sa2[1128] ^ eqed_spc7_ccx[0];
		   end else begin
			   spc7_ccx_sa2[i] <= spc7_ccx_sa2[i] ^ eqed_spc7_ccx[j]; 
		   end
		       spc7_ccx_sa2[i+1] <= spc7_ccx_sa2[i];
		       spc7_ccx_sa2[i+2] <= spc7_ccx_sa2[i+1];
	           spc7_ccx_sa2[i+3] <= spc7_ccx_sa2[i+2];
		       spc7_ccx_sa2[i+4] <= spc7_ccx_sa2[i+3];
		       spc7_ccx_sa2[i+5] <= spc7_ccx_sa2[i+4];
		       spc7_ccx_sa2[i+6] <= spc7_ccx_sa2[i+5];
			   spc7_ccx_sa2[i+7] <= spc7_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_SPC_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_spc7_sa2[0] <= ccx_spc7_sa2[1239] ^ ccx_spc7_sa2[1235] ^ ccx_spc7_sa2[1233] ^ ccx_spc7_sa2[1230] ^ eqed_ccx_spc7[0];
		   end else begin
			   ccx_spc7_sa2[i] <= ccx_spc7_sa2[i] ^ eqed_ccx_spc7[j]; 
		   end
		       ccx_spc7_sa2[i+1] <= ccx_spc7_sa2[i];
		       ccx_spc7_sa2[i+2] <= ccx_spc7_sa2[i+1];
	           ccx_spc7_sa2[i+3] <= ccx_spc7_sa2[i+2];
		       ccx_spc7_sa2[i+4] <= ccx_spc7_sa2[i+3];
		       ccx_spc7_sa2[i+5] <= ccx_spc7_sa2[i+4];
		       ccx_spc7_sa2[i+6] <= ccx_spc7_sa2[i+5];
			   ccx_spc7_sa2[i+7] <= ccx_spc7_sa2[i+6];
       end
    end
end

*/

// CCX-L2C interface
wire [139:0] eqed_ccx_l2c0;
wire [155:0] eqed_l2c0_ccx;
wire [139:0] eqed_ccx_l2c1;
wire [155:0] eqed_l2c1_ccx;
wire [139:0] eqed_ccx_l2c2;
wire [155:0] eqed_l2c2_ccx;
wire [139:0] eqed_ccx_l2c3;
wire [155:0] eqed_l2c3_ccx;
wire [139:0] eqed_ccx_l2c4;
wire [155:0] eqed_l2c4_ccx;
wire [139:0] eqed_ccx_l2c5;
wire [155:0] eqed_l2c5_ccx;
wire [139:0] eqed_ccx_l2c6;
wire [155:0] eqed_l2c6_ccx;
wire [139:0] eqed_ccx_l2c7;
wire [155:0] eqed_l2c7_ccx;

assign eqed_ccx_l2c0 = {pcx_sctag0_atm_px1, pcx_sctag0_data_px2, pcx_sctag0_data_rdy_px1, cpx_sctag0_grant_cx};
assign eqed_l2c0_ccx = {sctag0_cpx_atom_cq, sctag0_cpx_data_ca, sctag0_cpx_req_cq};
assign eqed_ccx_l2c1 = {pcx_sctag1_atm_px1, pcx_sctag1_data_px2, pcx_sctag1_data_rdy_px1, cpx_sctag1_grant_cx};
assign eqed_l2c1_ccx = {sctag1_cpx_atom_cq, sctag1_cpx_data_ca, sctag1_cpx_req_cq};
assign eqed_ccx_l2c2 = {pcx_sctag2_atm_px1, pcx_sctag2_data_px2, pcx_sctag2_data_rdy_px1, cpx_sctag2_grant_cx};
assign eqed_l2c2_ccx = {sctag2_cpx_atom_cq, sctag2_cpx_data_ca, sctag2_cpx_req_cq};
assign eqed_ccx_l2c3 = {pcx_sctag3_atm_px1, pcx_sctag3_data_px2, pcx_sctag3_data_rdy_px1, cpx_sctag3_grant_cx};
assign eqed_l2c3_ccx = {sctag3_cpx_atom_cq, sctag3_cpx_data_ca, sctag3_cpx_req_cq};
assign eqed_ccx_l2c4 = {pcx_sctag4_atm_px1, pcx_sctag4_data_px2, pcx_sctag4_data_rdy_px1, cpx_sctag4_grant_cx};
assign eqed_l2c4_ccx = {sctag4_cpx_atom_cq, sctag4_cpx_data_ca, sctag4_cpx_req_cq};
assign eqed_ccx_l2c5 = {pcx_sctag5_atm_px1, pcx_sctag5_data_px2, pcx_sctag5_data_rdy_px1, cpx_sctag5_grant_cx};
assign eqed_l2c5_ccx = {sctag5_cpx_atom_cq, sctag5_cpx_data_ca, sctag5_cpx_req_cq};
assign eqed_ccx_l2c6 = {pcx_sctag6_atm_px1, pcx_sctag6_data_px2, pcx_sctag6_data_rdy_px1, cpx_sctag6_grant_cx};
assign eqed_l2c6_ccx = {sctag6_cpx_atom_cq, sctag6_cpx_data_ca, sctag6_cpx_req_cq};
assign eqed_ccx_l2c7 = {pcx_sctag7_atm_px1, pcx_sctag7_data_px2, pcx_sctag7_data_rdy_px1, cpx_sctag7_grant_cx};
assign eqed_l2c7_ccx = {sctag7_cpx_atom_cq, sctag7_cpx_data_ca, sctag7_cpx_req_cq};

parameter L2C_CCX_B = 156;
parameter CCX_L2C_B = 140;

parameter L2C_CCX_SB_SIZE = 1248;
parameter CCX_L2C_SB_SIZE = 1120;

// Declare the registers for the Signature Analyzer MISRs
reg [L2C_CCX_SB_SIZE:0] l2c0_ccx_sa;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c0_sa;
/*
reg [L2C_CCX_SB_SIZE:0] l2c1_ccx_sa;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c1_sa;
reg [L2C_CCX_SB_SIZE:0] l2c2_ccx_sa;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c2_sa;
reg [L2C_CCX_SB_SIZE:0] l2c3_ccx_sa;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c3_sa;
reg [L2C_CCX_SB_SIZE:0] l2c4_ccx_sa;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c4_sa;
reg [L2C_CCX_SB_SIZE:0] l2c5_ccx_sa;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c5_sa;
reg [L2C_CCX_SB_SIZE:0] l2c6_ccx_sa;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c6_sa;
reg [L2C_CCX_SB_SIZE:0] l2c7_ccx_sa;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c7_sa;
*/
// Declare the registers for the Signature Analyzer MISRs
reg [L2C_CCX_SB_SIZE:0] l2c0_ccx_sa2;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c0_sa2;
/*
reg [L2C_CCX_SB_SIZE:0] l2c1_ccx_sa2;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c1_sa2;
reg [L2C_CCX_SB_SIZE:0] l2c2_ccx_sa2;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c2_sa2;
reg [L2C_CCX_SB_SIZE:0] l2c3_ccx_sa2;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c3_sa2;
reg [L2C_CCX_SB_SIZE:0] l2c4_ccx_sa2;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c4_sa2;
reg [L2C_CCX_SB_SIZE:0] l2c5_ccx_sa2;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c5_sa2;
reg [L2C_CCX_SB_SIZE:0] l2c6_ccx_sa2;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c6_sa2;
reg [L2C_CCX_SB_SIZE:0] l2c7_ccx_sa2;
reg [CCX_L2C_SB_SIZE:0] ccx_l2c7_sa2;
*/

always @(posedge clk) begin
    if (m_rst) begin
       l2c0_ccx_sa <= 1;
       ccx_l2c0_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c0_ccx_sa[0] <= l2c0_ccx_sa[1246] ^ l2c0_ccx_sa[1243] ^ l2c0_ccx_sa[1242] ^ l2c0_ccx_sa[1241] ^ eqed_l2c0_ccx[0];
		   end else begin
			   l2c0_ccx_sa[i] <= l2c0_ccx_sa[i-1] ^ eqed_l2c0_ccx[j]; 
		   end
		       l2c0_ccx_sa[i+1] <= l2c0_ccx_sa[i];
		       l2c0_ccx_sa[i+2] <= l2c0_ccx_sa[i+1];
	           l2c0_ccx_sa[i+3] <= l2c0_ccx_sa[i+2];
		       l2c0_ccx_sa[i+4] <= l2c0_ccx_sa[i+3];
		       l2c0_ccx_sa[i+5] <= l2c0_ccx_sa[i+4];
		       l2c0_ccx_sa[i+6] <= l2c0_ccx_sa[i+5];
			   l2c0_ccx_sa[i+7] <= l2c0_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c0_sa[0] <= ccx_l2c0_sa[1119] ^ ccx_l2c0_sa[1114] ^ ccx_l2c0_sa[1110] ^ ccx_l2c0_sa[1108] ^ eqed_ccx_l2c0[0];
		   end else begin
			   ccx_l2c0_sa[i] <= ccx_l2c0_sa[i-1] ^ eqed_ccx_l2c0[j]; 
		   end
		       ccx_l2c0_sa[i+1] <= ccx_l2c0_sa[i];
		       ccx_l2c0_sa[i+2] <= ccx_l2c0_sa[i+1];
	           ccx_l2c0_sa[i+3] <= ccx_l2c0_sa[i+2];
		       ccx_l2c0_sa[i+4] <= ccx_l2c0_sa[i+3];
		       ccx_l2c0_sa[i+5] <= ccx_l2c0_sa[i+4];
		       ccx_l2c0_sa[i+6] <= ccx_l2c0_sa[i+5];
			   ccx_l2c0_sa[i+7] <= ccx_l2c0_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c0_ccx_sa2 <= 1;
       ccx_l2c0_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c0_ccx_sa2[0] <= l2c0_ccx_sa2[1246] ^ l2c0_ccx_sa2[1243] ^ l2c0_ccx_sa2[1242] ^ l2c0_ccx_sa2[1241] ^ eqed_l2c0_ccx[0];
		   end else begin
			   l2c0_ccx_sa2[i] <= l2c0_ccx_sa2[i] ^ eqed_l2c0_ccx[j]; 
		   end
		       l2c0_ccx_sa2[i+1] <= l2c0_ccx_sa2[i];
		       l2c0_ccx_sa2[i+2] <= l2c0_ccx_sa2[i+1];
	           l2c0_ccx_sa2[i+3] <= l2c0_ccx_sa2[i+2];
		       l2c0_ccx_sa2[i+4] <= l2c0_ccx_sa2[i+3];
		       l2c0_ccx_sa2[i+5] <= l2c0_ccx_sa2[i+4];
		       l2c0_ccx_sa2[i+6] <= l2c0_ccx_sa2[i+5];
			   l2c0_ccx_sa2[i+7] <= l2c0_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c0_sa2[0] <= ccx_l2c0_sa2[1119] ^ ccx_l2c0_sa2[1114] ^ ccx_l2c0_sa2[1110] ^ ccx_l2c0_sa2[1108] ^ eqed_ccx_l2c0[0];
		   end else begin
			   ccx_l2c0_sa2[i] <= ccx_l2c0_sa2[i] ^ eqed_ccx_l2c0[j]; 
		   end
		       ccx_l2c0_sa2[i+1] <= ccx_l2c0_sa2[i];
		       ccx_l2c0_sa2[i+2] <= ccx_l2c0_sa2[i+1];
	           ccx_l2c0_sa2[i+3] <= ccx_l2c0_sa2[i+2];
		       ccx_l2c0_sa2[i+4] <= ccx_l2c0_sa2[i+3];
		       ccx_l2c0_sa2[i+5] <= ccx_l2c0_sa2[i+4];
		       ccx_l2c0_sa2[i+6] <= ccx_l2c0_sa2[i+5];
			   ccx_l2c0_sa2[i+7] <= ccx_l2c0_sa2[i+6];
       end
    end
end
/*
always @(posedge clk) begin
    if (m_rst) begin
       l2c1_ccx_sa <= 1;
       ccx_l2c1_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c1_ccx_sa[0] <= l2c1_ccx_sa[1246] ^ l2c1_ccx_sa[1243] ^ l2c1_ccx_sa[1242] ^ l2c1_ccx_sa[1241] ^ eqed_l2c1_ccx[0];
		   end else begin
			   l2c1_ccx_sa[i] <= l2c1_ccx_sa[i-1] ^ eqed_l2c1_ccx[j]; 
		   end
		       l2c1_ccx_sa[i+1] <= l2c1_ccx_sa[i];
		       l2c1_ccx_sa[i+2] <= l2c1_ccx_sa[i+1];
	           l2c1_ccx_sa[i+3] <= l2c1_ccx_sa[i+2];
		       l2c1_ccx_sa[i+4] <= l2c1_ccx_sa[i+3];
		       l2c1_ccx_sa[i+5] <= l2c1_ccx_sa[i+4];
		       l2c1_ccx_sa[i+6] <= l2c1_ccx_sa[i+5];
			   l2c1_ccx_sa[i+7] <= l2c1_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c1_sa[0] <= ccx_l2c1_sa[1119] ^ ccx_l2c1_sa[1114] ^ ccx_l2c1_sa[1110] ^ ccx_l2c1_sa[1108] ^ eqed_ccx_l2c1[0];
		   end else begin
			   ccx_l2c1_sa[i] <= ccx_l2c1_sa[i-1] ^ eqed_ccx_l2c1[j]; 
		   end
		       ccx_l2c1_sa[i+1] <= ccx_l2c1_sa[i];
		       ccx_l2c1_sa[i+2] <= ccx_l2c1_sa[i+1];
	           ccx_l2c1_sa[i+3] <= ccx_l2c1_sa[i+2];
		       ccx_l2c1_sa[i+4] <= ccx_l2c1_sa[i+3];
		       ccx_l2c1_sa[i+5] <= ccx_l2c1_sa[i+4];
		       ccx_l2c1_sa[i+6] <= ccx_l2c1_sa[i+5];
			   ccx_l2c1_sa[i+7] <= ccx_l2c1_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c1_ccx_sa2 <= 1;
       ccx_l2c1_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c1_ccx_sa2[0] <= l2c1_ccx_sa2[1246] ^ l2c1_ccx_sa2[1243] ^ l2c1_ccx_sa2[1242] ^ l2c1_ccx_sa2[1241] ^ eqed_l2c1_ccx[0];
		   end else begin
			   l2c1_ccx_sa2[i] <= l2c1_ccx_sa2[i] ^ eqed_l2c1_ccx[j]; 
		   end
		       l2c1_ccx_sa2[i+1] <= l2c1_ccx_sa2[i];
		       l2c1_ccx_sa2[i+2] <= l2c1_ccx_sa2[i+1];
	           l2c1_ccx_sa2[i+3] <= l2c1_ccx_sa2[i+2];
		       l2c1_ccx_sa2[i+4] <= l2c1_ccx_sa2[i+3];
		       l2c1_ccx_sa2[i+5] <= l2c1_ccx_sa2[i+4];
		       l2c1_ccx_sa2[i+6] <= l2c1_ccx_sa2[i+5];
			   l2c1_ccx_sa2[i+7] <= l2c1_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c1_sa2[0] <= ccx_l2c1_sa2[1119] ^ ccx_l2c1_sa2[1114] ^ ccx_l2c1_sa2[1110] ^ ccx_l2c1_sa2[1108] ^ eqed_ccx_l2c1[0];
		   end else begin
			   ccx_l2c1_sa2[i] <= ccx_l2c1_sa2[i] ^ eqed_ccx_l2c1[j]; 
		   end
		       ccx_l2c1_sa2[i+1] <= ccx_l2c1_sa2[i];
		       ccx_l2c1_sa2[i+2] <= ccx_l2c1_sa2[i+1];
	           ccx_l2c1_sa2[i+3] <= ccx_l2c1_sa2[i+2];
		       ccx_l2c1_sa2[i+4] <= ccx_l2c1_sa2[i+3];
		       ccx_l2c1_sa2[i+5] <= ccx_l2c1_sa2[i+4];
		       ccx_l2c1_sa2[i+6] <= ccx_l2c1_sa2[i+5];
			   ccx_l2c1_sa2[i+7] <= ccx_l2c1_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c2_ccx_sa <= 1;
       ccx_l2c2_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c2_ccx_sa[0] <= l2c2_ccx_sa[1246] ^ l2c2_ccx_sa[1243] ^ l2c2_ccx_sa[1242] ^ l2c2_ccx_sa[1241] ^ eqed_l2c2_ccx[0];
		   end else begin
			   l2c2_ccx_sa[i] <= l2c2_ccx_sa[i-1] ^ eqed_l2c2_ccx[j]; 
		   end
		       l2c2_ccx_sa[i+1] <= l2c2_ccx_sa[i];
		       l2c2_ccx_sa[i+2] <= l2c2_ccx_sa[i+1];
	           l2c2_ccx_sa[i+3] <= l2c2_ccx_sa[i+2];
		       l2c2_ccx_sa[i+4] <= l2c2_ccx_sa[i+3];
		       l2c2_ccx_sa[i+5] <= l2c2_ccx_sa[i+4];
		       l2c2_ccx_sa[i+6] <= l2c2_ccx_sa[i+5];
			   l2c2_ccx_sa[i+7] <= l2c2_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c2_sa[0] <= ccx_l2c2_sa[1119] ^ ccx_l2c2_sa[1114] ^ ccx_l2c2_sa[1110] ^ ccx_l2c2_sa[1108] ^ eqed_ccx_l2c2[0];
		   end else begin
			   ccx_l2c2_sa[i] <= ccx_l2c2_sa[i-1] ^ eqed_ccx_l2c2[j]; 
		   end
		       ccx_l2c2_sa[i+1] <= ccx_l2c2_sa[i];
		       ccx_l2c2_sa[i+2] <= ccx_l2c2_sa[i+1];
	           ccx_l2c2_sa[i+3] <= ccx_l2c2_sa[i+2];
		       ccx_l2c2_sa[i+4] <= ccx_l2c2_sa[i+3];
		       ccx_l2c2_sa[i+5] <= ccx_l2c2_sa[i+4];
		       ccx_l2c2_sa[i+6] <= ccx_l2c2_sa[i+5];
			   ccx_l2c2_sa[i+7] <= ccx_l2c2_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c2_ccx_sa2 <= 1;
       ccx_l2c2_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c2_ccx_sa2[0] <= l2c2_ccx_sa2[1246] ^ l2c2_ccx_sa2[1243] ^ l2c2_ccx_sa2[1242] ^ l2c2_ccx_sa2[1241] ^ eqed_l2c2_ccx[0];
		   end else begin
			   l2c2_ccx_sa2[i] <= l2c2_ccx_sa2[i] ^ eqed_l2c2_ccx[j]; 
		   end
		       l2c2_ccx_sa2[i+1] <= l2c2_ccx_sa2[i];
		       l2c2_ccx_sa2[i+2] <= l2c2_ccx_sa2[i+1];
	           l2c2_ccx_sa2[i+3] <= l2c2_ccx_sa2[i+2];
		       l2c2_ccx_sa2[i+4] <= l2c2_ccx_sa2[i+3];
		       l2c2_ccx_sa2[i+5] <= l2c2_ccx_sa2[i+4];
		       l2c2_ccx_sa2[i+6] <= l2c2_ccx_sa2[i+5];
			   l2c2_ccx_sa2[i+7] <= l2c2_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c2_sa2[0] <= ccx_l2c2_sa2[1119] ^ ccx_l2c2_sa2[1114] ^ ccx_l2c2_sa2[1110] ^ ccx_l2c2_sa2[1108] ^ eqed_ccx_l2c2[0];
		   end else begin
			   ccx_l2c2_sa2[i] <= ccx_l2c2_sa2[i] ^ eqed_ccx_l2c2[j]; 
		   end
		       ccx_l2c2_sa2[i+1] <= ccx_l2c2_sa2[i];
		       ccx_l2c2_sa2[i+2] <= ccx_l2c2_sa2[i+1];
	           ccx_l2c2_sa2[i+3] <= ccx_l2c2_sa2[i+2];
		       ccx_l2c2_sa2[i+4] <= ccx_l2c2_sa2[i+3];
		       ccx_l2c2_sa2[i+5] <= ccx_l2c2_sa2[i+4];
		       ccx_l2c2_sa2[i+6] <= ccx_l2c2_sa2[i+5];
			   ccx_l2c2_sa2[i+7] <= ccx_l2c2_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c3_ccx_sa <= 1;
       ccx_l2c3_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c3_ccx_sa[0] <= l2c3_ccx_sa[1246] ^ l2c3_ccx_sa[1243] ^ l2c3_ccx_sa[1242] ^ l2c3_ccx_sa[1241] ^ eqed_l2c3_ccx[0];
		   end else begin
			   l2c3_ccx_sa[i] <= l2c3_ccx_sa[i-1] ^ eqed_l2c3_ccx[j]; 
		   end
		       l2c3_ccx_sa[i+1] <= l2c3_ccx_sa[i];
		       l2c3_ccx_sa[i+2] <= l2c3_ccx_sa[i+1];
	           l2c3_ccx_sa[i+3] <= l2c3_ccx_sa[i+2];
		       l2c3_ccx_sa[i+4] <= l2c3_ccx_sa[i+3];
		       l2c3_ccx_sa[i+5] <= l2c3_ccx_sa[i+4];
		       l2c3_ccx_sa[i+6] <= l2c3_ccx_sa[i+5];
			   l2c3_ccx_sa[i+7] <= l2c3_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c3_sa[0] <= ccx_l2c3_sa[1119] ^ ccx_l2c3_sa[1114] ^ ccx_l2c3_sa[1110] ^ ccx_l2c3_sa[1108] ^ eqed_ccx_l2c3[0];
		   end else begin
			   ccx_l2c3_sa[i] <= ccx_l2c3_sa[i-1] ^ eqed_ccx_l2c3[j]; 
		   end
		       ccx_l2c3_sa[i+1] <= ccx_l2c3_sa[i];
		       ccx_l2c3_sa[i+2] <= ccx_l2c3_sa[i+1];
	           ccx_l2c3_sa[i+3] <= ccx_l2c3_sa[i+2];
		       ccx_l2c3_sa[i+4] <= ccx_l2c3_sa[i+3];
		       ccx_l2c3_sa[i+5] <= ccx_l2c3_sa[i+4];
		       ccx_l2c3_sa[i+6] <= ccx_l2c3_sa[i+5];
			   ccx_l2c3_sa[i+7] <= ccx_l2c3_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c3_ccx_sa2 <= 1;
       ccx_l2c3_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c3_ccx_sa2[0] <= l2c3_ccx_sa2[1246] ^ l2c3_ccx_sa2[1243] ^ l2c3_ccx_sa2[1242] ^ l2c3_ccx_sa2[1241] ^ eqed_l2c3_ccx[0];
		   end else begin
			   l2c3_ccx_sa2[i] <= l2c3_ccx_sa2[i] ^ eqed_l2c3_ccx[j]; 
		   end
		       l2c3_ccx_sa2[i+1] <= l2c3_ccx_sa2[i];
		       l2c3_ccx_sa2[i+2] <= l2c3_ccx_sa2[i+1];
	           l2c3_ccx_sa2[i+3] <= l2c3_ccx_sa2[i+2];
		       l2c3_ccx_sa2[i+4] <= l2c3_ccx_sa2[i+3];
		       l2c3_ccx_sa2[i+5] <= l2c3_ccx_sa2[i+4];
		       l2c3_ccx_sa2[i+6] <= l2c3_ccx_sa2[i+5];
			   l2c3_ccx_sa2[i+7] <= l2c3_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c3_sa2[0] <= ccx_l2c3_sa2[1119] ^ ccx_l2c3_sa2[1114] ^ ccx_l2c3_sa2[1110] ^ ccx_l2c3_sa2[1108] ^ eqed_ccx_l2c3[0];
		   end else begin
			   ccx_l2c3_sa2[i] <= ccx_l2c3_sa2[i] ^ eqed_ccx_l2c3[j]; 
		   end
		       ccx_l2c3_sa2[i+1] <= ccx_l2c3_sa2[i];
		       ccx_l2c3_sa2[i+2] <= ccx_l2c3_sa2[i+1];
	           ccx_l2c3_sa2[i+3] <= ccx_l2c3_sa2[i+2];
		       ccx_l2c3_sa2[i+4] <= ccx_l2c3_sa2[i+3];
		       ccx_l2c3_sa2[i+5] <= ccx_l2c3_sa2[i+4];
		       ccx_l2c3_sa2[i+6] <= ccx_l2c3_sa2[i+5];
			   ccx_l2c3_sa2[i+7] <= ccx_l2c3_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c4_ccx_sa <= 1;
       ccx_l2c4_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c4_ccx_sa[0] <= l2c4_ccx_sa[1246] ^ l2c4_ccx_sa[1243] ^ l2c4_ccx_sa[1242] ^ l2c4_ccx_sa[1241] ^ eqed_l2c4_ccx[0];
		   end else begin
			   l2c4_ccx_sa[i] <= l2c4_ccx_sa[i-1] ^ eqed_l2c4_ccx[j]; 
		   end
		       l2c4_ccx_sa[i+1] <= l2c4_ccx_sa[i];
		       l2c4_ccx_sa[i+2] <= l2c4_ccx_sa[i+1];
	           l2c4_ccx_sa[i+3] <= l2c4_ccx_sa[i+2];
		       l2c4_ccx_sa[i+4] <= l2c4_ccx_sa[i+3];
		       l2c4_ccx_sa[i+5] <= l2c4_ccx_sa[i+4];
		       l2c4_ccx_sa[i+6] <= l2c4_ccx_sa[i+5];
			   l2c4_ccx_sa[i+7] <= l2c4_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c4_sa[0] <= ccx_l2c4_sa[1119] ^ ccx_l2c4_sa[1114] ^ ccx_l2c4_sa[1110] ^ ccx_l2c4_sa[1108] ^ eqed_ccx_l2c4[0];
		   end else begin
			   ccx_l2c4_sa[i] <= ccx_l2c4_sa[i-1] ^ eqed_ccx_l2c4[j]; 
		   end
		       ccx_l2c4_sa[i+1] <= ccx_l2c4_sa[i];
		       ccx_l2c4_sa[i+2] <= ccx_l2c4_sa[i+1];
	           ccx_l2c4_sa[i+3] <= ccx_l2c4_sa[i+2];
		       ccx_l2c4_sa[i+4] <= ccx_l2c4_sa[i+3];
		       ccx_l2c4_sa[i+5] <= ccx_l2c4_sa[i+4];
		       ccx_l2c4_sa[i+6] <= ccx_l2c4_sa[i+5];
			   ccx_l2c4_sa[i+7] <= ccx_l2c4_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c4_ccx_sa2 <= 1;
       ccx_l2c4_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c4_ccx_sa2[0] <= l2c4_ccx_sa2[1246] ^ l2c4_ccx_sa2[1243] ^ l2c4_ccx_sa2[1242] ^ l2c4_ccx_sa2[1241] ^ eqed_l2c4_ccx[0];
		   end else begin
			   l2c4_ccx_sa2[i] <= l2c4_ccx_sa2[i] ^ eqed_l2c4_ccx[j]; 
		   end
		       l2c4_ccx_sa2[i+1] <= l2c4_ccx_sa2[i];
		       l2c4_ccx_sa2[i+2] <= l2c4_ccx_sa2[i+1];
	           l2c4_ccx_sa2[i+3] <= l2c4_ccx_sa2[i+2];
		       l2c4_ccx_sa2[i+4] <= l2c4_ccx_sa2[i+3];
		       l2c4_ccx_sa2[i+5] <= l2c4_ccx_sa2[i+4];
		       l2c4_ccx_sa2[i+6] <= l2c4_ccx_sa2[i+5];
			   l2c4_ccx_sa2[i+7] <= l2c4_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c4_sa2[0] <= ccx_l2c4_sa2[1119] ^ ccx_l2c4_sa2[1114] ^ ccx_l2c4_sa2[1110] ^ ccx_l2c4_sa2[1108] ^ eqed_ccx_l2c4[0];
		   end else begin
			   ccx_l2c4_sa2[i] <= ccx_l2c4_sa2[i] ^ eqed_ccx_l2c4[j]; 
		   end
		       ccx_l2c4_sa2[i+1] <= ccx_l2c4_sa2[i];
		       ccx_l2c4_sa2[i+2] <= ccx_l2c4_sa2[i+1];
	           ccx_l2c4_sa2[i+3] <= ccx_l2c4_sa2[i+2];
		       ccx_l2c4_sa2[i+4] <= ccx_l2c4_sa2[i+3];
		       ccx_l2c4_sa2[i+5] <= ccx_l2c4_sa2[i+4];
		       ccx_l2c4_sa2[i+6] <= ccx_l2c4_sa2[i+5];
			   ccx_l2c4_sa2[i+7] <= ccx_l2c4_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c5_ccx_sa <= 1;
       ccx_l2c5_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c5_ccx_sa[0] <= l2c5_ccx_sa[1246] ^ l2c5_ccx_sa[1243] ^ l2c5_ccx_sa[1242] ^ l2c5_ccx_sa[1241] ^ eqed_l2c5_ccx[0];
		   end else begin
			   l2c5_ccx_sa[i] <= l2c5_ccx_sa[i-1] ^ eqed_l2c5_ccx[j]; 
		   end
		       l2c5_ccx_sa[i+1] <= l2c5_ccx_sa[i];
		       l2c5_ccx_sa[i+2] <= l2c5_ccx_sa[i+1];
	           l2c5_ccx_sa[i+3] <= l2c5_ccx_sa[i+2];
		       l2c5_ccx_sa[i+4] <= l2c5_ccx_sa[i+3];
		       l2c5_ccx_sa[i+5] <= l2c5_ccx_sa[i+4];
		       l2c5_ccx_sa[i+6] <= l2c5_ccx_sa[i+5];
			   l2c5_ccx_sa[i+7] <= l2c5_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c5_sa[0] <= ccx_l2c5_sa[1119] ^ ccx_l2c5_sa[1114] ^ ccx_l2c5_sa[1110] ^ ccx_l2c5_sa[1108] ^ eqed_ccx_l2c5[0];
		   end else begin
			   ccx_l2c5_sa[i] <= ccx_l2c5_sa[i-1] ^ eqed_ccx_l2c5[j]; 
		   end
		       ccx_l2c5_sa[i+1] <= ccx_l2c5_sa[i];
		       ccx_l2c5_sa[i+2] <= ccx_l2c5_sa[i+1];
	           ccx_l2c5_sa[i+3] <= ccx_l2c5_sa[i+2];
		       ccx_l2c5_sa[i+4] <= ccx_l2c5_sa[i+3];
		       ccx_l2c5_sa[i+5] <= ccx_l2c5_sa[i+4];
		       ccx_l2c5_sa[i+6] <= ccx_l2c5_sa[i+5];
			   ccx_l2c5_sa[i+7] <= ccx_l2c5_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c5_ccx_sa2 <= 1;
       ccx_l2c5_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c5_ccx_sa2[0] <= l2c5_ccx_sa2[1246] ^ l2c5_ccx_sa2[1243] ^ l2c5_ccx_sa2[1242] ^ l2c5_ccx_sa2[1241] ^ eqed_l2c5_ccx[0];
		   end else begin
			   l2c5_ccx_sa2[i] <= l2c5_ccx_sa2[i] ^ eqed_l2c5_ccx[j]; 
		   end
		       l2c5_ccx_sa2[i+1] <= l2c5_ccx_sa2[i];
		       l2c5_ccx_sa2[i+2] <= l2c5_ccx_sa2[i+1];
	           l2c5_ccx_sa2[i+3] <= l2c5_ccx_sa2[i+2];
		       l2c5_ccx_sa2[i+4] <= l2c5_ccx_sa2[i+3];
		       l2c5_ccx_sa2[i+5] <= l2c5_ccx_sa2[i+4];
		       l2c5_ccx_sa2[i+6] <= l2c5_ccx_sa2[i+5];
			   l2c5_ccx_sa2[i+7] <= l2c5_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c5_sa2[0] <= ccx_l2c5_sa2[1119] ^ ccx_l2c5_sa2[1114] ^ ccx_l2c5_sa2[1110] ^ ccx_l2c5_sa2[1108] ^ eqed_ccx_l2c5[0];
		   end else begin
			   ccx_l2c5_sa2[i] <= ccx_l2c5_sa2[i] ^ eqed_ccx_l2c5[j]; 
		   end
		       ccx_l2c5_sa2[i+1] <= ccx_l2c5_sa2[i];
		       ccx_l2c5_sa2[i+2] <= ccx_l2c5_sa2[i+1];
	           ccx_l2c5_sa2[i+3] <= ccx_l2c5_sa2[i+2];
		       ccx_l2c5_sa2[i+4] <= ccx_l2c5_sa2[i+3];
		       ccx_l2c5_sa2[i+5] <= ccx_l2c5_sa2[i+4];
		       ccx_l2c5_sa2[i+6] <= ccx_l2c5_sa2[i+5];
			   ccx_l2c5_sa2[i+7] <= ccx_l2c5_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c6_ccx_sa <= 1;
       ccx_l2c6_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c6_ccx_sa[0] <= l2c6_ccx_sa[1246] ^ l2c6_ccx_sa[1243] ^ l2c6_ccx_sa[1242] ^ l2c6_ccx_sa[1241] ^ eqed_l2c6_ccx[0];
		   end else begin
			   l2c6_ccx_sa[i] <= l2c6_ccx_sa[i-1] ^ eqed_l2c6_ccx[j]; 
		   end
		       l2c6_ccx_sa[i+1] <= l2c6_ccx_sa[i];
		       l2c6_ccx_sa[i+2] <= l2c6_ccx_sa[i+1];
	           l2c6_ccx_sa[i+3] <= l2c6_ccx_sa[i+2];
		       l2c6_ccx_sa[i+4] <= l2c6_ccx_sa[i+3];
		       l2c6_ccx_sa[i+5] <= l2c6_ccx_sa[i+4];
		       l2c6_ccx_sa[i+6] <= l2c6_ccx_sa[i+5];
			   l2c6_ccx_sa[i+7] <= l2c6_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c6_sa[0] <= ccx_l2c6_sa[1119] ^ ccx_l2c6_sa[1114] ^ ccx_l2c6_sa[1110] ^ ccx_l2c6_sa[1108] ^ eqed_ccx_l2c6[0];
		   end else begin
			   ccx_l2c6_sa[i] <= ccx_l2c6_sa[i-1] ^ eqed_ccx_l2c6[j]; 
		   end
		       ccx_l2c6_sa[i+1] <= ccx_l2c6_sa[i];
		       ccx_l2c6_sa[i+2] <= ccx_l2c6_sa[i+1];
	           ccx_l2c6_sa[i+3] <= ccx_l2c6_sa[i+2];
		       ccx_l2c6_sa[i+4] <= ccx_l2c6_sa[i+3];
		       ccx_l2c6_sa[i+5] <= ccx_l2c6_sa[i+4];
		       ccx_l2c6_sa[i+6] <= ccx_l2c6_sa[i+5];
			   ccx_l2c6_sa[i+7] <= ccx_l2c6_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c6_ccx_sa2 <= 1;
       ccx_l2c6_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c6_ccx_sa2[0] <= l2c6_ccx_sa2[1246] ^ l2c6_ccx_sa2[1243] ^ l2c6_ccx_sa2[1242] ^ l2c6_ccx_sa2[1241] ^ eqed_l2c6_ccx[0];
		   end else begin
			   l2c6_ccx_sa2[i] <= l2c6_ccx_sa2[i] ^ eqed_l2c6_ccx[j]; 
		   end
		       l2c6_ccx_sa2[i+1] <= l2c6_ccx_sa2[i];
		       l2c6_ccx_sa2[i+2] <= l2c6_ccx_sa2[i+1];
	           l2c6_ccx_sa2[i+3] <= l2c6_ccx_sa2[i+2];
		       l2c6_ccx_sa2[i+4] <= l2c6_ccx_sa2[i+3];
		       l2c6_ccx_sa2[i+5] <= l2c6_ccx_sa2[i+4];
		       l2c6_ccx_sa2[i+6] <= l2c6_ccx_sa2[i+5];
			   l2c6_ccx_sa2[i+7] <= l2c6_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c6_sa2[0] <= ccx_l2c6_sa2[1119] ^ ccx_l2c6_sa2[1114] ^ ccx_l2c6_sa2[1110] ^ ccx_l2c6_sa2[1108] ^ eqed_ccx_l2c6[0];
		   end else begin
			   ccx_l2c6_sa2[i] <= ccx_l2c6_sa2[i] ^ eqed_ccx_l2c6[j]; 
		   end
		       ccx_l2c6_sa2[i+1] <= ccx_l2c6_sa2[i];
		       ccx_l2c6_sa2[i+2] <= ccx_l2c6_sa2[i+1];
	           ccx_l2c6_sa2[i+3] <= ccx_l2c6_sa2[i+2];
		       ccx_l2c6_sa2[i+4] <= ccx_l2c6_sa2[i+3];
		       ccx_l2c6_sa2[i+5] <= ccx_l2c6_sa2[i+4];
		       ccx_l2c6_sa2[i+6] <= ccx_l2c6_sa2[i+5];
			   ccx_l2c6_sa2[i+7] <= ccx_l2c6_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c7_ccx_sa <= 1;
       ccx_l2c7_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c7_ccx_sa[0] <= l2c7_ccx_sa[1246] ^ l2c7_ccx_sa[1243] ^ l2c7_ccx_sa[1242] ^ l2c7_ccx_sa[1241] ^ eqed_l2c7_ccx[0];
		   end else begin
			   l2c7_ccx_sa[i] <= l2c7_ccx_sa[i-1] ^ eqed_l2c7_ccx[j]; 
		   end
		       l2c7_ccx_sa[i+1] <= l2c7_ccx_sa[i];
		       l2c7_ccx_sa[i+2] <= l2c7_ccx_sa[i+1];
	           l2c7_ccx_sa[i+3] <= l2c7_ccx_sa[i+2];
		       l2c7_ccx_sa[i+4] <= l2c7_ccx_sa[i+3];
		       l2c7_ccx_sa[i+5] <= l2c7_ccx_sa[i+4];
		       l2c7_ccx_sa[i+6] <= l2c7_ccx_sa[i+5];
			   l2c7_ccx_sa[i+7] <= l2c7_ccx_sa[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c7_sa[0] <= ccx_l2c7_sa[1119] ^ ccx_l2c7_sa[1114] ^ ccx_l2c7_sa[1110] ^ ccx_l2c7_sa[1108] ^ eqed_ccx_l2c7[0];
		   end else begin
			   ccx_l2c7_sa[i] <= ccx_l2c7_sa[i-1] ^ eqed_ccx_l2c7[j]; 
		   end
		       ccx_l2c7_sa[i+1] <= ccx_l2c7_sa[i];
		       ccx_l2c7_sa[i+2] <= ccx_l2c7_sa[i+1];
	           ccx_l2c7_sa[i+3] <= ccx_l2c7_sa[i+2];
		       ccx_l2c7_sa[i+4] <= ccx_l2c7_sa[i+3];
		       ccx_l2c7_sa[i+5] <= ccx_l2c7_sa[i+4];
		       ccx_l2c7_sa[i+6] <= ccx_l2c7_sa[i+5];
			   ccx_l2c7_sa[i+7] <= ccx_l2c7_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c7_ccx_sa2 <= 1;
       ccx_l2c7_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_CCX_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c7_ccx_sa2[0] <= l2c7_ccx_sa2[1246] ^ l2c7_ccx_sa2[1243] ^ l2c7_ccx_sa2[1242] ^ l2c7_ccx_sa2[1241] ^ eqed_l2c7_ccx[0];
		   end else begin
			   l2c7_ccx_sa2[i] <= l2c7_ccx_sa2[i] ^ eqed_l2c7_ccx[j]; 
		   end
		       l2c7_ccx_sa2[i+1] <= l2c7_ccx_sa2[i];
		       l2c7_ccx_sa2[i+2] <= l2c7_ccx_sa2[i+1];
	           l2c7_ccx_sa2[i+3] <= l2c7_ccx_sa2[i+2];
		       l2c7_ccx_sa2[i+4] <= l2c7_ccx_sa2[i+3];
		       l2c7_ccx_sa2[i+5] <= l2c7_ccx_sa2[i+4];
		       l2c7_ccx_sa2[i+6] <= l2c7_ccx_sa2[i+5];
			   l2c7_ccx_sa2[i+7] <= l2c7_ccx_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < CCX_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       ccx_l2c7_sa2[0] <= ccx_l2c7_sa2[1119] ^ ccx_l2c7_sa2[1114] ^ ccx_l2c7_sa2[1110] ^ ccx_l2c7_sa2[1108] ^ eqed_ccx_l2c7[0];
		   end else begin
			   ccx_l2c7_sa2[i] <= ccx_l2c7_sa2[i] ^ eqed_ccx_l2c7[j]; 
		   end
		       ccx_l2c7_sa2[i+1] <= ccx_l2c7_sa2[i];
		       ccx_l2c7_sa2[i+2] <= ccx_l2c7_sa2[i+1];
	           ccx_l2c7_sa2[i+3] <= ccx_l2c7_sa2[i+2];
		       ccx_l2c7_sa2[i+4] <= ccx_l2c7_sa2[i+3];
		       ccx_l2c7_sa2[i+5] <= ccx_l2c7_sa2[i+4];
		       ccx_l2c7_sa2[i+6] <= ccx_l2c7_sa2[i+5];
			   ccx_l2c7_sa2[i+7] <= ccx_l2c7_sa2[i+6];
       end
    end
end
*/

// L2C-L2D interface

wire [125:0] eqed_l2c0_l2d0;
wire [155:0] eqed_l2d0_l2c0;

assign eqed_l2c0_l2d0 = {l2t0_l2d0_way_sel_c2, l2t0_l2d0_rd_wr_c2, l2t0_l2d0_set_c2, l2t0_l2d0_col_offset_c2, 
                         l2t0_l2d0_word_en_c2, l2t0_l2d0_fbrd_c3, l2t0_l2d0_fb_hit_c3, l2t0_l2d0_stdecc_c2};
assign eqed_l2d0_l2c0 = {l2d0_l2t0_decc_c6};

parameter L2C_L2D_SB_SIZE = 1008;
parameter L2D_L2C_SB_SIZE = 1248;

// Declare the registers for the Signature Analyzer MISRs
reg [L2C_L2D_SB_SIZE:0] l2c0_l2d0_sa;
reg [L2D_L2C_SB_SIZE:0] l2d0_l2c0_sa;

reg [L2C_L2D_SB_SIZE:0] l2c0_l2d0_sa2;
reg [L2D_L2C_SB_SIZE:0] l2d0_l2c0_sa2;


always @(posedge clk) begin
    if (m_rst) begin
       l2c0_l2d0_sa <= 1;
       l2d0_l2c0_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_L2D_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c0_l2d0_sa[0] <= l2c0_l2d0_sa[1008] ^ l2c0_l2d0_sa[1006] ^ l2c0_l2d0_sa[1005] ^ l2c0_l2d0_sa[1001] ^ eqed_l2c0_l2d0[0];
		   end else begin
			   l2c0_l2d0_sa[i] <= l2c0_l2d0_sa[i-1] ^ eqed_l2c0_l2d0[j]; 
		   end
		       l2c0_l2d0_sa[i+1] <= l2c0_l2d0_sa[i];
		       l2c0_l2d0_sa[i+2] <= l2c0_l2d0_sa[i+1];
	           l2c0_l2d0_sa[i+3] <= l2c0_l2d0_sa[i+2];
		       l2c0_l2d0_sa[i+4] <= l2c0_l2d0_sa[i+3];
		       l2c0_l2d0_sa[i+5] <= l2c0_l2d0_sa[i+4];
		       l2c0_l2d0_sa[i+6] <= l2c0_l2d0_sa[i+5];
			   l2c0_l2d0_sa[i+7] <= l2c0_l2d0_sa[i+6];
       end
       for (int i = 0, int j = 0; i < L2D_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2d0_l2c0_sa[0] <= l2d0_l2c0_sa[1247] ^ l2d0_l2c0_sa[1244] ^ l2d0_l2c0_sa[1243] ^ l2d0_l2c0_sa[1240] ^ eqed_l2d0_l2c0[0];
		   end else begin
			   l2d0_l2c0_sa[i] <= l2d0_l2c0_sa[i-1] ^ eqed_l2d0_l2c0[j]; 
		   end
		       l2d0_l2c0_sa[i+1] <= l2d0_l2c0_sa[i];
		       l2d0_l2c0_sa[i+2] <= l2d0_l2c0_sa[i+1];
	           l2d0_l2c0_sa[i+3] <= l2d0_l2c0_sa[i+2];
		       l2d0_l2c0_sa[i+4] <= l2d0_l2c0_sa[i+3];
		       l2d0_l2c0_sa[i+5] <= l2d0_l2c0_sa[i+4];
		       l2d0_l2c0_sa[i+6] <= l2d0_l2c0_sa[i+5];
			   l2d0_l2c0_sa[i+7] <= l2d0_l2c0_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst2) begin
       l2c0_l2d0_sa2 <= 1;
       l2d0_l2c0_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_L2D_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c0_l2d0_sa2[0] <= l2c0_l2d0_sa2[1008] ^ l2c0_l2d0_sa2[1006] ^ l2c0_l2d0_sa2[1005] ^ l2c0_l2d0_sa2[1001] ^ eqed_l2c0_l2d0[0];
		   end else begin
			   l2c0_l2d0_sa2[i] <= l2c0_l2d0_sa2[i] ^ eqed_l2c0_l2d0[j]; 
		   end
		       l2c0_l2d0_sa2[i+1] <= l2c0_l2d0_sa2[i];
		       l2c0_l2d0_sa2[i+2] <= l2c0_l2d0_sa2[i+1];
	           l2c0_l2d0_sa2[i+3] <= l2c0_l2d0_sa2[i+2];
		       l2c0_l2d0_sa2[i+4] <= l2c0_l2d0_sa2[i+3];
		       l2c0_l2d0_sa2[i+5] <= l2c0_l2d0_sa2[i+4];
		       l2c0_l2d0_sa2[i+6] <= l2c0_l2d0_sa2[i+5];
			   l2c0_l2d0_sa2[i+7] <= l2c0_l2d0_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < L2D_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2d0_l2c0_sa2[0] <= l2d0_l2c0_sa2[1247] ^ l2d0_l2c0_sa2[1244] ^ l2d0_l2c0_sa2[1243] ^ l2d0_l2c0_sa2[1240] ^ eqed_l2d0_l2c0[0];
		   end else begin
			   l2d0_l2c0_sa2[i] <= l2d0_l2c0_sa2[i] ^ eqed_l2d0_l2c0[j]; 
		   end
		       l2d0_l2c0_sa2[i+1] <= l2d0_l2c0_sa2[i];
		       l2d0_l2c0_sa2[i+2] <= l2d0_l2c0_sa2[i+1];
	           l2d0_l2c0_sa2[i+3] <= l2d0_l2c0_sa2[i+2];
		       l2d0_l2c0_sa2[i+4] <= l2d0_l2c0_sa2[i+3];
		       l2d0_l2c0_sa2[i+5] <= l2d0_l2c0_sa2[i+4];
		       l2d0_l2c0_sa2[i+6] <= l2d0_l2c0_sa2[i+5];
			   l2d0_l2c0_sa2[i+7] <= l2d0_l2c0_sa2[i+6];
       end
    end
end


// L2C-MCU interface
wire [67:0] eqed_l2c0_mcu0;
wire [70:0] eqed_mcu0_l2c0;
wire [67:0] eqed_l2c1_mcu0;
wire [70:0] eqed_mcu0_l2c1;
wire [67:0] eqed_l2c2_mcu1;
wire [70:0] eqed_mcu1_l2c2;
wire [67:0] eqed_l2c3_mcu1;
wire [70:0] eqed_mcu1_l2c3;
wire [67:0] eqed_l2c4_mcu2;
wire [70:0] eqed_mcu2_l2c4;
wire [67:0] eqed_l2c5_mcu2;
wire [70:0] eqed_mcu2_l2c5;
wire [67:0] eqed_l2c6_mcu3;
wire [70:0] eqed_mcu3_l2c6;
wire [67:0] eqed_l2c7_mcu3;
wire [70:0] eqed_mcu3_l2c7;


assign eqed_l2c0_mcu0 = {l2b0_mcu0_wr_data_r5, l2b0_mcu0_data_vld_r5, l2b0_mcu0_data_mecc_r5, l2t0_mcu0_rd_req, l2t0_mcu0_wr_req};
assign eqed_mcu0_l2c0 = {mcu0_l2b01_data_r2, mcu0_l2b01_ecc_r2, mcu0_l2t0_rd_ack, mcu0_l2t0_wr_ack, mcu0_l2t0_data_vld_r0, mcu0_l2t0_rd_req_id_r0};
assign eqed_l2c1_mcu0 = {l2b1_mcu0_wr_data_r5, l2b1_mcu0_data_vld_r5, l2b1_mcu0_data_mecc_r5, l2t1_mcu0_rd_req, l2t1_mcu0_wr_req};
assign eqed_mcu0_l2c1 = {mcu0_l2b01_data_r2, mcu0_l2b01_ecc_r2, mcu0_l2t1_rd_ack, mcu0_l2t1_wr_ack, mcu0_l2t1_data_vld_r0, mcu0_l2t1_rd_req_id_r0};
assign eqed_l2c2_mcu1 = {l2b2_mcu1_wr_data_r5, l2b2_mcu1_data_vld_r5, l2b2_mcu1_data_mecc_r5, l2t2_mcu1_rd_req, l2t2_mcu1_wr_req};
assign eqed_mcu1_l2c2 = {mcu1_l2b23_data_r2, mcu1_l2b23_ecc_r2, mcu1_l2t2_rd_ack, mcu1_l2t2_wr_ack, mcu1_l2t2_data_vld_r0, mcu1_l2t2_rd_req_id_r0};
assign eqed_l2c3_mcu1 = {l2b3_mcu1_wr_data_r5, l2b3_mcu1_data_vld_r5, l2b3_mcu1_data_mecc_r5, l2t3_mcu1_rd_req, l2t3_mcu1_wr_req};
assign eqed_mcu1_l2c3 = {mcu1_l2b23_data_r2, mcu1_l2b23_ecc_r2, mcu1_l2t3_rd_ack, mcu1_l2t3_wr_ack, mcu1_l2t3_data_vld_r0, mcu1_l2t3_rd_req_id_r0};
assign eqed_l2c4_mcu2 = {l2b4_mcu2_wr_data_r5, l2b4_mcu2_data_vld_r5, l2b4_mcu2_data_mecc_r5, l2t4_mcu2_rd_req, l2t4_mcu2_wr_req};
assign eqed_mcu2_l2c4 = {mcu2_l2b45_data_r2, mcu2_l2b45_ecc_r2, mcu2_l2t4_rd_ack, mcu2_l2t4_wr_ack, mcu2_l2t4_data_vld_r0, mcu2_l2t4_rd_req_id_r0};
assign eqed_l2c5_mcu2 = {l2b5_mcu2_wr_data_r5, l2b5_mcu2_data_vld_r5, l2b5_mcu2_data_mecc_r5, l2t5_mcu2_rd_req, l2t5_mcu2_wr_req};
assign eqed_mcu2_l2c5 = {mcu2_l2b45_data_r2, mcu2_l2b45_ecc_r2, mcu2_l2t5_rd_ack, mcu2_l2t5_wr_ack, mcu2_l2t5_data_vld_r0, mcu2_l2t5_rd_req_id_r0};
assign eqed_l2c6_mcu3 = {l2b6_mcu3_wr_data_r5, l2b6_mcu3_data_vld_r5, l2b6_mcu3_data_mecc_r5, l2t6_mcu3_rd_req, l2t6_mcu3_wr_req};
assign eqed_mcu3_l2c6 = {mcu3_l2b67_data_r2, mcu3_l2b67_ecc_r2, mcu3_l2t6_rd_ack, mcu3_l2t6_wr_ack, mcu3_l2t6_data_vld_r0, mcu3_l2t6_rd_req_id_r0};
assign eqed_l2c7_mcu3 = {l2b7_mcu3_wr_data_r5, l2b7_mcu3_data_vld_r5, l2b7_mcu3_data_mecc_r5, l2t7_mcu3_rd_req, l2t7_mcu3_wr_req};
assign eqed_mcu3_l2c7 = {mcu3_l2b67_data_r2, mcu3_l2b67_ecc_r2, mcu3_l2t7_rd_ack, mcu3_l2t7_wr_ack, mcu3_l2t7_data_vld_r0, mcu3_l2t7_rd_req_id_r0};


parameter L2C_MCU_B = 68;
parameter MCU_L2C_B = 71;

parameter L2C_MCU_SB_SIZE = 544;
parameter MCU_L2C_SB_SIZE = 568;

// Declare the registers for the Signature Analyzer MISRs
reg [L2C_MCU_SB_SIZE:0] l2c0_mcu0_sa;
reg [MCU_L2C_SB_SIZE:0] mcu0_l2c0_sa;
/*
reg [L2C_MCU_SB_SIZE:0] l2c1_mcu0_sa;
reg [MCU_L2C_SB_SIZE:0] mcu0_l2c1_sa;
reg [L2C_MCU_SB_SIZE:0] l2c2_mcu1_sa;
reg [MCU_L2C_SB_SIZE:0] mcu1_l2c2_sa;
reg [L2C_MCU_SB_SIZE:0] l2c3_mcu1_sa;
reg [MCU_L2C_SB_SIZE:0] mcu1_l2c3_sa;
reg [L2C_MCU_SB_SIZE:0] l2c4_mcu2_sa;
reg [MCU_L2C_SB_SIZE:0] mcu2_l2c4_sa;
reg [L2C_MCU_SB_SIZE:0] l2c5_mcu2_sa;
reg [MCU_L2C_SB_SIZE:0] mcu2_l2c5_sa;
reg [L2C_MCU_SB_SIZE:0] l2c6_mcu3_sa;
reg [MCU_L2C_SB_SIZE:0] mcu3_l2c6_sa;
reg [L2C_MCU_SB_SIZE:0] l2c7_mcu3_sa;
reg [MCU_L2C_SB_SIZE:0] mcu3_l2c7_sa;
*/
// Declare the registers for the Signature Analyzer MISRs
reg [L2C_MCU_SB_SIZE:0] l2c0_mcu0_sa2;
reg [MCU_L2C_SB_SIZE:0] mcu0_l2c0_sa2;
/*
reg [L2C_MCU_SB_SIZE:0] l2c1_mcu0_sa2;
reg [MCU_L2C_SB_SIZE:0] mcu0_l2c1_sa2;
reg [L2C_MCU_SB_SIZE:0] l2c2_mcu1_sa2;
reg [MCU_L2C_SB_SIZE:0] mcu1_l2c2_sa2;
reg [L2C_MCU_SB_SIZE:0] l2c3_mcu1_sa2;
reg [MCU_L2C_SB_SIZE:0] mcu1_l2c3_sa2;
reg [L2C_MCU_SB_SIZE:0] l2c4_mcu2_sa2;
reg [MCU_L2C_SB_SIZE:0] mcu2_l2c4_sa2;
reg [L2C_MCU_SB_SIZE:0] l2c5_mcu2_sa2;
reg [MCU_L2C_SB_SIZE:0] mcu2_l2c5_sa2;
reg [L2C_MCU_SB_SIZE:0] l2c6_mcu3_sa2;
reg [MCU_L2C_SB_SIZE:0] mcu3_l2c6_sa2;
reg [L2C_MCU_SB_SIZE:0] l2c7_mcu3_sa2;
reg [MCU_L2C_SB_SIZE:0] mcu3_l2c7_sa2;
*/
always @(posedge clk) begin
    if (m_rst) begin
       l2c0_mcu0_sa <= 1;
       mcu0_l2c0_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c0_mcu0_sa[0] <= l2c0_mcu0_sa[543] ^ l2c0_mcu0_sa[541] ^ l2c0_mcu0_sa[538] ^ l2c0_mcu0_sa[537] ^ eqed_l2c0_mcu0[0];
		   end else begin
			   l2c0_mcu0_sa[i] <= l2c0_mcu0_sa[i-1] ^ eqed_l2c0_mcu0[j]; 
		   end
		       l2c0_mcu0_sa[i+1] <= l2c0_mcu0_sa[i];
		       l2c0_mcu0_sa[i+2] <= l2c0_mcu0_sa[i+1];
	           l2c0_mcu0_sa[i+3] <= l2c0_mcu0_sa[i+2];
		       l2c0_mcu0_sa[i+4] <= l2c0_mcu0_sa[i+3];
		       l2c0_mcu0_sa[i+5] <= l2c0_mcu0_sa[i+4];
		       l2c0_mcu0_sa[i+6] <= l2c0_mcu0_sa[i+5];
			   l2c0_mcu0_sa[i+7] <= l2c0_mcu0_sa[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu0_l2c0_sa[0] <= mcu0_l2c0_sa[567] ^ mcu0_l2c0_sa[565] ^ mcu0_l2c0_sa[561] ^ mcu0_l2c0_sa[537] ^ eqed_mcu0_l2c0[0];
		   end else begin
			   mcu0_l2c0_sa[i] <= mcu0_l2c0_sa[i-1] ^ eqed_mcu0_l2c0[j]; 
		   end
		       mcu0_l2c0_sa[i+1] <= mcu0_l2c0_sa[i];
		       mcu0_l2c0_sa[i+2] <= mcu0_l2c0_sa[i+1];
	           mcu0_l2c0_sa[i+3] <= mcu0_l2c0_sa[i+2];
		       mcu0_l2c0_sa[i+4] <= mcu0_l2c0_sa[i+3];
		       mcu0_l2c0_sa[i+5] <= mcu0_l2c0_sa[i+4];
		       mcu0_l2c0_sa[i+6] <= mcu0_l2c0_sa[i+5];
			   mcu0_l2c0_sa[i+7] <= mcu0_l2c0_sa[i+6];
       end
    end
end

/*

always @(posedge clk) begin
    if (m_rst) begin
       l2c0_mcu0_sa2 <= 1;
       mcu0_l2c0_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c0_mcu0_sa2[0] <= l2c0_mcu0_sa2[543] ^ l2c0_mcu0_sa2[541] ^ l2c0_mcu0_sa2[538] ^ l2c0_mcu0_sa2[537] ^ eqed_l2c0_mcu0[0];
		   end else begin
			   l2c0_mcu0_sa2[i] <= l2c0_mcu0_sa2[i] ^ eqed_l2c0_mcu0[j]; 
		   end
		       l2c0_mcu0_sa2[i+1] <= l2c0_mcu0_sa2[i];
		       l2c0_mcu0_sa2[i+2] <= l2c0_mcu0_sa2[i+1];
	           l2c0_mcu0_sa2[i+3] <= l2c0_mcu0_sa2[i+2];
		       l2c0_mcu0_sa2[i+4] <= l2c0_mcu0_sa2[i+3];
		       l2c0_mcu0_sa2[i+5] <= l2c0_mcu0_sa2[i+4];
		       l2c0_mcu0_sa2[i+6] <= l2c0_mcu0_sa2[i+5];
			   l2c0_mcu0_sa2[i+7] <= l2c0_mcu0_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu0_l2c0_sa2[0] <= mcu0_l2c0_sa2[567] ^ mcu0_l2c0_sa2[565] ^ mcu0_l2c0_sa2[561] ^ mcu0_l2c0_sa2[537] ^ eqed_mcu0_l2c0[0];
		   end else begin
			   mcu0_l2c0_sa2[i] <= mcu0_l2c0_sa2[i] ^ eqed_mcu0_l2c0[j]; 
		   end
		       mcu0_l2c0_sa2[i+1] <= mcu0_l2c0_sa2[i];
		       mcu0_l2c0_sa2[i+2] <= mcu0_l2c0_sa2[i+1];
	           mcu0_l2c0_sa2[i+3] <= mcu0_l2c0_sa2[i+2];
		       mcu0_l2c0_sa2[i+4] <= mcu0_l2c0_sa2[i+3];
		       mcu0_l2c0_sa2[i+5] <= mcu0_l2c0_sa2[i+4];
		       mcu0_l2c0_sa2[i+6] <= mcu0_l2c0_sa2[i+5];
			   mcu0_l2c0_sa2[i+7] <= mcu0_l2c0_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c1_mcu0_sa <= 1;
       mcu0_l2c1_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c1_mcu0_sa[0] <= l2c1_mcu0_sa[543] ^ l2c1_mcu0_sa[541] ^ l2c1_mcu0_sa[538] ^ l2c1_mcu0_sa[537] ^ eqed_l2c1_mcu0[0];
		   end else begin
			   l2c1_mcu0_sa[i] <= l2c1_mcu0_sa[i-1] ^ eqed_l2c1_mcu0[j]; 
		   end
		       l2c1_mcu0_sa[i+1] <= l2c1_mcu0_sa[i];
		       l2c1_mcu0_sa[i+2] <= l2c1_mcu0_sa[i+1];
	           l2c1_mcu0_sa[i+3] <= l2c1_mcu0_sa[i+2];
		       l2c1_mcu0_sa[i+4] <= l2c1_mcu0_sa[i+3];
		       l2c1_mcu0_sa[i+5] <= l2c1_mcu0_sa[i+4];
		       l2c1_mcu0_sa[i+6] <= l2c1_mcu0_sa[i+5];
			   l2c1_mcu0_sa[i+7] <= l2c1_mcu0_sa[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu0_l2c1_sa[0] <= mcu0_l2c1_sa[567] ^ mcu0_l2c1_sa[565] ^ mcu0_l2c1_sa[561] ^ mcu0_l2c1_sa[537] ^ eqed_mcu0_l2c1[0];
		   end else begin
			   mcu0_l2c1_sa[i] <= mcu0_l2c1_sa[i-1] ^ eqed_mcu0_l2c1[j]; 
		   end
		       mcu0_l2c1_sa[i+1] <= mcu0_l2c1_sa[i];
		       mcu0_l2c1_sa[i+2] <= mcu0_l2c1_sa[i+1];
	           mcu0_l2c1_sa[i+3] <= mcu0_l2c1_sa[i+2];
		       mcu0_l2c1_sa[i+4] <= mcu0_l2c1_sa[i+3];
		       mcu0_l2c1_sa[i+5] <= mcu0_l2c1_sa[i+4];
		       mcu0_l2c1_sa[i+6] <= mcu0_l2c1_sa[i+5];
			   mcu0_l2c1_sa[i+7] <= mcu0_l2c1_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c1_mcu0_sa2 <= 1;
       mcu0_l2c1_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c1_mcu0_sa2[0] <= l2c1_mcu0_sa2[543] ^ l2c1_mcu0_sa2[541] ^ l2c1_mcu0_sa2[538] ^ l2c1_mcu0_sa2[537] ^ eqed_l2c1_mcu0[0];
		   end else begin
			   l2c1_mcu0_sa2[i] <= l2c1_mcu0_sa2[i] ^ eqed_l2c1_mcu0[j]; 
		   end
		       l2c1_mcu0_sa2[i+1] <= l2c1_mcu0_sa2[i];
		       l2c1_mcu0_sa2[i+2] <= l2c1_mcu0_sa2[i+1];
	           l2c1_mcu0_sa2[i+3] <= l2c1_mcu0_sa2[i+2];
		       l2c1_mcu0_sa2[i+4] <= l2c1_mcu0_sa2[i+3];
		       l2c1_mcu0_sa2[i+5] <= l2c1_mcu0_sa2[i+4];
		       l2c1_mcu0_sa2[i+6] <= l2c1_mcu0_sa2[i+5];
			   l2c1_mcu0_sa2[i+7] <= l2c1_mcu0_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu0_l2c1_sa2[0] <= mcu0_l2c1_sa2[567] ^ mcu0_l2c1_sa2[565] ^ mcu0_l2c1_sa2[561] ^ mcu0_l2c1_sa2[537] ^ eqed_mcu0_l2c1[0];
		   end else begin
			   mcu0_l2c1_sa2[i] <= mcu0_l2c1_sa2[i] ^ eqed_mcu0_l2c1[j]; 
		   end
		       mcu0_l2c1_sa2[i+1] <= mcu0_l2c1_sa2[i];
		       mcu0_l2c1_sa2[i+2] <= mcu0_l2c1_sa2[i+1];
	           mcu0_l2c1_sa2[i+3] <= mcu0_l2c1_sa2[i+2];
		       mcu0_l2c1_sa2[i+4] <= mcu0_l2c1_sa2[i+3];
		       mcu0_l2c1_sa2[i+5] <= mcu0_l2c1_sa2[i+4];
		       mcu0_l2c1_sa2[i+6] <= mcu0_l2c1_sa2[i+5];
			   mcu0_l2c1_sa2[i+7] <= mcu0_l2c1_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c2_mcu1_sa <= 1;
       mcu1_l2c2_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c2_mcu1_sa[0] <= l2c2_mcu1_sa[543] ^ l2c2_mcu1_sa[541] ^ l2c2_mcu1_sa[538] ^ l2c2_mcu1_sa[537] ^ eqed_l2c2_mcu1[0];
		   end else begin
			   l2c2_mcu1_sa[i] <= l2c2_mcu1_sa[i-1] ^ eqed_l2c2_mcu1[j]; 
		   end
		       l2c2_mcu1_sa[i+1] <= l2c2_mcu1_sa[i];
		       l2c2_mcu1_sa[i+2] <= l2c2_mcu1_sa[i+1];
	           l2c2_mcu1_sa[i+3] <= l2c2_mcu1_sa[i+2];
		       l2c2_mcu1_sa[i+4] <= l2c2_mcu1_sa[i+3];
		       l2c2_mcu1_sa[i+5] <= l2c2_mcu1_sa[i+4];
		       l2c2_mcu1_sa[i+6] <= l2c2_mcu1_sa[i+5];
			   l2c2_mcu1_sa[i+7] <= l2c2_mcu1_sa[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu1_l2c2_sa[0] <= mcu1_l2c2_sa[567] ^ mcu1_l2c2_sa[565] ^ mcu1_l2c2_sa[561] ^ mcu1_l2c2_sa[537] ^ eqed_mcu1_l2c2[0];
		   end else begin
			   mcu1_l2c2_sa[i] <= mcu1_l2c2_sa[i-1] ^ eqed_mcu1_l2c2[j]; 
		   end
		       mcu1_l2c2_sa[i+1] <= mcu1_l2c2_sa[i];
		       mcu1_l2c2_sa[i+2] <= mcu1_l2c2_sa[i+1];
	           mcu1_l2c2_sa[i+3] <= mcu1_l2c2_sa[i+2];
		       mcu1_l2c2_sa[i+4] <= mcu1_l2c2_sa[i+3];
		       mcu1_l2c2_sa[i+5] <= mcu1_l2c2_sa[i+4];
		       mcu1_l2c2_sa[i+6] <= mcu1_l2c2_sa[i+5];
			   mcu1_l2c2_sa[i+7] <= mcu1_l2c2_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c2_mcu1_sa2 <= 1;
       mcu1_l2c2_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c2_mcu1_sa2[0] <= l2c2_mcu1_sa2[543] ^ l2c2_mcu1_sa2[541] ^ l2c2_mcu1_sa2[538] ^ l2c2_mcu1_sa2[537] ^ eqed_l2c2_mcu1[0];
		   end else begin
			   l2c2_mcu1_sa2[i] <= l2c2_mcu1_sa2[i] ^ eqed_l2c2_mcu1[j]; 
		   end
		       l2c2_mcu1_sa2[i+1] <= l2c2_mcu1_sa2[i];
		       l2c2_mcu1_sa2[i+2] <= l2c2_mcu1_sa2[i+1];
	           l2c2_mcu1_sa2[i+3] <= l2c2_mcu1_sa2[i+2];
		       l2c2_mcu1_sa2[i+4] <= l2c2_mcu1_sa2[i+3];
		       l2c2_mcu1_sa2[i+5] <= l2c2_mcu1_sa2[i+4];
		       l2c2_mcu1_sa2[i+6] <= l2c2_mcu1_sa2[i+5];
			   l2c2_mcu1_sa2[i+7] <= l2c2_mcu1_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu1_l2c2_sa2[0] <= mcu1_l2c2_sa2[567] ^ mcu1_l2c2_sa2[565] ^ mcu1_l2c2_sa2[561] ^ mcu1_l2c2_sa2[537] ^ eqed_mcu1_l2c2[0];
		   end else begin
			   mcu1_l2c2_sa2[i] <= mcu1_l2c2_sa2[i] ^ eqed_mcu1_l2c2[j]; 
		   end
		       mcu1_l2c2_sa2[i+1] <= mcu1_l2c2_sa2[i];
		       mcu1_l2c2_sa2[i+2] <= mcu1_l2c2_sa2[i+1];
	           mcu1_l2c2_sa2[i+3] <= mcu1_l2c2_sa2[i+2];
		       mcu1_l2c2_sa2[i+4] <= mcu1_l2c2_sa2[i+3];
		       mcu1_l2c2_sa2[i+5] <= mcu1_l2c2_sa2[i+4];
		       mcu1_l2c2_sa2[i+6] <= mcu1_l2c2_sa2[i+5];
			   mcu1_l2c2_sa2[i+7] <= mcu1_l2c2_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c3_mcu1_sa <= 1;
       mcu1_l2c3_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c3_mcu1_sa[0] <= l2c3_mcu1_sa[543] ^ l2c3_mcu1_sa[541] ^ l2c3_mcu1_sa[538] ^ l2c3_mcu1_sa[537] ^ eqed_l2c3_mcu1[0];
		   end else begin
			   l2c3_mcu1_sa[i] <= l2c3_mcu1_sa[i-1] ^ eqed_l2c3_mcu1[j]; 
		   end
		       l2c3_mcu1_sa[i+1] <= l2c3_mcu1_sa[i];
		       l2c3_mcu1_sa[i+2] <= l2c3_mcu1_sa[i+1];
	           l2c3_mcu1_sa[i+3] <= l2c3_mcu1_sa[i+2];
		       l2c3_mcu1_sa[i+4] <= l2c3_mcu1_sa[i+3];
		       l2c3_mcu1_sa[i+5] <= l2c3_mcu1_sa[i+4];
		       l2c3_mcu1_sa[i+6] <= l2c3_mcu1_sa[i+5];
			   l2c3_mcu1_sa[i+7] <= l2c3_mcu1_sa[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu1_l2c3_sa[0] <= mcu1_l2c3_sa[567] ^ mcu1_l2c3_sa[565] ^ mcu1_l2c3_sa[561] ^ mcu1_l2c3_sa[537] ^ eqed_mcu1_l2c3[0];
		   end else begin
			   mcu1_l2c3_sa[i] <= mcu1_l2c3_sa[i-1] ^ eqed_mcu1_l2c3[j]; 
		   end
		       mcu1_l2c3_sa[i+1] <= mcu1_l2c3_sa[i];
		       mcu1_l2c3_sa[i+2] <= mcu1_l2c3_sa[i+1];
	           mcu1_l2c3_sa[i+3] <= mcu1_l2c3_sa[i+2];
		       mcu1_l2c3_sa[i+4] <= mcu1_l2c3_sa[i+3];
		       mcu1_l2c3_sa[i+5] <= mcu1_l2c3_sa[i+4];
		       mcu1_l2c3_sa[i+6] <= mcu1_l2c3_sa[i+5];
			   mcu1_l2c3_sa[i+7] <= mcu1_l2c3_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c3_mcu1_sa2 <= 1;
       mcu1_l2c3_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c3_mcu1_sa2[0] <= l2c3_mcu1_sa2[543] ^ l2c3_mcu1_sa2[541] ^ l2c3_mcu1_sa2[538] ^ l2c3_mcu1_sa2[537] ^ eqed_l2c3_mcu1[0];
		   end else begin
			   l2c3_mcu1_sa2[i] <= l2c3_mcu1_sa2[i] ^ eqed_l2c3_mcu1[j]; 
		   end
		       l2c3_mcu1_sa2[i+1] <= l2c3_mcu1_sa2[i];
		       l2c3_mcu1_sa2[i+2] <= l2c3_mcu1_sa2[i+1];
	           l2c3_mcu1_sa2[i+3] <= l2c3_mcu1_sa2[i+2];
		       l2c3_mcu1_sa2[i+4] <= l2c3_mcu1_sa2[i+3];
		       l2c3_mcu1_sa2[i+5] <= l2c3_mcu1_sa2[i+4];
		       l2c3_mcu1_sa2[i+6] <= l2c3_mcu1_sa2[i+5];
			   l2c3_mcu1_sa2[i+7] <= l2c3_mcu1_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu1_l2c3_sa2[0] <= mcu1_l2c3_sa2[567] ^ mcu1_l2c3_sa2[565] ^ mcu1_l2c3_sa2[561] ^ mcu1_l2c3_sa2[537] ^ eqed_mcu1_l2c3[0];
		   end else begin
			   mcu1_l2c3_sa2[i] <= mcu1_l2c3_sa2[i] ^ eqed_mcu1_l2c3[j]; 
		   end
		       mcu1_l2c3_sa2[i+1] <= mcu1_l2c3_sa2[i];
		       mcu1_l2c3_sa2[i+2] <= mcu1_l2c3_sa2[i+1];
	           mcu1_l2c3_sa2[i+3] <= mcu1_l2c3_sa2[i+2];
		       mcu1_l2c3_sa2[i+4] <= mcu1_l2c3_sa2[i+3];
		       mcu1_l2c3_sa2[i+5] <= mcu1_l2c3_sa2[i+4];
		       mcu1_l2c3_sa2[i+6] <= mcu1_l2c3_sa2[i+5];
			   mcu1_l2c3_sa2[i+7] <= mcu1_l2c3_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c4_mcu2_sa <= 1;
       mcu2_l2c4_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c4_mcu2_sa[0] <= l2c4_mcu2_sa[543] ^ l2c4_mcu2_sa[541] ^ l2c4_mcu2_sa[538] ^ l2c4_mcu2_sa[537] ^ eqed_l2c4_mcu2[0];
		   end else begin
			   l2c4_mcu2_sa[i] <= l2c4_mcu2_sa[i-1] ^ eqed_l2c4_mcu2[j]; 
		   end
		       l2c4_mcu2_sa[i+1] <= l2c4_mcu2_sa[i];
		       l2c4_mcu2_sa[i+2] <= l2c4_mcu2_sa[i+1];
	           l2c4_mcu2_sa[i+3] <= l2c4_mcu2_sa[i+2];
		       l2c4_mcu2_sa[i+4] <= l2c4_mcu2_sa[i+3];
		       l2c4_mcu2_sa[i+5] <= l2c4_mcu2_sa[i+4];
		       l2c4_mcu2_sa[i+6] <= l2c4_mcu2_sa[i+5];
			   l2c4_mcu2_sa[i+7] <= l2c4_mcu2_sa[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu2_l2c4_sa[0] <= mcu2_l2c4_sa[567] ^ mcu2_l2c4_sa[565] ^ mcu2_l2c4_sa[561] ^ mcu2_l2c4_sa[537] ^ eqed_mcu2_l2c4[0];
		   end else begin
			   mcu2_l2c4_sa[i] <= mcu2_l2c4_sa[i-1] ^ eqed_mcu2_l2c4[j]; 
		   end
		       mcu2_l2c4_sa[i+1] <= mcu2_l2c4_sa[i];
		       mcu2_l2c4_sa[i+2] <= mcu2_l2c4_sa[i+1];
	           mcu2_l2c4_sa[i+3] <= mcu2_l2c4_sa[i+2];
		       mcu2_l2c4_sa[i+4] <= mcu2_l2c4_sa[i+3];
		       mcu2_l2c4_sa[i+5] <= mcu2_l2c4_sa[i+4];
		       mcu2_l2c4_sa[i+6] <= mcu2_l2c4_sa[i+5];
			   mcu2_l2c4_sa[i+7] <= mcu2_l2c4_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c4_mcu2_sa2 <= 1;
       mcu2_l2c4_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c4_mcu2_sa2[0] <= l2c4_mcu2_sa2[543] ^ l2c4_mcu2_sa2[541] ^ l2c4_mcu2_sa2[538] ^ l2c4_mcu2_sa2[537] ^ eqed_l2c4_mcu2[0];
		   end else begin
			   l2c4_mcu2_sa2[i] <= l2c4_mcu2_sa2[i] ^ eqed_l2c4_mcu2[j]; 
		   end
		       l2c4_mcu2_sa2[i+1] <= l2c4_mcu2_sa2[i];
		       l2c4_mcu2_sa2[i+2] <= l2c4_mcu2_sa2[i+1];
	           l2c4_mcu2_sa2[i+3] <= l2c4_mcu2_sa2[i+2];
		       l2c4_mcu2_sa2[i+4] <= l2c4_mcu2_sa2[i+3];
		       l2c4_mcu2_sa2[i+5] <= l2c4_mcu2_sa2[i+4];
		       l2c4_mcu2_sa2[i+6] <= l2c4_mcu2_sa2[i+5];
			   l2c4_mcu2_sa2[i+7] <= l2c4_mcu2_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu2_l2c4_sa2[0] <= mcu2_l2c4_sa2[567] ^ mcu2_l2c4_sa2[565] ^ mcu2_l2c4_sa2[561] ^ mcu2_l2c4_sa2[537] ^ eqed_mcu2_l2c4[0];
		   end else begin
			   mcu2_l2c4_sa2[i] <= mcu2_l2c4_sa2[i] ^ eqed_mcu2_l2c4[j]; 
		   end
		       mcu2_l2c4_sa2[i+1] <= mcu2_l2c4_sa2[i];
		       mcu2_l2c4_sa2[i+2] <= mcu2_l2c4_sa2[i+1];
	           mcu2_l2c4_sa2[i+3] <= mcu2_l2c4_sa2[i+2];
		       mcu2_l2c4_sa2[i+4] <= mcu2_l2c4_sa2[i+3];
		       mcu2_l2c4_sa2[i+5] <= mcu2_l2c4_sa2[i+4];
		       mcu2_l2c4_sa2[i+6] <= mcu2_l2c4_sa2[i+5];
			   mcu2_l2c4_sa2[i+7] <= mcu2_l2c4_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c5_mcu2_sa <= 1;
       mcu2_l2c5_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c5_mcu2_sa[0] <= l2c5_mcu2_sa[543] ^ l2c5_mcu2_sa[541] ^ l2c5_mcu2_sa[538] ^ l2c5_mcu2_sa[537] ^ eqed_l2c5_mcu2[0];
		   end else begin
			   l2c5_mcu2_sa[i] <= l2c5_mcu2_sa[i-1] ^ eqed_l2c5_mcu2[j]; 
		   end
		       l2c5_mcu2_sa[i+1] <= l2c5_mcu2_sa[i];
		       l2c5_mcu2_sa[i+2] <= l2c5_mcu2_sa[i+1];
	           l2c5_mcu2_sa[i+3] <= l2c5_mcu2_sa[i+2];
		       l2c5_mcu2_sa[i+4] <= l2c5_mcu2_sa[i+3];
		       l2c5_mcu2_sa[i+5] <= l2c5_mcu2_sa[i+4];
		       l2c5_mcu2_sa[i+6] <= l2c5_mcu2_sa[i+5];
			   l2c5_mcu2_sa[i+7] <= l2c5_mcu2_sa[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu2_l2c5_sa[0] <= mcu2_l2c5_sa[567] ^ mcu2_l2c5_sa[565] ^ mcu2_l2c5_sa[561] ^ mcu2_l2c5_sa[537] ^ eqed_mcu2_l2c5[0];
		   end else begin
			   mcu2_l2c5_sa[i] <= mcu2_l2c5_sa[i-1] ^ eqed_mcu2_l2c5[j]; 
		   end
		       mcu2_l2c5_sa[i+1] <= mcu2_l2c5_sa[i];
		       mcu2_l2c5_sa[i+2] <= mcu2_l2c5_sa[i+1];
	           mcu2_l2c5_sa[i+3] <= mcu2_l2c5_sa[i+2];
		       mcu2_l2c5_sa[i+4] <= mcu2_l2c5_sa[i+3];
		       mcu2_l2c5_sa[i+5] <= mcu2_l2c5_sa[i+4];
		       mcu2_l2c5_sa[i+6] <= mcu2_l2c5_sa[i+5];
			   mcu2_l2c5_sa[i+7] <= mcu2_l2c5_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c5_mcu2_sa2 <= 1;
       mcu2_l2c5_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c5_mcu2_sa2[0] <= l2c5_mcu2_sa2[543] ^ l2c5_mcu2_sa2[541] ^ l2c5_mcu2_sa2[538] ^ l2c5_mcu2_sa2[537] ^ eqed_l2c5_mcu2[0];
		   end else begin
			   l2c5_mcu2_sa2[i] <= l2c5_mcu2_sa2[i] ^ eqed_l2c5_mcu2[j]; 
		   end
		       l2c5_mcu2_sa2[i+1] <= l2c5_mcu2_sa2[i];
		       l2c5_mcu2_sa2[i+2] <= l2c5_mcu2_sa2[i+1];
	           l2c5_mcu2_sa2[i+3] <= l2c5_mcu2_sa2[i+2];
		       l2c5_mcu2_sa2[i+4] <= l2c5_mcu2_sa2[i+3];
		       l2c5_mcu2_sa2[i+5] <= l2c5_mcu2_sa2[i+4];
		       l2c5_mcu2_sa2[i+6] <= l2c5_mcu2_sa2[i+5];
			   l2c5_mcu2_sa2[i+7] <= l2c5_mcu2_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu2_l2c5_sa2[0] <= mcu2_l2c5_sa2[567] ^ mcu2_l2c5_sa2[565] ^ mcu2_l2c5_sa2[561] ^ mcu2_l2c5_sa2[537] ^ eqed_mcu2_l2c5[0];
		   end else begin
			   mcu2_l2c5_sa2[i] <= mcu2_l2c5_sa2[i] ^ eqed_mcu2_l2c5[j]; 
		   end
		       mcu2_l2c5_sa2[i+1] <= mcu2_l2c5_sa2[i];
		       mcu2_l2c5_sa2[i+2] <= mcu2_l2c5_sa2[i+1];
	           mcu2_l2c5_sa2[i+3] <= mcu2_l2c5_sa2[i+2];
		       mcu2_l2c5_sa2[i+4] <= mcu2_l2c5_sa2[i+3];
		       mcu2_l2c5_sa2[i+5] <= mcu2_l2c5_sa2[i+4];
		       mcu2_l2c5_sa2[i+6] <= mcu2_l2c5_sa2[i+5];
			   mcu2_l2c5_sa2[i+7] <= mcu2_l2c5_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c6_mcu3_sa <= 1;
       mcu3_l2c6_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c6_mcu3_sa[0] <= l2c6_mcu3_sa[543] ^ l2c6_mcu3_sa[541] ^ l2c6_mcu3_sa[538] ^ l2c6_mcu3_sa[537] ^ eqed_l2c6_mcu3[0];
		   end else begin
			   l2c6_mcu3_sa[i] <= l2c6_mcu3_sa[i-1] ^ eqed_l2c6_mcu3[j]; 
		   end
		       l2c6_mcu3_sa[i+1] <= l2c6_mcu3_sa[i];
		       l2c6_mcu3_sa[i+2] <= l2c6_mcu3_sa[i+1];
	           l2c6_mcu3_sa[i+3] <= l2c6_mcu3_sa[i+2];
		       l2c6_mcu3_sa[i+4] <= l2c6_mcu3_sa[i+3];
		       l2c6_mcu3_sa[i+5] <= l2c6_mcu3_sa[i+4];
		       l2c6_mcu3_sa[i+6] <= l2c6_mcu3_sa[i+5];
			   l2c6_mcu3_sa[i+7] <= l2c6_mcu3_sa[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu3_l2c6_sa[0] <= mcu3_l2c6_sa[567] ^ mcu3_l2c6_sa[565] ^ mcu3_l2c6_sa[561] ^ mcu3_l2c6_sa[537] ^ eqed_mcu3_l2c6[0];
		   end else begin
			   mcu3_l2c6_sa[i] <= mcu3_l2c6_sa[i-1] ^ eqed_mcu3_l2c6[j]; 
		   end
		       mcu3_l2c6_sa[i+1] <= mcu3_l2c6_sa[i];
		       mcu3_l2c6_sa[i+2] <= mcu3_l2c6_sa[i+1];
	           mcu3_l2c6_sa[i+3] <= mcu3_l2c6_sa[i+2];
		       mcu3_l2c6_sa[i+4] <= mcu3_l2c6_sa[i+3];
		       mcu3_l2c6_sa[i+5] <= mcu3_l2c6_sa[i+4];
		       mcu3_l2c6_sa[i+6] <= mcu3_l2c6_sa[i+5];
			   mcu3_l2c6_sa[i+7] <= mcu3_l2c6_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c6_mcu3_sa2 <= 1;
       mcu3_l2c6_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c6_mcu3_sa2[0] <= l2c6_mcu3_sa2[543] ^ l2c6_mcu3_sa2[541] ^ l2c6_mcu3_sa2[538] ^ l2c6_mcu3_sa2[537] ^ eqed_l2c6_mcu3[0];
		   end else begin
			   l2c6_mcu3_sa2[i] <= l2c6_mcu3_sa2[i] ^ eqed_l2c6_mcu3[j]; 
		   end
		       l2c6_mcu3_sa2[i+1] <= l2c6_mcu3_sa2[i];
		       l2c6_mcu3_sa2[i+2] <= l2c6_mcu3_sa2[i+1];
	           l2c6_mcu3_sa2[i+3] <= l2c6_mcu3_sa2[i+2];
		       l2c6_mcu3_sa2[i+4] <= l2c6_mcu3_sa2[i+3];
		       l2c6_mcu3_sa2[i+5] <= l2c6_mcu3_sa2[i+4];
		       l2c6_mcu3_sa2[i+6] <= l2c6_mcu3_sa2[i+5];
			   l2c6_mcu3_sa2[i+7] <= l2c6_mcu3_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu3_l2c6_sa2[0] <= mcu3_l2c6_sa2[567] ^ mcu3_l2c6_sa2[565] ^ mcu3_l2c6_sa2[561] ^ mcu3_l2c6_sa2[537] ^ eqed_mcu3_l2c6[0];
		   end else begin
			   mcu3_l2c6_sa2[i] <= mcu3_l2c6_sa2[i] ^ eqed_mcu3_l2c6[j]; 
		   end
		       mcu3_l2c6_sa2[i+1] <= mcu3_l2c6_sa2[i];
		       mcu3_l2c6_sa2[i+2] <= mcu3_l2c6_sa2[i+1];
	           mcu3_l2c6_sa2[i+3] <= mcu3_l2c6_sa2[i+2];
		       mcu3_l2c6_sa2[i+4] <= mcu3_l2c6_sa2[i+3];
		       mcu3_l2c6_sa2[i+5] <= mcu3_l2c6_sa2[i+4];
		       mcu3_l2c6_sa2[i+6] <= mcu3_l2c6_sa2[i+5];
			   mcu3_l2c6_sa2[i+7] <= mcu3_l2c6_sa2[i+6];
       end
    end
end

always @(posedge clk) begin
    if (m_rst) begin
       l2c7_mcu3_sa <= 1;
       mcu3_l2c7_sa <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c7_mcu3_sa[0] <= l2c7_mcu3_sa[543] ^ l2c7_mcu3_sa[541] ^ l2c7_mcu3_sa[538] ^ l2c7_mcu3_sa[537] ^ eqed_l2c7_mcu3[0];
		   end else begin
			   l2c7_mcu3_sa[i] <= l2c7_mcu3_sa[i-1] ^ eqed_l2c7_mcu3[j]; 
		   end
		       l2c7_mcu3_sa[i+1] <= l2c7_mcu3_sa[i];
		       l2c7_mcu3_sa[i+2] <= l2c7_mcu3_sa[i+1];
	           l2c7_mcu3_sa[i+3] <= l2c7_mcu3_sa[i+2];
		       l2c7_mcu3_sa[i+4] <= l2c7_mcu3_sa[i+3];
		       l2c7_mcu3_sa[i+5] <= l2c7_mcu3_sa[i+4];
		       l2c7_mcu3_sa[i+6] <= l2c7_mcu3_sa[i+5];
			   l2c7_mcu3_sa[i+7] <= l2c7_mcu3_sa[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu3_l2c7_sa[0] <= mcu3_l2c7_sa[567] ^ mcu3_l2c7_sa[565] ^ mcu3_l2c7_sa[561] ^ mcu3_l2c7_sa[537] ^ eqed_mcu3_l2c7[0];
		   end else begin
			   mcu3_l2c7_sa[i] <= mcu3_l2c7_sa[i-1] ^ eqed_mcu3_l2c7[j]; 
		   end
		       mcu3_l2c7_sa[i+1] <= mcu3_l2c7_sa[i];
		       mcu3_l2c7_sa[i+2] <= mcu3_l2c7_sa[i+1];
	           mcu3_l2c7_sa[i+3] <= mcu3_l2c7_sa[i+2];
		       mcu3_l2c7_sa[i+4] <= mcu3_l2c7_sa[i+3];
		       mcu3_l2c7_sa[i+5] <= mcu3_l2c7_sa[i+4];
		       mcu3_l2c7_sa[i+6] <= mcu3_l2c7_sa[i+5];
			   mcu3_l2c7_sa[i+7] <= mcu3_l2c7_sa[i+6];
       end
    end
end


always @(posedge clk) begin
    if (m_rst) begin
       l2c7_mcu3_sa2 <= 1;
       mcu3_l2c7_sa2 <= 1;
    end else begin
       for (int i = 0, int j = 0; i < L2C_MCU_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       l2c7_mcu3_sa2[0] <= l2c7_mcu3_sa2[543] ^ l2c7_mcu3_sa2[541] ^ l2c7_mcu3_sa2[538] ^ l2c7_mcu3_sa2[537] ^ eqed_l2c7_mcu3[0];
		   end else begin
			   l2c7_mcu3_sa2[i] <= l2c7_mcu3_sa2[i] ^ eqed_l2c7_mcu3[j]; 
		   end
		       l2c7_mcu3_sa2[i+1] <= l2c7_mcu3_sa2[i];
		       l2c7_mcu3_sa2[i+2] <= l2c7_mcu3_sa2[i+1];
	           l2c7_mcu3_sa2[i+3] <= l2c7_mcu3_sa2[i+2];
		       l2c7_mcu3_sa2[i+4] <= l2c7_mcu3_sa2[i+3];
		       l2c7_mcu3_sa2[i+5] <= l2c7_mcu3_sa2[i+4];
		       l2c7_mcu3_sa2[i+6] <= l2c7_mcu3_sa2[i+5];
			   l2c7_mcu3_sa2[i+7] <= l2c7_mcu3_sa2[i+6];
       end
       for (int i = 0, int j = 0; i < MCU_L2C_SB_SIZE; i = i+8, j++) begin
	       if (i == 0) begin
		       mcu3_l2c7_sa2[0] <= mcu3_l2c7_sa2[567] ^ mcu3_l2c7_sa2[565] ^ mcu3_l2c7_sa2[561] ^ mcu3_l2c7_sa2[537] ^ eqed_mcu3_l2c7[0];
		   end else begin
			   mcu3_l2c7_sa2[i] <= mcu3_l2c7_sa2[i] ^ eqed_mcu3_l2c7[j]; 
		   end
		       mcu3_l2c7_sa2[i+1] <= mcu3_l2c7_sa2[i];
		       mcu3_l2c7_sa2[i+2] <= mcu3_l2c7_sa2[i+1];
	           mcu3_l2c7_sa2[i+3] <= mcu3_l2c7_sa2[i+2];
		       mcu3_l2c7_sa2[i+4] <= mcu3_l2c7_sa2[i+3];
		       mcu3_l2c7_sa2[i+5] <= mcu3_l2c7_sa2[i+4];
		       mcu3_l2c7_sa2[i+6] <= mcu3_l2c7_sa2[i+5];
			   mcu3_l2c7_sa2[i+7] <= mcu3_l2c7_sa2[i+6];
       end
    end
end

*/

M_stable_eqed_reset : assume property (
                             @(posedge clk)
                             ##1 eqed_rst == 1'b0
                             );


C_check_l2c0 : cover property (
                             @(posedge clk)
                             eqed_rst == 1'b1
                             ##32
					         l2d0_l2c0_sa    == 1249'h040820a5998080010005a0c0c080000000b0092a01086048101d60709021010008747c00a0f7ee07fa400fc1e03a09f7ffc8080046003fb1842600efffefd9897dfdffefffdfcbd30c8ef227fe3f4a0cc8419a40680802003cfd7746eee0088e6849ff7fffdde1ff350f7b7fffefdfe7fbffbb8382c80200400a0fffbefd8810ffffff12ffdff800f04000000001bfffe04002c7802057ff7efe3befb
							 && ccx_l2c0_sa  == 1121'h0aa0060000a606060606a00600a6808086a6260000000600202080a0a62680a02600860006262026260600008026a6a626a0a0a000a086a026008680008080062000a6a0a6060606a6860680a0a6a080a000a08680060006062626a02680260686060620868020060020000020a08626a686a08080a0a626a6a6a62686a080a0a0a02085fc9490041c0200015
							 && mcu0_l2c0_sa == 569'h03800a08030cffc000ff9bbefee1ffe46fcb189a1b043dffbf5a7ffbffff9ffffffdfac4a82a100e380000001d0e000008600008001f100014c1aab04a10bc40d99f0b2c43c4f5d
							 && l2c0_l2d0_sa == 1009'h0d98c000048514050000000000013e9fed4f4e42dc6ca0298f6daa89648bbf838f8fc25702b78547c3efe704939faf2b50ff81b87dec03c4b8f96e1cab60dd5993dfd77198b00017eb581575157fe6883e9037b727d34aac3f66604a4f17acde7cd22946573f7f0f423a31ad1bffe228af201d90d7bf48875eef10d248c68
							 && l2c0_ccx_sa  == 1249'h03c3e869de40780c1000fffea775717effb960ff77fffb7fbc4800003004f281c1ce08af2ff0f9e21d2400400fbf6bffb6f818200001eee6c24660a3cc707bcce9027ff127e969987da87e02002017ad4e12de6f3c0bf8f3e008045122e19fe7ebee36d94054bedf185857c43e23f00fcffc2147c4f67dcecdabffb7ff14c2ae9fbdea43c9c90291cf77e04bfa3cf7dfb27f785f69ef817feefd503df
							 && l2c0_mcu0_sa == 545'h0bf7cd0002c73e09f10b353ef1f238fbf7f3f4f53b34cb3635ce39303e3ecec7053bc83b35cbfecf07300df0ce07c300f1f33a37ce03f0c839f5c9003834c130620ee5199
                             );



/*

spc spc0(
  .vnw_ary0                 (SPC_VNW[ 0 ]),
  .vnw_ary1		    (SPC_VNW[ 0 ]),
  .gclk				  ( cmp_gclk_c3_spc0 ), // cmp_gclk_c1_r[1]) ,
  .tcu_clk_stop ( gl_spc0_clk_stop ),	// staged clk_stop
  .cpx_spc_data_cx	    (cpx_spc0_data_cx2[ 145 : 0 ]	 ),// sparc core
  .pcx_spc_grant_px	    (pcx_spc0_grant_px[ 8 : 0 ]	 ),
  .spc_pcx_req_pq	    (spc0_pcx_req_pq[ 8 : 0 ]	 ),
  .spc_pcx_atm_pq	    (spc0_pcx_atm_pq[ 8 : 0 ]	 ),
  .spc_pcx_data_pa	    (spc0_pcx_data_pa[ 129 : 0 ]	 ),
  .spc_hardstop_request	    (spc0_hardstop_request),
  .spc_softstop_request	    (spc0_softstop_request),
  .spc_trigger_pulse	    (spc0_trigger_pulse),
  .tcu_ss_mode		    (tcu_ss_mode[ 0 ]),
  .tcu_do_mode		    (tcu_do_mode[ 0 ]),
  .tcu_ss_request	    (tcu_ss_request_t1lff_0),
  .spc_ss_complete	    (spc0_ss_complete),
  .tcu_aclk		    (tcu_spc0_aclk		 ),
  .tcu_bclk		    (tcu_spc0_bclk		 ),
  .tcu_scan_en		    (tcu_spc0_scan_en		 ),
  .tcu_se_scancollar_in	    (tcu_spc0_se_scancollar_in	 ),
  .tcu_se_scancollar_out    (tcu_spc0_se_scancollar_out	 ),
  .tcu_array_wr_inhibit	    (tcu_spc0_array_wr_inhibit	 ),
  .tcu_core_running	    (ncu_spc0_core_running[ 7 : 0 ]	 ),
  .spc_core_running_status  (spc0_ncu_core_running_status[ 7 : 0 ]),
  .const_cpuid		    ({1'b0, 1'b0, 1'b0}		 ),//No 3'b101 to Astro.
  .power_throttle	    (mio_spc_pwr_throttle_0[ 2 : 0 ]),
  .scan_out		    (spc0_tcu_scan_in[ 1 : 0 ]	 ),
  .scan_in		    (tcu_spc0_scan_out[ 1 : 0 ]	 ),
  .spc_dbg_instr_cmt_grp0   (spc0_dbg0_instr_cmt_grp0[ 1 : 0 ]),
  .spc_dbg_instr_cmt_grp1   (spc0_dbg0_instr_cmt_grp1[ 1 : 0 ]),
  .tcu_spc_mbist_start	    (tcu_spc0_mbist_start_t1lff_0),
  .spc_mbist_done	    (spc0_tcu_mbist_done    ),
  .spc_mbist_fail	    (spc0_tcu_mbist_fail    ),
  .tcu_spc_mbist_scan_in    (tcu_spc0_mbist_scan_in	 ),
  .spc_tcu_mbist_scan_out   (spc0_tcu_mbist_scan_out	 ),
  .dmo_din		    (36'b0			 ),
  .dmo_dout		    (spc0_dmo_dout[ 35 : 0 ]	 ),
  .dmo_coresel		    (1'b0			 ),
  .tcu_spc_lbist_start	    (tcu_spc_lbist_start[ 0 ]	 ),
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in[ 0 ]	 ),
  .spc_tcu_lbist_done	    (spc0_tcu_lbist_done	 ),
  .spc_tcu_lbist_scan_out   (spc0_tcu_lbist_scan_out	 ),
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ),
  .tcu_shscan_aclk	    (tcu_spc_shscan_aclk	 ),
  .tcu_shscan_bclk	    (tcu_spc_shscan_bclk	 ),
  .tcu_shscan_scan_en	    (tcu_spc_shscan_scan_en	 ),
  .tcu_shscanid		    (tcu_spc_shscanid[ 2 : 0 ]	 ),
  .tcu_shscan_scan_in	    (tcu_spc0_shscan_scan_out	 ),
  .spc_shscan_scan_out	    (spc0_tcu_shscan_scan_in	 ),
  .tcu_shscan_clk_stop	    (tcu_spc0_shscan_clk_stop	 ),
  .efu_spc_fuse_data	    (efu_spc0246_fuse_data	 ),
  .efu_spc_fuse_ixfer_en    (efu_spc0_fuse_ixfer_en	 ),
  .efu_spc_fuse_iclr	    (efu_spc0_fuse_iclr		 ),
  .efu_spc_fuse_dxfer_en    (efu_spc0_fuse_dxfer_en	 ),
  .efu_spc_fuse_dclr	    (efu_spc0_fuse_dclr		 ),
  .spc_efu_fuse_dxfer_en    (spc0_efu_fuse_dxfer_en	 ),
  .spc_efu_fuse_ixfer_en    (spc0_efu_fuse_ixfer_en	 ),
  .spc_efu_fuse_ddata	    (spc0_efu_fuse_ddata	 ),
  .spc_efu_fuse_idata	    (spc0_efu_fuse_idata	 ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3t0 ),	// gl_io_cmp_sync_en_c3t  - for int6.1
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3t0 ),	// gl_cmp_io_sync_en_c3t  - for int6.1
  .hver_mask_minor_rev	    (spc_revid_out[ 3 : 0 ]        ),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .rst_wmr_protect(rst_wmr_protect),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .ncu_cmp_tick_enable(ncu_cmp_tick_enable),
  .ncu_wmr_vec_mask(ncu_wmr_vec_mask),
  .ncu_spc_pm(ncu_spc_pm),
  .ncu_spc_ba01(ncu_spc_ba01),
  .ncu_spc_ba23(ncu_spc_ba23),
  .ncu_spc_ba45(ncu_spc_ba45),
  .ncu_spc_ba67(ncu_spc_ba67),
  .tcu_spc_lbist_pgm(tcu_spc_lbist_pgm),
  .tcu_spc_test_mode(tcu_spc0_test_mode),
  .dmo_icmuxctl(dmo_icmuxctl),
  .dmo_dcmuxctl(dmo_dcmuxctl),
  .tcu_atpg_mode(tcu_atpg_mode),
  .ncu_spc_l2_idx_hash_en(ncu_spc_l2_idx_hash_en)
            );

*/

/* - 	    
assign spc0_tcu_scan_in[1:0] = 2'b0;
assign spc0_ncu_core_running_status[7:0] = 8'b0;
assign spc0_tcu_shscan_scan_in = 1'b0;
assign spc0_tcu_mbist_done = 1'b0;
assign spc0_tcu_mbist_fail = 1'b0;
assign spc0_tcu_mbist_scan_out = 1'b0;
assign spc0_dmo_dout  = 36'b0;
assign spc0_tcu_lbist_done = 1'b0;
assign spc0_tcu_lbist_scan_out = 1'b0;
assign spc0_hardstop_request = 1'b0;
assign spc0_softstop_request = 1'b0;
assign spc0_trigger_pulse = 1'b0;
assign spc0_ss_complete = 1'b0;
assign spc0_dbg0_instr_cmt_grp0[1:0] = 2'b0;
assign spc0_dbg0_instr_cmt_grp1[1:0] = 2'b0;
assign spc0_efu_fuse_ddata =1'b0;
assign spc0_efu_fuse_dxfer_en =1'b0;
assign spc0_efu_fuse_idata =1'b0;
assign spc0_efu_fuse_ixfer_en =1'b0;
*/

//________________________________________________________________

/*

spc spc1(
  .vnw_ary0                 (SPC_VNW[ 1 ]),
  .vnw_ary1                 (SPC_VNW[ 1 ]),
  .gclk                      	  ( cmp_gclk_c2_spc1 ), // cmp_gclk_c1_r[1]) , 
  .tcu_clk_stop ( gl_spc1_clk_stop ),	// staged clk_stop

  .cpx_spc_data_cx          (cpx_spc1_data_cx2[ 145 : 0 ]    ),// sparc core
  .pcx_spc_grant_px         (pcx_spc1_grant_px[ 8 : 0 ]      ),
  .spc_pcx_req_pq           (spc1_pcx_req_pq[ 8 : 0 ]        ),
  .spc_pcx_atm_pq           (spc1_pcx_atm_pq[ 8 : 0 ]        ),
  .spc_pcx_data_pa          (spc1_pcx_data_pa[ 129 : 0 ]     ),
  .spc_hardstop_request     (spc1_hardstop_request),
  .spc_softstop_request     (spc1_softstop_request),
  .spc_trigger_pulse        (spc1_trigger_pulse),
  .tcu_ss_mode              (tcu_ss_mode[ 1 ]),
  .tcu_do_mode              (tcu_do_mode[ 1 ]),
  .tcu_ss_request           (tcu_ss_request[ 1 ]),
  .spc_ss_complete          (spc1_ss_complete),
  .tcu_aclk                 (tcu_spc1_aclk               ),
  .tcu_bclk                 (tcu_spc1_bclk               ),
  .tcu_scan_en              (tcu_spc1_scan_en            ),
  .tcu_se_scancollar_in     (tcu_spc1_se_scancollar_in   ),
  .tcu_se_scancollar_out    (tcu_spc1_se_scancollar_out  ),
  .tcu_array_wr_inhibit     (tcu_spc1_array_wr_inhibit   ),
  .tcu_core_running         (ncu_spc1_core_running[ 7 : 0 ]  ),
  .spc_core_running_status  (spc1_ncu_core_running_status[ 7 : 0 ]),
  .const_cpuid              ({1'b0, 1'b0, 1'b1}          ),//No 3'b101 to Astro.
  .power_throttle           (mio_spc_pwr_throttle_0[ 2 : 0 ]),
  .scan_out                 (spc1_tcu_scan_in[ 1 : 0 ]       ),
  .scan_in                  (tcu_spc1_scan_out[ 1 : 0 ]      ),
  .spc_dbg_instr_cmt_grp0   (spc1_dbg1_instr_cmt_grp0[ 1 : 0 ]),
  .spc_dbg_instr_cmt_grp1   (spc1_dbg1_instr_cmt_grp1[ 1 : 0 ]),
  .tcu_spc_mbist_start      (tcu_spc_mbist_start[ 1 ]    ),
  .spc_mbist_done           (spc1_tcu_mbist_done    ),
  .spc_mbist_fail           (spc1_tcu_mbist_fail    ),
  .tcu_spc_mbist_scan_in    (tcu_spc1_mbist_scan_in      ),
  .spc_tcu_mbist_scan_out   (spc1_tcu_mbist_scan_out     ),
  .dmo_din                  (spc0_dmo_dout[ 35 : 0 ]         ),
  .dmo_dout                 (spc1_dmo_dout[ 35 : 0 ]         ),
  .dmo_coresel              (dmo_coresel[ 5 ]              ),
  .tcu_spc_lbist_start      (tcu_spc_lbist_start[ 1 ]      ),
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in[ 1 ]    ),
  .spc_tcu_lbist_done       (spc1_tcu_lbist_done         ),
  .spc_tcu_lbist_scan_out   (spc1_tcu_lbist_scan_out     ),
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ),
  .tcu_shscan_aclk          (tcu_spc_shscan_aclk	 ),
  .tcu_shscan_bclk          (tcu_spc_shscan_bclk         ),
  .tcu_shscan_scan_en       (tcu_spc_shscan_scan_en      ),
  .tcu_shscanid             (tcu_spc_shscanid[ 2 : 0 ]       ),
  .tcu_shscan_scan_in       (tcu_spc1_shscan_scan_out    ),
  .spc_shscan_scan_out      (spc1_tcu_shscan_scan_in     ),
  .tcu_shscan_clk_stop      (tcu_spc1_shscan_clk_stop    ),
  .efu_spc_fuse_data        (efu_spc1357_fuse_data       ),
  .efu_spc_fuse_ixfer_en    (efu_spc1_fuse_ixfer_en      ),
  .efu_spc_fuse_iclr        (efu_spc1_fuse_iclr          ),
  .efu_spc_fuse_dxfer_en    (efu_spc1_fuse_dxfer_en      ),
  .efu_spc_fuse_dclr        (efu_spc1_fuse_dclr          ),
  .spc_efu_fuse_dxfer_en    (spc1_efu_fuse_dxfer_en      ),
  .spc_efu_fuse_ixfer_en    (spc1_efu_fuse_ixfer_en      ),
  .spc_efu_fuse_ddata       (spc1_efu_fuse_ddata         ),
  .spc_efu_fuse_idata       (spc1_efu_fuse_idata         ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c2t ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c2t ),
  .hver_mask_minor_rev      (spc_revid_out[ 3 : 0 ]          ),
  .tcu_spc_test_mode        (tcu_spc1_test_mode),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .rst_wmr_protect(rst_wmr_protect),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .ncu_cmp_tick_enable(ncu_cmp_tick_enable),
  .ncu_wmr_vec_mask(ncu_wmr_vec_mask),
  .ncu_spc_pm(ncu_spc_pm),
  .ncu_spc_ba01(ncu_spc_ba01),
  .ncu_spc_ba23(ncu_spc_ba23),
  .ncu_spc_ba45(ncu_spc_ba45),
  .ncu_spc_ba67(ncu_spc_ba67),
  .tcu_spc_lbist_pgm(tcu_spc_lbist_pgm),
  .dmo_icmuxctl(dmo_icmuxctl),
  .dmo_dcmuxctl(dmo_dcmuxctl),
  .ncu_spc_l2_idx_hash_en(ncu_spc_l2_idx_hash_en)
            );


//________________________________________________________________



spc spc2(
  .vnw_ary0                 (SPC_VNW[ 2 ]),
  .vnw_ary1                 (SPC_VNW[ 2 ]),
  .gclk                      	  ( cmp_gclk_c3_spc2 ), // cmp_gclk_c1_r[6]) , 
  .tcu_clk_stop ( gl_spc2_clk_stop ),	// staged clk_stop

  .cpx_spc_data_cx          (cpx_spc2_data_cx2[ 145 : 0 ]    ),// sparc core
  .pcx_spc_grant_px         (pcx_spc2_grant_px[ 8 : 0 ]      ),
  .spc_pcx_req_pq           (spc2_pcx_req_pq[ 8 : 0 ]        ),
  .spc_pcx_atm_pq           (spc2_pcx_atm_pq[ 8 : 0 ]        ),
  .spc_pcx_data_pa          (spc2_pcx_data_pa[ 129 : 0 ]     ),
  .spc_hardstop_request     (spc2_hardstop_request),
  .spc_softstop_request     (spc2_softstop_request),
  .spc_trigger_pulse        (spc2_trigger_pulse),
  .tcu_ss_mode              (tcu_ss_mode[ 2 ]),
  .tcu_do_mode              (tcu_do_mode[ 2 ]),
  .tcu_ss_request           (tcu_ss_request_t3lff_2),
  .spc_ss_complete          (spc2_ss_complete),
  .tcu_aclk                 (tcu_spc2_aclk               ),
  .tcu_bclk                 (tcu_spc2_bclk               ),
  .tcu_scan_en              (tcu_spc2_scan_en            ),
  .tcu_se_scancollar_in     (tcu_spc2_se_scancollar_in   ),
  .tcu_se_scancollar_out    (tcu_spc2_se_scancollar_out  ),
  .tcu_array_wr_inhibit     (tcu_spc2_array_wr_inhibit   ),
  .tcu_core_running         (ncu_spc2_core_running[ 7 : 0 ]  ),
  .spc_core_running_status  (spc2_ncu_core_running_status[ 7 : 0 ]),
  .const_cpuid              ({1'b0, 1'b1, 1'b0}          ),//No 3'b101 to Astro.
  .power_throttle           (mio_spc_pwr_throttle_1[ 2 : 0 ]),
  .scan_out                 (spc2_tcu_scan_in[ 1 : 0 ]       ),
  .scan_in                  (tcu_spc2_scan_out[ 1 : 0 ]      ),
  .spc_dbg_instr_cmt_grp0   (spc2_dbg0_instr_cmt_grp0[ 1 : 0 ]),
  .spc_dbg_instr_cmt_grp1   (spc2_dbg0_instr_cmt_grp1[ 1 : 0 ]),
  .tcu_spc_mbist_start      (tcu_spc_mbist_start_t3lff_2 ),
  .spc_mbist_done           (spc2_tcu_mbist_done    ),
  .spc_mbist_fail           (spc2_tcu_mbist_fail    ),
  .tcu_spc_mbist_scan_in    (tcu_spc2_mbist_scan_in      ),
  .spc_tcu_mbist_scan_out   (spc2_tcu_mbist_scan_out     ),
  .dmo_din                  (36'b0                       ),
  .dmo_dout                 (spc2_dmo_dout[ 35 : 0 ]         ),
  .dmo_coresel              (1'b0                        ),
  .tcu_spc_lbist_start      (tcu_spc_lbist_start[ 2 ]      ),
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in[ 2 ]    ),
  .spc_tcu_lbist_done       (spc2_tcu_lbist_done         ),
  .spc_tcu_lbist_scan_out   (spc2_tcu_lbist_scan_out     ),
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ),
  .tcu_shscan_aclk          (tcu_spc_shscan_aclk	 ),
  .tcu_shscan_bclk          (tcu_spc_shscan_bclk         ),
  .tcu_shscan_scan_en       (tcu_spc_shscan_scan_en      ),
  .tcu_shscanid             (tcu_spc_shscanid[ 2 : 0 ]       ),
  .tcu_shscan_scan_in       (tcu_spc2_shscan_scan_out    ),
  .spc_shscan_scan_out      (spc2_tcu_shscan_scan_in     ),
  .tcu_shscan_clk_stop      (tcu_spc2_shscan_clk_stop    ),
  .efu_spc_fuse_data        (efu_spc0246_fuse_data       ),
  .efu_spc_fuse_ixfer_en    (efu_spc2_fuse_ixfer_en      ),
  .efu_spc_fuse_iclr        (efu_spc2_fuse_iclr          ),
  .efu_spc_fuse_dxfer_en    (efu_spc2_fuse_dxfer_en      ),
  .efu_spc_fuse_dclr        (efu_spc2_fuse_dclr          ),
  .spc_efu_fuse_dxfer_en    (spc2_efu_fuse_dxfer_en      ),
  .spc_efu_fuse_ixfer_en    (spc2_efu_fuse_ixfer_en      ),
  .spc_efu_fuse_ddata       (spc2_efu_fuse_ddata         ),
  .spc_efu_fuse_idata       (spc2_efu_fuse_idata         ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3b ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3b ),
  .hver_mask_minor_rev      (spc_revid_out[ 3 : 0 ]          ),
  .tcu_spc_test_mode        (tcu_spc2_test_mode),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .rst_wmr_protect(rst_wmr_protect),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .ncu_cmp_tick_enable(ncu_cmp_tick_enable),
  .ncu_wmr_vec_mask(ncu_wmr_vec_mask),
  .ncu_spc_pm(ncu_spc_pm),
  .ncu_spc_ba01(ncu_spc_ba01),
  .ncu_spc_ba23(ncu_spc_ba23),
  .ncu_spc_ba45(ncu_spc_ba45),
  .ncu_spc_ba67(ncu_spc_ba67),
  .tcu_spc_lbist_pgm(tcu_spc_lbist_pgm),
  .dmo_icmuxctl(dmo_icmuxctl),
  .dmo_dcmuxctl(dmo_dcmuxctl),
  .ncu_spc_l2_idx_hash_en(ncu_spc_l2_idx_hash_en)
         );

//________________________________________________________________


spc spc3(
  .vnw_ary0                 (SPC_VNW[ 3 ]),
  .vnw_ary1                 (SPC_VNW[ 3 ]),
  .gclk                      	  ( cmp_gclk_c2_spc3 ), // cmp_gclk_c1_r[6]) , 
  .tcu_clk_stop ( gl_spc3_clk_stop ),	// staged clk_stop

  .cpx_spc_data_cx          (cpx_spc3_data_cx2[ 145 : 0 ]    ),// sparc core
  .pcx_spc_grant_px         (pcx_spc3_grant_px[ 8 : 0 ]      ),
  .spc_pcx_req_pq           (spc3_pcx_req_pq[ 8 : 0 ]        ),
  .spc_pcx_atm_pq           (spc3_pcx_atm_pq[ 8 : 0 ]        ),
  .spc_pcx_data_pa          (spc3_pcx_data_pa[ 129 : 0 ]     ),
  .spc_hardstop_request     (spc3_hardstop_request),
  .spc_softstop_request     (spc3_softstop_request),
  .spc_trigger_pulse        (spc3_trigger_pulse),
  .tcu_ss_mode              (tcu_ss_mode[ 3 ]),
  .tcu_do_mode              (tcu_do_mode[ 3 ]),
  .tcu_ss_request           (tcu_ss_request[ 3 ]),
  .spc_ss_complete          (spc3_ss_complete),
  .tcu_aclk                 (tcu_spc3_aclk               ),
  .tcu_bclk                 (tcu_spc3_bclk               ),
  .tcu_scan_en              (tcu_spc3_scan_en            ),
  .tcu_se_scancollar_in     (tcu_spc3_se_scancollar_in   ),
  .tcu_se_scancollar_out    (tcu_spc3_se_scancollar_out  ),
  .tcu_array_wr_inhibit     (tcu_spc3_array_wr_inhibit   ),
  .tcu_core_running         (ncu_spc3_core_running[ 7 : 0 ]  ),
  .spc_core_running_status  (spc3_ncu_core_running_status[ 7 : 0 ]),
  .const_cpuid              ({1'b0, 1'b1, 1'b1}          ),//No 3'b101 to Astro.
  .power_throttle           (mio_spc_pwr_throttle_1[ 2 : 0 ]),
  .scan_out                 (spc3_tcu_scan_in[ 1 : 0 ]       ),
  .scan_in                  (tcu_spc3_scan_out[ 1 : 0 ]      ),
  .spc_dbg_instr_cmt_grp0   (spc3_dbg1_instr_cmt_grp0[ 1 : 0 ]),
  .spc_dbg_instr_cmt_grp1   (spc3_dbg1_instr_cmt_grp1[ 1 : 0 ]),
  .tcu_spc_mbist_start      (tcu_spc_mbist_start[ 3 ]   ),
  .spc_mbist_done           (spc3_tcu_mbist_done    ),
  .spc_mbist_fail           (spc3_tcu_mbist_fail    ),
  .tcu_spc_mbist_scan_in    (tcu_spc3_mbist_scan_in      ),
  .spc_tcu_mbist_scan_out   (spc3_tcu_mbist_scan_out     ),
  .dmo_din                  (spc2_dmo_dout[ 35 : 0 ]         ),
  .dmo_dout                 (spc3_dmo_dout[ 35 : 0 ]         ),
  .dmo_coresel              (dmo_coresel[ 2 ]              ),
  .tcu_spc_lbist_start      (tcu_spc_lbist_start[ 3 ]      ),
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in[ 3 ]    ),
  .spc_tcu_lbist_done       (spc3_tcu_lbist_done         ),
  .spc_tcu_lbist_scan_out   (spc3_tcu_lbist_scan_out     ),
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ),
  .tcu_shscan_aclk          (tcu_spc_shscan_aclk	 ),
  .tcu_shscan_bclk          (tcu_spc_shscan_bclk         ),
  .tcu_shscan_scan_en       (tcu_spc_shscan_scan_en      ),
  .tcu_shscanid             (tcu_spc_shscanid[ 2 : 0 ]       ),
  .tcu_shscan_scan_in       (tcu_spc3_shscan_scan_out    ),
  .spc_shscan_scan_out      (spc3_tcu_shscan_scan_in     ),
  .tcu_shscan_clk_stop      (tcu_spc3_shscan_clk_stop    ),
  .efu_spc_fuse_data        (efu_spc1357_fuse_data       ),
  .efu_spc_fuse_ixfer_en    (efu_spc3_fuse_ixfer_en      ),
  .efu_spc_fuse_iclr        (efu_spc3_fuse_iclr          ),
  .efu_spc_fuse_dxfer_en    (efu_spc3_fuse_dxfer_en      ),
  .efu_spc_fuse_dclr        (efu_spc3_fuse_dclr          ),
  .spc_efu_fuse_dxfer_en    (spc3_efu_fuse_dxfer_en      ),
  .spc_efu_fuse_ixfer_en    (spc3_efu_fuse_ixfer_en      ),
  .spc_efu_fuse_ddata       (spc3_efu_fuse_ddata         ),
  .spc_efu_fuse_idata       (spc3_efu_fuse_idata         ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c2b ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c2b ),
  .hver_mask_minor_rev      (spc_revid_out[ 3 : 0 ]          ),
  .tcu_spc_test_mode        (tcu_spc3_test_mode),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .rst_wmr_protect(rst_wmr_protect),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .ncu_cmp_tick_enable(ncu_cmp_tick_enable),
  .ncu_wmr_vec_mask(ncu_wmr_vec_mask),
  .ncu_spc_pm(ncu_spc_pm),
  .ncu_spc_ba01(ncu_spc_ba01),
  .ncu_spc_ba23(ncu_spc_ba23),
  .ncu_spc_ba45(ncu_spc_ba45),
  .ncu_spc_ba67(ncu_spc_ba67),
  .tcu_spc_lbist_pgm(tcu_spc_lbist_pgm),
  .dmo_icmuxctl(dmo_icmuxctl),
  .dmo_dcmuxctl(dmo_dcmuxctl),
  .ncu_spc_l2_idx_hash_en(ncu_spc_l2_idx_hash_en)
            );

//________________________________________________________________


spc spc4(
  .vnw_ary0                 (SPC_VNW[ 4 ]),
  .vnw_ary1                 (SPC_VNW[ 4 ]),
  .gclk                      	  ( cmp_gclk_c1_spc4 ), // cmp_gclk_c2_r[1]) , 
  .tcu_clk_stop ( gl_spc4_clk_stop ),	// staged clk_stop
  .cpx_spc_data_cx          (cpx_spc4_data_cx2[ 145 : 0 ]    ),// sparc core
  .pcx_spc_grant_px         (pcx_spc4_grant_px[ 8 : 0 ]      ),
  .spc_pcx_req_pq           (spc4_pcx_req_pq[ 8 : 0 ]        ),
  .spc_pcx_atm_pq           (spc4_pcx_atm_pq[ 8 : 0 ]        ),
  .spc_pcx_data_pa          (spc4_pcx_data_pa[ 129 : 0 ]     ),
  .spc_hardstop_request     (spc4_hardstop_request),
  .spc_softstop_request     (spc4_softstop_request),
  .spc_trigger_pulse        (spc4_trigger_pulse),
  .tcu_ss_mode              (tcu_ss_mode[ 4 ]),
  .tcu_do_mode              (tcu_do_mode[ 4 ]),
  .tcu_ss_request           (tcu_ss_request[ 4 ]),
  .spc_ss_complete          (spc4_ss_complete),
  .tcu_aclk                 (tcu_spc4_aclk               ),
  .tcu_bclk                 (tcu_spc4_bclk               ),
  .tcu_scan_en              (tcu_spc4_scan_en            ),
  .tcu_se_scancollar_in     (tcu_spc4_se_scancollar_in   ),
  .tcu_se_scancollar_out    (tcu_spc4_se_scancollar_out  ),
  .tcu_array_wr_inhibit     (tcu_spc4_array_wr_inhibit   ),
  .tcu_core_running         (ncu_spc4_core_running[ 7 : 0 ]  ),
  .spc_core_running_status  (spc4_ncu_core_running_status[ 7 : 0 ]),
  .const_cpuid              ({1'b1, 1'b0, 1'b0}          ),//No 3'b101 to Astro.
  .power_throttle           (mio_spc_pwr_throttle_0[ 2 : 0 ]),
  .scan_out                 (spc4_tcu_scan_in[ 1 : 0 ]       ),
  .scan_in                  (tcu_spc4_scan_out[ 1 : 0 ]      ),
  .spc_dbg_instr_cmt_grp0   (spc4_dbg1_instr_cmt_grp0[ 1 : 0 ]),
  .spc_dbg_instr_cmt_grp1   (spc4_dbg1_instr_cmt_grp1[ 1 : 0 ]),
  .tcu_spc_mbist_start      (tcu_spc_mbist_start[ 4 ]  ),
  .spc_mbist_done           (spc4_tcu_mbist_done    ),
  .spc_mbist_fail           (spc4_tcu_mbist_fail    ),
  .tcu_spc_mbist_scan_in    (tcu_spc4_mbist_scan_in      ),
  .spc_tcu_mbist_scan_out   (spc4_tcu_mbist_scan_out     ),
  .dmo_din                  (spc5_dmo_dout[ 35 : 0 ]         ),
  .dmo_dout                 (spc4_dmo_dout[ 35 : 0 ]         ),
  .dmo_coresel              (dmo_coresel[ 3 ]              ),
  .tcu_spc_lbist_start      (tcu_spc_lbist_start[ 4 ]      ),
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in[ 4 ]    ),
  .spc_tcu_lbist_done       (spc4_tcu_lbist_done         ),
  .spc_tcu_lbist_scan_out   (spc4_tcu_lbist_scan_out     ),
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ),
  .tcu_shscan_aclk          (tcu_spc_shscan_aclk	 ),
  .tcu_shscan_bclk          (tcu_spc_shscan_bclk         ),
  .tcu_shscan_scan_en       (tcu_spc_shscan_scan_en      ),
  .tcu_shscanid             (tcu_spc_shscanid[ 2 : 0 ]       ),
  .tcu_shscan_scan_in       (tcu_spc4_shscan_scan_out    ),
  .spc_shscan_scan_out      (spc4_tcu_shscan_scan_in     ),
  .tcu_shscan_clk_stop      (tcu_spc4_shscan_clk_stop    ),
  .efu_spc_fuse_data        (efu_spc0246_fuse_data       ),
  .efu_spc_fuse_ixfer_en    (efu_spc4_fuse_ixfer_en      ),
  .efu_spc_fuse_iclr        (efu_spc4_fuse_iclr          ),
  .efu_spc_fuse_dxfer_en    (efu_spc4_fuse_dxfer_en      ),
  .efu_spc_fuse_dclr        (efu_spc4_fuse_dclr          ),
  .spc_efu_fuse_dxfer_en    (spc4_efu_fuse_dxfer_en      ),
  .spc_efu_fuse_ixfer_en    (spc4_efu_fuse_ixfer_en      ),
  .spc_efu_fuse_ddata       (spc4_efu_fuse_ddata         ),
  .spc_efu_fuse_idata       (spc4_efu_fuse_idata         ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c1t ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c1t ),
  .hver_mask_minor_rev      (spc_revid_out[ 3 : 0 ]          ),
  .tcu_spc_test_mode        (tcu_spc4_test_mode),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .rst_wmr_protect(rst_wmr_protect),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .ncu_cmp_tick_enable(ncu_cmp_tick_enable),
  .ncu_wmr_vec_mask(ncu_wmr_vec_mask),
  .ncu_spc_pm(ncu_spc_pm),
  .ncu_spc_ba01(ncu_spc_ba01),
  .ncu_spc_ba23(ncu_spc_ba23),
  .ncu_spc_ba45(ncu_spc_ba45),
  .ncu_spc_ba67(ncu_spc_ba67),
  .tcu_spc_lbist_pgm(tcu_spc_lbist_pgm),
  .dmo_icmuxctl(dmo_icmuxctl),
  .dmo_dcmuxctl(dmo_dcmuxctl),
  .ncu_spc_l2_idx_hash_en(ncu_spc_l2_idx_hash_en)
        );

//________________________________________________________________


spc spc5(
  .vnw_ary0                 (SPC_VNW[ 5 ]),
  .vnw_ary1                 (SPC_VNW[ 5 ]),
  .gclk                      	  ( cmp_gclk_c2_spc5 ), // cmp_gclk_c2_r[1]) , 
  .tcu_clk_stop ( gl_spc5_clk_stop ),	// staged clk_stop

  .cpx_spc_data_cx          (cpx_spc5_data_cx2[ 145 : 0 ]    ),// sparc core
  .pcx_spc_grant_px         (pcx_spc5_grant_px[ 8 : 0 ]      ),
  .spc_pcx_req_pq           (spc5_pcx_req_pq[ 8 : 0 ]        ),
  .spc_pcx_atm_pq           (spc5_pcx_atm_pq[ 8 : 0 ]        ),
  .spc_pcx_data_pa          (spc5_pcx_data_pa[ 129 : 0 ]     ),
  .spc_hardstop_request     (spc5_hardstop_request),
  .spc_softstop_request     (spc5_softstop_request),
  .spc_trigger_pulse        (spc5_trigger_pulse),
  .tcu_ss_mode              (tcu_ss_mode[ 5 ]),
  .tcu_do_mode              (tcu_do_mode[ 5 ]),
  .tcu_ss_request           (tcu_ss_request[ 5 ]),
  .spc_ss_complete          (spc5_ss_complete),
  .tcu_aclk                 (tcu_spc5_aclk               ),
  .tcu_bclk                 (tcu_spc5_bclk               ),
  .tcu_scan_en              (tcu_spc5_scan_en            ),
  .tcu_se_scancollar_in     (tcu_spc5_se_scancollar_in   ),
  .tcu_se_scancollar_out    (tcu_spc5_se_scancollar_out  ),
  .tcu_array_wr_inhibit     (tcu_spc5_array_wr_inhibit   ),
  .tcu_core_running         (ncu_spc5_core_running[ 7 : 0 ]  ),
  .spc_core_running_status  (spc5_ncu_core_running_status[ 7 : 0 ]),
  .const_cpuid              ({1'b1, 1'b0, 1'b1}          ),//No 3'b101 to Astro.
  .power_throttle           (mio_spc_pwr_throttle_0[ 2 : 0 ]),
  .scan_out                 (spc5_tcu_scan_in[ 1 : 0 ]       ),
  .scan_in                  (tcu_spc5_scan_out[ 1 : 0 ]      ),
  .spc_dbg_instr_cmt_grp0   (spc5_dbg1_instr_cmt_grp0[ 1 : 0 ]),
  .spc_dbg_instr_cmt_grp1   (spc5_dbg1_instr_cmt_grp1[ 1 : 0 ]),
  .tcu_spc_mbist_start      (tcu_spc_mbist_start[ 5 ]  ),
  .spc_mbist_done           (spc5_tcu_mbist_done    ),
  .spc_mbist_fail           (spc5_tcu_mbist_fail    ),
  .tcu_spc_mbist_scan_in    (tcu_spc5_mbist_scan_in      ),
  .spc_tcu_mbist_scan_out   (spc5_tcu_mbist_scan_out     ),
  .dmo_din                  (spc1_dmo_dout[ 35 : 0 ]         ),
  .dmo_dout                 (spc5_dmo_dout[ 35 : 0 ]         ),
  .dmo_coresel              (dmo_coresel[ 4 ]              ),
  .tcu_spc_lbist_start      (tcu_spc_lbist_start[ 5 ]      ),
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in[ 5 ]    ),
  .spc_tcu_lbist_done       (spc5_tcu_lbist_done         ),
  .spc_tcu_lbist_scan_out   (spc5_tcu_lbist_scan_out     ),
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ),
  .tcu_shscan_aclk          (tcu_spc_shscan_aclk	 ),
  .tcu_shscan_bclk          (tcu_spc_shscan_bclk         ),
  .tcu_shscan_scan_en       (tcu_spc_shscan_scan_en      ),
  .tcu_shscanid             (tcu_spc_shscanid[ 2 : 0 ]       ),
  .tcu_shscan_scan_in       (tcu_spc5_shscan_scan_out    ),
  .spc_shscan_scan_out      (spc5_tcu_shscan_scan_in     ),
  .tcu_shscan_clk_stop      (tcu_spc5_shscan_clk_stop    ),
  .efu_spc_fuse_data        (efu_spc1357_fuse_data       ),
  .efu_spc_fuse_ixfer_en    (efu_spc5_fuse_ixfer_en      ),
  .efu_spc_fuse_iclr        (efu_spc5_fuse_iclr          ),
  .efu_spc_fuse_dxfer_en    (efu_spc5_fuse_dxfer_en      ),
  .efu_spc_fuse_dclr        (efu_spc5_fuse_dclr          ),
  .spc_efu_fuse_dxfer_en    (spc5_efu_fuse_dxfer_en      ),
  .spc_efu_fuse_ixfer_en    (spc5_efu_fuse_ixfer_en      ),
  .spc_efu_fuse_ddata       (spc5_efu_fuse_ddata         ),
  .spc_efu_fuse_idata       (spc5_efu_fuse_idata         ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c2t ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c2t ),
  .hver_mask_minor_rev      (spc_revid_out[ 3 : 0 ]          ),
  .tcu_spc_test_mode        (tcu_spc5_test_mode),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .rst_wmr_protect(rst_wmr_protect),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .ncu_cmp_tick_enable(ncu_cmp_tick_enable),
  .ncu_wmr_vec_mask(ncu_wmr_vec_mask),
  .ncu_spc_pm(ncu_spc_pm),
  .ncu_spc_ba01(ncu_spc_ba01),
  .ncu_spc_ba23(ncu_spc_ba23),
  .ncu_spc_ba45(ncu_spc_ba45),
  .ncu_spc_ba67(ncu_spc_ba67),
  .tcu_spc_lbist_pgm(tcu_spc_lbist_pgm),
  .dmo_icmuxctl(dmo_icmuxctl),
  .dmo_dcmuxctl(dmo_dcmuxctl),
  .ncu_spc_l2_idx_hash_en(ncu_spc_l2_idx_hash_en)
      );

//________________________________________________________________

spc spc6(
  .vnw_ary0                 (SPC_VNW[ 6 ]),
  .vnw_ary1                 (SPC_VNW[ 6 ]),
  .gclk                      	  ( cmp_gclk_c1_spc6 ), // cmp_gclk_c2_r[6]) , 
  .tcu_clk_stop ( gl_spc6_clk_stop ),	// staged clk_stop

  .cpx_spc_data_cx          (cpx_spc6_data_cx2[ 145 : 0 ]    ),// sparc core
  .pcx_spc_grant_px         (pcx_spc6_grant_px[ 8 : 0 ]      ),
  .spc_pcx_req_pq           (spc6_pcx_req_pq[ 8 : 0 ]        ),
  .spc_pcx_atm_pq           (spc6_pcx_atm_pq[ 8 : 0 ]        ),
  .spc_pcx_data_pa          (spc6_pcx_data_pa[ 129 : 0 ]     ),
  .spc_hardstop_request     (spc6_hardstop_request),
  .spc_softstop_request     (spc6_softstop_request),
  .spc_trigger_pulse        (spc6_trigger_pulse),
  .tcu_ss_mode              (tcu_ss_mode[ 6 ]),
  .tcu_do_mode              (tcu_do_mode[ 6 ]),
  .tcu_ss_request           (tcu_ss_request[ 6 ]),
  .spc_ss_complete          (spc6_ss_complete),
  .tcu_aclk                 (tcu_spc6_aclk               ),
  .tcu_bclk                 (tcu_spc6_bclk               ),
  .tcu_scan_en              (tcu_spc6_scan_en            ),
  .tcu_se_scancollar_in     (tcu_spc6_se_scancollar_in   ),
  .tcu_se_scancollar_out    (tcu_spc6_se_scancollar_out  ),
  .tcu_array_wr_inhibit     (tcu_spc6_array_wr_inhibit   ),
  .tcu_core_running         (ncu_spc6_core_running[ 7 : 0 ]  ),
  .spc_core_running_status  (spc6_ncu_core_running_status[ 7 : 0 ]),
  .const_cpuid              ({1'b1, 1'b1, 1'b0}          ),//No 3'b101 to Astro.
  .power_throttle           (mio_spc_pwr_throttle_1[ 2 : 0 ]),
  .scan_out                 (spc6_tcu_scan_in[ 1 : 0 ]       ),
  .scan_in                  (tcu_spc6_scan_out[ 1 : 0 ]      ),
  .spc_dbg_instr_cmt_grp0   (spc6_dbg1_instr_cmt_grp0[ 1 : 0 ]),
  .spc_dbg_instr_cmt_grp1   (spc6_dbg1_instr_cmt_grp1[ 1 : 0 ]),
  .tcu_spc_mbist_start      (tcu_spc_mbist_start[ 6 ]  ),
  .spc_mbist_done           (spc6_tcu_mbist_done    ),
  .spc_mbist_fail           (spc6_tcu_mbist_fail    ),
  .tcu_spc_mbist_scan_in    (tcu_spc6_mbist_scan_in      ),
  .spc_tcu_mbist_scan_out   (spc6_tcu_mbist_scan_out     ),
  .dmo_din                  (spc7_dmo_dout[ 35 : 0 ]         ),
  .dmo_dout                 (spc6_dmo_dout[ 35 : 0 ]         ),
  .dmo_coresel              (dmo_coresel[ 0 ]              ),
  .tcu_spc_lbist_start      (tcu_spc_lbist_start[ 6 ]      ),
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in[ 6 ]    ),
  .spc_tcu_lbist_done       (spc6_tcu_lbist_done         ),
  .spc_tcu_lbist_scan_out   (spc6_tcu_lbist_scan_out     ),
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ),
  .tcu_shscan_aclk          (tcu_spc_shscan_aclk	 ),
  .tcu_shscan_bclk          (tcu_spc_shscan_bclk         ),
  .tcu_shscan_scan_en       (tcu_spc_shscan_scan_en      ),
  .tcu_shscanid             (tcu_spc_shscanid[ 2 : 0 ]       ),
  .tcu_shscan_scan_in       (tcu_spc6_shscan_scan_out    ),
  .spc_shscan_scan_out      (spc6_tcu_shscan_scan_in     ),
  .tcu_shscan_clk_stop      (tcu_spc6_shscan_clk_stop    ),
  .efu_spc_fuse_data        (efu_spc0246_fuse_data       ),
  .efu_spc_fuse_ixfer_en    (efu_spc6_fuse_ixfer_en      ),
  .efu_spc_fuse_iclr        (efu_spc6_fuse_iclr          ),
  .efu_spc_fuse_dxfer_en    (efu_spc6_fuse_dxfer_en      ),
  .efu_spc_fuse_dclr        (efu_spc6_fuse_dclr          ),
  .spc_efu_fuse_dxfer_en    (spc6_efu_fuse_dxfer_en      ),
  .spc_efu_fuse_ixfer_en    (spc6_efu_fuse_ixfer_en      ),
  .spc_efu_fuse_ddata       (spc6_efu_fuse_ddata         ),
  .spc_efu_fuse_idata       (spc6_efu_fuse_idata         ),
  .ccu_slow_cmp_sync_en 	(gl_io_cmp_sync_en_c1b ), 
  .ccu_cmp_slow_sync_en 	(gl_cmp_io_sync_en_c1b ),
  .hver_mask_minor_rev      (spc_revid_out[ 3 : 0 ]          ),
  .tcu_spc_test_mode        (tcu_spc6_test_mode),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .rst_wmr_protect(rst_wmr_protect),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .ncu_cmp_tick_enable(ncu_cmp_tick_enable),
  .ncu_wmr_vec_mask(ncu_wmr_vec_mask),
  .ncu_spc_pm(ncu_spc_pm),
  .ncu_spc_ba01(ncu_spc_ba01),
  .ncu_spc_ba23(ncu_spc_ba23),
  .ncu_spc_ba45(ncu_spc_ba45),
  .ncu_spc_ba67(ncu_spc_ba67),
  .tcu_spc_lbist_pgm(tcu_spc_lbist_pgm),
  .dmo_icmuxctl(dmo_icmuxctl),
  .dmo_dcmuxctl(dmo_dcmuxctl),
  .ncu_spc_l2_idx_hash_en(ncu_spc_l2_idx_hash_en)
     );


//________________________________________________________________


spc spc7(
  .vnw_ary0                 (SPC_VNW[ 7 ]),
  .vnw_ary1                 (SPC_VNW[ 7 ]),
  .gclk                      	  ( cmp_gclk_c2_spc7 ), // cmp_gclk_c2_r[6]) , 
  .tcu_clk_stop ( gl_spc7_clk_stop ),	// staged clk_stop

  .cpx_spc_data_cx          (cpx_spc7_data_cx2[ 145 : 0 ]    ),// sparc core
  .pcx_spc_grant_px         (pcx_spc7_grant_px[ 8 : 0 ]      ),
  .spc_pcx_req_pq           (spc7_pcx_req_pq[ 8 : 0 ]        ),
  .spc_pcx_atm_pq           (spc7_pcx_atm_pq[ 8 : 0 ]        ),
  .spc_pcx_data_pa          (spc7_pcx_data_pa[ 129 : 0 ]     ),
  .spc_hardstop_request     (spc7_hardstop_request),
  .spc_softstop_request     (spc7_softstop_request),
  .spc_trigger_pulse        (spc7_trigger_pulse),
  .tcu_ss_mode              (tcu_ss_mode[ 7 ]),
  .tcu_do_mode              (tcu_do_mode[ 7 ]),
  .tcu_ss_request           (tcu_ss_request[ 7 ]),
  .spc_ss_complete          (spc7_ss_complete),
  .tcu_aclk                 (tcu_spc7_aclk               ),
  .tcu_bclk                 (tcu_spc7_bclk               ),
  .tcu_scan_en              (tcu_spc7_scan_en            ),
  .tcu_se_scancollar_in     (tcu_spc7_se_scancollar_in   ),
  .tcu_se_scancollar_out    (tcu_spc7_se_scancollar_out  ),
  .tcu_array_wr_inhibit     (tcu_spc7_array_wr_inhibit   ),
  .tcu_core_running         (ncu_spc7_core_running[ 7 : 0 ]  ),
  .spc_core_running_status  (spc7_ncu_core_running_status[ 7 : 0 ]),
  .const_cpuid              ({1'b1, 1'b1, 1'b1}          ),//No 3'b101 to Astro.
  .power_throttle           (mio_spc_pwr_throttle_1[ 2 : 0 ]),
  .scan_out                 (spc7_tcu_scan_in[ 1 : 0 ]       ),
  .scan_in                  (tcu_spc7_scan_out[ 1 : 0 ]      ),
  .spc_dbg_instr_cmt_grp0   (spc7_dbg1_instr_cmt_grp0[ 1 : 0 ]),
  .spc_dbg_instr_cmt_grp1   (spc7_dbg1_instr_cmt_grp1[ 1 : 0 ]),
  .tcu_spc_mbist_start      (tcu_spc_mbist_start[ 7 ]  ),
  .spc_mbist_done           (spc7_tcu_mbist_done    ),
  .spc_mbist_fail           (spc7_tcu_mbist_fail    ),
  .tcu_spc_mbist_scan_in    (tcu_spc7_mbist_scan_in      ),
  .spc_tcu_mbist_scan_out   (spc7_tcu_mbist_scan_out     ),
  .dmo_din                  (spc3_dmo_dout[ 35 : 0 ]         ),
  .dmo_dout                 (spc7_dmo_dout[ 35 : 0 ]         ),
  .dmo_coresel              (dmo_coresel[ 1 ]              ),
  .tcu_spc_lbist_start      (tcu_spc_lbist_start[ 7 ]      ),
  .tcu_spc_lbist_scan_in    (tcu_spc_lbist_scan_in[ 7 ]    ),
  .spc_tcu_lbist_done       (spc7_tcu_lbist_done         ),
  .spc_tcu_lbist_scan_out   (spc7_tcu_lbist_scan_out     ),
  .tcu_shscan_pce_ov	    (tcu_spc_shscan_pce_ov	 ),
  .tcu_shscan_aclk          (tcu_spc_shscan_aclk	 ),
  .tcu_shscan_bclk          (tcu_spc_shscan_bclk         ),
  .tcu_shscan_scan_en       (tcu_spc_shscan_scan_en      ),
  .tcu_shscanid             (tcu_spc_shscanid[ 2 : 0 ]       ),
  .tcu_shscan_scan_in       (tcu_spc7_shscan_scan_out    ),
  .spc_shscan_scan_out      (spc7_tcu_shscan_scan_in     ),
  .tcu_shscan_clk_stop      (tcu_spc7_shscan_clk_stop    ),
  .efu_spc_fuse_data        (efu_spc1357_fuse_data       ),
  .efu_spc_fuse_ixfer_en    (efu_spc7_fuse_ixfer_en      ),
  .efu_spc_fuse_iclr        (efu_spc7_fuse_iclr          ),
  .efu_spc_fuse_dxfer_en    (efu_spc7_fuse_dxfer_en      ),
  .efu_spc_fuse_dclr        (efu_spc7_fuse_dclr          ),
  .spc_efu_fuse_dxfer_en    (spc7_efu_fuse_dxfer_en      ),
  .spc_efu_fuse_ixfer_en    (spc7_efu_fuse_ixfer_en      ),
  .spc_efu_fuse_ddata       (spc7_efu_fuse_ddata         ),
  .spc_efu_fuse_idata       (spc7_efu_fuse_idata         ),
  .ccu_slow_cmp_sync_en 	( gl_io_cmp_sync_en_c2b ), 
  .ccu_cmp_slow_sync_en 	( gl_cmp_io_sync_en_c2b ),
  .hver_mask_minor_rev      (spc_revid_out[ 3 : 0 ]          ),
  .tcu_spc_test_mode        (tcu_spc7_test_mode),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_atpg_mode(tcu_atpg_mode),
  .rst_wmr_protect(rst_wmr_protect),
  .cluster_arst_l(cluster_arst_l),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .ncu_cmp_tick_enable(ncu_cmp_tick_enable),
  .ncu_wmr_vec_mask(ncu_wmr_vec_mask),
  .ncu_spc_pm(ncu_spc_pm),
  .ncu_spc_ba01(ncu_spc_ba01),
  .ncu_spc_ba23(ncu_spc_ba23),
  .ncu_spc_ba45(ncu_spc_ba45),
  .ncu_spc_ba67(ncu_spc_ba67),
  .tcu_spc_lbist_pgm(tcu_spc_lbist_pgm),
  .dmo_icmuxctl(dmo_icmuxctl),
  .dmo_dcmuxctl(dmo_dcmuxctl),
  .ncu_spc_l2_idx_hash_en(ncu_spc_l2_idx_hash_en)
       );


//________________________________________________________________

*/

//// stagging flops

//assign

/*

ccx ccx(

  //  .gclk		    ( cmp_gclk_c2_ccx_right ), // cmp_gclk_c1_r[3]) , 
  .gl_ccx_clk_stop_left     ( gl_ccx_clk_stop ), 
  .gl_ccx_clk_stop_right    ( gl_ccx_clk_stop ), 
  .scan_in                  (tcu_ccx_scan_out[ 1 : 0 ]       ),      
  .scan_out                 (ccx_scan_out[ 1 : 0 ]           ),
  .io_cpx_req_cq            (ncu_cpx_req_cq[ 7 : 0 ]         ),
  .cpx_io_grant_cx          (cpx_ncu_grant_cx[ 7 : 0 ]       ),
  .io_cpx_data_ca           ({ncu_cpx_data_ca[ 145 : 0 ]}),
  .io_pcx_stall_pq          (ncu_pcx_stall_pq            ),
  .pcx_fpio_data_px2        (pcx_ncu_data_px2[ 129 : 0 ]     ),
  .sctag0_cpx_data_ca       ({sctag0_cpx_data_ca[ 145 : 0 ]}),
  .sctag1_cpx_data_ca       ({sctag1_cpx_data_ca[ 145 : 0 ]}),
  .sctag2_cpx_data_ca       ({sctag2_cpx_data_ca[ 145 : 0 ]}),
  .sctag3_cpx_data_ca       ({sctag3_cpx_data_ca[ 145 : 0 ]}),
  .sctag4_cpx_data_ca       ({sctag4_cpx_data_ca[ 145 : 0 ]}),
  .sctag5_cpx_data_ca       ({sctag5_cpx_data_ca[ 145 : 0 ]}),
  .sctag6_cpx_data_ca       ({sctag6_cpx_data_ca[ 145 : 0 ]}),
  .sctag7_cpx_data_ca       ({sctag7_cpx_data_ca[ 145 : 0 ]}),
  .pcx_fpio_data_rdy_px1    (pcx_ncu_data_rdy_px1        ),
  ////  .tcu_clk_stop             (tcu_soc4cmp_clk_stop        ),

  .ccx_lstg_in              (
                             {'0
							  dbg0_dbg1_l2b0_sio_ack_dest,
                              dbg0_dbg1_l2b0_sio_ack_type,
                              dbg0_dbg1_l2b0_sio_ctag_vld,
                              dbg0_dbg1_l2b1_sio_ack_dest,
                              dbg0_dbg1_l2b1_sio_ack_type,
                              dbg0_dbg1_l2b1_sio_ctag_vld,
                              dbg0_dbg1_l2b2_sio_ack_dest,
                              dbg0_dbg1_l2b2_sio_ack_type,
                              dbg0_dbg1_l2b2_sio_ctag_vld,
                              dbg0_dbg1_l2b3_sio_ack_dest,
                              dbg0_dbg1_l2b3_sio_ack_type,
                              dbg0_dbg1_l2b3_sio_ctag_vld,
                              dbg0_dbg1_l2t0_err_event,
                              dbg0_dbg1_l2t0_pa_match,
                              dbg0_dbg1_l2t0_sii_iq_dequeue,
                              dbg0_dbg1_l2t0_sii_wib_dequeue,
                              dbg0_dbg1_l2t0_xbar_vcid[ 5 : 0 ],
                              dbg0_dbg1_l2t2_err_event,
                              dbg0_dbg1_l2t2_pa_match,
                              dbg0_dbg1_l2t2_sii_iq_dequeue,
                              dbg0_dbg1_l2t2_sii_wib_dequeue,
                              dbg0_dbg1_l2t2_xbar_vcid[ 5 : 0 ],
                              dbg0_dbg1_spc0_instr_cmt_grp0[ 0 ],
                              dbg0_dbg1_spc0_instr_cmt_grp0[ 1 ],
                              dbg0_dbg1_spc0_instr_cmt_grp1[ 0 ],
                              dbg0_dbg1_spc0_instr_cmt_grp1[ 1 ],
                              dbg0_dbg1_spc2_instr_cmt_grp0[ 0 ],
                              dbg0_dbg1_spc2_instr_cmt_grp0[ 1 ],
                              dbg0_dbg1_spc2_instr_cmt_grp1[ 0 ],
                              dbg0_dbg1_spc2_instr_cmt_grp1[ 1 ],
                              l2b1_sio_data[ 31 : 0 ],
                              l2b1_sio_parity[ 1 : 0 ],
                              l2b1_sio_ctag_vld,
                              l2b1_sio_ue_err,
                              l2b2_sio_data[ 31 : 0 ],
                              l2b2_sio_parity[ 1 : 0 ],
                              l2b2_sio_ctag_vld,
                              l2b2_sio_ue_err,
                              l2b3_sio_data[ 31 : 0 ],
                              l2b3_sio_parity[ 1 : 0 ],
                              l2b3_sio_ctag_vld,
                              l2b3_sio_ue_err,
                              l2b0_tcu_mbist_done,
                              l2b0_tcu_mbist_fail,
                              tcu_l2b0_mbist_start,
                              l2b1_tcu_mbist_done,
                              l2b1_tcu_mbist_fail,
                              tcu_l2b1_mbist_start,
                              l2b2_tcu_mbist_done,
                              l2b2_tcu_mbist_fail,
                              tcu_l2b2_mbist_start,
                              l2b3_tcu_mbist_done,
                              l2b3_tcu_mbist_fail,
                              tcu_l2b3_mbist_start
                             }
                            ),
  .ccx_lstg_out             (
                             {dbg0_dbg1_l2b0_sio_ack_dest_ccxlff,
                              dbg0_dbg1_l2b0_sio_ack_type_ccxlff,
                              dbg0_dbg1_l2b0_sio_ctag_vld_ccxlff,
                              dbg0_dbg1_l2b1_sio_ack_dest_ccxlff,
                              dbg0_dbg1_l2b1_sio_ack_type_ccxlff,
                              dbg0_dbg1_l2b1_sio_ctag_vld_ccxlff,
                              dbg0_dbg1_l2b2_sio_ack_dest_ccxlff,
                              dbg0_dbg1_l2b2_sio_ack_type_ccxlff,
                              dbg0_dbg1_l2b2_sio_ctag_vld_ccxlff,
                              dbg0_dbg1_l2b3_sio_ack_dest_ccxlff,
                              dbg0_dbg1_l2b3_sio_ack_type_ccxlff,
                              dbg0_dbg1_l2b3_sio_ctag_vld_ccxlff,
                              dbg0_dbg1_l2t0_err_event_ccxlff,
                              dbg0_dbg1_l2t0_pa_match_ccxlff,
                              dbg0_dbg1_l2t0_sii_iq_dequeue_ccxlff,
                              dbg0_dbg1_l2t0_sii_wib_dequeue_ccxlff,
                              dbg0_dbg1_l2t0_xbar_vcid_ccxlff[ 5 : 0 ],
                              dbg0_dbg1_l2t2_err_event_ccxlff,
                              dbg0_dbg1_l2t2_pa_match_ccxlff,
                              dbg0_dbg1_l2t2_sii_iq_dequeue_ccxlff,
                              dbg0_dbg1_l2t2_sii_wib_dequeue_ccxlff,
                              dbg0_dbg1_l2t2_xbar_vcid_ccxlff[ 5 : 0 ],
                              dbg0_dbg1_spc0_instr_cmt_grp0_ccxlff_0,
                              dbg0_dbg1_spc0_instr_cmt_grp0_ccxlff_1,
                              dbg0_dbg1_spc0_instr_cmt_grp1_ccxlff_0,
                              dbg0_dbg1_spc0_instr_cmt_grp1_ccxlff_1,
                              dbg0_dbg1_spc2_instr_cmt_grp0_ccxlff_0,
                              dbg0_dbg1_spc2_instr_cmt_grp0_ccxlff_1,
                              dbg0_dbg1_spc2_instr_cmt_grp1_ccxlff_0,
                              dbg0_dbg1_spc2_instr_cmt_grp1_ccxlff_1,
                              l2b1_sio_data_ccxlff[ 31 : 0 ],
                              l2b1_sio_parity_ccxlff[ 1 : 0 ],
                              l2b1_sio_ctag_vld_ccxlff,
                              l2b1_sio_ue_err_ccxlff,
                              l2b2_sio_data_ccxlff[ 31 : 0 ],
                              l2b2_sio_parity_ccxlff[ 1 : 0 ],
                              l2b2_sio_ctag_vld_ccxlff,
                              l2b2_sio_ue_err_ccxlff,
                              l2b3_sio_data_ccxlff[ 31 : 0 ],
                              l2b3_sio_parity_ccxlff[ 1 : 0 ],
                              l2b3_sio_ctag_vld_ccxlff,
                              l2b3_sio_ue_err_ccxlff,
                              l2b0_tcu_mbist_done_ccxlff,
                              l2b0_tcu_mbist_fail_ccxlff,
                              tcu_l2b0_mbist_start_ccxlff,
                              l2b1_tcu_mbist_done_ccxlff,
                              l2b1_tcu_mbist_fail_ccxlff,
                              tcu_l2b1_mbist_start_ccxlff,
                              l2b2_tcu_mbist_done_ccxlff,
                              l2b2_tcu_mbist_fail_ccxlff,
                              tcu_l2b2_mbist_start_ccxlff,
                              l2b3_tcu_mbist_done_ccxlff,
                              l2b3_tcu_mbist_fail_ccxlff,
                              tcu_l2b3_mbist_start_ccxlff
                             }
                            ),
  .ccx_rstg_in              (
                             {'0
							  5'b0,
                              sii_l2b5_ecc[ 6 : 5 ],
                              4'b0,
                              sii_l2b5_ecc[ 4 : 3 ],
                              4'b0,
                              sii_l2b5_ecc[ 2 : 1 ],
                              4'b0,
                              sii_l2b5_ecc[ 0 ],
                              4'b0,
                              sii_dbg1_l2t0_req[ 1 : 0 ],
                              4'b0,
                              sii_dbg1_l2t1_req[ 1 : 0 ],
                              4'b0,
                              sii_dbg1_l2t2_req[ 1 : 0 ],
                              4'b0,
                              sii_dbg1_l2t3_req[ 1 : 0 ],
                              4'b0,
                              sii_dbg1_l2t4_req[ 1 : 0 ],
                              4'b0,
                              sii_dbg1_l2t5_req[ 1 : 0 ],
                              4'b0,
                              sii_dbg1_l2t6_req[ 1 : 0 ],
                              4'b0,
                              sii_dbg1_l2t7_req[ 1 : 0 ],
                              13'b0,
                              sii_tcu_mbist_done[ 1 : 0 ],
                              4'b0,
                              sii_tcu_mbist_fail[ 1 : 0 ],
                              4'b0,
                              tcu_sii_mbist_start[ 1 : 0 ],
                              4'b0,
                              tcu_sii_data,
                              tcu_sii_vld,
                              13'b0,
                              sii_l2b6_ecc[  0  ],
                              4'b0,
                              sii_l2b6_ecc[  2  :  1  ],
                              4'b0,
                              sii_l2b6_ecc[  4  :  3  ],
                              4'b0,
                              sii_l2b6_ecc[  6  :  5  ],
                              4'b0,
                              sii_l2b7_ecc[  0  ],
                              4'b0,
                              sii_l2b7_ecc[  2  :  1  ],
                              4'b0,
                              sii_l2b7_ecc[  4  :  3  ],
                              4'b0,
                              sii_l2b7_ecc[  6  :  5  ]
                             }
                            ),
  .ccx_rstg_out             (
                             {ccx_rstg_out_unconnected[ 159 : 155 ],
                              sii_l2b5_ecc_ccxrff[ 6 : 5 ],
                              ccx_rstg_out_unconnected[ 152 : 149 ],
                              sii_l2b5_ecc_ccxrff[ 4 : 3 ],
                              ccx_rstg_out_unconnected[ 146 : 143 ],
                              sii_l2b5_ecc_ccxrff[ 2 : 1 ],
                              ccx_rstg_out_unconnected[ 140 : 137 ],
                              sii_l2b5_ecc_ccxrff[ 0 ],
                              ccx_rstg_out_unconnected[ 135 : 132 ],
                              sii_dbg1_l2t0_req_ccxrff[ 1 : 0 ],
                              ccx_rstg_out_unconnected[ 129 : 126 ],
                              sii_dbg1_l2t1_req_ccxrff[ 1 : 0 ],
                              ccx_rstg_out_unconnected[ 123 : 120 ],
                              sii_dbg1_l2t2_req_ccxrff[ 1 : 0 ],
                              ccx_rstg_out_unconnected[ 117 : 114 ],
                              sii_dbg1_l2t3_req_ccxrff[ 1 : 0 ],
                              ccx_rstg_out_unconnected[ 111 : 108 ],
                              sii_dbg1_l2t4_req_ccxrff[ 1 : 0 ],
                              ccx_rstg_out_unconnected[ 105 : 102 ],
                              sii_dbg1_l2t5_req_ccxrff[ 1 : 0 ],
                              ccx_rstg_out_unconnected[ 99 : 96 ],
                              sii_dbg1_l2t6_req_ccxrff[ 1 : 0 ],
                              ccx_rstg_out_unconnected[ 93 : 90 ],
                              sii_dbg1_l2t7_req_ccxrff[ 1 : 0 ],
                              ccx_rstg_out_unconnected[ 87 : 75 ],
                              sii_tcu_mbist_done_ccxrff_1,
                              sii_tcu_mbist_done_ccxrff_0,
                              ccx_rstg_out_unconnected[ 72 : 69 ],
                              sii_tcu_mbist_fail_ccxrff_1,
                              sii_tcu_mbist_fail_ccxrff_0,
                              ccx_rstg_out_unconnected[ 66 : 63 ],
                              tcu_sii_mbist_start_ccxrff_1,
                              tcu_sii_mbist_start_ccxrff_0,
                              ccx_rstg_out_unconnected[ 60 : 57 ],
                              tcu_sii_data_ccxrff,
                              tcu_sii_vld_ccxrff,
                              ccx_rstg_out_unconnected[ 54 : 42 ],
                              sii_l2b6_ecc_ccxrff[ 0 ],
                              ccx_rstg_out_unconnected[ 40 : 37 ],
                              sii_l2b6_ecc_ccxrff[ 2  :  1 ],
                              ccx_rstg_out_unconnected[ 34 : 31 ],
                              sii_l2b6_ecc_ccxrff[ 4 : 3 ],
                              ccx_rstg_out_unconnected[ 28 : 25 ],
                              sii_l2b6_ecc_ccxrff[ 6 : 5 ],
                              ccx_rstg_out_unconnected[ 22 : 19 ],
                              sii_l2b7_ecc_ccxrff[ 0 ],
                              ccx_rstg_out_unconnected[ 17 : 14 ],
                              sii_l2b7_ecc_ccxrff[ 2 : 1 ],
                              ccx_rstg_out_unconnected[ 11 : 8 ],
                              sii_l2b7_ecc_ccxrff[ 4 : 3 ],
                              ccx_rstg_out_unconnected[ 5 : 2 ],
                              sii_l2b7_ecc_ccxrff[ 6 : 5 ]
                             }
                            ),
  .cpu_rep0_in              (192'b0                      ),
  .cpu_rep0_out             (cpu_rep0_out_unconnected[ 191 : 0 ]),
  .cpu_rep1_in              (192'b0                      ),
  .cpu_rep1_out             (cpu_rep1_out_unconnected[ 191 : 0 ]),
  .cmp_gclk_c2_ccx_left(cmp_gclk_c2_ccx_left),
  .cmp_gclk_c2_ccx_right(cmp_gclk_c2_ccx_right),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_scan_en(tcu_scan_en),
  .cluster_arst_l(cluster_arst_l),
  .tcu_atpg_mode(tcu_atpg_mode),
  .spc0_pcx_data_pa(spc0_pcx_data_pa[129:0]),
  .spc0_pcx_req_pq(spc0_pcx_req_pq[8:0]),
  .spc0_pcx_atm_pq(spc0_pcx_atm_pq[8:0]),
  .spc1_pcx_data_pa(spc1_pcx_data_pa[129:0]),
  .spc1_pcx_req_pq(spc1_pcx_req_pq[8:0]),
  .spc1_pcx_atm_pq(spc1_pcx_atm_pq[8:0]),
  .spc2_pcx_data_pa(spc2_pcx_data_pa[129:0]),
  .spc2_pcx_req_pq(spc2_pcx_req_pq[8:0]),
  .spc2_pcx_atm_pq(spc2_pcx_atm_pq[8:0]),
  .spc3_pcx_data_pa(spc3_pcx_data_pa[129:0]),
  .spc3_pcx_req_pq(spc3_pcx_req_pq[8:0]),
  .spc3_pcx_atm_pq(spc3_pcx_atm_pq[8:0]),
  .spc4_pcx_data_pa(spc4_pcx_data_pa[129:0]),
  .spc4_pcx_req_pq(spc4_pcx_req_pq[8:0]),
  .spc4_pcx_atm_pq(spc4_pcx_atm_pq[8:0]),
  .spc5_pcx_data_pa(spc5_pcx_data_pa[129:0]),
  .spc5_pcx_req_pq(spc5_pcx_req_pq[8:0]),
  .spc5_pcx_atm_pq(spc5_pcx_atm_pq[8:0]),
  .spc6_pcx_data_pa(spc6_pcx_data_pa[129:0]),
  .spc6_pcx_req_pq(spc6_pcx_req_pq[8:0]),
  .spc6_pcx_atm_pq(spc6_pcx_atm_pq[8:0]),
  .spc7_pcx_data_pa(spc7_pcx_data_pa[129:0]),
  .spc7_pcx_req_pq(spc7_pcx_req_pq[8:0]),
  .spc7_pcx_atm_pq(spc7_pcx_atm_pq[8:0]),
  .sctag0_pcx_stall_pq(sctag0_pcx_stall_pq),
  .sctag1_pcx_stall_pq(sctag1_pcx_stall_pq),
  .sctag2_pcx_stall_pq(sctag2_pcx_stall_pq),
  .sctag3_pcx_stall_pq(sctag3_pcx_stall_pq),
  .sctag4_pcx_stall_pq(sctag4_pcx_stall_pq),
  .sctag5_pcx_stall_pq(sctag5_pcx_stall_pq),
  .sctag6_pcx_stall_pq(sctag6_pcx_stall_pq),
  .sctag7_pcx_stall_pq(sctag7_pcx_stall_pq),
  .pcx_spc0_grant_px(pcx_spc0_grant_px[8:0]),
  .pcx_spc1_grant_px(pcx_spc1_grant_px[8:0]),
  .pcx_spc2_grant_px(pcx_spc2_grant_px[8:0]),
  .pcx_spc3_grant_px(pcx_spc3_grant_px[8:0]),
  .pcx_spc4_grant_px(pcx_spc4_grant_px[8:0]),
  .pcx_spc5_grant_px(pcx_spc5_grant_px[8:0]),
  .pcx_spc6_grant_px(pcx_spc6_grant_px[8:0]),
  .pcx_spc7_grant_px(pcx_spc7_grant_px[8:0]),
  .pcx_sctag0_atm_px1(pcx_sctag0_atm_px1),
  .pcx_sctag0_data_px2(pcx_sctag0_data_px2[129:0]),
  .pcx_sctag0_data_rdy_px1(pcx_sctag0_data_rdy_px1),
  .pcx_sctag1_atm_px1(pcx_sctag1_atm_px1),
  .pcx_sctag1_data_px2(pcx_sctag1_data_px2[129:0]),
  .pcx_sctag1_data_rdy_px1(pcx_sctag1_data_rdy_px1),
  .pcx_sctag2_atm_px1(pcx_sctag2_atm_px1),
  .pcx_sctag2_data_px2(pcx_sctag2_data_px2[129:0]),
  .pcx_sctag2_data_rdy_px1(pcx_sctag2_data_rdy_px1),
  .pcx_sctag3_atm_px1(pcx_sctag3_atm_px1),
  .pcx_sctag3_data_px2(pcx_sctag3_data_px2[129:0]),
  .pcx_sctag3_data_rdy_px1(pcx_sctag3_data_rdy_px1),
  .pcx_sctag4_atm_px1(pcx_sctag4_atm_px1),
  .pcx_sctag4_data_px2(pcx_sctag4_data_px2[129:0]),
  .pcx_sctag4_data_rdy_px1(pcx_sctag4_data_rdy_px1),
  .pcx_sctag5_atm_px1(pcx_sctag5_atm_px1),
  .pcx_sctag5_data_px2(pcx_sctag5_data_px2[129:0]),
  .pcx_sctag5_data_rdy_px1(pcx_sctag5_data_rdy_px1),
  .pcx_sctag6_atm_px1(pcx_sctag6_atm_px1),
  .pcx_sctag6_data_px2(pcx_sctag6_data_px2[129:0]),
  .pcx_sctag6_data_rdy_px1(pcx_sctag6_data_rdy_px1),
  .pcx_sctag7_atm_px1(pcx_sctag7_atm_px1),
  .pcx_sctag7_data_px2(pcx_sctag7_data_px2[129:0]),
  .pcx_sctag7_data_rdy_px1(pcx_sctag7_data_rdy_px1),
  .sctag0_cpx_atom_cq(sctag0_cpx_atom_cq),
  .sctag0_cpx_req_cq(sctag0_cpx_req_cq[7:0]),
  .sctag1_cpx_atom_cq(sctag1_cpx_atom_cq),
  .sctag1_cpx_req_cq(sctag1_cpx_req_cq[7:0]),
  .sctag2_cpx_atom_cq(sctag2_cpx_atom_cq),
  .sctag2_cpx_req_cq(sctag2_cpx_req_cq[7:0]),
  .sctag3_cpx_atom_cq(sctag3_cpx_atom_cq),
  .sctag3_cpx_req_cq(sctag3_cpx_req_cq[7:0]),
  .sctag4_cpx_atom_cq(sctag4_cpx_atom_cq),
  .sctag4_cpx_req_cq(sctag4_cpx_req_cq[7:0]),
  .sctag5_cpx_atom_cq(sctag5_cpx_atom_cq),
  .sctag5_cpx_req_cq(sctag5_cpx_req_cq[7:0]),
  .sctag6_cpx_atom_cq(sctag6_cpx_atom_cq),
  .sctag6_cpx_req_cq(sctag6_cpx_req_cq[7:0]),
  .sctag7_cpx_atom_cq(sctag7_cpx_atom_cq),
  .sctag7_cpx_req_cq(sctag7_cpx_req_cq[7:0]),
  .cpx_sctag0_grant_cx(cpx_sctag0_grant_cx[7:0]),
  .cpx_sctag1_grant_cx(cpx_sctag1_grant_cx[7:0]),
  .cpx_sctag2_grant_cx(cpx_sctag2_grant_cx[7:0]),
  .cpx_sctag3_grant_cx(cpx_sctag3_grant_cx[7:0]),
  .cpx_sctag4_grant_cx(cpx_sctag4_grant_cx[7:0]),
  .cpx_sctag5_grant_cx(cpx_sctag5_grant_cx[7:0]),
  .cpx_sctag6_grant_cx(cpx_sctag6_grant_cx[7:0]),
  .cpx_sctag7_grant_cx(cpx_sctag7_grant_cx[7:0]),
  .cpx_spc0_data_cx2(cpx_spc0_data_cx2[145:0]),
  .cpx_spc1_data_cx2(cpx_spc1_data_cx2[145:0]),
  .cpx_spc2_data_cx2(cpx_spc2_data_cx2[145:0]),
  .cpx_spc3_data_cx2(cpx_spc3_data_cx2[145:0]),
  .cpx_spc4_data_cx2(cpx_spc4_data_cx2[145:0]),
  .cpx_spc5_data_cx2(cpx_spc5_data_cx2[145:0]),
  .cpx_spc6_data_cx2(cpx_spc6_data_cx2[145:0]),
  .cpx_spc7_data_cx2(cpx_spc7_data_cx2[145:0])
        );
//________________________________________________________________

*/

/*

n2_l2d_sp_512kb_cust l2d0(

  .l2b_l2d_en_fill_clk_v0         (1'b1),
  .l2b_l2d_en_fill_clk_v1         (1'b1),
  .l2t_l2d_en_fill_clk_ov         (1'b1),
  .l2t_l2d_pwrsav_ov          (1'b1),
  .vnw_ary0                       (L2D_VNW0[ 0 ]),
  .vnw_ary1                       (L2D_VNW1[ 0 ]),
  .gclk                        ( cmp_gclk_c3_l2d0 ), // cmp_gclk_c0_r[0]            ),  
  .tcu_clk_stop ( gl_l2d0_clk_stop ),	// staged clk_stop
  .tcu_aclk			(tcu_aclk),
  .tcu_bclk			(tcu_bclk),
  .l2t_l2d_way_sel_c2             (l2t0_l2d0_way_sel_c2[ 15 : 0 ]),   
  .l2t_l2d_col_offset_c2          (l2t0_l2d0_col_offset_c2[ 3 : 0 ]),     
  .l2t_l2d_fb_hit_c3              (l2t0_l2d0_fb_hit_c3),
  .l2t_l2d_fbrd_c3                (l2t0_l2d0_fbrd_c3),
  .l2t_l2d_rd_wr_c2               (l2t0_l2d0_rd_wr_c2),
  .l2t_l2d_set_c2                 (l2t0_l2d0_set_c2[ 8 : 0 ]),
  .l2t_l2d_word_en_c2             (l2t0_l2d0_word_en_c2[ 15 : 0 ]),
  .l2t_l2d_stdecc_c2              (l2t0_l2d0_stdecc_c2[ 77 : 0 ]),
  .l2b_l2d_fbdecc_c4              (l2b0_l2d0_fbdecc_c4[ 623 : 0 ]),
  .rst_por_                 	  ( gl_l2_por_c3t0 ), // ( gl_l2_por_c3t ),  - for int6.1
  .rst_wmr_                 	  ( gl_l2_wmr_c3t0 ), // ( gl_l2_wmr_c3t ),  - for int6.1
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .tcu_ce                         (1'b1),
  .tcu_se_scancollar_in           (tcu_se_scancollar_in),
  .tcu_se_scancollar_out          (tcu_se_scancollar_out),
  .tcu_array_wr_inhibit           (tcu_array_wr_inhibit),
  .scan_in                        (l2t1_scan_out          ),
  .l2b_l2d_fuse_l2d_data_in       (l2b0_l2d0_rvalue[ 9 : 0 ]),
  .l2b_l2d_fuse_rid               (l2b0_l2d0_rid[ 6 : 0 ]),
  .l2b_l2d_fuse_l2d_wren          (l2b0_l2d0_wr_en),
  .l2b_l2d_fuse_reset             (l2b0_l2d0_fuse_clr),
  .l2d_l2b_efc_fuse_data          (l2d0_l2b0_fuse_data[ 9 : 0 ]),   
  .scan_out                       (l2d0_scan_out),                          
  .l2d_l2b_decc_out_c7            (l2d0_l2b0_decc_out_c7[ 623 : 0 ]),
  .l2d_l2t_decc_c6                (l2d0_l2t0_decc_c6[ 155 : 0 ]),
  .tcu_scan_en(tcu_scan_en),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_atpg_mode(tcu_atpg_mode)
);

//________________________________________________________________


n2_l2d_sp_512kb_cust l2d1(

  .l2b_l2d_en_fill_clk_v0         (1'b1),
  .l2b_l2d_en_fill_clk_v1         (1'b1),
  .l2t_l2d_en_fill_clk_ov         (1'b1),
  .l2t_l2d_pwrsav_ov          (1'b1),
  .vnw_ary0                       (L2D_VNW0[ 1 ]),
  .vnw_ary1                       (L2D_VNW1[ 1 ]),
  .gclk		( cmp_gclk_c3_l2d1 ), // cmp_gclk_c0_r[1]),  
  .tcu_clk_stop ( gl_l2d1_clk_stop ),	// staged clk_stop
  .tcu_aclk		(tcu_aclk),
  .tcu_bclk		(tcu_bclk),
  .tcu_ce                   (1'b1                        ),
  .tcu_se_scancollar_in     (tcu_se_scancollar_in),
  .tcu_se_scancollar_out    (tcu_se_scancollar_out),
  .tcu_array_wr_inhibit     (tcu_array_wr_inhibit),
  .scan_in                  (l2d0_scan_out               ),
  .scan_out                 (l2d1_scan_out),
  .l2b_l2d_fbdecc_c4        (l2b1_l2d1_fbdecc_c4[ 623 : 0 ]  ),// scdata
  .rst_por_                 ( gl_l2_por_c3t ), 
  .rst_wmr_                 ( gl_l2_wmr_c3t ), 
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_col_offset_c2    (l2t1_l2d1_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_fb_hit_c3        (l2t1_l2d1_fb_hit_c3         ),
  .l2t_l2d_fbrd_c3          (l2t1_l2d1_fbrd_c3           ),
  .l2t_l2d_rd_wr_c2         (l2t1_l2d1_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t1_l2d1_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_stdecc_c2        (l2t1_l2d1_stdecc_c2[ 77 : 0 ]   ),
  .l2t_l2d_way_sel_c2       (l2t1_l2d1_way_sel_c2[ 15 : 0 ]  ),
  .l2t_l2d_word_en_c2       (l2t1_l2d1_word_en_c2[ 15 : 0 ]  ),
  .l2b_l2d_fuse_l2d_data_in (l2b1_l2d1_rvalue[ 9 : 0 ]),
  .l2b_l2d_fuse_rid         (l2b1_l2d1_rid[ 6 : 0 ]),
  .l2b_l2d_fuse_l2d_wren    (l2b1_l2d1_wr_en),
  .l2b_l2d_fuse_reset       (l2b1_l2d1_fuse_clr),
  .l2d_l2b_efc_fuse_data    (l2d1_l2b1_fuse_data[ 9 : 0 ]),     
  .l2d_l2b_decc_out_c7      (l2d1_l2b1_decc_out_c7[ 623 : 0 ]),
  .l2d_l2t_decc_c6          (l2d1_l2t1_decc_c6[ 155 : 0 ]    ),
  .tcu_scan_en(tcu_scan_en),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_atpg_mode(tcu_atpg_mode)
        );
//________________________________________________________________

n2_l2d_sp_512kb_cust l2d2(

  .l2b_l2d_en_fill_clk_v0         (1'b1),
  .l2b_l2d_en_fill_clk_v1         (1'b1),
  .l2t_l2d_en_fill_clk_ov         (1'b1),
  .l2t_l2d_pwrsav_ov          (1'b1),
  .vnw_ary0                       (L2D_VNW0[ 2 ]),
  .vnw_ary1                       (L2D_VNW1[ 2 ]),
  .gclk		( cmp_gclk_c3_l2d2 ), // cmp_gclk_c3_r[4]  ),  
  .tcu_clk_stop ( gl_l2d2_clk_stop ),	// staged clk_stop
  .tcu_aclk		(tcu_aclk),
  .tcu_bclk		(tcu_bclk),
  .tcu_ce                   (1'b1                        ),
  .tcu_se_scancollar_in     (tcu_se_scancollar_in),
  .tcu_se_scancollar_out    (tcu_se_scancollar_out),
  .tcu_array_wr_inhibit     (tcu_array_wr_inhibit),
  .scan_in                  (l2t3_scan_out               ),
  .scan_out                 (l2d2_scan_out),
  .l2b_l2d_fbdecc_c4        (l2b2_l2d2_fbdecc_c4[ 623 : 0 ]  ),// scdata
  .rst_por_                 ( gl_l2_por_c3b0 ), 	// ECO c3t0 -> c3b0 - mh157021
  .rst_wmr_                 ( gl_l2_wmr_c3b ), 		// ECO c3t0 -> c3b  - mh157021
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_col_offset_c2    (l2t2_l2d2_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_fb_hit_c3        (l2t2_l2d2_fb_hit_c3         ),
  .l2t_l2d_fbrd_c3          (l2t2_l2d2_fbrd_c3           ),
  .l2t_l2d_rd_wr_c2         (l2t2_l2d2_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t2_l2d2_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_stdecc_c2        (l2t2_l2d2_stdecc_c2[ 77 : 0 ]   ),
  .l2t_l2d_way_sel_c2       (l2t2_l2d2_way_sel_c2[ 15 : 0 ]  ),
  .l2t_l2d_word_en_c2       (l2t2_l2d2_word_en_c2[ 15 : 0 ]  ),
  .l2d_l2b_decc_out_c7      (l2d2_l2b2_decc_out_c7[ 623 : 0 ]),
  .l2d_l2t_decc_c6          (l2d2_l2t2_decc_c6[ 155 : 0 ]    ),
  .l2b_l2d_fuse_l2d_data_in (l2b2_l2d2_rvalue[ 9 : 0 ]),
  .l2b_l2d_fuse_rid         (l2b2_l2d2_rid[ 6 : 0 ]),
  .l2b_l2d_fuse_l2d_wren    (l2b2_l2d2_wr_en),
  .l2b_l2d_fuse_reset       (l2b2_l2d2_fuse_clr),
  .l2d_l2b_efc_fuse_data    (l2d2_l2b2_fuse_data[ 9 : 0 ]),
  .tcu_scan_en(tcu_scan_en),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_atpg_mode(tcu_atpg_mode)     
        );
//________________________________________________________________

 n2_l2d_sp_512kb_cust l2d3(

  .l2b_l2d_en_fill_clk_v0         (1'b1),
  .l2b_l2d_en_fill_clk_v1         (1'b1),
  .l2t_l2d_en_fill_clk_ov         (1'b1),
  .l2t_l2d_pwrsav_ov          (1'b1),
  .vnw_ary0                       (L2D_VNW0[ 3 ]),
  .vnw_ary1                       (L2D_VNW1[ 3 ]),
  .gclk		( cmp_gclk_c3_l2d3 ), // cmp_gclk_c1_r[5]),  
  .tcu_clk_stop ( gl_l2d3_clk_stop ),	// staged clk_stop
  .tcu_aclk		(tcu_aclk),
  .tcu_bclk		(tcu_bclk),
  .scan_in                  (l2d2_scan_out               ),
  .scan_out                 (l2d3_scan_out),
  .tcu_ce                   (1'b1                        ),
  .tcu_se_scancollar_in     (tcu_se_scancollar_in),
  .tcu_se_scancollar_out    (tcu_se_scancollar_out),
  .tcu_array_wr_inhibit     (tcu_array_wr_inhibit),
  .l2b_l2d_fuse_l2d_data_in (l2b3_l2d3_rvalue[ 9 : 0 ]),
  .l2b_l2d_fuse_rid         (l2b3_l2d3_rid[ 6 : 0 ]),
  .l2b_l2d_fuse_l2d_wren    (l2b3_l2d3_wr_en),
  .l2b_l2d_fuse_reset       (l2b3_l2d3_fuse_clr),
  .l2d_l2b_efc_fuse_data    (l2d3_l2b3_fuse_data[ 9 : 0 ]),     
  .l2b_l2d_fbdecc_c4        (l2b3_l2d3_fbdecc_c4[ 623 : 0 ]  ),// scdata
  .rst_por_                 ( gl_l2_por_c3b0 ), 	// ECO c3t0 -> c3b0 -mh157021
  .rst_wmr_                 ( gl_l2_wmr_c3b ), 		// ECO c3t0 -> c3b -mh157021
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_col_offset_c2    (l2t3_l2d3_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_fb_hit_c3        (l2t3_l2d3_fb_hit_c3         ),
  .l2t_l2d_fbrd_c3          (l2t3_l2d3_fbrd_c3           ),
  .l2t_l2d_rd_wr_c2         (l2t3_l2d3_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t3_l2d3_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_stdecc_c2        (l2t3_l2d3_stdecc_c2[ 77 : 0 ]   ),
  .l2t_l2d_way_sel_c2       (l2t3_l2d3_way_sel_c2[ 15 : 0 ]  ),
  .l2t_l2d_word_en_c2       (l2t3_l2d3_word_en_c2[ 15 : 0 ]  ),
  .l2d_l2b_decc_out_c7      (l2d3_l2b3_decc_out_c7[ 623 : 0 ]),
  .l2d_l2t_decc_c6          (l2d3_l2t3_decc_c6[ 155 : 0 ]    ),
  .tcu_scan_en(tcu_scan_en),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_atpg_mode(tcu_atpg_mode)
        );
//________________________________________________________________

n2_l2d_sp_512kb_cust l2d4(

  .l2b_l2d_en_fill_clk_v0         (1'b1),
  .l2b_l2d_en_fill_clk_v1         (1'b1),
  .l2t_l2d_en_fill_clk_ov         (1'b1),
  .l2t_l2d_pwrsav_ov          (1'b1),
  .vnw_ary0                       (L2D_VNW0[ 4 ]),
  .vnw_ary1                       (L2D_VNW1[ 4 ]),
  .gclk		( cmp_gclk_c1_l2d4 ), // cmp_gclk_c3_r[0]),  
  .tcu_clk_stop ( gl_l2d4_clk_stop ),	// staged clk_stop
  .tcu_aclk		(tcu_aclk),
  .tcu_bclk		(tcu_bclk),
  .scan_in                  (l2t5_scan_out               ),
  .scan_out                 (l2d4_scan_out),
  .tcu_ce                   (1'b1),
  .tcu_se_scancollar_in     (tcu_se_scancollar_in),
  .tcu_se_scancollar_out    (tcu_se_scancollar_out),
  .tcu_array_wr_inhibit     (tcu_array_wr_inhibit),
  .l2b_l2d_fuse_l2d_data_in (l2b4_l2d4_rvalue[ 9 : 0 ]),
  .l2b_l2d_fuse_rid         (l2b4_l2d4_rid[ 6 : 0 ]),
  .l2b_l2d_fuse_l2d_wren    (l2b4_l2d4_wr_en),
  .l2b_l2d_fuse_reset       (l2b4_l2d4_fuse_clr),
  .l2d_l2b_efc_fuse_data    (l2d4_l2b4_fuse_data[ 9 : 0 ]),     
  .l2b_l2d_fbdecc_c4        (l2b4_l2d4_fbdecc_c4[ 623 : 0 ]  ),// scdata
  .rst_por_                 ( gl_l2_por_c1t ), 
  .rst_wmr_                 ( gl_l2_wmr_c1t ), 
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_col_offset_c2    (l2t4_l2d4_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_fb_hit_c3        (l2t4_l2d4_fb_hit_c3         ),
  .l2t_l2d_fbrd_c3          (l2t4_l2d4_fbrd_c3           ),
  .l2t_l2d_rd_wr_c2         (l2t4_l2d4_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t4_l2d4_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_stdecc_c2        (l2t4_l2d4_stdecc_c2[ 77 : 0 ]   ),
  .l2t_l2d_way_sel_c2       (l2t4_l2d4_way_sel_c2[ 15 : 0 ]  ),
  .l2t_l2d_word_en_c2       (l2t4_l2d4_word_en_c2[ 15 : 0 ]  ),
  .l2d_l2b_decc_out_c7      (l2d4_l2b4_decc_out_c7[ 623 : 0 ]),
  .l2d_l2t_decc_c6          (l2d4_l2t4_decc_c6[ 155 : 0 ]    ),
  .tcu_scan_en(tcu_scan_en),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_atpg_mode(tcu_atpg_mode)
        );
//________________________________________________________________

n2_l2d_sp_512kb_cust l2d5(

  .l2b_l2d_en_fill_clk_v0         (1'b1),
  .l2b_l2d_en_fill_clk_v1         (1'b1),
  .l2t_l2d_en_fill_clk_ov         (1'b1),
  .l2t_l2d_pwrsav_ov          (1'b1),
  .vnw_ary0                       (L2D_VNW0[ 5 ]),
  .vnw_ary1                       (L2D_VNW1[ 5 ]),
  .gclk				( cmp_gclk_c1_l2d5 ), // cmp_gclk_c3_r[1]),  
  .tcu_clk_stop ( gl_l2d5_clk_stop ),	// staged clk_stop
  .tcu_aclk			(tcu_aclk),
  .tcu_bclk			(tcu_bclk),
  .tcu_ce                   (1'b1                        ),
  .tcu_se_scancollar_in     (tcu_se_scancollar_in),
  .tcu_se_scancollar_out    (tcu_se_scancollar_out),
  .tcu_array_wr_inhibit     (tcu_array_wr_inhibit),
  .scan_in                  (l2d4_scan_out               ),
  .scan_out                 (l2d5_scan_out),
  .l2b_l2d_fbdecc_c4        (l2b5_l2d5_fbdecc_c4[ 623 : 0 ]  ),// scdata
  .rst_por_                 ( gl_l2_por_c1t ), 
  .rst_wmr_                 ( gl_l2_wmr_c1t ), 	// ECO c1b -> c1t -mh157021
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_col_offset_c2    (l2t5_l2d5_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_fb_hit_c3        (l2t5_l2d5_fb_hit_c3         ),
  .l2t_l2d_fbrd_c3          (l2t5_l2d5_fbrd_c3           ),
  .l2t_l2d_rd_wr_c2         (l2t5_l2d5_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t5_l2d5_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_stdecc_c2        (l2t5_l2d5_stdecc_c2[ 77 : 0 ]   ),
  .l2t_l2d_way_sel_c2       (l2t5_l2d5_way_sel_c2[ 15 : 0 ]  ),
  .l2t_l2d_word_en_c2       (l2t5_l2d5_word_en_c2[ 15 : 0 ]  ),
  .l2b_l2d_fuse_l2d_data_in (l2b5_l2d5_rvalue[ 9 : 0 ]),
  .l2b_l2d_fuse_rid         (l2b5_l2d5_rid[ 6 : 0 ]),
  .l2b_l2d_fuse_l2d_wren    (l2b5_l2d5_wr_en),
  .l2b_l2d_fuse_reset       (l2b5_l2d5_fuse_clr),
  .l2d_l2b_efc_fuse_data    (l2d5_l2b5_fuse_data[ 9 : 0 ]),     
  .l2d_l2b_decc_out_c7      (l2d5_l2b5_decc_out_c7[ 623 : 0 ]),
  .l2d_l2t_decc_c6          (l2d5_l2t5_decc_c6[ 155 : 0 ]    ),
  .tcu_scan_en(tcu_scan_en),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_atpg_mode(tcu_atpg_mode)
        );
//________________________________________________________________

n2_l2d_sp_512kb_cust l2d6(

  .l2b_l2d_en_fill_clk_v0         (1'b1),
  .l2b_l2d_en_fill_clk_v1         (1'b1),
  .l2t_l2d_en_fill_clk_ov         (1'b1),
  .l2t_l2d_pwrsav_ov          (1'b1),
  .vnw_ary0                       (L2D_VNW0[ 6 ]),
  .vnw_ary1                       (L2D_VNW1[ 6 ]),
  .gclk		( cmp_gclk_c1_l2d6 ), // cmp_gclk_c3_r[4]),  
  .tcu_clk_stop ( gl_l2d6_clk_stop ),	// staged clk_stop
  .tcu_aclk		(tcu_aclk),
  .tcu_bclk		(tcu_bclk),
  .tcu_ce                   (1'b1                        ),
  .tcu_se_scancollar_in     (tcu_se_scancollar_in),
  .tcu_se_scancollar_out    (tcu_se_scancollar_out),
  .tcu_array_wr_inhibit     (tcu_array_wr_inhibit),
  .scan_in                  (l2t7_scan_out               ),
  .scan_out                 (l2d6_scan_out),
  .l2b_l2d_fuse_l2d_data_in (l2b6_l2d6_rvalue[ 9 : 0 ]),
  .l2b_l2d_fuse_rid         (l2b6_l2d6_rid[ 6 : 0 ]),
  .l2b_l2d_fuse_l2d_wren    (l2b6_l2d6_wr_en),
  .l2b_l2d_fuse_reset       (l2b6_l2d6_fuse_clr),
  .l2d_l2b_efc_fuse_data    (l2d6_l2b6_fuse_data[ 9 : 0 ]),     
  .l2b_l2d_fbdecc_c4        (l2b6_l2d6_fbdecc_c4[ 623 : 0 ]  ),// scdata
  .rst_por_                 ( gl_l2_por_c1b ), // ECO c1t -> c1b - mh157021
  .rst_wmr_                 ( gl_l2_wmr_c1b ), 
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_col_offset_c2    (l2t6_l2d6_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_fb_hit_c3        (l2t6_l2d6_fb_hit_c3         ),
  .l2t_l2d_fbrd_c3          (l2t6_l2d6_fbrd_c3           ),
  .l2t_l2d_rd_wr_c2         (l2t6_l2d6_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t6_l2d6_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_stdecc_c2        (l2t6_l2d6_stdecc_c2[ 77 : 0 ]   ),
  .l2t_l2d_way_sel_c2       (l2t6_l2d6_way_sel_c2[ 15 : 0 ]  ),
  .l2t_l2d_word_en_c2       (l2t6_l2d6_word_en_c2[ 15 : 0 ]  ),
  .l2d_l2b_decc_out_c7      (l2d6_l2b6_decc_out_c7[ 623 : 0 ]),
  .l2d_l2t_decc_c6          (l2d6_l2t6_decc_c6[ 155 : 0 ]    ),
  .tcu_scan_en(tcu_scan_en),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_atpg_mode(tcu_atpg_mode)
  );
//________________________________________________________________

n2_l2d_sp_512kb_cust l2d7(

  .l2b_l2d_en_fill_clk_v0         (1'b1),
  .l2b_l2d_en_fill_clk_v1         (1'b1),
  .l2t_l2d_en_fill_clk_ov         (1'b1),
  .l2t_l2d_pwrsav_ov          (1'b1),
  .vnw_ary0                       (L2D_VNW0[ 7 ]),
  .vnw_ary1                       (L2D_VNW1[ 7 ]),
  .gclk				( cmp_gclk_c1_l2d7 ), // cmp_gclk_c3_r[5]),  
  .tcu_clk_stop ( gl_l2d7_clk_stop ),	// staged clk_stop
  .tcu_aclk			(tcu_aclk),
  .tcu_bclk			(tcu_bclk),
  .tcu_ce                   (1'b1                        ),
  .tcu_se_scancollar_in     (tcu_se_scancollar_in),
  .tcu_se_scancollar_out    (tcu_se_scancollar_out),
  .tcu_array_wr_inhibit     (tcu_array_wr_inhibit),
  .scan_in                  (l2d6_scan_out               ),
  .scan_out                 (l2d7_scan_out),
  .l2b_l2d_fuse_l2d_data_in (l2b7_l2d7_rvalue[ 9 : 0 ]),
  .l2b_l2d_fuse_rid         (l2b7_l2d7_rid[ 6 : 0 ]),
  .l2b_l2d_fuse_l2d_wren    (l2b7_l2d7_wr_en),
  .l2b_l2d_fuse_reset       (l2b7_l2d7_fuse_clr),
  .l2d_l2b_efc_fuse_data    (l2d7_l2b7_fuse_data[ 9 : 0 ]),     
  .l2b_l2d_fbdecc_c4        (l2b7_l2d7_fbdecc_c4[ 623 : 0 ]  ),// scdata
  .rst_por_                 ( gl_l2_por_c1b ), // ECO c1t -> c1b - mh157021
  .rst_wmr_                 ( gl_l2_wmr_c1b ), 
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_col_offset_c2    (l2t7_l2d7_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_fb_hit_c3        (l2t7_l2d7_fb_hit_c3         ),
  .l2t_l2d_fbrd_c3          (l2t7_l2d7_fbrd_c3           ),
  .l2t_l2d_rd_wr_c2         (l2t7_l2d7_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t7_l2d7_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_stdecc_c2        (l2t7_l2d7_stdecc_c2[ 77 : 0 ]   ),
  .l2t_l2d_way_sel_c2       (l2t7_l2d7_way_sel_c2[ 15 : 0 ]  ),
  .l2t_l2d_word_en_c2       (l2t7_l2d7_word_en_c2[ 15 : 0 ]  ),
  .l2d_l2b_decc_out_c7      (l2d7_l2b7_decc_out_c7[ 623 : 0 ]),
  .l2d_l2t_decc_c6          (l2d7_l2t7_decc_c6[ 155 : 0 ]    ),
  .tcu_scan_en(tcu_scan_en),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_atpg_mode(tcu_atpg_mode)
        );
//________________________________________________________________

*/

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
                             l2b0_sio_parity_t0rff[ 1 : 0 ],
                             unconnectedt0rff[ 78 : 0 ]
                             }
                            ),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (39'b0                       ), 
  .l2t_tcu_dmo_out          (l2t0_dmo_dout[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (1'b0                        ),
  .tcu_l2t_tag_or_data_sel  (dmo_tagmuxctl               ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3t ),
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3t ),
  .l2t_dbg_sii_iq_dequeue   (l2t0_dbg0_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t0_dbg0_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t0_dbg0_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t0_dbg0_err_event		 ),
  .l2t_dbg_pa_match	    (l2t0_dbg0_pa_match		 ),
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
  .mcu_l2t_chunk_id_r0      (mcu0_l2t0_qword_id_r0[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu0_l2t0_data_vld_r0       ),
  .mcu_l2t_rd_req_id_r0     (mcu0_l2t0_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu0_l2t0_secc_err_r2       ),
  .mcu_l2t_mecc_err_r2      (mcu0_l2t0_mecc_err_r2       ),
  .mcu_l2t_scb_mecc_err     (mcu0_l2t0_scb_mecc_err      ),
  .mcu_l2t_scb_secc_err     (mcu0_l2t0_scb_secc_err      ),
  .sii_l2t_req_vld          (sii_l2t0_req_vld            ),
  .sii_l2t_req              (sii_l2t0_req[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b0_ecc[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t0_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t0_sii_wib_dequeue        ),
  .rst_por_                 ( L2_rst ), 
  .rst_wmr_                 ( ~L2_rst ), 
  .scan_in                  (tcu_soc0_scan_out           ),
  .scan_out                 (l2t0_scan_out               ),
  .efu_l2t_fuse_clr          (efu_l2t0_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t0_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t0246_fuse_data      ),                       
  .l2t_efu_fuse_data         (l2t0_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t0_efu_fuse_xfer_en      ),                       
  .tcu_mbist_bisi_en              (tcu_mbist_bisi_en),
  .tcu_l2t_mbist_start            (tcu_l2t0_mbist_start_t1lff),
  .tcu_l2t_mbist_scan_in          (tcu_l2t0_mbist_scan_in),
  .l2t_tcu_mbist_done             (l2t0_tcu_mbist_done),
  .l2t_tcu_mbist_fail             (l2t0_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out         (l2t0_tcu_mbist_scan_out),
  .gclk                      	  ( cmp_gclk_c3_l2t0 ), // cmp_gclk_c1_r[2]            ), 
  .tcu_clk_stop ( gl_l2t0_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t0_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t0_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t0_shscan_clk_stop),
  .vnw_ary                            (L2T_VNW[ 0 ]),
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
  .l2t_rep_out0                       (l2t0_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t0_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t0_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t0_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t0_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t0_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t0_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t0_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t0_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t0_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t0_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t0_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t0_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t0_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t0_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t0_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t0_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t0_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t0_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t0_rep_out19_unused[ 23 : 0 ]),
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

/*

/////// stagging flop

//assign

l2t l2t1(
  .l2t_lstg_in		    (
                             {5'b0,
                              1'b0, tcu_ncu_mbist_start[ 0 ],
                              59'b0,
                              l2t4_sii_iq_dequeue,
                              l2t4_sii_wib_dequeue,
                              l2t5_sii_iq_dequeue,
                              l2t5_sii_wib_dequeue,
                              48'b0,
                              tcu_l2t0_mbist_start,
			      tcu_spc_mbist_start[ 0 ],
			      tcu_ss_request[ 0 ],
			      6'b0,
                              tcu_mcu0_mbist_start,
			      tcu_mcu1_mbist_start,
			      63'b0}
                            ),
  .l2t_rstg_in		    (
                             {77'b0,
                              l2b0_sio_data[ 31 : 0 ],
//                              l2b0_sio_parity[1:0],
                              l2b0_sio_ctag_vld,
                              l2b0_sio_ue_err,
			      25'b0,
                              mcu0_l2t1_rd_ack,
                              mcu0_l2t1_wr_ack,
                              mcu0_l2t1_qword_id_r0[ 1 : 0 ],
                              mcu0_l2t1_data_vld_r0,
                              mcu0_l2t1_rd_req_id_r0[ 2 : 0 ],
                              mcu0_l2t1_secc_err_r2,
                              mcu0_l2t1_mecc_err_r2,
                              mcu0_l2t1_scb_mecc_err,
                              mcu0_l2t1_scb_secc_err,
			      44'b0}
                            ),
  .l2t_lstg_out		    (
                             {unconnectedt1lff[ 191 : 186 ],
                              tcu_ncu_mbist_start_t1lff_0,
                              unconnectedt1lff[  184  :  126  ],
                              l2t4_sii_iq_dequeue_t1lff,
                              l2t4_sii_wib_dequeue_t1lff,
                              l2t5_sii_iq_dequeue_t1lff,
                              l2t5_sii_wib_dequeue_t1lff,
                              unconnectedt1lff[  121  :  74  ],
			      tcu_l2t0_mbist_start_t1lff,
                              tcu_spc0_mbist_start_t1lff_0,
                              tcu_ss_request_t1lff_0,
                              unconnectedt1lff[ 70 : 65 ],
                              tcu_mcu0_mbist_start_t1lff,
                              tcu_mcu1_mbist_start_t1lff,
                              unconnectedt1lff_t1lff[ 62 : 0 ]
                             }
                            ),
  .l2t_rstg_out		   (
                            {unconnectedt1rff[ 191 : 115 ],
			     l2b0_sio_data_t1rff[ 31 : 0 ],
//                             l2b0_sio_parity_t1rff[1:0],
                             l2b0_sio_ctag_vld_t1rff,
                             l2b0_sio_ue_err_t1rff,
			     unconnectedt1rff[ 80 : 56 ],
                             mcu0_l2t1_rd_ack_t1rff,
                             mcu0_l2t1_wr_ack_t1rff,
                             mcu0_l2t1_qword_id_r0_t1rff[ 1 : 0 ],
                             mcu0_l2t1_data_vld_r0_t1rff,
                             mcu0_l2t1_rd_req_id_r0_t1rff[ 2 : 0 ],
                             mcu0_l2t1_secc_err_r2_t1rff,
                             mcu0_l2t1_mecc_err_r2_t1rff,
                             mcu0_l2t1_scb_mecc_err_t1rff,
                             mcu0_l2t1_scb_secc_err_t1rff,
			     unconnectedt1rff[ 43 : 0 ]}
                           ),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (l2t0_dmo_dout[ 38 : 0 ]         ), 
  .l2t_tcu_dmo_out          (l2t1_dmo_dout[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (dmo_l2tsel[ 5 ]               ),
  .tcu_l2t_tag_or_data_sel  (dmo_tagmuxctl               ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c2t ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c2t ),
  .l2t_dbg_sii_iq_dequeue   (l2t1_dbg1_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t1_dbg1_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t1_dbg1_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t1_dbg1_err_event		 ),
  .l2t_dbg_pa_match	    (l2t1_dbg1_pa_match		 ),
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
  .mcu_l2t_rd_ack           (mcu0_l2t1_rd_ack_t1rff            ),
  .mcu_l2t_wr_ack           (mcu0_l2t1_wr_ack_t1rff            ),
  .mcu_l2t_chunk_id_r0      (mcu0_l2t1_qword_id_r0_t1rff[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu0_l2t1_data_vld_r0_t1rff       ),
  .mcu_l2t_rd_req_id_r0     (mcu0_l2t1_rd_req_id_r0_t1rff[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu0_l2t1_secc_err_r2_t1rff       ),
  .mcu_l2t_mecc_err_r2      (mcu0_l2t1_mecc_err_r2_t1rff       ),
  .mcu_l2t_scb_mecc_err     (mcu0_l2t1_scb_mecc_err_t1rff      ),
  .mcu_l2t_scb_secc_err     (mcu0_l2t1_scb_secc_err_t1rff      ),
  .sii_l2t_req_vld          (sii_l2t1_req_vld            ),
  .sii_l2t_req              (sii_l2t1_req[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b1_ecc[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t1_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t1_sii_wib_dequeue        ),
  .scan_out                 (l2t1_scan_out               ),
  .rst_por_                 ( gl_l2_por_c2t ), 
  .rst_wmr_                 ( gl_l2_wmr_c2t ), 
  .scan_in                  (l2t0_scan_out               ),
  .efu_l2t_fuse_clr          (efu_l2t1_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t1_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t1357_fuse_data         ),                       
  .l2t_efu_fuse_data         (l2t1_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t1_efu_fuse_xfer_en      ),                       
  .tcu_mbist_bisi_en              (tcu_mbist_bisi_en),
  .tcu_l2t_mbist_start            (tcu_l2t1_mbist_start),
  .tcu_l2t_mbist_scan_in          (tcu_l2t1_mbist_scan_in),
  .l2t_tcu_mbist_done             (l2t1_tcu_mbist_done),
  .l2t_tcu_mbist_fail             (l2t1_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out         (l2t1_tcu_mbist_scan_out),
  .gclk                     ( cmp_gclk_c2_l2t1 ), // cmp_gclk_c1_r[2]            ), 
  .tcu_clk_stop ( gl_l2t1_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t1_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t1_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t1_shscan_clk_stop),
  .vnw_ary                            (L2T_VNW[ 1 ]),
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
  .l2t_rep_out0                       (l2t1_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t1_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t1_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t1_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t1_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t1_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t1_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t1_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t1_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t1_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t1_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t1_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t1_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t1_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t1_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t1_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t1_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t1_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t1_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t1_rep_out19_unused[ 23 : 0 ]),
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



//assign

l2t l2t2(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3b ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3b ),
.l2t_lstg_in		    ({
                              148'b0,
                              l2t3_mcu1_rd_req,
                              l2t3_mcu1_rd_dummy_req,
                              l2t3_mcu1_rd_req_id[ 2 : 0 ],
                              l2t3_mcu1_wr_req,
                              l2t3_mcu1_addr_5,
                              l2t3_mcu1_addr[ 39 : 31 ],
                              4'b0,
                              l2t3_mcu1_addr[ 30 : 7 ]}
                            ),
  .l2t_lstg_out		    ({
                              unconnectedt2lff[ 191 : 44 ],
                              l2t3_mcu1_rd_req_t2lff,
                              l2t3_mcu1_rd_dummy_req_t2lff,
                              l2t3_mcu1_rd_req_id_t2lff[ 2 : 0 ],
                              l2t3_mcu1_wr_req_t2lff,
                              l2t3_mcu1_addr_5_t2lff,
                              l2t3_mcu1_addr_t2lff[ 39 : 31 ],
                              unconnectedt2lff[ 27 : 24 ],
                              l2t3_mcu1_addr_t2lff[ 30 : 7 ]}
                            ),
//  .l2t_lstg_in		    (192'b0),
//  .l2t_lstg_out		    (unconnectedt2lff[191:0]),
  .l2t_rstg_in		    (192'b0),
  .l2t_rstg_out		    (unconnectedt2rff[ 191 : 0 ]),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (39'b0                       ), 
  .l2t_tcu_dmo_out          (l2t2_dmo_dout[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (1'b0                        ),
  .tcu_l2t_tag_or_data_sel  (dmo_tagmuxctl               ),
  .l2t_dbg_sii_iq_dequeue   (l2t2_dbg0_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t2_dbg0_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t2_dbg0_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t2_dbg0_err_event		 ),
  .l2t_dbg_pa_match	    (l2t2_dbg0_pa_match		 ),
  .l2t_cpx_req_cq           (sctag2_cpx_req_cq[ 7 : 0 ]      ),// sctag
  .l2t_cpx_atom_cq          (sctag2_cpx_atom_cq          ),
  .l2t_cpx_data_ca          (sctag2_cpx_data_ca[ 145 : 0 ]),
  .l2t_pcx_stall_pq         (sctag2_pcx_stall_pq         ),
  .pcx_l2t_data_rdy_px1     (pcx_sctag2_data_rdy_px1     ),
  .pcx_l2t_data_px2         (pcx_sctag2_data_px2[ 129 : 0 ]),
  .pcx_l2t_atm_px1          (pcx_sctag2_atm_px1          ),
  .cpx_l2t_grant_cx         (cpx_sctag2_grant_cx[ 7 : 0 ]    ),
  .l2t_rst_fatal_error      (l2t2_rst_fatal_error),
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_way_sel_c2       (l2t2_l2d2_way_sel_c2        ),
  .l2t_l2d_rd_wr_c2         (l2t2_l2d2_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t2_l2d2_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_col_offset_c2    (l2t2_l2d2_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_word_en_c2       (l2t2_l2d2_word_en_c2        ),
  .l2t_l2d_fbrd_c3          (l2t2_l2d2_fbrd_c3           ),
  .l2t_l2d_fb_hit_c3        (l2t2_l2d2_fb_hit_c3         ),
  .l2t_l2d_stdecc_c2        (l2t2_l2d2_stdecc_c2[ 77 : 0 ]         ),
  .l2d_l2t_decc_c6          (l2d2_l2t2_decc_c6           ),
 // .l2t_l2b_stdecc_c3        (l2t2_l2b2_stdecc_c3[77:0]   ),
  .l2t_l2b_fbrd_en_c3       (l2t2_l2b2_fbrd_en_c3        ),
  .l2t_l2b_fbrd_wl_c3       (l2t2_l2b2_fbrd_wl_c3[ 2 : 0 ]   ),
  .l2t_l2b_fbwr_wen_r2      (l2t2_l2b2_fbwr_wen_r2[ 15 : 0 ] ),
  .l2t_l2b_fbwr_wl_r2       (l2t2_l2b2_fbwr_wl_r2[ 2 : 0 ]   ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t2_l2b2_fbd_stdatasel_c3  ),
  .l2t_l2b_wbwr_wen_c6      (l2t2_l2b2_wbwr_wen_c6[ 3 : 0 ]  ),
  .l2t_l2b_wbwr_wl_c6       (l2t2_l2b2_wbwr_wl_c6[ 2 : 0 ]   ),
  .l2t_l2b_wbrd_en_r0       (l2t2_l2b2_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t2_l2b2_wbrd_wl_r0[ 2 : 0 ]   ),
  .l2t_l2b_ev_dword_r0      (l2t2_l2b2_ev_dword_r0[ 2 : 0 ]  ),
  .l2t_l2b_evict_en_r0      (l2t2_l2b2_evict_en_r0       ),
  .l2b_l2t_ev_uerr_r5       (l2b2_l2t2_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b2_l2t2_ev_cerr_r5        ),
  .l2t_l2b_rdma_wren_s2     (l2t2_l2b2_rdma_wren_s2[ 15 : 0 ]),
  .l2t_l2b_rdma_wrwl_s2     (l2t2_l2b2_rdma_wrwl_s2[ 1 : 0 ] ),
  .l2t_l2b_rdma_rdwl_r0     (l2t2_l2b2_rdma_rdwl_r0[ 1 : 0 ] ),
  .l2t_l2b_rdma_rden_r0     (l2t2_l2b2_rdma_rden_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t2_l2b2_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t2_l2b2_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_word_c7          (l2t2_l2b2_word_c7[ 3 : 0 ]      ),
  .l2t_l2b_req_en_c7        (l2t2_l2b2_req_en_c7         ),
  .l2t_l2b_word_vld_c7      (l2t2_l2b2_word_vld_c7       ),
  .l2b_l2t_rdma_uerr_c10    (l2b2_l2t2_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b2_l2t2_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b2_l2t2_rdma_notdata_c10  ),
  .l2t_mcu_rd_req           (l2t2_mcu1_rd_req            ),
  .l2t_mcu_rd_dummy_req     (l2t2_mcu1_rd_dummy_req      ),
  .l2t_mcu_rd_req_id        (l2t2_mcu1_rd_req_id[ 2 : 0 ]    ),
  .l2t_mcu_addr             (l2t2_mcu1_addr[ 39 : 7 ]        ),
  .l2t_mcu_addr_5           (l2t2_mcu1_addr_5            ),
  .l2t_mcu_wr_req           (l2t2_mcu1_wr_req            ),
  .mcu_l2t_rd_ack           (mcu1_l2t2_rd_ack            ),
  .mcu_l2t_wr_ack           (mcu1_l2t2_wr_ack            ),
  .mcu_l2t_chunk_id_r0      (mcu1_l2t2_qword_id_r0[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu1_l2t2_data_vld_r0       ),
  .mcu_l2t_rd_req_id_r0     (mcu1_l2t2_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu1_l2t2_secc_err_r2       ),
  .mcu_l2t_mecc_err_r2      (mcu1_l2t2_mecc_err_r2       ),
  .mcu_l2t_scb_mecc_err     (mcu1_l2t2_scb_mecc_err      ),
  .mcu_l2t_scb_secc_err     (mcu1_l2t2_scb_secc_err      ),
  .sii_l2t_req_vld          (sii_l2t2_req_vld            ),
  .sii_l2t_req              (sii_l2t2_req[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b2_ecc[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t2_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t2_sii_wib_dequeue        ),
  .rst_por_                 ( gl_l2_por_c3b0 ), 
  .rst_wmr_                 ( gl_l2_wmr_c3b ), 
  .scan_in                  (tcu_soc1_scan_out           ),
  .scan_out                 (l2t2_scan_out               ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2t_mbist_start      (tcu_l2t2_mbist_start_t3lff),
  .tcu_l2t_mbist_scan_in    (tcu_l2t2_mbist_scan_in      ),
  .l2t_tcu_mbist_done       (l2t2_tcu_mbist_done),
  .l2t_tcu_mbist_fail       (l2t2_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out   (l2t2_tcu_mbist_scan_out     ),
  .efu_l2t_fuse_clr          (efu_l2t2_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t2_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t0246_fuse_data         ),                       
  .l2t_efu_fuse_data         (l2t2_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t2_efu_fuse_xfer_en      ),                       
  .gclk                     ( cmp_gclk_c3_l2t2 ), // cmp_gclk_c1_r[5] ), 
  .tcu_clk_stop ( gl_l2t2_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t2_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t2_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t2_shscan_clk_stop),
  .vnw_ary                            (L2T_VNW[ 2 ]),
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
  .l2t_rep_out0                       (l2t2_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t2_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t2_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t2_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t2_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t2_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t2_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t2_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t2_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t2_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t2_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t2_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t2_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t2_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t2_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t2_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t2_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t2_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t2_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t2_rep_out19_unused[ 23 : 0 ]),
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

//assign

l2t l2t3(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c2b ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c2b ),
  .l2t_lstg_in		    (
                           { 66'b0,
                              l2t6_sii_iq_dequeue,
                              l2t6_sii_wib_dequeue,
                              l2t7_sii_iq_dequeue,
                              l2t7_sii_wib_dequeue,
                              48'b0,
                              tcu_l2t2_mbist_start,
			      tcu_spc_mbist_start[ 2 ],
			      tcu_ss_request[ 2 ],
			      71'b0
                             }
                            ),
  .l2t_rstg_in		    (
                             {136'b0,
                              mcu1_l2t3_rd_ack,
                              mcu1_l2t3_wr_ack,
                              mcu1_l2t3_qword_id_r0[ 1 : 0 ],
                              mcu1_l2t3_data_vld_r0,
                              mcu1_l2t3_rd_req_id_r0[ 2 : 0 ],
                              mcu1_l2t3_secc_err_r2,
                              mcu1_l2t3_mecc_err_r2,
                              mcu1_l2t3_scb_mecc_err,
                              mcu1_l2t3_scb_secc_err,
                              44'b0
                             }
                            ),
  .l2t_lstg_out		    (
                             {unconnectedt3lff[ 191 : 126 ],
                              l2t6_sii_iq_dequeue_t3lff,
                              l2t6_sii_wib_dequeue_t3lff,
                              l2t7_sii_iq_dequeue_t3lff,
                              l2t7_sii_wib_dequeue_t3lff,
                              unconnectedt3lff[ 121 : 74 ],
                              tcu_l2t2_mbist_start_t3lff,
                              tcu_spc_mbist_start_t3lff_2,
                              tcu_ss_request_t3lff_2,
                              unconnectedt3lff[ 70 : 0 ]
                             }
                            ),
  .l2t_rstg_out		    (
                             {unconnectedt3rff[ 191 : 56 ],
                              mcu1_l2t3_rd_ack_t3rff,
                              mcu1_l2t3_wr_ack_t3rff,
                              mcu1_l2t3_qword_id_r0_t3rff[ 1 : 0 ],
                              mcu1_l2t3_data_vld_r0_t3rff,
                              mcu1_l2t3_rd_req_id_r0_t3rff[ 2 : 0 ],
                              mcu1_l2t3_secc_err_r2_t3rff,
                              mcu1_l2t3_mecc_err_r2_t3rff,
                              mcu1_l2t3_scb_mecc_err_t3rff,
                              mcu1_l2t3_scb_secc_err_t3rff,
                              unconnectedt3rff[ 43 : 0 ]
                             }
                            ),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (l2t2_dmo_dout[ 38 : 0 ]         ), 
  .l2t_tcu_dmo_out          (l2t3_dmo_dout[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (dmo_l2tsel[ 2 ]               ),
  .tcu_l2t_tag_or_data_sel  (dmo_tagmuxctl               ),
  .l2t_dbg_sii_iq_dequeue   (l2t3_dbg1_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t3_dbg1_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t3_dbg1_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t3_dbg1_err_event		 ),
  .l2t_dbg_pa_match	    (l2t3_dbg1_pa_match		 ),
  .l2t_cpx_req_cq           (sctag3_cpx_req_cq[ 7 : 0 ]      ),// sctag
  .l2t_cpx_atom_cq          (sctag3_cpx_atom_cq          ),
  .l2t_cpx_data_ca          (sctag3_cpx_data_ca[ 145 : 0 ]),
  .l2t_pcx_stall_pq         (sctag3_pcx_stall_pq         ),
  .pcx_l2t_data_rdy_px1     (pcx_sctag3_data_rdy_px1     ),
  .pcx_l2t_data_px2         (pcx_sctag3_data_px2[ 129 : 0 ]),
  .pcx_l2t_atm_px1          (pcx_sctag3_atm_px1          ),
  .cpx_l2t_grant_cx         (cpx_sctag3_grant_cx[ 7 : 0 ]    ),
  .l2t_rst_fatal_error      (l2t3_rst_fatal_error),
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_way_sel_c2       (l2t3_l2d3_way_sel_c2        ),
  .l2t_l2d_rd_wr_c2         (l2t3_l2d3_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t3_l2d3_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_col_offset_c2    (l2t3_l2d3_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_word_en_c2       (l2t3_l2d3_word_en_c2        ),
  .l2t_l2d_fbrd_c3          (l2t3_l2d3_fbrd_c3           ),
  .l2t_l2d_fb_hit_c3        (l2t3_l2d3_fb_hit_c3         ),
  .l2t_l2d_stdecc_c2        (l2t3_l2d3_stdecc_c2[ 77 : 0 ]         ),
  .l2d_l2t_decc_c6          (l2d3_l2t3_decc_c6           ),
 // .l2t_l2b_stdecc_c3        (l2t3_l2b3_stdecc_c3[77:0]   ),
  .l2t_l2b_fbrd_en_c3       (l2t3_l2b3_fbrd_en_c3        ),
  .l2t_l2b_fbrd_wl_c3       (l2t3_l2b3_fbrd_wl_c3[ 2 : 0 ]   ),
  .l2t_l2b_fbwr_wen_r2      (l2t3_l2b3_fbwr_wen_r2[ 15 : 0 ] ),
  .l2t_l2b_fbwr_wl_r2       (l2t3_l2b3_fbwr_wl_r2[ 2 : 0 ]   ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t3_l2b3_fbd_stdatasel_c3  ),
  .l2t_l2b_wbwr_wen_c6      (l2t3_l2b3_wbwr_wen_c6[ 3 : 0 ]  ),
  .l2t_l2b_wbwr_wl_c6       (l2t3_l2b3_wbwr_wl_c6[ 2 : 0 ]   ),
  .l2t_l2b_wbrd_en_r0       (l2t3_l2b3_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t3_l2b3_wbrd_wl_r0[ 2 : 0 ]   ),
  .l2t_l2b_ev_dword_r0      (l2t3_l2b3_ev_dword_r0[ 2 : 0 ]  ),
  .l2t_l2b_evict_en_r0      (l2t3_l2b3_evict_en_r0       ),
  .l2b_l2t_ev_uerr_r5       (l2b3_l2t3_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b3_l2t3_ev_cerr_r5        ),
  .l2t_l2b_rdma_wren_s2     (l2t3_l2b3_rdma_wren_s2[ 15 : 0 ]),
  .l2t_l2b_rdma_wrwl_s2     (l2t3_l2b3_rdma_wrwl_s2[ 1 : 0 ] ),
  .l2t_l2b_rdma_rdwl_r0     (l2t3_l2b3_rdma_rdwl_r0[ 1 : 0 ] ),
  .l2t_l2b_rdma_rden_r0     (l2t3_l2b3_rdma_rden_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t3_l2b3_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t3_l2b3_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_word_c7          (l2t3_l2b3_word_c7[ 3 : 0 ]      ),
  .l2t_l2b_req_en_c7        (l2t3_l2b3_req_en_c7         ),
  .l2t_l2b_word_vld_c7      (l2t3_l2b3_word_vld_c7       ),
  .l2b_l2t_rdma_uerr_c10    (l2b3_l2t3_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b3_l2t3_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b3_l2t3_rdma_notdata_c10  ),
  .l2t_mcu_rd_req           (l2t3_mcu1_rd_req            ),
  .l2t_mcu_rd_dummy_req     (l2t3_mcu1_rd_dummy_req      ),
  .l2t_mcu_rd_req_id        (l2t3_mcu1_rd_req_id[ 2 : 0 ]    ),
  .l2t_mcu_addr             (l2t3_mcu1_addr[ 39 : 7 ]        ),
  .l2t_mcu_addr_5           (l2t3_mcu1_addr_5            ),
  .l2t_mcu_wr_req           (l2t3_mcu1_wr_req            ),
  .mcu_l2t_rd_ack           (mcu1_l2t3_rd_ack_t3rff            ),
  .mcu_l2t_wr_ack           (mcu1_l2t3_wr_ack_t3rff            ),
  .mcu_l2t_chunk_id_r0      (mcu1_l2t3_qword_id_r0_t3rff[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu1_l2t3_data_vld_r0_t3rff       ),
  .mcu_l2t_rd_req_id_r0     (mcu1_l2t3_rd_req_id_r0_t3rff[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu1_l2t3_secc_err_r2_t3rff       ),
  .mcu_l2t_mecc_err_r2      (mcu1_l2t3_mecc_err_r2_t3rff       ),
  .mcu_l2t_scb_mecc_err     (mcu1_l2t3_scb_mecc_err_t3rff      ),
  .mcu_l2t_scb_secc_err     (mcu1_l2t3_scb_secc_err_t3rff      ),
  .sii_l2t_req_vld          (sii_l2t3_req_vld            ),
  .sii_l2t_req              (sii_l2t3_req[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b3_ecc[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t3_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t3_sii_wib_dequeue        ),
  .rst_por_                 ( gl_l2_por_c2b ), 
  .rst_wmr_                 ( gl_l2_wmr_c2b ), 
  .scan_in                  (l2t2_scan_out               ),
  .scan_out                 (l2t3_scan_out               ),
  .tcu_mbist_bisi_en         (tcu_mbist_bisi_en           ),
  .tcu_l2t_mbist_start       (tcu_l2t3_mbist_start),
  .tcu_l2t_mbist_scan_in     (tcu_l2t3_mbist_scan_in      ),
  .l2t_tcu_mbist_done        (l2t3_tcu_mbist_done),
  .l2t_tcu_mbist_fail        (l2t3_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out    (l2t3_tcu_mbist_scan_out     ),
  .efu_l2t_fuse_clr          (efu_l2t3_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t3_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t1357_fuse_data         ),                       
  .l2t_efu_fuse_data         (l2t3_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t3_efu_fuse_xfer_en      ),                       
  .gclk                     ( cmp_gclk_c2_l2t3 ), // cmp_gclk_c1_r[5]), 
  .tcu_clk_stop ( gl_l2t3_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t3_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t3_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t3_shscan_clk_stop),
  .vnw_ary                            (L2T_VNW[ 3 ]),
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
  .l2t_rep_out0                       (l2t3_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t3_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t3_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t3_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t3_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t3_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t3_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t3_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t3_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t3_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t3_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t3_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t3_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t3_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t3_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t3_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t3_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t3_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t3_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t3_rep_out19_unused[ 23 : 0 ]),
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

//assign

l2t l2t4(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c1t ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c1t ),
  .l2t_lstg_in		    (
                             {sii_l2t4_req[ 31 : 0 ],
                              sii_l2t4_req_vld,
			      sii_l2t5_req[ 31 : 0 ],
                              sii_l2t5_req_vld,
			      4'b0,
                              sii_l2b4_ecc[ 6 : 0 ],
			      l2b0_sio_data_t1rff[ 31 : 0 ],
//                              l2b0_sio_parity_t1rff[1:0],
                              l2b0_sio_ctag_vld_t1rff,
                              l2b0_sio_ue_err_t1rff,
			      37'b0,
                              l2t5_mcu2_rd_req,
                              l2t5_mcu2_rd_dummy_req,
                              l2t5_mcu2_rd_req_id[ 2 : 0 ],
                              l2t5_mcu2_wr_req,
                              l2t5_mcu2_addr_5,
                              l2t5_mcu2_addr[ 39 : 31 ],
                              4'b0,
			      l2t5_mcu2_addr[ 30 : 7 ]
                             }
                            ),
  .l2t_rstg_in		    (
                             {77'b0,
                              l2b4_sio_data[ 31 : 0 ],
                              l2b4_sio_parity[ 1 : 0 ],
                              l2b4_sio_ctag_vld,
                              l2b4_sio_ue_err,
                              79'b0
                             }
                            ),
  .l2t_lstg_out		    (
                             {sii_l2t4_req_t4lff[ 31 : 0 ],
                              sii_l2t4_req_vld_t4lff,
                              sii_l2t5_req_t4lff[ 31 : 0 ],
                              sii_l2t5_req_vld_t4lff,
                              unconnectedt4lff[ 125 : 122 ],
                              sii_l2b4_ecc_t4lff[ 6 : 0 ],
                              l2b0_sio_data_t4lff[ 31 : 0 ],
//                              l2b0_sio_parity_t4lff[1:0],
                              l2b0_sio_ctag_vld_t4lff,
                              l2b0_sio_ue_err_t4lff,
                              unconnectedt4lff[ 80 : 44 ],
                              l2t5_mcu2_rd_req_t4lff,
                              l2t5_mcu2_rd_dummy_req_t4lff,
                              l2t5_mcu2_rd_req_id_t4lff[ 2 : 0 ],
                              l2t5_mcu2_wr_req_t4lff,
                              l2t5_mcu2_addr_5_t4lff,
                              l2t5_mcu2_addr_t4lff[ 39 : 31 ],
                              unconnectedt4lff[ 27 : 24 ],
			      l2t5_mcu2_addr_t4lff[ 30 : 7 ]
                             }
                            ),
  .l2t_rstg_out		    (
                             {unconnectedt4rff[ 191 : 115 ],
                              l2b4_sio_data_t4rff[ 31 : 0 ],
                              l2b4_sio_parity_t4rff[ 1 : 0 ],
                              l2b4_sio_ctag_vld_t4rff,
                              l2b4_sio_ue_err_t4rff,
                              unconnectedt4rff[ 78 : 0 ]
                             }
                            ),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (l2t5_dmo_dout[ 38 : 0 ]         ), 
  .l2t_tcu_dmo_out          (l2t4_dmo_dout[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (dmo_l2tsel[ 3 ]               ),
  .tcu_l2t_tag_or_data_sel  (dmo_tagmuxctl               ),
  .l2t_dbg_sii_iq_dequeue   (l2t4_dbg1_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t4_dbg1_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t4_dbg1_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t4_dbg1_err_event		 ),
  .l2t_dbg_pa_match	    (l2t4_dbg1_pa_match		 ),
  .l2t_cpx_req_cq           (sctag4_cpx_req_cq[ 7 : 0 ]      ),// sctag
  .l2t_cpx_atom_cq          (sctag4_cpx_atom_cq          ),
  .l2t_cpx_data_ca          (sctag4_cpx_data_ca[ 145 : 0 ]),
  .l2t_pcx_stall_pq         (sctag4_pcx_stall_pq         ),
  .pcx_l2t_data_rdy_px1     (pcx_sctag4_data_rdy_px1     ),
  .pcx_l2t_data_px2         (pcx_sctag4_data_px2[ 129 : 0 ]),
  .pcx_l2t_atm_px1          (pcx_sctag4_atm_px1          ),
  .cpx_l2t_grant_cx         (cpx_sctag4_grant_cx[ 7 : 0 ]    ),
  .l2t_rst_fatal_error      (l2t4_rst_fatal_error),
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_way_sel_c2       (l2t4_l2d4_way_sel_c2        ),
  .l2t_l2d_rd_wr_c2         (l2t4_l2d4_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t4_l2d4_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_col_offset_c2    (l2t4_l2d4_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_word_en_c2       (l2t4_l2d4_word_en_c2        ),
  .l2t_l2d_fbrd_c3          (l2t4_l2d4_fbrd_c3           ),
  .l2t_l2d_fb_hit_c3        (l2t4_l2d4_fb_hit_c3         ),
  .l2t_l2d_stdecc_c2        (l2t4_l2d4_stdecc_c2[ 77 : 0 ]         ),
  .l2d_l2t_decc_c6          (l2d4_l2t4_decc_c6           ),
 // .l2t_l2b_stdecc_c3        (l2t4_l2b4_stdecc_c3[77:0]   ),
  .l2t_l2b_fbrd_en_c3       (l2t4_l2b4_fbrd_en_c3        ),
  .l2t_l2b_fbrd_wl_c3       (l2t4_l2b4_fbrd_wl_c3[ 2 : 0 ]   ),
  .l2t_l2b_fbwr_wen_r2      (l2t4_l2b4_fbwr_wen_r2[ 15 : 0 ] ),
  .l2t_l2b_fbwr_wl_r2       (l2t4_l2b4_fbwr_wl_r2[ 2 : 0 ]   ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t4_l2b4_fbd_stdatasel_c3  ),
  .l2t_l2b_wbwr_wen_c6      (l2t4_l2b4_wbwr_wen_c6[ 3 : 0 ]  ),
  .l2t_l2b_wbwr_wl_c6       (l2t4_l2b4_wbwr_wl_c6[ 2 : 0 ]   ),
  .l2t_l2b_wbrd_en_r0       (l2t4_l2b4_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t4_l2b4_wbrd_wl_r0[ 2 : 0 ]   ),
  .l2t_l2b_ev_dword_r0      (l2t4_l2b4_ev_dword_r0[ 2 : 0 ]  ),
  .l2t_l2b_evict_en_r0      (l2t4_l2b4_evict_en_r0       ),
  .l2b_l2t_ev_uerr_r5       (l2b4_l2t4_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b4_l2t4_ev_cerr_r5        ),
  .l2t_l2b_rdma_wren_s2     (l2t4_l2b4_rdma_wren_s2[ 15 : 0 ]),
  .l2t_l2b_rdma_wrwl_s2     (l2t4_l2b4_rdma_wrwl_s2[ 1 : 0 ] ),
  .l2t_l2b_rdma_rdwl_r0     (l2t4_l2b4_rdma_rdwl_r0[ 1 : 0 ] ),
  .l2t_l2b_rdma_rden_r0     (l2t4_l2b4_rdma_rden_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t4_l2b4_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t4_l2b4_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_word_c7          (l2t4_l2b4_word_c7[ 3 : 0 ]      ),
  .l2t_l2b_req_en_c7        (l2t4_l2b4_req_en_c7         ),
  .l2t_l2b_word_vld_c7      (l2t4_l2b4_word_vld_c7       ),
  .l2b_l2t_rdma_uerr_c10    (l2b4_l2t4_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b4_l2t4_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b4_l2t4_rdma_notdata_c10  ),
  .l2t_mcu_rd_req           (l2t4_mcu2_rd_req            ),
  .l2t_mcu_rd_dummy_req     (l2t4_mcu2_rd_dummy_req      ),
  .l2t_mcu_rd_req_id        (l2t4_mcu2_rd_req_id[ 2 : 0 ]    ),
  .l2t_mcu_addr             (l2t4_mcu2_addr[ 39 : 7 ]        ),
  .l2t_mcu_addr_5           (l2t4_mcu2_addr_5            ),
  .l2t_mcu_wr_req           (l2t4_mcu2_wr_req            ),
  .mcu_l2t_rd_ack           (mcu2_l2t4_rd_ack            ),
  .mcu_l2t_wr_ack           (mcu2_l2t4_wr_ack            ),
  .mcu_l2t_chunk_id_r0      (mcu2_l2t4_qword_id_r0[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu2_l2t4_data_vld_r0       ),
  .mcu_l2t_rd_req_id_r0     (mcu2_l2t4_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu2_l2t4_secc_err_r2       ),
  .mcu_l2t_mecc_err_r2      (mcu2_l2t4_mecc_err_r2       ),
  .mcu_l2t_scb_mecc_err     (mcu2_l2t4_scb_mecc_err      ),
  .mcu_l2t_scb_secc_err     (mcu2_l2t4_scb_secc_err      ),
  .sii_l2t_req_vld          (sii_l2t4_req_vld_t4lff            ),
  .sii_l2t_req              (sii_l2t4_req_t4lff[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b4_ecc_t4lff[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t4_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t4_sii_wib_dequeue        ),
  .rst_por_                 ( gl_rst_l2_por_c1m ), // ( gl_l2_por_c1t ),  - for int6.1
  .rst_wmr_                 ( gl_rst_l2_wmr_c1m ), // ( gl_l2_wmr_c1t ),  - for int6.1
  .scan_in                  (tcu_soc2_scan_out           ),
  .scan_out                 (l2t4_scan_out               ),
  .tcu_mbist_bisi_en         (tcu_mbist_bisi_en           ),
  .tcu_l2t_mbist_start       (tcu_l2t4_mbist_start),
  .tcu_l2t_mbist_scan_in     (tcu_l2t4_mbist_scan_in      ),
  .l2t_tcu_mbist_done        (l2t4_tcu_mbist_done),
  .l2t_tcu_mbist_fail        (l2t4_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out    (l2t4_tcu_mbist_scan_out     ),
  .efu_l2t_fuse_clr          (efu_l2t4_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t4_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t0246_fuse_data         ),                       
  .l2t_efu_fuse_data         (l2t4_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t4_efu_fuse_xfer_en      ),                       
  .gclk                     ( cmp_gclk_c1_l2t4 ), // cmp_gclk_c2_r[2]), 
  .tcu_clk_stop ( gl_l2t4_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t4_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t4_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t4_shscan_clk_stop),
  .vnw_ary                            (L2T_VNW[ 4 ]),
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
  .l2t_rep_out0                       (l2t4_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t4_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t4_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t4_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t4_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t4_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t4_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t4_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t4_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t4_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t4_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t4_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t4_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t4_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t4_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t4_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t4_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t4_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t4_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t4_rep_out19_unused[ 23 : 0 ]),
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

//assign

l2t l2t5(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c2t ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c2t ),
  .l2t_lstg_in		    (
                             {mcu1_tcu_mbist_fail,     
                              1'b0, ncu_tcu_mbist_done[ 0 ],
                              1'b0, ncu_tcu_mbist_fail[ 0 ],
                              106'b0,                   
                              l2b0_sio_parity_t0rff[ 1 : 0 ],
                              l2t0_tcu_mbist_done,
                              l2t0_tcu_mbist_fail,
                              spc0_tcu_mbist_done,
                              spc0_tcu_mbist_fail,
			      6'b0,
                              mcu0_tcu_mbist_done,
                              mcu0_tcu_mbist_fail,
			      mcu1_tcu_mbist_done,
//                              mcu1_tcu_mbist_fail,
                              16'b0,
			      22'b0,
                              spc0_softstop_request,
                              spc0_hardstop_request,
                              spc0_trigger_pulse,
                              spc0_ss_complete,
			      24'b0
                             }
                            ),
  .l2t_rstg_in		    (
                             {136'b0,
                              mcu2_l2t5_rd_ack,
                              mcu2_l2t5_wr_ack,
                              mcu2_l2t5_qword_id_r0[ 1 : 0 ],
                              mcu2_l2t5_data_vld_r0,
                              mcu2_l2t5_rd_req_id_r0[ 2 : 0 ],
                              mcu2_l2t5_secc_err_r2,
                              mcu2_l2t5_mecc_err_r2,
                              mcu2_l2t5_scb_mecc_err,
                              mcu2_l2t5_scb_secc_err,
                              44'b0
                             }
                            ),
  .l2t_lstg_out		    (
                             {mcu1_tcu_mbist_fail_t5lff,
                              unconnectedt5lff[  190  ],
                              ncu_tcu_mbist_done_t5lff_0,
                              unconnectedt5lff[  188  ],
                              ncu_tcu_mbist_fail_t5lff_0,
                              unconnectedt5lff[  186  :  81  ],
                              l2b0_sio_parity_t5lff[ 1 : 0 ],
                              l2t0_tcu_mbist_done_t5lff,
                              l2t0_tcu_mbist_fail_t5lff,
                              spc0_tcu_mbist_done_t5lff,
                              spc0_tcu_mbist_fail_t5lff,
                              unconnectedt5lff[ 74 : 69 ],
                              mcu0_tcu_mbist_done_t5lff,
                              mcu0_tcu_mbist_fail_t5lff,
                              mcu1_tcu_mbist_done_t5lff,
//                              mcu1_tcu_mbist_fail_t5lff,
                              unconnectedt5lff[ 65 : 28 ],
                              spc0_softstop_request_t5lff,
                              spc0_hardstop_request_t5lff,
                              spc0_trigger_pulse_t5lff,
                              spc0_ss_complete_t5lff,
                              unconnectedt5lff[ 23 : 0 ]
                             }
                            ),
  .l2t_rstg_out		    (
                             {unconnectedt5rff[ 191 : 56 ],
                              mcu2_l2t5_rd_ack_t5rff,
                              mcu2_l2t5_wr_ack_t5rff,
                              mcu2_l2t5_qword_id_r0_t5rff[ 1 : 0 ],
                              mcu2_l2t5_data_vld_r0_t5rff,
                              mcu2_l2t5_rd_req_id_r0_t5rff[ 2 : 0 ],
                              mcu2_l2t5_secc_err_r2_t5rff,
                              mcu2_l2t5_mecc_err_r2_t5rff,
                              mcu2_l2t5_scb_mecc_err_t5rff,
                              mcu2_l2t5_scb_secc_err_t5rff,
                              unconnectedt5rff[ 43 : 0 ]
                             }
                            ),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (l2t1_dmo_dout[ 38 : 0 ]         ), 
  .l2t_tcu_dmo_out          (l2t5_dmo_dout[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (dmo_l2tsel[ 4 ]               ),
  .tcu_l2t_tag_or_data_sel  (dmo_tagmuxctl               ),
  .l2t_dbg_sii_iq_dequeue   (l2t5_dbg1_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t5_dbg1_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t5_dbg1_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t5_dbg1_err_event		 ),
  .l2t_dbg_pa_match	    (l2t5_dbg1_pa_match		 ),
  .l2t_cpx_req_cq           (sctag5_cpx_req_cq[ 7 : 0 ]      ),// sctag
  .l2t_cpx_atom_cq          (sctag5_cpx_atom_cq          ),
  .l2t_cpx_data_ca          (sctag5_cpx_data_ca[ 145 : 0 ]),
  .l2t_pcx_stall_pq         (sctag5_pcx_stall_pq         ),
  .pcx_l2t_data_rdy_px1     (pcx_sctag5_data_rdy_px1     ),
  .pcx_l2t_data_px2         (pcx_sctag5_data_px2[ 129 : 0 ]),
  .pcx_l2t_atm_px1          (pcx_sctag5_atm_px1          ),
  .cpx_l2t_grant_cx         (cpx_sctag5_grant_cx[ 7 : 0 ]    ),
  .l2t_rst_fatal_error      (l2t5_rst_fatal_error),
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_way_sel_c2       (l2t5_l2d5_way_sel_c2        ),
  .l2t_l2d_rd_wr_c2         (l2t5_l2d5_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t5_l2d5_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_col_offset_c2    (l2t5_l2d5_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_word_en_c2       (l2t5_l2d5_word_en_c2        ),
  .l2t_l2d_fbrd_c3          (l2t5_l2d5_fbrd_c3           ),
  .l2t_l2d_fb_hit_c3        (l2t5_l2d5_fb_hit_c3         ),
  .l2t_l2d_stdecc_c2        (l2t5_l2d5_stdecc_c2[ 77 : 0 ]         ),
  .l2d_l2t_decc_c6          (l2d5_l2t5_decc_c6           ),
 // .l2t_l2b_stdecc_c3        (l2t5_l2b5_stdecc_c3[77:0]   ),
  .l2t_l2b_fbrd_en_c3       (l2t5_l2b5_fbrd_en_c3        ),
  .l2t_l2b_fbrd_wl_c3       (l2t5_l2b5_fbrd_wl_c3[ 2 : 0 ]   ),
  .l2t_l2b_fbwr_wen_r2      (l2t5_l2b5_fbwr_wen_r2[ 15 : 0 ] ),
  .l2t_l2b_fbwr_wl_r2       (l2t5_l2b5_fbwr_wl_r2[ 2 : 0 ]   ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t5_l2b5_fbd_stdatasel_c3  ),
  .l2t_l2b_wbwr_wen_c6      (l2t5_l2b5_wbwr_wen_c6[ 3 : 0 ]  ),
  .l2t_l2b_wbwr_wl_c6       (l2t5_l2b5_wbwr_wl_c6[ 2 : 0 ]   ),
  .l2t_l2b_wbrd_en_r0       (l2t5_l2b5_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t5_l2b5_wbrd_wl_r0[ 2 : 0 ]   ),
  .l2t_l2b_ev_dword_r0      (l2t5_l2b5_ev_dword_r0[ 2 : 0 ]  ),
  .l2t_l2b_evict_en_r0      (l2t5_l2b5_evict_en_r0       ),
  .l2b_l2t_ev_uerr_r5       (l2b5_l2t5_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b5_l2t5_ev_cerr_r5        ),
  .l2t_l2b_rdma_wren_s2     (l2t5_l2b5_rdma_wren_s2[ 15 : 0 ]),
  .l2t_l2b_rdma_wrwl_s2     (l2t5_l2b5_rdma_wrwl_s2[ 1 : 0 ] ),
  .l2t_l2b_rdma_rdwl_r0     (l2t5_l2b5_rdma_rdwl_r0[ 1 : 0 ] ),
  .l2t_l2b_rdma_rden_r0     (l2t5_l2b5_rdma_rden_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t5_l2b5_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t5_l2b5_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_word_c7          (l2t5_l2b5_word_c7[ 3 : 0 ]      ),
  .l2t_l2b_req_en_c7        (l2t5_l2b5_req_en_c7         ),
  .l2t_l2b_word_vld_c7      (l2t5_l2b5_word_vld_c7       ),
  .l2b_l2t_rdma_uerr_c10    (l2b5_l2t5_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b5_l2t5_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b5_l2t5_rdma_notdata_c10  ),
  .l2t_mcu_rd_req           (l2t5_mcu2_rd_req            ),
  .l2t_mcu_rd_dummy_req     (l2t5_mcu2_rd_dummy_req      ),
  .l2t_mcu_rd_req_id        (l2t5_mcu2_rd_req_id[ 2 : 0 ]    ),
  .l2t_mcu_addr             (l2t5_mcu2_addr[ 39 : 7 ]        ),
  .l2t_mcu_addr_5           (l2t5_mcu2_addr_5            ),
  .l2t_mcu_wr_req           (l2t5_mcu2_wr_req            ),
  .mcu_l2t_rd_ack           (mcu2_l2t5_rd_ack_t5rff            ),
  .mcu_l2t_wr_ack           (mcu2_l2t5_wr_ack_t5rff            ),
  .mcu_l2t_chunk_id_r0      (mcu2_l2t5_qword_id_r0_t5rff[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu2_l2t5_data_vld_r0_t5rff       ),
  .mcu_l2t_rd_req_id_r0     (mcu2_l2t5_rd_req_id_r0_t5rff[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu2_l2t5_secc_err_r2_t5rff       ),
  .mcu_l2t_mecc_err_r2      (mcu2_l2t5_mecc_err_r2_t5rff       ),
  .mcu_l2t_scb_mecc_err     (mcu2_l2t5_scb_mecc_err_t5rff      ),
  .mcu_l2t_scb_secc_err     (mcu2_l2t5_scb_secc_err_t5rff      ),
  .sii_l2t_req_vld          (sii_l2t5_req_vld_t4lff            ),
  .sii_l2t_req              (sii_l2t5_req_t4lff[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b5_ecc_ccxrff[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t5_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t5_sii_wib_dequeue        ),
  .rst_por_                 ( gl_l2_por_c2t ), 
  .rst_wmr_                 ( gl_l2_wmr_c2t ), 
  .scan_in                  (l2t4_scan_out               ),
  .scan_out                 (l2t5_scan_out               ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2t_mbist_start      (tcu_l2t5_mbist_start),
  .tcu_l2t_mbist_scan_in    (tcu_l2t5_mbist_scan_in      ),
  .l2t_tcu_mbist_done       (l2t5_tcu_mbist_done),
  .l2t_tcu_mbist_fail       (l2t5_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out   (l2t5_tcu_mbist_scan_out     ),
  .efu_l2t_fuse_clr          (efu_l2t5_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t5_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t1357_fuse_data         ),                       
  .l2t_efu_fuse_data         (l2t5_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t5_efu_fuse_xfer_en      ),                       
  .gclk                     ( cmp_gclk_c2_l2t5 ), 
  .tcu_clk_stop ( gl_l2t5_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t5_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t5_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t5_shscan_clk_stop),
  .vnw_ary                            (L2T_VNW[ 5 ]),
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
  .l2t_rep_out0                       (l2t5_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t5_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t5_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t5_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t5_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t5_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t5_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t5_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t5_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t5_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t5_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t5_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t5_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t5_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t5_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t5_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t5_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t5_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t5_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t5_rep_out19_unused[ 23 : 0 ]),
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

//assign

l2t l2t6(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c1b ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c1b ),
  .l2t_lstg_in		    ({sii_l2t6_req[ 31 : 0 ],
                              sii_l2t6_req_vld,
			      sii_l2t7_req[ 31 : 0 ],
                              sii_l2t7_req_vld,
			      82'b0,
                              l2t7_mcu3_rd_req,
                              l2t7_mcu3_rd_dummy_req,
                              l2t7_mcu3_rd_req_id[ 2 : 0 ],
                              l2t7_mcu3_wr_req,
                              l2t7_mcu3_addr_5,
                              l2t7_mcu3_addr[ 39 : 31 ],
                              4'b0,
                              l2t7_mcu3_addr[ 30 : 7 ]
                             }
                            ),
  .l2t_rstg_in		    (192'b0),
  .l2t_lstg_out		    (
                             {sii_l2t6_req_t6lff[ 31 : 0 ],
                              sii_l2t6_req_vld_t6lff,
                              sii_l2t7_req_t6lff[ 31 : 0 ],
                              sii_l2t7_req_vld_t6lff,
                              unconnectedt6lff[ 125 : 44 ],
                              l2t7_mcu3_rd_req_t6lff,
                              l2t7_mcu3_rd_dummy_req_t6lff,
                              l2t7_mcu3_rd_req_id_t6lff[ 2 : 0 ],
                              l2t7_mcu3_wr_req_t6lff,
                              l2t7_mcu3_addr_5_t6lff,
                              l2t7_mcu3_addr_t6lff[ 39 : 31 ],
                              unconnectedt6lff[ 27 : 24 ],
                              l2t7_mcu3_addr_t6lff[ 30 : 7 ]
                             }
                            ),
  .l2t_rstg_out		    ({unconnectedt6rff[ 191 : 0 ]}),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (l2t7_dmo_dout[ 38 : 0 ]         ), 
  .l2t_tcu_dmo_out          (l2t6_dmo_dout[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (dmo_l2tsel[ 0 ]               ),
  .tcu_l2t_tag_or_data_sel  (dmo_tagmuxctl               ),
  .l2t_dbg_sii_iq_dequeue   (l2t6_dbg1_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t6_dbg1_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t6_dbg1_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t6_dbg1_err_event		 ),
  .l2t_dbg_pa_match	    (l2t6_dbg1_pa_match		 ),
  .l2t_cpx_req_cq           (sctag6_cpx_req_cq[ 7 : 0 ]      ),// sctag
  .l2t_cpx_atom_cq          (sctag6_cpx_atom_cq          ),
  .l2t_cpx_data_ca          (sctag6_cpx_data_ca[ 145 : 0 ]),
  .l2t_pcx_stall_pq         (sctag6_pcx_stall_pq         ),
  .pcx_l2t_data_rdy_px1     (pcx_sctag6_data_rdy_px1     ),
  .pcx_l2t_data_px2         (pcx_sctag6_data_px2[ 129 : 0 ]),
  .pcx_l2t_atm_px1          (pcx_sctag6_atm_px1          ),
  .cpx_l2t_grant_cx         (cpx_sctag6_grant_cx[ 7 : 0 ]    ),
  .l2t_rst_fatal_error      (l2t6_rst_fatal_error),
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_way_sel_c2       (l2t6_l2d6_way_sel_c2        ),
  .l2t_l2d_rd_wr_c2         (l2t6_l2d6_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t6_l2d6_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_col_offset_c2    (l2t6_l2d6_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_word_en_c2       (l2t6_l2d6_word_en_c2        ),
  .l2t_l2d_fbrd_c3          (l2t6_l2d6_fbrd_c3           ),
  .l2t_l2d_fb_hit_c3        (l2t6_l2d6_fb_hit_c3         ),
  .l2t_l2d_stdecc_c2        (l2t6_l2d6_stdecc_c2[ 77 : 0 ]         ),
  .l2d_l2t_decc_c6          (l2d6_l2t6_decc_c6           ),
 // .l2t_l2b_stdecc_c3        (l2t6_l2b6_stdecc_c3[77:0]   ),
  .l2t_l2b_fbrd_en_c3       (l2t6_l2b6_fbrd_en_c3        ),
  .l2t_l2b_fbrd_wl_c3       (l2t6_l2b6_fbrd_wl_c3[ 2 : 0 ]   ),
  .l2t_l2b_fbwr_wen_r2      (l2t6_l2b6_fbwr_wen_r2[ 15 : 0 ] ),
  .l2t_l2b_fbwr_wl_r2       (l2t6_l2b6_fbwr_wl_r2[ 2 : 0 ]   ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t6_l2b6_fbd_stdatasel_c3  ),
  .l2t_l2b_wbwr_wen_c6      (l2t6_l2b6_wbwr_wen_c6[ 3 : 0 ]  ),
  .l2t_l2b_wbwr_wl_c6       (l2t6_l2b6_wbwr_wl_c6[ 2 : 0 ]   ),
  .l2t_l2b_wbrd_en_r0       (l2t6_l2b6_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t6_l2b6_wbrd_wl_r0[ 2 : 0 ]   ),
  .l2t_l2b_ev_dword_r0      (l2t6_l2b6_ev_dword_r0[ 2 : 0 ]  ),
  .l2t_l2b_evict_en_r0      (l2t6_l2b6_evict_en_r0       ),
  .l2b_l2t_ev_uerr_r5       (l2b6_l2t6_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b6_l2t6_ev_cerr_r5        ),
  .l2t_l2b_rdma_wren_s2     (l2t6_l2b6_rdma_wren_s2[ 15 : 0 ]),
  .l2t_l2b_rdma_wrwl_s2     (l2t6_l2b6_rdma_wrwl_s2[ 1 : 0 ] ),
  .l2t_l2b_rdma_rdwl_r0     (l2t6_l2b6_rdma_rdwl_r0[ 1 : 0 ] ),
  .l2t_l2b_rdma_rden_r0     (l2t6_l2b6_rdma_rden_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t6_l2b6_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t6_l2b6_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_word_c7          (l2t6_l2b6_word_c7[ 3 : 0 ]      ),
  .l2t_l2b_req_en_c7        (l2t6_l2b6_req_en_c7         ),
  .l2t_l2b_word_vld_c7      (l2t6_l2b6_word_vld_c7       ),
  .l2b_l2t_rdma_uerr_c10    (l2b6_l2t6_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b6_l2t6_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b6_l2t6_rdma_notdata_c10  ),
  .l2t_mcu_rd_req           (l2t6_mcu3_rd_req            ),
  .l2t_mcu_rd_dummy_req     (l2t6_mcu3_rd_dummy_req      ),
  .l2t_mcu_rd_req_id        (l2t6_mcu3_rd_req_id[ 2 : 0 ]    ),
  .l2t_mcu_addr             (l2t6_mcu3_addr[ 39 : 7 ]        ),
  .l2t_mcu_addr_5           (l2t6_mcu3_addr_5            ),
  .l2t_mcu_wr_req           (l2t6_mcu3_wr_req            ),
  .mcu_l2t_rd_ack           (mcu3_l2t6_rd_ack            ),
  .mcu_l2t_wr_ack           (mcu3_l2t6_wr_ack            ),
  .mcu_l2t_chunk_id_r0      (mcu3_l2t6_qword_id_r0[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu3_l2t6_data_vld_r0       ),
  .mcu_l2t_rd_req_id_r0     (mcu3_l2t6_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu3_l2t6_secc_err_r2       ),
  .mcu_l2t_mecc_err_r2      (mcu3_l2t6_mecc_err_r2       ),
  .mcu_l2t_scb_mecc_err     (mcu3_l2t6_scb_mecc_err      ),
  .mcu_l2t_scb_secc_err     (mcu3_l2t6_scb_secc_err      ),
  .sii_l2t_req_vld          (sii_l2t6_req_vld_t6lff            ),
  .sii_l2t_req              (sii_l2t6_req_t6lff[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b6_ecc_ccxrff[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t6_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t6_sii_wib_dequeue        ),
  .rst_por_                 ( gl_l2_por_c1b ), // ( gl_l2_por_c1t ),  - for int6.1
  .rst_wmr_                 ( gl_l2_wmr_c1b ), 
  .scan_in                  (tcu_soc3_scan_out           ),
  .scan_out                 (l2t6_scan_out               ),
  .tcu_mbist_bisi_en         (tcu_mbist_bisi_en           ),
  .tcu_l2t_mbist_start       (tcu_l2t6_mbist_start),
  .tcu_l2t_mbist_scan_in     (tcu_l2t6_mbist_scan_in      ),
  .l2t_tcu_mbist_done        (l2t6_tcu_mbist_done),
  .l2t_tcu_mbist_fail        (l2t6_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out    (l2t6_tcu_mbist_scan_out     ),
  .efu_l2t_fuse_clr          (efu_l2t6_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t6_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t0246_fuse_data         ),                       
  .l2t_efu_fuse_data         (l2t6_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t6_efu_fuse_xfer_en      ),                       
  .gclk                     ( cmp_gclk_c1_l2t6 ),
  .tcu_clk_stop ( gl_l2t6_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t6_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t6_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t6_shscan_clk_stop),
  .vnw_ary                            (L2T_VNW[ 6 ]),
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
  .l2t_rep_out0                       (l2t6_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t6_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t6_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t6_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t6_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t6_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t6_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t6_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t6_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t6_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t6_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t6_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t6_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t6_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t6_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t6_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t6_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t6_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t6_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t6_rep_out19_unused[ 23 : 0 ]),
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

//assign

l2t l2t7(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c2b ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c2b ),
  .l2t_lstg_in		    (
                             {113'b0,
                              l2t2_tcu_mbist_done,
                              l2t2_tcu_mbist_fail,
                              spc2_tcu_mbist_done,
                              spc2_tcu_mbist_fail,
			      21'b0,
			      26'b0,
                              spc2_softstop_request,
                              spc2_hardstop_request,
                              spc2_trigger_pulse,
                              spc2_ss_complete,
			      24'b0
                             }
                            ),
  .l2t_rstg_in		    (
                             {136'b0,
                              mcu3_l2t7_rd_ack,
                              mcu3_l2t7_wr_ack,
                              mcu3_l2t7_qword_id_r0[ 1 : 0 ],
                              mcu3_l2t7_data_vld_r0,
                              mcu3_l2t7_rd_req_id_r0[ 2 : 0 ],
                              mcu3_l2t7_secc_err_r2,
                              mcu3_l2t7_mecc_err_r2,
                              mcu3_l2t7_scb_mecc_err,
                              mcu3_l2t7_scb_secc_err,
                              44'b0
                             }
                            ),
  .l2t_lstg_out		    (
                             {unconnectedt7lff[ 191 : 79 ],
                              l2t2_tcu_mbist_done_t7lff,
                              l2t2_tcu_mbist_fail_t7lff,
                              spc2_tcu_mbist_done_t7lff,
                              spc2_tcu_mbist_fail_t7lff,
                              unconnectedt7lff[ 74 : 28 ],
                              spc2_softstop_request_t7lff,
                              spc2_hardstop_request_t7lff,
                              spc2_trigger_pulse_t7lff,
                              spc2_ss_complete_t7lff,
                              unconnectedt7lff[ 23 : 0 ]
                              }
                             ),
  .l2t_rstg_out		    (
                             {unconnectedt7rff[ 191 : 56 ],
                              mcu3_l2t7_rd_ack_t7rff,
                              mcu3_l2t7_wr_ack_t7rff,
                              mcu3_l2t7_qword_id_r0_t7rff[ 1 : 0 ],
                              mcu3_l2t7_data_vld_r0_t7rff,
                              mcu3_l2t7_rd_req_id_r0_t7rff[ 2 : 0 ],
                              mcu3_l2t7_secc_err_r2_t7rff,
                              mcu3_l2t7_mecc_err_r2_t7rff,
                              mcu3_l2t7_scb_mecc_err_t7rff,
                              mcu3_l2t7_scb_secc_err_t7rff,
                              unconnectedt7rff[ 43 : 0 ]
                             }
                            ),
  .l2t_siu_delay	    (1'b0),
  .l2t_tcu_dmo_out_prev     (l2t3_dmo_dout[ 38 : 0 ]         ), 
  .l2t_tcu_dmo_out          (l2t7_dmo_dout[ 38 : 0 ]         ),
  .tcu_l2t_coresel          (dmo_l2tsel[ 1 ]               ),
  .tcu_l2t_tag_or_data_sel  (dmo_tagmuxctl               ),
  .l2t_dbg_sii_iq_dequeue   (l2t7_dbg1_sii_iq_dequeue	 ),
  .l2t_dbg_sii_wib_dequeue  (l2t7_dbg1_sii_wib_dequeue 	 ),
  .l2t_dbg_xbar_vcid	    (l2t7_dbg1_xbar_vcid[ 5 : 0 ]	 ),
  .l2t_dbg_err_event	    (l2t7_dbg1_err_event	 ),
  .l2t_dbg_pa_match	    (l2t7_dbg1_pa_match		 ),
  .l2t_cpx_req_cq           (sctag7_cpx_req_cq[ 7 : 0 ]      ),// sctag
  .l2t_cpx_atom_cq          (sctag7_cpx_atom_cq          ),
  .l2t_cpx_data_ca          (sctag7_cpx_data_ca[ 145 : 0 ]),
  .l2t_pcx_stall_pq         (sctag7_pcx_stall_pq         ),
  .pcx_l2t_data_rdy_px1     (pcx_sctag7_data_rdy_px1     ),
  .pcx_l2t_data_px2         (pcx_sctag7_data_px2[ 129 : 0 ]),
  .pcx_l2t_atm_px1          (pcx_sctag7_atm_px1          ),
  .cpx_l2t_grant_cx         (cpx_sctag7_grant_cx[ 7 : 0 ]    ),
  .l2t_rst_fatal_error      (l2t7_rst_fatal_error),
  .rst_wmr_protect                (rst_wmr_protect                 ),
  .l2t_l2d_way_sel_c2       (l2t7_l2d7_way_sel_c2        ),
  .l2t_l2d_rd_wr_c2         (l2t7_l2d7_rd_wr_c2          ),
  .l2t_l2d_set_c2           (l2t7_l2d7_set_c2[ 8 : 0 ]       ),
  .l2t_l2d_col_offset_c2    (l2t7_l2d7_col_offset_c2[ 3 : 0 ]),
  .l2t_l2d_word_en_c2       (l2t7_l2d7_word_en_c2        ),
  .l2t_l2d_fbrd_c3          (l2t7_l2d7_fbrd_c3           ),
  .l2t_l2d_fb_hit_c3        (l2t7_l2d7_fb_hit_c3         ),
  .l2t_l2d_stdecc_c2        (l2t7_l2d7_stdecc_c2[ 77 : 0 ]         ),
  .l2d_l2t_decc_c6          (l2d7_l2t7_decc_c6           ),
 // .l2t_l2b_stdecc_c3        (l2t7_l2b7_stdecc_c3[77:0]   ),
  .l2t_l2b_fbrd_en_c3       (l2t7_l2b7_fbrd_en_c3        ),
  .l2t_l2b_fbrd_wl_c3       (l2t7_l2b7_fbrd_wl_c3[ 2 : 0 ]   ),
  .l2t_l2b_fbwr_wen_r2      (l2t7_l2b7_fbwr_wen_r2[ 15 : 0 ] ),
  .l2t_l2b_fbwr_wl_r2       (l2t7_l2b7_fbwr_wl_r2[ 2 : 0 ]   ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t7_l2b7_fbd_stdatasel_c3  ),
  .l2t_l2b_wbwr_wen_c6      (l2t7_l2b7_wbwr_wen_c6[ 3 : 0 ]  ),
  .l2t_l2b_wbwr_wl_c6       (l2t7_l2b7_wbwr_wl_c6[ 2 : 0 ]   ),
  .l2t_l2b_wbrd_en_r0       (l2t7_l2b7_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t7_l2b7_wbrd_wl_r0[ 2 : 0 ]   ),
  .l2t_l2b_ev_dword_r0      (l2t7_l2b7_ev_dword_r0[ 2 : 0 ]  ),
  .l2t_l2b_evict_en_r0      (l2t7_l2b7_evict_en_r0       ),
  .l2b_l2t_ev_uerr_r5       (l2b7_l2t7_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b7_l2t7_ev_cerr_r5        ),
  .l2t_l2b_rdma_wren_s2     (l2t7_l2b7_rdma_wren_s2[ 15 : 0 ]),
  .l2t_l2b_rdma_wrwl_s2     (l2t7_l2b7_rdma_wrwl_s2[ 1 : 0 ] ),
  .l2t_l2b_rdma_rdwl_r0     (l2t7_l2b7_rdma_rdwl_r0[ 1 : 0 ] ),
  .l2t_l2b_rdma_rden_r0     (l2t7_l2b7_rdma_rden_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t7_l2b7_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t7_l2b7_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_word_c7          (l2t7_l2b7_word_c7[ 3 : 0 ]      ),
  .l2t_l2b_req_en_c7        (l2t7_l2b7_req_en_c7         ),
  .l2t_l2b_word_vld_c7      (l2t7_l2b7_word_vld_c7       ),
  .l2b_l2t_rdma_uerr_c10    (l2b7_l2t7_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b7_l2t7_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b7_l2t7_rdma_notdata_c10  ),
  .l2t_mcu_rd_req           (l2t7_mcu3_rd_req            ),
  .l2t_mcu_rd_dummy_req     (l2t7_mcu3_rd_dummy_req      ),
  .l2t_mcu_rd_req_id        (l2t7_mcu3_rd_req_id[ 2 : 0 ]    ),
  .l2t_mcu_addr             (l2t7_mcu3_addr[ 39 : 7 ]        ),
  .l2t_mcu_addr_5           (l2t7_mcu3_addr_5            ),
  .l2t_mcu_wr_req           (l2t7_mcu3_wr_req            ),
  .mcu_l2t_rd_ack           (mcu3_l2t7_rd_ack_t7rff            ),
  .mcu_l2t_wr_ack           (mcu3_l2t7_wr_ack_t7rff            ),
  .mcu_l2t_chunk_id_r0      (mcu3_l2t7_qword_id_r0_t7rff[ 1 : 0 ]  ),
  .mcu_l2t_data_vld_r0      (mcu3_l2t7_data_vld_r0_t7rff       ),
  .mcu_l2t_rd_req_id_r0     (mcu3_l2t7_rd_req_id_r0_t7rff[ 2 : 0 ] ),
  .mcu_l2t_secc_err_r2      (mcu3_l2t7_secc_err_r2_t7rff       ),
  .mcu_l2t_mecc_err_r2      (mcu3_l2t7_mecc_err_r2_t7rff       ),
  .mcu_l2t_scb_mecc_err     (mcu3_l2t7_scb_mecc_err_t7rff      ),
  .mcu_l2t_scb_secc_err     (mcu3_l2t7_scb_secc_err_t7rff      ),
  .sii_l2t_req_vld          (sii_l2t7_req_vld_t6lff            ),
  .sii_l2t_req              (sii_l2t7_req_t6lff[ 31 : 0 ]          ),
  .sii_l2b_ecc              (sii_l2b7_ecc_ccxrff[ 6 : 0 ]           ),
  .l2t_sii_iq_dequeue       (l2t7_sii_iq_dequeue         ),
  .l2t_sii_wib_dequeue      (l2t7_sii_wib_dequeue        ),
  .rst_por_                 ( gl_l2_por_c2b ), 
  .rst_wmr_                 ( gl_l2_wmr_c2b ), 
  .scan_in                  (l2t6_scan_out               ),
  .scan_out                 (l2t7_scan_out               ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2t_mbist_start      (tcu_l2t7_mbist_start),
  .tcu_l2t_mbist_scan_in    (tcu_l2t7_mbist_scan_in      ),
  .l2t_tcu_mbist_done       (l2t7_tcu_mbist_done),
  .l2t_tcu_mbist_fail       (l2t7_tcu_mbist_fail),
  .l2t_tcu_mbist_scan_out   (l2t7_tcu_mbist_scan_out     ),
  .efu_l2t_fuse_clr          (efu_l2t7_fuse_clr          ),                       
  .efu_l2t_fuse_xfer_en      (efu_l2t7_fuse_xfer_en      ),                       
  .efu_l2t_fuse_data         (efu_l2t1357_fuse_data         ),                       
  .l2t_efu_fuse_data         (l2t7_efu_fuse_data         ),                       
  .l2t_efu_fuse_xfer_en      (l2t7_efu_fuse_xfer_en      ),                       
  .gclk                     ( cmp_gclk_c2_l2t7 ),
  .tcu_clk_stop ( gl_l2t7_clk_stop ),	// staged clk_stop
  .tcu_l2t_shscan_scan_in         (tcu_l2t7_shscan_scan_in ),
  .tcu_l2t_shscan_aclk            (tcu_l2t_shscan_aclk    ),
  .tcu_l2t_shscan_bclk            (tcu_l2t_shscan_bclk    ),
  .tcu_l2t_shscan_scan_en         (tcu_l2t_shscan_scan_en ),
  .tcu_l2t_shscan_pce_ov          (tcu_l2t_shscan_pce_ov  ),
  .l2t_tcu_shscan_scan_out        (l2t7_tcu_shscan_scan_out),
  .tcu_l2t_shscan_clk_stop        (tcu_l2t7_shscan_clk_stop),
  .vnw_ary                            (L2T_VNW[ 7 ]),
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
  .l2t_rep_out0                       (l2t7_rep_out0_unused[ 23 : 0 ]),
  .l2t_rep_out1                       (l2t7_rep_out1_unused[ 23 : 0 ]),
  .l2t_rep_out2                       (l2t7_rep_out2_unused[ 23 : 0 ]),
  .l2t_rep_out3                       (l2t7_rep_out3_unused[ 23 : 0 ]),
  .l2t_rep_out4                       (l2t7_rep_out4_unused[ 23 : 0 ]),
  .l2t_rep_out5                       (l2t7_rep_out5_unused[ 23 : 0 ]),
  .l2t_rep_out6                       (l2t7_rep_out6_unused[ 23 : 0 ]),
  .l2t_rep_out7                       (l2t7_rep_out7_unused[ 23 : 0 ]),
  .l2t_rep_out8                       (l2t7_rep_out8_unused[ 23 : 0 ]),
  .l2t_rep_out9                       (l2t7_rep_out9_unused[ 23 : 0 ]),
  .l2t_rep_out10                      (l2t7_rep_out10_unused[ 23 : 0 ]),
  .l2t_rep_out11                      (l2t7_rep_out11_unused[ 23 : 0 ]),
  .l2t_rep_out12                      (l2t7_rep_out12_unused[ 23 : 0 ]),
  .l2t_rep_out13                      (l2t7_rep_out13_unused[ 23 : 0 ]),
  .l2t_rep_out14                      (l2t7_rep_out14_unused[ 23 : 0 ]),
  .l2t_rep_out15                      (l2t7_rep_out15_unused[ 23 : 0 ]),
  .l2t_rep_out16                      (l2t7_rep_out16_unused[ 23 : 0 ]),
  .l2t_rep_out17                      (l2t7_rep_out17_unused[ 23 : 0 ]),
  .l2t_rep_out18                      (l2t7_rep_out18_unused[ 23 : 0 ]),
  .l2t_rep_out19                      (l2t7_rep_out19_unused[ 23 : 0 ]),
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

*/

l2b l2b0(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3t0 ), // ( gl_io_cmp_sync_en_c3t ), - for int6.1
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3t0 ), // ( gl_cmp_io_sync_en_c3t ), - for int6.1
  .select_delay_mcu ( 1'b0 ),

  .gclk                     ( cmp_gclk_c3_l2b0 ), // cmp_gclk_c0_r[1]), 
  .tcu_clk_stop ( gl_l2b0_clk_stop ),	// staged clk_stop
  .rst_por_                 (L2_rst 			), // ( gl_l2_por_c3t ), - for int6.1
  .rst_wmr_                 (~L2_rst 			), // ( gl_l2_wmr_c3t ), - for int6.1
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
//________________________________________________________________

/*

l2b l2b1(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3t ),
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3t ),
  .select_delay_mcu ( 1'b1 ),


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
  .l2b_l2d_rvalue          (l2b1_l2d1_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b1_l2d1_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b1_l2d1_wr_en),
  .l2b_l2d_fuse_clr        (l2b1_l2d1_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d1_l2b1_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b1357_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b1_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b1_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b1_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b1_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b1_dbg0_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b1_dbg0_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b1_dbg0_sio_ack_dest	 ),
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
  .mcu_l2b_data_r2          (mcu0_l2b01_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu0_l2b01_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b1_mbist_start_ccxlff        ),
  .l2b_tcu_mbist_done       (l2b1_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b1_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b1_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b1_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b1_mcu0_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b1_mcu0_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b1_mcu0_data_vld_r5       ),
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

l2b l2b2(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3b ), // gl_io_cmp_sync_en_c3t0 - for int6.1
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3b ), // gl_cmp_io_sync_en_c3t0 - for int6.1
  .select_delay_mcu ( 1'b0 ),


  .gclk                     ( cmp_gclk_c3_l2b2 ), // cmp_gclk_c0_r[4]            ), 
  .tcu_clk_stop ( gl_l2b2_clk_stop ),	// staged clk_stop
  .rst_por_                 ( gl_l2_por_c3b0 ), // ( gl_l2_por_c3t0 ), - for int6.1 
  .rst_wmr_                 ( gl_l2_wmr_c3b ), // ( gl_l2_wmr_c3t0 ), - for int6.1 
  .l2t_l2b_fbrd_en_c3       (l2t2_l2b2_fbrd_en_c3        ),// scbuf
  .l2t_l2b_fbrd_wl_c3       (l2t2_l2b2_fbrd_wl_c3        ),
  .l2t_l2b_fbwr_wen_r2      (l2t2_l2b2_fbwr_wen_r2       ),
  .l2t_l2b_fbwr_wl_r2       (l2t2_l2b2_fbwr_wl_r2        ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t2_l2b2_fbd_stdatasel_c3  ),
  .l2t_l2b_stdecc_c2        (l2t2_l2d2_stdecc_c2[ 77 : 0 ]         ),
  .l2t_l2b_evict_en_r0      (l2t2_l2b2_evict_en_r0       ),
  .l2t_l2b_wbwr_wen_c6      (l2t2_l2b2_wbwr_wen_c6       ),
  .l2t_l2b_wbwr_wl_c6       (l2t2_l2b2_wbwr_wl_c6        ),
  .l2t_l2b_wbrd_en_r0       (l2t2_l2b2_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t2_l2b2_wbrd_wl_r0        ),
  .l2t_l2b_ev_dword_r0      (l2t2_l2b2_ev_dword_r0       ),
  .l2t_l2b_rdma_wren_s2     (l2t2_l2b2_rdma_wren_s2      ),
  .l2t_l2b_rdma_wrwl_s2     (l2t2_l2b2_rdma_wrwl_s2      ),
  .l2t_l2b_rdma_rden_r0     (l2t2_l2b2_rdma_rden_r0      ),
  .l2t_l2b_rdma_rdwl_r0     (l2t2_l2b2_rdma_rdwl_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t2_l2b2_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t2_l2b2_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_req_en_c7        (l2t2_l2b2_req_en_c7         ),
  .l2t_l2b_word_c7          (l2t2_l2b2_word_c7           ),
  .l2t_l2b_word_vld_c7      (l2t2_l2b2_word_vld_c7       ),
  .sii_l2t_req              (sii_l2t2_req                ),
  .sii_l2b_ecc              (sii_l2b2_ecc[ 6 : 0 ]           ),
  .l2b_l2d_rvalue          (l2b2_l2d2_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b2_l2d2_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b2_l2d2_wr_en),
  .l2b_l2d_fuse_clr        (l2b2_l2d2_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d2_l2b2_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b0246_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b2_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b2_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b2_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b2_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b2_dbg0_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b2_dbg0_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b2_dbg0_sio_ack_dest	 ),
  .l2b_sio_ctag_vld         (l2b2_sio_ctag_vld           ),
  .l2b_sio_data             (l2b2_sio_data[ 31 : 0 ]         ),
  .l2b_sio_parity           (l2b2_sio_parity[ 1 : 0 ]        ),     
  .l2b_sio_ue_err           (l2b2_sio_ue_err             ),
  .l2b_l2t_rdma_uerr_c10    (l2b2_l2t2_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b2_l2t2_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b2_l2t2_rdma_notdata_c10  ),
  .l2b_l2t_ev_uerr_r5       (l2b2_l2t2_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b2_l2t2_ev_cerr_r5        ),
  .l2d_l2b_decc_out_c7      (l2d2_l2b2_decc_out_c7       ),
  .l2b_l2d_fbdecc_c4        (l2b2_l2d2_fbdecc_c4         ),
  .mcu_l2b_data_r2          (mcu1_l2b23_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu1_l2b23_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b2_mbist_start_ccxlff        ),
  .l2b_tcu_mbist_done       (l2b2_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b2_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b2_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b2_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b2_mcu1_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b2_mcu1_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b2_mcu1_data_vld_r5       ),
  .scan_in                  (l2b1_scan_out               ),
  .scan_out                 (l2b2_scan_out               ),
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
//.so                       (                          )
        );
//________________________________________________________________

l2b l2b3(


  .select_delay_mcu ( 1'b1 ),
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c3b ), // ( gl_io_cmp_sync_en_c3t0 ), - for int6.1
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c3b ), // ( gl_cmp_io_sync_en_c3t0 ), - for int6.1
  .gclk                     ( cmp_gclk_c3_l2b3 ), // cmp_gclk_c0_r[5]            ), 
  .tcu_clk_stop ( gl_l2b3_clk_stop ),	// staged clk_stop
  .rst_por_                 ( gl_l2_por_c3b0 ), // ( gl_l2_por_c3t0 ),  - for int6.1
  .rst_wmr_                 ( gl_l2_wmr_c3b ), // ( gl_l2_wmr_c3t0 ),  - for int6.1
  .l2t_l2b_fbrd_en_c3       (l2t3_l2b3_fbrd_en_c3        ),// scbuf
  .l2t_l2b_fbrd_wl_c3       (l2t3_l2b3_fbrd_wl_c3        ),
  .l2t_l2b_fbwr_wen_r2      (l2t3_l2b3_fbwr_wen_r2       ),
  .l2t_l2b_fbwr_wl_r2       (l2t3_l2b3_fbwr_wl_r2        ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t3_l2b3_fbd_stdatasel_c3  ),
  .l2t_l2b_stdecc_c2        (l2t3_l2d3_stdecc_c2[ 77 : 0 ]         ),
  .l2t_l2b_evict_en_r0      (l2t3_l2b3_evict_en_r0       ),
  .l2t_l2b_wbwr_wen_c6      (l2t3_l2b3_wbwr_wen_c6       ),
  .l2t_l2b_wbwr_wl_c6       (l2t3_l2b3_wbwr_wl_c6        ),
  .l2t_l2b_wbrd_en_r0       (l2t3_l2b3_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t3_l2b3_wbrd_wl_r0        ),
  .l2t_l2b_ev_dword_r0      (l2t3_l2b3_ev_dword_r0       ),
  .l2t_l2b_rdma_wren_s2     (l2t3_l2b3_rdma_wren_s2      ),
  .l2t_l2b_rdma_wrwl_s2     (l2t3_l2b3_rdma_wrwl_s2      ),
  .l2t_l2b_rdma_rden_r0     (l2t3_l2b3_rdma_rden_r0      ),
  .l2t_l2b_rdma_rdwl_r0     (l2t3_l2b3_rdma_rdwl_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t3_l2b3_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t3_l2b3_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_req_en_c7        (l2t3_l2b3_req_en_c7         ),
  .l2t_l2b_word_c7          (l2t3_l2b3_word_c7           ),
  .l2t_l2b_word_vld_c7      (l2t3_l2b3_word_vld_c7       ),
  .sii_l2t_req              (sii_l2t3_req                ),
  .sii_l2b_ecc              (sii_l2b3_ecc[ 6 : 0 ]           ),
  .l2b_l2d_rvalue          (l2b3_l2d3_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b3_l2d3_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b3_l2d3_wr_en),
  .l2b_l2d_fuse_clr        (l2b3_l2d3_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d3_l2b3_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b1357_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b3_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b3_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b3_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b3_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b3_dbg0_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b3_dbg0_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b3_dbg0_sio_ack_dest	 ),
  .l2b_sio_ctag_vld         (l2b3_sio_ctag_vld           ),
  .l2b_sio_data             (l2b3_sio_data[ 31 : 0 ]         ),
  .l2b_sio_parity           (l2b3_sio_parity[ 1 : 0 ]        ),     
  .l2b_sio_ue_err           (l2b3_sio_ue_err             ),
  .l2b_l2t_rdma_uerr_c10    (l2b3_l2t3_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b3_l2t3_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b3_l2t3_rdma_notdata_c10  ),
  .l2b_l2t_ev_uerr_r5       (l2b3_l2t3_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b3_l2t3_ev_cerr_r5        ),
  .l2d_l2b_decc_out_c7      (l2d3_l2b3_decc_out_c7       ),
  .l2b_l2d_fbdecc_c4        (l2b3_l2d3_fbdecc_c4         ),
  .mcu_l2b_data_r2          (mcu1_l2b23_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu1_l2b23_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b3_mbist_start_ccxlff        ),
  .l2b_tcu_mbist_done       (l2b3_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b3_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b3_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b3_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b3_mcu1_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b3_mcu1_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b3_mcu1_data_vld_r5       ),
  .scan_in                  (l2b2_scan_out               ),
  .scan_out                 (l2b3_scan_out               ),
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

l2b l2b4(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c1t ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c1t ),
  .select_delay_mcu ( 1'b0 ),


  .gclk                     ( cmp_gclk_c1_l2b4 ), // cmp_gclk_c3_r[1]            ), 
  .tcu_clk_stop ( gl_l2b4_clk_stop ),	// staged clk_stop
  .rst_por_                 ( gl_l2_por_c1t ), 
  .rst_wmr_                 ( gl_l2_wmr_c1t ), 
  .l2t_l2b_fbrd_en_c3       (l2t4_l2b4_fbrd_en_c3        ),// scbuf
  .l2t_l2b_fbrd_wl_c3       (l2t4_l2b4_fbrd_wl_c3        ),
  .l2t_l2b_fbwr_wen_r2      (l2t4_l2b4_fbwr_wen_r2       ),
  .l2t_l2b_fbwr_wl_r2       (l2t4_l2b4_fbwr_wl_r2        ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t4_l2b4_fbd_stdatasel_c3  ),
  .l2t_l2b_stdecc_c2        (l2t4_l2d4_stdecc_c2[ 77 : 0 ]         ),
  .l2t_l2b_evict_en_r0      (l2t4_l2b4_evict_en_r0       ),
  .l2t_l2b_wbwr_wen_c6      (l2t4_l2b4_wbwr_wen_c6       ),
  .l2t_l2b_wbwr_wl_c6       (l2t4_l2b4_wbwr_wl_c6        ),
  .l2t_l2b_wbrd_en_r0       (l2t4_l2b4_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t4_l2b4_wbrd_wl_r0        ),
  .l2t_l2b_ev_dword_r0      (l2t4_l2b4_ev_dword_r0       ),
  .l2t_l2b_rdma_wren_s2     (l2t4_l2b4_rdma_wren_s2      ),
  .l2t_l2b_rdma_wrwl_s2     (l2t4_l2b4_rdma_wrwl_s2      ),
  .l2t_l2b_rdma_rden_r0     (l2t4_l2b4_rdma_rden_r0      ),
  .l2t_l2b_rdma_rdwl_r0     (l2t4_l2b4_rdma_rdwl_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t4_l2b4_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t4_l2b4_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_req_en_c7        (l2t4_l2b4_req_en_c7         ),
  .l2t_l2b_word_c7          (l2t4_l2b4_word_c7           ),
  .l2t_l2b_word_vld_c7      (l2t4_l2b4_word_vld_c7       ),
  .sii_l2t_req              (sii_l2t4_req_t4lff[ 31 : 0 ]                ),
  .sii_l2b_ecc              (sii_l2b4_ecc_t4lff[ 6 : 0 ]           ),
  .l2b_l2d_rvalue          (l2b4_l2d4_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b4_l2d4_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b4_l2d4_wr_en),
  .l2b_l2d_fuse_clr        (l2b4_l2d4_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d4_l2b4_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b0246_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b4_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b4_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b4_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b4_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b4_dbg1_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b4_dbg1_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b4_dbg1_sio_ack_dest	 ),
  .l2b_sio_ctag_vld         (l2b4_sio_ctag_vld           ),
  .l2b_sio_data             (l2b4_sio_data[ 31 : 0 ]         ),
  .l2b_sio_parity           (l2b4_sio_parity[ 1 : 0 ]        ),     
  .l2b_sio_ue_err           (l2b4_sio_ue_err             ),
  .l2b_l2t_rdma_uerr_c10    (l2b4_l2t4_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b4_l2t4_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b4_l2t4_rdma_notdata_c10  ),
  .l2b_l2t_ev_uerr_r5       (l2b4_l2t4_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b4_l2t4_ev_cerr_r5        ),
  .l2d_l2b_decc_out_c7      (l2d4_l2b4_decc_out_c7       ),
  .l2b_l2d_fbdecc_c4        (l2b4_l2d4_fbdecc_c4         ),
  .mcu_l2b_data_r2          (mcu2_l2b45_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu2_l2b45_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b4_mbist_start        ),
  .l2b_tcu_mbist_done       (l2b4_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b4_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b4_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b4_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b4_mcu2_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b4_mcu2_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b4_mcu2_data_vld_r5       ),
  .scan_in                  (l2b3_scan_out               ),
  .scan_out                 (l2b4_scan_out               ),
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

l2b l2b5(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c1t ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c1t ),
  .select_delay_mcu ( 1'b1 ),


  .gclk                     ( cmp_gclk_c1_l2b5 ), // cmp_gclk_c3_r[2]            ), 
  .tcu_clk_stop ( gl_l2b5_clk_stop ),	// staged clk_stop
  .rst_por_                 ( gl_rst_l2_por_c1m ), // ( gl_l2_por_c1t ), - for int6.1 
  .rst_wmr_                 ( gl_rst_l2_wmr_c1m ), // ( gl_l2_wmr_c1b ), - for int6.1 
  .l2t_l2b_fbrd_en_c3       (l2t5_l2b5_fbrd_en_c3        ),// scbuf
  .l2t_l2b_fbrd_wl_c3       (l2t5_l2b5_fbrd_wl_c3        ),
  .l2t_l2b_fbwr_wen_r2      (l2t5_l2b5_fbwr_wen_r2       ),
  .l2t_l2b_fbwr_wl_r2       (l2t5_l2b5_fbwr_wl_r2        ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t5_l2b5_fbd_stdatasel_c3  ),
  .l2t_l2b_stdecc_c2        (l2t5_l2d5_stdecc_c2[ 77 : 0 ]         ),
  .l2t_l2b_evict_en_r0      (l2t5_l2b5_evict_en_r0       ),
  .l2t_l2b_wbwr_wen_c6      (l2t5_l2b5_wbwr_wen_c6       ),
  .l2t_l2b_wbwr_wl_c6       (l2t5_l2b5_wbwr_wl_c6        ),
  .l2t_l2b_wbrd_en_r0       (l2t5_l2b5_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t5_l2b5_wbrd_wl_r0        ),
  .l2t_l2b_ev_dword_r0      (l2t5_l2b5_ev_dword_r0       ),
  .l2t_l2b_rdma_wren_s2     (l2t5_l2b5_rdma_wren_s2      ),
  .l2t_l2b_rdma_wrwl_s2     (l2t5_l2b5_rdma_wrwl_s2      ),
  .l2t_l2b_rdma_rden_r0     (l2t5_l2b5_rdma_rden_r0      ),
  .l2t_l2b_rdma_rdwl_r0     (l2t5_l2b5_rdma_rdwl_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t5_l2b5_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t5_l2b5_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_req_en_c7        (l2t5_l2b5_req_en_c7         ),
  .l2t_l2b_word_c7          (l2t5_l2b5_word_c7           ),
  .l2t_l2b_word_vld_c7      (l2t5_l2b5_word_vld_c7       ),
  .sii_l2t_req              (sii_l2t5_req_t4lff[ 31 : 0 ]                ),
  .sii_l2b_ecc              (sii_l2b5_ecc_ccxrff[ 6 : 0 ]           ),
  .l2b_l2d_rvalue          (l2b5_l2d5_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b5_l2d5_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b5_l2d5_wr_en),
  .l2b_l2d_fuse_clr        (l2b5_l2d5_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d5_l2b5_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b1357_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b5_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b5_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b5_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b5_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b5_dbg1_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b5_dbg1_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b5_dbg1_sio_ack_dest	 ),
  .l2b_sio_ctag_vld         (l2b5_sio_ctag_vld           ),
  .l2b_sio_data             (l2b5_sio_data[ 31 : 0 ]         ),
  .l2b_sio_parity           (l2b5_sio_parity[ 1 : 0 ]        ),     
  .l2b_sio_ue_err           (l2b5_sio_ue_err             ),
  .l2b_l2t_rdma_uerr_c10    (l2b5_l2t5_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b5_l2t5_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b5_l2t5_rdma_notdata_c10  ),
  .l2b_l2t_ev_uerr_r5       (l2b5_l2t5_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b5_l2t5_ev_cerr_r5        ),
  .l2d_l2b_decc_out_c7      (l2d5_l2b5_decc_out_c7       ),
  .l2b_l2d_fbdecc_c4        (l2b5_l2d5_fbdecc_c4         ),
  .mcu_l2b_data_r2          (mcu2_l2b45_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu2_l2b45_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b5_mbist_start        ),
  .l2b_tcu_mbist_done       (l2b5_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b5_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b5_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b5_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b5_mcu2_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b5_mcu2_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b5_mcu2_data_vld_r5       ),
  .scan_in                  (l2b4_scan_out               ),
  .scan_out                 (l2b5_scan_out               ),
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

l2b l2b6(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c1m ), 
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c1m ),
  .select_delay_mcu ( 1'b0 ),


  .gclk                     ( cmp_gclk_c1_l2b6 ), // cmp_gclk_c3_r[4]            ), 
  .tcu_clk_stop ( gl_l2b6_clk_stop ),	// staged clk_stop
  .rst_por_                 ( gl_l2_por_c1b ), // ( gl_l2_por_c1t ), - for int6.1 
  .rst_wmr_                 ( gl_l2_wmr_c1b ), 
  .l2t_l2b_fbrd_en_c3       (l2t6_l2b6_fbrd_en_c3        ),// scbuf
  .l2t_l2b_fbrd_wl_c3       (l2t6_l2b6_fbrd_wl_c3        ),
  .l2t_l2b_fbwr_wen_r2      (l2t6_l2b6_fbwr_wen_r2       ),
  .l2t_l2b_fbwr_wl_r2       (l2t6_l2b6_fbwr_wl_r2        ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t6_l2b6_fbd_stdatasel_c3  ),
  .l2t_l2b_stdecc_c2        (l2t6_l2d6_stdecc_c2[ 77 : 0 ]         ),
  .l2t_l2b_evict_en_r0      (l2t6_l2b6_evict_en_r0       ),
  .l2t_l2b_wbwr_wen_c6      (l2t6_l2b6_wbwr_wen_c6       ),
  .l2t_l2b_wbwr_wl_c6       (l2t6_l2b6_wbwr_wl_c6        ),
  .l2t_l2b_wbrd_en_r0       (l2t6_l2b6_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t6_l2b6_wbrd_wl_r0        ),
  .l2t_l2b_ev_dword_r0      (l2t6_l2b6_ev_dword_r0       ),
  .l2t_l2b_rdma_wren_s2     (l2t6_l2b6_rdma_wren_s2      ),
  .l2t_l2b_rdma_wrwl_s2     (l2t6_l2b6_rdma_wrwl_s2      ),
  .l2t_l2b_rdma_rden_r0     (l2t6_l2b6_rdma_rden_r0      ),
  .l2t_l2b_rdma_rdwl_r0     (l2t6_l2b6_rdma_rdwl_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t6_l2b6_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t6_l2b6_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_req_en_c7        (l2t6_l2b6_req_en_c7         ),
  .l2t_l2b_word_c7          (l2t6_l2b6_word_c7           ),
  .l2t_l2b_word_vld_c7      (l2t6_l2b6_word_vld_c7       ),
  .sii_l2t_req              (sii_l2t6_req_t6lff                ),
  .sii_l2b_ecc              (sii_l2b6_ecc_ccxrff[ 6 : 0 ]           ),
  .l2b_l2d_rvalue          (l2b6_l2d6_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b6_l2d6_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b6_l2d6_wr_en),
  .l2b_l2d_fuse_clr        (l2b6_l2d6_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d6_l2b6_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b0246_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b6_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b6_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b6_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b6_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b6_dbg1_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b6_dbg1_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b6_dbg1_sio_ack_dest	 ),
  .l2b_sio_ctag_vld         (l2b6_sio_ctag_vld           ),
  .l2b_sio_data             (l2b6_sio_data[ 31 : 0 ]         ),
  .l2b_sio_parity           (l2b6_sio_parity[ 1 : 0 ]        ),     
  .l2b_sio_ue_err           (l2b6_sio_ue_err             ),
  .l2b_l2t_rdma_uerr_c10    (l2b6_l2t6_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b6_l2t6_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b6_l2t6_rdma_notdata_c10  ),
  .l2b_l2t_ev_uerr_r5       (l2b6_l2t6_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b6_l2t6_ev_cerr_r5        ),
  .l2d_l2b_decc_out_c7      (l2d6_l2b6_decc_out_c7       ),
  .l2b_l2d_fbdecc_c4        (l2b6_l2d6_fbdecc_c4         ),
  .mcu_l2b_data_r2          (mcu3_l2b67_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu3_l2b67_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b6_mbist_start        ),
  .l2b_tcu_mbist_done       (l2b6_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b6_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b6_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b6_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b6_mcu3_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b6_mcu3_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b6_mcu3_data_vld_r5       ),
  .scan_in                  (l2b5_scan_out               ),
  .scan_out                 (l2b6_scan_out               ),
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

l2b l2b7(
  .ccu_slow_cmp_sync_en ( gl_io_cmp_sync_en_c1b ),  // ECO c1m -> c1b - mh157021
  .ccu_cmp_slow_sync_en ( gl_cmp_io_sync_en_c1b ),  // ECO c1m -> c1b - mh157021
  .select_delay_mcu ( 1'b1 ),


  .gclk                     ( cmp_gclk_c1_l2b7 ), // cmp_gclk_c3_r[5]            ), 
  .tcu_clk_stop ( gl_l2b7_clk_stop ),	// staged clk_stop
  .rst_por_                 ( gl_l2_por_c1b ), // ECO again c1m -> c1b mh157021 // ( gl_l2_por_c1t ), - for int6.1 
  .rst_wmr_                 ( gl_l2_wmr_c1b ), // ECO again c1m -> c1b mh157021 // ( gl_l2_wmr_c1b ), - for int6.1 
  .l2t_l2b_fbrd_en_c3       (l2t7_l2b7_fbrd_en_c3        ),// scbuf
  .l2t_l2b_fbrd_wl_c3       (l2t7_l2b7_fbrd_wl_c3        ),
  .l2t_l2b_fbwr_wen_r2      (l2t7_l2b7_fbwr_wen_r2       ),
  .l2t_l2b_fbwr_wl_r2       (l2t7_l2b7_fbwr_wl_r2        ),
  .l2t_l2b_fbd_stdatasel_c3 (l2t7_l2b7_fbd_stdatasel_c3  ),
  .l2t_l2b_stdecc_c2        (l2t7_l2d7_stdecc_c2[ 77 : 0 ]   ),
  .l2t_l2b_evict_en_r0      (l2t7_l2b7_evict_en_r0       ),
  .l2t_l2b_wbwr_wen_c6      (l2t7_l2b7_wbwr_wen_c6       ),
  .l2t_l2b_wbwr_wl_c6       (l2t7_l2b7_wbwr_wl_c6        ),
  .l2t_l2b_wbrd_en_r0       (l2t7_l2b7_wbrd_en_r0        ),
  .l2t_l2b_wbrd_wl_r0       (l2t7_l2b7_wbrd_wl_r0        ),
  .l2t_l2b_ev_dword_r0      (l2t7_l2b7_ev_dword_r0       ),
  .l2t_l2b_rdma_wren_s2     (l2t7_l2b7_rdma_wren_s2      ),
  .l2t_l2b_rdma_wrwl_s2     (l2t7_l2b7_rdma_wrwl_s2      ),
  .l2t_l2b_rdma_rden_r0     (l2t7_l2b7_rdma_rden_r0      ),
  .l2t_l2b_rdma_rdwl_r0     (l2t7_l2b7_rdma_rdwl_r0      ),
  .l2t_l2b_ctag_en_c7       (l2t7_l2b7_ctag_en_c7        ),
  .l2t_l2b_ctag_c7          (l2t7_l2b7_ctag_c7[ 31 : 0 ]     ),
  .l2t_l2b_req_en_c7        (l2t7_l2b7_req_en_c7         ),
  .l2t_l2b_word_c7          (l2t7_l2b7_word_c7           ),
  .l2t_l2b_word_vld_c7      (l2t7_l2b7_word_vld_c7       ),
  .sii_l2t_req              (sii_l2t7_req_t6lff                ),
  .sii_l2b_ecc              (sii_l2b7_ecc_ccxrff[ 6 : 0 ]           ),
  .l2b_l2d_rvalue          (l2b7_l2d7_rvalue[ 9 : 0 ]),
  .l2b_l2d_rid             (l2b7_l2d7_rid[ 6 : 0 ]),      
  .l2b_l2d_wr_en           (l2b7_l2d7_wr_en),
  .l2b_l2d_fuse_clr        (l2b7_l2d7_fuse_clr),
  .l2d_l2b_fuse_read_data  (l2d7_l2b7_fuse_data[ 9 : 0 ]),
  .efu_l2b_fuse_data       (efu_l2b1357_fuse_data),
  .efu_l2b_fuse_xfer_en    (efu_l2b7_fuse_xfer_en),
  .efu_l2b_fuse_clr        (efu_l2b7_fuse_clr),
  .l2b_efu_fuse_xfer_en    (l2b7_efu_fuse_xfer_en),
  .l2b_efu_fuse_data       (l2b7_efu_fuse_data),
  .l2b_dbg_sio_ctag_vld	    (l2b7_dbg1_sio_ctag_vld	 ),
  .l2b_dbg_sio_ack_type	    (l2b7_dbg1_sio_ack_type	 ),
  .l2b_dbg_sio_ack_dest	    (l2b7_dbg1_sio_ack_dest	 ),
  .l2b_sio_ctag_vld         (l2b7_sio_ctag_vld           ),
  .l2b_sio_data             (l2b7_sio_data[ 31 : 0 ]         ),
  .l2b_sio_parity           (l2b7_sio_parity[ 1 : 0 ]        ),     
  .l2b_sio_ue_err           (l2b7_sio_ue_err             ),
  .l2b_l2t_rdma_uerr_c10    (l2b7_l2t7_rdma_uerr_c10     ),
  .l2b_l2t_rdma_cerr_c10    (l2b7_l2t7_rdma_cerr_c10     ),
  .l2b_l2t_rdma_notdata_c10 (l2b7_l2t7_rdma_notdata_c10  ),
  .l2b_l2t_ev_uerr_r5       (l2b7_l2t7_ev_uerr_r5        ),
  .l2b_l2t_ev_cerr_r5       (l2b7_l2t7_ev_cerr_r5        ),
  .l2d_l2b_decc_out_c7      (l2d7_l2b7_decc_out_c7       ),
  .l2b_l2d_fbdecc_c4        (l2b7_l2d7_fbdecc_c4         ),
  .mcu_l2b_data_r2          (mcu3_l2b67_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r2           (mcu3_l2b67_ecc_r2[ 27 : 0 ]     ),
  .tcu_mbist_bisi_en        (tcu_mbist_bisi_en           ),
  .tcu_l2b_mbist_start      (tcu_l2b7_mbist_start        ),
  .l2b_tcu_mbist_done       (l2b7_tcu_mbist_done         ),
  .l2b_tcu_mbist_fail       (l2b7_tcu_mbist_fail         ),
  .tcu_l2b_mbist_scan_in    (tcu_l2b7_mbist_scan_in      ),
  .l2b_tcu_mbist_scan_out   (l2b7_tcu_mbist_scan_out     ),
  .l2b_evict_l2b_mcu_data_mecc_r5
                            (l2b7_mcu3_data_mecc_r5      ),
  .evict_l2b_mcu_wr_data_r5 (l2b7_mcu3_wr_data_r5[ 63 : 0 ]  ),
  .evict_l2b_mcu_data_vld_r5(l2b7_mcu3_data_vld_r5       ),
  .scan_in                  (l2b6_scan_out               ),
  .scan_out                 (l2b7_scan_out               ),
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

mcu mcu0(
  .gclk                     ( cmp_gclk_c4_mcu0 ), // cmp_gclk_c0_r[2]            ) , 
  .tcu_mcu_clk_stop	( gl_mcu0_clk_stop ),	// staged clk_stop
  .tcu_mcu_dr_clk_stop	( gl_mcu0_dr_clk_stop ),	// staged clk_stop
  .tcu_mcu_io_clk_stop	( gl_mcu0_io_clk_stop ),	// staged clk_stop
  .ccu_io_out	( gl_io_out_c3t ),	// staged div phase
  .dr_gclk                  ( dr_gclk_c4_mcu0 ), // dr_gclk_c0_r[2]             ) , 
  .ccu_dr_sync_en (gl_dr_sync_en_c3t),		
  .ccu_io_cmp_sync_en ( gl_io_cmp_sync_en_c3t ), 
  .ccu_cmp_io_sync_en ( gl_cmp_io_sync_en_c3t ),
  .tcu_mcu_fbd_clk_stop     (tcu_mcu0_fbd_clk_stop       ),
  .mcu_dbg1_rd_req_in_0	    (mcu0_dbg1_rd_req_in_0[ 3 : 0 ]  ),
  .mcu_dbg1_rd_req_in_1	    (mcu0_dbg1_rd_req_in_1[ 3 : 0 ]  ),
  .mcu_dbg1_rd_req_out	    (mcu0_dbg1_rd_req_out[ 4 : 0 ]   ),
  .mcu_dbg1_wr_req_in_0	    (mcu0_dbg1_wr_req_in_0       ),
  .mcu_dbg1_wr_req_in_1	    (mcu0_dbg1_wr_req_in_1       ),
  .mcu_dbg1_wr_req_out	    (mcu0_dbg1_wr_req_out[ 1 : 0 ]   ),
  .mcu_dbg1_mecc_err	    (mcu0_dbg1_mecc_err          ),
  .mcu_dbg1_secc_err	    (mcu0_dbg1_secc_err          ),
  .mcu_dbg1_fbd_err	    (mcu0_dbg1_fbd_err           ),
  .mcu_dbg1_err_mode	    (mcu0_dbg1_err_mode          ),
  .mcu_dbg1_err_event	    (mcu0_dbg1_err_event         ), 
  .mcu_dbg1_crc21	    (mcu0_dbg1_crc21		 ),
  .l2t0_mcu_rd_req          (l2t0_mcu0_rd_req            ),
  .l2t0_mcu_wr_req          (l2t0_mcu0_wr_req            ),
  .l2t0_mcu_rd_dummy_req    (l2t0_mcu0_rd_dummy_req      ),
  .l2t0_mcu_rd_req_id       (l2t0_mcu0_rd_req_id[ 2 : 0 ]    ),
  .l2t0_mcu_addr_39to7      (l2t0_mcu0_addr[ 39 : 7 ]        ),
  .l2t0_mcu_addr_5          (l2t0_mcu0_addr_5            ),
  .mcu_l2t0_rd_ack          (mcu0_l2t0_rd_ack            ),
  .mcu_l2t0_wr_ack          (mcu0_l2t0_wr_ack            ),
  .mcu_l2t0_data_vld_r0     (mcu0_l2t0_data_vld_r0       ),
  .mcu_l2t0_rd_req_id_r0    (mcu0_l2t0_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t0_secc_err_r3     (mcu0_l2t0_secc_err_r2       ),
  .mcu_l2t0_mecc_err_r3     (mcu0_l2t0_mecc_err_r2       ),
  .mcu_l2t0_scb_secc_err    (mcu0_l2t0_scb_secc_err      ),
  .mcu_l2t0_scb_mecc_err    (mcu0_l2t0_scb_mecc_err      ),
  .mcu_l2t0_qword_id_r0     (mcu0_l2t0_qword_id_r0[ 1 : 0 ]  ),
  .l2t1_mcu_rd_req          (l2t1_mcu0_rd_req_t0lff            ),
  .l2t1_mcu_wr_req          (l2t1_mcu0_wr_req_t0lff            ),
  .l2t1_mcu_rd_dummy_req    (l2t1_mcu0_rd_dummy_req_t0lff      ),
  .l2t1_mcu_rd_req_id       (l2t1_mcu0_rd_req_id_t0lff[ 2 : 0 ]    ),
  .l2t1_mcu_addr_39to7      (l2t1_mcu0_addr_t0lff[ 39 : 7 ]        ),
  .l2t1_mcu_addr_5          (l2t1_mcu0_addr_5_t0lff            ),
  .mcu_l2t1_rd_ack          (mcu0_l2t1_rd_ack            ),
  .mcu_l2t1_wr_ack          (mcu0_l2t1_wr_ack            ),
  .mcu_l2t1_data_vld_r0     (mcu0_l2t1_data_vld_r0       ),
  .mcu_l2t1_rd_req_id_r0    (mcu0_l2t1_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t1_secc_err_r3     (mcu0_l2t1_secc_err_r2       ),
  .mcu_l2t1_mecc_err_r3     (mcu0_l2t1_mecc_err_r2       ),
  .mcu_l2t1_scb_secc_err    (mcu0_l2t1_scb_secc_err      ),
  .mcu_l2t1_scb_mecc_err    (mcu0_l2t1_scb_mecc_err      ),
  .mcu_l2t1_qword_id_r0     (mcu0_l2t1_qword_id_r0[ 1 : 0 ]  ),
  .mcu_l2b_data_r3          (mcu0_l2b01_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r3           (mcu0_l2b01_ecc_r2[ 27 : 0 ]     ),
  .l2b0_mcu_data_mecc_r5    (l2b0_mcu0_data_mecc_r5      ),
  .l2b0_mcu_wr_data_r5      (l2b0_mcu0_wr_data_r5[ 63 : 0 ]  ),
  .l2b0_mcu_data_vld_r5     (l2b0_mcu0_data_vld_r5       ),
  .l2b1_mcu_data_mecc_r5    (l2b1_mcu0_data_mecc_r5      ),
  .l2b1_mcu_wr_data_r5      (l2b1_mcu0_wr_data_r5[ 63 : 0 ]  ),
  .l2b1_mcu_data_vld_r5     (l2b1_mcu0_data_vld_r5       ),
  .mcu_pt_sync_out          (mcu0_pt_sync_out            ),
  .mcu_pt_sync_in0          (mcu1_pt_sync_out            ),
  .mcu_pt_sync_in1          (mcu2_pt_sync_out            ),
  .mcu_pt_sync_in2          (mcu3_pt_sync_out            ),
  .mcu_ncu_data             (mcu0_ncu_data[ 3 : 0 ]          ),
  .mcu_ncu_stall            (mcu0_ncu_stall              ),
  .mcu_ncu_vld              (mcu0_ncu_vld                ),
  .ncu_mcu_data             (ncu_mcu0_data[ 3 : 0 ]          ),
  .ncu_mcu_stall            (ncu_mcu0_stall              ),
  .ncu_mcu_vld              (ncu_mcu0_vld                ),
  .mcu_ncu_ecc              (mcu0_ncu_ecc                ),
  .mcu_ncu_fbr              (mcu0_ncu_fbr                ),
  .ncu_mcu_ecci             (ncu_mcu0_ecci               ),
  .ncu_mcu_fbui             (ncu_mcu0_fbui               ),
  .ncu_mcu_fbri             (ncu_mcu0_fbri               ),
  .mcu_fsr0_data            (mcu0_fsr0_data[ 119 : 0 ]       ),
  .mcu_fsr1_data            (mcu0_fsr1_data[ 119 : 0 ]       ),
  .mcu_fsr0_cfgpll_enpll    (mcu0_fsr0_cfgpll_enpll      ),
  .mcu_fsr1_cfgpll_enpll    (mcu0_fsr1_cfgpll_enpll      ),
  .mcu_fsr01_cfgpll_lb      (mcu0_fsr01_cfgpll_lb[ 1 : 0 ]   ),
  .mcu_fsr01_cfgpll_mpy     (mcu0_fsr01_cfgpll_mpy[ 3 : 0 ]  ),
  .mcu_fsr0_cfgrx_enrx      (mcu0_fsr0_cfgrx_enrx        ),
  .mcu_fsr1_cfgrx_enrx      (mcu0_fsr1_cfgrx_enrx        ),
  .mcu_fsr0_cfgrx_align     (mcu0_fsr0_cfgrx_align       ),
  .mcu_fsr1_cfgrx_align     (mcu0_fsr1_cfgrx_align       ),
  .mcu_fsr0_cfgrx_invpair   (mcu0_fsr0_cfgrx_invpair[ 13 : 0 ]),
  .mcu_fsr1_cfgrx_invpair   (mcu0_fsr1_cfgrx_invpair[ 13 : 0 ]),
  .mcu_fsr01_cfgrx_eq       (mcu0_fsr01_cfgrx_eq[ 3 : 0 ]    ),
  .mcu_fsr01_cfgrx_cdr      (mcu0_fsr01_cfgrx_cdr[ 2 : 0 ]   ),
  .mcu_fsr01_cfgrx_term     (mcu0_fsr01_cfgrx_term[ 2 : 0 ]  ),
  .mcu_fsr0_cfgtx_entx      (mcu0_fsr0_cfgtx_entx        ),
  .mcu_fsr1_cfgtx_entx      (mcu0_fsr1_cfgtx_entx        ),
  .mcu_fsr0_cfgtx_enidl     (mcu0_fsr0_cfgtx_enidl       ),
  .mcu_fsr1_cfgtx_enidl     (mcu0_fsr1_cfgtx_enidl       ),
  .mcu_fsr0_cfgtx_invpair   (mcu0_fsr0_cfgtx_invpair[ 9 : 0 ]),
  .mcu_fsr1_cfgtx_invpair   (mcu0_fsr1_cfgtx_invpair[ 9 : 0 ]),
  .mcu_fsr01_cfgtx_enftp    (mcu0_fsr01_cfgtx_enftp      ),
  .mcu_fsr01_cfgtx_de       (mcu0_fsr01_cfgtx_de[ 3 : 0 ]    ),
  .mcu_fsr01_cfgtx_swing    (mcu0_fsr01_cfgtx_swing[ 2 : 0 ] ),
  .mcu_fsr01_cfgtx_cm       (mcu0_fsr01_cfgtx_cm         ),
  .mcu_fsr01_cfgrtx_rate    (mcu0_fsr01_cfgrtx_rate[ 1 : 0 ] ),
  .mcu_fsr0_cfgrx_entest    (mcu0_fsr0_cfgrx_entest      ),
  .mcu_fsr1_cfgrx_entest    (mcu0_fsr1_cfgrx_entest      ),
  .mcu_fsr0_cfgtx_entest    (mcu0_fsr0_cfgtx_entest      ),
  .mcu_fsr1_cfgtx_entest    (mcu0_fsr1_cfgtx_entest      ),
  .mcu_fsr0_cfgtx_bstx      (mcu0_fsr0_cfgtx_bstx[ 9 : 0 ]   ),
  .mcu_fsr1_cfgtx_bstx      (mcu0_fsr1_cfgtx_bstx[ 9 : 0 ]   ),
  .fsr0_mcu_data            (fsr0_mcu0_data[ 167 : 0 ]       ),
  .fsr1_mcu_data            (fsr1_mcu0_data[ 167 : 0 ]       ),
  .fsr0_mcu_rxbclk          (fsr0_mcu0_rxbclk[ 13 : 0 ]      ),
  .fsr1_mcu_rxbclk          (fsr1_mcu0_rxbclk[ 13 : 0 ]      ),
  .fsr0_mcu_stspll_lock     (fsr0_mcu0_stspll_lock[ 2 : 0 ]  ),
  .fsr1_mcu_stspll_lock     (fsr1_mcu0_stspll_lock[ 2 : 0 ]  ),
  .mcu_fsr0_testcfg         (mcu0_fsr0_testcfg[ 11 : 0 ]     ),
  .mcu_fsr1_testcfg         (mcu0_fsr1_testcfg[ 11 : 0 ]     ),
  .fsr0_mcu_stsrx_sync      ({fsr0_mcu0_stsrx_sync[ 8 ],    fsr0_mcu0_stsrx_sync[ 9 ],
			      fsr0_mcu0_stsrx_sync[ 13 : 10 ],fsr0_mcu0_stsrx_sync[ 7 : 0 ]}),
  .fsr1_mcu_stsrx_sync      ({fsr1_mcu0_stsrx_sync[ 8 ],    fsr1_mcu0_stsrx_sync[ 9 ],
			      fsr1_mcu0_stsrx_sync[ 13 : 10 ],fsr1_mcu0_stsrx_sync[ 7 : 0 ]}),
  .fsr0_mcu_stsrx_losdtct   ({fsr0_mcu0_stsrx_losdtct[ 8 ],    fsr0_mcu0_stsrx_losdtct[ 9 ],
			      fsr0_mcu0_stsrx_losdtct[ 13 : 10 ],fsr0_mcu0_stsrx_losdtct[ 7 : 0 ]}),
  .fsr1_mcu_stsrx_losdtct   ({fsr1_mcu0_stsrx_losdtct[ 8 ],    fsr1_mcu0_stsrx_losdtct[ 9 ],
			      fsr1_mcu0_stsrx_losdtct[ 13 : 10 ],fsr1_mcu0_stsrx_losdtct[ 7 : 0 ]}),
  .fsr0_mcu_stsrx_testfail  (fsr0_mcu0_stsrx_testfail[ 13 : 0 ]),
  .fsr1_mcu_stsrx_testfail  (fsr1_mcu0_stsrx_testfail[ 13 : 0 ]),
  .fsr0_mcu_stsrx_bsrxp     (fsr0_mcu0_stsrx_bsrxp[ 13 : 0 ] ),
  .fsr1_mcu_stsrx_bsrxp     (fsr1_mcu0_stsrx_bsrxp[ 13 : 0 ] ),
  .fsr0_mcu_stsrx_bsrxn     (fsr0_mcu0_stsrx_bsrxn[ 13 : 0 ] ),
  .fsr1_mcu_stsrx_bsrxn     (fsr1_mcu0_stsrx_bsrxn[ 13 : 0 ] ),
  .fsr0_mcu_ststx_testfail  (fsr0_mcu0_ststx_testfail[ 9 : 0 ]),
  .fsr1_mcu_ststx_testfail  (fsr1_mcu0_ststx_testfail[ 9 : 0 ]),
  .mcu_id                   ({1'b0,1'b0}                 ),
  .tcu_mcu_mbist_start      (tcu_mcu0_mbist_start_t1lff        ),
  .mcu_tcu_mbist_done       (mcu0_tcu_mbist_done         ),
  .mcu_tcu_mbist_fail       (mcu0_tcu_mbist_fail         ),
  .tcu_mcu_mbist_scan_in    (tcu_mcu0_mbist_scan_in      ),
  .mcu_tcu_mbist_scan_out   (mcu0_tcu_mbist_scan_out     ),
  .mcu_sbs_scan_in          (tcu_sbs_scan_in             ),
  .mcu_sbs_scan_out         (mcu0_sbs_scan_out           ),
  .scan_in                  (ccx_scan_out[ 0 ]             ),
  .scan_out                 (mcu0_scan_out               ),
  .ncu_mcu_pm(ncu_mcu_pm),
  .ncu_mcu_ba01(ncu_mcu_ba01),
  .ncu_mcu_ba23(ncu_mcu_ba23),
  .ncu_mcu_ba45(ncu_mcu_ba45),
  .ncu_mcu_ba67(ncu_mcu_ba67),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .tcu_sbs_scan_en(tcu_sbs_scan_en),
  .tcu_sbs_aclk(tcu_sbs_aclk),
  .tcu_sbs_bclk(tcu_sbs_bclk),
  .tcu_sbs_clk(tcu_sbs_clk),
  .tcu_sbs_uclk(tcu_sbs_uclk),
  .rst_mcu_selfrsh(rst_mcu_selfrsh),
  .rst_wmr_protect(rst_wmr_protect),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_mcu_testmode(tcu_mcu_testmode),
  .tcu_scan_en(tcu_scan_en),
  .tcu_se_scancollar_in(tcu_se_scancollar_in),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .tcu_array_bypass(tcu_array_bypass),
  .tcu_atpg_mode(tcu_atpg_mode),
  .tcu_div_bypass(tcu_div_bypass),
  .ccu_serdes_dtm(ccu_serdes_dtm)
        );
//________________________________________________________________

mcu mcu1(
  .gclk                     ( cmp_gclk_c4_mcu1 ), // cmp_gclk_c0_r[3]            ) , 
  .tcu_mcu_dr_clk_stop	( gl_mcu1_dr_clk_stop ),	// staged clk_stop
  .tcu_mcu_clk_stop	( gl_mcu1_clk_stop ),	// staged clk_stop
  .tcu_mcu_io_clk_stop	( gl_mcu1_io_clk_stop ),	// staged clk_stop
  .ccu_io_out	( gl_io_out_c3t ),	// staged div phase
  .ccu_dr_sync_en (gl_dr_sync_en_c3t),		
  .ccu_io_cmp_sync_en ( gl_io_cmp_sync_en_c3t ), 
  .ccu_cmp_io_sync_en ( gl_cmp_io_sync_en_c3t ),
  .dr_gclk                  ( dr_gclk_c4_mcu1 ), // dr_gclk_c0_r[3]             ) , 
  .tcu_mcu_fbd_clk_stop     (tcu_mcu1_fbd_clk_stop       ),
  .mcu_dbg1_rd_req_in_0	    (mcu1_dbg1_rd_req_in_0[ 3 : 0 ]  ),
  .mcu_dbg1_rd_req_in_1	    (mcu1_dbg1_rd_req_in_1[ 3 : 0 ]  ),
  .mcu_dbg1_rd_req_out	    (mcu1_dbg1_rd_req_out[ 4 : 0 ]   ),
  .mcu_dbg1_wr_req_in_0	    (mcu1_dbg1_wr_req_in_0       ),
  .mcu_dbg1_wr_req_in_1	    (mcu1_dbg1_wr_req_in_1       ),
  .mcu_dbg1_wr_req_out	    (mcu1_dbg1_wr_req_out[ 1 : 0 ]   ),
  .mcu_dbg1_mecc_err	    (mcu1_dbg1_mecc_err          ),
  .mcu_dbg1_secc_err	    (mcu1_dbg1_secc_err          ),
  .mcu_dbg1_fbd_err	    (mcu1_dbg1_fbd_err           ),
  .mcu_dbg1_err_mode	    (mcu1_dbg1_err_mode          ),
  .mcu_dbg1_err_event	    (mcu1_dbg1_err_event         ), 
  .mcu_dbg1_crc21	    (mcu1_dbg1_crc21             ),
  .l2t0_mcu_rd_req          (l2t2_mcu1_rd_req            ),
  .l2t0_mcu_wr_req          (l2t2_mcu1_wr_req            ),
  .l2t0_mcu_rd_dummy_req    (l2t2_mcu1_rd_dummy_req      ),
  .l2t0_mcu_rd_req_id       (l2t2_mcu1_rd_req_id[ 2 : 0 ]    ),
  .l2t0_mcu_addr_39to7      (l2t2_mcu1_addr[ 39 : 7 ]        ),
  .l2t0_mcu_addr_5          (l2t2_mcu1_addr_5            ),
  .mcu_l2t0_rd_ack          (mcu1_l2t2_rd_ack            ),
  .mcu_l2t0_wr_ack          (mcu1_l2t2_wr_ack            ),
  .mcu_l2t0_data_vld_r0     (mcu1_l2t2_data_vld_r0       ),
  .mcu_l2t0_rd_req_id_r0    (mcu1_l2t2_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t0_secc_err_r3     (mcu1_l2t2_secc_err_r2       ),
  .mcu_l2t0_mecc_err_r3     (mcu1_l2t2_mecc_err_r2       ),
  .mcu_l2t0_scb_secc_err    (mcu1_l2t2_scb_secc_err      ),
  .mcu_l2t0_scb_mecc_err    (mcu1_l2t2_scb_mecc_err      ),
  .mcu_l2t0_qword_id_r0     (mcu1_l2t2_qword_id_r0[ 1 : 0 ]  ),
  .l2t1_mcu_rd_req          (l2t3_mcu1_rd_req_t2lff            ),
  .l2t1_mcu_wr_req          (l2t3_mcu1_wr_req_t2lff            ),
  .l2t1_mcu_rd_dummy_req    (l2t3_mcu1_rd_dummy_req_t2lff      ),
  .l2t1_mcu_rd_req_id       (l2t3_mcu1_rd_req_id_t2lff[ 2 : 0 ]    ),
  .l2t1_mcu_addr_39to7      (l2t3_mcu1_addr_t2lff[ 39 : 7 ]        ),
  .l2t1_mcu_addr_5          (l2t3_mcu1_addr_5_t2lff            ),
  .mcu_l2t1_rd_ack          (mcu1_l2t3_rd_ack            ),
  .mcu_l2t1_wr_ack          (mcu1_l2t3_wr_ack            ),
  .mcu_l2t1_data_vld_r0     (mcu1_l2t3_data_vld_r0       ),
  .mcu_l2t1_rd_req_id_r0    (mcu1_l2t3_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t1_secc_err_r3     (mcu1_l2t3_secc_err_r2       ),
  .mcu_l2t1_mecc_err_r3     (mcu1_l2t3_mecc_err_r2       ),
  .mcu_l2t1_scb_secc_err    (mcu1_l2t3_scb_secc_err      ),
  .mcu_l2t1_scb_mecc_err    (mcu1_l2t3_scb_mecc_err      ),
  .mcu_l2t1_qword_id_r0     (mcu1_l2t3_qword_id_r0[ 1 : 0 ]  ),
  .mcu_l2b_data_r3          (mcu1_l2b23_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r3           (mcu1_l2b23_ecc_r2[ 27 : 0 ]     ),
  .l2b0_mcu_data_mecc_r5    (l2b2_mcu1_data_mecc_r5      ),
  .l2b0_mcu_wr_data_r5      (l2b2_mcu1_wr_data_r5[ 63 : 0 ]  ),
  .l2b0_mcu_data_vld_r5     (l2b2_mcu1_data_vld_r5       ),
  .l2b1_mcu_data_mecc_r5    (l2b3_mcu1_data_mecc_r5      ),
  .l2b1_mcu_wr_data_r5      (l2b3_mcu1_wr_data_r5[ 63 : 0 ]  ),
  .l2b1_mcu_data_vld_r5     (l2b3_mcu1_data_vld_r5       ),
  .mcu_pt_sync_out          (mcu1_pt_sync_out            ),
  .mcu_pt_sync_in0          (mcu2_pt_sync_out            ),
  .mcu_pt_sync_in1          (mcu3_pt_sync_out            ),
  .mcu_pt_sync_in2          (mcu0_pt_sync_out            ),
  .mcu_ncu_data             (mcu1_ncu_data[ 3 : 0 ]          ),
  .mcu_ncu_stall            (mcu1_ncu_stall              ),
  .mcu_ncu_vld              (mcu1_ncu_vld                ),
  .ncu_mcu_data             (ncu_mcu1_data[ 3 : 0 ]          ),
  .ncu_mcu_stall            (ncu_mcu1_stall              ),
  .ncu_mcu_vld              (ncu_mcu1_vld                ),
  .mcu_ncu_ecc              (mcu1_ncu_ecc                ),
  .mcu_ncu_fbr              (mcu1_ncu_fbr                ),
  .ncu_mcu_ecci             (ncu_mcu1_ecci               ),
  .ncu_mcu_fbui             (ncu_mcu1_fbui               ),
  .ncu_mcu_fbri             (ncu_mcu1_fbri               ),
  .mcu_fsr0_data            (mcu1_fsr2_data[ 119 : 0 ]       ),
  .mcu_fsr1_data            (mcu1_fsr3_data[ 119 : 0 ]       ),
  .mcu_fsr0_cfgpll_enpll    (mcu1_fsr2_cfgpll_enpll      ),
  .mcu_fsr1_cfgpll_enpll    (mcu1_fsr3_cfgpll_enpll      ),
  .mcu_fsr01_cfgpll_lb      (mcu1_fsr23_cfgpll_lb[ 1 : 0 ]   ),
  .mcu_fsr01_cfgpll_mpy     (mcu1_fsr23_cfgpll_mpy[ 3 : 0 ]  ),
  .mcu_fsr0_cfgrx_enrx      (mcu1_fsr2_cfgrx_enrx        ),
  .mcu_fsr1_cfgrx_enrx      (mcu1_fsr3_cfgrx_enrx        ),
  .mcu_fsr0_cfgrx_align     (mcu1_fsr2_cfgrx_align       ),
  .mcu_fsr1_cfgrx_align     (mcu1_fsr3_cfgrx_align       ),
  .mcu_fsr0_cfgrx_invpair   (mcu1_fsr2_cfgrx_invpair[ 13 : 0 ]),
  .mcu_fsr1_cfgrx_invpair   (mcu1_fsr3_cfgrx_invpair[ 13 : 0 ]),
  .mcu_fsr01_cfgrx_eq       (mcu1_fsr23_cfgrx_eq[ 3 : 0 ]    ),
  .mcu_fsr01_cfgrx_cdr      (mcu1_fsr23_cfgrx_cdr[ 2 : 0 ]   ),
  .mcu_fsr01_cfgrx_term     (mcu1_fsr23_cfgrx_term[ 2 : 0 ]  ),
  .mcu_fsr0_cfgtx_entx      (mcu1_fsr2_cfgtx_entx        ),
  .mcu_fsr1_cfgtx_entx      (mcu1_fsr3_cfgtx_entx        ),
  .mcu_fsr0_cfgtx_enidl     (mcu1_fsr2_cfgtx_enidl       ),
  .mcu_fsr1_cfgtx_enidl     (mcu1_fsr3_cfgtx_enidl       ),
  .mcu_fsr0_cfgtx_invpair   (mcu1_fsr2_cfgtx_invpair[ 9 : 0 ]),
  .mcu_fsr1_cfgtx_invpair   (mcu1_fsr3_cfgtx_invpair[ 9 : 0 ]),
  .mcu_fsr01_cfgtx_enftp    (mcu1_fsr23_cfgtx_enftp      ),
  .mcu_fsr01_cfgtx_de       (mcu1_fsr23_cfgtx_de[ 3 : 0 ]    ),
  .mcu_fsr01_cfgtx_swing    (mcu1_fsr23_cfgtx_swing[ 2 : 0 ] ),
  .mcu_fsr01_cfgtx_cm       (mcu1_fsr23_cfgtx_cm         ),
  .mcu_fsr01_cfgrtx_rate    (mcu1_fsr23_cfgrtx_rate[ 1 : 0 ] ),
  .mcu_fsr0_cfgrx_entest    (mcu1_fsr2_cfgrx_entest      ),
  .mcu_fsr1_cfgrx_entest    (mcu1_fsr3_cfgrx_entest      ),
  .mcu_fsr0_cfgtx_entest    (mcu1_fsr2_cfgtx_entest      ),
  .mcu_fsr1_cfgtx_entest    (mcu1_fsr3_cfgtx_entest      ),
  .mcu_fsr0_cfgtx_bstx      (mcu1_fsr2_cfgtx_bstx[ 9 : 0 ]   ),
  .mcu_fsr1_cfgtx_bstx      (mcu1_fsr3_cfgtx_bstx[ 9 : 0 ]   ),
  .fsr0_mcu_data            (fsr2_mcu1_data[ 167 : 0 ]       ),
  .fsr1_mcu_data            (fsr3_mcu1_data[ 167 : 0 ]       ),
  .fsr0_mcu_rxbclk          (fsr2_mcu1_rxbclk[ 13 : 0 ]      ),
  .fsr1_mcu_rxbclk          (fsr3_mcu1_rxbclk[ 13 : 0 ]      ),
  .fsr0_mcu_stspll_lock     (fsr2_mcu1_stspll_lock[ 2 : 0 ]  ),
  .fsr1_mcu_stspll_lock     (fsr3_mcu1_stspll_lock[ 2 : 0 ]  ),
  .mcu_fsr0_testcfg         (mcu1_fsr2_testcfg[ 11 : 0 ]     ),
  .mcu_fsr1_testcfg         (mcu1_fsr3_testcfg[ 11 : 0 ]     ),
  .fsr0_mcu_stsrx_sync      ({fsr2_mcu1_stsrx_sync[ 8 ],    fsr2_mcu1_stsrx_sync[ 9 ],
			      fsr2_mcu1_stsrx_sync[ 13 : 10 ],fsr2_mcu1_stsrx_sync[ 7 : 0 ]}),
  .fsr1_mcu_stsrx_sync      ({fsr3_mcu1_stsrx_sync[ 8 ],    fsr3_mcu1_stsrx_sync[ 9 ],
			      fsr3_mcu1_stsrx_sync[ 13 : 10 ],fsr3_mcu1_stsrx_sync[ 7 : 0 ]}),
  .fsr0_mcu_stsrx_losdtct   ({fsr2_mcu1_stsrx_losdtct[ 8 ],    fsr2_mcu1_stsrx_losdtct[ 9 ],
			      fsr2_mcu1_stsrx_losdtct[ 13 : 10 ],fsr2_mcu1_stsrx_losdtct[ 7 : 0 ]}),
  .fsr1_mcu_stsrx_losdtct   ({fsr3_mcu1_stsrx_losdtct[ 8 ],    fsr3_mcu1_stsrx_losdtct[ 9 ],
			      fsr3_mcu1_stsrx_losdtct[ 13 : 10 ],fsr3_mcu1_stsrx_losdtct[ 7 : 0 ]}),
  .fsr0_mcu_stsrx_testfail  (fsr2_mcu1_stsrx_testfail[ 13 : 0 ]),
  .fsr1_mcu_stsrx_testfail  (fsr3_mcu1_stsrx_testfail[ 13 : 0 ]),
  .fsr0_mcu_stsrx_bsrxp     (fsr2_mcu1_stsrx_bsrxp[ 13 : 0 ] ),
  .fsr1_mcu_stsrx_bsrxp     (fsr3_mcu1_stsrx_bsrxp[ 13 : 0 ] ),
  .fsr0_mcu_stsrx_bsrxn     (fsr2_mcu1_stsrx_bsrxn[ 13 : 0 ] ),
  .fsr1_mcu_stsrx_bsrxn     (fsr3_mcu1_stsrx_bsrxn[ 13 : 0 ] ),
  .fsr0_mcu_ststx_testfail  (fsr2_mcu1_ststx_testfail[ 9 : 0 ]),
  .fsr1_mcu_ststx_testfail  (fsr3_mcu1_ststx_testfail[ 9 : 0 ]),
  .mcu_id                   ({1'b0,1'b1}                 ),
  .tcu_mcu_mbist_start      (tcu_mcu1_mbist_start_t1lff        ),
  .mcu_tcu_mbist_done       (mcu1_tcu_mbist_done         ),
  .mcu_tcu_mbist_fail       (mcu1_tcu_mbist_fail         ),
  .tcu_mcu_mbist_scan_in    (tcu_mcu1_mbist_scan_in      ),
  .mcu_tcu_mbist_scan_out   (mcu1_tcu_mbist_scan_out     ),
  .mcu_sbs_scan_in          (mcu0_sbs_scan_out           ),
  .mcu_sbs_scan_out         (mcu1_sbs_scan_out           ),
  .scan_in                  (tcu_socc_scan_out           ),
  .scan_out                 (mcu1_scan_out               ),
  .ncu_mcu_pm(ncu_mcu_pm),
  .ncu_mcu_ba01(ncu_mcu_ba01),
  .ncu_mcu_ba23(ncu_mcu_ba23),
  .ncu_mcu_ba45(ncu_mcu_ba45),
  .ncu_mcu_ba67(ncu_mcu_ba67),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .tcu_sbs_scan_en(tcu_sbs_scan_en),
  .tcu_sbs_aclk(tcu_sbs_aclk),
  .tcu_sbs_bclk(tcu_sbs_bclk),
  .tcu_sbs_clk(tcu_sbs_clk),
  .tcu_sbs_uclk(tcu_sbs_uclk),
  .rst_mcu_selfrsh(rst_mcu_selfrsh),
  .rst_wmr_protect(rst_wmr_protect),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_mcu_testmode(tcu_mcu_testmode),
  .tcu_scan_en(tcu_scan_en),
  .tcu_se_scancollar_in(tcu_se_scancollar_in),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .tcu_array_bypass(tcu_array_bypass),
  .tcu_atpg_mode(tcu_atpg_mode),
  .tcu_div_bypass(tcu_div_bypass),
  .ccu_serdes_dtm(ccu_serdes_dtm)
         );
	 
//________________________________________________________________

mcu mcu2(
  .gclk                     ( cmp_gclk_c0_mcu2 ), // cmp_gclk_c3_r[2]            ) , 
  .tcu_mcu_dr_clk_stop	( gl_mcu2_dr_clk_stop ),	// staged clk_stop
  .tcu_mcu_io_clk_stop	( gl_mcu2_io_clk_stop ),	// staged clk_stop
  .tcu_mcu_clk_stop	( gl_mcu2_clk_stop ),	// staged clk_stop
  .ccu_io_out	( gl_io_out_c1m ),	// staged div phase
  .dr_gclk                  ( dr_gclk_c0_mcu2 ), // dr_gclk_c3_r[2]             ) , 
  .ccu_dr_sync_en (gl_dr_sync_en_c1m),	
  .ccu_io_cmp_sync_en ( gl_io_cmp_sync_en_c1m ), 
  .ccu_cmp_io_sync_en ( gl_cmp_io_sync_en_c1m ),
  .tcu_mcu_fbd_clk_stop     (tcu_mcu2_fbd_clk_stop       ),
  .mcu_dbg1_rd_req_in_0	    (mcu2_dbg1_rd_req_in_0[ 3 : 0 ]  ),
  .mcu_dbg1_rd_req_in_1	    (mcu2_dbg1_rd_req_in_1[ 3 : 0 ]  ),
  .mcu_dbg1_rd_req_out	    (mcu2_dbg1_rd_req_out[ 4 : 0 ]   ),
  .mcu_dbg1_wr_req_in_0	    (mcu2_dbg1_wr_req_in_0       ),
  .mcu_dbg1_wr_req_in_1	    (mcu2_dbg1_wr_req_in_1       ),
  .mcu_dbg1_wr_req_out	    (mcu2_dbg1_wr_req_out[ 1 : 0 ]   ),
  .mcu_dbg1_mecc_err	    (mcu2_dbg1_mecc_err          ),
  .mcu_dbg1_secc_err	    (mcu2_dbg1_secc_err          ),
  .mcu_dbg1_fbd_err	    (mcu2_dbg1_fbd_err           ),
  .mcu_dbg1_err_mode	    (mcu2_dbg1_err_mode          ),
  .mcu_dbg1_err_event	    (mcu2_dbg1_err_event         ), 
  .mcu_dbg1_crc21	    (mcu2_dbg1_crc21             ), 
  .l2t0_mcu_rd_req          (l2t4_mcu2_rd_req            ),
  .l2t0_mcu_wr_req          (l2t4_mcu2_wr_req            ),
  .l2t0_mcu_rd_dummy_req    (l2t4_mcu2_rd_dummy_req      ),
  .l2t0_mcu_rd_req_id       (l2t4_mcu2_rd_req_id[ 2 : 0 ]    ),
  .l2t0_mcu_addr_39to7      (l2t4_mcu2_addr[ 39 : 7 ]        ),
  .l2t0_mcu_addr_5          (l2t4_mcu2_addr_5            ),
  .mcu_l2t0_rd_ack          (mcu2_l2t4_rd_ack            ),
  .mcu_l2t0_wr_ack          (mcu2_l2t4_wr_ack            ),
  .mcu_l2t0_data_vld_r0     (mcu2_l2t4_data_vld_r0       ),
  .mcu_l2t0_rd_req_id_r0    (mcu2_l2t4_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t0_secc_err_r3     (mcu2_l2t4_secc_err_r2       ),
  .mcu_l2t0_mecc_err_r3     (mcu2_l2t4_mecc_err_r2       ),
  .mcu_l2t0_scb_secc_err    (mcu2_l2t4_scb_secc_err      ),
  .mcu_l2t0_scb_mecc_err    (mcu2_l2t4_scb_mecc_err      ),
  .mcu_l2t0_qword_id_r0     (mcu2_l2t4_qword_id_r0[ 1 : 0 ]  ),
  .l2t1_mcu_rd_req          (l2t5_mcu2_rd_req_t4lff            ),
  .l2t1_mcu_wr_req          (l2t5_mcu2_wr_req_t4lff            ),
  .l2t1_mcu_rd_dummy_req    (l2t5_mcu2_rd_dummy_req_t4lff      ),
  .l2t1_mcu_rd_req_id       (l2t5_mcu2_rd_req_id_t4lff[ 2 : 0 ]    ),
  .l2t1_mcu_addr_39to7      (l2t5_mcu2_addr_t4lff[ 39 : 7 ]        ),
  .l2t1_mcu_addr_5          (l2t5_mcu2_addr_5_t4lff            ),
  .mcu_l2t1_rd_ack          (mcu2_l2t5_rd_ack            ),
  .mcu_l2t1_wr_ack          (mcu2_l2t5_wr_ack            ),
  .mcu_l2t1_data_vld_r0     (mcu2_l2t5_data_vld_r0       ),
  .mcu_l2t1_rd_req_id_r0    (mcu2_l2t5_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t1_secc_err_r3     (mcu2_l2t5_secc_err_r2       ),
  .mcu_l2t1_mecc_err_r3     (mcu2_l2t5_mecc_err_r2       ),
  .mcu_l2t1_scb_secc_err    (mcu2_l2t5_scb_secc_err      ),
  .mcu_l2t1_scb_mecc_err    (mcu2_l2t5_scb_mecc_err      ),
  .mcu_l2t1_qword_id_r0     (mcu2_l2t5_qword_id_r0[ 1 : 0 ]  ),
  .mcu_l2b_data_r3          (mcu2_l2b45_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r3           (mcu2_l2b45_ecc_r2[ 27 : 0 ]     ),
  .l2b0_mcu_data_mecc_r5    (l2b4_mcu2_data_mecc_r5      ),
  .l2b0_mcu_wr_data_r5      (l2b4_mcu2_wr_data_r5[ 63 : 0 ]  ),
  .l2b0_mcu_data_vld_r5     (l2b4_mcu2_data_vld_r5       ),
  .l2b1_mcu_data_mecc_r5    (l2b5_mcu2_data_mecc_r5      ),
  .l2b1_mcu_wr_data_r5      (l2b5_mcu2_wr_data_r5[ 63 : 0 ]  ),
  .l2b1_mcu_data_vld_r5     (l2b5_mcu2_data_vld_r5       ),
  .mcu_pt_sync_out          (mcu2_pt_sync_out            ),
  .mcu_pt_sync_in0          (mcu3_pt_sync_out            ),
  .mcu_pt_sync_in1          (mcu0_pt_sync_out            ),
  .mcu_pt_sync_in2          (mcu1_pt_sync_out            ),
  .mcu_ncu_data             (mcu2_ncu_data[ 3 : 0 ]          ),
  .mcu_ncu_stall            (mcu2_ncu_stall              ),
  .mcu_ncu_vld              (mcu2_ncu_vld                ),
  .ncu_mcu_data             (ncu_mcu2_data[ 3 : 0 ]          ),
  .ncu_mcu_stall            (ncu_mcu2_stall              ),
  .ncu_mcu_vld              (ncu_mcu2_vld                ),
  .mcu_ncu_ecc              (mcu2_ncu_ecc                ),
  .mcu_ncu_fbr              (mcu2_ncu_fbr                ),
  .ncu_mcu_ecci             (ncu_mcu2_ecci               ),
  .ncu_mcu_fbui             (ncu_mcu2_fbui               ),
  .ncu_mcu_fbri             (ncu_mcu2_fbri               ),
  .mcu_fsr0_data            (mcu2_fsr4_data[ 119 : 0 ]       ),
  .mcu_fsr1_data            (mcu2_fsr5_data[ 119 : 0 ]       ),
  .mcu_fsr0_cfgpll_enpll    (mcu2_fsr4_cfgpll_enpll      ),
  .mcu_fsr1_cfgpll_enpll    (mcu2_fsr5_cfgpll_enpll      ),
  .mcu_fsr01_cfgpll_lb      (mcu2_fsr45_cfgpll_lb[ 1 : 0 ]   ),
  .mcu_fsr01_cfgpll_mpy     (mcu2_fsr45_cfgpll_mpy[ 3 : 0 ]  ),
  .mcu_fsr0_cfgrx_enrx      (mcu2_fsr4_cfgrx_enrx        ),
  .mcu_fsr1_cfgrx_enrx      (mcu2_fsr5_cfgrx_enrx        ),
  .mcu_fsr0_cfgrx_align     (mcu2_fsr4_cfgrx_align       ),
  .mcu_fsr1_cfgrx_align     (mcu2_fsr5_cfgrx_align       ),
  .mcu_fsr0_cfgrx_invpair   (mcu2_fsr4_cfgrx_invpair[ 13 : 0 ]),
  .mcu_fsr1_cfgrx_invpair   (mcu2_fsr5_cfgrx_invpair[ 13 : 0 ]),
  .mcu_fsr01_cfgrx_eq       (mcu2_fsr45_cfgrx_eq[ 3 : 0 ]    ),
  .mcu_fsr01_cfgrx_cdr      (mcu2_fsr45_cfgrx_cdr[ 2 : 0 ]   ),
  .mcu_fsr01_cfgrx_term     (mcu2_fsr45_cfgrx_term[ 2 : 0 ]  ),
  .mcu_fsr0_cfgtx_entx      (mcu2_fsr4_cfgtx_entx        ),
  .mcu_fsr1_cfgtx_entx      (mcu2_fsr5_cfgtx_entx        ),
  .mcu_fsr0_cfgtx_enidl     (mcu2_fsr4_cfgtx_enidl       ),
  .mcu_fsr1_cfgtx_enidl     (mcu2_fsr5_cfgtx_enidl       ),
  .mcu_fsr0_cfgtx_invpair   (mcu2_fsr4_cfgtx_invpair[ 9 : 0 ]),
  .mcu_fsr1_cfgtx_invpair   (mcu2_fsr5_cfgtx_invpair[ 9 : 0 ]),
  .mcu_fsr01_cfgtx_enftp    (mcu2_fsr45_cfgtx_enftp      ),
  .mcu_fsr01_cfgtx_de       (mcu2_fsr45_cfgtx_de[ 3 : 0 ]    ),
  .mcu_fsr01_cfgtx_swing    (mcu2_fsr45_cfgtx_swing[ 2 : 0 ] ),
  .mcu_fsr01_cfgtx_cm       (mcu2_fsr45_cfgtx_cm         ),
  .mcu_fsr01_cfgrtx_rate    (mcu2_fsr45_cfgrtx_rate[ 1 : 0 ] ),
  .mcu_fsr0_cfgrx_entest    (mcu2_fsr4_cfgrx_entest      ),
  .mcu_fsr1_cfgrx_entest    (mcu2_fsr5_cfgrx_entest      ),
  .mcu_fsr0_cfgtx_entest    (mcu2_fsr4_cfgtx_entest      ),
  .mcu_fsr1_cfgtx_entest    (mcu2_fsr5_cfgtx_entest      ),
  .mcu_fsr0_cfgtx_bstx      (mcu2_fsr4_cfgtx_bstx[ 9 : 0 ]   ),
  .mcu_fsr1_cfgtx_bstx      (mcu2_fsr5_cfgtx_bstx[ 9 : 0 ]   ),
  .fsr0_mcu_data            (fsr4_mcu2_data[ 167 : 0 ]       ),
  .fsr1_mcu_data            (fsr5_mcu2_data[ 167 : 0 ]       ),
  .fsr0_mcu_rxbclk          (fsr4_mcu2_rxbclk[ 13 : 0 ]      ),
  .fsr1_mcu_rxbclk          (fsr5_mcu2_rxbclk[ 13 : 0 ]      ),
  .fsr0_mcu_stspll_lock     (fsr4_mcu2_stspll_lock[ 2 : 0 ]  ),
  .fsr1_mcu_stspll_lock     (fsr5_mcu2_stspll_lock[ 2 : 0 ]  ),
  .mcu_fsr0_testcfg         (mcu2_fsr4_testcfg[ 11 : 0 ]     ),
  .mcu_fsr1_testcfg         (mcu2_fsr5_testcfg[ 11 : 0 ]     ),
  .fsr0_mcu_stsrx_sync      ({fsr4_mcu2_stsrx_sync[ 9 : 8 ],fsr4_mcu2_stsrx_sync[ 0 ], fsr4_mcu2_stsrx_sync[ 1 ],
			      fsr4_mcu2_stsrx_sync[ 2 ],  fsr4_mcu2_stsrx_sync[ 3 ], fsr4_mcu2_stsrx_sync[ 4 ],
			      fsr4_mcu2_stsrx_sync[ 5 ],  fsr4_mcu2_stsrx_sync[ 6 ], fsr4_mcu2_stsrx_sync[ 7 ],
			      fsr4_mcu2_stsrx_sync[ 10 ], fsr4_mcu2_stsrx_sync[ 11 ],fsr4_mcu2_stsrx_sync[ 12 ],
			      fsr4_mcu2_stsrx_sync[ 13 ]}),
  .fsr1_mcu_stsrx_sync      ({fsr5_mcu2_stsrx_sync[ 9 : 8 ],fsr5_mcu2_stsrx_sync[ 0 ], fsr5_mcu2_stsrx_sync[ 1 ],
			      fsr5_mcu2_stsrx_sync[ 2 ],  fsr5_mcu2_stsrx_sync[ 3 ], fsr5_mcu2_stsrx_sync[ 4 ],
			      fsr5_mcu2_stsrx_sync[ 5 ],  fsr5_mcu2_stsrx_sync[ 6 ], fsr5_mcu2_stsrx_sync[ 7 ],
			      fsr5_mcu2_stsrx_sync[ 10 ], fsr5_mcu2_stsrx_sync[ 11 ],fsr5_mcu2_stsrx_sync[ 12 ],
			      fsr5_mcu2_stsrx_sync[ 13 ]}),
  .fsr0_mcu_stsrx_losdtct   ({fsr4_mcu2_stsrx_losdtct[ 9 : 8 ],fsr4_mcu2_stsrx_losdtct[ 0 ], fsr4_mcu2_stsrx_losdtct[ 1 ],
			      fsr4_mcu2_stsrx_losdtct[ 2 ],  fsr4_mcu2_stsrx_losdtct[ 3 ], fsr4_mcu2_stsrx_losdtct[ 4 ],
			      fsr4_mcu2_stsrx_losdtct[ 5 ],  fsr4_mcu2_stsrx_losdtct[ 6 ], fsr4_mcu2_stsrx_losdtct[ 7 ],
			      fsr4_mcu2_stsrx_losdtct[ 10 ], fsr4_mcu2_stsrx_losdtct[ 11 ],fsr4_mcu2_stsrx_losdtct[ 12 ],
			      fsr4_mcu2_stsrx_losdtct[ 13 ]}),
  .fsr1_mcu_stsrx_losdtct   ({fsr5_mcu2_stsrx_losdtct[ 9 : 8 ],fsr5_mcu2_stsrx_losdtct[ 0 ], fsr5_mcu2_stsrx_losdtct[ 1 ],
			      fsr5_mcu2_stsrx_losdtct[ 2 ],  fsr5_mcu2_stsrx_losdtct[ 3 ], fsr5_mcu2_stsrx_losdtct[ 4 ],
			      fsr5_mcu2_stsrx_losdtct[ 5 ],  fsr5_mcu2_stsrx_losdtct[ 6 ], fsr5_mcu2_stsrx_losdtct[ 7 ],
			      fsr5_mcu2_stsrx_losdtct[ 10 ], fsr5_mcu2_stsrx_losdtct[ 11 ],fsr5_mcu2_stsrx_losdtct[ 12 ],
			      fsr5_mcu2_stsrx_losdtct[ 13 ]}),
  .fsr0_mcu_stsrx_testfail  (fsr4_mcu2_stsrx_testfail[ 13 : 0 ]),
  .fsr1_mcu_stsrx_testfail  (fsr5_mcu2_stsrx_testfail[ 13 : 0 ]),
  .fsr0_mcu_stsrx_bsrxp     (fsr4_mcu2_stsrx_bsrxp[ 13 : 0 ] ),
  .fsr1_mcu_stsrx_bsrxp     (fsr5_mcu2_stsrx_bsrxp[ 13 : 0 ] ),
  .fsr0_mcu_stsrx_bsrxn     (fsr4_mcu2_stsrx_bsrxn[ 13 : 0 ] ),
  .fsr1_mcu_stsrx_bsrxn     (fsr5_mcu2_stsrx_bsrxn[ 13 : 0 ] ),
  .fsr0_mcu_ststx_testfail  (fsr4_mcu2_ststx_testfail[ 9 : 0 ]),
  .fsr1_mcu_ststx_testfail  (fsr5_mcu2_ststx_testfail[ 9 : 0 ]),
  .mcu_id                   ({1'b1,1'b0}                 ),
  .tcu_mcu_mbist_start      (tcu_mcu2_mbist_start        ),
  .mcu_tcu_mbist_done       (mcu2_tcu_mbist_done         ),
  .mcu_tcu_mbist_fail       (mcu2_tcu_mbist_fail         ),
  .tcu_mcu_mbist_scan_in    (tcu_mcu2_mbist_scan_in      ),
  .mcu_tcu_mbist_scan_out   (mcu2_tcu_mbist_scan_out     ),
  .mcu_sbs_scan_in          (mcu3_sbs_scan_out           ),
  .mcu_sbs_scan_out         (mcu2_sbs_scan_out           ),
  .scan_in                  (mcu1_scan_out               ),
  .scan_out                 (mcu2_scan_out               ),
  .ncu_mcu_pm(ncu_mcu_pm),
  .ncu_mcu_ba01(ncu_mcu_ba01),
  .ncu_mcu_ba23(ncu_mcu_ba23),
  .ncu_mcu_ba45(ncu_mcu_ba45),
  .ncu_mcu_ba67(ncu_mcu_ba67),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .tcu_sbs_scan_en(tcu_sbs_scan_en),
  .tcu_sbs_aclk(tcu_sbs_aclk),
  .tcu_sbs_bclk(tcu_sbs_bclk),
  .tcu_sbs_clk(tcu_sbs_clk),
  .tcu_sbs_uclk(tcu_sbs_uclk),
  .rst_mcu_selfrsh(rst_mcu_selfrsh),
  .rst_wmr_protect(rst_wmr_protect),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_mcu_testmode(tcu_mcu_testmode),
  .tcu_scan_en(tcu_scan_en),
  .tcu_se_scancollar_in(tcu_se_scancollar_in),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .tcu_array_bypass(tcu_array_bypass),
  .tcu_atpg_mode(tcu_atpg_mode),
  .tcu_div_bypass(tcu_div_bypass),
  .ccu_serdes_dtm(ccu_serdes_dtm)
        );
//________________________________________________________________

mcu mcu3(
  .gclk                     ( cmp_gclk_c0_mcu3 ), // cmp_gclk_c3_r[3]            ) , 
  .tcu_mcu_dr_clk_stop	( gl_mcu3_dr_clk_stop ),	// staged clk_stop
  .tcu_mcu_io_clk_stop	( gl_mcu3_io_clk_stop ),	// staged clk_stop
  .tcu_mcu_clk_stop	( gl_mcu3_clk_stop ),	// staged clk_stop
  .ccu_io_out	( gl_io_out_c1m ),	// staged div phase
  .dr_gclk                  ( dr_gclk_c0_mcu3 ), // dr_gclk_c3_r[3]             ) , 
  .ccu_dr_sync_en (gl_dr_sync_en_c1m),	
  .ccu_io_cmp_sync_en ( gl_io_cmp_sync_en_c1m ), 
  .ccu_cmp_io_sync_en ( gl_cmp_io_sync_en_c1m ),
  .tcu_mcu_fbd_clk_stop     (tcu_mcu3_fbd_clk_stop       ),
  .mcu_dbg1_rd_req_in_0	    (mcu3_dbg1_rd_req_in_0[ 3 : 0 ]  ),
  .mcu_dbg1_rd_req_in_1	    (mcu3_dbg1_rd_req_in_1[ 3 : 0 ]  ),
  .mcu_dbg1_rd_req_out	    (mcu3_dbg1_rd_req_out[ 4 : 0 ]   ),
  .mcu_dbg1_wr_req_in_0	    (mcu3_dbg1_wr_req_in_0       ),
  .mcu_dbg1_wr_req_in_1	    (mcu3_dbg1_wr_req_in_1       ),
  .mcu_dbg1_wr_req_out	    (mcu3_dbg1_wr_req_out[ 1 : 0 ]   ),
  .mcu_dbg1_mecc_err	    (mcu3_dbg1_mecc_err          ),
  .mcu_dbg1_secc_err	    (mcu3_dbg1_secc_err          ),
  .mcu_dbg1_fbd_err	    (mcu3_dbg1_fbd_err           ),
  .mcu_dbg1_err_mode	    (mcu3_dbg1_err_mode          ),
  .mcu_dbg1_err_event	    (mcu3_dbg1_err_event         ), 
  .mcu_dbg1_crc21	    (mcu3_dbg1_crc21		 ), 
  .l2t0_mcu_rd_req          (l2t6_mcu3_rd_req            ),
  .l2t0_mcu_wr_req          (l2t6_mcu3_wr_req            ),
  .l2t0_mcu_rd_dummy_req    (l2t6_mcu3_rd_dummy_req      ),
  .l2t0_mcu_rd_req_id       (l2t6_mcu3_rd_req_id[ 2 : 0 ]    ),
  .l2t0_mcu_addr_39to7      (l2t6_mcu3_addr[ 39 : 7 ]        ),
  .l2t0_mcu_addr_5          (l2t6_mcu3_addr_5            ),
  .mcu_l2t0_rd_ack          (mcu3_l2t6_rd_ack            ),
  .mcu_l2t0_wr_ack          (mcu3_l2t6_wr_ack            ),
  .mcu_l2t0_data_vld_r0     (mcu3_l2t6_data_vld_r0       ),
  .mcu_l2t0_rd_req_id_r0    (mcu3_l2t6_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t0_secc_err_r3     (mcu3_l2t6_secc_err_r2       ),
  .mcu_l2t0_mecc_err_r3     (mcu3_l2t6_mecc_err_r2       ),
  .mcu_l2t0_scb_secc_err    (mcu3_l2t6_scb_secc_err      ),
  .mcu_l2t0_scb_mecc_err    (mcu3_l2t6_scb_mecc_err      ),
  .mcu_l2t0_qword_id_r0     (mcu3_l2t6_qword_id_r0[ 1 : 0 ]  ),
  .l2t1_mcu_rd_req          (l2t7_mcu3_rd_req_t6lff            ),
  .l2t1_mcu_wr_req          (l2t7_mcu3_wr_req_t6lff            ),
  .l2t1_mcu_rd_dummy_req    (l2t7_mcu3_rd_dummy_req_t6lff      ),
  .l2t1_mcu_rd_req_id       (l2t7_mcu3_rd_req_id_t6lff[ 2 : 0 ]    ),
  .l2t1_mcu_addr_39to7      (l2t7_mcu3_addr_t6lff[ 39 : 7 ]        ),
  .l2t1_mcu_addr_5          (l2t7_mcu3_addr_5_t6lff            ),
  .mcu_l2t1_rd_ack          (mcu3_l2t7_rd_ack            ),
  .mcu_l2t1_wr_ack          (mcu3_l2t7_wr_ack            ),
  .mcu_l2t1_data_vld_r0     (mcu3_l2t7_data_vld_r0       ),
  .mcu_l2t1_rd_req_id_r0    (mcu3_l2t7_rd_req_id_r0[ 2 : 0 ] ),
  .mcu_l2t1_secc_err_r3     (mcu3_l2t7_secc_err_r2       ),
  .mcu_l2t1_mecc_err_r3     (mcu3_l2t7_mecc_err_r2       ),
  .mcu_l2t1_scb_secc_err    (mcu3_l2t7_scb_secc_err      ),
  .mcu_l2t1_scb_mecc_err    (mcu3_l2t7_scb_mecc_err      ),
  .mcu_l2t1_qword_id_r0     (mcu3_l2t7_qword_id_r0[ 1 : 0 ]  ),
  .mcu_l2b_data_r3          (mcu3_l2b67_data_r2[ 127 : 0 ]   ),
  .mcu_l2b_ecc_r3           (mcu3_l2b67_ecc_r2[ 27 : 0 ]     ),
  .l2b0_mcu_data_mecc_r5    (l2b6_mcu3_data_mecc_r5      ),
  .l2b0_mcu_wr_data_r5      (l2b6_mcu3_wr_data_r5[ 63 : 0 ]  ),
  .l2b0_mcu_data_vld_r5     (l2b6_mcu3_data_vld_r5       ),
  .l2b1_mcu_data_mecc_r5    (l2b7_mcu3_data_mecc_r5      ),
  .l2b1_mcu_wr_data_r5      (l2b7_mcu3_wr_data_r5[ 63 : 0 ]  ),
  .l2b1_mcu_data_vld_r5     (l2b7_mcu3_data_vld_r5       ),
  .mcu_pt_sync_out          (mcu3_pt_sync_out            ),
  .mcu_pt_sync_in0          (mcu0_pt_sync_out            ),
  .mcu_pt_sync_in1          (mcu1_pt_sync_out            ),
  .mcu_pt_sync_in2          (mcu2_pt_sync_out            ),
  .mcu_ncu_data             (mcu3_ncu_data[ 3 : 0 ]          ),
  .mcu_ncu_stall            (mcu3_ncu_stall              ),
  .mcu_ncu_vld              (mcu3_ncu_vld                ),
  .ncu_mcu_data             (ncu_mcu3_data[ 3 : 0 ]          ),
  .ncu_mcu_stall            (ncu_mcu3_stall              ),
  .ncu_mcu_vld              (ncu_mcu3_vld                ),
  .mcu_ncu_ecc              (mcu3_ncu_ecc                ),
  .mcu_ncu_fbr              (mcu3_ncu_fbr                ),
  .ncu_mcu_ecci             (ncu_mcu3_ecci               ),
  .ncu_mcu_fbui             (ncu_mcu3_fbui               ),
  .ncu_mcu_fbri             (ncu_mcu3_fbri               ),
  .mcu_fsr0_data            (mcu3_fsr6_data[ 119 : 0 ]       ),
  .mcu_fsr1_data            (mcu3_fsr7_data[ 119 : 0 ]       ),
  .mcu_fsr0_cfgpll_enpll    (mcu3_fsr6_cfgpll_enpll      ),
  .mcu_fsr1_cfgpll_enpll    (mcu3_fsr7_cfgpll_enpll      ),
  .mcu_fsr01_cfgpll_lb      (mcu3_fsr67_cfgpll_lb[ 1 : 0 ]   ),
  .mcu_fsr01_cfgpll_mpy     (mcu3_fsr67_cfgpll_mpy[ 3 : 0 ]  ),
  .mcu_fsr0_cfgrx_enrx      (mcu3_fsr6_cfgrx_enrx        ),
  .mcu_fsr1_cfgrx_enrx      (mcu3_fsr7_cfgrx_enrx        ),
  .mcu_fsr0_cfgrx_align     (mcu3_fsr6_cfgrx_align       ),
  .mcu_fsr1_cfgrx_align     (mcu3_fsr7_cfgrx_align       ),
  .mcu_fsr0_cfgrx_invpair   (mcu3_fsr6_cfgrx_invpair[ 13 : 0 ]),
  .mcu_fsr1_cfgrx_invpair   (mcu3_fsr7_cfgrx_invpair[ 13 : 0 ]),
  .mcu_fsr01_cfgrx_eq       (mcu3_fsr67_cfgrx_eq[ 3 : 0 ]    ),
  .mcu_fsr01_cfgrx_cdr      (mcu3_fsr67_cfgrx_cdr[ 2 : 0 ]   ),
  .mcu_fsr01_cfgrx_term     (mcu3_fsr67_cfgrx_term[ 2 : 0 ]  ),
  .mcu_fsr0_cfgtx_entx      (mcu3_fsr6_cfgtx_entx        ),
  .mcu_fsr1_cfgtx_entx      (mcu3_fsr7_cfgtx_entx        ),
  .mcu_fsr0_cfgtx_enidl     (mcu3_fsr6_cfgtx_enidl       ),
  .mcu_fsr1_cfgtx_enidl     (mcu3_fsr7_cfgtx_enidl       ),
  .mcu_fsr0_cfgtx_invpair   (mcu3_fsr6_cfgtx_invpair[ 9 : 0 ]),
  .mcu_fsr1_cfgtx_invpair   (mcu3_fsr7_cfgtx_invpair[ 9 : 0 ]),
  .mcu_fsr01_cfgtx_enftp    (mcu3_fsr67_cfgtx_enftp      ),
  .mcu_fsr01_cfgtx_de       (mcu3_fsr67_cfgtx_de[ 3 : 0 ]    ),
  .mcu_fsr01_cfgtx_swing    (mcu3_fsr67_cfgtx_swing[ 2 : 0 ] ),
  .mcu_fsr01_cfgtx_cm       (mcu3_fsr67_cfgtx_cm         ),
  .mcu_fsr01_cfgrtx_rate    (mcu3_fsr67_cfgrtx_rate[ 1 : 0 ] ),
  .mcu_fsr0_cfgrx_entest    (mcu3_fsr6_cfgrx_entest      ),
  .mcu_fsr1_cfgrx_entest    (mcu3_fsr7_cfgrx_entest      ),
  .mcu_fsr0_cfgtx_entest    (mcu3_fsr6_cfgtx_entest      ),
  .mcu_fsr1_cfgtx_entest    (mcu3_fsr7_cfgtx_entest      ),
  .mcu_fsr0_cfgtx_bstx      (mcu3_fsr6_cfgtx_bstx[ 9 : 0 ]   ),
  .mcu_fsr1_cfgtx_bstx      (mcu3_fsr7_cfgtx_bstx[ 9 : 0 ]   ),
  .fsr0_mcu_data            (fsr6_mcu3_data[ 167 : 0 ]       ),
  .fsr1_mcu_data            (fsr7_mcu3_data[ 167 : 0 ]       ),
  .fsr0_mcu_rxbclk          (fsr6_mcu3_rxbclk[ 13 : 0 ]      ),
  .fsr1_mcu_rxbclk          (fsr7_mcu3_rxbclk[ 13 : 0 ]      ),
  .fsr0_mcu_stspll_lock     (fsr6_mcu3_stspll_lock[ 2 : 0 ]  ),
  .fsr1_mcu_stspll_lock     (fsr7_mcu3_stspll_lock[ 2 : 0 ]  ),
  .mcu_fsr0_testcfg         (mcu3_fsr6_testcfg[ 11 : 0 ]     ),
  .mcu_fsr1_testcfg         (mcu3_fsr7_testcfg[ 11 : 0 ]     ),
  .fsr0_mcu_stsrx_sync      ({fsr6_mcu3_stsrx_sync[ 9 : 8 ],fsr6_mcu3_stsrx_sync[ 0 ], fsr6_mcu3_stsrx_sync[ 1 ],
			      fsr6_mcu3_stsrx_sync[ 2 ],  fsr6_mcu3_stsrx_sync[ 3 ], fsr6_mcu3_stsrx_sync[ 4 ],
			      fsr6_mcu3_stsrx_sync[ 5 ],  fsr6_mcu3_stsrx_sync[ 6 ], fsr6_mcu3_stsrx_sync[ 7 ],
			      fsr6_mcu3_stsrx_sync[ 10 ], fsr6_mcu3_stsrx_sync[ 11 ],fsr6_mcu3_stsrx_sync[ 12 ],
			      fsr6_mcu3_stsrx_sync[ 13 ]}),
  .fsr1_mcu_stsrx_sync      ({fsr7_mcu3_stsrx_sync[ 8 ],    fsr7_mcu3_stsrx_sync[ 9 ],
			      fsr7_mcu3_stsrx_sync[ 13 : 10 ],fsr7_mcu3_stsrx_sync[ 7 : 0 ]}),
  .fsr0_mcu_stsrx_losdtct   ({fsr6_mcu3_stsrx_losdtct[ 9 : 8 ],fsr6_mcu3_stsrx_losdtct[ 0 ], fsr6_mcu3_stsrx_losdtct[ 1 ],
			      fsr6_mcu3_stsrx_losdtct[ 2 ],  fsr6_mcu3_stsrx_losdtct[ 3 ], fsr6_mcu3_stsrx_losdtct[ 4 ],
			      fsr6_mcu3_stsrx_losdtct[ 5 ],  fsr6_mcu3_stsrx_losdtct[ 6 ], fsr6_mcu3_stsrx_losdtct[ 7 ],
			      fsr6_mcu3_stsrx_losdtct[ 10 ], fsr6_mcu3_stsrx_losdtct[ 11 ],fsr6_mcu3_stsrx_losdtct[ 12 ],
			      fsr6_mcu3_stsrx_losdtct[ 13 ]}),
  .fsr1_mcu_stsrx_losdtct   ({fsr7_mcu3_stsrx_losdtct[ 8 ],    fsr7_mcu3_stsrx_losdtct[ 9 ],
			      fsr7_mcu3_stsrx_losdtct[ 13 : 10 ],fsr7_mcu3_stsrx_losdtct[ 7 : 0 ]}),
  .fsr0_mcu_stsrx_testfail  (fsr6_mcu3_stsrx_testfail[ 13 : 0 ]),
  .fsr1_mcu_stsrx_testfail  (fsr7_mcu3_stsrx_testfail[ 13 : 0 ]),
  .fsr0_mcu_stsrx_bsrxp     (fsr6_mcu3_stsrx_bsrxp[ 13 : 0 ] ),
  .fsr1_mcu_stsrx_bsrxp     (fsr7_mcu3_stsrx_bsrxp[ 13 : 0 ] ),
  .fsr0_mcu_stsrx_bsrxn     (fsr6_mcu3_stsrx_bsrxn[ 13 : 0 ] ),
  .fsr1_mcu_stsrx_bsrxn     (fsr7_mcu3_stsrx_bsrxn[ 13 : 0 ] ),
  .fsr0_mcu_ststx_testfail  (fsr6_mcu3_ststx_testfail[ 9 : 0 ]),
  .fsr1_mcu_ststx_testfail  (fsr7_mcu3_ststx_testfail[ 9 : 0 ]),
  .mcu_id                   ({1'b1,1'b1}                 ),
  .tcu_mcu_mbist_start      (tcu_mcu3_mbist_start        ),
  .mcu_tcu_mbist_done       (mcu3_tcu_mbist_done         ),
  .mcu_tcu_mbist_fail       (mcu3_tcu_mbist_fail         ),
  .tcu_mcu_mbist_scan_in    (tcu_mcu3_mbist_scan_in      ),
  .mcu_tcu_mbist_scan_out   (mcu3_tcu_mbist_scan_out     ),
  .mcu_sbs_scan_in          (mac_mcu_3_sbs_output	 ),		// 03/24
  .mcu_sbs_scan_out         (mcu3_sbs_scan_out           ),
  .scan_in                  (ncu_scan_out                ),
  .scan_out                 (mcu3_scan_out               ),
  .ncu_mcu_pm(ncu_mcu_pm),
  .ncu_mcu_ba01(ncu_mcu_ba01),
  .ncu_mcu_ba23(ncu_mcu_ba23),
  .ncu_mcu_ba45(ncu_mcu_ba45),
  .ncu_mcu_ba67(ncu_mcu_ba67),
  .tcu_mbist_bisi_en(tcu_mbist_bisi_en),
  .tcu_mbist_user_mode(tcu_mbist_user_mode),
  .tcu_sbs_scan_en(tcu_sbs_scan_en),
  .tcu_sbs_aclk(tcu_sbs_aclk),
  .tcu_sbs_bclk(tcu_sbs_bclk),
  .tcu_sbs_clk(tcu_sbs_clk),
  .tcu_sbs_uclk(tcu_sbs_uclk),
  .rst_mcu_selfrsh(rst_mcu_selfrsh),
  .rst_wmr_protect(rst_wmr_protect),
  .tcu_aclk(tcu_aclk),
  .tcu_bclk(tcu_bclk),
  .tcu_pce_ov(tcu_pce_ov),
  .tcu_dectest(tcu_dectest),
  .tcu_muxtest(tcu_muxtest),
  .tcu_mcu_testmode(tcu_mcu_testmode),
  .tcu_scan_en(tcu_scan_en),
  .tcu_se_scancollar_in(tcu_se_scancollar_in),
  .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
  .tcu_array_bypass(tcu_array_bypass),
  .tcu_atpg_mode(tcu_atpg_mode),
  .tcu_div_bypass(tcu_div_bypass),
  .ccu_serdes_dtm(ccu_serdes_dtm)
         );     

//________________________________________________________________

*/


endmodule // eqed_ost2


