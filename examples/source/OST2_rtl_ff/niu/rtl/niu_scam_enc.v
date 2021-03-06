// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: niu_scam_enc.v
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

/**********************************************************
***********************************************************

    Project         : Niu

    File name       : niu_scam_enc.v

    Module(s) name  : niu_scam_enc

    Parent modules  : niu_scam.v

    Child modules   : niu_scam_hit 

    Author's name   : George Chu

    Date            : Jan. 2004

    Description     : 

    Synthesis Notes:

    Modification History:
    Date       Description
    ----       -----------

************************************************************
***********************************************************/

`timescale 1ns/10ps

module niu_scam_enc (
                     match_array,
                     cmp_enc,
                     reset,
                     cam_clk,
                     cam_hit,
                     cam_haddr);

input  [127:0] match_array;   // matched entries
input          cmp_enc;       // do priority encode
input          reset;
input          cam_clk;       // tcam internal clock
output         cam_hit;       // cam has a match/hit
output   [6:0] cam_haddr;     // cam's match/hit address

reg            cam_hit;
reg      [6:0] cam_haddr;

reg    [127:0] match_array_d;

wire           hit; 
reg      [6:0] haddr; 

  assign hit = |(match_array[127:0]);

// ------------------ priority encode the hit address ---------
  always @(match_array_d) 
    casez (match_array_d) // synopsys parallel_case
//            1 1  1 1  1 1  1 
//            6 5  4 3  2 1  0 9  8 7  6 5  4 3  2 1
      ({124'h????_????_????_????_????_????_????_???,4'b???1}       ): haddr=7'h00;
      ({124'h????_????_????_????_????_????_????_???,4'b??10}       ): haddr=7'h01;
      ({124'h????_????_????_????_????_????_????_???,4'b?100}       ): haddr=7'h02;
      ({124'h????_????_????_????_????_????_????_???,4'b1000}       ): haddr=7'h03;
      ({120'h????_????_????_????_????_????_????_??, 4'b???1,  4'b0}): haddr=7'h04;
      ({120'h????_????_????_????_????_????_????_??, 4'b??10,  4'b0}): haddr=7'h05;
      ({120'h????_????_????_????_????_????_????_??, 4'b?100,  4'b0}): haddr=7'h06;
      ({120'h????_????_????_????_????_????_????_??, 4'b1000,  4'b0}): haddr=7'h07;
      ({116'h????_????_????_????_????_????_????_?,  4'b???1,  8'b0}): haddr=7'h08;
      ({116'h????_????_????_????_????_????_????_?,  4'b??10,  8'b0}): haddr=7'h09;
      ({116'h????_????_????_????_????_????_????_?,  4'b?100,  8'b0}): haddr=7'h0a;
      ({116'h????_????_????_????_????_????_????_?,  4'b1000,  8'b0}): haddr=7'h0b;
      ({112'h????_????_????_????_????_????_????,    4'b???1, 12'b0}): haddr=7'h0c;
      ({112'h????_????_????_????_????_????_????,    4'b??10, 12'b0}): haddr=7'h0d;
      ({112'h????_????_????_????_????_????_????,    4'b?100, 12'b0}): haddr=7'h0e;
      ({112'h????_????_????_????_????_????_????,    4'b1000, 12'b0}): haddr=7'h0f;

//            1 1  1 1  1 1  1
//            6 5  4 3  2 1  0 9  8 7  6 5  4 3  2 1
      ({108'h????_????_????_????_????_????_???,     4'b???1, 16'b0}): haddr=7'h10;
      ({108'h????_????_????_????_????_????_???,     4'b??10, 16'b0}): haddr=7'h11;
      ({108'h????_????_????_????_????_????_???,     4'b?100, 16'b0}): haddr=7'h12;
      ({108'h????_????_????_????_????_????_???,     4'b1000, 16'b0}): haddr=7'h13;
      ({104'h????_????_????_????_????_????_??,      4'b???1, 20'b0}): haddr=7'h14;
      ({104'h????_????_????_????_????_????_??,      4'b??10, 20'b0}): haddr=7'h15;
      ({104'h????_????_????_????_????_????_??,      4'b?100, 20'b0}): haddr=7'h16;
      ({104'h????_????_????_????_????_????_??,      4'b1000, 20'b0}): haddr=7'h17;
      ({100'h????_????_????_????_????_????_?,       4'b???1, 24'b0}): haddr=7'h18;
      ({100'h????_????_????_????_????_????_?,       4'b??10, 24'b0}): haddr=7'h19;
      ({100'h????_????_????_????_????_????_?,       4'b?100, 24'b0}): haddr=7'h1a;
      ({100'h????_????_????_????_????_????_?,       4'b1000, 24'b0}): haddr=7'h1b;
      ({096'h????_????_????_????_????_????,         4'b???1, 28'b0}): haddr=7'h1c;
      ({096'h????_????_????_????_????_????,         4'b??10, 28'b0}): haddr=7'h1d;
      ({096'h????_????_????_????_????_????,         4'b?100, 28'b0}): haddr=7'h1e;
      ({096'h????_????_????_????_????_????,         4'b1000, 28'b0}): haddr=7'h1f;

//            1 1  1 1  1 1  1 
//            6 5  4 3  2 1  0 9  8 7  6 5  4 3  2 1
      ({092'h????_????_????_????_????_???,          4'b???1, 32'b0}): haddr=7'h20;
      ({092'h????_????_????_????_????_???,          4'b??10, 32'b0}): haddr=7'h21;
      ({092'h????_????_????_????_????_???,          4'b?100, 32'b0}): haddr=7'h22;
      ({092'h????_????_????_????_????_???,          4'b1000, 32'b0}): haddr=7'h23;
      ({088'h????_????_????_????_????_??,           4'b???1, 36'b0}): haddr=7'h24;
      ({088'h????_????_????_????_????_??,           4'b??10, 36'b0}): haddr=7'h25;
      ({088'h????_????_????_????_????_??,           4'b?100, 36'b0}): haddr=7'h26;
      ({088'h????_????_????_????_????_??,           4'b1000, 36'b0}): haddr=7'h27;
      ({084'h????_????_????_????_????_?,            4'b???1, 40'b0}): haddr=7'h28;
      ({084'h????_????_????_????_????_?,            4'b??10, 40'b0}): haddr=7'h29;
      ({084'h????_????_????_????_????_?,            4'b?100, 40'b0}): haddr=7'h2a;
      ({084'h????_????_????_????_????_?,            4'b1000, 40'b0}): haddr=7'h2b;
      ({080'h????_????_????_????_????,              4'b???1, 44'b0}): haddr=7'h2c;
      ({080'h????_????_????_????_????,              4'b??10, 44'b0}): haddr=7'h2d;
      ({080'h????_????_????_????_????,              4'b?100, 44'b0}): haddr=7'h2e;
      ({080'h????_????_????_????_????,              4'b1000, 44'b0}): haddr=7'h2f;

//            1 1  1 1  1 1  1 
//            6 5  4 3  2 1  0 9  8 7  6 5  4 3  2 1
      ({076'h????_????_????_????_???,               4'b???1, 48'b0}): haddr=7'h30;
      ({076'h????_????_????_????_???,               4'b??10, 48'b0}): haddr=7'h31;
      ({076'h????_????_????_????_???,               4'b?100, 48'b0}): haddr=7'h32;
      ({076'h????_????_????_????_???,               4'b1000, 48'b0}): haddr=7'h33;
      ({072'h????_????_????_????_??,                4'b???1, 52'b0}): haddr=7'h34;
      ({072'h????_????_????_????_??,                4'b??10, 52'b0}): haddr=7'h35;
      ({072'h????_????_????_????_??,                4'b?100, 52'b0}): haddr=7'h36;
      ({072'h????_????_????_????_??,                4'b1000, 52'b0}): haddr=7'h37;
      ({068'h????_????_????_????_?,                 4'b???1, 56'b0}): haddr=7'h38;
      ({068'h????_????_????_????_?,                 4'b??10, 56'b0}): haddr=7'h39;
      ({068'h????_????_????_????_?,                 4'b?100, 56'b0}): haddr=7'h3a;
      ({068'h????_????_????_????_?,                 4'b1000, 56'b0}): haddr=7'h3b;
      ({064'h????_????_????_????,                   4'b???1, 60'b0}): haddr=7'h3c;
      ({064'h????_????_????_????,                   4'b??10, 60'b0}): haddr=7'h3d;
      ({064'h????_????_????_????,                   4'b?100, 60'b0}): haddr=7'h3e;
      ({064'h????_????_????_????,                   4'b1000, 60'b0}): haddr=7'h3f;

//            1 1  1 1  1 1  1 
//            6 5  4 3  2 1  0 9  8 7  6 5  4 3  2 1
      ({060'h????_????_????_???,                    4'b???1, 64'b0}): haddr=7'h40;
      ({060'h????_????_????_???,                    4'b??10, 64'b0}): haddr=7'h41;
      ({060'h????_????_????_???,                    4'b?100, 64'b0}): haddr=7'h42;
      ({060'h????_????_????_???,                    4'b1000, 64'b0}): haddr=7'h43;
      ({056'h????_????_????_??,                     4'b???1, 68'b0}): haddr=7'h44;
      ({056'h????_????_????_??,                     4'b??10, 68'b0}): haddr=7'h45;
      ({056'h????_????_????_??,                     4'b?100, 68'b0}): haddr=7'h46;
      ({056'h????_????_????_??,                     4'b1000, 68'b0}): haddr=7'h47;
      ({052'h????_????_????_?,                      4'b???1, 72'b0}): haddr=7'h48;
      ({052'h????_????_????_?,                      4'b??10, 72'b0}): haddr=7'h49;
      ({052'h????_????_????_?,                      4'b?100, 72'b0}): haddr=7'h4a;
      ({052'h????_????_????_?,                      4'b1000, 72'b0}): haddr=7'h4b;
      ({048'h????_????_????,                        4'b???1, 76'b0}): haddr=7'h4c;
      ({048'h????_????_????,                        4'b??10, 76'b0}): haddr=7'h4d;
      ({048'h????_????_????,                        4'b?100, 76'b0}): haddr=7'h4e;
      ({048'h????_????_????,                        4'b1000, 76'b0}): haddr=7'h4f;

//            1 1  1 1  1 1  1 
//            6 5  4 3  2 1  0 9  8 7  6 5  4 3  2 1
      ({044'h????_????_???,                         4'b???1, 80'b0}): haddr=7'h50;
      ({044'h????_????_???,                         4'b??10, 80'b0}): haddr=7'h51;
      ({044'h????_????_???,                         4'b?100, 80'b0}): haddr=7'h52;
      ({044'h????_????_???,                         4'b1000, 80'b0}): haddr=7'h53;
      ({040'h????_????_??,                          4'b???1, 84'b0}): haddr=7'h54;
      ({040'h????_????_??,                          4'b??10, 84'b0}): haddr=7'h55;
      ({040'h????_????_??,                          4'b?100, 84'b0}): haddr=7'h56;
      ({040'h????_????_??,                          4'b1000, 84'b0}): haddr=7'h57;
      ({036'h????_????_?,                           4'b???1, 88'b0}): haddr=7'h58;
      ({036'h????_????_?,                           4'b??10, 88'b0}): haddr=7'h59;
      ({036'h????_????_?,                           4'b?100, 88'b0}): haddr=7'h5a;
      ({036'h????_????_?,                           4'b1000, 88'b0}): haddr=7'h5b;
      ({032'h????_????,                             4'b???1, 92'b0}): haddr=7'h5c;
      ({032'h????_????,                             4'b??10, 92'b0}): haddr=7'h5d;
      ({032'h????_????,                             4'b?100, 92'b0}): haddr=7'h5e;
      ({032'h????_????,                             4'b1000, 92'b0}): haddr=7'h5f;

//            1 1  1 1  1 1  1 
//            6 5  4 3  2 1  0 9  8 7  6 5  4 3  2 1
      ({028'h????_???,                              4'b???1, 96'b0}): haddr=7'h60;
      ({028'h????_???,                              4'b??10, 96'b0}): haddr=7'h61;
      ({028'h????_???,                              4'b?100, 96'b0}): haddr=7'h62;
      ({028'h????_???,                              4'b1000, 96'b0}): haddr=7'h63;
      ({024'h????_??,                               4'b???1,100'b0}): haddr=7'h64;
      ({024'h????_??,                               4'b??10,100'b0}): haddr=7'h65;
      ({024'h????_??,                               4'b?100,100'b0}): haddr=7'h66;
      ({024'h????_??,                               4'b1000,100'b0}): haddr=7'h67;
      ({020'h????_?,                                4'b???1,104'b0}): haddr=7'h68;
      ({020'h????_?,                                4'b??10,104'b0}): haddr=7'h69;
      ({020'h????_?,                                4'b?100,104'b0}): haddr=7'h6a;
      ({020'h????_?,                                4'b1000,104'b0}): haddr=7'h6b;
      ({016'h????,                                  4'b???1,108'b0}): haddr=7'h6c;
      ({016'h????,                                  4'b??10,108'b0}): haddr=7'h6d;
      ({016'h????,                                  4'b?100,108'b0}): haddr=7'h6e;
      ({016'h????,                                  4'b1000,108'b0}): haddr=7'h6f;

//            1 1  1 1  1 1  1 
//            6 5  4 3  2 1  0 9  8 7  6 5  4 3  2 1
      ({012'h???,                                   4'b???1,112'b0}): haddr=7'h70;
      ({012'h???,                                   4'b??10,112'b0}): haddr=7'h71;
      ({012'h???,                                   4'b?100,112'b0}): haddr=7'h72;
      ({012'h???,                                   4'b1000,112'b0}): haddr=7'h73;
      ({008'h??,                                    4'b???1,116'b0}): haddr=7'h74;
      ({008'h??,                                    4'b??10,116'b0}): haddr=7'h75;
      ({008'h??,                                    4'b?100,116'b0}): haddr=7'h76;
      ({008'h??,                                    4'b1000,116'b0}): haddr=7'h77;
      ({004'h?,                                     4'b???1,120'b0}): haddr=7'h78;
      ({004'h?,                                     4'b??10,120'b0}): haddr=7'h79;
      ({004'h?,                                     4'b?100,120'b0}): haddr=7'h7a;
      ({004'h?,                                     4'b1000,120'b0}): haddr=7'h7b;
      ({                                            4'b???1,124'b0}): haddr=7'h7c;
      ({                                            4'b??10,124'b0}): haddr=7'h7d;
      ({                                            4'b?100,124'b0}): haddr=7'h7e;
      ({                                            4'b1000,124'b0}): haddr=7'h7f;

      default: haddr=7'd0; 
    endcase

// ------------------ registers -------------------------------
  always @(posedge cam_clk) begin
    if (reset) begin
      match_array_d <= 128'h0;
      cam_hit       <=   1'h0;
      cam_haddr     <=   7'h0;
    end
    else begin
      match_array_d <= match_array[127:0];
      cam_hit       <=    cmp_enc  && hit;
      cam_haddr     <= {7{cmp_enc}} & haddr[6:0];
    end
  end

endmodule
