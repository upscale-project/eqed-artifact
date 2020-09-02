// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_com_dp_64x84_cust.v
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
module n2_com_dp_64x84_cust (
  wr_adr, 
  wr_en, 
  rd_adr, 
  rd_en, 
  din, 
  dout, 
  rdclk, 
  wrclk, 
  scan_in, 
  tcu_pce_ov, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_array_wr_inhibit, 
  tcu_se_scancollar_in, 
  bist_clk_mux_sel, 
  rd_pce, 
  wr_pce, 
  scan_out);
wire rd_lce;
wire wr_lce;
wire rdclk_in;
wire wrclk_in;
wire rdclk_free;
wire wrclk_free;
wire dff_wr_addr_scanin;
wire dff_wr_addr_scanout;
wire [5:0] wr_adr_d1;
wire [5:1] dff_rd_addr_scan;
wire dff_rd_addr_scanin;
wire dff_rd_addr_scanout;
wire [5:0] rd_adr_d1;
wire [5:0] rd_adr_mq_l_unused;
wire [5:0] rd_adr_q_unused;
wire [5:0] rd_adr_q_l_unused;
wire dff_rd_en_scanin;
wire dff_rd_en_scanout;
wire rd_en_d1;
wire rd_en_mq_l_unused;
wire rd_en_q_unused;
wire rd_en_q_l_unused;
wire dff_wr_en_scanin;
wire dff_wr_en_scanout;
wire wr_en_d1;
wire [41:1] dff_din_hi_scan;
wire dff_din_hi_scanin;
wire dff_din_hi_scanout;
wire [83:0] din_d1;
wire [41:1] dff_din_lo_scan;
wire dff_din_lo_scanin;
wire dff_din_lo_scanout;
wire wr_inh_;
wire rd_en_d1_qual;
wire wr_en_d1_qual;
wire [83:0] local_dout;
wire dff_dout_scanout;
wire dff_dout_scanin;
		
input	[5:0]	wr_adr;
input			wr_en;
input	[5:0]	rd_adr;
input			rd_en;
input	[83:0] 	din;
output	[83:0]	dout;
input		rdclk;
input		wrclk;
input		scan_in;
input		tcu_pce_ov;
input		tcu_aclk;
input		tcu_bclk;
input		tcu_array_wr_inhibit;
input		tcu_se_scancollar_in;


input		bist_clk_mux_sel;
input		rd_pce;
input		wr_pce;
output		scan_out;

