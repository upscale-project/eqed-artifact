`include "qed.vh"


module ccx_checker (/*AUTOARG*/
   // Inputs
   clk, rst, ena, MISRccxIN, MISRccxOUT, MISRreset, FFcontrol 
   );


   input        clk;
   input        rst;
   input        ena;
   input [12911:0] ccxIN0;
   input [11855:0] ccxOUT0;   
   input [12911:0] ccxIN1;
   input [11855:0] ccxOUT1;


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
                            ##50
                            inject1 == 1
                            ##74
                            ccxOUT0 == 296400'h
d6 eb 8f c9 7f b8 aa ce 2d f8 28 26 91 b6 dd a1 
61 db d2 b2 cd d6 db 14 7f 78 12 d7 cd e0 f8 b8 
bc c6 42 fa 6e 1c f0 3a 62 98 0f 38 cc cc bf 19 
fe 86 18 ed ae 2a 52 f5 cb a8 f6 e5 1a c2 d3 37 
6d 1a 27 2e 25 87 f5 25 81 ac 5d 7f 4e d1 c1 05 
05 89 7d aa cd 53 2f 86 bc f2 ad e6 96 8f 87 72 
4b ac 19 8d be 9d 74 87 ea 78 66 68 11 85 29 c3 
29 69 dd e6 22 d3 76 4d 39 a4 8e 7f 4f 11 e0 2b 
24 69 5e 57 70 41 25 01 88 49 e7 69 08 2a 69 c5 
79 cc f6 30 28 5b 97 b7 5a 42 0c 2d b8 b2 ee fe 
5e d2 d9 76 56 35 7c 59 98 44 3b 8a ad 84 74 9c 
62 73 23 b6 82 43 3a 12 3e a2 70 1d f4 bb 6f 04 
2f 89 30 8d cc 7f c0 42 e7 65 ce fc 6f 34 a0 e5 
db b3 ec ca bb a1 b2 13 67 b2 49 63 b1 0b 3e fd 
b2 75 3a 43 1d c1 6a 63 48 9d 55 c4 b8 41 c9 7f 
39 f0 dc c5 fb 81 35 5c c6 53 9b e5 89 d8 31 63 
30 cd 39 48 19 f3 cd 13 36 a7 1c 20 36 8d d0 61 
ae 5a ea a3 0f 3f 33 c6 cc a6 85 0c a8 12 85 28 
e3 fd 55 2e 5b da c2 2d 35 4f 5c a5 13 7c 9a 35 
bd ec cc 0c 7e 57 4e 61 c8 91 cc 0a 7c ec 20 3b 
88 f4 ad ee f3 9f 45 72 5c 94 5d 1f 3b b5 6d 85 
fe 5c 6c d9 0b 19 82 3b e9 59 92 5a 7c 43 7b ab 
7b 57 85 6b 65 a8 9a 7a 82 4e 70 82 a1 64 38 fc 
84 07 f6 d1 37 58 b4 40 56 2a ab b4 58 2f 4a 67 
5b 9b 3b 55 64 bd b0 e6 0a f4 fe 7c 13 2c cd c5 
7e d0 00 d1 5a 58 b9 4b 8e 6b 9b 7a 69 15 3b 77 
26 0d ba f4 dd 44 12 67 66 8c 01 1a 99 d2 4c 23 
fe fc b0 e9 14 08 53 ba 04 be 13 bb ee f7 08 d7 
12 c4 86 79 2c d5 13 44 34 4e 03 24 cc 88 f4 77 
38 4b 37 f8 2a ea d5 0d ee c9 0e 43 20 5b 23 92 
bf e8 28 74 e5 ef 6b 9f e8 fa 51 91 97 27 63 1d 
2e d9 ce 01 ed 47 b8 9f 7a 79 55 e1 87 88 be ee 
7e 35 31 ee 96 22 45 7f 2c 99 04 5c d6 ad aa 76 
6d 3f bf 80 e3 75 9d fd 4d 7f 96 ed 51 17 19 ef 
c9 f7 11 f4 48 8a 83 c3 ca f2 32 2e ce 6b 64 d5 
ee 1a a5 59 c2 54 c4 a6 f2 f6 29 14 d8 68 dc 48 
39 a4 ea ac 13 3f 01 6b 9e c6 db 3f 24 51 cb 5f 
bb 8c 88 c5 b4 8e 8c 0f 93 97 60 25 7f e1 6b 8c 
d8 a6 05 7e 8a 1c cf 39 e7 66 d4 60 e9 c8 94 aa 
72 d5 9b e0 ee 7a a8 73 36 be d7 b9 a7 fc 66 c7 
e9 40 31 d0 6e fc c8 df a9 2e 9e 80 d5 03 1e 63 
c6 c9 43 e9 c0 53 cb 16 64 80 41 42 84 c3 af ba 
e8 06 83 b6 8d 31 03 47 11 f6 1d cd eb e2 81 8f 
51 f5 f8 fd 8a 99 17 47 db 20 3d be 9e fa a7 14 
21 dc 34 36 fe 9b 6a cd d5 9c f9 74 cf ff 43 47 
a8 10 c4 f9 12 84 cb 97 0f b5 bb a7 2c d6 09 be 
4e 07 06 e4 0d e4 9e 04 c1 7d d6 6c e7 bb e9 9c 
ec 52 6c 81 70 dc 63 09 ec e3 5c 40 33 e8 c0 8b 
c2 5f b5 ba 9f 48 e0 45 e4 45 7d f0 cb b9 47 a4 
d3 09 50 c4 94 13 f1 d0 24 6c 61 bf b6 5a d8 5f 
a3 11 2c 89 87 ea 31 62 2e ac f1 6d f9 5e a6 dc 
11 7f ca 60 61 3e 29 42 71 c7 b9 f8 f6 45 b0 92 
bf f9 7e 33 d2 6b 26 6c 41 5f b8 c0 94 f2 08 31 
5c 0f 58 95 b5 60 c0 42 4c 51 0c 93 42 36 ff b9 
b6 f4 2b c3 a8 fd 4b 5d ea 58 f2 0e 32 00 73 b6 
82 da 00 67 c0 67 34 f8 bb c4 fe 8b 23 f4 78 c7 
37 45 f9 a7 6d ed 63 f3 fd 5c 3b 84 f5 e1 5d 17 
f3 84 eb b6 2e 6d 55 b0 43 85 da ca 27 29 e0 18 
c9 b2 2c 40 97 3b cd e5 ab bf 85 c0 9d 85 d9 be 
4c 5f e7 d2 ce 3e 4e 66 98 06 97 7d 28 e6 8e cd 
94 69 77 cc 36 0f 9b 35 4d 71 1f a8 d2 c6 90 2a 
13 9f d0 ae 0b bd 6e 68 ba 6c 01 f0 de e0 89 54 
bc e1 5a 3a ae 4f fb d9 56 b3 51 28 af 1d 4e 48 
e2 f2 df 45 76 3a cd 09 99 b8 ac ec 6f 4e 9b 29 
a5 83 78 d8 3c 5b c0 b6 16 50 2a ad 42 98 33 71 
82 a3 15 3b b8 e0 b8 24 0c 67 38 dc 40 8b f9 ca 
8f a2 c7 43 66 fb eb a4 65 7b 37 72 be 44 7b 18 
fc f9 08 29 a0 87 fa 1c 3f ac 3d 09 b5 50 ba 83 
00 82 64 c2 16 dc 2f e9 ab 2a 3e 34 9e 46 d0 71 
ff 41 26 cd 42 0d 5a 88 d2 3a 4a 7a ba 89 a7 fd 
ca 22 00 fc 73 01 69 29 fb 34 11 7d 79 6d 19 8d 
09 00 c0 be 5f 39 64 1e 91 85 88 02 9a e7 cc 9a 
59 bf f9 31 07 9b 29 3f 62 40 c3 16 b4 bb 12 7b 
6d 19 6d 02 8d ca 62 0a 93 95 a4 eb e6 81 82 26 
88 e3 1e b8 71 23 a6 38 55 90 5d 3d 39 5c bf cb 
3e cc ce 82 c5 99 7b a6 e1 71 82 fb 6e 6f 1b 0a 
27 18 23 d6 26 34 28 77 d6 d6 11 54 1a 42 07 79 
a1 b0 e0 e7 7a 6c 66 60 ae af b5 f6 db cf de 85 
94 b0 ae 4e fb 91 67 4d ee b1 09 1b 01 32 bb 9a 
e6 a9 5b 06 ac 10 6c 73 33 a6 fd 43 10 86 7b b4 
d8 5f b6 1f cd f4 2c bf 94 40 93 d8 b6 9b 86 a6 
26 f5 db 86 59 c5 9a ac 11 e1 38 3d cf a9 a1 f6 
7c 15 d9 81 ea 58 48 f6 62 61 7a 68 37 83 01 56 
6f 5e 95 cc e7 37 47 7b 63 4f c3 7a e4 85 7f 50 
6b 30 e2 92 42 1f c9 da 00 3e 18 d0 9c 47 49 ca 
be e0 53 12 dc fc 85 05 4c bb 94 83 04 22 66 96 
8f e6 04 af e9 7b 9d 57 86 b9 9f 38 4d b6 0b 46 
89 57 bd 72 cb 01 b7 b5 96 da 32 85 a4 99 db 05 
3f 6e 92 c1 14 d7 7b 02 5f 30 df ce 2a de cc e9 
df e5 45 86 49 0c cd 1d 9f 84 dd 84 c5 a9 7b 85 
02 21 de a3 ff eb e5 96 89 de 57 63 ee 4a e9 9f 
4f c9 0a bc 84 1e 0f fd d6 5d ec 2d dc e4 a2 8b 
b5 4d 8e f2 0c 13 65 64 65 a5 57 ae 19 3c 3f 09 
94 a6 5d 1f 89 87 1f 0e 4e 14 e4 2c db 91 66 ec 
e2 20 b6 7b ae 40 86 66 11 c1 1d 52 87 f1 0c 10 
62 03 1a b7 4c 61 19 8e b9 6f 6f 57 95 42 91 28 
15 07 ec 20 a0 26 99 39 bf 16 39 d1 6e a6 6f 68 
29 55 fc d7 0a 1c d4 ff 64 4e 85 6f 8e aa 27 21 
3d e6 cb 9e f6 df 12 07 b7 b5 17 12 31 b2 5a 8e 
b6 c7 ea 78 c3 08 2d 48 ad b5 b7 41 af ab f4 91 
de 9e 39 01 86 c1 30 c7 c0 bf 12 5d 74 d9 15 0e 
66 32 b2 14 e3 cb 3f 42 a5 58 76 55 69 22 15 d9 
f4 a6 28 0d a3 a6 c6 42 d1 e4 07 1b 6e 54 d1 c5 
36 26 b2 c6 80 6b 7c 2a 9e 00 55 63 d6 48 f1 f5 
1a 32 d6 fd dd 58 b7 02 cc a1 9e 68 61 19 70 3c 
45 60 12 f9 ed 50 31 d8 07 d7 6b e1 48 ed d9 f6 
b8 3e 1b 3a 76 f5 21 b0 41 2c 81 ff e6 84 ab da 
8b be d1 05 e1 24 53 d8 49 f6 fc 46 3a b8 d1 14 
f8 c0 07 f6 57 e0 e3 4f e5 b1 56 b4 08 d4 fa 14 
af 7d 77 6e e3 f1 60 a5 af d9 30 64 2e 8b eb 28 
e6 72 18 4d 21 55 09 a3 cd 65 eb 0a 59 53 50 c0 
f5 b4 df fb b5 26 d3 b4 f4 39 be ce 5a ae 48 87 
0f 07 fc 65 58 6e cc 0e 0e af cf 49 b1 68 a1 09 
af 81 92 9d 3c 3b 85 08 c2 0a cf 6a 07 7b 5d d4 
4a 62 42 90 00 38 b0 2c c0 19 b0 89 e4 22 dc a1 
2c 68 89 61 ed 98 d6 bc f7 32 69 c5 e6 19 87 82 
dc 5d 70 4b b7 21 d0 24 f7 75 77 5a cc 05 68 31 
fc ef df 32 5b c8 37 59 af 31 8e bb 85 ff 52 68 
ae c4 f9 48 cb 1f 18 d3 d6 98 c6 5e 71 36 05 bf 
3d 9a bb 18 80 b3 28 c9 4b 39 01 79 74 5e 37 86 
f4 7a ec 56 65 9d b3 36 80 ad 1a 04 39 a0 a6 b6 
58 32 1b e1 a2 4c a2 7f 9c 63 9b 72 1f 47 f3 29 
09 c7 27 92 b7 35 81 dd 6c aa 53 5b be b6 49 59 
1f 46 a0 8e ba 61 b6 2c 33 9f ae d2 21 5e 32 4a 
01 0b 6d dd 29 34 44 d6 f9 19 3d 81 51 2f 25 47 
f3 91 6c b6 fe 01 44 3e 82 87 45 04 0b eb 13 28 
70 b4 18 c8 88 e9 dd 51 17 44 e9 65 64 36 58 47 
ac bc 02 31 34 58 3b 90 f2 cc 29 25 e8 43 49 76 
e8 c3 d3 f0 ef 70 b4 1d 25 b3 89 82 99 7b 73 62 
ef ae e8 86 b6 ab ed 6b e3 58 f0 7b 95 c4 f4 4d 
7b e4 c8 91 23 15 ae 7f ac 8f 89 4d c2 5f a2 93 
cd 7a 2c 72 06 75 b7 c0 7f ed 8f b3 67 65 16 7c 
b7 0e 00 23 05 60 9e e6 0d 66 c1 d7 2a 8d 59 7d 
9d 91 e8 4d f5 7e 39 84 2b e2 9b e6 c8 cc 06 93 
c9 58 7a 52 af df 01 cf 50 be 00 df 39 e7 01 f7 
4b 39 09 2c 46 94 a6 69 b3 f9 5a 47 93 e4 f6 af 
4b fc 2e 79 ca 13 42 28 5a 5d 53 6c 03 25 2c f8 
50 8e 1f a1 bd bf 74 ee 90 6c 7f 05 de a6 e8 7d 
01 72 d2 93 fe c7 d4 8b 14 ca ca 73 68 4e 3c e9 
95 90 20 98 86 37 8d e1 b3 9c 5a 93 c9 7b af 3d 
51 2c 7f d9 8a 55 24 59 86 52 10 8e 04 1e 5b f0 
92 7d 73 d5 26 b2 de 8e 4f 94 f7 7c cd 10 62 3d 
94 fc c8 bc 1b f8 bf ae 30 7f 1d 5b 97 14 9f c4 
39 b9 5e 2e 83 12 b2 6a 90 74 83 ee af b7 75 bd 
7d 65 36 09 c5 57 9b 74 ec 4b 72 40 01 5b 5f dc 
8f bf b2 24 d6 c2 7c 82 a8 ce 02 67 0f 5c 23 49 
82 66 4a e2 96 40 da 3f 93 14 35 6c a5 8d 3a 6e 
86 ae 33 9a d3 3e e1 b9 a1 32 2a 4a 02 bd 86 21 
89 92 14 66 9b 83 5d 1b 6d 6e eb fe 22 08 f3 91 
f3 cc bf ba 27 ab 23 71 e7 d6 59 aa 4a 57 f2 b3 
0d 59 65 9f 6a 32 36 47 f6 7a a0 da a1 bb e5 b5 
3a f0 ae e5 06 29 13 a6 67 03 35 96 99 cf 57 d3 
8b be 01 c5 b7 87 0b 0c 08 7f ab 17 23 05 3a 52 
fb 70 3b f7 64 df 81 74 82 b5 71 73 f9 4b d0 29 
b6 e1 71 b3 7c ad 90 83 ab e5 77 5a 4b 0b 49 1c 
68 2e e4 e7 86 0c 2d f9 6e 0e 1c 60 c6 65 5d 70 
be 47 b9 ad 84 f4 73 4d 70 78 51 97 e0 9f 00 d6 
0c 50 c9 3a 82 22 94 aa f7 09 3c 0a 62 ee c5 f4 
f4 a6 5d fe c4 05 75 fb 6a 7a 78 6e fa 3a 96 a4 
b2 77 4a e3 0e b6 31 71 58 76 0b 6b d4 d3 6a 38 
a6 9f 3b 67 bd e8 3c bf 8c 6a fa fc b5 62 88 0f 
11 d8 fc 7e 01 0a 90 f2 f6 44 ae c0 54 27 a2 92 
83 49 09 21 53 89 a8 0e 16 39 d4 cb df 9f 51 09 
bc a3 40 bf cd e6 72 1b 2a cd 4c c1 ee d7 7b 2b 
ac 42 71 3d e5 20 3b 63 56 ab 8e 98 57 04 d6 3c 
32 c5 fa d6 6d d7 84 cb d9 44 04 bb 69 bc 00 16 
6f 0f bd 94 e2 1f 78 14 61 78 cd 07 84 72 60 b0 
bf 4b de 5b be b5 de a2 84 40 2f 70 f1 af 90 57 
5a d1 92 19 dd 48 2c ae c1 e8 52 93 c5 7a ad 0f 
9b 83 12 50 bf a2 01 2a 33 8c 4d 13 88 91 1a 49 
2b 29 f0 cf 21 4d 25 09 66 d7 cf 22 d0 58 4c 12 
a2 11 22 f7 43 39 80 1b ce e6 0a a7 b0 ef 9a 45 
c0 a9 ed f2 3c ef 42 42 a0 87 d1 13 98 28 2e 45 
6b 31 8e c5 43 48 dc 77 05 90 fe f8 22 53 2a be 
4e e0 8f 22 14 68 77 c7 c8 8e 8e f7 2f e7 e8 fb 
fd b1 4d c2 0c a3 45 5d 15 61 37 e3 43 5a 38 57 
e4 8e 3b f3 9f a5 d7 86 6a 57 f7 31 c5 cb 71 70 
6a 5a 2e 36 ef cb 03 6d 43 c2 44 cb de 0f ec fb 
fa 7e c2 57 91 5a 56 6a 88 7f 8a c7 f4 49 97 51 
aa c5 d6 b1 b6 08 08 87 6a 3b 51 e7 08 01 a7 a0 
1c 1c 57 95 cc a7 fd 2d a0 1f a1 d8 4a bf d1 88 
d1 f4 fc 67 26 8f 2a 9c 1e a9 d7 ab 18 3f 48 77 
6f 8b 73 83 79 69 5a cb 71 0c 5b 1f 4b bc d4 88 
d1 33 d4 1b ed e1 e7 99 fa 62 f4 1f 62 8f 6a 7c 
1d 12 66 23 3c be 9e 65 47 9b 25 6f 58 90 98 9b 
fd c9 c6 3e 11 af 4f e3 05 d5 9f 5a 1d b3 c9 1b 
ab 3c 0d ad 07 73 5f 30 c5 78 a8 d6 36 f0 13 c4 
2b 16 1a fe 51 be a6 52 26 3a 43 72 f8 0c 78 0f 
1e b8 6a 47 31 03 b9 ea 2c 1b ab 74 92 74 68 69 
e2 ab 06 a9 67 87 29 4d 2a 5d 89 a4 9e 3f 70 b1 
a5 f8 c9 b7 16 a4 e3 d6 15 69 7f 58 55 75 ee 24 
f8 d6 52 a5 33 b9 24 b3 24 a3 8b e9 96 88 2d 85 
39 60 bc 3d 3b 88 7d ed 95 72 51 b7 c9 24 c7 70 
03 0b 1b 52 82 7d 8d 90 01 fa 0c f2 6d c1 60 58 
80 66 da ae 03 35 0f eb 1e 2f 79 0a b8 82 7c b2 
3b c7 e1 1a 98 8e 58 aa 77 03 fe c5 75 90 52 e4 
c5 f2 d1 50 fe 4d 32 bc 9d df d8 e5 bd 98 33 d9 
69 1b de ad b0 1c b4 61 8b 76 bf 2e 07 fc cc ed 
7b 03 ab ae ea 35 a4 6e c3 fb 12 d5 72 6b 45 de 
e6 1f 8c 6a 28 8e 7c 5b d6 61 5b 2e c4 fa 1c cc 
cb 9d 31 69 ec 33 9b 81 26 52 2b f2 b0 9a 9b bc 
5b 02 92 c7 fc 48 9f c6 12 d1 bf 92 54 c4 95 ee 
af 37 70 66 35 cf 00 cc 52 02 1b c8 8f 58 6f f6 
d8 3a 93 1c 49 a0 23 42 d1 8c 96 90 2a a6 6c 4e 
ef 19 b1 03 e7 a1 33 87 09 0c 85 04 40 4b 28 5e 
43 0f 9f bd 89 35 f1 bd 38 0c d9 b5 31 61 9c 96 
1c 34 66 1f 22 77 2f b3 f4 d1 8e f6 ec 31 9a ee 
1c cb 93 35 73 7b 09 f0 60 3e 69 3b 3f 63 4a 67 
a0 41 05 16 ce 48 fe b7 f5 f5 b5 4b 40 49 4b 61 
67 57 d5 45 dd 78 18 16 af b6 7a 1b f2 71 6d 60 
67 23 00 33 e2 b9 73 5a 59 5d 54 aa 86 74 99 3e 
30 73 63 15 83 de 07 bf d8 21 34 d6 47 ab 83 13 
1f a7 80 53 25 5a b9 ec ac d1 4a d1 2b 57 ee 65 
9f 15 4d 6b 8f 59 0f 97 c8 0d 68 99 38 af 5b 77 
8f d7 d7 4d 6f 33 a6 33 e2 8a 15 d5 13 15 dc 29 
03 a5 87 d7 de b3 d0 c8 24 77 ab 85 9c 78 4c a1 
23 1a e9 e7 35 4b 52 29 bc 10 bc 9f fb 35 60 ee 
f5 c0 11 5d 3e b3 09 66 9f 5b 2d 61 ad 8d 64 cc 
95 da 36 34 a4 b3 7a 0c ba 76 b4 ed 72 47 8b 64 
c2 f4 0c 44 38 9c 2c 60 b4 c4 ae 61 64 6d 0e 29 
cb bc f6 e1 15 cb a4 b1 20 7a 35 f4 6d bf 23 95 
e4 13 23 60 02 4b f0 11 1e 33 2f 5e 11 0c 94 0a 
5e 37 ae 17 16 fc 68 02 e4 f6 80 fc fd 30 f5 47 
ee d6 a8 dc 61 df eb 42 b0 f5 c7 dd b5 6c 6c a1 
58 23 79 80 bf 6c 3f 32 a4 d8 37 44 8b ed ce d3 
c2 55 9d 89 ac 0d 98 3b ad 21 76 f1 11 c4 fe 0a 
c5 ed d9 f1 ae ba 7f 4f 70 2f 27 b9 a1 4a 8e db 
17 51 21 9a d1 e5 64 fc c3 32 f7 4f ff fa ab 72 
a2 2b e0 87 0d 80 7c e1 38 cc c3 41 a9 0f 15 cc 
69 b2 8f f5 21 56 bb 1e ef 0e bc 3a c0 84 79 73 
7d 2d ff 4a 0f 26 c6 af 0f 25 b2 13 5d 07 75 30 
15 51 dc 8b d0 6d ba 5b 48 ae fc 9d 86 e6 2a 2f 
38 95 63 ae 80 45 b2 4e ee c5 d5 85 9b 00 8b 3c 
62 2a 64 b0 96 1b e0 e7 b1 b8 61 87 83 d2 65 31 
87 57 bc d1 5d 7f 62 68 1a 56 f7 b0 74 03 9f 4a 
42 f0 a3 18 11 ac fe b5 d9 ff f9 45 f0 1f 12 e6 
05 ea 69 e7 52 bd 85 25 4a e1 e9 78 99 1d 8e 3f 
5b fc 31 d6 58 9e e3 ca 02 11 0f 1c 6b 6d 9d 60 
84 d2 f2 3b ef bf 9f 71 7d 35 24 9c 87 7e 8f a7 
f1 ba 90 6e 8a 41 76 55 16 2f a5 6c 42 70 eb 94 
ed b9 8a 37 69 15 d1 9d 47 0e 4f 0e c3 91 4c 76 
8e 29 3e 77 0b 9c 99 ad 61 55 94 db 13 f7 43 11 
bb 67 66 c6 65 f1 2e f8 cb c4 a9 94 fe 10 fb f5 
d1 3b c5 ab 68 9a ed 7a 1d cd 8e cc 9a 2a 44 0a 
50 13 94 6e b1 df 0c 5f 6f 4d cb 87 ff 96 e8 d5 
ed 0c 72 4c 60 8e 2b e7 c6 35 5a 87 61 d8 4f f9 
43 28 47 e0 24 22 b8 51 7c 19 33 67 62 c2 d1 e1 
8e 3f 36 9f 4e 9e 39 c1 7b 53 82 25 52 6e 4d 68 
de 47 b4 ef 31 5d bb c1 dd 8d 23 e6 94 a3 63 2c 
35 a9 d4 9d 07 ef 49 69 89 50 3f 21 5c 71 f1 df 
63 13 a8 77 bd f2 b9 78 71 05 35 79 39 74 2f 01 
7e 0d 4b a1 6b 96 bd 49 42 1f f6 65 6e 35 d3 fc 
c1 38 08 e5 2e 1c 63 72 52 8c 67 86 42 2a 05 1a 
c1 4b c4 4b 22 1f 61 8b c1 10 2d 1e 71 3d 87 53 
d0 f8 e2 f6 fe 9b 9f 0b 1b 16 35 38 ee 4d 8c b3 
53 de 66 5f a2 8a a6 2e f9 42 2e 9d 89 7e a2 83 
cc f5 fb 1f 74 7c f2 a1 d7 24 66 a7 91 36 19 9b 
9f 9a 1d 74 1e 77 39 51 2b 17 56 d0 71 8c 13 fe 
00 c6 4d 5e cd a5 4f f3 b9 02 2d 34 8a b0 8a 2e 
88 f8 32 30 11 4b fc db 63 a7 a3 f0 b0 a2 52 f5 
9b cc fb 12 5b 56 85 6b f1 61 a2 f0 df 83 29 95 
5e 35 13 f6 1e e2 c9 8b f1 39 13 fa 51 6c f7 6e 
fe 6f d5 01 2f 86 e2 29 74 9e 49 f5 48 1a 16 12 
9e 1f cc 92 4b 74 18 49 ab 66 b6 f1 35 ac 40 6a 
38 cb 38 e0 44 82 f3 78 4b 2f 92 ff bc e0 f8 4c 
a3 c8 b1 22 5f 4e 07 27 fa b9 e3 af d4 89 5d b4 
bb 50 7c 94 30 a5 74 bf d5 a6 65 2c 2c af b2 ac 
34 6f f8 75 49 47 b1 e1 38 3f e5 4e a0 28 f3 e8 
66 d4 dd af 19 47 0f d4 75 62 39 0d 55 ca 48 12 
ba 3c ba f6 77 a8 f8 34 ee d1 48 8c b1 96 91 07 
9e 82 60 74 95 f8 0f cc c8 0f 0f cd a4 d9 5b 05 
4b e1 89 f3 6b 3f 60 1c 58 68 db ab cf cf 7b 58 
bb 75 d0 ca 0c 16 03 3b 3a ad 44 5b a7 73 d7 b2 
3c b1 f6 c2 29 a6 95 71 39 71 1f 0b 2f f1 36 80 
6e 2b 35 52 0c 48 ae c7 e5 b5 95 4b 2a 04 b2 9a 
52 16 52 24 46 e5 9c d7 53 f5 a7 47 7f a3 be 5a 
80 8a d5 62 c1 58 56 ac 0a fc be 73 57 a2 c5 6a 
ef ca f3 d3 e7 47 a8 9e 89 0f da 65 a3 d9 38 dd 
97 eb 24 d5 e3 31 8f db 22 e1 72 0b f9 80 41 fc 
b4 e6 82 6a 96 96 1c e0 9c 82 31 be a8 a9 15 3e 
b0 42 1e 90 de b2 84 c2 d2 ec 3b 46 4f 7b 4a 1f 
ca 0f 4e 34 2a ed 27 90 f8 86 d0 0f 7a 7d cd ce 
7c 6f af 61 44 02 7e 52 2f 42 b8 b2 80 a5 a9 9e 
0d 47 2d 61 ee 06 92 47 5b 06 aa f7 83 89 0a 3a 
c0 d1 6b 0c 9e 6c 4c db f7 cd 4d a0 1e 8b 30 6a 
dc 80 2c 25 1a c0 52 29 12 2a 83 8b 65 f0 11 2a 
89 45 af c1 98 82 ce 49 0a 2a de b6 d1 64 85 7e 
5e 44 45 88 75 ee 17 2b c8 9f 45 6a 53 df 1e ad 
e4 47 3e 62 40 90 c1 c1 78 6c 13 93 10 33 94 73 
84 a0 1d c9 b5 5d 0c a3 a4 43 2f f2 50 70 fa ab 
c7 52 e4 e0 f2 bd 5d 43 61 c1 b4 7a cd 28 cc ca 
bf b8 87 29 05 b6 4d 29 e1 6a c2 61 e8 60 be be 
77 6a de ff 43 a3 1a c9 1e a6 36 80 f0 93 c9 91 
8a 66 1b ae e6 c2 c9 3c b3 93 f8 03 23 c6 0d a5 
f1 0f ad ee 30 6f 67 c8 94 09 4b 79 35 9a 8c 0d 
35 90 b1 e2 c2 51 b0 81 c7 a4 26 4c ee 2e 75 32 
e6 d2 d4 8d 81 d6 5e 87 de 9a e1 32 fd 2f 1b 03 
ce da 6b 73 75 7e 71 21 45 27 01 1b ce 28 aa bd 
dd 26 50 fe 55 5d 5b 59 fd d6 69 53 52 b2 98 dd 
ce 93 b8 d9 08 45 0f 5c d3 58 f0 94 55 08 2a 2f 
df e5 36 8f 9d 3c 4c 2a c5 b8 98 b3 e7 05 fc 88 
34 24 bc d5 61 04 da 53 99 6b 90 32 33 c3 ca f0 
03 e9 4d bd cd c7 af b8 39 88 96 d5 19 60 16 5c 
44 fb ad 90 86 73 c0 99 6e ff 5e 8c 07 46 45 fe 
09 ae f3 42 32 e4 16 f1 eb 60 08 05 4e fb 08 6e 
a9 3c a2 86 75 49 f1 43 bd b4 fd e3 54 e4 1b 77 
7f 3d 93 aa 54 2f d7 03 79 50 81 84 c3 20 8f 71 
23 b1 91 64 13 7a 0c a8 9b 53 75 b4 c6 97 74 2a 
9e a7 b7 dc 5f 5f 79 72 a5 ea 33 7a c7 49 67 aa 
80 f0 fd 97 cf 24 97 35 2c cb 07 23 17 c0 a7 9a 
7f 2f 7c 4c c9 1c ec 76 22 3e ee 42 16 b2 48 d0 
05 c0 67 a1 e5 bc e6 73 f9 41 ae e4 05 15 fd 4a 
75 0d c6 94 df da e4 81 51 98 3d 73 1e fb f1 3b 
66 1f 83 d4 4d 17 03 e3 2b f3 6e d5 8a 0e 7b 37 
06 54 21 12 3a e5 77 fd 8e dd 63 26 0f 7a 66 09 
c3 a5 f5 40 4c 6f 9b 65 ab 99 47 e5 02 08 a7 3c 
8b db 20 3d 24 c5 ad 24 81 13 6e f6 92 51 23 e6 
da 02 83 bd 02 70 62 e0 00 96 54 7c 2c 8d 35 f5 
01 9f 72 13 24 00 36 35 d1 8e c5 27 7a 16 6f 70 
92 c9 82 a7 39 84 3e 1a 12 4b 48 40 da f8 58 71 
86 bb 54 77 58 64 d9 75 05 0c 78 e2 65 64 ec f8 
d0 98 c7 93 c0 41 10 05 eb 3c 4b 58 5f b7 5c 62 
b3 35 ad 19 33 93 2e 65 61 4d 1e f2 0b 32 07 80 
1f 01 15 d3 8e 32 cc e3 f5 33 1b 56 ba 43 aa e2 
50 95 e0 47 2f 4d 83 84 3d 1b 7b 29 91 2d 5d f1 
e6 c2 c4 fa ef 4f ff 93 b4 8d 5e 0b 07 b0 5e 7f 
70 ae 23 c5 8c c6 16 61 86 ab a8 d9 68 f7 27 63 
e2 57 49 ac 96 dd 2c 7f a7 a9 b9 9d 97 4e 7c c1 
41 94 2f 30 e3 83 01 52 64 e6 a0 ac a1 00 99 6a 
71 38 5e 9f 18 6a e7 b0 93 2f 75 6b 7a eb a5 17 
e9 41 2f 55 e6 a2 77 26 98 c0 73 15 32 00 4e 4e 
49 c2 d9 20 2b 44 c0 18 ea 81 e9 2e 8e 3f b2 ac 
7a 79 64 89 02 d9 4f 58 31 34 15 18 3c 2f b6 34 
cd bd 74 1d 78 20 93 14 52 51 6b 63 14 68 25 25 
7b 52 16 79 b2 1c 9c d6 02 bc d4 c4 a1 7d e7 a9 
78 b5 ba d1 5e 85 52 1b 21 cb 94 42 51 39 11 32 
42 4e eb ce db 86 37 d9 4c 94 e1 35 b7 d6 fb 5e 
33 a9 a0 39 94 f4 a3 fd c4 3e 6d 62 7b 04 1b 01 
89 77 e8 0f 46 89 42 9d 77 36 81 6a ed da 72 5e 
d6 2d 5b 78 f6 9b 90 07 6d d3 77 da e6 4d 35 98 
0f f3 2f 00 56 2e b3 3d 70 5d fc 38 8b d6 c0 5e 
23 68 73 02 a7 5e 6c f1 78 62 14 ca 48 92 da 22 
56 6f d4 4a 97 ba 9c 1f 73 15 a7 d3 24 ba 70 9e 
41 ab e0 84 94 1a e7 d4 18 d2 b1 e9 b8 63 7c 03 
72 86 98 17 55 ec e1 f1 bb 83 51 40 94 50 40 3b 
78 40 fa a3 7a 68 d3 56 32 28 97 58 59 c5 00 cc 
34 ee 4d 45 18 a6 a0 ee d0 40 66 d6 23 d5 62 cc 
f3 b3 f2 ad 61 8a 3c 23 f1 90 31 27 f0 c6 72 f5 
fd 19 43 b1 bf 65 31 85 af a1 83 4c 98 c5 46 5f 
63 b9 5c 79 53 ce 36 3c 5b b3 d7 81 57 9f 07 c2 
40 38 48 68 1e 6e ba ec 48 49 d2 76 48 0e 75 7d 
76 f9 9f 06 4f 5b fa 53 79 ab 7f 40 0a fb de dc 
32 f6 e3 a1 6f d4 90 63 4a 13 a2 d1 5c 8c 00 3f 
a3 aa 54 23 57 6e 53 7b fc 2d 34 45 25 bf ad b8 
3d 37 fc 65 99 87 0f 00 16 57 af 8a ef 74 28 79 
89 bc f3 ec fd 67 04 e3 70 fc ee 54 12 35 24 39 
c5 fa 45 54 97 bb 18 bc f6 59 50 22 68 52 76 83 
84 76 71 50 fe 54 ca cd ec 0a 74 78 47 55 f3 8e 
eb b9 a2 1e b4 86 68 b6 18 5e 3d ac 71 0f f0 ab 
5c 41 1a b5 05 8c 5b be ae ef 2b 32 e0 cc 32 5b 
1e d9 f0 9d 61 e5 16 ce 16 a8 bc f9 f3 4e c1 66 
14 c2 0e 3f aa 9d 2c 72 b2 3d 2c b0 dd a8 cf ec 
73 1e 1b d2 32 c9 02 3a 80 9b ee 81 48 6e 9f 13 
08 3b f9 0a 2b 70 f2 6c 49 e0 2f 3b fd e5 eb 5a 
0a a2 ef 91 55 b3 8a ea d5 83 30 32 de 80 79 24 
67 a9 9d 16 96 d0 1c 1b 14 6d b0 c7 09 a4 74 0c 
18 e3 be 9a 5d b1 de 19 48 89 be ba 6d a6 f7 c7 
0c 6b 0a 7f a7 4e 0b f5 63 2c 08 14 37 e6 d4 be 
70 f7 f5 7d ff a8 e2 62 1e 4d 4a 47 b2 f3 49 e4 
6f 11 79 9a 2a c9 5a d4 d3 00 ef c3 de 66 02 23 
38 34 35 72 70 82 36 f8 78 71 66 1e be e3 25 31 
a2 f8 e5 2c 39 ed bf 83 ba 4f ca 25 d0 1c 07 d7 
ad 6a d5 fc cc a5 cf 59 d4 52 1c b4 03 51 5c 30 
ab 94 cf 72 d8 ab ea 68 b1 ed 79 c4 01 08 ab 5b 
ec fb f6 d5 82 f1 25 f5 21 c3 1f 3f 23 27 bb c2 
3c 05 d0 a6 96 5a 16 dc 11 ee 9c 94 9d c4 57 4c 
45 99 5e 78 97 43 f9 55 18 4d 40 3f 56 dc a8 dd 
56 39 f5 c1 0d cf 56 be 71 cf ce 11 46 16 1e 40 
f6 71 62 b3 71 8e 97 0e 11 5e 57 6d 5e ed 4d b1 
df 25 1c aa 80 42 97 93 1d e2 f9 ad 6a cf 16 df 
c8 2a 80 77 73 87 68 6c 15 31 48 8b ea 30 32 dc 
5b 3b c7 ce 5a 04 95 01 86 91 52 f6 f4 a9 e8 b5 
49 d7 e3 c9 39 31 df 2e 3e 10 df 18 46 18 26 da 
c1 3e 17 2e 9e b6 d8 d0 f1 6a 59 1e 52 42 28 ed 
8e 1d c6 01 45 01 11 40 1b 48 bb 1f d4 d4 f4 cb 
5f f1 11 63 d2 c8 6e 6b 81 2b 45 64 4c aa 98 b6 
50 d9 28 63 06 73 20 24 c4 81 7d 9a 48 21 c3 58 
eb 6f bc 2b 21 15 1c 4a 0e bc f4 1f 9e eb 7f b8 
b7 ef 33 3a be 6a cd 9b ae f8 3d 1e 69 1b 05 28 
f3 a4 6f 38 09 78 06 64 57 a4 c1 e2 69 0e d2 34 
6e a3 e6 ee 58 0f 2d b3 ef d0 1a 37 78 9f ff 9e 
c9 39 f3 f2 b2 01 da 34 84 e4 2c e0 9c 2e 3f e6 
72 b4 41 77 16 db fa af 44 f9 fc 4e e9 a8 9b 41 
c8 78 41 59 fe b5 90 3b 02 c7 1e 78 fd 83 6e 0a 
35 ab b3 eb 47 76 ab b4 ce 47 91 c2 2d d8 32 fb 
cc f2 26 5a c5 97 40 48 57 83 b0 eb bd 30 68 25 
6f 12 82 27 30 43 d4 ac 19 52 84 10 0c 49 60 d8 
80 b1 91 10 41 fc 3d 43 e4 e3 7c 03 dc 06 77 93 
03 49 c0 06 f7 80 aa 43 cc 58 e5 d3 9e 01 f0 b9 
09 a7 51 1d 8c 95 b3 3f b9 91 7d 29 ac eb ee 11 
5a 81 29 19 68 e9 02 b9 34 29 8e 8e e8 42 d6 ca 
33 cc 4c 54 04 bd b2 4d 54 25 17 6e d2 00 c2 4d 
14 71 0d 68 2a 51 d1 26 86 dd 4b 55 0c ef 22 c2 
fc 2f 83 7e 75 e9 14 6e b9 3c aa 5b 22 20 6b a7 
3a f7 f6 9e 5e a2 18 3b 57 7b ee 32 e1 0a 24 6b 
5a 12 34 92 9c 81 4e a3 5b 16 8d e7 4b b0 e0 ce 
81 4f 9a 3e 13 36 0d 9e 94 72 3f 40 95 85 b0 63 
3f 38 94 2d 6f 99 2b 2e ca e0 40 dc ee 05 4e 40 
19 ee 32 dd a6 01 d8 7f cd df ce 36 a3 db b7 07 
d9 e3 fc 08 2c ed f3 23 e5 5d 52 19 83 23 3a ff 
d3 41 7f 67 d4 aa ef 60 a1 d2 20 a5 4b 8b 75 9b 
91 49 5e 76 b3 53 73 72 73 83 41 d5 64 ea 14 91 
f0 e7 f4 9b 0d 61 4f 46 b1 b1 dc 24 be c8 76 ff 
35 7f cf 84 f0 a9 cc 8d 7c 24 9a 7a b3 18 0b aa 
7b d5 2c c2 71 c0 eb aa 5f f9 b6 14 b4 94 a1 98 
9c 3d cc 4a 4a ea a4 c6 96 4f e6 1c e8 67 d0 78 
cf 79 77 8c c8 53 7c 14 39 d9 4d 81 4a 36 4f 4a 
bb fb 11 57 1b d8 5c f1 ff 2f b3 b9 af 5e a1 f5 
b5 00 37 c3 58 f4 04 86 37 c5 fb 90 00 f8 bc e3 
11 80 e4 7d d4 5f 88 b5 8b b2 5a a8 39 2f 60 3c 
a1 47 2b 13 50 52 1a 5c b5 2d 23 3e db 71 72 92 
ca c7 31 e6 94 ab 7d 52 e5 9e 7f 6a 94 2c 0b ec 
21 68 29 21 3b 1e fb b1 9b ca 80 2c da a6 a9 f4 
d4 12 ff af ac 91 62 ba 6a 5e 85 3a 4e 10 4a 8b 
49 38 50 c9 f3 a3 73 05 f1 ac 95 c2 5e cc af 2e 
d2 c5 5d d1 ba 05 95 23 4b 1b f3 b2 08 43 3c 23 
42 92 b1 73 d1 77 3b 9a 7f e1 c2 ab 24 e6 0c c6 
c7 bc 20 aa 6a 4b 8c 88 37 8b ac b2 a8 e0 5f d1 
be 9a 22 de 09 4a 82 49 6a 2b cf 70 0c ff 0f 0d 
f7 b9 a0 94 7f 6f 9b cf e5 ea ac ee fd 75 2c 46 
b7 cf 17 ce 01 62 e9 22 8f 80 da b1 9c 64 c9 e6 
fb 75 f4 a7 62 58 52 fb 31 d3 6a 26 4d 22 87 92 
a0 45 ed 99 af 51 23 74 40 c8 0c 9f b9 7f e3 cb 
1e e3 30 b9 70 ca d6 f7 20 a5 60 14 57 0e 08 5e 
8a 93 40 87 7c a1 6b 8e 51 32 65 c0 0f 82 a1 5f 
12 8d bf bb 77 a8 50 fb 5a fe 45 2f 1c 45 a0 48 
2a b2 0c f2 d2 9c 87 57 67 e2 00 2a 00 67 f9 6b 
b4 00 bd c3 37 44 d9 e3 89 81 d4 26 84 b2 3d 0a 
29 6a 97 85 2a f3 8e b9 30 4c 6e 6c b5 f5 f6 3b 
5c a6 69 ef fa a8 a9 83 18 2d 10 22 98 cd 16 c8 
2d 0b 70 17 05 1a 34 7f ec 9d f4 c9 12 98 42 34 
76 56 24 72 d9 fc 56 5f ae 11 01 4f 66 46 55 9e 
ff 51 dd be b3 0d f8 7c 9d 4e 13 2b a1 66 ff ff 
b4 e2 2c 21 b5 f3 a1 e7 8d c6 6e de 5a 20 3f da 
1a 32 4e d1 19 75 e4 75 cd 7d b5 70 74 7f a6 32 
60 de 79 f4 82 e3 7f 01 16 e9 ad 74 c1 f2 60 93 
73 cf ac ea e3 b5 0e 0a a3 32 f2 39 eb 6b 9a 57 
b3 32 f1 1b d1 73 6a a9 28 b5 0a 4c 89 f3 08 04 
d9 11 b3 fd 89 0f 5f ec 33 0b 13 e7 f2 65 dc de 
50 c7 4b 3d 58 ac 11 b9 43 23 76 8c fd df b5 38 
89 2e 04 7c b0 d2 8f 1e 98 17 0c fa 67 c5 c7 c7 
1f fc 85 49 96 36 32 cd bd d8 b9 44 ed 92 a6 21 
57 c2 93 f2 9a 60 7d a6 b1 31 c4 50 48 d8 7f e8 
a7 b8 c1 81 b3 ed d9 0b d2 23 dd 07 16 42 ba 46 
af 14 ab 38 b7 e8 da 05 32 f1 57 a7 4c dd 4b 1c 
ca 49 62 f6 0d 5f 2f 12 51 27 55 27 79 20 7e 9b 
92 7c 8b b2 eb 45 28 fc bb c5 94 e0 8a fc be 82 
3d 12 39 b0 31 a4 9c 6d e5 43 61 0f 61 1d d2 0f 
d3 84 c5 bb 0f f7 84 6d 0a 50 44 32 63 5c ba 1c 
18 02 3e 20 3e 7f b3 20 34 85 b6 ed c4 3a 65 58 
9d d9 fc e9 9d f2 a0 ec dd b6 4e 98 04 97 4f 4d 
91 a3 2f 14 a2 69 d0 2e c2 0d 51 a1 ef fa 7f 35 
fc e0 e6 36 b3 32 79 fe 4c f8 76 12 86 ff 24 e9 
40 14 e9 7f aa 32 0e 27 70 92 f9 6b 09 fb c6 5f 
b5 6b 88 0f 35 a8 05 a7 96 91 e3 e1 17 41 8e 7b 
92 58 75 60 86 9f ff a7 7c 86 69 41 bc 5e 7e ee 
d5 aa 85 18 24 8b 47 4b 8e a7 f1 a2 b4 36 3d ae 
50 98 96 05 85 3c 8b 9b 74 e8 1c c7 cd 95 d2 4a 
5b be 3d 26 92 f3 9a f2 4e df 35 82 5f 39 2c a5 
83 2c 37 0a 4f 14 82 3c 28 d5 ff 75 9a 44 b5 09 
4b 01 52 c2 f9 92 b3 11 12 c9 3f 1d 95 a0 4e 63 
7a 9c 97 3a 04 f4 e7 32 64 d3 80 ea 02 3f e7 2e 
71 29 0f 77 47 d3 bd e2 80 72 a8 93 8f 7f 80 95 
91 72 a2 3f 61 19 39 5c e1 42 9e 73 13 cf d3 46 
aa 9f b5 99 e1 bf 55 74 65 49 c5 da 1a 25 59 5d 
f3 ec c9 85 16 3b c6 2a 1a 2f 55 c4 a6 01 72 11 
80 03 cf 5d 49 cc f5 d8 37 ca c2 29 c4 d0 bd f2 
53 78 d3 6b 1a d3 e3 a1 03 6e 5d 35 59 97 55 82 
84 29 50 c4 0c 29 a2 6f b8 0e 1b b6 18 30 f7 bd 
67 79 43 28 fd 35 10 b8 bd c8 60 03 aa 3f 6a f2 
b5 77 bf 7c 0c b7 1e b3 af 55 c0 52 80 a2 54 cf 
de d1 5b e2 7d 0e e7 e8 99 07 68 40 83 75 2f 82 
06 5f cf cd a3 fe 2d 63 e1 ac 60 bf ab 70 bd 43 
59 8c ee 32 44 7d 00 cf b3 0c e2 71 39 87 cd 6d 
1f 02 8c 13 bc e4 97 ea 63 c4 36 bc cf 41 e8 bc 
eb 51 85 2b 8f 82 ae ae 70 a5 ec 31 a7 a2 57 e3 
3e ba ba 55 08 0b 99 00 b7 93 41 88 8c 0a 99 69 
ed 12 5a 45 fe 7b 54 a2 7c 36 af 76 27 37 d9 b8 
0d 35 8b 83 95 59 52 62 3c 5c ba d3 3b 36 d8 fa 
fe 1f b2 1b e1 93 9f 6e 3d c6 fa b3 7f c8 11 b6 
90 1e c7 f6 e6 dc 8b 7b f5 f6 7b 36 2c 3e a7 6c 
a6 38 33 11 9d 79 64 e4 02 fc 4b 66 10 6f 10 a2 
01 0f 07 4c d9 a0 02 90 3e 3a 1f 0b be a5 24 d5 
cf 47 a9 b7 e0 90 cc 4e 68 3f fd 5a fa be 63 a1 
d5 6a c9 86 56 9b 21 ee a4 6a 75 d1 5d cf 31 35 
b3 bc 4c 27 76 1e d6 ef 4b 90 69 8d ee 4f 64 55 
ef fe 02 7d 00 fe be f9 ae 94 2f 4b 80 04 8a 03 
f2 16 b7 96 80 dc c0 1e ee c6 d4 8a 3e 79 3b 78 
90 37 5f a8 5a 65 37 8f 64 61 c9 81 1a 7a 2b c7 
7e 54 d8 73 b7 6d e0 5c 3c ad 88 9b af 04 30 c6 
c0 87 89 a8 48 0c 7a 56 18 64 30 b2 4e 47 48 5b 
cf e2 18 45 a4 7b 04 e7 ac 7d 19 ec 1a ac d3 09 
d3 33 fc 9d 24 d3 89 10 dc 52 56 28 1f d6 4a 17 
4d ce 62 54 14 79 1d 57 34 ce 61 50 cd 5f f9 7c 
cd b9 18 73 c4 38 1f ad 81 43 33 55 d6 41 10 81 
67 fe 7c 05 a9 69 91 9f d3 9e 77 46 a2 48 b1 56 
49 ae f6 20 f9 1d 06 82 fd 1a c2 36 ac 7f a8 fd 
eb 76 1f c7 3a ea 0a f3 e7 7d 81 52 55 f8 7c 0d 
1e 4b 53 bc b5 a2 a0 38 08 53 55 1d a1 35 4e 06 
cd 85 2c d5 73 30 3c d5 0d 64 23 04 ab b5 4b f9 
f4 74 f4 23 27 77 15 43 64 af fe 59 34 bc 78 9a 
68 2e 04 21 a9 bc 49 38 24 e9 5c 3b 38 e7 b7 0a 
06 f8 6b cf 7e 42 8b dd 8e 6f 4d 9c 07 0e 45 f8 
ab b5 6b f9 e1 4e e7 a9 59 ef 4e ec 03 7e 17 98 
1c da d7 07 f5 0e 41 3a 3f 80 c7 b5 13 53 93 da 
55 ac 0f 53 ce 10 45 c2 78 3f 5f ec dd ee b0 28 
a6 a6 29 95 e3 fd 2e 49 cf c4 e9 23 db 2c c2 d2 
db d9 cc 18 35 46 87 66 ca fa d2 0b 75 0d a3 c5 
ae b3 e0 3f 0b 2b ee d2 10 40 4e d7 72 db 46 09 
88 c5 5d 1b 2f ff e7 7a 55 57 c3 48 a0 b2 e6 ec 
a0 e8 ac be 07 8a 56 b5 48 9a 9d 33 8d 08 28 66 
43 78 81 8d 6d ec b9 60 15 0e ac c6 ef 67 dd f4 
7f d1 a7 1d b2 55 da 33 39 be 81 2f 6a 50 47 06 
3c 73 27 1b 7a ae 56 31 60 cf fa d9 8a bc d5 ed 
24 6e 4a 73 7c d8 0d 5a 92 fc 04 a0 fb 71 06 df 
1e fb 57 6e 41 ff 95 72 27 32 e4 e6 94 ff 32 ac 
5c 6f 61 eb 00 c1 2f bf e4 ba c0 48 1f db b9 b6 
de 50 f6 98 ff 30 bf d1 c7 a5 88 95 7b 56 b7 e1 
da ae 2a 1f 2c 4b a9 eb 8a 5a 62 49 ac ae f2 bc 
c1 8b f8 cd 60 3e d5 68 9e bf df 9b 8c f0 73 39 
74 53 38 fb 4a f6 df fa b3 af 7c 8b bf 8c cc fd 
4e 7e f0 ee ca 05 2b e6 48 64 f4 6d b6 01 e6 7e 
be ce ba 5a bf e1 04 8b 17 e0 c3 d0 65 54 7a f0 
20 d5 8f 84 c4 05 a0 52 11 f6 73 1c 72 e0 76 83 
80 08 64 78 e7 f9 1e 5e f1 70 46 eb 2e 7f 07 13 
f9 60 d2 f6 f3 65 b1 ff c8 e1 0d d5 38 f7 9a 99 
96 9e 00 bb c4 94 4a ea e8 0f 05 5c 6b 08 46 68 
f7 7d ef a3 0b b1 29 27 dd 13 12 47 14 af 08 65 
54 0b 30 62 f1 1e a5 9c 1c c9 57 d8 fa 70 94 d6 
5a 72 c6 7f 8c b7 76 ef 81 7a 72 4a eb 6e 51 5d 
13 7e 3f 70 4b ec be a8 b5 d0 7f 39 b3 89 30 55 
2b 4e 9e 3d 03 2c 41 dc 9b ac 75 54 c0 50 1b 94 
9e 9a 74 9a ea 6f b7 3c bc e9 79 8b 9c d6 ed 4a 
f7 1b 51 2e 37 83 91 35 3e 5e 2e 24 b6 4f e7 18 
8d a7 41 9e e3 ea 95 30 38 43 4b 2c 48 de f6 f4 
e2 5e 71 13 06 3c df 4b c0 e5 8a 3e 77 0a 35 96 
65 38 36 9c 09 a9 5d b5 ce 54 8b 5a 7c ca 42 b7 
7e 3c 5e 64 c0 aa 5c 53 df 32 a9 ae 0f 1b dd 9d 
aa f7 99 7e d0 2c 32 32 03 ca d3 63 c7 e0 d2 5b 
bc 51 c0 c3 17 ff a4 53 b2 d2 96 0c c8 b9 a9 a0 
17 24 12 e3 2a 0b 63 ed 4d 19 67 e8 c8 94 0e 3f 
37 59 6e fc 19 66 03 65 f3 ce e4 35 f3 e2 24 62 
d3 b3 57 4f cc c0 bc 48 9b 0d 95 7d 5a a5 e3 b4 
8d d6 da 93 4f 2d 91 75 96 8d 74 6c 2a 0b 2e d0 
6c ca d2 16 97 15 47 96 49 be 99 f8 73 f5 72 ca 
b3 f1 fd 39 66 7e 4a ef fa 73 08 41 1a 94 9e 96 
0e 96 88 7f 46 eb 59 93 84 80 f5 ca 48 0b a4 20 
a1 e1 43 4c c0 82 a0 ef 99 5e e1 60 a2 39 3e 73 
d3 b8 88 cc da fd 29 97 4d 8c 1f 82 8c 09 37 aa 
78 dd 7e d5 c0 e6 84 cb 60 34 53 09 b5 aa fc 3d 
15 9f 5a c5 85 0e 0b 6b 95 b4 4a 93 01 0d 3a f4 
96 70 37 d4 a0 7c ea f9 47 da 58 51 2d 39 a4 74 
ed a7 18 13 6b 2f 98 1c 86 a6 cb be a4 87 1a 41 
a0 87 bf 51 8a 4a 18 4b 24 55 2a 92 ba 56 59 af 
67 74 fd 2b 62 48 4e b5 24 8c 44 06 3d ee 65 d7 
87 f3 b9 3b f2 91 fc 3b 97 9d bb b9 ba a6 9e fb 
4c 98 30 be 68 d4 dc e9 cf 3a 88 4d 05 47 f4 b8 
08 c9 30 01 ae 51 5d 6f 99 50 4c 87 4a db a5 10 
0a c1 f5 2e 9b 38 9e 1e 5d 91 55 68 11 06 a8 f5 
d5 be e1 39 96 d5 33 e8 0e 23 1c 8a 0f f9 f5 81 
bf d7 a0 2a 34 fe 1d 04 5d c1 1f e9 78 27 e7 f4 
65 69 de 72 94 05 b9 35 a6 6b d3 57 cb f9 1b d1 
68 55 14 fd 5b 24 fb d7 8a 2e 13 ed 6a b0 b8 c1 
87 2f c3 6f 8b b0 d1 82 2c 46 0d b2 ed 60 62 35 
c6 af ed f5 b8 70 3f 23 a3 3f 4d ed 7d c0 cb 66 
6c 9d 5e 0d ea 9b 4e ef bc 56 c4 60 89 0d 27 db 
da cb a7 6f dd 7f 83 6f 4e f3 d0 f0 e1 7f 1b 07 
d4 d9 d5 ec d6 43 4b aa ec cd f7 45 bc 34 e0 61 
b9 5c 74 ad 39 11 21 07 08 8a 9f e5 ab 12 8e 74 
c3 60 b0 b5 0c 3c 85 8a 21 73 8d a4 90 4d a4 bd 
52 1e b1 a7 37 18 94 9f 20 35 c7 36 15 e0 ae 53 
52 3b d0 c3 34 65 7c 73 39 e5 b3 65 e1 3f e4 a0 
bb df a0 04 cc ed 44 b2 e9 99 72 78 9f 6c 23 3e 
a5 55 86 3c ae e9 05 97 58 8d 9e 40 bd bd d8 12 
fe 41 da c7 40 ad e7 1a f2 2e 61 31 71 ef b3 5f 
e0 cb be 16 bd 1a a4 84 af 5f 01 2e 0c 13 5c b6 
44 fd 29 3e cc 80 37 99 25 1c c8 fc 02 87 49 1c 
47 59 6f 4a ae a0 1b c6 b9 ab 5c 16 1f 56 d2 90 
83 e7 af 54 bb 41 2c 84 c6 cb ca 88 e8 6c 1a a8 
ca 42 65 37 5e 4d 13 bf af 95 92 e3 20 fe e2 42 
f3 ce 6e f5 7c ed af 95 41 bd f2 96 92 b5 82 af 
6a 44 23 45 f4 eb 1c 05 a9 3f 1e cd 71 a0 73 c0 
84 e8 e1 61 53 38 7d db 76 b8 1c dc 8e bf fc bf 
4e ec d2 92 2c cf 0e 30 95 f2 62 53 0a 76 a6 92 
d8 59 d6 5a ea 8a 55 69 7e ef 3a 42 55 8c fb 3f 
11 91 e1 d9 11 e9 0a b6 19 40 3a f2 f8 cb 30 7a 
1f 91 2d 66 b2 f3 81 ff b8 1b 5f fc 0e 8f 5d b7 
18 84 2a 5c a0 92 9b af 60 e7 3b ed 96 a4 45 1c 
5b 9b 6e dd a2 fa e6 52 15 d9 d0 f1 d3 bf b4 dc 
8f cd cb ce eb 05 38 94 3d cd f5 0a ac 06 6a 76 
54 bf b5 b6 f0 5e ee e7 2b 64 07 dd 33 e9 d0 f6 
82 b1 5f c4 80 f0 37 40 bd 98 36 06 66 8c 22 bc 
9e 57 a5 0c 96 43 55 de 09 59 8a 52 c0 da 9c c6 
02 83 d3 fb f9 64 af 2c 8b 36 86 07 a4 42 3a 4b 
5e cb cf b3 6d 32 24 5f 96 93 ac ca 3c df 55 77 
b0 db 25 fa 7d f6 6c 85 c8 33 9d 80 7c bb 26 a9 
b0 cd e5 fa 27 9b 37 aa 3b f7 b9 71 ee b8 b7 35 
72 3d 5f 4b 31 c9 26 60 8b cb 4e 56 e2 71 81 7a 
70 60 9b 47 56 21 19 a8 39 83 2d 8b 34 1f 1a ce 
79 a8 79 54 03 00 f3 23 31 83 d8 21 0b 40 90 57 
59 68 de 32 e4 e1 e2 53 bb be ef a8 eb be ec 9a 
21 d2 4c 57 e8 71 30 12 48 8e 25 4f ec b8 d6 75 
a1 df 6c 49 fd 1b cc 31 20 18 ea 1a 9e 78 d6 f6 
ea 31 6c fe 50 f9 26 a9 27 9c 86 aa e4 ef 79 30 
44 38 3a da 3d fa 05 fd 69 4a 7e 03 89 72 01 d6 
b4 b5 23 74 ca 38 2b 19 64 a9 af 0f 70 6d 9e ae 
76 3c df 74 fc ca 5f ac 2a c5 81 e1 6e 79 12 60 
2e ab 85 4d 79 bb ed 12 af b6 73 b0 2e 07 83 39 
83 19 8b 9d 07 16 f5 54 98 ac 7d 74 d6 45 4b ea 
5d bc 28 32 86 a6 eb d8 49 c2 ae a7 af ca ab d7 
aa 43 ac 4c d3 53 8e e0 6e ae df fb 2a af a6 63 
8c d2 f8 66 1d 19 e4 c3 cb 47 84 58 6b d6 82 e3 
52 b6 c3 7a 71 d8 ea 49 92 23 f4 79 7b 42 14 52 
65 f8 18 0c de fb d5 40 5a 13 e7 03 05 e7 3f fc 
b6 1b 43 f6 05 07 3f 9c 4f 6e 80 1b 2c 5a d3 dd 
69 bd 18 8c 7f d3 cc 25 9b b8 47 6c d3 78 a0 27 
68 f2 1f e5 30 79 df 9c 16 44 32 6a 4f 51 b0 cf 
cd 23 cd aa dc 61 d4 24 32 3c c5 5e 7f 8e 59 40 
f7 11 6f e9 fd 9a 3d 3b 5c c2 20 cf 29 38 4e 3d 
94 05 86 63 c6 9e 1a 70 82 01 2b 55 33 45 37 9f 
62 94 be 18 38 be 53 c5 98 f2 29 66 10 45 27 a1 
ba b7 0a 14 96 4d 91 ad 46 44 14 a4 68 5e 2f a1 
a7 ba 5c 59 38 1e 94 a6 53 79 6e 12 d0 f3 f2 ea 
ef 17 e4 71 dd f2 24 e4 7b 29 1c 85 83 c6 ba 1d 
e2 b5 06 55 f3 d6 86 c3 ab 77 6f a2 42 d9 92 46 
f2 70 78 d5 9f 05 c4 82 cb 79 15 2f 19 0b 42 4f 
d6 c3 57 82 69 9e 7f 7a d3 ee 56 42 8b 0c 69 7b 
17 f4 58 14 8c 91 60 c1 e7 e6 10 c7 88 8c 91 c1 
44 82 b6 44 be 0f 29 0d 7c b9 6a 21 80 5d d6 a9 
97 e9 dd ed 05 8f 9c 61 28 ac fa 9a 5c a8 72 0d 
8f 4a 35 5a e3 76 b0 d2 04 89 81 6e cd ce f5 f6 
e3 5f 65 8d d1 34 12 41 2e 8b 06 cd 16 72 74 f2 
45 c9 e5 ac 72 2a 71 e1 c4 cb 89 f3 74 ab d8 1a 
94 d6 d6 f2 c3 5b 26 11 0f 64 4b 15 01 a4 6f f3 
4a e8 5e 67 d3 4b d4 02 c4 cd dc 37 2f 72 37 da 
0c 57 e1 e2 fd 64 1d f8 29 fd 2c 93 7f 6a 0d b2 
68 59 33 5c 3b cc 70 7c 6f 93 7e 69 43 0e d0 7d 
9a c7 a9 b0 0e b0 da a9 65 30 6f 0b 64 6a ac cf 
00 c7 49 75 51 57 08 f9 7a 70 26 14 7e 91 fc 42 
f8 16 a6 56 9d bc 15 26 6e 59 e7 92 f2 15 10 48 
ed 5e 7e 7f 1b d0 e5 09 21 b5 c2 07 0b f4 5c 8d 
e2 cf d3 e8 0b 15 b3 c6 91 c0 32 14 a0 e0 1a 54 
88 b3 e7 45 b1 a5 f6 4b 81 d2 5d 4e d7 8d a1 47 
ee 23 1c 20 23 1c 9c 60 56 8b 70 79 a9 74 a0 33 
c9 07 22 b2 b5 0e c1 0f 5e 62 ae c9 35 f5 2a b5 
77 07 b9 e6 56 e0 98 08 5e 0d 44 fe 24 2e a8 83 
c9 ae 1a 4f 20 22 9d 1a ec f4 08 63 ac 3d fa ec 
02 03 de 7b 11 2b 09 bd 63 3e 1f ae 0c 65 3f 7d 
41 3b 08 51 e2 86 93 4d 1d fe 68 38 dc b9 ff 83 
df 50 f5 35 6e 0c 84 77 c4 e2 1c 34 0b fe b9 a9 
e4 a9 d9 6f 07 56 84 fa 3e df 31 fd 30 6f 44 30 
18 28 94 10 c6 00 4f 95 e7 c8 65 21 21 b2 48 7c 
4a a8 47 50 d5 25 65 a6 c8 06 89 56 f8 0b f5 96 
89 8b d1 69 d0 8a 46 69 c4 1d 5a 5d 0b 05 a6 c0 
3b 9b 0f cb c7 26 bc db c3 51 97 28 be 99 c1 05 
5e b8 d1 bb 68 c6 52 60 9f de 68 c6 83 df 5f 87 
f7 0d d2 26 f2 f6 cb 10 68 0b 71 b1 9f 88 5e f7 
76 98 aa b5 71 9f 2d d2 b5 b2 f1 8f 57 9a 49 f4 
3d 7d d6 89 5f 3b 8d 2a c6 a2 70 0c 1c ec b5 8b 
5f 57 f7 4c 02 3e 8e cf c8 7c f4 00 8b c4 98 13 
df 3c a5 86 e2 a9 03 04 0d c8 d7 88 fb 5a 95 97 
69 5d 6f 5b 49 a0 e3 6c 34 89 4f 14 a5 bd 50 9e 
90 b3 3a 5c 5f b4 05 5c 1f ea ad b7 9f 39 1a 55 
d5 b6 88 80 d3 28 1d 2c 1f 07 4a 1c 80 e7 18 f6 
12 7a 67 7d 21 45 55 f0 af 35 87 dc c3 5f 4e a9 
de 50 ce 5d b2 6a e3 45 15 97 83 a1 d9 af 57 f8 
85 e0 4c 98 1e 41 d5 ad 3a 7a fb 56 dd f5 df 60 
ed 6d 5b 2a a1 b9 b8 e6 1c 8a 44 16 40 7a 5d 55 
49 89 fc c3 14 5d ff 35 3d a2 22 54 0f 22 95 ed 
b8 20 9b 71 80 aa 9f 01 36 44 86 f0 94 60 42 5e 
36 66 11 b7 8b 8a c1 92 9f a1 24 1d bb a9 6a 3a 
8f d2 4e 44 c6 be 22 11 34 30 d7 7b b4 0c 6f e2 
e9 b3 4f 2c 53 b9 be 2d a7 19 4d bf f0 ea b4 80 
1e 7a 85 7c b9 2e 7f 16 c1 60 05 5c 79 1e 62 dc 
10 50 de 4c c2 83 12 f2 5c 74 dd c8 d8 77 d6 71 
ee 49 43 b4 c5 f8 30 58 c6 4e 76 bc 1a f3 4a 84 
e8 f8 da 84 3f 11 60 ae a3 a7 10 15 c0 71 c3 02 
af 47 e8 4b 32 99 61 1d 66 3d 97 56 ca 4c 41 ee 
eb 13 f0 b9 c8 01 b3 cf d1 0d 1e 1b fc 44 c7 34 
f6 c7 58 7e 5f 8d 1c 35 17 c2 90 ee 1b 55 c4 4a 
80 19 f4 38 62 fc f0 ce 23 db 05 62 ab 29 e3 fc 
43 e9 81 3d 6d 16 5c 6c 84 74 15 f3 47 a5 40 19 
95 4b 50 11 c7 47 df 26 a7 d9 71 d7 0e b7 11 be 
3f 1d de 08 cc 62 8e 10 ee 76 2b b7 68 41 02 26 
09 8c 37 d1 fa eb b7 ff 2d 2f 27 5b 03 61 f7 37 
2a 68 72 34 91 0d ab 89 e4 47 eb 72 d0 fc 37 53 
71 71 56 eb f6 5c 66 d1 c3 f9 9a a4 0c fa ec 73 
35 3b 34 9c ab a2 c8 12 8b bc 5e 46 cf 19 09 8e 
54 5f 64 b7 57 18 2d 39 9a ba 54 58 f3 06 ca 31 
25 ab b6 83 f0 3b ba 66 0e 57 7f e2 ce 4f b8 f2 
4d da 5b 67 7e 28 d0 ed b8 87 31 bd 43 54 c9 84 
a2 6e c3 35 4a a8 7a df 83 38 a4 4c e0 0d 21 0b 
60 f7 c4 fc df 5d fd e6 d9 3a bc b5 4b ec 0e c4 
be 0d 1d 32 fb 22 c1 78 88 11 d9 41 53 d3 b2 b2 
f2 10 82 ca 3e 83 3e 5e f3 2f be 90 5e 45 48 29 
0d a7 b8 c6 a9 e6 04 47 30 43 bb 2e 39 57 69 f8 
38 9d 8c 0e 53 d3 f6 35 3e 11 3c 50 86 e6 e1 e9 
3a 57 38 b2 93 70 4b 50 86 1f db e0 ee 4e 3f b0 
31 82 a1 81 02 7c 5d a7 81 8b d8 fa 8a c8 c2 29 
d4 57 d4 7f 10 4c 71 b0 73 44 b5 20 43 33 3e d2 
a9 9d 79 20 9b c4 af 48 27 3b 9b c3 44 6d 6e d2 
b0 6f 28 56 3b 89 e4 90 0d a4 d7 a0 e8 f3 2e 02 
33 bd 26 58 ef c0 f6 a3 00 57 e9 1a 5e 1f ff 63 
f3 1f db d9 93 e7 e9 f9 be 23 c3 c9 ed c9 bd ad 
2b ad a3 35 ef 36 a2 f4 2f 27 59 c5 c3 e6 0f 24 
74 85 f1 f4 59 45 b5 96 d7 1d dd 07 e2 21 37 e3 
ff bb 19 d7 12 76 ef 17 66 2f 09 6d 82 21 24 2a 
8c 9c 60 26 cc 78 be 55 90 37 0c b2 22 85 c7 5c 
df 41 32 60 a8 05 da 4c fb 3a e8 b2 48 99 32 d2 
ce 7b 5e 94 e3 bd 31 e8 7b 35 28 00 8d c1 22 03 
8a 85 35 62 c4 3f 05 2f a6 fa 72 34 ac 2c 86 9a 
58 33 6a db a9 c9 5d f0 fc 9d 2c ba cd ed c3 a8 
c2 6d 66 f9 74 92 97 0a 16 57 b6 d2 43 23 32 1a 
52 c6 21 08 cc 95 5e ad 8c b8 96 79 ce 2a 4c 03 
6b be e3 65 e5 c2 50 90 1e 38 5b b5 7b 74 81 f4 
4a 4c 8c 30 e5 7f 34 c7 f8 d6 ec d4 2b 36 af 39 
1a 02 c8 94 47 fb 3e 44 67 3b 5e 01 48 08 b0 54 
72 b6 2b cc 2f 14 62 b2 ba 1b 0e 66 ba a4 52 cb 
f7 25 22 1c 00 48 94 a7 e6 be cc c4 f0 82 35 05 
23 13 ee 8e d8 32 81 b3 88 65 37 2e fa 0c 92 70 
d7 56 80 0f e2 e0 73 20 b6 cb e5 9e e3 56 6e ce 
49 20 a7 53 f7 68 10 69 2c 03 93 0d 08 38 52 68 
e9 9e 88 b7 bd 05 f9 00 e4 e8 8d 29 6e d0 d7 fe 
e0 21 ef 15 8b 6d 9e 92 a8 57 79 97 b1 ab 3f 62 
ce 0e 6e b9 a1 c9 10 19 af 47 b9 1f 71 09 63 32 
98 64 b4 9f a6 1f 01 8d 41 a6 30 6a ae 62 4a e5 
13 e7 e3 a2 7a a7 59 7c 7b 13 ea 3d 57 5a 16 57 
72 5f 75 e8 c1 d2 d8 bb ef 0e 0a 68 ec 28 4c 8c 
38 71 53 44 8b c6 e8 1a 43 4c 86 3f 09 c4 d0 b0 
cb 34 af 83 fc 5a be 28 98 cd 6f 9a b8 48 21 91 
86 25 99 8d 98 e0 28 3a 0f cb 11 6b a3 45 d4 fb 
74 03 c2 64 59 0a 21 74 8b 56 e1 8a d2 93 f3 a6 
ac 99 09 9a 4b 4e 81 97 40 6e c4 1e b8 ce 7a e7 
af 2e 81 c8 65 40 b5 74 bb 99 8e 1c a3 85 55 70 
31 ed 1d f8 e9 3a ce 47 c3 8a 9d b8 a7 35 7e 6c 
06 91 c0 6b 3e 03 fa 4e 29 f4 19 77 c0 81 13 93 
d6 cd c2 92 56 0e 92 50 b3 21 bb c9 54 44 79 7a 
b6 66 c6 d2 f7 82 fd 76 47 a2 a7 a9 6b 75 2d 0c 
d1 da 33 7e cf 32 7e 0b af 33 28 c6 de 3e f1 bd 
81 dd fd 9c a2 fd ea ca 65 78 ad aa 90 1a ad 4a 
aa 55 75 e5 ad 01 69 8c d4 a4 5e b2 ba 7e 5f 95 
59 52 0f 3c 80 1a 9d 2c 17 24 7f 93 a4 b9 86 7b 
47 c2 19 8c 9b 5c 37 58 6d b8 33 e5 08 71 fd f1 
4c 58 4b 1d 34 3b 58 aa 55 5a 1e 72 90 7e 6c b3 
61 5d 20 48 79 5d 02 d8 5b 11 a9 6d c1 2d 79 39 
0c 6e f5 c8 dc 2d 60 b1 7b 30 03 dd 9d 41 5b 58 
bf 71 83 d3 b9 e1 8c 80 ed 3e 05 5d b4 e6 da c3 
d2 a9 29 fb 38 58 65 a7 c3 cb 31 6c 0a ef 6a ae 
48 1b 1f 10 8e 88 40 77 11 58 ba a2 53 b0 cf bc 
a5 f6 c2 7e f7 6c cd a8 ff 6c 33 80 bc 91 45 7b 
90 07 ef a2 09 c1 59 b2 e8 89 08 98 2e 9d 60 10 
91 c0 f1 cb 9b 05 e4 78 3c 3e e3 c2 f8 bc ad 4f 
12 00 45 e2 0c 1c fe a2 f0 0b a5 b0 f6 c8 89 94 
00 23 92 89 cf ac 3b 7b 7c be 45 b2 d6 4f 23 f2 
0a e0 34 0d ba 1e ce 8c 40 a1 8e cf 31 f5 ae fe 
5b ae 99 91 6e 72 94 76 63 a9 28 d7 f3 45 63 41 
f4 67 8b 61 10 70 fd 39 6f ab 20 bc c9 be 34 35 
7c 90 d8 70 c7 02 0f a8 a6 56 42 a8 0b 46 85 aa 
87 ce 98 79 3f e2 c2 52 d9 6c d1 82 7a c3 7b 71 
3e 1a f2 ed c5 c3 83 90 1b 47 b0 3e 18 b5 c7 9e 
7d c7 7e aa f9 f8 a2 63 1a 78 e9 8b f3 51 4b c1 
e6 66 06 27 63 24 62 bb 7a 36 a2 f3 c8 db 32 68 
76 17 18 6b 77 ab fa 78 14 2c bb c9 33 66 2c 7c 
17 ec 0d 52 e9 bd ea 35 ba 95 df 5f b3 06 9e 3e 
c5 6e db 9b 30 67 6c 03 8b 70 3d 6d ed fa ae 7d 
58 cf fc fa d3 06 2c bb 84 70 d5 26 88 b6 84 7a 
a5 f3 09 63 0c 6c 60 68 9d 36 64 8d ea 47 99 96 
35 92 74 eb d4 6d 35 fe 3f 08 7a 15 8c 31 d4 5b 
96 2f 1c db 53 65 f7 d5 3e 91 53 a2 5b c3 f3 c8 
15 a8 87 2f 33 74 bb 3d 2a 9b b4 e8 77 89 cf 1c 
b1 49 6f c8 24 68 81 de 32 b8 87 5e 98 97 6d b0 
89 a2 bb 2f 81 85 b8 74 85 7d c7 ed da e3 7a 6a 
2f 8c 7f 37 3e 2a 9c d8 5d b9 d1 bc 51 10 fb 81 
95 ab 1c 91 3e 42 68 65 db 3c a0 3d bd 01 af 92 
ec 76 21 fd 07 27 6d db 66 76 89 f6 89 bb 8f 2f 
1a 08 26 76 71 0a cd ba 93 f3 b2 c8 12 5f e9 c2 
f5 21 26 af ae e2 ed 20 62 a4 71 4a 68 f4 46 06 
31 b2 00 95 55 62 34 24 40 88 12 ac 16 40 09 15 
37 5a 58 77 d4 64 79 e8 9a 30 b1 c3 04 c8 57 89 
ac 23 e8 9f 7e 55 64 42 ed 5b 83 03 e9 aa 65 93 
a7 bc 90 82 bd 95 0e 39 94 c3 b2 a3 cd c5 a8 dc 
cd 7c e7 2c 34 7e f8 3e e2 63 ba 4a da 92 4f eb 
7a ef db bd 19 61 ad 69 06 ea 33 cc 6d 6a 89 24 
7b ff e9 ad 38 b6 0f 68 12 b5 75 51 ea 96 16 fb 
b6 ac 78 04 6b 4d 35 5c 58 95 4f f8 46 13 81 1f 
1b b7 19 f6 c0 d0 9d 96 77 bc 59 75 7b 66 38 07 
f8 95 bb e9 5c 7a db 03 60 c9 6f 42 dc a5 80 89 
3b 1f e4 a8 d5 8b 94 16 24 06 57 ff 98 d3 6d b9 
d0 52 d1 22 0a de 8f 79 70 65 75 bc 10 41 33 01 
4a f4 1b d3 87 9c 20 9d ca 4a 4a cd 17 43 94 cb 
9f e4 8b 05 98 85 7e e9 e9 1d bc 8f 64 33 9c 69 
76 f3 4a 72 39 07 5c 7a e7 79 8c 19 cb 47 6f 0b 
57 dd 5d 8d 16 c4 56 bc 1b f7 1c 80 ba c5 1c e0 
ab bf 43 6b f0 d5 11 cb 43 6a d4 e6 99 00 79 61 
83 cd 90 45 2b 8b 9d ed ef 9d b0 45 58 fa e6 a3 
63 4e c4 ea 2c 81 4c 04 df 27 07 4a a4 29 e8 a4 
6c 5f 61 3a ae 1b e8 fd a3 4e f5 14 c9 c1 0e a6 
78 dc ec a6 cc fd 2a 66 4c 34 20 3e d6 8a 57 7b 
13 01 b4 aa fd 8d 53 56 da c0 f4 d9 d1 3a b6 27 
6a 33 a1 99 f9 14 cd de 47 93 89 43 05 1c 13 05 
15 10 c9 5c 3b 1c f6 9e e9 0a c4 27 44 d7 cb 58 
a0 80 94 4e c2 aa 74 b1 67 aa 9e a5 66 5f 15 60 
0a 4e 83 9e 3c 64 b8 4b 4b 81 c5 73 2d 0e 10 bc 
1e 3e 0e e0 cd d6 be 70 98 d3 bc b7 dd 4e 2d 83 
09 41 c0 ba 56 fe a8 4d e6 43 90 b8 f5 21 65 59 
d7 89 c1 ad 9e 4e 90 b1 2b 73 0c cc 41 c8 57 6b 
d8 d1 44 b6 41 eb e6 ec 7d fa de 7d 7a 1c ba 46 
26 ec 73 c8 cb c5 75 c2 3e 04 73 50 b4 fd d9 ec 
15 06 6b 28 06 4c 7d 86 43 61 82 da 0d 8e f2 c1 
63 cb e2 d1 1d aa cc ef bd bf 0a ab 20 6f a6 fc 
76 a6 f7 e7 6a fb 1c c8 92 3a 10 bc 42 c5 e6 79 
ba cf 27 e1 77 b1 f9 88 fe ed 8b ec 50 8d 2c f9 
a2 6d 27 25 02 50 3d d0 2b 94 6c 3a df 34 f1 31 
2b 74 de 9c c9 f4 0d e7 7c e7 31 61 0a c8 5f 35 
6d b7 3c 93 5a 94 b1 29 ca dc ae 30 a5 37 d2 93 
dc 66 6b 4c a3 7b 9c 12 62 f2 27 17 7a 44 0d 4c 
5c 63 d8 5f 1a 04 5b b8 b7 d5 af f3 83 a1 a3 bc 
d6 ff bf ad 4b 09 f1 fd 13 1c 55 57 b4 d6 8a 04 
42 3f 98 0c a8 f1 d2 6b 76 c0 4d 64 b2 c8 08 2c 
87 f5 f0 d0 64 86 8c d7 be 62 ca 06 ca 9c 78 12 
e2 99 b2 e6 d7 2f df e0 76 3e e7 8f bc 97 0e d6 
25 51 b8 2c 6f 9d f0 ea 92 58 c8 96 f9 6f 57 b4 
72 63 c7 b0 d2 a1 b6 9c 92 33 db 11 6f 7e 8d 53 
88 ad 9f f1 33 24 c3 73 30 d9 a5 e0 6b c7 d0 bd 
bf 88 79 2e 55 b8 c1 f0 1c 25 6a 2a 96 07 54 e4 
db 5f 9a ac 78 95 a9 49 b9 f4 62 20 d4 42 bf 0f 
5f 1c 85 a9 69 21 44 65 d5 b1 fa 89 ca 97 67 c0 
15 d1 ea 95 7e e0 cd 10 4f 9d 68 14 c7 af 1a 5b 
ec f2 77 e5 fe ed 11 a9 99 e1 c0 f3 a6 8b 9e 4a 
4a 1a ed 2a 0e 23 b8 ad 37 68 17 42 49 42 aa a2 
fd 09 3e 9b 2c 40 69 a1 8c 06 87 ea b7 83 c8 80 
11 b7 d7 04 2b 3c 79 0d ff af ef 68 90 3e 7e 8d 
e5 1d e7 9e dd db 96 21 8b 9c e2 60 4e 06 e1 1e 
5f 2f 2e 98 7d 85 c3 b9 94 c1 20 a8 26 35 bf 34 
2a 6c dc 8a 13 53 34 2e 44 4d 8d ff 21 2c 86 77 
62 09 d8 53 95 9b 79 ed ea ad 40 3b cb 84 54 f4 
68 e4 bd 3f 77 bc ac f9 ad c9 55 1c 90 ec ad af 
41 0f 01 86 9d e4 e5 79 0d 92 c3 36 0b 29 4c a9 
c0 f5 c9 09 96 b4 ed 4a 47 e1 cd 55 33 ff a2 c2 
1d de ea 33 e6 79 68 d3 0d 84 41 d4 7c f1 08 06 
d4 6b 8b 29 03 88 3a 75 d6 10 dd c5 cd 7a f5 01 
26 f6 a6 90 16 a9 00 4d 23 5e 5f fe 05 72 dd 53 
d6 6f a2 88 eb 8e fb e3 5a 5c 49 8c 8b d5 a8 b6 
d5 0c 06 55 9b 27 e1 83 53 e3 66 61 f5 17 13 b3 
d1 25 03 31 d2 72 fb b1 ad 9f 67 e8 98 ac d3 97 
fb 6c 4f 40 21 fb ae 89 cc 84 28 2f c3 45 91 85 
cf 5a ee 5d ee 70 fd 5c ac 6a 78 8f 53 cb 61 73 
ec 17 d0 c9 d4 52 7d b7 ef 0a d7 5a 8c 82 22 d0 
cd 62 44 d8 26 30 73 a5 a0 74 da 04 fc 34 5c cf 
47 60 a5 63 12 49 a1 48 e1 85 05 a4 96 a9 5d b5 
57 a4 cd 02 d5 71 c2 d5 45 4e 00 13 e3 d4 3c 99 
61 d8 44 c8 73 14 a3 ef 9d 92 71 33 98 c4 a3 4e 
42 55 81 00 1d a6 6e cb 6e aa a7 e5 b0 63 58 96 
9d 53 83 5d 53 da d1 75 91 ce 35 45 3c 8c 2e 21 
ea 00 22 93 18 56 4b 9c 6f a3 15 4f 5a 24 41 31 
af bb 6a d2 c0 47 37 6d d3 78 ae 05 e9 64 a8 77 
0a 4b 54 6a 2b 76 89 10 11 eb 65 3f f6 2a 9d a8 
6b e4 b7 34 69 b1 81 5e d0 1f a9 c4 43 92 fe 28 
78 a4 53 c4 a6 23 2d 9b 30 14 67 cb 10 60 cc b0 
3b e0 4e 68 42 6f 9d 7c 0a 40 d7 6b 93 a1 79 61 
d8 4b 72 78 d4 b9 1b 65 a3 dd e9 0a 7f 01 17 42 
20 a2 88 19 ce 6c 9c 78 95 cf e7 3e af 89 9a 1a 
9f 96 e4 f2 56 20 50 4e 89 f7 e7 ee ee fd 95 4f 
79 e3 dd c2 a4 d3 7c 90 49 45 ff 0e 90 76 b5 63 
eb 38 db 25 e1 be 90 01 96 f2 74 6f 7c 8f 75 7a 
0e e5 93 18 97 d5 d6 b0 02 f9 10 ab 3c 37 e5 9b 
f1 c8 6f f5 01 ac 62 02 3c 71 f0 a4 c0 d1 f2 24 
ec 86 22 1e d2 da b8 a7 d7 20 26 c6 93 10 c5 3c 
65 e5 e1 93 d5 51 2e d8 e2 58 38 8c e1 fa fa 78 
eb 67 55 c5 96 c3 d8 3e d7 4d 48 da 6e ac 21 e3 
22 4b ec 3b 1c af 64 b0 00 dd 18 2a 39 b8 ab 47 
05 7a 90 a7 aa 8a 5f af f2 c0 db db c8 80 f4 70 
5c 36 3f 88 64 e4 aa a8 1c e4 1e 63 84 1b 11 28 
21 13 72 35 11 1a bd 5c be 49 f1 c0 73 4c 88 48 
df 33 f3 a3 ef 21 1a 07 c7 e7 23 98 b5 30 bd a1 
e1 23 7a 2a 32 28 fd 31 d0 32 81 f9 0a f2 ec 2a 
b5 33 5d 1d ab d8 ca 81 b4 8e 64 46 84 7f e3 b9 
f3 5a 19 01 28 cf b9 f7 8c bc 5a 02 6e 81 25 47 
59 e7 6f b5 61 30 72 73 6e 06 99 3e 47 d9 b8 0f 
84 02 03 42 2c 20 88 04 d3 69 b3 e5 69 82 e0 2e 
9f 59 4b 16 84 57 84 66 81 17 2d ea 8e 6b b4 8d 
b7 62 34 ad aa 8a d3 ca d5 9c fb 71 c8 38 e1 d3 
b1 e3 71 9e 5f 98 0e 4d 0b 9d 01 d9 7d 50 e3 a6 
96 05 50 1f 39 16 61 7b c0 22 48 ef ff 27 ab 09 
80 8b af 12 65 de fd 87 cb 95 d0 8a 8f 27 29 4f 
19 24 62 d4 10 de 56 f4 ce 91 f1 43 89 1e 95 b7 
de 47 39 d7 b4 93 27 de 26 66 12 17 8d 1a 8e 0b 
03 21 d0 bc d1 42 52 ab d9 44 6e 60 97 15 97 d0 
9d 0d 29 f0 f5 70 d3 e6 73 dd 12 80 74 8f f7 31 
66 e0 cf a9 0b 4e 82 07 5a 3c 05 94 d0 93 f9 89 
93 bd 55 49 71 3f 80 1e 97 8f c1 9e 18 41 6e 6f 
12 57 43 b2 d1 95 5c 6a 06 7b 97 8f 87 e9 a2 4e 
e1 a2 3b 5b f1 59 1a 46 83 07 ac 60 a7 c8 3b d2 
d1 ab dc fd e5 8e 55 83 e8 ec a7 ee c7 08 82 71 
cc 5c d6 9e 81 e6 3a d8 0a 58 4c 4e b4 2f 27 e7 
8e d1 78 9a b2 69 2b 41 5b e1 9e b1 58 1f c8 da 
c0 fb 19 7e 3d d0 81 5d 80 6c a6 1b 9d 98 9b 87 
18 7b cb f5 ec 7f d6 67 ff 40 dd 6b 30 2c d1 0e 
81 1b 26 25 9e 16 e6 77 72 04 11 84 5f d4 0a da 
02 62 01 a3 38 56 5c 67 0e 61 70 37 9d 1f 9b 7c 
bc f3 8a 7e e7 07 f1 fa 6b e8 b1 2b bc d9 fa 69 
c6 b9 44 95 11 6a d8 88 2c ec 60 31 57 85 42 0e 
30 cc 80 82 13 4a 06 6b d3 a2 51 18 98 66 64 c6 
2a cf 41 89 fc 89 b6 f2 82 3c 24 16 e5 0d 12 65 
03 3e 46 cb 21 75 9c 49 ab fa 15 7e 90 ca eb 98 
b6 b4 b1 40 41 68 95 90 0d a2 f4 82 94 8b a4 22 
6f a1 b7 9a 96 e2 05 7c a5 25 85 1c c8 f3 90 b2 
8c df 01 94 02 19 ea 68 85 67 6a 39 07 95 99 1e 
dd e4 8a c8 95 43 d5 16 75 fc 6a e4 ad 85 b0 e4 
31 5b 2d b8 99 71 14 14 66 92 de 87 f0 f5 45 3a 
2f 62 fa e9 0f 16 9b 45 f5 3d 25 2a be 1d 08 99 
16 9c 6c 75 7e 30 d7 0b 17 ac 3d ae a7 42 e2 f0 
8b eb 3a 28 e3 32 7c f5 5b 80 1f cd ac d0 77 17 
cc 3a c9 44 8a 2a b0 59 a7 50 c7 28 08 ae 6e 39 
82 60 16 0d 75 6d 87 9d 8f 96 1d 3b bd e9 b0 fd 
c2 00 06 1b dc 3c 48 1e 28 49 2f 3b c8 12 07 a2 
93 20 31 3d 9d bc 1c a7 47 d1 27 50 81 3d e5 c4 
e7 3a 12 13 7a 05 9a 6f a7 71 56 73 f5 82 f3 7f 
b5 ed 20 5d 5d 10 5f a2 ec 6e 0f 4b 4d 9a 42 ea 
bb ca d7 c1 0d e3 d2 cb ef 15 ac cc 0a 7b f6 f4 
7f 3e 70 f6 d1 44 2c 84 60 ae 41 ec d2 50 a3 d3 
b5 07 66 96 a1 bc d6 87 bc a9 28 ff 0a cf a3 2c 
72 c6 b9 3d a9 5e ea 72 30 44 6b bf a0 33 b7 1c 
4b cb ca 38 34 bb 3f 2d 9c 74 96 23 2b e4 34 ff 
bb dd 0a 92 f6 93 21 35 e7 9d d8 18 8b 72 1d 61 
d7 f8 aa cc 94 93 7c c3 ee 21 cd f1 53 1a 1d 23 
96 e9 4a a7 ec 00 f9 76 be d7 ce 86 56 ce 54 d0 
33 bc e4 f6 85 fa 8b 50 19 75 f2 98 58 b4 7e 5e 
41 b8 2b 30 43 fd 67 f0 33 ac 6a 22 76 ce c5 44 
2a d3 b9 7e 2b 30 86 49 8d 1e 2b db 2e 6e 5d 9d 
fe af 45 50 9a b2 d1 53 2f 7f 17 28 26 77 f2 b4 
bc 65 91 ed 23 c5 72 cf 9b ed 07 e0 b2 d5 2e fe 
5f df 9c 85 68 50 87 11 ca ce a7 01 35 ba df c1 
a1 d4 71 3e 58 df cb e3 b0 04 7b 90 4f 9e c9 c8 
6b 90 b9 7d db 9b 1b bd 72 99 3f 82 f0 c0 41 5d 
d9 40 a7 90 79 fe 95 78 79 c1 3b b8 5d 6f e0 a9 
28 8e 86 1d 8a d0 d9 60 bf 26 59 a1 60 2b 5b 70 
a0 a2 84 1e 10 c5 e3 dd a1 54 e1 3e f0 31 62 84 
cc df 52 a9 db de b1 48 f1 d8 88 e4 94 f8 0a 52 
be b1 d5 c8 34 aa f7 75 a1 aa 73 07 43 de 26 a1 
27 53 16 2c ae 71 32 3e 57 a3 24 91 e3 e3 d2 80 
67 a6 70 0e af fd 14 2f 5c 1b 27 b3 29 cd 66 93 
af 59 ff 85 3f 74 d6 47 31 da b5 64 f3 d4 98 47 
c4 c7 17 e2 51 55 f6 84 94 7f f3 a7 bc b7 30 a4 
61 55 13 79 5c 98 27 64 64 1b be 26 83 b9 fd fc 
53 c6 5c 57 e5 e4 e2 30 59 37 ea 4d 9e 7c ff 81 
ba 9d ba 1f bf bd 94 61 15 94 29 91 d6 51 92 71 
34 10 03 08 b6 4c e8 7f 07 90 3b 3d 6c 3d 9b 5c 
ce 55 a5 0a 22 05 a7 b4 22 a4 dd 23 7c cf 43 1e 
c5 76 81 f3 c4 6e 86 8e 8f fa 04 0b 25 bd e0 17 
58 7b aa 13 69 f6 f5 33 69 19 7e 8b 4f 17 09 5b 
d8 60 4e ac cc c3 43 33 2a 0e e8 de 93 e6 0d d4 
73 8f b3 20 88 8d ff 90 dd 57 6b 83 97 87 43 05 
51 67 d7 13 8b 0f d7 68 fe 28 ab f2 59 95 1d 07 
e8 b4 66 a1 84 d7 f8 08 b4 99 94 93 0f 8d 25 6d 
b4 9f 55 b0 76 94 08 2c 1b 79 91 ec 3d b4 ce 06 
57 53 8f f5 38 2b 1c c6 b9 d1 e2 c5 b5 e3 6a ce 
cc 95 25 cf 07 5a 1e 91 88 53 e8 c4 80 1c 18 3b 
61 92 c5 5f c2 9b f4 bb cd 60 53 7e 36 e3 bb 5f 
5a 9a 87 d9 3c f1 e8 dd 1c 5a c1 d0 d0 6a ff 25 
29 a0 22 07 b5 88 c3 af d0 71 e4 c3 b9 17 5e c8 
63 34 46 3a 8a 82 f3 94 c4 1f 8f 12 27 25 a1 9c 
b7 96 dc 9a c8 2c 2d ac ee cf 5c e2 97 7e e5 4b 
60 93 a3 5f c4 04 ea 50 e7 14 9e 4a 9e 0f bd 0e 
31 d4 7f 8b bd 24 ef 7d 61 08 7e 64 ba ac 2b 2a 
5e 4d 3d df f8 76 64 1f 6d ef f1 1b cb 05 8f 81 
be f0 5a 3f 8b b7 c1 7e f2 f0 ba e9 19 5a e9 ab 
43 e7 42 fe 8b 1b 5b e7 c5 42 ae 7b a0 34 e5 64 
b2 42 de 77 9c 02 7a ba dc 62 33 82 97 30 a9 87 
6d 23 91 42 fc ec ab 11 df 95 6a a7 09 40 1d bc 
16 ee e0 5c 2d 91 93 21 39 2e d1 31 b7 1c ee b6 
f1 68 d1 d8 c1 ed 73 34 c6 cc 50 99 47 04 5c 2e 
d7 30 06 9d fd 34 6e cc 01 9e ff b5 7a aa ca f7 
4f 22 1f a0 77 0e eb 72 2e 64 2e 11 46 4c 63 c9 
ad 7f 81 c0 6d 24 e5 7a ed 49 4f 21 91 f6 af f8 
04 b5 44 c3 64 80 62 5a ac 7f 11 1f d5 07 c2 0e 
44 59 c9 78 4d 40 b1 c9 34 16 74 5a 78 02 f7 15 
b1 b5 9d 6f 7a a2 04 78 63 b8 08 17 29 49 de 9c 
17 11 01 d1 70 ac 34 04 7f 48 19 bc 8d ab fe ce 
8a db e6 90 1b 60 50 b7 c3 b6 e1 91 05 fa 14 72 
ba 06 1e f1 97 f7 4f 76 9c e5 a9 58 2a 6b 5b cb 
2c 73 b4 92 ec d1 2d 73 29 03 3f 3d 6b e9 50 51 
9a 9b aa 23 b2 b2 d8 d6 5c d2 37 1e f2 3e 27 77 
bf 55 8a 57 37 30 41 20 e4 ec 66 f0 66 8e 6e c8 
48 d3 f5 08 93 d9 1b 1a 01 29 3c 98 2e 4b 2d 68 
80 75 1d b9 7a 66 b4 8d 51 4a a9 ae 3f 9b 34 c0 
56 8a 33 be 48 b9 e1 77 35 b0 fa 33 ea 77 33 02 
cc d4 3a 3c 40 d5 71 9c 47 f8 b0 78 df 09 ae 05 
ec e8 1c ec 52 c3 3d 11 1d 85 c7 53 14 90 ab dd 
68 22 ee c2 07 f0 7f fc e9 7a ca 04 e5 85 15 aa 
                            ccxOUT1 == ccxOUT0;

                            qed_consistent == 0);


cover_test_MISR_2 : cover property (
                            @(posedge clk)
                            (MISR_reset == 1)
                            ##124
                            MISRccxIN0 == 101'h
                            MISRccxIN1 == 101'h
                            MISRccxIN2 == 101'h
                            MISRccxIN3 == 101'h
                            MISRccxIN4 == 101'h
                            MISRccxIN5 == 101'h
                            MISRccxIN6 == 101'h
                            MISRccxIN7 == 101'h
                            MISRccxOUT0 == 93'h
                            MISRccxOUT1 == 93'h
                            MISRccxOUT2 == 93'h
                            MISRccxOUT3 == 93'h
                            MISRccxOUT4 == 93'h
                            MISRccxOUT5 == 93'h
                            MISRccxOUT6 == 93'h
                            MISRccxOUT7 == 93'h
                            qed_consistent == 0);


*/

endmodule // spc_checker
