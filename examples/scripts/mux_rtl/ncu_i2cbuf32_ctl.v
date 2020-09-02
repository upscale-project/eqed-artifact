// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: ncu_i2cbuf32_ctl.v
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
// ========== Copyright Header End ============================================
`define RF_RDEN_OFFSTATE            1'b1

//====================================
`define NCU_INTMANRF_DEPTH         128
`define NCU_INTMANRF_DATAWIDTH      16
`define NCU_INTMANRF_ADDRWIDTH       7
//====================================

//====================================
`define NCU_MONDORF_DEPTH           64
`define NCU_MONDORF_DATAWIDTH       72
`define NCU_MONDORF_ADDRWIDTH        6
//====================================

//====================================
`define NCU_CPUBUFRF_DEPTH          32
`define NCU_CPUBUFRF_DATAWIDTH     144
`define NCU_CPUBUFRF_ADDRWIDTH       5
//====================================

//====================================
`define NCU_IOBUFRF_DEPTH          32
`define NCU_IOBUFRF_DATAWIDTH     144
`define NCU_IOBUFRF_ADDRWIDTH       5
//====================================

//====================================
`define NCU_IOBUF1RF_DEPTH          32
`define NCU_IOBUF1RF_DATAWIDTH      32
`define NCU_IOBUF1RF_ADDRWIDTH       5
//====================================

//====================================
`define NCU_INTBUFRF_DEPTH          32
`define NCU_INTBUFRF_DATAWIDTH     144
`define NCU_INTBUFRF_ADDRWIDTH       5
//====================================

//== fix me : need to remove when warm //
//== becomes available //
`define WMR_LENGTH		10'd999
`define WMR_LENGTH_P1		10'd1000

//// NCU CSR_MAN address   80_0000_xxxx ////
`define NCU_CSR_MAN			16'h0000
`define NCU_CREG_INTMAN			16'h0000
//`define NCU_CREG_INTVECDISP		16'h0800
`define NCU_CREG_MONDOINVEC		16'h0a00
`define NCU_CREG_SERNUM			16'h1000
`define NCU_CREG_FUSESTAT		16'h1008
`define NCU_CREG_COREAVAIL		16'h1010
`define NCU_CREG_BANKAVAIL		16'h1018
`define NCU_CREG_BANK_ENABLE		16'h1020
`define NCU_CREG_BANK_ENABLE_STATUS 	16'h1028
`define NCU_CREG_L2_HASH_ENABLE		16'h1030
`define NCU_CREG_L2_HASH_ENABLE_STATUS	16'h1038


`define NCU_CREG_MEM32_BASE	16'h2000
`define NCU_CREG_MEM32_MASK	16'h2008
`define NCU_CREG_MEM64_BASE	16'h2010
`define NCU_CREG_MEM64_MASK	16'h2018
`define NCU_CREG_IOCON_BASE	16'h2020
`define NCU_CREG_IOCON_MASK	16'h2028
`define NCU_CREG_MMUFSH		16'h2030

`define NCU_CREG_ESR		16'h3000
`define NCU_CREG_ELE		16'h3008
`define NCU_CREG_EIE		16'h3010
`define NCU_CREG_EJR		16'h3018
`define NCU_CREG_FEE		16'h3020
`define NCU_CREG_PER		16'h3028
`define NCU_CREG_SIISYN		16'h3030
`define NCU_CREG_NCUSYN		16'h3038
`define NCU_CREG_SCKSEL         16'h3040
`define NCU_CREG_DBGTRIG_EN     16'h4000

//// NUC CSR_MONDO address 80_0004_xxxx ////
`define NCU_CSR_MONDO		16'h0004
`define NCU_CREG_MDATA0  	16'h0000 
`define NCU_CREG_MDATA1  	16'h0200 
`define NCU_CREG_MDATA0_ALIAS	16'h0400 
`define NCU_CREG_MDATA1_ALIAS	16'h0600 
`define NCU_CREG_MBUSY		16'h0800 
`define NCU_CREG_MBUSY_ALIAS	16'h0a00 



// ASI shared reg 90_xxxx_xxxx//
`define NCU_ASI_A_HIT			10'h104 // 6-bits cpuid and thread id are "x"
`define NCU_ASI_B_HIT			10'h1CC // 6-bits cpuid and thread id are "x"
`define NCU_ASI_C_HIT			10'h114	// 6-bits cpuid and thread id are "x"
`define NCU_ASI_COREAVAIL		16'h0000
`define NCU_ASI_CORE_ENABLE_STATUS	16'h0010
`define NCU_ASI_CORE_ENABLE		16'h0020
`define NCU_ASI_XIR_STEERING		16'h0030
`define NCU_ASI_CORE_RUNNINGRW		16'h0050
`define NCU_ASI_CORE_RUNNING_STATUS	16'h0058
`define NCU_ASI_CORE_RUNNING_W1S	16'h0060
`define NCU_ASI_CORE_RUNNING_W1C	16'h0068
`define NCU_ASI_INTVECDISP		16'h0000
`define NCU_ASI_ERR_STR                 16'h1000
`define NCU_ASI_WMR_VEC_MASK            16'h0018
`define NCU_ASI_CMP_TICK_ENABLE		16'h0038


