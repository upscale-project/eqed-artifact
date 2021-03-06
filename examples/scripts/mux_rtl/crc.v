// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: crc.v
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
module crc(b,E_out,failover);
// interface signals
input  [71:0] b;
input failover;
output [11:0] E_out;

reg  failover_nb_14, failover_nb_13,nb_12;
wire [11:0] E_nb_13 , E ;

assign E_out =  (failover ) ? E_nb_13 : E;
               

initial begin

if($test$plusargs("fbdimm_nb_failover_14bit"))
 failover_nb_14=1;
else
 failover_nb_14=0;

if($test$plusargs("fbdimm_nb_failover_13bit"))
 failover_nb_13=1;
else
 failover_nb_13=0;


if($test$plusargs("fbdimm_nb_12bit"))
 nb_12=1;
else
 nb_12=0;

end

// 13bit lane northbound data frame



assign E_nb_13[0] = b[69] ^ b[66] ^ b[65] ^ b[64] ^ b[63] ^ b[57] ^
                    b[56] ^ b[54] ^ b[53] ^ b[52] ^ b[49] ^ b[48] ^
                    b[44] ^ b[43] ^ b[42] ^ b[40] ^ b[38] ^ b[37] ^ 
                    b[36] ^ b[35] ^ b[34] ^ b[33] ^ b[31] ^ b[30] ^ 
                    b[28] ^ b[24] ^ b[19] ^ b[17] ^ b[16] ^ b[13] ^ 
                    b[11] ^ b[09] ^ b[06] ^ b[03] ^ b[02] ^ b[01] ^ 
                    b[00] ;

assign E_nb_13[1] = b[70] ^ b[69] ^ b[67] ^ b[63] ^ b[58] ^ b[56] ^
                    b[55] ^ b[52] ^ b[50] ^ b[48] ^ b[45] ^ b[42] ^
                    b[41] ^ b[40] ^ b[39] ^ b[33] ^ b[32] ^ b[30] ^
                    b[29] ^ b[28] ^ b[25] ^ b[24] ^ b[20] ^ b[19] ^
                    b[18] ^ b[16] ^ b[14] ^ b[13] ^ b[12] ^ b[11] ^
                    b[10] ^ b[09] ^ b[07] ^ b[06] ^ b[04] ^ b[00] ;

assign E_nb_13[2] = b[71] ^ b[70] ^ b[69] ^ b[68] ^ b[66] ^ b[65] ^
                    b[63] ^ b[59] ^ b[54] ^ b[52] ^ b[51] ^ b[48] ^
                    b[46] ^ b[44] ^ b[41] ^ b[38] ^ b[37] ^ b[36] ^
                    b[35] ^ b[29] ^ b[28] ^ b[26] ^ b[25] ^ b[24] ^
                    b[21] ^ b[20] ^ b[16] ^ b[15] ^ b[14] ^ b[12] ^
                    b[10] ^ b[09] ^ b[08] ^ b[07] ^ b[06] ^ b[05] ^
                    b[03] ^ b[02] ^ b[00] ;

assign E_nb_13[3] = b[71] ^ b[70] ^ b[69] ^ b[67] ^ b[66] ^ b[64] ^
                    b[60] ^ b[55] ^ b[53] ^ b[52] ^ b[49] ^ b[47] ^
                    b[45] ^ b[42] ^ b[39] ^ b[38] ^ b[37] ^ b[36] ^
                    b[30] ^ b[29] ^ b[27] ^ b[26] ^ b[25] ^ b[22] ^
                    b[21] ^ b[17] ^ b[16] ^ b[15] ^ b[13] ^ b[11] ^
                    b[10] ^ b[09] ^ b[08] ^ b[07] ^ b[06] ^ b[04] ^
                    b[03] ^ b[01] ;

assign E_nb_13[4] = b[71] ^ b[70] ^ b[68] ^ b[67] ^ b[65] ^ b[61] ^
                    b[56] ^ b[54] ^ b[53] ^ b[50] ^ b[48] ^ b[46] ^
                    b[43] ^ b[40] ^ b[39] ^ b[38] ^ b[37] ^ b[31] ^
                    b[30] ^ b[28] ^ b[27] ^ b[26] ^ b[23] ^ b[22] ^
                    b[18] ^ b[17] ^ b[16] ^ b[14] ^ b[12] ^ b[11] ^
                    b[10] ^ b[09] ^ b[08] ^ b[07] ^ b[05] ^ b[04] ^
                    b[02] ;


assign E_nb_13[5] = b[71] ^ b[68] ^ b[65] ^ b[64] ^ b[63] ^ b[62] ^
                    b[56] ^ b[55] ^ b[53] ^ b[52] ^ b[51] ^ b[48] ^
                    b[47] ^ b[43] ^ b[42] ^ b[41] ^ b[39] ^ b[37] ^
                    b[36] ^ b[35] ^ b[34] ^ b[33] ^ b[32] ^ b[30] ^
                    b[29] ^ b[27] ^ b[23] ^ b[18] ^ b[16] ^ b[15] ^
                    b[12] ^ b[10] ^ b[08] ^ b[05] ^ b[02] ^ b[01] ^
                    b[00] ;


