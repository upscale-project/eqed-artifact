// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: n2_com_cm_32x40_cust.v
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
module n2_com_cm_32x40_cust (
  adr_w, 
  din, 
  write_en, 
  tcu_array_wr_inhibit, 
  adr_r, 
  read_en, 
  lookup_en, 
  key, 
  l2clk, 
  tcu_se_scancollar_in, 
  scan_in, 
  tcu_pce_ov, 
  pce, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_scan_en, 
  tcu_clk_stop, 
  tcu_array_bypass, 
  scan_out, 
  match, 
  match_idx, 
  dout);
wire siclk;
wire soclk;
wire pce_ov;
wire l1clk_in;
wire l1clk_en;
wire [142:0] so;
wire [152:0] xx_unused;
wire [152:0] xx0_unused;
wire [41:0] din_d1;
wire [41:7] key_d1;
wire lkup_so;
wire lookup_en_d1;
wire mb_ren_d1;
wire mb_wen_d1;
wire [31:0] adr_r_d1;
wire [31:0] adr_w_d1;
 

input   [31:0]  adr_w ; // set up to +ve edge, BS & SR 11/04/03, MB grows to 32
input   [41:0]  din;    // set up to +ve edge
input           write_en;       // +ve edge clk; write enable
input		tcu_array_wr_inhibit; // used to gate off writes during SCAN.
input   [31:0]  adr_r;  // set up to +ve edge, BS & SR 11/04/03, MB grows to 32
input           read_en;
input           lookup_en;      // set up to -ve edge
input   [41:7]  key;    // set up to -ve edge
input           l2clk ;
input           tcu_se_scancollar_in;
input           scan_in;
input           tcu_pce_ov;
input           pce;
input           tcu_aclk;
input           tcu_bclk;
input 		tcu_scan_en;
input		tcu_clk_stop;
input           tcu_array_bypass; // array bypass for DFT

output          scan_out;
output  [31:0]  match ;
output  [31:0]  match_idx ;
output  [41:0]  dout;

wire   [41:0]   dout_array;
wire   [31:0]   match_array;
wire   [31:0]   match_idx_array;

// scan chain connections ////
wire stop;
assign siclk = tcu_aclk;
assign soclk = tcu_bclk;
//assign se = tcu_scan_en;
assign stop = tcu_clk_stop;
assign pce_ov = tcu_pce_ov;

assign dout = dout_array;

//// Input Flops /////


///////////
n2_com_cm_32x40_cust_l1clkhdr_ctl_macro      collar_in
         (
         .l2clk  (l2clk  ),
         .l1en   (pce   ),
         .pce_ov (pce_ov ),
         .stop   (stop   ),
         .se     (tcu_se_scancollar_in),
         .l1clk  (l1clk_in  )
         );

n2_com_cm_32x40_cust_l1clkhdr_ctl_macro      scan_en
         (
         .l2clk  (l2clk  ),
         .l1en   (pce   ),
         .pce_ov (pce_ov ),
         .stop   (stop   ),
         .se     (tcu_scan_en),
         .l1clk  (l1clk_en  )
         );



