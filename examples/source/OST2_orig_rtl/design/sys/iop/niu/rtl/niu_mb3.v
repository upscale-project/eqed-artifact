// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: niu_mb3.v
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

/////////////////////////////////////////////////////////////////////////////
//
//
//    Released:           1/16/05
//    Contacts:           carlos.castil@sun.com / shahryar.aryani@sun.com
//    Description:        Memory BIST Controller for Niagara2 NIU core
//    Block Type:         Control Block
//    Chip Name:          
//    Unit Name:         
//    Module:            
//    Where Instantiated: 
//
//
//  (c) 2005 Sun Microsystems, Inc.
//      Sun Proprietary/Confidential
//      Internal use only.
//
//  All rights reserved. No part of this design may be reproduced stored
//  in a retrieval system, or transmitted, in any form or by any means,
//  electronic, mechanical, photocopying, recording, or otherwise, without
//  prior written permission of Sun Microsystems, Inc.
//
///////////////////////////////////////////////////////////////////////////////


module niu_mb3 (
  niu_mb3_prebuf_header_rd_en, 
  niu_mb3_prebuf_header_wr_en, 
  niu_mb3_rx_data_fifo_rd_en, 
  niu_mb3_rx_data_fifo_wr_en, 
  niu_mb3_addr, 
  niu_mb3_wdata, 
  niu_mb3_run, 
  niu_tcu_mbist_fail_3, 
  niu_tcu_mbist_done_3, 
  mb3_scan_out, 
  mb3_dmo_dout, 
  l1clk, 
  rst, 
  tcu_mbist_user_mode, 
  mb3_scan_in, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_niu_mbist_start_3, 
  niu_mb3_prebuf_header_data_out, 
  niu_mb3_rx_data_fifo_data_out, 
  tcu_mbist_bisi_en);
wire siclk;
wire soclk;
wire reset;
wire config_reg_scanin;
wire config_reg_scanout;
wire [8:0] config_in;
wire [8:0] config_out;
wire start_transition;
wire reset_engine;
wire mbist_user_loop_mode;
wire mbist_done;
wire run;
wire bisi;
wire user_mode;
wire user_data_mode;
wire user_addr_mode;
wire user_loop_mode;
wire user_cmpsel_hold;
wire ten_n_mode;
wire mbist_user_data_mode;
wire mbist_user_addr_mode;
wire mbist_user_cmpsel_hold;
wire mbist_ten_n_mode;
wire user_data_reg_scanin;
wire user_data_reg_scanout;
wire [7:0] user_data_in;
wire [7:0] user_data_out;
wire user_start_addr_reg_scanin;
wire user_start_addr_reg_scanout;
wire [9:0] user_start_addr_in;
wire [9:0] user_start_addr;
wire user_stop_addr_reg_scanin;
wire user_stop_addr_reg_scanout;
wire [9:0] user_stop_addr_in;
wire [9:0] user_stop_addr;
wire user_incr_addr_reg_scanin;
wire user_incr_addr_reg_scanout;
wire [9:0] user_incr_addr_in;
wire [9:0] user_incr_addr;
wire user_array_sel_reg_scanin;
wire user_array_sel_reg_scanout;
wire user_array_sel_in;
wire user_array_sel;
wire user_cmpsel_reg_scanin;
wire user_cmpsel_reg_scanout;
wire [1:0] user_cmpsel_in;
wire [1:0] user_cmpsel;
wire user_bisi_wr_reg_scanin;
wire user_bisi_wr_reg_scanout;
wire user_bisi_wr_mode_in;
wire user_bisi_wr_mode;
wire user_bisi_rd_reg_scanin;
wire user_bisi_rd_reg_scanout;
wire user_bisi_rd_mode_in;
wire user_bisi_rd_mode;
wire mbist_user_bisi_wr_mode;
wire mbist_user_bisi_wr_rd_mode;
wire start_transition_reg_scanin;
wire start_transition_reg_scanout;
wire start_transition_piped;
wire run_reg_scanin;
wire run_reg_scanout;
wire run1_reg_scanin;
wire run1_reg_scanout;
wire run1_in;
wire run1_out;
wire run2_reg_scanin;
wire run2_reg_scanout;
wire run2_in;
wire run2_out;
wire run_piped3;
wire msb;
wire control_reg_scanin;
wire control_reg_scanout;
wire [24:0] control_in;
wire [24:0] control_out;
wire bisi_wr_rd;
wire array_sel;
wire [1:0] cmpsel;
wire [1:0] data_control;
wire address_mix;
wire [3:0] march_element;
wire [9:0] array_address;
wire upaddress_march;
wire [2:0] read_write_control;
wire five_cycle_march;
wire array_sel0;
wire one_cycle_march;
wire increment_addr;
wire [9:0] start_addr;
wire [9:0] next_array_address;
wire next_upaddr_march;
wire next_downaddr_march;
wire [9:0] stop_addr;
wire [10:0] overflow_addr;
wire array_sel1;
wire [9:0] incr_addr;
wire overflow;
wire [10:0] compare_addr;
wire [9:0] add;
wire [9:0] adj_address;
wire [9:0] mbist_address;
wire increment_march_elem;
wire next_array_sel;
wire [1:0] next_cmpsel;
wire [1:0] next_data_control;
wire next_address_mix;
wire [3:0] next_march_element;
wire array_write;
wire one_op_march;
wire array_read;
wire [7:0] mbist_wdata;
wire true_data;
wire [7:0] data_pattern;
wire [7:0] exp_read_data;
wire done_counter_reg_scanin;
wire done_counter_reg_scanout;
wire [2:0] done_counter_in;
wire [2:0] done_counter_out;
wire done_reg_in;
wire done_reg_out;
wire done_reg_scanin;
wire done_reg_scanout;
wire data_pipe_reg1_scanin;
wire data_pipe_reg1_scanout;
wire [7:0] data_pipe_reg1_in;
wire [7:0] data_pipe_out1;
wire data_pipe_reg2_scanin;
wire data_pipe_reg2_scanout;
wire [7:0] data_pipe_reg2_in;
wire [7:0] data_pipe_out2;
wire [7:0] old_piped_data;
wire cmpsel_reg1_scanin;
wire cmpsel_reg1_scanout;
wire [1:0] cmpsel_reg1_in;
wire [1:0] cmpsel_reg1_out1;
wire [1:0] cmpsel_pipe1;
wire ren_pipe_reg1_scanin;
wire ren_pipe_reg1_scanout;
wire ren_pipe_reg1_in;
wire ren_pipe_out1;
wire ren_pipe_reg2_scanin;
wire ren_pipe_reg2_scanout;
wire ren_pipe_reg2_in;
wire ren_pipe_out2;
wire old_piped_ren;
wire sel_pipe_reg1_scanin;
wire sel_pipe_reg1_scanout;
wire sel_pipe_reg1_in;
wire sel_pipe_out1;
wire sel_pipe_reg2_scanin;
wire sel_pipe_reg2_scanout;
wire sel_pipe_reg2_in;
wire sel_pipe_out2;
wire old_piped_sel2;
wire old_piped_sel1;
wire fail_out_reg_in;
wire fail;
wire fail_out_reg_out;
wire fail_out_reg_scanin;
wire fail_out_reg_scanout;
wire fail_reg_scanin;
wire fail_reg_scanout;
wire [1:0] fail_reg_in;
wire [1:0] fail_reg_out;
wire qual_old_fail1;
wire qual_old_fail0;
wire fail_detect;
wire qual_old_fail;
wire [145:0] read_data_mux1;
wire [39:0] read_data_mux2;
wire [39:0] read_data_reg_in;
wire [39:0] read_data_reg_out;
wire read_data_pipe_reg_scanin;
wire read_data_pipe_reg_scanout;