// 14bit lane north bound data frame

assign E[0] = b[71] ^ b[70] ^ b[68] ^ b[67] ^ b[66] ^ b[63] ^
              b[58] ^ b[56] ^ b[55] ^ b[54] ^ b[53] ^ b[52] ^
              b[49] ^ b[48] ^ b[46] ^ b[44] ^ b[42] ^ b[41] ^ 
              b[40] ^ b[39] ^ b[38] ^ b[37] ^ b[36] ^ b[35] ^ 
              b[34] ^ b[29] ^ b[26] ^ b[25] ^ b[22] ^ b[21] ^ 
              b[19] ^ b[18] ^ b[16] ^ b[12] ^ b[09] ^ b[08] ^ 
              b[07] ^ b[06] ^ b[03] ^ b[01] ^ b[0] ;

assign E[1] = b[70] ^ b[69] ^ b[66] ^ b[64] ^ b[63] ^ b[59] ^
              b[58] ^ b[57] ^ b[52] ^ b[50] ^ b[48] ^ b[47] ^
              b[46] ^ b[45] ^ b[44] ^ b[43] ^ b[34] ^ b[30] ^
              b[29] ^ b[27] ^ b[25] ^ b[23] ^ b[21] ^ b[20] ^
              b[18] ^ b[17] ^ b[16] ^ b[13] ^ b[12] ^ b[10] ^
              b[06] ^ b[04] ^ b[03] ^ b[02] ^ b[00];

assign E[2] = b[71] ^ b[70] ^ b[67] ^ b[65] ^ b[64] ^ b[60] ^
              b[59] ^ b[58] ^ b[53] ^ b[51] ^ b[49] ^ b[48] ^
              b[47] ^ b[46] ^ b[45] ^ b[44] ^ b[35] ^ b[31] ^
              b[30] ^ b[28] ^ b[26] ^ b[24] ^ b[22] ^ b[21] ^
              b[19] ^ b[18] ^ b[17] ^ b[14] ^ b[13] ^ b[11] ^
              b[07] ^ b[05] ^ b[04] ^ b[03] ^ b[01] ;

assign E[3] =  b[70] ^ b[67] ^ b[65] ^ b[63] ^ b[61] ^ b[60] ^
               b[59] ^ b[58] ^ b[56] ^ b[55] ^ b[53] ^ b[50] ^
               b[47] ^ b[45] ^ b[44] ^ b[42] ^ b[41] ^ b[40] ^
               b[39] ^ b[38] ^ b[37] ^ b[35] ^ b[34] ^ b[32] ^
               b[31] ^ b[27] ^ b[26] ^ b[23] ^ b[21] ^ b[20] ^
               b[16] ^ b[15] ^ b[14] ^ b[09] ^ b[07] ^ b[05] ^
               b[04] ^ b[03] ^ b[02] ^ b[01] ^ b[00];

assign E[4] =  b[70] ^ b[67] ^ b[64] ^ b[63] ^ b[62] ^ b[61] ^
               b[60] ^ b[59] ^ b[58] ^ b[57] ^ b[55] ^ b[53] ^
               b[52] ^ b[51] ^ b[49] ^ b[45] ^ b[44] ^ b[43] ^
               b[37] ^ b[34] ^ b[33] ^ b[32] ^ b[29] ^ b[28] ^
               b[27] ^ b[26] ^ b[25] ^ b[24] ^ b[19] ^ b[18] ^
               b[17] ^ b[15] ^ b[12] ^ b[10] ^ b[09] ^ b[07] ^
               b[05] ^ b[04] ^ b[02] ^ b[00] ;


assign E[5] =  b[71] ^ b[68] ^ b[65] ^ b[64] ^ b[63] ^ b[62] ^
               b[61] ^ b[60] ^ b[59] ^ b[58] ^ b[56] ^ b[54] ^
               b[53] ^ b[52] ^ b[50] ^ b[46] ^ b[45] ^ b[44] ^
               b[38] ^ b[35] ^ b[34] ^ b[33] ^ b[30] ^ b[29] ^
               b[28] ^ b[27] ^ b[26] ^ b[25] ^ b[20] ^ b[19] ^
               b[18] ^ b[16] ^ b[13] ^ b[11] ^ b[10] ^ b[08] ^
               b[06] ^ b[05] ^ b[03] ^ b[01] ;

assign E[6] = b[71] ^ b[70] ^ b[69] ^ b[68] ^ b[67] ^ b[65] ^
              b[64] ^ b[62] ^ b[61] ^ b[60] ^ b[59] ^ b[58] ^
              b[57] ^ b[56] ^ b[52] ^ b[51] ^ b[49] ^ b[48] ^
              b[47] ^ b[45] ^ b[44] ^ b[42] ^ b[41] ^ b[40] ^
              b[38] ^ b[37] ^ b[31] ^ b[30] ^ b[28] ^ b[27] ^
              b[25] ^ b[22] ^ b[20] ^ b[18] ^ b[17] ^ b[16] ^
              b[14] ^ b[11] ^ b[08] ^ b[04] ^ b[03] ^ b[02] ^
              b[01] ^ b[00] ;

