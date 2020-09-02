`include "qed.vh"


module mcu_checker (/*AUTOARG*/
   // Inputs
   clk, rst, ena, MISRmcuIN, MISRmcuOUT, MISRreset, FFcontrol 
   );


   input        clk;
   input        rst;
   input        ena;
   input [1613:0] MISRmcuIN0;
   input [1613:0] MISRmcuIN1;
   input [1613:0] MISRmcuIN2;
   input [1613:0] MISRmcuIN3;
   input [1613:0] MISRmcuIN4;
   input [1613:0] MISRmcuIN5;
   input [1613:0] MISRmcuIN6;
   input [1613:0] MISRmcuIN7;

   input [1481:0] MISRmcuOUT0;
   input [1481:0] MISRmcuOUT1;
   input [1481:0] MISRmcuOUT2;
   input [1481:0] MISRmcuOUT3;
   input [1481:0] MISRmcuOUT4;
   input [1481:0] MISRmcuOUT5;
   input [1481:0] MISRmcuOUT6;
   input [1481:0] MISRmcuOUT7;

   output MISRreset;
   output [41511:0] FFcontrol;
    
   genvar       j;



   assign iregs[0] = reg0;
   assign iregs[1] = reg1;
   assign iregs[2] = reg2;
   assign iregs[3] = reg3;
   assign iregs[4] = reg4;
   assign iregs[5] = reg5;
   assign iregs[6] = reg6;
   assign iregs[7] = reg7;
   assign iregs[8] = reg8;
   assign iregs[9] = reg9;
   assign iregs[10] = reg10;
   assign iregs[11] = reg11;
   assign iregs[12] = reg12;
   assign iregs[13] = reg13;
   assign iregs[14] = reg14;
   assign iregs[15] = reg15;
   assign iregs[16] = reg16;
   assign iregs[17] = reg17;
   assign iregs[18] = reg18;
   assign iregs[19] = reg19;
   assign iregs[20] = reg20;
   assign iregs[21] = reg21;
   assign iregs[22] = reg22;
   assign iregs[23] = reg23;
   assign iregs[24] = reg24;
   assign iregs[25] = reg25;
   assign iregs[26] = reg26;
   assign iregs[27] = reg27;
   assign iregs[28] = reg28;
   assign iregs[29] = reg29;
   assign iregs[30] = reg30;
   assign iregs[31] = reg31;

   assign instruction = spc_wrapper.spc.dec.ifu_buf0_inst0;

   assign op = instruction[31:30];
   assign op2 = instruction[24:22];
   assign op3 = instruction[24:19];
   assign rd = instruction[29:25];
   assign rs1 = instruction[18:14];
   assign i = instruction[13];
   assign rs2 = instruction[4:0];

   assign qed_inst_out = spc_wrapper.spc.dec.qed.qed_ifu_instruction;

   assign  allowed_op_0_instructions = (op == 2'b00) && ((op2 == 3'b001) || // BPcc
                                                        (op2 == 3'b010) || // Bicc
                                                        (op2 == 3'b011) || // BPr bit 28 = 0, || bit 28 = 1, footnote page 138, sparcv9
                                                        (op2 == 3'b100));   // SETHI, NOP


   assign  allowed_op_2_instructions =  ((op == 2'b10) && 
            ((op3 == 6'b00_0000) || // ADD
             (op3 == 6'b00_0001) || // AND
             (op3 == 6'b00_0010) || // OR
             (op3 == 6'b00_0011) || // XOR
             (op3 == 6'b00_0100) || // SUB
             (op3 == 6'b00_0101) || // ANDN
             (op3 == 6'b00_0110) || // ORN
             (op3 == 6'b00_0111) || // XNOR
             (op3 == 6'b00_1000) || // ADDC
             (op3 == 6'b00_1001) || // MULX
             (op3 == 6'b00_1010) || // UMUL
             (op3 == 6'b00_1011) || // SMUL
             (op3 == 6'b00_1100) || // SUBC
             
             (op3 == 6'b01_0000) || // ADDcc
             (op3 == 6'b01_0001) || // ANDcc
             (op3 == 6'b01_0010) || // ORcc
             (op3 == 6'b01_0011) || // XORcc
             (op3 == 6'b01_0100) || // SUBcc
             (op3 == 6'b01_0101) || // ANDNcc
             (op3 == 6'b01_0110) || // ORNcc
             (op3 == 6'b01_0111) || // XNORcc
             (op3 == 6'b01_1000) || // ADDCcc
             (op3 == 6'b01_1010) || // UMULcc
             (op3 == 6'b01_1011) || // SMULcc
             (op3 == 6'b01_1100)) && ( // SUBCcc
          (rd < 5'b10000) && (rs1 < 5'b10000) && (((i == 1'b0) && (rs2 < 5'b10000)) || (i == 1'b1))));


   assign  allowed_op_3_instructions = ((op ==  2'b11) &&
          (rd < 5'b10000) && (rs1 < 5'b10000) && (((i == 1'b0) && (rs2 < 5'b10000)) || (i == 1'b1)));

   assign allowed_instructions = ((op == 2'b00));// || (op == 2'b10) || (op == 2'b11));

   assign qed_consistent = ((iregs[0] == iregs[16]) &&
                            (iregs[1] == iregs[17]) &&
                            (iregs[2] == iregs[18]) &&
                            (iregs[3] == iregs[19]) &&
                            (iregs[4] == iregs[20]) &&
                            (iregs[5] == iregs[21]) &&
                            (iregs[6] == iregs[22]) &&
                            (iregs[7] == iregs[23]) &&
                            (iregs[8] == iregs[24]) &&
                            (iregs[9] == iregs[25]) &&
                            (iregs[10] == iregs[26]) &&
                            (iregs[11] == iregs[27]) &&
                            (iregs[12] == iregs[28]) &&
                            (iregs[13] == iregs[29]) &&
                            (iregs[14] == iregs[30]) &&
                            (iregs[15] == iregs[31]));


   
   // PROPERTIES
   property check_i_register (a, b);
      @(posedge clk)
         (ena & (spc_wrapper.spc.dec.qed.mode == `CHECK_MODE )) |-> (a == b);
   endproperty
   

   // ASSUMPTIONS