// /////////////////////////////////////////////////////////////////////////////
// Outputs
// /////////////////////////////////////////////////////////////////////////////

   output niu_mb3_prebuf_header_rd_en;
   output niu_mb3_prebuf_header_wr_en;

   output niu_mb3_rx_data_fifo_rd_en;
   output niu_mb3_rx_data_fifo_wr_en;

   output [9:0] niu_mb3_addr;
   output [7:0] niu_mb3_wdata;

   output niu_mb3_run;

   output niu_tcu_mbist_fail_3;
   output niu_tcu_mbist_done_3;

   output mb3_scan_out;

   output [39:0] mb3_dmo_dout;

// /////////////////////////////////////////////////////////////////////////////
// Inputs
// /////////////////////////////////////////////////////////////////////////////

   input              l1clk;
   input              rst;
   input              tcu_mbist_user_mode;

   input              mb3_scan_in;
   input              tcu_aclk;
   input              tcu_bclk;

   input              tcu_niu_mbist_start_3;

   input      [145:0] niu_mb3_prebuf_header_data_out;
   input      [145:0] niu_mb3_rx_data_fifo_data_out;

   input              tcu_mbist_bisi_en;


// /////////////////////////////////////////////////////////////////////////////
// Scan Renames
// /////////////////////////////////////////////////////////////////////////////

// assign se     = tcu_scan_en;
// assign pce_ov = tcu_pce_ov;
// assign stop   = tcu_clk_stop;

assign siclk  = tcu_aclk;
assign soclk  = tcu_bclk;

// /////////////////////////////////////////////////////////////////////////////
// Invert reset
// /////////////////////////////////////////////////////////////////////////////

assign reset = ~rst;

////////////////////////////////////////////////////////////////////////////////
// Clock header

// l1clkhdr_ctl_macro clkgen (
//      .l2clk  (iol2clk 			),
//      .l1en   (1'b1			),
//      .l1clk  (l1clk			)
// );
//assign siclk = 1'b0;
//assign soclk = 1'b0;