assign E[7] = b[71] ^ b[70] ^ b[69] ^ b[68] ^ b[66] ^ b[65] ^
              b[63] ^ b[62] ^ b[61] ^ b[60] ^ b[59] ^ b[58] ^
              b[57] ^ b[53] ^ b[52] ^ b[50] ^ b[49] ^ b[48] ^
              b[46] ^ b[45] ^ b[43] ^ b[42] ^ b[41] ^ b[39] ^
              b[38] ^ b[32] ^ b[31] ^ b[29] ^ b[28] ^ b[26] ^
              b[23] ^ b[21] ^ b[19] ^ b[18] ^ b[17] ^ b[15] ^
              b[12] ^ b[09] ^ b[05] ^ b[04] ^ b[03] ^ b[02] ^
              b[1] ;

assign E[8] = b[69] ^ b[68] ^ b[64] ^ b[62] ^ b[61] ^ b[60] ^
              b[59] ^ b[56] ^ b[55] ^ b[52] ^ b[51] ^ b[50] ^
              b[48] ^ b[47] ^ b[43] ^ b[41] ^ b[38] ^ b[37] ^
              b[36] ^ b[35] ^ b[34] ^ b[33] ^ b[32] ^ b[30] ^
              b[27] ^ b[26] ^ b[25] ^ b[24] ^ b[21] ^ b[20] ^
              b[13] ^ b[12] ^ b[10] ^ b[09] ^ b[08] ^ b[07] ^
              b[05] ^ b[04] ^ b[02] ^ b[01] ^ b[0];

assign E[9] = b[70] ^ b[69] ^ b[65] ^ b[63] ^ b[62] ^ b[61] ^
              b[60] ^ b[57] ^ b[56] ^ b[53] ^ b[52] ^ b[51] ^
              b[49] ^ b[48] ^ b[44] ^ b[42] ^ b[39] ^ b[38] ^
              b[37] ^ b[36] ^ b[35] ^ b[34] ^ b[33] ^ b[31] ^
              b[28] ^ b[27] ^ b[26] ^ b[25] ^ b[22] ^ b[21] ^
              b[14] ^ b[13] ^ b[11] ^ b[10] ^ b[09] ^ b[08] ^
              b[06] ^ b[05] ^ b[03] ^ b[02] ^ b[01];

assign E[10] = b[68] ^ b[67] ^ b[64] ^ b[62] ^ b[61] ^ b[57] ^
               b[56] ^ b[55] ^ b[50] ^ b[48] ^ b[46] ^ b[45] ^
               b[44] ^ b[43] ^ b[42] ^ b[41] ^ b[32] ^ b[28] ^
               b[27] ^ b[25] ^ b[23] ^ b[21] ^ b[19] ^ b[18] ^
               b[16] ^ b[15] ^ b[14] ^ b[11] ^ b[10] ^ b[08] ^
               b[04] ^ b[02] ^ b[01] ^ b[00];


assign E[11] = b[71] ^ b[70] ^ b[69] ^ b[67] ^ b[66] ^ b[65] ^
               b[62] ^ b[57] ^ b[55] ^ b[54] ^ b[53] ^ b[52] ^
               b[51] ^ b[48] ^ b[47] ^ b[45] ^ b[43] ^ b[41] ^
               b[40] ^ b[39] ^ b[38] ^ b[37] ^ b[36] ^ b[35] ^
               b[34] ^ b[33] ^ b[28] ^ b[25] ^ b[24] ^ b[21] ^
               b[20] ^ b[18] ^ b[17] ^ b[15] ^ b[11] ^ b[08] ^
               b[07] ^ b[06] ^ b[05] ^ b[02] ^ b[00];


endmodule

module crc_aE(B,E);
// interface signals
input  [25:0] B;
output [13:0] E;

assign E[0] = B[24] ^ B[22] ^ B[21] ^ B[18] ^ B[17] ^ B[15] ^
B[14] ^ B[9] ^ B[8] ^ B[7] ^ B[6] ^ B[4] ^
B[1] ^ B[0];

assign E[1] = B[25] ^ B[24] ^ B[23] ^ B[21] ^ B[19] ^ B[17] ^
B[16] ^ B[14] ^ B[10] ^ B[6] ^ B[5] ^ B[4] ^
B[2] ^ B[0] ;


assign E[2] = B[25] ^ B[21] ^ B[20] ^ B[14] ^ B[11] ^ B[9] ^
B[8] ^ B[5] ^ B[4] ^ B[3] ^ B[0];

assign E[3] = B[24] ^ B[18] ^ B[17] ^ B[14] ^ B[12] ^ B[10] ^
B[8] ^ B[7] ^ B[5] ^ B[0];

assign E[4] = B[25] ^ B[19] ^ B[18] ^ B[15] ^ B[13] ^ B[11] ^
B[9] ^ B[8] ^ B[6] ^ B[1];

assign E[5] = B[20] ^ B[19] ^ B[16] ^ B[14] ^ B[12] ^ B[10] ^
B[9] ^ B[7] ^ B[2];

