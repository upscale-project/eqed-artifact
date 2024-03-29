// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: dmu_cmu_clst_aloc.v
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
module dmu_cmu_clst_aloc (
		clk, 	
		rst_l,
        enq,
		data_in,
        deq, 
		data_out,
		full,
        empty,
        overflow,
        underflow 
     );
     
//************************************************
//				PARAMETERS
//************************************************
   parameter WIDTH = 5;     // max width supported
   parameter DEPTH = 16;    // max depth supported

  integer 	 i;
   
//************************************************
//				PORTS
//************************************************

  input clk;                        // The input clock
  input rst_l;                      // synopsys sync_set_reset "rst_l"

  input enq;                        // enqueue into fifo
  input [WIDTH - 1:0] data_in;      // data to put in

  input deq;                        // dequeue outof fifo
  output [WIDTH - 1:0] data_out;    // data taken out

  output full;                      // full flag
  output empty;                     // empty flag 
  output overflow;                  // overflow indicater
  output underflow;                 // underflow indicater

//************************************************
//				SIGNALS
//************************************************
 
  reg [WIDTH - 1:0] sr [0 :DEPTH -1];      // fifo flops
  reg [DEPTH :0] ld;                    // current load location
  reg [DEPTH :0] next_ld;               // next load location

  reg [DEPTH - 1:0] vld;                   // current location has valid data
  reg [DEPTH - 1:0] next_vld;              // next location to have valid data
   
  reg empty;                               // fifo is empty
  reg overflow;                            // enqueue when fifo was full
  reg underflow;                           // dequeue when fifo was empty

// uncomment to add a contents counter
//  reg [COUNT_WIDTH:0] count;	  	      // # valid contents in fifo   

//  uncoment these line for debug
//  wire [WIDTH -1:0] sr_out_7, sr_out_6, sr_out_5, sr_out_4,
//                    sr_out_3, sr_out_2, sr_out_1, sr_out_0;
//  
//  assign sr_out_0 = sr[DEPTH - 8];
//  assign sr_out_1 = sr[DEPTH - 7];
//  assign sr_out_2 = sr[DEPTH - 6];
//  assign sr_out_3 = sr[DEPTH - 5];
//  assign sr_out_4 = sr[DEPTH - 4];
//  assign sr_out_5 = sr[DEPTH - 3];
//  assign sr_out_6 = sr[DEPTH - 2];
//  assign sr_out_7 = sr[DEPTH - 1];


   wire [DEPTH -1 :0] vld_init;                // to make vlint happy
   		  
   wire [WIDTH -1 :0] initf  =  5'h0f;  
   wire [WIDTH -1 :0] inite  =  5'h0e;  
   wire [WIDTH -1 :0] initd  =  5'h0d;  
   wire [WIDTH -1 :0] initc  =  5'h0c;  
   wire [WIDTH -1 :0] initb  =  5'h0b;  
   wire [WIDTH -1 :0] inita  =  5'h0a;  
   wire [WIDTH -1 :0] init9  =  5'h09;  
   wire [WIDTH -1 :0] init8  =  5'h08;
		  
   wire [WIDTH -1 :0] init7  =  5'h07;  
   wire [WIDTH -1 :0] init6  =  5'h06;  
   wire [WIDTH -1 :0] init5  =  5'h05;  
   wire [WIDTH -1 :0] init4  =  5'h04;  
   wire [WIDTH -1 :0] init3  =  5'h03;  
   wire [WIDTH -1 :0] init2  =  5'h02;  
   wire [WIDTH -1 :0] init1  =  5'h01;  
   wire [WIDTH -1 :0] init0  =  5'h00;
							 
   assign vld_init[DEPTH -1 :0] = vld[DEPTH -1 :0] << 1; // make vlint happy

//************************************************
// mux function just to make the code easier for 
// synthesis (like we really want a 2:1 mux)
//************************************************

function [WIDTH -1:0] reg_mux;
 input sel;
 input [WIDTH -1:0] nxdata;
 input [WIDTH -1:0] nxsrdata;

 begin
   reg_mux = sel ? nxdata : nxsrdata;
 end
endfunction


//************************************************
// the fifo location always gets the value on 
// next_ld. mux logic to make the code parameterized and
// easier for synthesis
//************************************************