// /////////////////////////////////////////////////////////////////////////////
//
// MBIST Config Register
//
// /////////////////////////////////////////////////////////////////////////////
//
// A low to high transition on mbist_start will reset and start the engine.  
// mbist_start must remain active high for the duration of MBIST.  
// If mbist_start deasserts the engine will stop but not reset.
// Once MBIST has completed niu_tcu_mbist_done_3 will assert and the fail status
// signals will be valid.  
// To run MBIST again the mbist_start signal must transition low then high.
//
// Loop on Address will disable the address mix function.
//
// /////////////////////////////////////////////////////////////////////////////


  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_9 config_reg    (
		.scan_in(config_reg_scanin),
		.scan_out(config_reg_scanout),
		.din	 ( config_in[8:0]	),
		.dout	 ( config_out[8:0]	),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign config_in[0]		=	  tcu_niu_mbist_start_3;
  assign config_in[1]		=	  config_out[0];
  assign start_transition	=	  config_out[0]		&	~config_out[1];
  assign reset_engine		=	  start_transition   |	(mbist_user_loop_mode  &  mbist_done);
  assign run                    =         config_out[0] & config_out[1]; // 9/19/05 run to follow start only!

  assign config_in[2]		=	  start_transition   ?	 tcu_mbist_bisi_en:	 config_out[2];
  assign bisi			=	  config_out[2];

  assign config_in[3]		=	  start_transition   ?	tcu_mbist_user_mode : config_out[3];
  assign user_mode		=	  config_out[3];

  assign config_in[4]		=	  config_out[4];
  assign user_data_mode		=	  config_out[4];

  assign config_in[5]		=	  config_out[5];
  assign user_addr_mode		=	  config_out[5];

  assign config_in[6]		=	  config_out[6];
  assign user_loop_mode		=	  config_out[6];

  assign config_in[7]		=	  config_out[7];
  assign user_cmpsel_hold	=	  config_out[7];   //cmpsel_hold = 0 :	Default, All cominations
                                                           //		 = 1 :
                                                           //		User-specified cmpsel

  assign config_in[8]		=	  config_out[8];
  assign ten_n_mode		=	  config_out[8];

  assign mbist_user_data_mode =	  user_mode & user_data_mode;
  assign mbist_user_addr_mode =	  user_mode & user_addr_mode;
  assign mbist_user_loop_mode =	  user_mode & user_loop_mode;
  assign mbist_user_cmpsel_hold = user_mode & user_cmpsel_hold;
  assign mbist_ten_n_mode	=	  user_mode & ten_n_mode;


  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_8 user_data_reg    (
		 .scan_in(user_data_reg_scanin),
		 .scan_out(user_data_reg_scanout),
		 .din	   ( user_data_in[7:0]		),
                 .dout	   ( user_data_out[7:0]		),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign user_data_in[7:0]    =	   user_data_out[7:0];


// Defining User start, stop, and increment addresses.

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_10 user_start_addr_reg    (
			 .scan_in(user_start_addr_reg_scanin),
			 .scan_out(user_start_addr_reg_scanout),
			 .din	   ( user_start_addr_in[9:0]  ),
			 .dout	   ( user_start_addr[9:0] ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign user_start_addr_in[9:0]   =	user_start_addr[9:0];

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_10 user_stop_addr_reg    (
			 .scan_in(user_stop_addr_reg_scanin),
			 .scan_out(user_stop_addr_reg_scanout),
			 .din	   ( user_stop_addr_in[9:0]  ),
			 .dout	   ( user_stop_addr[9:0] ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign user_stop_addr_in[9:0]	  =    user_stop_addr[9:0];


  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_10 user_incr_addr_reg    (
			 .scan_in(user_incr_addr_reg_scanin),
			 .scan_out(user_incr_addr_reg_scanout),
			 .din	   ( user_incr_addr_in[9:0]  ),
			 .dout	   ( user_incr_addr[9:0] ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign user_incr_addr_in[9:0]	  =    user_incr_addr[9:0];

// Defining User array_sel.

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 user_array_sel_reg    (
			 .scan_in(user_array_sel_reg_scanin),
			 .scan_out(user_array_sel_reg_scanout),
			 .din	   ( user_array_sel_in	),
			 .dout	   ( user_array_sel ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign user_array_sel_in  =	 user_array_sel;

// Defining User cmpsel.

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_2 user_cmpsel_reg    (
			 .scan_in(user_cmpsel_reg_scanin),
			 .scan_out(user_cmpsel_reg_scanout),
			 .din	   ( user_cmpsel_in[1:0]  ),
			 .dout	   ( user_cmpsel[1:0] ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign user_cmpsel_in[1:0]   =    user_cmpsel[1:0];

// Defining user_bisi write and read registers

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 user_bisi_wr_reg    (
                 .scan_in(user_bisi_wr_reg_scanin),
                 .scan_out(user_bisi_wr_reg_scanout),
                 .din      ( user_bisi_wr_mode_in  ),
                 .dout     ( user_bisi_wr_mode ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign user_bisi_wr_mode_in     =    user_bisi_wr_mode;

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 user_bisi_rd_reg    (
                 .scan_in(user_bisi_rd_reg_scanin),
                 .scan_out(user_bisi_rd_reg_scanout),
                 .din      ( user_bisi_rd_mode_in  ),
                 .dout     ( user_bisi_rd_mode ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign user_bisi_rd_mode_in     =    user_bisi_rd_mode;

  assign mbist_user_bisi_wr_mode  =    user_mode & bisi & user_bisi_wr_mode & ~user_bisi_rd_mode;
//  assign mbist_user_bisi_rd_mode  =    user_mode & bisi & user_bisi_rd_mode & ~user_bisi_wr_mode;

  assign mbist_user_bisi_wr_rd_mode =   user_mode & bisi &
                                      ((user_bisi_wr_mode & user_bisi_rd_mode) |
                                       (~user_bisi_wr_mode & ~user_bisi_rd_mode));


////////////////////////////////////////////////////////////////////////////////
// Piping start_transition
////////////////////////////////////////////////////////////////////////////////

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 start_transition_reg   (
			.scan_in(start_transition_reg_scanin),
			.scan_out(start_transition_reg_scanout),
			.din	 ( start_transition ),
			.dout	 ( start_transition_piped ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));


////////////////////////////////////////////////////////////////////////////////
// Adding 2 extra pipeline stages to run to delay the start of mbist for 3 cycles.
////////////////////////////////////////////////////////////////////////////////

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 run_reg    (
			.scan_in(run_reg_scanin),
			.scan_out(run_reg_scanout),
			.din	 ( run ),
			.dout	 ( niu_mb3_run ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 run1_reg    (
			.scan_in(run1_reg_scanin),
			.scan_out(run1_reg_scanout),
			.din	 ( run1_in ),
			.dout	 ( run1_out ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign run1_in = reset_engine		?   1'b0:	niu_mb3_run;

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 run2_reg    (
			.scan_in(run2_reg_scanin),
			.scan_out(run2_reg_scanout),
			.din	 ( run2_in ),
			.dout	 ( run2_out ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign run2_in = reset_engine		?   1'b0:	run1_out;
  assign run_piped3 = config_out[0] & run2_out & ~msb;

// /////////////////////////////////////////////////////////////////////////////
//
// MBIST Control Register
//
// /////////////////////////////////////////////////////////////////////////////
// Remove Address mix disable before delivery
// /////////////////////////////////////////////////////////////////////////////

   niu_mb3_msff_ctl_macro__library_a1__reset_1__width_25 control_reg    ( 
                      .scan_in(control_reg_scanin),
                      .scan_out(control_reg_scanout),
                      .din   ( control_in[24:0]           ),
                      .dout  ( control_out[24:0]          ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign   msb                       =     control_out[24];
  assign   bisi_wr_rd                =     (bisi & ~user_mode) | mbist_user_bisi_wr_rd_mode ? control_out[23] : 1'b1;
  assign   array_sel                 =     user_mode              ?  user_array_sel   : control_out[22];
  assign   cmpsel[1:0]               =     mbist_user_cmpsel_hold ?  user_cmpsel[1:0] : control_out[21:20];
  assign   data_control[1:0]         =     control_out[19:18];
  assign   address_mix               =     (bisi | mbist_user_addr_mode) ?  1'b0 : control_out[17];
  assign   march_element[3:0]        =     control_out[16:13];

  assign   array_address[9:0]        =     array_sel &  upaddress_march   ? {4'b1111, control_out[8:3]} : 
                                           array_sel & (~upaddress_march) ? {4'b1111,~control_out[8:3]} :
                                         (~array_sel) &  upaddress_march  ? {control_out[12:3]} : ~control_out[12:3];

  assign   read_write_control[2:0]   =     ~five_cycle_march   ?   {2'b11,  control_out[0]} :
                                                                   control_out[2:0];


  assign   control_in[2:0]           =     reset_engine        ?   3'b0:
                                           ~run_piped3         ?   control_out[2:0]:
     (five_cycle_march && (read_write_control[2:0] == 3'b100)) ?   3'b000:
           (array_sel0 && (read_write_control[2:0] == 3'b110)) ?   3'b000:
      (one_cycle_march && (read_write_control[2:0] == 3'b110)) ?   3'b000:
                                                                   control_out[2:0]   +  3'b001;

  assign   increment_addr            =    array_sel0 ? (five_cycle_march && (read_write_control[2:0] == 3'b100)) ||
                                                                              (read_write_control[2:0] == 3'b110) :
                                                       (five_cycle_march && (read_write_control[2:0] == 3'b100)) || 
                                                        (one_cycle_march && (read_write_control[2:0] == 3'b110)) ||
                                                        (read_write_control[2:0] == 3'b111);

// start_transition_piped was added to have the correct start_addr at the start
// of mbist during user_addr_mode
  assign   control_in[12:3]  = start_transition_piped || reset_engine ?  start_addr[9:0]:
                                     ~run_piped3 || ~increment_addr   ?  control_out[12:3]:
                                                                   next_array_address[9:0];

  assign   next_array_address[9:0]  =    next_upaddr_march      ?  start_addr[9:0]:
                                          next_downaddr_march    ?  ~stop_addr[9:0]:
                                                                    (overflow_addr[9:0]);     // array_addr + incr_addr
                                                                    
  assign   start_addr[9:0]          =    mbist_user_addr_mode   ?   user_start_addr[9:0]: 10'b0000000000;
  assign   stop_addr[9:0]           =    mbist_user_addr_mode   ?   user_stop_addr[9:0] : 
                                          array_sel1            ?   10'b0000111111 : 10'b1111111111; 

  assign   incr_addr[9:0]            =    mbist_user_addr_mode   ?   user_incr_addr[9:0] : 10'b0000000001;

  assign   overflow_addr[10:0]       =    {1'b0,control_out[12:3]} + {1'b0,incr_addr[9:0]};
  assign   overflow                  =    compare_addr[10:0] < overflow_addr[10:0];

  assign   compare_addr[10:0]        =    upaddress_march       ?  {1'b0, stop_addr[9:0]} :
                                                                   {1'b0, ~start_addr[9:0]}; 

  assign   next_upaddr_march         =   ( (march_element[3:0] == 4'h0) || (march_element[3:0] == 4'h1) || 
                                           (march_element[3:0] == 4'h6) || (march_element[3:0] == 4'h5) || 
                                           (march_element[3:0] == 4'h8) ) && overflow; 
   
  assign   next_downaddr_march       =   ( (march_element[3:0] == 4'h2) || (march_element[3:0] == 4'h7) ||
                                           (march_element[3:0] == 4'h3) || (march_element[3:0] == 4'h4) ) && 
                                            overflow; 
   
  assign   add[9:0]                 =     five_cycle_march && ( (read_write_control[2:0] == 3'h1) || 
                                                                 (read_write_control[2:0] == 3'h3)) ?   
                                                                 adj_address[9:0] : array_address[9:0];

  assign   adj_address[9:0]         =    array_sel1 ? { array_address[9:6],  array_address[5:2], ~array_address[1], array_address[0] } :
                         (array_sel0 & address_mix) ? { array_address[9:1], ~array_address[0] } :
                                   { array_address[9:3], ~array_address[2], array_address[1:0]};


  assign   mbist_address[9:0] = (array_sel0 && address_mix) ?           {add[7:0], add[9:8]}: // Fast row array 0
				(array_sel1 && address_mix) ? {add[9:6],   add[0], add[5:1]}: // Fast row array 1
                                                                                   add[9:0];  // Fast column

// Definition of the rest of the control register  

 assign   increment_march_elem      =     increment_addr && overflow;

 assign   control_in[24:13]         =     reset_engine        ?   12'b0:
                                         ~run_piped3          ?   control_out[24:13]:
                                           {msb, bisi_wr_rd, next_array_sel, next_cmpsel[1:0], next_data_control[1:0], next_address_mix, next_march_element[3:0]} + 
                                           {11'b0, increment_march_elem};                        

  assign   next_address_mix          =    ( bisi | mbist_user_addr_mode) ?  1'b1 : address_mix;

  assign   next_array_sel            =     user_mode    ?   1'b1 : control_out[22];
  
  assign   next_cmpsel[1:0]          =     ( mbist_user_cmpsel_hold || (~bisi_wr_rd) || mbist_user_bisi_wr_mode ) ?   2'b11 : control_out[21:20];

  assign   next_data_control[1:0]    =     (bisi || (mbist_user_data_mode && (data_control[1:0] == 2'b00)))  ?   2'b11:
                                                                                                                 data_control[1:0];

// Incorporated ten_n_mode!  
  assign   next_march_element[3:0]   =     ( bisi || 
                                             (mbist_ten_n_mode && (march_element[3:0] == 4'b0101)) || 
                                          ((march_element[3:0] == 4'b1000) && (read_write_control[2:0] == 3'b100)) ) 
                                            && overflow ?   4'b1111:  march_element[3:0];


  assign   array_write               =     ~run_piped3         ?    1'b0:
                                           five_cycle_march    ?  (read_write_control[2:0] == 3'h0) || 
                                                                  (read_write_control[2:0] == 3'h1) ||
                                                                  (read_write_control[2:0] == 3'h4): 
	   (array_sel0) && (~five_cycle_march & ~one_op_march) ?  (read_write_control[0] == 1'b0) :
        (array_sel1) && (~five_cycle_march & ~one_cycle_march) ?  read_write_control[0]:
                    ( ((march_element[3:0] == 4'h0) & (~bisi || ~bisi_wr_rd || mbist_user_bisi_wr_mode)) || (march_element[3:0] == 4'h7));

  assign   array_read	             =	  array_sel0 & (~five_cycle_march & ~one_op_march) ? run_piped3 :
                                          array_sel0 ? (~array_write) && run_piped3                     :
                                         ~array_write && run_piped3;  

//  assign   array_read              =    ~array_write        &&  run_piped3;     //  &&  ~initialize;

  assign   mbist_wdata[7:0]          =     true_data           ?   data_pattern[7:0]:      ~data_pattern[7:0];

  assign   five_cycle_march          =    (march_element[3:0] == 4'h6)    ||  (march_element[3:0] == 4'h8);

  assign   one_cycle_march           =   array_sel1 && ( (march_element[3:0] == 4'h0) || (march_element[3:0] == 4'h5) || (march_element[3:0] == 4'h7));

  assign   one_op_march	             =	 array_sel0 && ( (march_element[3:0] == 4'h0) || (march_element[3:0] == 4'h5) || (march_element[3:0] == 4'h7));

  assign   upaddress_march           =    (march_element[3:0] == 4'h0)    ||  (march_element[3:0] == 4'h1) ||
                                          (march_element[3:0] == 4'h2)    ||  (march_element[3:0] == 4'h6) ||
                                          (march_element[3:0] == 4'h7);

  assign   true_data                 =     (five_cycle_march && (march_element[3:0] == 4'h6)) ? 
                                           ((read_write_control[2:0] == 3'h0) || (read_write_control[2:0] == 3'h2)):
                                           (five_cycle_march && (march_element[3:0] == 4'h8)) ? 
                                           ((read_write_control[2:0] == 3'h1) || 
                                            (read_write_control[2:0] == 3'h3) || (read_write_control[2:0] == 3'h4)):
	                                    one_op_march  ? (march_element[3:0] == 4'h7) :
	                                       array_sel0 ? (march_element[3:0] == 4'h1) || (march_element[3:0] == 4'h3):
                                          one_cycle_march ? (march_element[3:0] == 4'h7):
                                            ~(read_write_control[0] ^ march_element[0]);                                
                                                    
  
  assign   data_pattern[7:0]         =    (bisi & mbist_user_data_mode) ?   ~user_data_out[7:0]:
                                           mbist_user_data_mode         ?    user_data_out[7:0]:
                                           bisi                         ?    8'hFF:  // true_data function will invert to 8'h00
                                          (data_control[1:0] == 2'h0)   ?    8'hAA:
                                          (data_control[1:0] == 2'h1)   ?    8'h99:
                                          (data_control[1:0] == 2'h2)   ?    8'hCC:
                                                                             8'h00;

// /////////////////////////////////////////////////////////////////////////////
// Write data and address may need pipelining !!!
// /////////////////////////////////////////////////////////////////////////////

  assign   niu_mb3_wdata[7:0]	 =   mbist_wdata[7:0]; 
  assign   niu_mb3_addr[9:0]	 =   mbist_address[9:0];

  assign   exp_read_data[7:0]    =  (~five_cycle_march & ~one_op_march) ? ~mbist_wdata[7:0] : 
                                                                           mbist_wdata[7:0];

// /////////////////////////////////////////////////////////////////////////////
// Read and write selects 
// /////////////////////////////////////////////////////////////////////////////

   assign array_sel0  =  ~array_sel;
   assign array_sel1  =   array_sel;

   assign niu_mb3_rx_data_fifo_rd_en  =  (array_sel0 && array_read);
   assign niu_mb3_rx_data_fifo_wr_en  =  (array_sel0 && array_write);

   assign niu_mb3_prebuf_header_rd_en  = (array_sel1 && array_read);
   assign niu_mb3_prebuf_header_wr_en  = (array_sel1 && array_write);


/////////////////////////////////////////////////////////////////////////
// Creating the mbist_done signal
/////////////////////////////////////////////////////////////////////////
// Delaying mbist_done 8 clock signals after msb going high, to provide
// a generic solution for done going high after the last fail has come back!

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_3 done_counter_reg    (
                .scan_in(done_counter_reg_scanin),
                .scan_out(done_counter_reg_scanout),
                .din     ( done_counter_in[2:0]         ),
                .dout    ( done_counter_out[2:0]        ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

// config_out[1] is AND'ed to force mbist_done low 2 cycles after mbist_start
// goes low.

  assign mbist_done = (&done_counter_out[2:0] == 1'b1) & config_out[1];
  assign done_counter_in[2:0] = reset_engine       ?   3'b000:
                 msb & ~mbist_done & config_out[1] ?   done_counter_out[2:0] + 3'b001:
                                                       done_counter_out[2:0];

// /////////////////////////////////////////////////////////////////////////////
// Done Detection
// /////////////////////////////////////////////////////////////////////////////

  assign done_reg_in             =   mbist_done;
  assign niu_tcu_mbist_done_3    =   done_reg_out;

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 done_reg    (
                   .scan_in(done_reg_scanin),
                   .scan_out(done_reg_scanout),
                   .din         ( done_reg_in  ),
                   .dout        ( done_reg_out  ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

// /////////////////////////////////////////////////////////////////////////////
// Pipeline for wdata, and Read_en
// /////////////////////////////////////////////////////////////////////////////

// /////////////////////////////////////////////////////////////////////////////
// Pipeline for wdata
// /////////////////////////////////////////////////////////////////////////////

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_8  data_pipe_reg1   (
               .scan_in(data_pipe_reg1_scanin),
               .scan_out(data_pipe_reg1_scanout),
               .din        ( data_pipe_reg1_in[7:0]  ),
               .dout       ( data_pipe_out1[7:0]     ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_8  data_pipe_reg2   (
               .scan_in(data_pipe_reg2_scanin),
               .scan_out(data_pipe_reg2_scanout),
               .din        ( data_pipe_reg2_in[7:0]  ),
               .dout       ( data_pipe_out2[7:0]     ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

//Adding an extra level of pipe since piping the read_data
//msff_ctl_macro  data_pipe_reg3 (width=8, library=a1, reset=1)(
//             .scan_in(data_pipe_reg3_scanin),
//             .scan_out(data_pipe_reg3_scanout),
//             .din        ( data_pipe_reg3_in[7:0]  ),
//             .dout       ( data_pipe_out3[7:0]     ));

  assign data_pipe_reg1_in[7:0]   =  reset_engine    ?    8'h00: array_sel0 ? exp_read_data[7:0] : niu_mb3_wdata[7:0];
  assign data_pipe_reg2_in[7:0]   =  reset_engine    ?    8'h00:      data_pipe_out1[7:0];
//assign data_pipe_reg3_in[7:0]   =  reset_engine    ?    8'h00:      data_pipe_out2[7:0];
//assign old_piped_data[7:0]      =  data_pipe_out3[7:0];
  assign old_piped_data[7:0]      =  data_pipe_out2[7:0];

// /////////////////////////////////////////////////////////////////////////////
// Pipeline for comp sel
// /////////////////////////////////////////////////////////////////////////////

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_2  cmpsel_reg1   (
                .scan_in(cmpsel_reg1_scanin),
                .scan_out(cmpsel_reg1_scanout),
                .din       ( cmpsel_reg1_in[1:0]  ),
                .dout      ( cmpsel_reg1_out1[1:0] ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

 assign cmpsel_reg1_in[1:0] = cmpsel[1:0];

 assign cmpsel_pipe1[1:0] = cmpsel_reg1_out1[1:0];


// /////////////////////////////////////////////////////////////////////////////
// Pipeline for Read_en
// /////////////////////////////////////////////////////////////////////////////

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1  ren_pipe_reg1   (
               .scan_in(ren_pipe_reg1_scanin),
               .scan_out(ren_pipe_reg1_scanout),
               .din        ( ren_pipe_reg1_in  ),
               .dout       ( ren_pipe_out1     ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1  ren_pipe_reg2   (
               .scan_in(ren_pipe_reg2_scanin),
               .scan_out(ren_pipe_reg2_scanout),
               .din        ( ren_pipe_reg2_in  ),
               .dout       ( ren_pipe_out2     ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

//Adding an extra level of pipe since piping the read_data
//msff_ctl_macro  ren_pipe_reg3 (width=1, library=a1, reset=1)(
//             .scan_in(ren_pipe_reg3_scanin),
//             .scan_out(ren_pipe_reg3_scanout),
//             .din        ( ren_pipe_reg3_in  ),
//             .dout       ( ren_pipe_out3     ));

  assign ren_pipe_reg1_in   =  reset_engine    ?    1'b0:      array_read;
  assign ren_pipe_reg2_in   =  reset_engine    ?    1'b0:      ren_pipe_out1;
//assign ren_pipe_reg3_in   =  reset_engine    ?    1'b0:      ren_pipe_out2;
//assign old_piped_ren      =  ren_pipe_out3;
  assign old_piped_ren	    =  ren_pipe_out2;

// piped sel
 niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 sel_pipe_reg1    (
                 .scan_in(sel_pipe_reg1_scanin),
                 .scan_out(sel_pipe_reg1_scanout),
                 .din      ( sel_pipe_reg1_in     ),
                 .dout     ( sel_pipe_out1        ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

 niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 sel_pipe_reg2    (
                 .scan_in(sel_pipe_reg2_scanin),
                 .scan_out(sel_pipe_reg2_scanout),
                 .din      ( sel_pipe_reg2_in     ),
                 .dout     ( sel_pipe_out2        ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

 assign sel_pipe_reg1_in   =  reset_engine    ?    1'b0:   array_sel;
 assign sel_pipe_reg2_in   =  reset_engine    ?    1'b0:   sel_pipe_out1;
 assign old_piped_sel2     =  sel_pipe_out2;
 assign old_piped_sel1     =  sel_pipe_out1;

// ///////////////////////////////////////////////////////////////////////////// 
// Fail Detection
// /////////////////////////////////////////////////////////////////////////////

  assign fail_out_reg_in         =   fail;
  assign niu_tcu_mbist_fail_3    =   fail_out_reg_out;

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 fail_out_reg    (
                   .scan_in(fail_out_reg_scanin),
                   .scan_out(fail_out_reg_scanout),
                   .din         ( fail_out_reg_in  ),
                   .dout        ( fail_out_reg_out  ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

// /////////////////////////////////////////////////////////////////////////////
// Fail Detection
// /////////////////////////////////////////////////////////////////////////////

  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_2 fail_reg    (
                   .scan_in(fail_reg_scanin),
                   .scan_out(fail_reg_scanout),
                   .din      ( fail_reg_in  ),
                   .dout     ( fail_reg_out  ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

  assign    fail_reg_in[1:0]      =   reset_engine      ?    2'b00 :  {qual_old_fail1, qual_old_fail0} | fail_reg_out[1:0];

  assign    qual_old_fail0        =   fail_detect && !old_piped_sel2;
  assign    qual_old_fail1        =   fail_detect &&  old_piped_sel2;
  assign    qual_old_fail         =   qual_old_fail0 || qual_old_fail1;

  assign    fail_detect           =   ({old_piped_data[ 7 : 0 ],
                                        old_piped_data[ 7 : 0 ],
                                        old_piped_data[ 7 : 0 ],
                                        old_piped_data[ 7 : 0 ],
                                        old_piped_data[ 7 : 0 ]}) != mb3_dmo_dout[ 39 : 0 ] && old_piped_ren;

  assign    fail                  =   mbist_done ? |fail_reg_out[1:0] : qual_old_fail;

// Pipelining the read_data to meet the timing requirement
// Check if need to reset??

  assign  read_data_mux1[ 145 : 0 ] = old_piped_sel1 ? niu_mb3_prebuf_header_data_out[ 145 : 0 ] :
                                                       niu_mb3_rx_data_fifo_data_out[ 145 : 0 ];

  assign  read_data_mux2[ 39 : 0 ] = (cmpsel_pipe1[ 1 : 0 ] == 2'b00) ? read_data_mux1[ 39 : 0 ] :
                                 (cmpsel_pipe1[ 1 : 0 ] == 2'b01) ? read_data_mux1[ 79 : 40 ] :
                                 (cmpsel_pipe1[ 1 : 0 ] == 2'b10) ? read_data_mux1[ 119 : 80 ] :
                                 {data_pipe_out1[7:0], data_pipe_out1[7:2], read_data_mux1[ 145 : 120 ]} ;

  assign  read_data_reg_in[ 39 : 0 ] = read_data_mux2[ 39 : 0 ];
  assign  mb3_dmo_dout[ 39 : 0 ]     = read_data_reg_out[ 39 : 0 ];


  niu_mb3_msff_ctl_macro__library_a1__reset_1__width_40 read_data_pipe_reg    (
                   .scan_in(read_data_pipe_reg_scanin),
                   .scan_out(read_data_pipe_reg_scanout),
                   .din      ( read_data_reg_in[ 39 : 0 ] ),
                   .dout     ( read_data_reg_out[ 39 : 0 ]  ),
  .reset(reset),
  .l1clk(l1clk),
  .siclk(siclk),
  .soclk(soclk));

supply0 vss; // <- port for ground
supply1 vdd; // <- port for power 
// /////////////////////////////////////////////////////////////////////////////
// fixscan start:
assign config_reg_scanin         = mb3_scan_in                  ;
assign user_data_reg_scanin      = config_reg_scanout       ;
assign user_start_addr_reg_scanin = user_data_reg_scanout    ;
assign user_stop_addr_reg_scanin = user_start_addr_reg_scanout;
assign user_incr_addr_reg_scanin = user_stop_addr_reg_scanout;
assign user_array_sel_reg_scanin = user_incr_addr_reg_scanout;
assign user_cmpsel_reg_scanin    = user_array_sel_reg_scanout;
assign user_bisi_wr_reg_scanin   = user_cmpsel_reg_scanout  ;
assign user_bisi_rd_reg_scanin   = user_bisi_wr_reg_scanout ;
assign start_transition_reg_scanin = user_bisi_rd_reg_scanout ;
assign run_reg_scanin            = start_transition_reg_scanout;
assign run1_reg_scanin           = run_reg_scanout          ;
assign run2_reg_scanin           = run1_reg_scanout         ;
assign control_reg_scanin        = run2_reg_scanout         ;
assign done_counter_reg_scanin   = control_reg_scanout      ;
assign done_reg_scanin           = done_counter_reg_scanout ;
assign data_pipe_reg1_scanin     = done_reg_scanout         ;
assign data_pipe_reg2_scanin     = data_pipe_reg1_scanout   ;
assign cmpsel_reg1_scanin        = data_pipe_reg2_scanout   ;
assign ren_pipe_reg1_scanin      = cmpsel_reg1_scanout      ;
assign ren_pipe_reg2_scanin      = ren_pipe_reg1_scanout    ;
assign sel_pipe_reg1_scanin      = ren_pipe_reg2_scanout    ;
assign sel_pipe_reg2_scanin      = sel_pipe_reg1_scanout    ;
assign fail_out_reg_scanin       = sel_pipe_reg2_scanout    ;
assign fail_reg_scanin           = fail_out_reg_scanout     ;
assign read_data_pipe_reg_scanin = fail_reg_scanout         ;
assign mb3_scan_out                  = read_data_pipe_reg_scanout;
// fixscan end:
endmodule
// /////////////////////////////////////////////////////////////////////////////






// any PARAMS parms go into naming of macro

module niu_mb3_msff_ctl_macro__library_a1__reset_1__width_9 (
  din, 
  reset, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [8:0] fdin;
wire [8:1] sout;

  input [8:0] din;
  input reset;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [8:0] dout;
  output scan_out;
assign fdin[8:0] = din[8:0] & {9 {reset}};









    







cl_a1_msff_syrst_4x d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0]),
.si(sout[1]),
.so(scan_out),
.reset(reset),
.q(dout[0])
);
cl_a1_msff_syrst_4x d0_1 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1]),
.si(sout[2]),
.so(sout[1]),
.reset(reset),
.q(dout[1])
);
cl_a1_msff_syrst_4x d0_2 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[2]),
.si(sout[3]),
.so(sout[2]),
.reset(reset),
.q(dout[2])
);
cl_a1_msff_syrst_4x d0_3 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3]),
.si(sout[4]),
.so(sout[3]),
.reset(reset),
.q(dout[3])
);
cl_a1_msff_syrst_4x d0_4 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[4]),
.si(sout[5]),
.so(sout[4]),
.reset(reset),
.q(dout[4])
);
cl_a1_msff_syrst_4x d0_5 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[5]),
.si(sout[6]),
.so(sout[5]),
.reset(reset),
.q(dout[5])
);
cl_a1_msff_syrst_4x d0_6 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[6]),
.si(sout[7]),
.so(sout[6]),
.reset(reset),
.q(dout[6])
);
cl_a1_msff_syrst_4x d0_7 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[7]),
.si(sout[8]),
.so(sout[7]),
.reset(reset),
.q(dout[7])
);
cl_a1_msff_syrst_4x d0_8 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[8]),
.si(scan_in),
.so(sout[8]),
.reset(reset),
.q(dout[8])
);




endmodule













// any PARAMS parms go into naming of macro

module niu_mb3_msff_ctl_macro__library_a1__reset_1__width_8 (
  din, 
  reset, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [7:0] fdin;
wire [7:1] sout;

  input [7:0] din;
  input reset;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [7:0] dout;
  output scan_out;
assign fdin[7:0] = din[7:0] & {8 {reset}};









    







cl_a1_msff_syrst_4x d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0]),
.si(sout[1]),
.so(scan_out),
.reset(reset),
.q(dout[0])
);
cl_a1_msff_syrst_4x d0_1 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1]),
.si(sout[2]),
.so(sout[1]),
.reset(reset),
.q(dout[1])
);
cl_a1_msff_syrst_4x d0_2 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[2]),
.si(sout[3]),
.so(sout[2]),
.reset(reset),
.q(dout[2])
);
cl_a1_msff_syrst_4x d0_3 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3]),
.si(sout[4]),
.so(sout[3]),
.reset(reset),
.q(dout[3])
);
cl_a1_msff_syrst_4x d0_4 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[4]),
.si(sout[5]),
.so(sout[4]),
.reset(reset),
.q(dout[4])
);
cl_a1_msff_syrst_4x d0_5 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[5]),
.si(sout[6]),
.so(sout[5]),
.reset(reset),
.q(dout[5])
);
cl_a1_msff_syrst_4x d0_6 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[6]),
.si(sout[7]),
.so(sout[6]),
.reset(reset),
.q(dout[6])
);
cl_a1_msff_syrst_4x d0_7 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[7]),
.si(scan_in),
.so(sout[7]),
.reset(reset),
.q(dout[7])
);




endmodule













// any PARAMS parms go into naming of macro

module niu_mb3_msff_ctl_macro__library_a1__reset_1__width_10 (
  din, 
  reset, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [9:0] fdin;
wire [9:1] sout;

  input [9:0] din;
  input reset;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [9:0] dout;
  output scan_out;
assign fdin[9:0] = din[9:0] & {10 {reset}};









    







cl_a1_msff_syrst_4x d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0]),
.si(sout[1]),
.so(scan_out),
.reset(reset),
.q(dout[0])
);
cl_a1_msff_syrst_4x d0_1 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1]),
.si(sout[2]),
.so(sout[1]),
.reset(reset),
.q(dout[1])
);
cl_a1_msff_syrst_4x d0_2 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[2]),
.si(sout[3]),
.so(sout[2]),
.reset(reset),
.q(dout[2])
);
cl_a1_msff_syrst_4x d0_3 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3]),
.si(sout[4]),
.so(sout[3]),
.reset(reset),
.q(dout[3])
);
cl_a1_msff_syrst_4x d0_4 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[4]),
.si(sout[5]),
.so(sout[4]),
.reset(reset),
.q(dout[4])
);
cl_a1_msff_syrst_4x d0_5 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[5]),
.si(sout[6]),
.so(sout[5]),
.reset(reset),
.q(dout[5])
);
cl_a1_msff_syrst_4x d0_6 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[6]),
.si(sout[7]),
.so(sout[6]),
.reset(reset),
.q(dout[6])
);
cl_a1_msff_syrst_4x d0_7 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[7]),
.si(sout[8]),
.so(sout[7]),
.reset(reset),
.q(dout[7])
);
cl_a1_msff_syrst_4x d0_8 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[8]),
.si(sout[9]),
.so(sout[8]),
.reset(reset),
.q(dout[8])
);
cl_a1_msff_syrst_4x d0_9 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[9]),
.si(scan_in),
.so(sout[9]),
.reset(reset),
.q(dout[9])
);




endmodule













// any PARAMS parms go into naming of macro

module niu_mb3_msff_ctl_macro__library_a1__reset_1__width_1 (
  din, 
  reset, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [0:0] fdin;

  input [0:0] din;
  input reset;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [0:0] dout;
  output scan_out;
assign fdin[0:0] = din[0:0] & {1 {reset}};









    







cl_a1_msff_syrst_4x d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0]),
.si(scan_in),
.so(scan_out),
.reset(reset),
.q(dout[0])
);




endmodule













// any PARAMS parms go into naming of macro

module niu_mb3_msff_ctl_macro__library_a1__reset_1__width_2 (
  din, 
  reset, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [1:0] fdin;
wire [1:1] sout;

  input [1:0] din;
  input reset;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [1:0] dout;
  output scan_out;
assign fdin[1:0] = din[1:0] & {2 {reset}};









    







cl_a1_msff_syrst_4x d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0]),
.si(sout[1]),
.so(scan_out),
.reset(reset),
.q(dout[0])
);
cl_a1_msff_syrst_4x d0_1 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1]),
.si(scan_in),
.so(sout[1]),
.reset(reset),
.q(dout[1])
);




endmodule













// any PARAMS parms go into naming of macro

module niu_mb3_msff_ctl_macro__library_a1__reset_1__width_25 (
  din, 
  reset, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [24:0] fdin;
wire [24:1] sout;

  input [24:0] din;
  input reset;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [24:0] dout;
  output scan_out;
assign fdin[24:0] = din[24:0] & {25 {reset}};









    







cl_a1_msff_syrst_4x d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0]),
.si(sout[1]),
.so(scan_out),
.reset(reset),
.q(dout[0])
);
cl_a1_msff_syrst_4x d0_1 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1]),
.si(sout[2]),
.so(sout[1]),
.reset(reset),
.q(dout[1])
);
cl_a1_msff_syrst_4x d0_2 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[2]),
.si(sout[3]),
.so(sout[2]),
.reset(reset),
.q(dout[2])
);
cl_a1_msff_syrst_4x d0_3 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3]),
.si(sout[4]),
.so(sout[3]),
.reset(reset),
.q(dout[3])
);
cl_a1_msff_syrst_4x d0_4 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[4]),
.si(sout[5]),
.so(sout[4]),
.reset(reset),
.q(dout[4])
);
cl_a1_msff_syrst_4x d0_5 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[5]),
.si(sout[6]),
.so(sout[5]),
.reset(reset),
.q(dout[5])
);
cl_a1_msff_syrst_4x d0_6 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[6]),
.si(sout[7]),
.so(sout[6]),
.reset(reset),
.q(dout[6])
);
cl_a1_msff_syrst_4x d0_7 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[7]),
.si(sout[8]),
.so(sout[7]),
.reset(reset),
.q(dout[7])
);
cl_a1_msff_syrst_4x d0_8 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[8]),
.si(sout[9]),
.so(sout[8]),
.reset(reset),
.q(dout[8])
);
cl_a1_msff_syrst_4x d0_9 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[9]),
.si(sout[10]),
.so(sout[9]),
.reset(reset),
.q(dout[9])
);
cl_a1_msff_syrst_4x d0_10 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[10]),
.si(sout[11]),
.so(sout[10]),
.reset(reset),
.q(dout[10])
);
cl_a1_msff_syrst_4x d0_11 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[11]),
.si(sout[12]),
.so(sout[11]),
.reset(reset),
.q(dout[11])
);
cl_a1_msff_syrst_4x d0_12 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[12]),
.si(sout[13]),
.so(sout[12]),
.reset(reset),
.q(dout[12])
);
cl_a1_msff_syrst_4x d0_13 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[13]),
.si(sout[14]),
.so(sout[13]),
.reset(reset),
.q(dout[13])
);
cl_a1_msff_syrst_4x d0_14 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[14]),
.si(sout[15]),
.so(sout[14]),
.reset(reset),
.q(dout[14])
);
cl_a1_msff_syrst_4x d0_15 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[15]),
.si(sout[16]),
.so(sout[15]),
.reset(reset),
.q(dout[15])
);
cl_a1_msff_syrst_4x d0_16 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[16]),
.si(sout[17]),
.so(sout[16]),
.reset(reset),
.q(dout[16])
);
cl_a1_msff_syrst_4x d0_17 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[17]),
.si(sout[18]),
.so(sout[17]),
.reset(reset),
.q(dout[17])
);
cl_a1_msff_syrst_4x d0_18 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[18]),
.si(sout[19]),
.so(sout[18]),
.reset(reset),
.q(dout[18])
);
cl_a1_msff_syrst_4x d0_19 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[19]),
.si(sout[20]),
.so(sout[19]),
.reset(reset),
.q(dout[19])
);
cl_a1_msff_syrst_4x d0_20 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[20]),
.si(sout[21]),
.so(sout[20]),
.reset(reset),
.q(dout[20])
);
cl_a1_msff_syrst_4x d0_21 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[21]),
.si(sout[22]),
.so(sout[21]),
.reset(reset),
.q(dout[21])
);
cl_a1_msff_syrst_4x d0_22 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[22]),
.si(sout[23]),
.so(sout[22]),
.reset(reset),
.q(dout[22])
);
cl_a1_msff_syrst_4x d0_23 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[23]),
.si(sout[24]),
.so(sout[23]),
.reset(reset),
.q(dout[23])
);
cl_a1_msff_syrst_4x d0_24 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[24]),
.si(scan_in),
.so(sout[24]),
.reset(reset),
.q(dout[24])
);




