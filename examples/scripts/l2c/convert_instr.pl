// Convert sparc $instructions
#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;

   my $instruction;
      
   // $instruction format fields, extracted from sparcv9 page 64
   my op;
   my op2;
   my op3;
   my disp30;
   my rd;
   my imm22;
   my a;
   my cond_format2;
   my disp22;
   my cc1_format2;
   my cc0_format2;
   my p;
   my disp19;
   my rcond_format2;
   my d16hi;
   my rs1;
   my d16lo;
   my i;
   my rs2;
   my simm13;
   my rcond_format3;
   my simm10;
   my cmask;
   my mmask;
   my imm_asi;
   my x;
   my shcnt32;
   my shcnt64;
   my opf;
   my cc1_format3;
   my cc0_format3;
   my fnc;
   my cc1_format4;
   my cc0_format4;
   my simm11;
   my cc2;
   my cond_format4_1;;
   my rcond_format4;;
   my opf_low_5;
   my opf_low_6;
   my cond_format4_2;
   my sw_trap;


   // format 3 
   //  FORMAT3_1;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)             and ($instruction[12:5] == 8'b0000_0000) and (rs2 < 16));
   my         FORMAT3_1;
   assign FORMAT3_1 = (                      (rd < 16)        &&  (rs1 < 16)         &&  (i == 0)             &&  ($instruction[12:5] == 8'b0000_0000) &&  (rs2 < 16));
   // 
   //  FORMAT3_2;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1));
   my         FORMAT3_2;
   assign FORMAT3_2 = (                      (rd < 16)        &&  (rs1 < 16)         &&  (i == 1));
   // 
   //  FORMAT3_3;
   //    (                                   (rd == 5'b00000) and (rs1 < 16)         and (i == 0)             and ($instruction[12:5] == 8'b0000_0000) and (rs2 < 16)); 
   // 
   //  FORMAT3_4;
   //    (                                   (rd == 5'b00000) and (rs1 < 16)         and (i == 1)); 
   // 
   //  FORMAT3_5;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)             and ($instruction[9:5]  == 8'b0_0000)    and (rs2 < 16)); 
   // 
   //  FORMAT3_6;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1)); 
   // 
   //  FORMAT3_7;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)             and ($instruction[12:5] == 8'b0000_0000) and (rs2 < 16)); 
   // 
   //  FORMAT3_8;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1)             and ($instruction[12:7] == 8'b00_0000)); 
   // 
   //  FORMAT3_9;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)                                                     and (rs2 < 16)); 
   // 
   // // FORMAT3_10
   //  FORMAT3_11;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)             and ($instruction[11:5] == 7'b000_0000)  and (rs2 < 16));
   my         FORMAT3_11;
   assign FORMAT3_11 = (                     (rd < 16)        &&  (rs1 < 16)         &&  (i == 0)             &&  ($instruction[11:5] == 7'b000_0000)  &&  (rs2 < 16));
   // 
   //  FORMAT3_12;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1) and (x == 0) and ($instruction[11:5] == 7'b000_0000));
   my         FORMAT3_12;
   assign FORMAT3_12 = (                     (rd < 16)        &&  (rs1 < 16)         &&  (i == 1) &&  (x == 0) &&  ($instruction[11:5] == 7'b000_0000));
   // 
   //  FORMAT3_13;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1) and (x == 1) and ($instruction[11:6] == 6'b00_0000));
   my         FORMAT3_13;
   assign FORMAT3_13 = (                     (rd < 16)        &&  (rs1 < 16)         &&  (i == 1) &&  (x == 1) &&  ($instruction[11:6] == 6'b00_0000));
   // 
   //  FORMAT3_14;
   //    (                                   (rd < 16)        and (rs1 == 5'b0_0000)                                                                 and (rs2 < 16)); 
   //  FORMAT3_15;
   //    (($instruction[29:27] == 3'b000) and (rd < 16)        and (rs1 < 16)                                                                         and (rs2 < 16)); 
   //  FORMAT3_16;
   //    (                                   (rd < 16)        and (rs1 < 16)                                                                         and (rs2 < 16)); 
   //  FORMAT3_17;
   //    (                                   (rd < 16)        and (rs1 < 16)                                 and ($instruction[13:0] == 14'b00_0000_0000_0000)); 
   //  FORMAT3_18;
   //    (                                                                                                       ($instruction[18:0] == 19'b000_0000_0000_0000_0000)); 
   //  FORMAT3_19;
   //    (                                   (rd < 16)                                                       and ($instruction[18:0] == 19'b000_0000_0000_0000_0000)); 
   // // format 4
   //  FORMAT4_1;
   //    (                                   (rd < 16)                and (rs1 < 16)         and (i == 0)             and ($instruction[10:5] == 6'b00_0000)   and (rs2 < 16)); 
   // 
   //  FORMAT4_2;
   //    (                                   (rd < 16)                and (rs1 < 16)         and (i == 1)); 
   // 
   //  FORMAT4_3;
   //    (                                   (rd < 16)                                       and (i == 0)             and ($instruction[10:5] == 6'b00_0000)   and (rs2 < 16)); 
   // 
   my         FORMAT4_3;
   assign FORMAT4_3 = (                      (rd < 16)                                       &&  (i == 0)             &&  ($instruction[10:5] == 6'b00_0000)   &&  (rs2 < 16)); 
   //  FORMAT4_4;
   //    (                                   (rd < 16)                                       and (i == 1)); 
   // 
   my         FORMAT4_4;
   assign FORMAT4_4 = (                      (rd < 16)                                       && (i == 1)); 
   //  FORMAT4_5;
   //    (                                   (rd < 16)                and (rs1 < 16)         and (i == 0)                                                     and (rs2 < 16)); 
   // 
   //  FORMAT4_6;
   //    (                                   (rd < 16) and (cc2 == 0)                                                                                        and (rs2 < 16)); 
   // 
   //  FORMAT4_7;
   //    (($instruction[29] == 0)                                       and (rs1 < 16)         and (i == 0)             and ($instruction[10:5] == 6'b00_0000)   and (rs2 < 16)); 
   // 
   //  FORMAT4_8;
   //    (($instruction[29] == 0)                                       and (rs1 < 16)         and (i == 1)             and ($instruction[10:7] == 4'b0000)); 
   // 
   

   
   // format extracted from sparcv9 page 63
   // opcodes extracted from sparcv9 page 275, Appendix E: Opcode Maps
   
   // allowed $instruction formats
   // allow op = 0, 2, 3
   // disable op = 1, call $instructions
   my allowed_$instruction_formats;
   assign allowed_$instruction_formats = ((op == 2'b00) || (op == 2'b10) || (op == 2'b11));
   

   // allowed instrucions for op == 0
   my allowed_op_0_$instructions;
   assign  allowed_op_0_$instructions = (op == 2'b00) & ((op2 == 3'b001) || // BPcc
                                                        (op2 == 3'b010) || // Bicc
                                                        (op2 == 3'b011) || // BPr bit 28 = 0, || bit 28 = 1, footnote page 138, sparcv9
                                                        (op2 == 3'b100));   // SETHI, NOP
   

   // allowed $instructions for op == 2
   my allowed_op_2_$instructions;
   assign allowed_op_2_$instructions = (op == 2'b10) & (
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0000) && (FORMAT3_1 || FORMAT3_2)) || // ADD
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0001) && (FORMAT3_1 || FORMAT3_2)) || // AND
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0010) && (FORMAT3_1 || FORMAT3_2)) || // OR
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0011) && (FORMAT3_1 || FORMAT3_2)) || // XOR
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0100) && (FORMAT3_1 || FORMAT3_2)) || // SUB
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0101) && (FORMAT3_1 || FORMAT3_2)) || // ANDN
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0110) && (FORMAT3_1 || FORMAT3_2)) || // ORN
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0111) && (FORMAT3_1 || FORMAT3_2)) || // XNOR
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1000) && (FORMAT3_1 || FORMAT3_2)) || // ADDC
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1001) && (FORMAT3_1 || FORMAT3_2)) || // MULX
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1010) && (FORMAT3_1 || FORMAT3_2)) || // UMUL
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1011) && (FORMAT3_1 || FORMAT3_2)) || // SMUL
          ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1100) && (FORMAT3_1 || FORMAT3_2)) || // SUBC
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0000) && (FORMAT3_1 || FORMAT3_2)) || // ADDcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0001) && (FORMAT3_1 || FORMAT3_2)) || // ANDcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0010) && (FORMAT3_1 || FORMAT3_2)) || // ORcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0011) && (FORMAT3_1 || FORMAT3_2)) || // XORcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0100) && (FORMAT3_1 || FORMAT3_2)) || // SUBcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0101) && (FORMAT3_1 || FORMAT3_2)) || // ANDNcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0110) && (FORMAT3_1 || FORMAT3_2)) || // ORNcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0111) && (FORMAT3_1 || FORMAT3_2)) || // XNORcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1000) && (FORMAT3_1 || FORMAT3_2)) || // ADDCcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1010) && (FORMAT3_1 || FORMAT3_2)) || // UMULcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1011) && (FORMAT3_1 || FORMAT3_2)) || // SMULcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1100) && (FORMAT3_1 || FORMAT3_2)) || // SUBCcc
          ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0101) && (FORMAT3_11 || FORMAT3_12 || FORMAT3_13)) || // SLL (x=0), SLLX (x=1)
          ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0110) && (FORMAT3_11 || FORMAT3_12 || FORMAT3_13)) || // SRL (x=0), SRLX (x=1)
          ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0111) && (FORMAT3_11 || FORMAT3_12 || FORMAT3_13)) || // SRA (x=0), SRAX (x=1)

   
   
   my allowed_op_3_$instructions;
   assign allowed_op_3_$instructions = (op == 2'b11) & (
          // probably want to disable load indirect to avoid mixing original && duplicate address space
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0000) && (FORMAT3_1 || FORMAT3_2)) || // LDUW
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0001) && (FORMAT3_1 || FORMAT3_2)) || // LDUB
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0010) && (FORMAT3_1 || FORMAT3_2)) || // LDUH
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0011) && (FORMAT3_1 || FORMAT3_2)) || // LDD
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0100) && (FORMAT3_1 || FORMAT3_2)) || // STW
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0101) && (FORMAT3_1 || FORMAT3_2)) || // STB 
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0110) && (FORMAT3_1 || FORMAT3_2)) || // STH   
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b0111) && (FORMAT3_1 || FORMAT3_2)) || // STD    
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1000) && (FORMAT3_1 || FORMAT3_2)) || // LDSW    
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1001) && (FORMAT3_1 || FORMAT3_2)) || // LDSB
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1010) && (FORMAT3_1 || FORMAT3_2)) || // LDSH
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1011) && (FORMAT3_1 || FORMAT3_2)) || // LDX
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1101) && (FORMAT3_1 || FORMAT3_2)) || // LDSTUB
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1110) && (FORMAT3_1 || FORMAT3_2)) || // STX
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1111) && (FORMAT3_1 || FORMAT3_2)));   // SWAP

       

                                                      
   


   // check if load original $instruction uses correct operands
   property check_load_store_operands;
      @(posedge clk)
        if (op ==  2'b11)
          (rd < 16) && (rs1 < 16) && (((i == 0) && (rs2 < 16)) || (i == 1));
   endproperty


   // check if add original $instruction use correct operands
   property check_alu_operands;
      @(posedge clk)
        if ((op == 2'b10) && 
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
             (op3 == 6'b01_1100))) // SUBCcc
          (rd < 16) && (rs1 < 16) && (((i == 0) && (rs2 < 16)) || (i == 1));
   endproperty

   // check if shift original $instructions uses correct operands
   property check_shift_operands;
      @(posedge clk)
        if ((op == 2'b10) &&
            ((op3 == 6'b10_0101) || // SLL, SLLX
             (op3 == 6'b10_0110) || // SRL, SRLX
             (op3 == 6'b10_0111)))
          (rd < 16) && (rs1 < 16) && (((i == 0) && (rs2 < 16)) || (i == 1));
   endproperty

   // check if MOVcc original $instruction uses correct operands
   property check_movcc_operands;
      @(posedge clk)
        if ((op == 2'b10) && (op3 == 6'b10_1100))
          (rd <16) && (((i == 0) && (rs2 < 16)) || (i == 1));
   endproperty


  
   