assign E[6] = B[24] ^ B[22] ^ B[20] ^ B[18] ^ B[14] ^ B[13] ^
B[11] ^ B[10] ^ B[9] ^ B[7] ^ B[6] ^ B[4] ^
B[3] ^ B[1] ^ B[0];

assign E[7] = B[25] ^ B[23] ^ B[21] ^ B[19] ^ B[15] ^ B[14] ^
B[12] ^ B[11] ^ B[10] ^ B[8] ^ B[7] ^ B[5] ^
B[4] ^ B[2] ^ B[1];

assign E[8] = B[21] ^ B[20] ^ B[18] ^ B[17] ^ B[16] ^ B[14] ^
B[13] ^ B[12] ^ B[11] ^ B[7] ^ B[5] ^ B[4] ^
B[3] ^ B[2] ^ B[1] ^ B[0];

assign E[9] = B[24] ^ B[19] ^ B[13] ^ B[12] ^ B[9] ^ B[7] ^
B[5] ^ B[3] ^ B[2] ^ B[0];

assign E[10] = B[25] ^ B[20] ^ B[14] ^ B[13] ^ B[10] ^ B[8] ^
B[6] ^ B[4] ^ B[3] ^ B[1];

assign E[11] = B[24] ^ B[22] ^ B[18] ^ B[17] ^ B[11] ^ B[8] ^
B[6] ^ B[5] ^ B[2] ^ B[1] ^ B[0];

assign E[12] = B[25] ^ B[24] ^ B[23] ^ B[22] ^ B[21] ^ B[19] ^
B[17] ^ B[15] ^ B[14] ^ B[12] ^ B[8] ^ B[4] ^ B[3] ^ B[2] ^ B[0];

assign E[13] = B[25] ^ B[23] ^ B[21] ^ B[20] ^ B[17] ^ B[16] ^
B[14] ^ B[13] ^ B[8] ^ B[7] ^ B[6] ^ B[5] ^ B[3] ^ B[0];


endmodule


module crc_FE(B,E);
// interface signals
input  [71:0] B;
output [21:0] E;

assign E[0] = B[70] ^ B[69] ^ B[66] ^ B[62] ^ B[61] ^ B[59] ^
B[58] ^ B[55] ^ B[54] ^ B[53] ^ B[50] ^ B[49] ^
B[42] ^ B[39] ^ B[33] ^ B[32] ^ B[31] ^ B[29] ^
B[27] ^ B[25] ^ B[24] ^ B[22] ^ B[21] ^ B[19] ^
B[18] ^ B[16] ^ B[15] ^ B[10] ^ B[9] ^ B[8] ^
B[0];

assign E[1] = B[71] ^ B[69] ^ B[67] ^ B[66] ^ B[63] ^ B[61] ^
B[60] ^ B[58] ^ B[56] ^ B[53] ^ B[51] ^ B[49] ^
B[43] ^ B[42] ^ B[40] ^ B[39] ^ B[34] ^ B[31] ^
B[30] ^ B[29] ^ B[28] ^ B[27] ^ B[26] ^ B[24] ^
B[23] ^ B[21] ^ B[20] ^ B[18] ^ B[17] ^ B[15] ^
B[11] ^ B[8] ^ B[1] ^ B[0];

assign E[2] = B[69] ^ B[68] ^ B[67] ^ B[66] ^ B[64] ^ B[58] ^
B[57] ^ B[55] ^ B[53] ^ B[52] ^ B[49] ^ B[44] ^
B[43] ^ B[42] ^ B[41] ^ B[40] ^ B[39] ^ B[35] ^
B[33] ^ B[30] ^ B[28] ^ B[15] ^ B[12] ^ B[10] ^
B[8] ^ B[2] ^ B[1] ^ B[0];

assign E[3] = B[68] ^ B[67] ^ B[66] ^ B[65] ^ B[62] ^ B[61] ^
B[56] ^ B[55] ^ B[49] ^ B[45] ^ B[44] ^ B[43] ^
B[41] ^ B[40] ^ B[39] ^ B[36] ^ B[34] ^ B[33] ^
B[32] ^ B[27] ^ B[25] ^ B[24] ^ B[22] ^ B[21] ^
B[19] ^ B[18] ^ B[15] ^ B[13] ^ B[11] ^ B[10] ^
B[8] ^ B[3] ^ B[2] ^ B[1] ^ B[0];

assign E[4] = B[69] ^ B[68] ^ B[67] ^ B[66] ^ B[63] ^ B[62] ^
B[57] ^ B[56] ^ B[50] ^ B[46] ^ B[45] ^ B[44] ^
B[42] ^ B[41] ^ B[40] ^ B[37] ^ B[35] ^ B[34] ^
B[33] ^ B[28] ^ B[26] ^ B[25] ^ B[23] ^ B[22] ^
B[20] ^ B[19] ^ B[16] ^ B[14] ^ B[12] ^ B[11] ^
B[9] ^ B[4] ^ B[3] ^ B[2] ^ B[1];