//// UCB packet type ////
`define UCB_READ_NACK	4'b0000    // ack/nack types
`define UCB_READ_ACK	4'b0001
`define UCB_WRITE_ACK	4'b0010
`define UCB_IFILL_ACK	4'b0011
`define UCB_IFILL_NACK	4'b0111

`define UCB_READ_REQ	4'b0100    // req types
`define UCB_WRITE_REQ	4'b0101
`define UCB_IFILL_REQ	4'b0110

`define UCB_INT		4'b1000    // plain interrupt
`define UCB_INT_VEC	4'b1100    // interrupt with vector
`define UCB_INT_SOC_UE	4'b1001    // soc interrup ue
`define UCB_INT_SOC_CE  4'b1010    // soc interrup ce
`define UCB_RESET_VEC	4'b0101    // reset with vector
`define UCB_IDLE_VEC	4'b1110    // idle with vector
`define UCB_RESUME_VEC	4'b1111    // resume with vector

`define UCB_INT_SOC 	4'b1101    // soc interrup ce


//// PCX packet type ////
`define	PCX_LOAD_RQ	5'b00000
`define	PCX_IMISS_RQ	5'b10000
`define	PCX_STORE_RQ	5'b00001
`define PCX_FWD_RQs	5'b01101
`define PCX_FWD_RPYs	5'b01110

//// CPX packet type ////
//`define CPX_LOAD_RET	4'b0000
`define CPX_LOAD_RET	4'b1000
`define CPX_ST_ACK	4'b0100
//`define CPX_IFILL_RET	4'b0001
`define CPX_IFILL_RET	4'b1001
`define CPX_INT_RET	4'b0111
`define CPX_INT_SOC	4'b1101
//`define CPX_FWD_RQ_RET	4'b1010
//`define CPX_FWD_RPY_RET	4'b1011




//// Global CSR decode ////
`define NCU_CSR		8'h80
`define NIU_CSR		8'h81
//`define RNG_CSR		8'h82
`define DBG1_CSR               8'h86
`define CCU_CSR		8'h83
`define MCU_CSR		8'h84
`define TCU_CSR		8'h85
`define DMU_CSR		8'h88
`define RCU_CSR		8'h89
`define NCU_ASI		8'h90
			/////8'h91 ~ 9F reserved
			/////8'hA0 ~ BF L2 CSR////
`define DMU_PIO		4'hC   // C0 ~ CF
			/////8'hB0 ~ FE reserved
`define SSI_CSR		8'hFF


//// NCU_SSI ////
`define SSI_ADDR 	 	12'hFF_F
`define SSI_ADDR_TIMEOUT_REG	40'hFF_0001_0088
`define SSI_ADDR_LOG_REG	40'hFF_0000_0018

`define IF_IDLE 2'b00
`define IF_ACPT 2'b01
`define IF_DROP 2'b10

`define SSI_IDLE     3'b000
`define	SSI_REQ      3'b001
`define	SSI_WDATA    3'b011
`define	SSI_REQ_PAR  3'b101
`define	SSI_ACK      3'b111
`define	SSI_RDATA    3'b110
`define	SSI_ACK_PAR  3'b010










module ncu_i2cbuf32_ctl (
  iol2clk, 
  scan_in, 
  scan_out, 
  tcu_pce_ov, 
  tcu_clk_stop, 
  tcu_scan_en, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_dbr_gateoff, 
  ucb_iob_vld, 
  ucb_iob_data, 
  iob_ucb_stall, 
  req_ack_obj, 
  req_ack_vld, 
  rd_req_ack_dbl_buf, 
  int_obj, 
  int_vld, 
  rd_int_dbl_buf) ;