wire pce_ov	= tcu_pce_ov;
wire siclk	= tcu_aclk;
wire soclk	= tcu_bclk;
//================================================
// Clock headers
//================================================
cl_mc1_bistlatch_4x rd_pce_lat (
	.l2clk	(rdclk),
	.pce	(rd_pce),
	.pce_ov	(pce_ov),
	.lce	(rd_lce)
);
cl_mc1_bistlatch_4x wr_pce_lat (
	.l2clk	(wrclk),
	.pce	(wr_pce),
	.pce_ov	(pce_ov),
	.lce	(wr_lce)
);
cl_mc1_bistl1hdr_8x rch_in (
        .l2clk  (rdclk), 
        .se     (tcu_se_scancollar_in),
	.clksel	(bist_clk_mux_sel),
	.bistclk(rdclk),
	.lce	(rd_lce),
        .l1clk  (rdclk_in)
);
cl_mc1_bistl1hdr_8x wch_in (
        .l2clk  (wrclk), 
        .se     (tcu_se_scancollar_in),
	.clksel	(bist_clk_mux_sel),
	.bistclk(rdclk),
	.lce	(wr_lce),
        .l1clk  (wrclk_in)
);
cl_mc1_bistl1hdr_8x rch_free (
        .l2clk  (rdclk), 
        .se     (1'b0),
	.clksel	(bist_clk_mux_sel),
	.bistclk(rdclk),
	.lce	(rd_lce),
        .l1clk  (rdclk_free)
);
cl_mc1_bistl1hdr_8x wch_free (
        .l2clk  (wrclk), 
        .se     (1'b0),
	.clksel	(bist_clk_mux_sel),
	.bistclk(rdclk),
	.lce	(wr_lce),
        .l1clk  (wrclk_free)
);
 

///////////////////////////////////////////////////////////////
// Flop the inputs                                           //
///////////////////////////////////////////////////////////////
n2_com_dp_64x84_cust_msff_ctl_macro__width_6 dff_wr_addr  (
	.scan_in	(dff_wr_addr_scanin),
	.scan_out	(dff_wr_addr_scanout),
	.l1clk		(wrclk_in),
	.din		(wr_adr[5:0]),
	.dout		(wr_adr_d1[5:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_com_dp_64x84_cust_sram_msff_mo_macro__fs_1__width_6 dff_rd_addr   (
	.scan_in	({dff_rd_addr_scan[5:1],dff_rd_addr_scanin}),
	.scan_out	({dff_rd_addr_scanout,dff_rd_addr_scan[5:1]}),
	.l1clk		(rdclk_in),
	.and_clk	(rdclk_in),
	.d		(rd_adr[5:0]),
	.mq		(rd_adr_d1[5:0]),
	.mq_l		(rd_adr_mq_l_unused[5:0]),
	.q		(rd_adr_q_unused[5:0]),
	.q_l		(rd_adr_q_l_unused[5:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_com_dp_64x84_cust_sram_msff_mo_macro__width_1 dff_rd_en  (
	.scan_in	(dff_rd_en_scanin),
	.scan_out	(dff_rd_en_scanout),
	.l1clk		(rdclk_in),
	.and_clk	(rdclk_in),
	.d		(rd_en),
	.mq		(rd_en_d1),
	.mq_l		(rd_en_mq_l_unused),
	.q		(rd_en_q_unused),
	.q_l		(rd_en_q_l_unused),
  .siclk(siclk),
  .soclk(soclk)
);
n2_com_dp_64x84_cust_msff_ctl_macro__width_1 dff_wr_en  (
	.scan_in	(dff_wr_en_scanin),
	.scan_out	(dff_wr_en_scanout),
	.l1clk		(wrclk_in),
	.din		(wr_en),
	.dout		(wr_en_d1),
  .siclk(siclk),
  .soclk(soclk)
);
n2_com_dp_64x84_cust_msff_ctl_macro__fs_1__width_42 dff_din_hi   (
	.scan_in	({dff_din_hi_scan[41:1],dff_din_hi_scanin}),
	.scan_out	({dff_din_hi_scanout,dff_din_hi_scan[41:1]}),
	.l1clk		(wrclk_in),
	.din		(din[83:42]),
	.dout		(din_d1[83:42]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_com_dp_64x84_cust_msff_ctl_macro__fs_1__width_42 dff_din_lo   (
	.scan_in	({dff_din_lo_scan[41:1],dff_din_lo_scanin}),
	.scan_out	({dff_din_lo_scanout,dff_din_lo_scan[41:1]}),
	.l1clk		(wrclk_in),
	.din		(din[41:0]),
	.dout		(din_d1[41:0]),
  .siclk(siclk),
  .soclk(soclk)
);
n2_com_dp_64x84_cust_inv_macro__width_1 wr_inh_inv  (
	.din		(tcu_array_wr_inhibit),
	.dout		(wr_inh_)
);
n2_com_dp_64x84_cust_and_macro__width_2 enable_qual  (
	.din0		({2{wr_inh_}}),
	.din1		({rd_en_d1,wr_en_d1}),
	.dout		({rd_en_d1_qual,wr_en_d1_qual})
);
n2_com_dp_64x84_cust_n2_com_array_macro__rows_64__width_84__z_array array    (
	.rclk	(rdclk_free),
	.wclk	(wrclk_free),
	.wr_adr (wr_adr_d1[5:0]),
	.wr_en	(wr_en_d1_qual),
	.rd_adr (rd_adr_d1[5:0]),
	.rd_en	(rd_en_d1_qual),
	.din	(din_d1[83:0]),
	.dout	(local_dout[83:0])
);


assign dout[83:0] = local_dout[83:0];
assign dff_dout_scanout = dff_dout_scanin;

supply0 vss;
supply1 vdd;

// fixscan start:
assign dff_wr_addr_scanin         = scan_in                  ;
assign dff_rd_addr_scanin         = dff_wr_addr_scanout      ;
assign dff_wr_en_scanin           = dff_rd_addr_scanout      ;
assign dff_rd_en_scanin           = dff_wr_en_scanout        ;
assign dff_din_lo_scanin          = dff_rd_en_scanout        ;
assign dff_din_hi_scanin          = dff_din_lo_scanout       ;
assign dff_dout_scanin            = dff_din_hi_scanout       ;
assign scan_out                   = dff_dout_scanout         ;
// fixscan end:

endmodule







// any PARAMS parms go into naming of macro

module n2_com_dp_64x84_cust_msff_ctl_macro__width_6 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [5:0] fdin;
wire [4:0] so;

  input [5:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [5:0] dout;
  output scan_out;
assign fdin[5:0] = din[5:0];






dff /*#(6)*/  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[5:0]),
.si({scan_in,so[4:0]}),
.so({so[4:0],scan_out}),
.q(dout[5:0])
);












endmodule









//
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_com_dp_64x84_cust_sram_msff_mo_macro__fs_1__width_6 (
  d, 
  scan_in, 
  l1clk, 
  and_clk, 
  siclk, 
  soclk, 
  mq, 
  mq_l, 
  scan_out, 
  q, 
  q_l);
input [5:0] d;
  input [5:0] scan_in;
input l1clk;
input and_clk;
input siclk;
input soclk;
output [5:0] mq;
output [5:0] mq_l;
  output [5:0] scan_out;
output [5:0] q;
output [5:0] q_l;






new_dlata /*#(6)*/  d0_0 (
.d(d[5:0]),
.si(scan_in[5:0]),
.so(scan_out[5:0]),
.l1clk(l1clk),
.and_clk(and_clk),
.siclk(siclk),
.soclk(soclk),
.q(q[5:0]),
.q_l(q_l[5:0]),
.mq(mq[5:0]),
.mq_l(mq_l[5:0])
);










//place::generic_place($width,$stack,$left);

endmodule





//
//   macro for cl_mc1_sram_msff_mo_{16,8,4}x flops
//
//





module n2_com_dp_64x84_cust_sram_msff_mo_macro__width_1 (
  d, 
  scan_in, 
  l1clk, 
  and_clk, 
  siclk, 
  soclk, 
  mq, 
  mq_l, 
  scan_out, 
  q, 
  q_l);
input [0:0] d;
  input scan_in;
input l1clk;
input and_clk;
input siclk;
input soclk;
output [0:0] mq;
output [0:0] mq_l;
  output scan_out;
output [0:0] q;
output [0:0] q_l;






new_dlata /*#(1)*/  d0_0 (
.d(d[0:0]),
.si(scan_in),
.so(scan_out),
.l1clk(l1clk),
.and_clk(and_clk),
.siclk(siclk),
.soclk(soclk),
.q(q[0:0]),
.q_l(q_l[0:0]),
.mq(mq[0:0]),
.mq_l(mq_l[0:0])
);










//place::generic_place($width,$stack,$left);

endmodule









// any PARAMS parms go into naming of macro

module n2_com_dp_64x84_cust_msff_ctl_macro__width_1 (
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

module n2_com_dp_64x84_cust_msff_ctl_macro__fs_1__width_42 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [41:0] fdin;

  input [41:0] din;
  input l1clk;
  input [41:0] scan_in;


  input siclk;
  input soclk;

  output [41:0] dout;
  output [41:0] scan_out;
assign fdin[41:0] = din[41:0];






dff /*#(42)*/  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[41:0]),
.si(scan_in[41:0]),
.so(scan_out[41:0]),
.q(dout[41:0])
);












endmodule









//
//   invert macro
//
//





module n2_com_dp_64x84_cust_inv_macro__width_1 (
  din, 
  dout);
  input [0:0] din;
  output [0:0] dout;






inv /*#(1)*/  d0_0 (
.in(din[0:0]),
.out(dout[0:0])
);









endmodule





//  
//   and macro for ports = 2,3,4
//
//





module n2_com_dp_64x84_cust_and_macro__width_2 (
  din0, 
  din1, 
  dout);
  input [1:0] din0;
  input [1:0] din1;
  output [1:0] dout;






and2 /*#(2)*/  d0_0 (
.in0(din0[1:0]),
.in1(din1[1:0]),
.out(dout[1:0])
);









endmodule