assign E[5] = B[70] ^ B[69] ^ B[68] ^ B[67] ^ B[64] ^ B[63] ^
B[58] ^ B[57] ^ B[51] ^ B[47] ^ B[46] ^ B[45] ^
B[43] ^ B[42] ^ B[41] ^ B[38] ^ B[36] ^ B[35] ^
B[34] ^ B[29] ^ B[27] ^ B[26] ^ B[24] ^ B[23] ^
B[21] ^ B[20] ^ B[17] ^ B[15] ^ B[13] ^ B[12] ^
B[10] ^ B[5] ^ B[4] ^ B[3] ^ B[2];

assign E[6] = B[71] ^ B[70] ^ B[69] ^ B[68] ^ B[65] ^ B[64] ^
B[59] ^ B[58] ^ B[52] ^ B[48] ^ B[47] ^ B[46] ^
B[44] ^ B[43] ^ B[42] ^ B[39] ^ B[37] ^ B[36] ^
B[35] ^ B[30] ^ B[28] ^ B[27] ^ B[25] ^ B[24] ^
B[22] ^ B[21] ^ B[18] ^ B[16] ^ B[14] ^ B[13] ^
B[11] ^ B[6] ^ B[5] ^ B[4] ^ B[3];

assign E[7] = B[71] ^ B[65] ^ B[62] ^ B[61] ^ B[60] ^ B[58] ^
B[55] ^ B[54] ^ B[50] ^ B[48] ^ B[47] ^ B[45] ^
B[44] ^ B[43] ^ B[42] ^ B[40] ^ B[39] ^ B[38] ^
B[37] ^ B[36] ^ B[33] ^ B[32] ^ B[28] ^ B[27] ^
B[26] ^ B[24] ^ B[23] ^ B[21] ^ B[18] ^ B[17] ^
B[16] ^ B[14] ^ B[12] ^ B[10] ^ B[9] ^ B[8] ^
B[7] ^ B[6] ^ B[5] ^ B[4] ^ B[0];

assign E[8] = B[66] ^ B[63] ^ B[62] ^ B[61] ^ B[59] ^ B[56] ^
B[55] ^ B[51] ^ B[49] ^ B[48] ^ B[46] ^ B[45] ^
B[44] ^ B[43] ^ B[41] ^ B[40] ^ B[39] ^ B[38] ^
B[37] ^ B[34] ^ B[33] ^ B[29] ^ B[28] ^ B[27] ^
B[25] ^ B[24] ^ B[22] ^ B[19] ^ B[18] ^ B[17] ^
B[15] ^ B[13] ^ B[11] ^ B[10] ^ B[9] ^ B[8] ^
B[7] ^ B[6] ^ B[5] ^ B[1];

assign E[9] = B[67] ^ B[64] ^ B[63] ^ B[62] ^ B[60] ^ B[57] ^
B[56] ^ B[52] ^ B[50] ^ B[49] ^ B[47] ^ B[46] ^
B[45] ^ B[44] ^ B[42] ^ B[41] ^ B[40] ^ B[39] ^
B[38] ^ B[35] ^ B[34] ^ B[30] ^ B[29] ^ B[28] ^
B[26] ^ B[25] ^ B[23] ^ B[20] ^ B[19] ^ B[18] ^
B[16] ^ B[14] ^ B[12] ^ B[11] ^ B[10] ^ B[9] ^
B[8] ^ B[7] ^ B[6] ^ B[2];

assign E[10] = B[68] ^ B[65] ^ B[64] ^ B[63] ^ B[61] ^ B[58] ^
B[57] ^ B[53] ^ B[51] ^ B[50] ^ B[48] ^ B[47] ^
B[46] ^ B[45] ^ B[43] ^ B[42] ^ B[41] ^ B[40] ^
B[39] ^ B[36] ^ B[35] ^ B[31] ^ B[30] ^ B[29] ^
B[27] ^ B[26] ^ B[24] ^ B[21] ^ B[20] ^ B[19] ^
B[17] ^ B[15] ^ B[13] ^ B[12] ^ B[11] ^ B[10] ^
B[9] ^ B[8] ^ B[7] ^ B[3];

assign E[11] = B[69] ^ B[66] ^ B[65] ^ B[64] ^ B[62] ^ B[59] ^
B[58] ^ B[54] ^ B[52] ^ B[51] ^ B[49] ^ B[48] ^
B[47] ^ B[46] ^ B[44] ^ B[43] ^ B[42] ^ B[41] ^
B[40] ^ B[37] ^ B[36] ^ B[32] ^ B[31] ^ B[30] ^
B[28] ^ B[27] ^ B[25] ^ B[22] ^ B[21] ^ B[20] ^
B[18] ^ B[16] ^ B[14] ^ B[13] ^ B[12] ^ B[11] ^
B[10] ^ B[9] ^ B[8] ^ B[4];