wire stall_d1_n;
wire stall_d1;
wire vld_d1_ff_scanin;
wire vld_d1_ff_scanout;
wire vld_d1;
wire l1clk;
wire rdy1;
wire data_d1_ff_scanin;
wire data_d1_ff_scanout;
wire [31:0] data_d1;
wire iob_ucb_stall_f;
wire stall_ff_scanin;
wire stall_ff_scanout;
wire iob_ucb_stall_a1;
wire stall_d1_ff_scanin;
wire stall_d1_ff_scanout;
wire rdy0_ff_scanin;
wire rdy0_ff_scanout;
wire rdy0;
wire rdy1_ff_scanin;
wire rdy1_ff_scanout;
wire skid_buf0_en;
wire vld_buf0_ff_scanin;
wire vld_buf0_ff_scanout;
wire vld_buf0;
wire data_buf0_ff_scanin;
wire data_buf0_ff_scanout;
wire [31:0] data_buf0;
wire skid_buf1_en_ff_scanin;
wire skid_buf1_en_ff_scanout;
wire skid_buf1_en;
wire vld_buf1_ff_scanin;
wire vld_buf1_ff_scanout;
wire vld_buf1;
wire data_buf1_ff_scanin;
wire data_buf1_ff_scanout;
wire [31:0] data_buf1;
wire skid_buf0_sel;
wire skid_buf1_sel_ff_scanin;
wire skid_buf1_sel_ff_scanout;
wire skid_buf1_sel;
wire vld_mux;
wire [31:0] data_mux;
wire [3:0] indata_vec_next;
wire [3:0] indata_vec;
wire iob_ucb_stall_a1_n;
wire indata_vec_ff_scanin;
wire indata_vec_ff_scanout;
wire [127:0] indata_buf_next;
wire [127:0] indata_buf;
wire indata_buf_ff_scanin;
wire indata_buf_ff_scanout;
wire indata_vec0_d1_ff_scanin;
wire indata_vec0_d1_ff_scanout;
wire indata_vec0_d1;
wire indata_buf_vld;
wire req_ack_pending;
wire int_type;
wire int_pending;
wire req_ack_dbl_buf_full;
wire int_dbl_buf_full;
wire wr_req_ack_dbl_buf;
wire a_wr_buf0;
wire a_buf1_vld;
wire a_buf0_vld;
wire a_buf1_older;
wire a_wr_buf1;
wire a_rd_buf0;
wire a_rd_buf1;
wire a_rd_buf;
wire a_buf1_older_n;
wire a_buf1_older_ff_scanin;
wire a_buf1_older_ff_scanout;
wire a_en_vld0;
wire a_en_vld1;
wire a_buf0_vld_ff_scanin;
wire a_buf0_vld_ff_scanout;
wire a_buf1_vld_ff_scanin;
wire a_buf1_vld_ff_scanout;
wire a_buf0_obj_ff_scanin;
wire a_buf0_obj_ff_scanout;
wire [127:0] a_buf0_obj;
wire a_buf1_obj_ff_scanin;
wire a_buf1_obj_ff_scanout;
wire [127:0] a_buf1_obj;
wire wr_int_dbl_buf;
wire i_wr_buf0;
wire i_buf1_vld;
wire i_buf0_vld;
wire i_buf1_older;
wire i_wr_buf1;
wire i_rd_buf0;
wire i_rd_buf1;
wire i_rd_buf;
wire i_buf1_older_n;
wire i_buf1_older_ff_scanin;
wire i_buf1_older_ff_scanout;
wire i_en_vld0;
wire i_en_vld1;
wire i_buf0_vld_ff_scanin;
wire i_buf0_vld_ff_scanout;
wire i_buf1_vld_ff_scanin;
wire i_buf1_vld_ff_scanout;
wire i_buf0_obj_ff_scanin;
wire i_buf0_obj_ff_scanout;
wire [24:0] i_buf0_obj;
wire i_buf1_obj_ff_scanin;
wire i_buf1_obj_ff_scanout;
wire [24:0] i_buf1_obj;
wire siclk;
wire soclk;
wire se;
wire pce_ov;
wire stop;


   // Global interface
input		iol2clk;
input		scan_in;
output		scan_out;
input		tcu_pce_ov;
input		tcu_clk_stop;
input		tcu_scan_en;
input		tcu_aclk;
input		tcu_bclk;
input		tcu_dbr_gateoff;

   // UCB interface
input		ucb_iob_vld;
input [31:0]	ucb_iob_data;
output		iob_ucb_stall;

   // i2c slow control/datapath interface
output [127:0]	req_ack_obj;
output		req_ack_vld;
input		rd_req_ack_dbl_buf;