always @ (posedge clk)       // make vlint happy
  begin
	 if (!rst_l)  begin
         sr[15] <=  initf;
         sr[14] <=  inite;
         sr[13] <=  initd;
         sr[12] <=  initc;
         sr[11] <=  initb;
         sr[10] <=  inita;
         sr[9]  <=  init9;
         sr[8]  <=  init8;
         sr[7]  <=  init7;
         sr[6]  <=  init6;
         sr[5]  <=  init5;
         sr[4]  <=  init4;
         sr[3]  <=  init3;
         sr[2]  <=  init2;
         sr[1]  <=  init1;
         sr[0]  <=  init0;
	 end
	 else begin
		for (i = 0; i < DEPTH -1 ; i = i+1)
		  case ({enq, deq}) 	// synopsys parallel_case
			2'b00: sr[i] <= sr[i];
			2'b01: sr[i] <= sr[i+1];
			2'b10: sr[i] <= reg_mux(next_ld[i+1], data_in, sr[i]);
			2'b11: sr[i] <= reg_mux(next_ld[i+1], data_in, sr[i+1]);
			default: sr[i] <= sr[i];
		  endcase // case({enq, deq})
		for (i = DEPTH -1; i < DEPTH ; i = i+1)
		  case ({enq, deq}) 	// synopsys parallel_case
			2'b00: sr[i] <= sr[i];
			2'b01: sr[i] <= data_in;
			2'b10: sr[i] <= reg_mux(next_ld[i+1], data_in, sr[i]);
			2'b11: sr[i] <= reg_mux(next_ld[i+1], data_in, sr[i]);
			default: sr[i] <= sr[i];			
			endcase // case({enq, deq})
		end // else: !if(!rst_l)
	 end // always @ (posedge clk)

//*********************************************
// fifo load control updates when enq or deq
// valid
//*********************************************

always @ (rst_l or ld or enq or deq)
begin
  if (!rst_l) begin
     next_ld  = {1'b1,{(DEPTH){1'b0}}};	 // to make vlint happy
  end
  else begin 
   case ({enq, deq}) 	// synopsys parallel_case
    2'b00: next_ld = ld;
    2'b01: next_ld = ld >> 1;
    2'b10: next_ld = ld << 1;
    2'b11: next_ld = ld;
	default:  next_ld = ld;
   endcase // case({enq, deq})
  end // else: !if(!rst_l)
end // always @ (posedge clk)   

//*********************************************
// fifo valid contents marker updates when enq 
// or deq  valid
//*********************************************

always @ (rst_l or vld or enq or deq or vld_init)
begin
  if (!rst_l) begin
       next_vld = {DEPTH {1'b1}};
    end
 else begin 
  case ({enq, deq}) 	// synopsys parallel_case
   2'b00: next_vld = vld;
   2'b01: next_vld = vld >> 1;
   2'b10: next_vld = {vld_init[DEPTH -1 :1] , 1'b1}; // to make vlint happy
   2'b11: next_vld = vld;
   default : next_vld = vld;
  endcase // case({enq, deq})
 end // else: !if(!rst_l)
end // always @ (vld or enq or deq or vld_init)

//************************************************
// srfifo registered internal ld, vld    
//************************************************

always @ (posedge clk)
begin
  if (!rst_l) begin
     ld  <= {1'b1,{(DEPTH){1'b0}}};	 // to make vlint happy	 
	 vld <= {DEPTH {1'b1}};	 
  end
  else begin
	 ld  <= next_ld;
	 vld <= next_vld;
  end // else: !if(!rst_l)
end // always @ (posedge clk)   


//************************************************
// Outputs
//************************************************

always @ (posedge clk)
begin
  if (!rst_l) begin
	 empty <= 1'b0;
	 underflow <= 1'b0;
	 overflow <= 1'b0;
  end
  else begin
	 empty <= enq ? 1'b0 : ((deq == 1'b1) & (vld[1] == 1'b0)) ? 1'b1 : empty;
     underflow <= ((vld[0] == 1'b0) 
                    && (vld_init[0] == 1'b0) 
                    && (deq == 1'b1)) ? 1'b1 : underflow;
     overflow  <= (((vld[DEPTH -1] == 1'b1) & enq) ? 1'b1 : overflow);
 end
end

//************************************************
// If deq is active high data_out gets the next 
// valid contents of sr[0]
//************************************************

  assign full = vld[DEPTH -1];   
  assign data_out = sr[0];

endmodule 