assign E[12] = B[69] ^ B[67] ^ B[65] ^ B[63] ^ B[62] ^ B[61] ^
B[60] ^ B[58] ^ B[54] ^ B[52] ^ B[48] ^ B[47] ^
B[45] ^ B[44] ^ B[43] ^ B[41] ^ B[39] ^ B[38] ^
B[37] ^ B[28] ^ B[27] ^ B[26] ^ B[25] ^ B[24] ^
B[23] ^ B[18] ^ B[17] ^ B[16] ^ B[14] ^ B[13] ^
B[12] ^ B[11] ^ B[8] ^ B[5] ^ B[0];


assign E[13] = B[69] ^ B[68] ^ B[64] ^ B[63] ^ B[58] ^ B[54] ^
B[50] ^ B[48] ^ B[46] ^ B[45] ^ B[44] ^ B[40] ^
B[38] ^ B[33] ^ B[32] ^ B[31] ^ B[28] ^ B[26] ^
B[22] ^ B[21] ^ B[17] ^ B[16] ^ B[14] ^ B[13] ^
B[12] ^ B[10] ^ B[8] ^ B[6] ^ B[1] ^ B[0];

assign E[14] = B[66] ^ B[65] ^ B[64] ^ B[62] ^ B[61] ^ B[58] ^
B[54] ^ B[53] ^ B[51] ^ B[50] ^ B[47] ^ B[46] ^
B[45] ^ B[42] ^ B[41] ^ B[34] ^ B[31] ^ B[25] ^
B[24] ^ B[23] ^ B[21] ^ B[19] ^ B[17] ^ B[16] ^
B[14] ^ B[13] ^ B[11] ^ B[10] ^ B[8] ^ B[7] ^
B[2] ^ B[1] ^ B[0];

assign E[15] = B[67] ^ B[66] ^ B[65] ^ B[63] ^ B[62] ^ B[59] ^
B[55] ^ B[54] ^ B[52] ^ B[51] ^ B[48] ^ B[47] ^
B[46] ^ B[43] ^ B[42] ^ B[35] ^ B[32] ^ B[26] ^
B[25] ^ B[24] ^ B[22] ^ B[20] ^ B[18] ^ B[17] ^
B[15] ^ B[14] ^ B[12] ^ B[11] ^ B[9] ^ B[8] ^
B[3] ^ B[2] ^ B[1];

assign E[16] = B[68] ^ B[67] ^ B[66] ^ B[64] ^ B[63] ^ B[60] ^
B[56] ^ B[55] ^ B[53] ^ B[52] ^ B[49] ^ B[48] ^
B[47] ^ B[44] ^ B[43] ^ B[36] ^ B[33] ^ B[27] ^
B[26] ^ B[25] ^ B[23] ^ B[21] ^ B[19] ^ B[18] ^
B[16] ^ B[15] ^ B[13] ^ B[12] ^ B[10] ^ B[9] ^
B[4] ^ B[3] ^ B[2];

assign E[17] = B[69] ^ B[68] ^ B[67] ^ B[65] ^ B[64] ^ B[61] ^
B[57] ^ B[56] ^ B[54] ^ B[53] ^ B[50] ^ B[49] ^
B[48] ^ B[45] ^ B[44] ^ B[37] ^ B[34] ^ B[28] ^
B[27] ^ B[26] ^ B[24] ^ B[22] ^ B[20] ^ B[19] ^
B[17] ^ B[16] ^ B[14] ^ B[13] ^ B[11] ^ B[10] ^
B[5] ^ B[4] ^ B[3];

assign E[18] = B[70] ^ B[69] ^ B[68] ^ B[66] ^ B[65] ^ B[62] ^
B[58] ^ B[57] ^ B[55] ^ B[54] ^ B[51] ^ B[50] ^
B[49] ^ B[46] ^ B[45] ^ B[38] ^ B[35] ^ B[29] ^
B[28] ^ B[27] ^ B[25] ^ B[23] ^ B[21] ^ B[20] ^
B[18] ^ B[17] ^ B[15] ^ B[14] ^ B[12] ^ B[11] ^
B[6] ^ B[5] ^ B[4];

assign E[19] = B[71] ^ B[70] ^ B[69] ^ B[67] ^ B[66] ^ B[63] ^
B[59] ^ B[58] ^ B[56] ^ B[55] ^ B[52] ^ B[51] ^
B[50] ^ B[47] ^ B[46] ^ B[39] ^ B[36] ^ B[30] ^
B[29] ^ B[28] ^ B[26] ^ B[24] ^ B[22] ^ B[21] ^
B[19] ^ B[18] ^ B[16] ^ B[15] ^ B[13] ^ B[12] ^
B[7] ^ B[6] ^ B[5];

assign E[20] = B[71] ^ B[70] ^ B[68] ^ B[67] ^ B[64] ^ B[60] ^
B[59] ^ B[57] ^ B[56] ^ B[53] ^ B[52] ^ B[51] ^
B[48] ^ B[47] ^ B[40] ^ B[37] ^ B[31] ^ B[30] ^
B[29] ^ B[27] ^ B[25] ^ B[23] ^ B[22] ^ B[20] ^
B[19] ^ B[17] ^ B[16] ^ B[14] ^ B[13] ^ B[8] ^
B[7] ^ B[6];

