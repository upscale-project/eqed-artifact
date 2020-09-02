// constraint for sparc instructions

module inst_constraint(clk, 
//                       rst,
                       dec_valid_d,
                       instruction);
   
   input        clk;
   input        dec_valid_d;
   
   //input        rst;
   input [32:0] instruction;
      
   // instruction format fields, extracted from sparcv9 page 64
   wire [1:0]   op;
   wire [2:0]   op2;
   wire [5:0]   op3;
   wire [29:0]  disp30;
   wire [4:0]   rd;
   wire [21:0]  imm22;
   wire         a;
   wire [3:0]   cond_format2;
   wire [21:0]  disp22;
   wire         cc1_format2;
   wire         cc0_format2;
   wire         p;
   wire [18:0]  disp19;
   wire [2:0]   rcond_format2;
   wire [1:0]   d16hi;
   wire [4:0]   rs1;
   wire [13:0]  d16lo;
   wire         i;
   wire [4:0]   rs2;
   wire [12:0]  simm13;
   wire [2:0]   rcond_format3;
   wire [9:0]   simm10;
   wire [2:0]   cmask;
   wire [3:0]   mmask;
   wire [7:0]   imm_asi;
   wire         x;
   wire [4:0]   shcnt32;
   wire [5:0]   shcnt64;
   wire [8:0]   opf;
   wire         cc1_format3;
   wire         cc0_format3;
   wire [4:0]   fnc;
   wire         cc1_format4;
   wire         cc0_format4;
   wire [10:0]  simm11;
   wire         cc2;
   wire [3:0]   cond_format4_1;;
   wire [2:0]   rcond_format4;;
   wire [4:0]   opf_low_5;
   wire [5:0]   opf_low_6;
   wire [3:0]   cond_format4_2;
   wire [6:0]   sw_trap;

   assign op = instruction[31:30];
   assign op2 = instruction[24:22];
   assign op3 = instruction[24:19];
   assign disp30 = instruction[29:0];
   assign rd = instruction[29:25];
   assign imm22 = instruction[21:0];
   assign a = instruction[29];
   assign cond_format2 = instruction[28:25];
   assign disp22 = instruction[21:0];
   assign cc1_format2 = instruction[21];
   assign cc0_format2 = instruction[20];
   assign p = instruction[19];
   assign disp19 = instruction[18:0];
   assign rcond_format2 = instruction[28:25];
   assign d16hi = instruction[21:20];
   assign rs1 = instruction[18:14];
   assign d16lo = instruction[13:0];
   assign i = instruction[13];
   assign rs2 = instruction[4:0];
   assign simm13 = instruction[12:0];
   assign rcond_format3 = instruction[12:10];
   assign simm10 = instruction[9:0];
   assign cmask = instruction[6:4];
   assign mmask = instruction[3:0];
   assign imm_asi = instruction[12:5];
   assign x = instruction[12];
   assign shcnt32 = instruction[4:0];
   assign shcnt64 = instruction[5:0];
   assign opf = instruction[13:5];
   assign cc1_format3 = instruction[26];
   assign cc0_format3 = instruction[25];
   assign fnc = instruction[29:25];
   assign cc1_format4 = instruction[12];
   assign cc0_format4 = instruction[11];
   assign simm11 = instruction[10:0];
   assign cc2 = instruction[18];
   assign cond_format4_1 = instruction[17:14];
   assign rcond_format4 = instruction[12:10];
   assign opf_low_5 = instruction[9:5];
   assign opf_low_6 = instruction[10:5];
   assign cond_format4_2 = instruction[28:25];
   assign sw_trap = instruction[6:0];   

   // format 3 
   //  FORMAT3_1;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)             and (instruction[12:5] == 8'b0000_0000) and (rs2 < 16));
   wire         FORMAT3_1;
   assign FORMAT3_1 = (                      (rd > 0) && (rd < 16)        &&  (rs1 < 16)         &&  (i == 0)             &&  (instruction[12:5] == 8'b0000_0000) &&  (rs2 < 16));
   // 
   //  FORMAT3_2;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1));
   wire         FORMAT3_2;
   assign FORMAT3_2 = (                      (rd > 0) && (rd < 16)        &&  (rs1 < 16)         &&  (i == 1));
   // 
   //  FORMAT3_3;
   //    (                                   (rd == 5'b00000) and (rs1 < 16)         and (i == 0)             and (instruction[12:5] == 8'b0000_0000) and (rs2 < 16)); 
   // 
   //  FORMAT3_4;
   //    (                                   (rd == 5'b00000) and (rs1 < 16)         and (i == 1)); 
   // 
   //  FORMAT3_5;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)             and (instruction[9:5]  == 8'b0_0000)    and (rs2 < 16)); 
   // 
   //  FORMAT3_6;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1)); 
   // 
   //  FORMAT3_7;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)             and (instruction[12:5] == 8'b0000_0000) and (rs2 < 16)); 
   // 
   //  FORMAT3_8;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1)             and (instruction[12:7] == 8'b00_0000)); 
   // 
   //  FORMAT3_9;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)                                                     and (rs2 < 16)); 
   // 
   // // FORMAT3_10
   //  FORMAT3_11;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 0)             and (instruction[11:5] == 7'b000_0000)  and (rs2 < 16));
   wire         FORMAT3_11;
   assign FORMAT3_11 = (                     (rd < 16)        &&  (rs1 < 16)         &&  (i == 0)             &&  (instruction[11:5] == 7'b000_0000)  &&  (rs2 < 16));
   // 
   //  FORMAT3_12;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1) and (x == 0) and (instruction[11:5] == 7'b000_0000));
   wire         FORMAT3_12;
   assign FORMAT3_12 = (                     (rd < 16)        &&  (rs1 < 16)         &&  (i == 1) &&  (x == 0) &&  (instruction[11:5] == 7'b000_0000));
   // 
   //  FORMAT3_13;
   //    (                                   (rd < 16)        and (rs1 < 16)         and (i == 1) and (x == 1) and (instruction[11:6] == 6'b00_0000));
   wire         FORMAT3_13;
   assign FORMAT3_13 = (                     (rd < 16)        &&  (rs1 < 16)         &&  (i == 1) &&  (x == 1) &&  (instruction[11:6] == 6'b00_0000));
   // 
   //  FORMAT3_14;
   //    (                                   (rd < 16)        and (rs1 == 5'b0_0000)                                                                 and (rs2 < 16)); 
   //  FORMAT3_15;
   //    ((instruction[29:27] == 3'b000) and (rd < 16)        and (rs1 < 16)                                                                         and (rs2 < 16)); 
   //  FORMAT3_16;
   //    (                                   (rd < 16)        and (rs1 < 16)                                                                         and (rs2 < 16)); 
   //  FORMAT3_17;
   //    (                                   (rd < 16)        and (rs1 < 16)                                 and (instruction[13:0] == 14'b00_0000_0000_0000)); 
   //  FORMAT3_18;
   //    (                                                                                                       (instruction[18:0] == 19'b000_0000_0000_0000_0000)); 
   //  FORMAT3_19;
   //    (                                   (rd < 16)                                                       and (instruction[18:0] == 19'b000_0000_0000_0000_0000)); 
   // // format 4
   //  FORMAT4_1;
   //    (                                   (rd < 16)                and (rs1 < 16)         and (i == 0)             and (instruction[10:5] == 6'b00_0000)   and (rs2 < 16)); 
   // 
   //  FORMAT4_2;
   //    (                                   (rd < 16)                and (rs1 < 16)         and (i == 1)); 
   // 
   //  FORMAT4_3;
   //    (                                   (rd < 16)                                       and (i == 0)             and (instruction[10:5] == 6'b00_0000)   and (rs2 < 16)); 
   // 
   wire         FORMAT4_3;
   assign FORMAT4_3 = (                      (rd < 16)                                       &&  (i == 0)             &&  (instruction[10:5] == 6'b00_0000)   &&  (rs2 < 16)); 
   //  FORMAT4_4;
   //    (                                   (rd < 16)                                       and (i == 1)); 
   // 
   wire         FORMAT4_4;
   assign FORMAT4_4 = (                      (rd < 16)                                       && (i == 1)); 
   //  FORMAT4_5;
   //    (                                   (rd < 16)                and (rs1 < 16)         and (i == 0)                                                     and (rs2 < 16)); 
   // 
   //  FORMAT4_6;
   //    (                                   (rd < 16) and (cc2 == 0)                                                                                        and (rs2 < 16)); 
   // 
   //  FORMAT4_7;
   //    ((instruction[29] == 0)                                       and (rs1 < 16)         and (i == 0)             and (instruction[10:5] == 6'b00_0000)   and (rs2 < 16)); 
   // 
   //  FORMAT4_8;
   //    ((instruction[29] == 0)                                       and (rs1 < 16)         and (i == 1)             and (instruction[10:7] == 4'b0000)); 
   // 
   

   
   // format extracted from sparcv9 page 63
   // opcodes extracted from sparcv9 page 275, Appendix E: Opcode Maps
   
   // allowed instruction formats
   // allow op = 0, 2, 3
   // disable op = 1, call instructions
   wire allowed_instruction_formats;
   assign allowed_instruction_formats = ((op == 2'b00) || (op == 2'b10) || (op == 2'b11));
   

   // allowed instrucions for op == 0
   wire allowed_op_0_instructions;
   assign  allowed_op_0_instructions = (op == 2'b00) & ((op2 == 3'b001) || // BPcc
                                                        (op2 == 3'b010) || // Bicc
                                                        (op2 == 3'b011) || // BPr bit 28 = 0, || bit 28 = 1, footnote page 138, sparcv9
                                                        (op2 == 3'b100));   // SETHI, NOP
   // ignore floating branches FBPfcc:(instruction[24:22] == 3'b101) FBfcc:(instruction[24:22] == 3'b110)
   // not valid instruction (instruction[24:22] == 3'b111)
   

   // allowed instructions for op == 2
   wire allowed_op_2_instructions;
   assign allowed_op_2_instructions = (op == 2'b10) & (
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
       // ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1101) && (FORMAT3_1 || FORMAT3_2)) || // UDIVX, avoid division, may cause division by zero
       // ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1110) && (FORMAT3_1 || FORMAT3_2)) || // UDIV, avoid division, may cause division by zero
       // ((op == 2'b10) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1111) && (FORMAT3_1 || FORMAT3_2)) || // SDIV, avoid division, may cause division by zero
 
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0000) && (FORMAT3_1 || FORMAT3_2)) || // ADDcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0001) && (FORMAT3_1 || FORMAT3_2)) || // ANDcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0010) && (FORMAT3_1 || FORMAT3_2)) || // ORcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0011) && (FORMAT3_1 || FORMAT3_2)) || // XORcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0100) && (FORMAT3_1 || FORMAT3_2)) || // SUBcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0101) && (FORMAT3_1 || FORMAT3_2)) || // ANDNcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0110) && (FORMAT3_1 || FORMAT3_2)) || // ORNcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0111) && (FORMAT3_1 || FORMAT3_2)) || // XNORcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1000) && (FORMAT3_1 || FORMAT3_2)) || // ADDCcc
       // ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1001)) || // ---
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1010) && (FORMAT3_1 || FORMAT3_2)) || // UMULcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1011) && (FORMAT3_1 || FORMAT3_2)) || // SMULcc
          ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1100) && (FORMAT3_1 || FORMAT3_2)) || // SUBCcc
       // ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1101)) || // ---
       // ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1110) && (FORMAT3_1 || FORMAT3_2)) || // UDIVcc, avoid division, may cause division by zero
       // ((op == 2'b10) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1111) && (FORMAT3_1 || FORMAT3_2)) || // SDIVcc, avoid division, may cause division by zero

          //
        // ((op3[5:4] == 2'b10) and (op3[3:0] == 4'b0000)) or // TADDcc
        // ((op3[5:4] == 2'b10) and (op3[3:0] == 4'b0001)) or // TSUBcc
        // ((op3[5:4] == 2'b10) and (op3[3:0] == 4'b0010)) or // TADDccTV
        // ((op3[5:4] == 2'b10) && (op3[3:0] == 4'b0011)) or // TSUBccTV
        // ((op3[5:4] == 2'b10) && (op3[3:0] == 4'b0100)) or // MULScc
          ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0101) && (FORMAT3_11 || FORMAT3_12 || FORMAT3_13)) || // SLL (x=0), SLLX (x=1)
          ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0110) && (FORMAT3_11 || FORMAT3_12 || FORMAT3_13)) || // SRL (x=0), SRLX (x=1)
          ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0111) && (FORMAT3_11 || FORMAT3_12 || FORMAT3_13)) || // SRA (x=0), SRAX (x=1)
          // ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1000)) || // RDY, ---, RDCCR, RDASI, RDTICK, RDPC, RDFPRS, RDASR, MEMBAR, STBAR
          // ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1001)) || // ---
          // ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1010)) || // RDPR
          // ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1011)) || // FLUSHW
          ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1100) && (FORMAT4_3 || FORMAT4_4)) // MOVcc
          // ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1101)) || // SDIVX, avoid division, may cause division by zero
          // ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1110)) || // POPC (rs1=0), --- (rs1>0)
          // ((op == 2'b10) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1111)) || // MOVr (table 40)

          //
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0000)) || // WRY, ---, WRCCR, WRASI, WRASR, WRFPRS, SIR
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0001)) || // SAVED, RESTORED
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0010)) || // WRPR
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0011)) || // ---
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0100)) || // FPop1 (table 37)
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0101)) || // FPop2 (table 38)
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0110)) || // IMPDEP1
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0111)) || // IMPDEP2
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1000)) || // JMPL
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1001)) || // RETURN
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1010)) || // Tcc (table 39) (bit 29 = 1)
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1011)) || // FLUSH
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1100)) || // SAVE
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1101)) || // RESTORE
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1110)) || // DONE (fcn = 0), RETRY (fcn = 1)
          // ((op == 2'b10) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1111));   // ---
                                                       );
   
   
   wire allowed_op_3_instructions;
   assign allowed_op_3_instructions = (op == 2'b11) & (
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
          // ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1100)) || // --- 
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1101) && (FORMAT3_1 || FORMAT3_2)) || // LDSTUB
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1110) && (FORMAT3_1 || FORMAT3_2)) || // STX
          ((op == 2'b11) && (op3[5:4] == 2'b00) && (op3[3:0] == 4'b1111) && (FORMAT3_1 || FORMAT3_2)));   // SWAP

          // load from alternate space
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0000) && (FORMAT3_2 || FORMAT3_9)) || // LDUWA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0001) && (FORMAT3_2 || FORMAT3_9)) || // LDUBA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0010) && (FORMAT3_2 || FORMAT3_9)) || // LDUHA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0011) && (FORMAT3_2 || FORMAT3_9)) || // LDDA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0100) && (FORMAT3_2 || FORMAT3_9)) || // STWA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0101) && (FORMAT3_2 || FORMAT3_9)) || // STBA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0110) && (FORMAT3_2 || FORMAT3_9)) || // STHA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b0111) && (FORMAT3_2 || FORMAT3_9)) || // STDA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1000) && (FORMAT3_2 || FORMAT3_9)) || // LDSWA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1001) && (FORMAT3_2 || FORMAT3_9)) || // LDSBA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1010) && (FORMAT3_2 || FORMAT3_9)) || // LDSHA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1011) && (FORMAT3_2 || FORMAT3_9)) || // LDXA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1100)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1101)) || // LDSTUBA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1110)) || // STXA
       // ((op == 2'b11) && (op3[5:4] == 2'b01) && (op3[3:0] == 4'b1111)) || // SWAPA

          // load floating point
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0000)) || // LDF
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0001)) || // LDFSR, LDXFSR
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0010)) || // LDQF
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0011)) || // LDDF
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0100)) || // STF
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0101)) || // STFSR, STXFSR
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0110)) || // STQF
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b0111)) || // STDF
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1000)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1001)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1010)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1011)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1100)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1101)) || // PREFETCH
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1110)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b10) && (op3[3:0] == 4'b1111)) || // ---

          // load floating point from alternate space
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0000)) || // LDFA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0001)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0010)) || // LDQFA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0011)) || // LDDFA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0100)) || // STFA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0101)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0110)) || // STQFA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b0111)) || // STDFA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1000)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1001)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1010)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1011)) || // ---
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1100)) || // CASA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1101)) || // PREFETCHA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1110)) || // CASXA
       // ((op == 2'b11) && (op3[5:4] == 2'b11) && (op3[3:0] == 4'b1111));   // ---
                                                      
   


   // check if load original instruction uses correct operands
   property check_load_store_operands;
      @(posedge clk)
        if (op ==  2'b11)
          (rd < 16) && (rs1 < 16) && (((i == 0) && (rs2 < 16)) || (i == 1));
   endproperty


   // check if add original instruction use correct operands
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

   // check if shift original instructions uses correct operands
   property check_shift_operands;
      @(posedge clk)
        if ((op == 2'b10) &&
            ((op3 == 6'b10_0101) || // SLL, SLLX
             (op3 == 6'b10_0110) || // SRL, SRLX
             (op3 == 6'b10_0111)))
          (rd < 16) && (rs1 < 16) && (((i == 0) && (rs2 < 16)) || (i == 1));
   endproperty

   // check if MOVcc original instruction uses correct operands
   property check_movcc_operands;
      @(posedge clk)
        if ((op == 2'b10) && (op3 == 6'b10_1100))
          (rd <16) && (((i == 0) && (rs2 < 16)) || (i == 1));
   endproperty


   // // check if add original instruction use correct operands
   // property check_instruction_out_alu_operands;
   //    @(posedge clk)
   //      if ((instruction_out[31:30] == 2'b10) && 
   //          ((instruction_out[24:19] == 6'b00_0000) || // ADD
   //           (instruction_out[24:19] == 6'b00_0001) || // AND
   //           (instruction_out[24:19] == 6'b00_0010) || // OR
   //           (instruction_out[24:19] == 6'b00_0011) || // XOR
   //           (instruction_out[24:19] == 6'b00_0100) || // SUB
   //           (instruction_out[24:19] == 6'b00_0101) || // ANDN
   //           (instruction_out[24:19] == 6'b00_0110) || // ORN
   //           (instruction_out[24:19] == 6'b00_0111) || // XNOR
   //           (instruction_out[24:19] == 6'b00_1000) || // ADDC
   //           (instruction_out[24:19] == 6'b00_1001) || // MULX
   //           (instruction_out[24:19] == 6'b00_1010) || // UMUL
   //           (instruction_out[24:19] == 6'b00_1011) || // SMUL
   //           (instruction_out[24:19] == 6'b00_1100) || // SUBC
             
   //           (instruction_out[24:19] == 6'b01_0000) || // ADDcc
   //           (instruction_out[24:19] == 6'b01_0001) || // ANDcc
   //           (instruction_out[24:19] == 6'b01_0010) || // ORcc
   //           (instruction_out[24:19] == 6'b01_0011) || // XORcc
   //           (instruction_out[24:19] == 6'b01_0100) || // SUBcc
   //           (instruction_out[24:19] == 6'b01_0101) || // ANDNcc
   //           (instruction_out[24:19] == 6'b01_0110) || // ORNcc
   //           (instruction_out[24:19] == 6'b01_0111) || // XNORcc
   //           (instruction_out[24:19] == 6'b01_1000) || // ADDCcc
   //           (instruction_out[24:19] == 6'b01_1010) || // UMULcc
   //           (instruction_out[24:19] == 6'b01_1011) || // SMULcc
   //           (instruction_out[24:19] == 6'b01_1100))) // SUBCcc

   //        ((instruction_out[29:25] > 16) || (instruction_out[29:25] == 5'b00000)) &&
   //                                                                   ((instruction_out[18:14] > 16) || (instruction_out[18:14] == 5'b00000)) && 
   //                                                                   (((i == 0) && ((instruction_out[4:0] > 16) || (instruction_out[4:0] == 5'b00000))) && (i == 1));
   
   // endproperty

   
   assume_allowed_instructions: assume property (@ (posedge clk) allowed_instruction_formats &
                                                 (allowed_op_0_instructions | allowed_op_2_instructions | allowed_op_3_instructions));
   
   // assume_allowed_op_0_instructions:  assume property (allowed_op_0_instructions);
   // assume_allowed_op_2_instructions:  assume property (allowed_op_2_instructions);
   // assume_allowed_op_3_instructions:  assume property (allowed_op_3_instructions);

   // check_load_store_operands_0: assert property (check_load_store_operands);
   // check_alu_operands_0:  assert property (check_alu_operands);
   // check_shift_operands_0: assert property (check_shift_operands);
   // check_movcc_operands_0: assert property (check_movcc_operands);
   // check_instruction_out_alu_operands: assert property (check_instruction_out_alu_operands);

      
endmodule // inst_constraint

