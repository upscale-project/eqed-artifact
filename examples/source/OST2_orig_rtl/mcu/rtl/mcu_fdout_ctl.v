// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: mcu_fdout_ctl.v
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
module mcu_fdout_ctl (
  mcu_fsr0_data, 
  mcu_fsr1_data, 
  fbdiwr0_data, 
  fbdiwr1_data, 
  rdpctl_kp_lnk_up, 
  fbdic_link_cnt_eq_0_d1, 
  tcu_mcu_fbd_clk_stop, 
  tcu_atpg_mode, 
  drl2clk, 
  scan_in, 
  scan_out, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_scan_en, 
  tcu_pce_ov, 
  tcu_mcu_testmode);
wire pce_ov;
wire siclk;
wire soclk;
wire se;
wire stop;
wire l1clk;
wire [119:0] fdout_link_data;
wire fbdic_link_cnt_eq_0_d1_reg;
wire [119:0] mcu_fsr0_data_in;
wire ff_fsr0_data_scanin;
wire ff_fsr0_data_scanout;
wire [119:0] mcu_fsr1_data_in;
wire ff_fsr1_data_scanin;
wire ff_fsr1_data_scanout;
wire si_0;
wire so_0;
wire spares_scanin;
wire spare0_buf_32x_unused;
wire spare0_nand3_8x_unused;
wire spare0_inv_8x_unused;
wire spare0_aoi22_4x_unused;
wire spare0_buf_8x_unused;
wire spare0_oai22_4x_unused;
wire spare0_inv_16x_unused;
wire spare0_nand2_16x_unused;
wire spare0_nor3_4x_unused;
wire spare0_nand2_8x_unused;
wire spare0_buf_16x_unused;
wire spare0_nor2_16x_unused;
wire spare0_inv_32x_unused;
wire spares_scanout;


output	[119:0]	mcu_fsr0_data;
output	[119:0]	mcu_fsr1_data;

input	[119:0]	fbdiwr0_data;
input	[119:0]	fbdiwr1_data;

input		rdpctl_kp_lnk_up;
input		fbdic_link_cnt_eq_0_d1;

input		tcu_mcu_fbd_clk_stop;
input		tcu_atpg_mode;

input		drl2clk;
input 		scan_in;
output		scan_out;
input 		tcu_aclk;
input		tcu_bclk;
input		tcu_scan_en;
input		tcu_pce_ov;
input		tcu_mcu_testmode;

// Scan reassigns
assign pce_ov = tcu_pce_ov;
assign siclk = tcu_aclk & tcu_mcu_testmode;
assign soclk = tcu_bclk & tcu_mcu_testmode;
assign se = tcu_scan_en & tcu_mcu_testmode;
assign stop = tcu_mcu_fbd_clk_stop & ~tcu_atpg_mode;

mcu_fdout_ctl_l1clkhdr_ctl_macro clkgen (
 	.l2clk(drl2clk),
 	.l1en (1'b1 ),
 	.l1clk(l1clk),
  .pce_ov(pce_ov),
  .stop(stop),
  .se(se));

assign fdout_link_data[119:0] = fbdic_link_cnt_eq_0_d1_reg ? 120'h55_0aaa_557a_a455_0aa0_554a_a055_0aa0 : 120'h0;

assign mcu_fsr0_data_in[119:0] = rdpctl_kp_lnk_up ? fdout_link_data[119:0] : fbdiwr0_data[119:0];

mcu_fdout_ctl_msff_ctl_macro__width_120 ff_fsr0_data    (
	.scan_in(ff_fsr0_data_scanin),
	.scan_out(ff_fsr0_data_scanout),
	.din(mcu_fsr0_data_in[119:0]),
	.dout(mcu_fsr0_data[119:0]),
	.l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

assign mcu_fsr1_data_in[119:0] = rdpctl_kp_lnk_up ? fdout_link_data[119:0] : fbdiwr1_data[119:0];

mcu_fdout_ctl_msff_ctl_macro__width_120 ff_fsr1_data    (
	.scan_in(ff_fsr1_data_scanin),
	.scan_out(ff_fsr1_data_scanout),
	.din(mcu_fsr1_data_in[119:0]),
	.dout(mcu_fsr1_data[119:0]),
	.l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

cl_sc1_msff_8x spare0_flop (.l1clk(l1clk),
                               .siclk(siclk),
                               .soclk(soclk),
                               .si(si_0),
                               .so(so_0),
                               .d(fbdic_link_cnt_eq_0_d1),
                               .q(fbdic_link_cnt_eq_0_d1_reg));
assign si_0 = spares_scanin;

cl_u1_buf_32x   spare0_buf_32x (.in(1'b1),
                                   .out(spare0_buf_32x_unused));
cl_u1_nand3_8x spare0_nand3_8x (.in0(1'b1),
                                   .in1(1'b1),
                                   .in2(1'b1),
                                   .out(spare0_nand3_8x_unused));
cl_u1_inv_8x    spare0_inv_8x (.in(1'b1),
                                  .out(spare0_inv_8x_unused));
cl_u1_aoi22_4x spare0_aoi22_4x (.in00(1'b1),
                                   .in01(1'b1),
                                   .in10(1'b1),
                                   .in11(1'b1),
                                   .out(spare0_aoi22_4x_unused));
cl_u1_buf_8x    spare0_buf_8x (.in(1'b1),
                                  .out(spare0_buf_8x_unused));
cl_u1_oai22_4x spare0_oai22_4x (.in00(1'b1),
                                   .in01(1'b1),
                                   .in10(1'b1),
                                   .in11(1'b1),
                                   .out(spare0_oai22_4x_unused));
cl_u1_inv_16x   spare0_inv_16x (.in(1'b1),
                                   .out(spare0_inv_16x_unused));
cl_u1_nand2_16x spare0_nand2_16x (.in0(1'b1),
                                     .in1(1'b1),
                                     .out(spare0_nand2_16x_unused));
cl_u1_nor3_4x spare0_nor3_4x (.in0(1'b0),
                                 .in1(1'b0),
                                 .in2(1'b0),
                                 .out(spare0_nor3_4x_unused));
cl_u1_nand2_8x spare0_nand2_8x (.in0(1'b1),
                                   .in1(1'b1),
                                   .out(spare0_nand2_8x_unused));
cl_u1_buf_16x   spare0_buf_16x (.in(1'b1),
                                   .out(spare0_buf_16x_unused));
cl_u1_nor2_16x spare0_nor2_16x (.in0(1'b0),
                                   .in1(1'b0),
                                   .out(spare0_nor2_16x_unused));
cl_u1_inv_32x   spare0_inv_32x (.in(1'b1),
                                   .out(spare0_inv_32x_unused));
assign spares_scanout = so_0;

assign ff_fsr0_data_scanin       = scan_in                  ;
assign ff_fsr1_data_scanin       = ff_fsr0_data_scanout     ;
assign spares_scanin             = ff_fsr1_data_scanout     ;
assign scan_out                  = tcu_mcu_testmode ? spares_scanout : scan_in ;

endmodule






// any PARAMS parms go into naming of macro

module mcu_fdout_ctl_l1clkhdr_ctl_macro (
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













// any PARAMS parms go into naming of macro

module mcu_fdout_ctl_msff_ctl_macro__width_120 (
  din, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [119:0] fdin;
wire [118:0] so;

  input [119:0] din;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [119:0] dout;
  output scan_out;
assign fdin[119:0] = din[119:0];






dff #(120)  d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[119:0]),
.si({scan_in,so[118:0]}),
.so({so[118:0],scan_out}),
.q(dout[119:0])
);












endmodule