//   assume_allowed_op_0_instructions:  assume property (@(posedge clk)  
//                                                       (op == 2'b00)
//                                                       |->
//                                                       allowed_op_0_instructions == 1);
//
//   assume_allowed_op_2_instructions:  assume property (@(posedge clk)  
//                                                       (op == 2'b10)
//                                                       |->
//                                                       allowed_op_2_instructions == 1);
//
//   assume_allowed_op_3_instructions:  assume property (@(posedge clk)  
//                                                       (op == 2'b11)
//                                                       |->
//	  			                         allowed_op_3_instructions == 1);


//   assume_allowed_instructions: assume property (@ (posedge clk) allowed_instructions);
   
   generate
      for (j=0; j < 16; j++) begin
         assume_rst_ireg_match : assume property (
                                                  @(posedge clk)
                                                  (spc_wrapper.rst & (spc_wrapper.spc.dec.qed.mode == `ORIGINAL_MODE ))
                                                  |->
                                                  iregs[j] == iregs[j+16]
                                                  ); 
      end
   endgenerate

   assume_stable_input : assume property (
                                         @(posedge clk)
                                         !$isunknown(spc_wrapper.spc.dec.ifu_buf0_inst0)
                                         );



   assume_vld_inpt : assume property (
                                      @(posedge clk)
                                      (spc_wrapper.spc.dec.qed.mode == `ORIGINAL_MODE)
                                      |->
                                      spc_wrapper.spc.dec.qed.vld_inst == 1'b1
                                      );


   // ASSERTIONS

   //check_alu_operands_0:  assert property (check_alu_operands);
   //check_load_store_operands_0: assert property (check_load_store_operands);

   generate
      for (j = 1; j < 4; j++) begin
         assert_ireg_match : assert property (
                                              @(posedge clk) 
                                              (ena & (spc_wrapper.spc.dec.qed.mode == `CHECK_MODE ))
                                              |->
                                              iregs[j] == iregs[j+16]
                                              );
      end
   endgenerate

 inst_constraint inst_constraint_0 (.clk(spc_wrapper.spc.dec.l2clk),
                                                               .dec_valid_d(spc_wrapper.spc.dec.dec_valid0_d_i),
                                                               .instruction(spc_wrapper.spc.dec.ifu_buf0_inst0));


//   generate
//      for (j = 0; j < 16; j++) begin
//         assert_ireg_match_v2 : assert property (check_i_register (iregs[j], iregs[j+16]));
//      end
//   endgenerate

  // COVERS

//   generate
//      for (j=0; j < 16; j++) begin
//        cover_ireg_match : cover property (@(posedge clk) (iregs[j] == j));
//      end
//   endgenerate

     cover_bug_active : cover property (
                                        @(posedge clk) 
                                        spc_wrapper.spc.dec.bug_active == 1'b0
                                        ##1
                                        spc_wrapper.spc.dec.bug_active == 1'b1);



cover_test_MISR_1 : cover property (
                            @(posedge clk)
                            (MISR_reset == 1)
                            ##124
                            MISRmcuIN0 == 101'h
                            MISRmcuIN1 == 101'h
                            MISRmcuIN2 == 101'h
                            MISRmcuIN3 == 101'h
                            MISRmcuIN4 == 101'h
                            MISRmcuIN5 == 101'h
                            MISRmcuIN6 == 101'h
                            MISRmcuIN7 == 101'h
                            MISRmcuOUT0 == 93'h
                            MISRmcuOUT1 == 93'h
                            MISRmcuOUT2 == 93'h
                            MISRmcuOUT3 == 93'h
                            MISRmcuOUT4 == 93'h
                            MISRmcuOUT5 == 93'h
                            MISRmcuOUT6 == 93'h
                            MISRmcuOUT7 == 93'h
                            qed_consistent == 0);


cover_test_MISR_1 : cover property (
                            @(posedge clk)
                            (MISR_reset == 1)
                            ##124
                            MISRmcuIN0 == 101'h
                            MISRmcuIN1 == 101'h
                            MISRmcuIN2 == 101'h
                            MISRmcuIN3 == 101'h
                            MISRmcuIN4 == 101'h
                            MISRmcuIN5 == 101'h
                            MISRmcuIN6 == 101'h
                            MISRmcuIN7 == 101'h
                            MISRmcuOUT0 == 93'h
                            MISRmcuOUT1 == 93'h
                            MISRmcuOUT2 == 93'h
                            MISRmcuOUT3 == 93'h
                            MISRmcuOUT4 == 93'h
                            MISRmcuOUT5 == 93'h
                            MISRmcuOUT6 == 93'h
                            MISRmcuOUT7 == 93'h
                            qed_consistent == 0);


*/

endmodule // spc_checker
