// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: testing_state_fsm.v
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
`ifdef AXIS_FBDIMM_NO_FSR
`else

module testing_state_fsm(ps_bit,link_clk,amb_id,testing_state_start,testing_state_end,amb_id_ok,sb2nbmap);

parameter DS=0;

input ps_bit;
input link_clk;
output [3:0] amb_id;
input testing_state_start;
output testing_state_end;
output amb_id_ok;
output [2:0] sb2nbmap;

reg [2:0] SB2NB_Map,SB2NB_Map_tmp;
reg first_frame_enddelimeter_ok;
reg [11:0] tr_reg;
reg [4:0] tr_state;
reg [4:0] tr_count;
reg [11:0] clk_trn_ptrn;
reg [3:0] clk_grp;
reg ts1_ready_reg;
reg [3:0] amb_id_reg;
reg [23:0] test_param_reg;
reg [7:8] test_param_count;
reg [47:0] end_del_reg;
reg [2:0] sb2nbmap_reg;
reg testing_state_start_reg,testing_state_end_reg;
assign amb_id=amb_id_reg;
assign amb_id_ok = ( amb_id_reg == DS) ? 1'b1: 1'b0;
assign sb2nbmap =  SB2NB_Map ;

`define BEFORE_IDLE 9

initial begin
tr_state=`BEFORE_IDLE;
tr_count=5'h0;
test_param_count=0;
amb_id_reg=0;
SB2NB_Map=0;
SB2NB_Map_tmp=0;
end

//assign testing_state_start=testing_state_start_reg;
assign testing_state_end=testing_state_end_reg;


always@(negedge link_clk) if ( testing_state_start )
begin
  case(tr_state)
   `BEFORE_IDLE: begin
                   SB2NB_Map <= 0;
                   tr_state<=`IDLE;
                   first_frame_enddelimeter_ok <= 1'b0;
                 end
   `IDLE: begin
              tr_reg[11:0] <= {ps_bit, tr_reg[11:1] };

             // polling state detected
              if ( ({ps_bit, tr_reg[11:1] } == 12'b011111111110 ) &
                    first_frame_enddelimeter_ok ) 
                       testing_state_end_reg <=1;
              else
                       testing_state_end_reg <=0;

              if ( {ps_bit, tr_reg[11:1] } == 12'b111111111110 ) begin
                 tr_state<=`TS_TEST_1;
`ifdef FBD_DBG
                 `PR_ALWAYS ("amb_init",`DBG_0,"AMB Detected TESTING");
`endif
               end

             end
   `TS_TEST_1: begin
                case(tr_count)
                 4'b0000: begin tr_reg[0] <= ps_bit;  tr_count<=tr_count+5'h1; end
                 4'b0001: begin tr_reg[1] <= ps_bit; tr_count<=tr_count+5'h1;  end
                 4'b0010: begin tr_reg[2] <= ps_bit;  tr_count<=tr_count+5'h1;end
                 4'b0011: begin tr_reg[3] <= ps_bit; tr_count<=tr_count+5'h1; end
                 4'b0100: begin tr_reg[4] <= ps_bit; tr_count<=tr_count+5'h1; end
                 4'b0101: begin tr_reg[5] <= ps_bit; tr_count<=tr_count+5'h1; end
                 4'b0110: begin tr_reg[6] <= ps_bit;  tr_count<=tr_count+5'h1; end
                 4'b0111: begin tr_reg[7] <= ps_bit; tr_count<=tr_count+5'h1; end
                 4'b1000: begin tr_reg[8] <= ps_bit; tr_count<=tr_count+5'h1;  end
                 4'b1001: begin tr_reg[9] <= ps_bit;  tr_count<=tr_count+5'h1; end
                 4'b1010: begin tr_reg[10] <= ps_bit; tr_count<=tr_count+5'h1; end
                 4'b1011: begin tr_reg[11] <= ps_bit; tr_state<=`TS_TEST_2; 
                                 tr_count<=5'h1;clk_grp<=0;   amb_id_reg[3:0]<=tr_reg[3:0];SB2NB_Map<=tr_reg[6:4]; 

`ifdef FBD_DBG
                `PR_ALWAYS ("amb_init",`DBG_0,"TS_TEST Control values: ambid=%h sb2nbmap   %h",tr_reg[3:0],tr_reg[6:4]);
`endif
                          end
                endcase
             end

   `TS_TEST_2: begin
                end_del_reg[47:0] <= { ps_bit,end_del_reg[47:1]};

                 // if the last 4 groups have;
                 //   n-3  => first del, first grp
                 //   n-2  => first del, last grp
                 //   n-1  => last del, first grp
                 //   n    => last del, last grp

               if ( { ps_bit,end_del_reg[47:1]} == {12'b001101000101,12'b011001111000,12'b001101000101,12'b011001111000} )
                begin
`ifdef FBD_DBG
                       `PR_ALWAYS ("amb_init",`DBG_0,"AMB_INIT testing end sequence detected");
`endif
                       first_frame_enddelimeter_ok <= 1'b1;
                       tr_state<=`IDLE;
                end              
                      
               end

  endcase


end
else begin
  tr_state<=`BEFORE_IDLE;
  testing_state_end_reg <= 0;
end

endmodule



module testing_state_fsm_chk(ps_bit,link_clk,testing_state_start);

parameter DS=0;

input ps_bit;
input link_clk;
input testing_state_start;

reg [2:0] SB2NB_Map;
reg [143:0] tr_reg;
reg [4:0] tr_state;
reg [9:0] tr_count;
reg [11:0] clk_trn_ptrn;
reg [3:0] clk_grp;
reg ts1_ready_reg;
reg [3:0] amb_id_reg;
reg [23:0] test_param_reg;
reg [7:8] test_param_count;
reg [47:0] end_del_reg;
reg testing_state_start_reg,testing_state_end_reg;

initial begin
tr_state=0;
tr_count=10'h0;
test_param_count=0;
amb_id_reg=0;
SB2NB_Map=0;
end


always@(posedge link_clk) if ( testing_state_start )
begin
  case(tr_state)
   `IDLE: begin
             // ts1_ready_reg=0;
              tr_reg[143:0] <= {ps_bit,tr_reg[143:1]};

              if (tr_reg[143:132] == 12'b111111111110 ) begin
                 tr_state<=`TS_TEST_1;
               end

             end
   `TS_TEST_1: begin
              tr_reg[143:0] = {ps_bit,tr_reg[143:1]};
               tr_count<=tr_count+10'h1;
               if ( (tr_count == 10'h83) && (tr_reg[143:0] != 0 ) ) begin  
`ifdef AXIS_FBDIMM_HW
`else
                           `PR_ALWAYS ("ch_mon",`DBG_0,"ts_reg: %h ",tr_reg);

/* This is already checked indirectly
                        if ( tr_reg[11:0] != 12'hffe )
                             `PR_ALWAYS ("ch_mon",`DBG_0,"ERROR: ffe pattern not found for testing state ");
     
*/
                        if ( {tr_reg[23:19]} != {5'b00000} )
                             `PR_ALWAYS ("ch_mon",`DBG_0,"ERROR: grp1 pattern in testing is wrong! ");

                        if ( (tr_reg[18:16] != 3'b000 ) && (tr_reg[18:16] != 3'b001))
                             `PR_ALWAYS ("ch_mon",`DBG_0,"ERROR: SBtoNB mapping value(%b) in testing is reserved! ",tr_reg[18:16]);
`endif                         
                tr_count<=10'h0;
                tr_state<=`IDLE;
               end
            end

  endcase


end


endmodule

`endif //AXIS_FBDIMM_HW