assign E[21] = B[71] ^ B[69] ^ B[68] ^ B[65] ^ B[61] ^ B[60] ^
B[58] ^ B[57] ^ B[54] ^ B[53] ^ B[52] ^ B[49] ^
B[48] ^ B[41] ^ B[38] ^ B[32] ^ B[31] ^ B[30] ^
B[28] ^ B[26] ^ B[24] ^ B[23] ^ B[21] ^ B[20] ^
B[18] ^ B[17] ^ B[15] ^ B[14] ^ B[9] ^ B[8] ^
B[7];

 endmodule


module crc_aE_failover(B,E);
// interface signals
input  [25:0] B;
output [9:0] E;


assign E[0] = B[25] ^ B[22] ^ B[21] ^ B[19] ^ B[17] ^ 
         B[16] ^ B[14] ^ B[13] ^ B[10] ^ B[8] ^ B[2] 
         ^ B[1] ^ B[0]; 

assign E[1] = B[25] ^ B[23] ^ B[21] ^ B[20] ^  B[19] 
         ^ B[18] ^ B[16] ^ B[15] ^ B[13] ^ B[11]   
         ^ B[10] ^ B[9] ^ B[8] ^ B[3] ^ B[0]; 

assign E[2] = B[25] ^ B[24] ^ B[20] ^ B[13] ^ B[12] ^ B[11] ^ B[9] 
 ^ B[8] ^ B[4] ^ B[2] ^ B[0]; 

assign E[3] = B[22] ^ B[19] ^ B[17] ^ B[16] ^ B[12] ^ B[9] ^ B[8] ^ B[5] ^ B[3] ^ B[2] ^ B[0]; 

assign E[4] = B[25] ^ B[23] ^ B[22] ^ B[21] ^ B[20] ^ B[19] ^ B[18] ^ B[16] ^ B[14] ^ B[9] ^ B[8] ^ B[6] ^ B[4] ^ B[3] ^ B[2] ^ B[0]; 

assign E[5] = B[24] ^ B[23] ^ B[22] ^ B[21] ^ B[20] ^ B[19] ^ B[17] ^ B[15] ^ B[10] ^ B[9] ^ B[7] ^ B[5] ^ B[4] ^ B[3] ^ B[1]; 

assign E[6] = B[24] ^ B[23] ^ B[20] ^ B[19] ^ B[18] ^ B[17] ^ B[14] ^ B[13] ^ B[11] ^ B[6] ^ B[5] ^ B[4] ^ B[1] ^ B[0]; 

assign E[7] = B[24] ^ B[22] ^ B[20] ^ B[18] ^ B[17] ^ B[16] ^ B[15] ^ B[13] ^ B[12] ^ B[10] ^ B[8] ^ B[7] ^ B[6] ^ B[5] ^ B[0]; 

assign E[8] = B[25] ^ B[23] ^ B[21] ^ B[19] ^ B[18] ^ B[17] ^ B[16] ^ B[14] ^ B[13] ^ B[11] ^ B[9] ^ B[8] ^ B[7] ^ B[6] ^ B[1]; 

assign E[9] = B[25] ^ B[24] ^ B[21] ^ B[20] ^ B[18] ^ B[16] ^ B[15] ^ B[13] ^ B[12] ^ B[9] ^ B[7] ^ B[1] ^ B[0];

 


endmodule


module crc_FE_failover(B,E);
// interface signals
input  [71:0] B;
output [9:0] E;

 assign E[0] = B[71] ^ B[65] ^ B[63] ^ B[62] ^ B[59] ^ B[58] ^ B[57] ^ B[55] ^ B[53] ^ B[52] ^ B[51] ^ B[50] ^ B[49] ^ B[48] ^ B[45] ^ 
B[44] ^ B[41] ^ B[36] ^ B[34] ^ B[32] ^ B[31] ^ B[29] ^ B[26] ^ B[25] ^ B[22] ^ B[21] ^ B[19] ^ B[17] ^ B[16] ^ B[14] ^ B[13] ^ B[10] ^ B[8] ^ B[2] ^ B[1] ^ B[0]; 

assign E[1] = B[71] ^ B[66] ^ B[65] ^ B[64] ^ B[62] ^ B[60] ^ B[57] ^ B[56] ^ B[55] ^ B[54] ^ B[48] ^ B[46] ^ B[44] ^ B[42] ^ B[41] ^ 
B[37] ^ B[36] ^ B[35] ^ B[34] ^ B[33] ^ B[31] ^ B[30] ^ B[29] ^ B[27] ^ B[25] ^ B[23] ^ B[21] ^ B[20] ^ B[19] ^ B[18] ^ B[16] ^ B[15] ^ B[13] ^ B[11] ^ B[10] ^ B[9] ^ B[8] ^ B[3] ^ B[0]; 

assign E[2] = B[71] ^ B[67] ^ B[66] ^ B[62] ^ B[61] ^ B[59] ^ B[56] ^ B[53] ^ B[52] ^ B[51] ^ B[50] ^ B[48] ^ B[47] ^ B[44] ^ B[43] ^ 
B[42] ^ B[41] ^ B[38] ^ B[37] ^ B[35] ^ B[30] ^ B[29] ^ B[28] ^ B[25] ^ B[24] ^ B[20] ^ B[13] ^ B[12] ^ B[11] ^ B[9] ^ B[8] ^ B[4] ^ B[2] ^ B[0]; 