output [24:0]	int_obj;
output		int_vld;
input		rd_int_dbl_buf;

   // Internal signals


/************************************************************
 * Assemble inbound packet
 ************************************************************/
//ucb_bus_in /*#(UCB_BUS_WIDTH)*/ ucb_bus_in (
//					.clk(iol2clk),
//					.vld(ucb_iob_vld),
//					.data(ucb_iob_data[UCB_BUS_WIDTH-1:0]),
//					.stall(iob_ucb_stall),
//					.indata_buf_vld(indata_buf_vld),
//					.indata_buf(indata_buf[127:0]),
//					.stall_a1(iob_ucb_stall_a1));
//=============================================================
//=============================================================
//======================================== ucb_bus_in =========
/************************************************************
 * UCB bus interface flops
 * This is to make signals going between IOB and UCB flop-to-flop
 * to improve timing.
 ************************************************************/
assign	stall_d1_n = ~stall_d1 ;
ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 vld_d1_ff  
				(
				.scan_in(vld_d1_ff_scanin),
				.scan_out(vld_d1_ff_scanout),
				.dout		(vld_d1),
				.l1clk		(l1clk),
				.en		(stall_d1_n &rdy1),
				.din		(ucb_iob_vld),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_32 data_d1_ff  
				(
				.scan_in(data_d1_ff_scanin),
				.scan_out(data_d1_ff_scanout),
				.dout		(data_d1[31:0]),
				.l1clk		(l1clk),
				.en		(stall_d1_n),
				.din		(ucb_iob_data[31:0]),
  .siclk(siclk),
  .soclk(soclk)
				);

assign iob_ucb_stall = iob_ucb_stall_f & tcu_dbr_gateoff;
ncu_i2cbuf32_ctl_msff_ctl_macro__width_1 stall_ff 
				(
				.scan_in(stall_ff_scanin),
				.scan_out(stall_ff_scanout),
				.dout		(iob_ucb_stall_f),
				.l1clk		(l1clk),
				.din		(iob_ucb_stall_a1),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__width_1 stall_d1_ff 
				(
				.scan_in(stall_d1_ff_scanin),
				.scan_out(stall_d1_ff_scanout),
				.dout		(stall_d1),
				.l1clk		(l1clk),
				.din		(iob_ucb_stall),
  .siclk(siclk),
  .soclk(soclk)
				);


ncu_i2cbuf32_ctl_msff_ctl_macro__width_1 rdy0_ff 
				(
				.scan_in(rdy0_ff_scanin),
				.scan_out(rdy0_ff_scanout),
				.dout		(rdy0),
				.l1clk		(l1clk),
				.din		(1'b1),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__width_1 rdy1_ff 
				(
				.scan_in(rdy1_ff_scanin),
				.scan_out(rdy1_ff_scanout),
				.dout		(rdy1),
				.l1clk		(l1clk),
				.din		(rdy0),
  .siclk(siclk),
  .soclk(soclk)
				);

/************************************************************
 * Skid buffer
 * We need a two deep skid buffer to handle stalling.
 ************************************************************/
// Assertion: stall has to be deasserted for more than 1 cycle
//            ie time between two separate stalls has to be
//            at least two cycles.  Otherwise, contents from
//            skid buffer will be lost.

// Buffer 0
assign  skid_buf0_en = iob_ucb_stall_a1 & ~iob_ucb_stall;

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 vld_buf0_ff  
				(
				.scan_in(vld_buf0_ff_scanin),
				.scan_out(vld_buf0_ff_scanout),
				.dout		(vld_buf0),
				.l1clk		(l1clk),
				.en		(skid_buf0_en),
				.din		(vld_d1),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_32 data_buf0_ff  
				(
				.scan_in(data_buf0_ff_scanin),
				.scan_out(data_buf0_ff_scanout),
				.dout		(data_buf0[31:0]),
				.l1clk		(l1clk),
				.en		(skid_buf0_en),
				.din		(data_d1[31:0]),
  .siclk(siclk),
  .soclk(soclk)
				);

// Buffer 1
ncu_i2cbuf32_ctl_msff_ctl_macro__width_1 skid_buf1_en_ff 
				(
				.scan_in(skid_buf1_en_ff_scanin),
				.scan_out(skid_buf1_en_ff_scanout),
				.dout		(skid_buf1_en),
				.l1clk		(l1clk),
				.din		(skid_buf0_en),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 vld_buf1_ff  
				(
				.scan_in(vld_buf1_ff_scanin),
				.scan_out(vld_buf1_ff_scanout),
				.dout		(vld_buf1),
				.l1clk		(l1clk),
				.en		(skid_buf1_en),
				.din		(vld_d1),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_32 data_buf1_ff  
				(
				.scan_in(data_buf1_ff_scanin),
				.scan_out(data_buf1_ff_scanout),
				.dout		(data_buf1[31:0]),
				.l1clk		(l1clk),
				.en		(skid_buf1_en),
				.din		(data_d1[31:0]),
  .siclk(siclk),
  .soclk(soclk)
				);
/************************************************************
 * Mux between skid buffer and interface flop
 ************************************************************/
// Assertion: stall has to be deasserted for more than 1 cycle
//            ie time between two separate stalls has to be
//            at least two cycles.  Otherwise, contents from
//            skid buffer will be lost.

assign  skid_buf0_sel = ~iob_ucb_stall_a1 & iob_ucb_stall;

ncu_i2cbuf32_ctl_msff_ctl_macro__width_1 skid_buf1_sel_ff 
				(
				.scan_in(skid_buf1_sel_ff_scanin),
				.scan_out(skid_buf1_sel_ff_scanout),
				.dout		(skid_buf1_sel),
				.l1clk		(l1clk),
				.din		(skid_buf0_sel),
  .siclk(siclk),
  .soclk(soclk)
				);

assign  vld_mux = skid_buf0_sel ? vld_buf0 : 
	          skid_buf1_sel ? vld_buf1 : vld_d1;

assign  data_mux[31:0] = skid_buf0_sel ? data_buf0[31:0] : 
			 skid_buf1_sel ? data_buf1[31:0] : data_d1[31:0];

/************************************************************
 * Assemble inbound data
 ************************************************************/
// valid vector
assign  indata_vec_next[3:0] = {vld_mux,indata_vec[3:1]};

assign	iob_ucb_stall_a1_n = ~iob_ucb_stall_a1;
ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_4 indata_vec_ff  
				(
				.scan_in(indata_vec_ff_scanin),
				.scan_out(indata_vec_ff_scanout),
				.dout		(indata_vec[3:0]),
				.l1clk		(l1clk),
				.en		(iob_ucb_stall_a1_n),
				.din		(indata_vec_next[3:0]),
  .siclk(siclk),
  .soclk(soclk)
				);

// data buffer
assign  indata_buf_next[127:0] = {data_mux[31:0], indata_buf[127:32]};
ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_128 indata_buf_ff  
				(
				.scan_in(indata_buf_ff_scanin),
				.scan_out(indata_buf_ff_scanout),
				.dout		(indata_buf[127:0]),
				.l1clk		(l1clk),
				.en		(iob_ucb_stall_a1_n),
				.din		(indata_buf_next[127:0]),
  .siclk(siclk),
  .soclk(soclk)
				);

// detect a new packet	  
ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 indata_vec0_d1_ff  
				(
				.scan_in(indata_vec0_d1_ff_scanin),
				.scan_out(indata_vec0_d1_ff_scanout),
				.dout		(indata_vec0_d1),
				.l1clk		(l1clk),
				.en		(iob_ucb_stall_a1_n),
				.din		(indata_vec[0]),
  .siclk(siclk),
  .soclk(soclk)
				);

assign  indata_buf_vld = indata_vec[0] & ~indata_vec0_d1;
//======================================== ucb_bus_in =========
//=============================================================
//=============================================================



/************************************************************
 * Decode inbound packet type
 ************************************************************/
   // non-interrupt packet
assign	req_ack_pending = ~int_type & indata_buf_vld;

   // interrupt packet
assign 	 int_type = ((indata_buf[3:0] == `UCB_INT) |
		     (indata_buf[3:0] == `UCB_INT_VEC) |
		     (indata_buf[3:0] == `UCB_RESET_VEC) |
		     (indata_buf[3:0] == `UCB_IDLE_VEC) |
		     (indata_buf[3:0] == `UCB_RESUME_VEC) );
		       
assign 	 int_pending = int_type & indata_buf_vld;

assign 	 iob_ucb_stall_a1 = (req_ack_pending & req_ack_dbl_buf_full) |
				    (int_pending & int_dbl_buf_full);


/************************************************************
 * Double buffer to store non-interrupt packets
 ************************************************************/
assign 	 wr_req_ack_dbl_buf = req_ack_pending & ~req_ack_dbl_buf_full;

//dbl_buf /*#(128)*/ req_ack_dbl_buf (
//				 .clk(iol2clk),
//				 .wr(wr_req_ack_dbl_buf),
//				 .din(indata_buf[127:0]),
//				 .rd(rd_req_ack_dbl_buf),
//				 .dout(req_ack_obj[127:0]),
//				 .vld(req_ack_vld),
//				 .full(req_ack_dbl_buf_full));
//=============================================================
//=============================================================
//========================================== dbl_buf ==========

// if both entries are empty, write to entry pointed to by the older pointer
assign	a_wr_buf0 = wr_req_ack_dbl_buf & (a_buf1_vld | (~a_buf0_vld & ~a_buf1_older));
assign	a_wr_buf1 = wr_req_ack_dbl_buf & (a_buf0_vld | (~a_buf1_vld & a_buf1_older));

// read from the older entry
assign	a_rd_buf0 = rd_req_ack_dbl_buf & ~a_buf1_older;
assign	a_rd_buf1 = rd_req_ack_dbl_buf &  a_buf1_older;

// flip older pointer when an entry is read
assign	a_rd_buf = rd_req_ack_dbl_buf & (a_buf0_vld | a_buf1_vld);
assign	a_buf1_older_n = ~a_buf1_older;
ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 a_buf1_older_ff  
				(
				.scan_in(a_buf1_older_ff_scanin),
				.scan_out(a_buf1_older_ff_scanout),
				.dout		(a_buf1_older),
				.l1clk		(l1clk),
				.en		(a_rd_buf),
				.din		(a_buf1_older_n),
  .siclk(siclk),
  .soclk(soclk)
				);

// set valid bit for writes and reset for reads
assign	a_en_vld0 = a_wr_buf0 | a_rd_buf0;
assign	a_en_vld1 = a_wr_buf1 | a_rd_buf1;

// the actual buffers
ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 a_buf0_vld_ff  
				(
				.scan_in(a_buf0_vld_ff_scanin),
				.scan_out(a_buf0_vld_ff_scanout),
				.dout		(a_buf0_vld),
				.l1clk		(l1clk),
				.en		(a_en_vld0),
				.din		(a_wr_buf0),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 a_buf1_vld_ff  
				(
				.scan_in(a_buf1_vld_ff_scanin),
				.scan_out(a_buf1_vld_ff_scanout),
				.dout		(a_buf1_vld),
				.l1clk		(l1clk),
				.en		(a_en_vld1),
				.din		(a_wr_buf1),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_128 a_buf0_obj_ff  
				(
				.scan_in(a_buf0_obj_ff_scanin),
				.scan_out(a_buf0_obj_ff_scanout),
				.dout		(a_buf0_obj[127:0]),
				.l1clk		(l1clk),
				.en		(a_wr_buf0),
				.din		(indata_buf[127:0]),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_128 a_buf1_obj_ff  
				(
				.scan_in(a_buf1_obj_ff_scanin),
				.scan_out(a_buf1_obj_ff_scanout),
				.dout		(a_buf1_obj[127:0]),
				.l1clk		(l1clk),
				.en		(a_wr_buf1),
				.din		(indata_buf[127:0]),
  .siclk(siclk),
  .soclk(soclk)
				);

// mux out the older entry
assign	req_ack_obj[127:0] = (a_buf1_older) ? a_buf1_obj[127:0] : a_buf0_obj[127:0] ;

assign	req_ack_vld = a_buf0_vld | a_buf1_vld;
assign	req_ack_dbl_buf_full = a_buf0_vld & a_buf1_vld;
//========================================== dbl_buf ==========
//=============================================================
//=============================================================

	  


/************************************************************
 * Double buffer to store interrupt packets
 ************************************************************/
assign 	 wr_int_dbl_buf = int_pending & ~int_dbl_buf_full;

//dbl_buf /*#(64)*/ int_dbl_buf (
//				 .clk(iol2clk),
//				 .wr(wr_int_dbl_buf),
//				 .din(indata_buf[63:0]),
//				 .rd(rd_int_dbl_buf),
//				 .dout(int_obj[63:0]),
//				 .vld(int_vld),
//				 .full(int_dbl_buf_full));

//=============================================================
//=============================================================
//======================================= dbl_buf =============

// if both entries are empty, write to entry pointed to by the older pointer
assign	i_wr_buf0 = wr_int_dbl_buf & (i_buf1_vld | (~i_buf0_vld & ~i_buf1_older));
assign	i_wr_buf1 = wr_int_dbl_buf & (i_buf0_vld | (~i_buf1_vld & i_buf1_older));

// read from the older entry
assign	i_rd_buf0 = rd_int_dbl_buf & ~i_buf1_older;
assign	i_rd_buf1 = rd_int_dbl_buf &  i_buf1_older;

// flip older pointer when an entry is read
assign	i_rd_buf = rd_int_dbl_buf & (i_buf0_vld | i_buf1_vld);
assign	i_buf1_older_n = ~i_buf1_older;
ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 i_buf1_older_ff  
				(
				.scan_in(i_buf1_older_ff_scanin),
				.scan_out(i_buf1_older_ff_scanout),
				.dout		(i_buf1_older),
				.l1clk		(l1clk),
				.en		(i_rd_buf),
				.din		(i_buf1_older_n),
  .siclk(siclk),
  .soclk(soclk)
				);

// set valid bit for writes and reset for reads
assign	i_en_vld0 = i_wr_buf0 | i_rd_buf0;
assign	i_en_vld1 = i_wr_buf1 | i_rd_buf1;

// the actual buffers
ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 i_buf0_vld_ff  
				(
				.scan_in(i_buf0_vld_ff_scanin),
				.scan_out(i_buf0_vld_ff_scanout),
				.dout		(i_buf0_vld),
				.l1clk		(l1clk),
				.en		(i_en_vld0),
				.din		(i_wr_buf0),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 i_buf1_vld_ff  
				(
				.scan_in(i_buf1_vld_ff_scanin),
				.scan_out(i_buf1_vld_ff_scanout),
				.dout		(i_buf1_vld),
				.l1clk		(l1clk),
				.en		(i_en_vld1),
				.din		(i_wr_buf1),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_25 i_buf0_obj_ff  
				(
				.scan_in(i_buf0_obj_ff_scanin),
				.scan_out(i_buf0_obj_ff_scanout),
				.dout		(i_buf0_obj[24:0]),
				.l1clk		(l1clk),
				.en		(i_wr_buf0),
				.din		({indata_buf[56:51],indata_buf[18:0]}),
  .siclk(siclk),
  .soclk(soclk)
				);

ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_25 i_buf1_obj_ff  
				(
				.scan_in(i_buf1_obj_ff_scanin),
				.scan_out(i_buf1_obj_ff_scanout),
				.dout		(i_buf1_obj[24:0]),
				.l1clk		(l1clk),
				.en		(i_wr_buf1),
				.din		({indata_buf[56:51],indata_buf[18:0]}),
  .siclk(siclk),
  .soclk(soclk)
				);

// mux out the older entry
assign	int_obj[24:0] = (i_buf1_older) ? i_buf1_obj[24:0] : i_buf0_obj[24:0] ;

assign	int_vld = i_buf0_vld | i_buf1_vld;
assign	int_dbl_buf_full = i_buf0_vld & i_buf1_vld;
//=========================================== dbl_buf =========
//=============================================================
//=============================================================

	  




/**** adding clock header ****/
ncu_i2cbuf32_ctl_l1clkhdr_ctl_macro clkgen (
				.l2clk	(iol2clk),
				.l1en	(1'b1),
				.l1clk	(l1clk),
  .pce_ov(pce_ov),
  .stop(stop),
  .se(se)
				);

/*** building tcu port ***/
assign	siclk = tcu_aclk;
assign	soclk = tcu_bclk;
assign	   se = tcu_scan_en;
assign	pce_ov = tcu_pce_ov;
assign	stop = tcu_clk_stop;

// fixscan start:
assign vld_d1_ff_scanin          = scan_in                  ;
assign data_d1_ff_scanin         = vld_d1_ff_scanout        ;
assign stall_ff_scanin           = data_d1_ff_scanout       ;
assign stall_d1_ff_scanin        = stall_ff_scanout         ;
assign rdy0_ff_scanin            = stall_d1_ff_scanout      ;
assign rdy1_ff_scanin            = rdy0_ff_scanout          ;
assign vld_buf0_ff_scanin        = rdy1_ff_scanout          ;
assign data_buf0_ff_scanin       = vld_buf0_ff_scanout      ;
assign skid_buf1_en_ff_scanin    = data_buf0_ff_scanout     ;
assign vld_buf1_ff_scanin        = skid_buf1_en_ff_scanout  ;
assign data_buf1_ff_scanin       = vld_buf1_ff_scanout      ;
assign skid_buf1_sel_ff_scanin   = data_buf1_ff_scanout     ;
assign indata_vec_ff_scanin      = skid_buf1_sel_ff_scanout ;
assign indata_buf_ff_scanin      = indata_vec_ff_scanout    ;
assign indata_vec0_d1_ff_scanin  = indata_buf_ff_scanout    ;
assign a_buf1_older_ff_scanin    = indata_vec0_d1_ff_scanout;
assign a_buf0_vld_ff_scanin      = a_buf1_older_ff_scanout  ;
assign a_buf1_vld_ff_scanin      = a_buf0_vld_ff_scanout    ;
assign a_buf0_obj_ff_scanin      = a_buf1_vld_ff_scanout    ;
assign a_buf1_obj_ff_scanin      = a_buf0_obj_ff_scanout    ;
assign i_buf1_older_ff_scanin    = a_buf1_obj_ff_scanout    ;
assign i_buf0_vld_ff_scanin      = i_buf1_older_ff_scanout  ;
assign i_buf1_vld_ff_scanin      = i_buf0_vld_ff_scanout    ;
assign i_buf0_obj_ff_scanin      = i_buf1_vld_ff_scanout    ;
assign i_buf1_obj_ff_scanin      = i_buf0_obj_ff_scanout    ;
assign scan_out                  = i_buf1_obj_ff_scanout    ;
// fixscan end:
endmodule // i2c_buf








// any PARAMS parms go into naming of macro

module ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_1 (
  din, 
  en, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [0:0] fdin;

  input [0:0] din;
  input en;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [0:0] dout;
  output scan_out;
assign fdin[0:0] = (din[0:0] & {1{en}}) | (dout[0:0] & ~{1{en}});






dff /*#(1)*/  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0:0]),
.si(scan_in),
.so(scan_out),
.q(dout[0:0])
);












endmodule













// any PARAMS parms go into naming of macro

module ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_32 (
  din, 
  en, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [31:0] fdin;
wire [30:0] so;

  input [31:0] din;
  input en;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [31:0] dout;
  output scan_out;
assign fdin[31:0] = (din[31:0] & {32{en}}) | (dout[31:0] & ~{32{en}});






dff /*#(32)*/  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[31:0]),
.si({scan_in,so[30:0]}),
.so({so[30:0],scan_out}),
.q(dout[31:0])
);












endmodule













// any PARAMS parms go into naming of macro

module ncu_i2cbuf32_ctl_msff_ctl_macro__width_1 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [0:0] fdin;

  input [0:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [0:0] dout;
  output scan_out;
assign fdin[0:0] = din[0:0];






dff /*#(1)*/  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0:0]),
.si(scan_in),
.so(scan_out),
.q(dout[0:0])
);












endmodule













// any PARAMS parms go into naming of macro

module ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_4 (
  din, 
  en, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [3:0] fdin;
wire [2:0] so;

  input [3:0] din;
  input en;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [3:0] dout;
  output scan_out;
assign fdin[3:0] = (din[3:0] & {4{en}}) | (dout[3:0] & ~{4{en}});






dff /*#(4)*/  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3:0]),
.si({scan_in,so[2:0]}),
.so({so[2:0],scan_out}),
.q(dout[3:0])
);












endmodule













// any PARAMS parms go into naming of macro

module ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_128 (
  din, 
  en, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [127:0] fdin;
wire [126:0] so;

  input [127:0] din;
  input en;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [127:0] dout;
  output scan_out;
assign fdin[127:0] = (din[127:0] & {128{en}}) | (dout[127:0] & ~{128{en}});






dff /*#(128)*/  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[127:0]),
.si({scan_in,so[126:0]}),
.so({so[126:0],scan_out}),
.q(dout[127:0])
);












endmodule













// any PARAMS parms go into naming of macro

module ncu_i2cbuf32_ctl_msff_ctl_macro__en_1__width_25 (
  din, 
  en, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [24:0] fdin;
wire [23:0] so;

  input [24:0] din;
  input en;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [24:0] dout;
  output scan_out;
assign fdin[24:0] = (din[24:0] & {25{en}}) | (dout[24:0] & ~{25{en}});






dff /*#(25)*/  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[24:0]),
.si({scan_in,so[23:0]}),
.so({so[23:0],scan_out}),
.q(dout[24:0])
);












endmodule













// any PARAMS parms go into naming of macro

module ncu_i2cbuf32_ctl_l1clkhdr_ctl_macro (
  l2clk, 
  l1en, 
  pce_ov, 
  stop, 
  se, 
  l1clk);


  input l2clk;
  input l1en;
  input pce_ov;
  input stop;
  input se;
  output l1clk;



 

cl_sc1_l1hdr_8x c_0 (


   .l2clk(l2clk),
   .pce(l1en),
   .l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop)
);



endmodule