endmodule













// any PARAMS parms go into naming of macro

module niu_mb3_msff_ctl_macro__library_a1__reset_1__width_3 (
  din, 
  reset, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [2:0] fdin;
wire [2:1] sout;

  input [2:0] din;
  input reset;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [2:0] dout;
  output scan_out;
assign fdin[2:0] = din[2:0] & {3 {reset}};









    







cl_a1_msff_syrst_4x d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0]),
.si(sout[1]),
.so(scan_out),
.reset(reset),
.q(dout[0])
);
cl_a1_msff_syrst_4x d0_1 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1]),
.si(sout[2]),
.so(sout[1]),
.reset(reset),
.q(dout[1])
);
cl_a1_msff_syrst_4x d0_2 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[2]),
.si(scan_in),
.so(sout[2]),
.reset(reset),
.q(dout[2])
);




endmodule













// any PARAMS parms go into naming of macro

module niu_mb3_msff_ctl_macro__library_a1__reset_1__width_40 (
  din, 
  reset, 
  l1clk, 
  scan_in, 
  siclk, 
  soclk, 
  dout, 
  scan_out);
wire [39:0] fdin;
wire [39:1] sout;

  input [39:0] din;
  input reset;
  input l1clk;
  input scan_in;


  input siclk;
  input soclk;

  output [39:0] dout;
  output scan_out;