n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx0  (.scan_in(scan_in), .scan_out(so[0]), .l1clk(l1clk_in), .d(din[0]), .latout(xx_unused[0]), .q_l(xx0_unused[0]), .q(din_d1[0]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx1  (.scan_in(so[0]), .scan_out(so[1]), .l1clk(l1clk_in), .d(din[1]), .latout(xx_unused[1]), .q_l(xx0_unused[1]), .q(din_d1[1]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx2  (.scan_in(so[1]), .scan_out(so[2]), .l1clk(l1clk_in), .d(din[2]), .latout(xx_unused[2]), .q_l(xx0_unused[2]), .q(din_d1[2]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx3  (.scan_in(so[2]), .scan_out(so[3]), .l1clk(l1clk_in), .d(din[3]), .latout(xx_unused[3]), .q_l(xx0_unused[3]), .q(din_d1[3]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx4  (.scan_in(so[3]), .scan_out(so[4]), .l1clk(l1clk_in), .d(din[4]), .latout(xx_unused[4]), .q_l(xx0_unused[4]), .q(din_d1[4]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx5  (.scan_in(so[4]), .scan_out(so[5]), .l1clk(l1clk_in), .d(din[5]), .latout(xx_unused[5]), .q_l(xx0_unused[5]), .q(din_d1[5]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx6  (.scan_in(so[5]), .scan_out(so[6]), .l1clk(l1clk_in), .d(din[6]), .latout(xx_unused[6]), .q_l(xx0_unused[6]), .q(din_d1[6]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx7  (.scan_in(so[6]), .scan_out(so[7]), .l1clk(l1clk_in), .d(din[9]), .latout(xx_unused[7]), .q_l(xx0_unused[7]), .q(din_d1[9]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx8  (.scan_in(so[7]), .scan_out(so[8]), .l1clk(l1clk_in), .d(din[10]), .latout(xx_unused[8]), .q_l(xx0_unused[8]), .q(din_d1[10]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx9  (.scan_in(so[8]), .scan_out(so[9]), .l1clk(l1clk_in), .d(din[11]), .latout(xx_unused[9]), .q_l(xx0_unused[9]), .q(din_d1[11]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx10  (.scan_in(so[9]), .scan_out(so[10]), .l1clk(l1clk_in), .d(din[12]), .latout(xx_unused[10]), .q_l(xx0_unused[10]), .q(din_d1[12]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx11  (.scan_in(so[10]), .scan_out(so[11]), .l1clk(l1clk_in), .d(din[13]), .latout(xx_unused[11]), .q_l(xx0_unused[11]), .q(din_d1[13]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx12  (.scan_in(so[11]), .scan_out(so[12]), .l1clk(l1clk_in), .d(din[14]), .latout(xx_unused[12]), .q_l(xx0_unused[12]), .q(din_d1[14]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx13  (.scan_in(so[12]), .scan_out(so[13]), .l1clk(l1clk_in), .d(din[15]), .latout(xx_unused[13]), .q_l(xx0_unused[13]), .q(din_d1[15]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx14  (.scan_in(so[13]), .scan_out(so[14]), .l1clk(l1clk_in), .d(din[16]), .latout(xx_unused[14]), .q_l(xx0_unused[14]), .q(din_d1[16]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx15  (.scan_in(so[14]), .scan_out(so[15]), .l1clk(l1clk_in), .d(din[17]), .latout(xx_unused[15]), .q_l(xx0_unused[15]), .q(din_d1[17]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx16  (.scan_in(so[15]), .scan_out(so[16]), .l1clk(l1clk_in), .d(din[7]), .latout(xx_unused[16]), .q_l(xx0_unused[16]), .q(din_d1[7]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx17  (.scan_in(so[16]), .scan_out(so[17]), .l1clk(l1clk_in), .d(din[8]), .latout(xx_unused[17]), .q_l(xx0_unused[17]), .q(din_d1[8]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx18  (.scan_in(so[17]), .scan_out(so[18]), .l1clk(l1clk_in), .d(din[18]), .latout(xx_unused[18]), .q_l(xx0_unused[18]), .q(din_d1[18]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx19  (.scan_in(so[18]), .scan_out(so[19]), .l1clk(l1clk_in), .d(din[19]), .latout(xx_unused[19]), .q_l(xx0_unused[19]), .q(din_d1[19]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx20  (.scan_in(so[19]), .scan_out(so[20]), .l1clk(l1clk_in), .d(din[20]), .latout(xx_unused[20]), .q_l(xx0_unused[20]), .q(din_d1[20]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx21  (.scan_in(so[20]), .scan_out(so[21]), .l1clk(l1clk_in), .d(din[21]), .latout(xx_unused[21]), .q_l(xx0_unused[21]), .q(din_d1[21]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx22  (.scan_in(so[21]), .scan_out(so[22]), .l1clk(l1clk_in), .d(din[22]), .latout(xx_unused[22]), .q_l(xx0_unused[22]), .q(din_d1[22]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx23  (.scan_in(so[22]), .scan_out(so[23]), .l1clk(l1clk_in), .d(din[23]), .latout(xx_unused[23]), .q_l(xx0_unused[23]), .q(din_d1[23]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx24  (.scan_in(so[23]), .scan_out(so[24]), .l1clk(l1clk_in), .d(din[24]), .latout(xx_unused[24]), .q_l(xx0_unused[24]), .q(din_d1[24]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx25  (.scan_in(so[24]), .scan_out(so[25]), .l1clk(l1clk_in), .d(din[25]), .latout(xx_unused[25]), .q_l(xx0_unused[25]), .q(din_d1[25]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx26  (.scan_in(so[25]), .scan_out(so[26]), .l1clk(l1clk_in), .d(din[26]), .latout(xx_unused[26]), .q_l(xx0_unused[26]), .q(din_d1[26]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx27  (.scan_in(so[26]), .scan_out(so[27]), .l1clk(l1clk_in), .d(din[27]), .latout(xx_unused[27]), .q_l(xx0_unused[27]), .q(din_d1[27]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx28  (.scan_in(so[27]), .scan_out(so[28]), .l1clk(l1clk_in), .d(din[28]), .latout(xx_unused[28]), .q_l(xx0_unused[28]), .q(din_d1[28]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx29  (.scan_in(so[28]), .scan_out(so[29]), .l1clk(l1clk_in), .d(din[29]), .latout(xx_unused[29]), .q_l(xx0_unused[29]), .q(din_d1[29]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx30  (.scan_in(so[29]), .scan_out(so[30]), .l1clk(l1clk_in), .d(din[30]), .latout(xx_unused[30]), .q_l(xx0_unused[30]), .q(din_d1[30]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx31  (.scan_in(so[30]), .scan_out(so[31]), .l1clk(l1clk_in), .d(din[31]), .latout(xx_unused[31]), .q_l(xx0_unused[31]), .q(din_d1[31]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx32  (.scan_in(so[31]), .scan_out(so[32]), .l1clk(l1clk_in), .d(din[32]), .latout(xx_unused[32]), .q_l(xx0_unused[32]), .q(din_d1[32]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx33  (.scan_in(so[32]), .scan_out(so[33]), .l1clk(l1clk_in), .d(din[33]), .latout(xx_unused[33]), .q_l(xx0_unused[33]), .q(din_d1[33]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx34  (.scan_in(so[33]), .scan_out(so[34]), .l1clk(l1clk_in), .d(din[34]), .latout(xx_unused[34]), .q_l(xx0_unused[34]), .q(din_d1[34]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx35  (.scan_in(so[34]), .scan_out(so[35]), .l1clk(l1clk_in), .d(din[35]), .latout(xx_unused[35]), .q_l(xx0_unused[35]), .q(din_d1[35]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx36  (.scan_in(so[35]), .scan_out(so[36]), .l1clk(l1clk_in), .d(din[36]), .latout(xx_unused[36]), .q_l(xx0_unused[36]), .q(din_d1[36]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx37  (.scan_in(so[36]), .scan_out(so[37]), .l1clk(l1clk_in), .d(din[37]), .latout(xx_unused[37]), .q_l(xx0_unused[37]), .q(din_d1[37]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx38  (.scan_in(so[37]), .scan_out(so[38]), .l1clk(l1clk_in), .d(din[38]), .latout(xx_unused[38]), .q_l(xx0_unused[38]), .q(din_d1[38]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx39  (.scan_in(so[38]), .scan_out(so[39]), .l1clk(l1clk_in), .d(din[39]), .latout(xx_unused[39]), .q_l(xx0_unused[39]), .q(din_d1[39]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx40  (.scan_in(so[39]), .scan_out(so[40]), .l1clk(l1clk_in), .d(din[40]), .latout(xx_unused[40]), .q_l(xx0_unused[40]), .q(din_d1[40]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx41  (.scan_in(so[40]), .scan_out(so[41]), .l1clk(l1clk_in), .d(din[41]), .latout(xx_unused[41]), .q_l(xx0_unused[41]), .q(din_d1[41]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx42  (.scan_in(so[41]), .scan_out(so[42]), .l1clk(l1clk_in), .d(key[41]), .latout(key_d1[41]), .q_l(xx0_unused[42]), .q(xx_unused[42]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx43  (.scan_in(so[42]), .scan_out(so[43]), .l1clk(l1clk_in), .d(key[40]), .latout(key_d1[40]), .q_l(xx0_unused[43]), .q(xx_unused[43]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx44  (.scan_in(so[43]), .scan_out(so[44]), .l1clk(l1clk_in), .d(key[39]), .latout(key_d1[39]), .q_l(xx0_unused[44]), .q(xx_unused[44]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx45  (.scan_in(so[44]), .scan_out(so[45]), .l1clk(l1clk_in), .d(key[38]), .latout(key_d1[38]), .q_l(xx0_unused[45]), .q(xx_unused[45]),
  .siclk(siclk),
  .soclk(soclk));





n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx46  (.scan_in(so[45]), .scan_out(lkup_so), .l1clk(l1clk_in), .d(lookup_en), .latout(lookup_en_d1),  .q_l(xx0_unused[46]), .q(xx_unused[46]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx47  (.scan_in(lkup_so), .scan_out(so[46]), .l1clk(l1clk_in), .d(key[37]), .latout(key_d1[37]),      .q_l(xx0_unused[47]), .q(xx_unused[47]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx48  (.scan_in(so[46]), .scan_out(so[47]), .l1clk(l1clk_in), .d(key[36]), .latout(key_d1[36]),       .q_l(xx0_unused[48]), .q(xx_unused[48]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx49  (.scan_in(so[47]), .scan_out(so[48]), .l1clk(l1clk_in), .d(key[35]), .latout(key_d1[35]),       .q_l(xx0_unused[49]), .q(xx_unused[49]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx50  (.scan_in(so[48]), .scan_out(so[49]), .l1clk(l1clk_in), .d(key[34]), .latout(key_d1[34]),       .q_l(xx0_unused[50]), .q(xx_unused[50]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx51  (.scan_in(so[49]), .scan_out(so[50]), .l1clk(l1clk_in), .d(key[33]), .latout(key_d1[33]),       .q_l(xx0_unused[51]), .q(xx_unused[51]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx52  (.scan_in(so[50]), .scan_out(so[51]), .l1clk(l1clk_in), .d(key[32]), .latout(key_d1[32]),       .q_l(xx0_unused[52]), .q(xx_unused[52]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx53  (.scan_in(so[51]), .scan_out(so[52]), .l1clk(l1clk_in), .d(key[31]), .latout(key_d1[31]),       .q_l(xx0_unused[53]), .q(xx_unused[53]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx54  (.scan_in(so[52]), .scan_out(so[53]), .l1clk(l1clk_in), .d(key[30]), .latout(key_d1[30]),       .q_l(xx0_unused[54]), .q(xx_unused[54]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx55  (.scan_in(so[53]), .scan_out(so[54]), .l1clk(l1clk_in), .d(key[29]), .latout(key_d1[29]),       .q_l(xx0_unused[55]), .q(xx_unused[55]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx56  (.scan_in(so[54]), .scan_out(so[55]), .l1clk(l1clk_in), .d(key[28]), .latout(key_d1[28]),       .q_l(xx0_unused[56]), .q(xx_unused[56]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx57  (.scan_in(so[55]), .scan_out(so[56]), .l1clk(l1clk_in), .d(key[27]), .latout(key_d1[27]),       .q_l(xx0_unused[57]), .q(xx_unused[57]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx58  (.scan_in(so[56]), .scan_out(so[57]), .l1clk(l1clk_in), .d(key[26]), .latout(key_d1[26]),       .q_l(xx0_unused[58]), .q(xx_unused[58]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx59  (.scan_in(so[57]), .scan_out(so[58]), .l1clk(l1clk_in), .d(key[25]), .latout(key_d1[25]),       .q_l(xx0_unused[59]), .q(xx_unused[59]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx60  (.scan_in(so[58]), .scan_out(so[59]), .l1clk(l1clk_in), .d(key[24]), .latout(key_d1[24]),       .q_l(xx0_unused[60]), .q(xx_unused[60]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx61  (.scan_in(so[59]), .scan_out(so[60]), .l1clk(l1clk_in), .d(key[23]), .latout(key_d1[23]),       .q_l(xx0_unused[70]), .q(xx_unused[70]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx62  (.scan_in(so[60]), .scan_out(so[61]), .l1clk(l1clk_in), .d(key[22]), .latout(key_d1[22]),       .q_l(xx0_unused[71]), .q(xx_unused[71]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx63  (.scan_in(so[61]), .scan_out(so[62]), .l1clk(l1clk_in), .d(key[21]), .latout(key_d1[21]),       .q_l(xx0_unused[72]), .q(xx_unused[72]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx64  (.scan_in(so[62]), .scan_out(so[63]), .l1clk(l1clk_in), .d(key[20]), .latout(key_d1[20]),       .q_l(xx0_unused[73]), .q(xx_unused[73]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx65  (.scan_in(so[63]), .scan_out(so[64]), .l1clk(l1clk_in), .d(key[19]), .latout(key_d1[19]),       .q_l(xx0_unused[74]), .q(xx_unused[74]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx66  (.scan_in(so[64]), .scan_out(so[65]), .l1clk(l1clk_in), .d(key[18]), .latout(key_d1[18]),       .q_l(xx0_unused[75]), .q(xx_unused[75]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx67  (.scan_in(so[65]), .scan_out(so[66]), .l1clk(l1clk_in), .d(key[8]), .latout(key_d1[8]),         .q_l(xx0_unused[76]), .q(xx_unused[76]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx68  (.scan_in(so[66]), .scan_out(so[67]), .l1clk(l1clk_in), .d(key[7]), .latout(key_d1[7]),         .q_l(xx0_unused[77]), .q(xx_unused[77]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx69  (.scan_in(so[67]), .scan_out(so[68]), .l1clk(l1clk_in), .d(key[17]), .latout(key_d1[17]),       .q_l(xx0_unused[78]), .q(xx_unused[78]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx70  (.scan_in(so[68]), .scan_out(so[69]), .l1clk(l1clk_in), .d(key[16]), .latout(key_d1[16]),       .q_l(xx0_unused[79]), .q(xx_unused[79]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx71  (.scan_in(so[69]), .scan_out(so[70]), .l1clk(l1clk_in), .d(key[15]), .latout(key_d1[15]),       .q_l(xx0_unused[80]), .q(xx_unused[80]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx72  (.scan_in(so[70]), .scan_out(so[71]), .l1clk(l1clk_in), .d(key[14]), .latout(key_d1[14]),       .q_l(xx0_unused[81]), .q(xx_unused[81]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx73  (.scan_in(so[71]), .scan_out(so[72]), .l1clk(l1clk_in), .d(key[13]), .latout(key_d1[13]),       .q_l(xx0_unused[82]), .q(xx_unused[82]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx74  (.scan_in(so[72]), .scan_out(so[73]), .l1clk(l1clk_in), .d(key[12]), .latout(key_d1[12]),       .q_l(xx0_unused[83]), .q(xx_unused[83]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx75  (.scan_in(so[73]), .scan_out(so[74]), .l1clk(l1clk_in), .d(key[11]), .latout(key_d1[11]),       .q_l(xx0_unused[84]), .q(xx_unused[84]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx76  (.scan_in(so[74]), .scan_out(so[75]), .l1clk(l1clk_in), .d(key[10]), .latout(key_d1[10]),       .q_l(xx0_unused[85]), .q(xx_unused[85]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx77  (.scan_in(so[75]), .scan_out(so[76]), .l1clk(l1clk_in), .d(key[9]), .latout(key_d1[9]),         .q_l(xx0_unused[86]), .q(xx_unused[86]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx78  (.scan_in(so[76]), .scan_out(so[77]), .l1clk(l1clk_in), .d(read_en), .latout(mb_ren_d1),        .q_l(xx0_unused[87]), .q(xx_unused[87]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx79  (.scan_in(so[77]), .scan_out(so[78]), .l1clk(l1clk_in), .d(write_en), .latout(mb_wen_d1),       .q_l(xx0_unused[88]), .q(xx_unused[88]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx80  (.scan_in(so[78]), .scan_out(so[79]), .l1clk(l1clk_in), .d(adr_r[0]), .latout(adr_r_d1[0]),     .q_l(xx0_unused[89]), .q(xx_unused[89]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx81  (.scan_in(so[79]), .scan_out(so[80]), .l1clk(l1clk_in), .d(adr_r[1]), .latout(adr_r_d1[1]),     .q_l(xx0_unused[90]), .q(xx_unused[90]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx82  (.scan_in(so[80]), .scan_out(so[81]), .l1clk(l1clk_in), .d(adr_r[2]), .latout(adr_r_d1[2]),     .q_l(xx0_unused[91]), .q(xx_unused[91]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx83  (.scan_in(so[81]), .scan_out(so[82]), .l1clk(l1clk_in), .d(adr_r[3]), .latout(adr_r_d1[3]),     .q_l(xx0_unused[92]), .q(xx_unused[92]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx84  (.scan_in(so[82]), .scan_out(so[83]), .l1clk(l1clk_in), .d(adr_w[0]), .latout(adr_w_d1[0]),     .q_l(xx0_unused[93]), .q(xx_unused[93]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx85  (.scan_in(so[83]), .scan_out(so[84]), .l1clk(l1clk_in), .d(adr_w[1]), .latout(adr_w_d1[1]),     .q_l(xx0_unused[94]), .q(xx_unused[94]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx86  (.scan_in(so[84]), .scan_out(so[85]), .l1clk(l1clk_in), .d(adr_w[2]), .latout(adr_w_d1[2]),     .q_l(xx0_unused[95]), .q(xx_unused[95]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx87  (.scan_in(so[85]), .scan_out(so[86]), .l1clk(l1clk_in), .d(adr_w[3]), .latout(adr_w_d1[3]),     .q_l(xx0_unused[96]), .q(xx_unused[96]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx88  (.scan_in(so[86]), .scan_out(so[87]), .l1clk(l1clk_in), .d(adr_r[4]), .latout(adr_r_d1[4]),     .q_l(xx0_unused[97]), .q(xx_unused[97]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx89  (.scan_in(so[87]), .scan_out(so[88]), .l1clk(l1clk_in), .d(adr_r[5]), .latout(adr_r_d1[5]),     .q_l(xx0_unused[98]), .q(xx_unused[98]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx90  (.scan_in(so[88]), .scan_out(so[89]), .l1clk(l1clk_in), .d(adr_r[6]), .latout(adr_r_d1[6]),     .q_l(xx0_unused[99]), .q(xx_unused[99]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx91  (.scan_in(so[89]), .scan_out(so[90]), .l1clk(l1clk_in), .d(adr_r[7]), .latout(adr_r_d1[7]),     .q_l(xx0_unused[100]), .q(xx_unused[100]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx92  (.scan_in(so[90]), .scan_out(so[91]), .l1clk(l1clk_in), .d(adr_w[4]), .latout(adr_w_d1[4]),     .q_l(xx0_unused[101]), .q(xx_unused[101]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx93  (.scan_in(so[91]), .scan_out(so[92]), .l1clk(l1clk_in), .d(adr_w[5]), .latout(adr_w_d1[5]),     .q_l(xx0_unused[102]), .q(xx_unused[102]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx94  (.scan_in(so[92]), .scan_out(so[93]), .l1clk(l1clk_in), .d(adr_w[6]), .latout(adr_w_d1[6]),     .q_l(xx0_unused[103]), .q(xx_unused[103]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx95  (.scan_in(so[93]), .scan_out(so[94]), .l1clk(l1clk_in), .d(adr_w[7]), .latout(adr_w_d1[7]),     .q_l(xx0_unused[104]), .q(xx_unused[104]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx96  (.scan_in(so[94]), .scan_out(so[95]), .l1clk(l1clk_in), .d(adr_r[11]), .latout(adr_r_d1[11]),   .q_l(xx0_unused[105]), .q(xx_unused[105]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx97  (.scan_in(so[95]), .scan_out(so[96]), .l1clk(l1clk_in), .d(adr_r[10]), .latout(adr_r_d1[10]),   .q_l(xx0_unused[106]), .q(xx_unused[106]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx98  (.scan_in(so[96]), .scan_out(so[97]), .l1clk(l1clk_in), .d(adr_r[9]), .latout(adr_r_d1[9]),     .q_l(xx0_unused[107]), .q(xx_unused[107]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx99  (.scan_in(so[97]), .scan_out(so[98]), .l1clk(l1clk_in), .d(adr_r[8]), .latout(adr_r_d1[8]),     .q_l(xx0_unused[108]), .q(xx_unused[108]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx100  (.scan_in(so[98]), .scan_out(so[99]), .l1clk(l1clk_in), .d(adr_w[11]), .latout(adr_w_d1[11]),  .q_l(xx0_unused[109]), .q(xx_unused[109]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx101  (.scan_in(so[99]), .scan_out(so[100]), .l1clk(l1clk_in), .d(adr_w[10]), .latout(adr_w_d1[10]), .q_l(xx0_unused[110]), .q(xx_unused[110]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx102  (.scan_in(so[100]), .scan_out(so[101]), .l1clk(l1clk_in), .d(adr_w[9]), .latout(adr_w_d1[9]),  .q_l(xx0_unused[111]), .q(xx_unused[111]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx103  (.scan_in(so[101]), .scan_out(so[102]), .l1clk(l1clk_in), .d(adr_w[8]), .latout(adr_w_d1[8]),  .q_l(xx0_unused[112]), .q(xx_unused[112]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx104  (.scan_in(so[102]), .scan_out(so[103]), .l1clk(l1clk_in), .d(adr_r[15]), .latout(adr_r_d1[15]),.q_l(xx0_unused[113]), .q(xx_unused[113]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx105  (.scan_in(so[103]), .scan_out(so[104]), .l1clk(l1clk_in), .d(adr_r[14]), .latout(adr_r_d1[14]),.q_l(xx0_unused[114]), .q(xx_unused[114]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx106  (.scan_in(so[104]), .scan_out(so[105]), .l1clk(l1clk_in), .d(adr_r[13]), .latout(adr_r_d1[13]),.q_l(xx0_unused[115]), .q(xx_unused[115]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx107  (.scan_in(so[105]), .scan_out(so[106]), .l1clk(l1clk_in), .d(adr_r[12]), .latout(adr_r_d1[12]),.q_l(xx0_unused[116]), .q(xx_unused[116]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx108  (.scan_in(so[106]), .scan_out(so[107]), .l1clk(l1clk_in), .d(adr_w[15]), .latout(adr_w_d1[15]),.q_l(xx0_unused[117]), .q(xx_unused[117]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx109  (.scan_in(so[107]), .scan_out(so[108]), .l1clk(l1clk_in), .d(adr_w[14]), .latout(adr_w_d1[14]),.q_l(xx0_unused[118]), .q(xx_unused[118]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx110  (.scan_in(so[108]), .scan_out(so[109]), .l1clk(l1clk_in), .d(adr_w[13]), .latout(adr_w_d1[13]),.q_l(xx0_unused[119]), .q(xx_unused[119]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx111  (.scan_in(so[109]), .scan_out(so[110]), .l1clk(l1clk_in), .d(adr_w[12]), .latout(adr_w_d1[12]),.q_l(xx0_unused[120]), .q(xx_unused[120]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx112  (.scan_in(so[110]), .scan_out(so[111]), .l1clk(l1clk_in), .d(adr_r[16]), .latout(adr_r_d1[16]),.q_l(xx0_unused[121]), .q(xx_unused[121]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx113  (.scan_in(so[111]), .scan_out(so[112]), .l1clk(l1clk_in), .d(adr_r[17]), .latout(adr_r_d1[17]),.q_l(xx0_unused[122]), .q(xx_unused[122]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx114  (.scan_in(so[112]), .scan_out(so[113]), .l1clk(l1clk_in), .d(adr_r[18]), .latout(adr_r_d1[18]),.q_l(xx0_unused[123]), .q(xx_unused[123]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx115  (.scan_in(so[113]), .scan_out(so[114]), .l1clk(l1clk_in), .d(adr_r[19]), .latout(adr_r_d1[19]),.q_l(xx0_unused[124]), .q(xx_unused[124]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx116  (.scan_in(so[114]), .scan_out(so[115]), .l1clk(l1clk_in), .d(adr_w[16]), .latout(adr_w_d1[16]),.q_l(xx0_unused[125]), .q(xx_unused[125]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx117  (.scan_in(so[115]), .scan_out(so[116]), .l1clk(l1clk_in), .d(adr_w[17]), .latout(adr_w_d1[17]),.q_l(xx0_unused[126]), .q(xx_unused[126]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx118  (.scan_in(so[116]), .scan_out(so[117]), .l1clk(l1clk_in), .d(adr_w[18]), .latout(adr_w_d1[18]),.q_l(xx0_unused[127]), .q(xx_unused[127]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx119  (.scan_in(so[117]), .scan_out(so[118]), .l1clk(l1clk_in), .d(adr_w[19]), .latout(adr_w_d1[19]),.q_l(xx0_unused[128]), .q(xx_unused[128]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx120  (.scan_in(so[118]), .scan_out(so[119]), .l1clk(l1clk_in), .d(adr_r[20]), .latout(adr_r_d1[20]),.q_l(xx0_unused[129]), .q(xx_unused[129]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx121  (.scan_in(so[119]), .scan_out(so[120]), .l1clk(l1clk_in), .d(adr_r[21]), .latout(adr_r_d1[21]),.q_l(xx0_unused[130]), .q(xx_unused[130]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx122  (.scan_in(so[120]), .scan_out(so[121]), .l1clk(l1clk_in), .d(adr_r[22]), .latout(adr_r_d1[22]),.q_l(xx0_unused[131]), .q(xx_unused[131]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx123  (.scan_in(so[121]), .scan_out(so[122]), .l1clk(l1clk_in), .d(adr_r[23]), .latout(adr_r_d1[23]),.q_l(xx0_unused[132]), .q(xx_unused[132]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx124  (.scan_in(so[122]), .scan_out(so[123]), .l1clk(l1clk_in), .d(adr_w[20]), .latout(adr_w_d1[20]),.q_l(xx0_unused[133]), .q(xx_unused[133]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx125  (.scan_in(so[123]), .scan_out(so[124]), .l1clk(l1clk_in), .d(adr_w[21]), .latout(adr_w_d1[21]),.q_l(xx0_unused[134]), .q(xx_unused[134]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx126  (.scan_in(so[124]), .scan_out(so[125]), .l1clk(l1clk_in), .d(adr_w[22]), .latout(adr_w_d1[22]),.q_l(xx0_unused[135]), .q(xx_unused[135]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx127  (.scan_in(so[125]), .scan_out(so[126]), .l1clk(l1clk_in), .d(adr_w[23]), .latout(adr_w_d1[23]),.q_l(xx0_unused[136]), .q(xx_unused[136]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx128  (.scan_in(so[126]), .scan_out(so[127]), .l1clk(l1clk_in), .d(adr_r[27]), .latout(adr_r_d1[27]),.q_l(xx0_unused[137]), .q(xx_unused[137]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx129  (.scan_in(so[127]), .scan_out(so[128]), .l1clk(l1clk_in), .d(adr_r[26]), .latout(adr_r_d1[26]),.q_l(xx0_unused[138]), .q(xx_unused[138]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx130  (.scan_in(so[128]), .scan_out(so[129]), .l1clk(l1clk_in), .d(adr_r[25]), .latout(adr_r_d1[25]),.q_l(xx0_unused[139]), .q(xx_unused[139]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx131  (.scan_in(so[129]), .scan_out(so[130]), .l1clk(l1clk_in), .d(adr_r[24]), .latout(adr_r_d1[24]),.q_l(xx0_unused[140]), .q(xx_unused[140]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx132  (.scan_in(so[130]), .scan_out(so[131]), .l1clk(l1clk_in), .d(adr_w[27]), .latout(adr_w_d1[27]),.q_l(xx0_unused[141]), .q(xx_unused[141]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx133  (.scan_in(so[131]), .scan_out(so[132]), .l1clk(l1clk_in), .d(adr_w[26]), .latout(adr_w_d1[26]),.q_l(xx0_unused[142]), .q(xx_unused[142]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx134  (.scan_in(so[132]), .scan_out(so[133]), .l1clk(l1clk_in), .d(adr_w[25]), .latout(adr_w_d1[25]),.q_l(xx0_unused[143]), .q(xx_unused[143]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx135  (.scan_in(so[133]), .scan_out(so[134]), .l1clk(l1clk_in), .d(adr_w[24]), .latout(adr_w_d1[24]),.q_l(xx0_unused[144]), .q(xx_unused[144]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx136  (.scan_in(so[134]), .scan_out(so[135]), .l1clk(l1clk_in), .d(adr_r[31]), .latout(adr_r_d1[31]),.q_l(xx0_unused[145]), .q(xx_unused[145]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx137  (.scan_in(so[135]), .scan_out(so[136]), .l1clk(l1clk_in), .d(adr_r[30]), .latout(adr_r_d1[30]),.q_l(xx0_unused[146]), .q(xx_unused[146]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx138  (.scan_in(so[136]), .scan_out(so[137]), .l1clk(l1clk_in), .d(adr_r[29]), .latout(adr_r_d1[29]),.q_l(xx0_unused[147]), .q(xx_unused[147]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx139  (.scan_in(so[137]), .scan_out(so[138]), .l1clk(l1clk_in), .d(adr_r[28]), .latout(adr_r_d1[28]),.q_l(xx0_unused[148]), .q(xx_unused[148]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx140  (.scan_in(so[138]), .scan_out(so[139]), .l1clk(l1clk_in), .d(adr_w[31]), .latout(adr_w_d1[31]),.q_l(xx0_unused[149]), .q(xx_unused[149]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx141  (.scan_in(so[139]), .scan_out(so[140]), .l1clk(l1clk_in), .d(adr_w[30]), .latout(adr_w_d1[30]),.q_l(xx0_unused[150]), .q(xx_unused[150]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx142  (.scan_in(so[140]), .scan_out(so[141]), .l1clk(l1clk_in), .d(adr_w[29]), .latout(adr_w_d1[29]),.q_l(xx0_unused[151]), .q(xx_unused[151]),
  .siclk(siclk),
  .soclk(soclk));
n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 xx143  (.scan_in(so[141]), .scan_out(so[142]), .l1clk(l1clk_in), .d(adr_w[28]), .latout(adr_w_d1[28]),.q_l(xx0_unused[152]), .q(xx_unused[152]),
  .siclk(siclk),
  .soclk(soclk));


///////////////////
 /// Memory array ////

n2_com_cm_32x40_cust_array array (
                .l1clk(l1clk_en),
                .wr_en (mb_wen_d1),
                .rd_en (mb_ren_d1),
                .wr_addr(adr_w_d1[31:0]),
                .rd_addr(adr_r_d1[31:0]),
                .din(din_d1[41:0]),
                .dout(dout_array[41:0]),
                .tcu_array_wr_inhibit(tcu_array_wr_inhibit),
                .lookup_en(lookup_en_d1),
		.key(key_d1[41:7]),
                .match(match[31:0]),
                .match_idx(match_idx[31:0]),
		.bypass(tcu_array_bypass)
                 );

// fixscan start:
//assign ff_din_scanin             = scan_in                  ;
//assign ff_wr_en_scanin           = ff_din_scanout           ;
//assign ff_wr_adr_scanin          = ff_wr_en_scanout         ;
//assign ff_rd_adr_scanin          = ff_wr_adr_scanout        ;
//assign ff_ren_scanin             = ff_rd_adr_scanout        ;
//assign ff_lookup_en_scanin       = ff_ren_scanout         ;
//assign ff_key_scanin             = ff_lookup_en_scanout     ;
assign scan_out                  = so[142]; //ff_key_scanout           ;
// fixscan end:

endmodule








// any PARAMS parms go into naming of macro

module n2_com_cm_32x40_cust_l1clkhdr_ctl_macro (
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









//
//   macro for cl_mc1_scm_msff_lat_{4}x flops
//
//





module n2_com_cm_32x40_cust_scm_msff_lat_macro__width_1 (
  d, 
  scan_in, 
  l1clk, 
  siclk, 
  soclk, 
  latout, 
  scan_out, 
  q, 
  q_l);
input [0:0] d;
  input scan_in;
input l1clk;
input siclk;
input soclk;
output [0:0] latout;
  output scan_out;
output [0:0] q;
output [0:0] q_l;






scm_msff_lat /*#(1)*/  d0_0 (
.d(d[0:0]),
.si(scan_in),
.so(scan_out),
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.q(q[0:0]),
.q_l(q_l[0:0]),
.latout(latout[0:0])
);










//place::generic_place($width,$stack,$left);

endmodule