assign E[3] = B[71] ^ B[68] ^ B[67] ^ B[65] ^ B[60] ^ B[59] ^ B[58] ^ B[55] ^ B[54] ^ B[50] ^ B[43] ^ B[42] ^ B[41] ^ B[39] ^ B[38] ^ 
B[34] ^ B[32] ^ B[30] ^ B[22] ^ B[19] ^ B[17] ^ B[16] ^ B[12] ^ B[9] ^ B[8] ^ B[5] ^ B[3] ^ B[2] ^ B[0]; 

assign E[4] = B[71] ^ B[69] ^ B[68] ^ B[66] ^ B[65] ^ B[63] ^ B[62] ^ B[61] ^ B[60] ^ B[58] ^ B[57] ^ B[56] ^ B[53] ^ B[52] ^ B[50] ^ 
B[49] ^ B[48] ^ B[45] ^ B[43] ^ B[42] ^ B[41] ^ B[40] ^ B[39] ^ B[36] ^ B[35] ^ B[34] ^ B[33] ^ B[32] ^ B[29] ^ B[26] ^ B[25] ^ B[23] ^ B[22] ^ B[21] ^ B[20] ^ B[19] ^ B[18] ^ B[16] ^ B[14] ^ B[9] ^ B[8] ^ B[6] ^ B[4] ^ B[3] ^ B[2] ^ B[0]; 

assign E[5] = B[70] ^ B[69] ^ B[67] ^ B[66] ^ B[64] ^ B[63] ^ B[62] ^ B[61] ^ B[59] ^ B[58] ^ B[57] ^ B[54] ^ B[53] ^ B[51] ^ B[50] ^ 
B[49] ^ B[46] ^ B[44] ^ B[43] ^ B[42] ^ B[41] ^ B[40] ^ B[37] ^ B[36] ^ B[35] ^ B[34] ^ B[33] ^ B[30] ^ B[27] ^ B[26] ^ B[24] ^ B[23] ^ B[22] ^ B[21] ^ B[20] ^ B[19] ^ B[17] ^ B[15] ^ B[10] ^ B[9] ^ B[7] ^ B[5] ^ B[4] ^ B[3] ^ B[1]; 

assign E[6] = B[70] ^ B[68] ^ B[67] ^ B[64] ^ B[60] ^ B[57] ^ B[54] ^ B[53] ^ B[49] ^ B[48] ^ B[47] ^ B[43] ^ B[42] ^ B[38] ^ B[37] ^ 
B[35] ^ B[32] ^ B[29] ^ B[28] ^ B[27] ^ B[26] ^ B[24] ^ B[23] ^ B[20] ^  B[19] ^ B[18] ^ B[17] ^ B[14] ^ B[13] ^ B[11] ^ B[6] ^ B[5] ^ B[4] ^ B[1] ^ B[0]; 

assign E[7] = B[69] ^ B[68] ^ B[63] ^ B[62] ^ B[61] ^ B[59] ^ B[57] ^ B[54] ^ B[53] ^ B[52] ^ B[51] ^ B[45] ^ B[43] ^ B[41] ^ B[39] ^ 
B[38] ^ B[34] ^ B[33] ^ B[32] ^ B[31] ^ B[30] ^ B[28] ^ B[27] ^ B[26] ^ B[24] ^ B[22] ^ B[20] ^ B[18] ^ B[17] ^ B[16] ^ B[15] ^ B[13] ^ B[12] ^ B[10] ^ B[8] ^ B[7] ^ B[6] ^ B[5] ^ B[0]; 

assign E[8] = B[70] ^ B[69] ^ B[64] ^ B[63] ^ B[62] ^ B[60] ^ B[58] ^ B[55] ^ B[54] ^ B[53] ^ B[52] ^ B[46] ^ B[44] ^ B[42] ^ B[40] ^ 
B[39] ^ B[35] ^ B[34] ^ B[33] ^ B[32] ^ B[31] ^ B[29] ^ B[28] ^ B[27] ^ B[25] ^ B[23] ^ B[21] ^ B[19] ^ B[18] ^ B[17] ^ B[16] ^ B[14] ^ B[13] ^ B[11] ^ B[9] ^ B[8] ^ B[7] ^ B[6] ^ B[1]; 

assign E[9] = B[70] ^ B[64] ^ B[62] ^ B[61] ^ B[58] ^ B[57] ^ B[56] ^ B[54] ^ B[52] ^ B[51] ^ B[50] ^ B[49] ^ B[48] ^ B[47] ^ B[44] ^ 
B[43] ^ B[40] ^ B[35] ^ B[33] ^ B[31] ^ B[30] ^ B[28] ^ B[25] ^ B[24] ^ B[21] ^ B[20] ^ B[18] ^ B[16] ^ B[15] ^ B[13] ^ B[12] ^ B[9] ^ B[7] ^ B[1] ^ B[0];

 endmodule