assign fdin[39:0] = din[39:0] & {40 {reset}};









    







cl_a1_msff_syrst_4x d0_0 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[0]),
.si(sout[1]),
.so(scan_out),
.reset(reset),
.q(dout[0])
);
cl_a1_msff_syrst_4x d0_1 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[1]),
.si(sout[2]),
.so(sout[1]),
.reset(reset),
.q(dout[1])
);
cl_a1_msff_syrst_4x d0_2 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[2]),
.si(sout[3]),
.so(sout[2]),
.reset(reset),
.q(dout[2])
);
cl_a1_msff_syrst_4x d0_3 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[3]),
.si(sout[4]),
.so(sout[3]),
.reset(reset),
.q(dout[3])
);
cl_a1_msff_syrst_4x d0_4 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[4]),
.si(sout[5]),
.so(sout[4]),
.reset(reset),
.q(dout[4])
);
cl_a1_msff_syrst_4x d0_5 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[5]),
.si(sout[6]),
.so(sout[5]),
.reset(reset),
.q(dout[5])
);
cl_a1_msff_syrst_4x d0_6 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[6]),
.si(sout[7]),
.so(sout[6]),
.reset(reset),
.q(dout[6])
);
cl_a1_msff_syrst_4x d0_7 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[7]),
.si(sout[8]),
.so(sout[7]),
.reset(reset),
.q(dout[7])
);
cl_a1_msff_syrst_4x d0_8 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[8]),
.si(sout[9]),
.so(sout[8]),
.reset(reset),
.q(dout[8])
);
cl_a1_msff_syrst_4x d0_9 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[9]),
.si(sout[10]),
.so(sout[9]),
.reset(reset),
.q(dout[9])
);
cl_a1_msff_syrst_4x d0_10 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[10]),
.si(sout[11]),
.so(sout[10]),
.reset(reset),
.q(dout[10])
);
cl_a1_msff_syrst_4x d0_11 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[11]),
.si(sout[12]),
.so(sout[11]),
.reset(reset),
.q(dout[11])
);
cl_a1_msff_syrst_4x d0_12 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[12]),
.si(sout[13]),
.so(sout[12]),
.reset(reset),
.q(dout[12])
);
cl_a1_msff_syrst_4x d0_13 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[13]),
.si(sout[14]),
.so(sout[13]),
.reset(reset),
.q(dout[13])
);
cl_a1_msff_syrst_4x d0_14 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[14]),
.si(sout[15]),
.so(sout[14]),
.reset(reset),
.q(dout[14])
);
cl_a1_msff_syrst_4x d0_15 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[15]),
.si(sout[16]),
.so(sout[15]),
.reset(reset),
.q(dout[15])
);
cl_a1_msff_syrst_4x d0_16 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[16]),
.si(sout[17]),
.so(sout[16]),
.reset(reset),
.q(dout[16])
);
cl_a1_msff_syrst_4x d0_17 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[17]),
.si(sout[18]),
.so(sout[17]),
.reset(reset),
.q(dout[17])
);
cl_a1_msff_syrst_4x d0_18 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[18]),
.si(sout[19]),
.so(sout[18]),
.reset(reset),
.q(dout[18])
);
cl_a1_msff_syrst_4x d0_19 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[19]),
.si(sout[20]),
.so(sout[19]),
.reset(reset),
.q(dout[19])
);
cl_a1_msff_syrst_4x d0_20 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[20]),
.si(sout[21]),
.so(sout[20]),
.reset(reset),
.q(dout[20])
);
cl_a1_msff_syrst_4x d0_21 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[21]),
.si(sout[22]),
.so(sout[21]),
.reset(reset),
.q(dout[21])
);
cl_a1_msff_syrst_4x d0_22 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[22]),
.si(sout[23]),
.so(sout[22]),
.reset(reset),
.q(dout[22])
);
cl_a1_msff_syrst_4x d0_23 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[23]),
.si(sout[24]),
.so(sout[23]),
.reset(reset),
.q(dout[23])
);
cl_a1_msff_syrst_4x d0_24 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[24]),
.si(sout[25]),
.so(sout[24]),
.reset(reset),
.q(dout[24])
);
cl_a1_msff_syrst_4x d0_25 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[25]),
.si(sout[26]),
.so(sout[25]),
.reset(reset),
.q(dout[25])
);
cl_a1_msff_syrst_4x d0_26 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[26]),
.si(sout[27]),
.so(sout[26]),
.reset(reset),
.q(dout[26])
);
cl_a1_msff_syrst_4x d0_27 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[27]),
.si(sout[28]),
.so(sout[27]),
.reset(reset),
.q(dout[27])
);
cl_a1_msff_syrst_4x d0_28 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[28]),
.si(sout[29]),
.so(sout[28]),
.reset(reset),
.q(dout[28])
);
cl_a1_msff_syrst_4x d0_29 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[29]),
.si(sout[30]),
.so(sout[29]),
.reset(reset),
.q(dout[29])
);
cl_a1_msff_syrst_4x d0_30 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[30]),
.si(sout[31]),
.so(sout[30]),
.reset(reset),
.q(dout[30])
);
cl_a1_msff_syrst_4x d0_31 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[31]),
.si(sout[32]),
.so(sout[31]),
.reset(reset),
.q(dout[31])
);
cl_a1_msff_syrst_4x d0_32 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[32]),
.si(sout[33]),
.so(sout[32]),
.reset(reset),
.q(dout[32])
);
cl_a1_msff_syrst_4x d0_33 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[33]),
.si(sout[34]),
.so(sout[33]),
.reset(reset),
.q(dout[33])
);
cl_a1_msff_syrst_4x d0_34 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[34]),
.si(sout[35]),
.so(sout[34]),
.reset(reset),
.q(dout[34])
);
cl_a1_msff_syrst_4x d0_35 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[35]),
.si(sout[36]),
.so(sout[35]),
.reset(reset),
.q(dout[35])
);
cl_a1_msff_syrst_4x d0_36 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[36]),
.si(sout[37]),
.so(sout[36]),
.reset(reset),
.q(dout[36])
);
cl_a1_msff_syrst_4x d0_37 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[37]),
.si(sout[38]),
.so(sout[37]),
.reset(reset),
.q(dout[37])
);
cl_a1_msff_syrst_4x d0_38 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[38]),
.si(sout[39]),
.so(sout[38]),
.reset(reset),
.q(dout[38])
);
cl_a1_msff_syrst_4x d0_39 (
.l1clk(l1clk),
.siclk(siclk),
.soclk(soclk),
.d(fdin[39]),
.si(scan_in),
.so(sout[39]),
.reset(reset),
.q(dout[39])
);




endmodule








