
print('Enter e to exit')
while True:
  inst_hex = raw_input('enter the instruction code in hex:')
  if (inst_hex ==  'e'):
    break
  instruction = bin(int(inst_hex,16))[2:].zfill(32)
  print('binary inst =',instruction)
  #print len(instruction)
  instruction = instruction[::-1]

  op = int(instruction[30:32][::-1],2)          #[31:30]     
  op2 = int(instruction[22:25][::-1],2)         #[24:22]
  op3 = int(instruction[19:25][::-1],2)         #[24:19]
  op3_2 = int(instruction[23:25][::-1],2)            #[5:4] inside [24:19]
  op3_1 = int(instruction[19:23][::-1],2)            #[3:0] inside [24:19]
  rd = int(instruction[25:30][::-1],2)          #[29:25]
  simm13 = int(instruction[0:13][::-1],2)        #[12:0]
  simm11 = int(instruction[0:11][::-1],2) 
  shcnt32 = int(instruction[0:5][::-1],2)
  shcnt64 = int(instruction[0:6][::-1],2)

  rs1 = int(instruction[14:19][::-1],2)                 #[18:14]

  i = int(instruction[13][::-1],2)                    #[13]
  rs2 = int(instruction[0:5][::-1],2)                 #[4:0]

  x = int(instruction[12][::-1],2)                     #[12]

  #print('op =',op,'op2 =',op2,'op3 =',op3,'rd =',rd,'rs1 =',rs1,'rs2 =',rs2)

  FORMAT3_1 = 0
  FORMAT3_2 = 0
  FORMAT3_11 = 0
  FORMAT3_12 = 0
  FORMAT3_13 = 0
  FORMAT4_3 = 0
  FORMAT4_4 = 0
   
  if (                      (rd < 16)        and  (rs1 < 16)         and  (i == 0)             and  (instruction[5:13] == '00000000') and  (rs2 < 16)):
    FORMAT3_1 =1
    #print('instruction in FORMAT3_1')
  if (                      (rd < 16)        and  (rs1 < 16)         and  (i == 1)):
    FORMAT3_2 =1
    #print('instruction in FORMAT3_2')
   
  if (                     (rd < 16)        and  (rs1 < 16)         and  (i == 0)             and  (instruction[5:12] == '0000000')  and  (rs2 < 16)):
    FORMAT3_11 =1
    #print('instruction in FORMAT3_11')

  if (                     (rd < 16)        and  (rs1 < 16)         and  (i == 1) and  (x == 0) and  (instruction[5:12] == '0000000')):
    FORMAT3_12 =1
    #print('instruction in FORMAT3_12')
   
  if (                     (rd < 16)        and  (rs1 < 16)         and  (i == 1) and  (x == 1) and  (instruction[6:12] == '000000')):
    FORMAT3_13 =1
    #print('instruction in FORMAT3_13')

  if (                      (rd < 16)                                       and  (i == 0)             and  (instruction[5:11] == '000000')   and  (rs2 < 16)) :
    FORMAT4_3 =1
    #print('instruction in FORMAT4_3')

  if (                      (rd < 16)                                       and (i == 1)) :
    FORMAT4_4 =1
    #print('instruction in FORMAT4_4')
   

   
   # format extracted from sparcv9 page 63
   # opcodes extracted from sparcv9 page 275, Appendix E: Opcode Maps
   
   # allowed instruction formats
   # allow op = 0, 2, 3
   # disable op = 1, call instructions
   #wire allowed_instruction_formats
  ###allowed_instruction_formats = if ((op == 00) or (op == 2) or (op == 3)
    

   # allowed instrucions for op == 0
   #wire allowed_op_0_instructions
  if (op == 00) and (op2 == 001): 
    print('BPcc (branch instruction)')
  if (op == 00) and (op2 == 2):
    print('Bicc (branch instruction)')
  if (op == 00) and (op2 == 3):
    print('BPr (branch instruction)') #bit 28 = 0, or bit 28 = 1, footnote page 138, sparcv9
  if (op == 00) and (op2 == 4):
    print('SETHI or NOP')

   # ignore floating branches FBPfcc:(instruction[24:22] == 101) FBfcc:(instruction[24:22] == 110)
   # not valid instruction (instruction[24:22] == 111)
   

   # allowed instructions for op == 2
   #wire allowed_op_2_instructions

  if ((op == 2) and (op3_2 == 00) and (op3_1 == 0000) and (FORMAT3_1 or FORMAT3_2)):
    print('ADD')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 0001) and (FORMAT3_1 or FORMAT3_2)):
    print('AND')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 002) and (FORMAT3_1 or FORMAT3_2)):
    print('OR')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 003) and (FORMAT3_1 or FORMAT3_2)):
    print('XOR')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 04) and (FORMAT3_1 or FORMAT3_2)):
    print('SUB')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 05) and (FORMAT3_1 or FORMAT3_2)):
    print('ANDN')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 06) and (FORMAT3_1 or FORMAT3_2)):
    print('ORN')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 07) and (FORMAT3_1 or FORMAT3_2)):
    print('XNOR')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 8) and (FORMAT3_1 or FORMAT3_2)):
    print('ADDC')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 9) and (FORMAT3_1 or FORMAT3_2)):
    print('MULX')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 10) and (FORMAT3_1 or FORMAT3_2)):
    print('UMUL')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 11) and (FORMAT3_1 or FORMAT3_2)):
    print('SMUL')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 00) and (op3_1 == 12) and (FORMAT3_1 or FORMAT3_2)):
    print('SUBC')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
 
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 0000) and (FORMAT3_1 or FORMAT3_2)):
    print('ADDcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 0001) and (FORMAT3_1 or FORMAT3_2)):
    print('ANDcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 2) and (FORMAT3_1 or FORMAT3_2)):
    print('ORcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 003) and (FORMAT3_1 or FORMAT3_2)):
    print('XORcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 04) and (FORMAT3_1 or FORMAT3_2)):
    print('SUBcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 05) and (FORMAT3_1 or FORMAT3_2)):
    print('ANDNcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 06) and (FORMAT3_1 or FORMAT3_2)):
    print('ORNcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 07) and (FORMAT3_1 or FORMAT3_2)):
    print('XNORcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 8) and (FORMAT3_1 or FORMAT3_2)):
    print('ADDCcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  # if ((op == 2) and (op3_2 == 01) and (op3_1 == 1001)):
  # rint('---
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 10) and (FORMAT3_1 or FORMAT3_2)):
    print('UMULcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 11) and (FORMAT3_1 or FORMAT3_2)):
    print('SMULcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 2) and (op3_2 == 01) and (op3_1 == 12) and (FORMAT3_1 or FORMAT3_2)):
    print('SUBCcc')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)

  if ((op == 2) and (op3_2 == 2) and (op3_1 == 5) and (FORMAT3_11 or FORMAT3_12 or FORMAT3_13)):
    print('SLL or SLLX ')
    if FORMAT3_11 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_12 == 1:
      print('rd =',rd,'rs1 =',rs1,'shcnt32 =',shcnt32)
    elif FORMAT3_13 == 1:
      print('rd =',rd,'rs1 =',rs1,'shcnt64 =',shcnt64)
  if ((op == 2) and (op3_2 == 2) and (op3_1 == 06) and (FORMAT3_11 or FORMAT3_12 or FORMAT3_13)):
    print('SRL or SRLX ')
    if FORMAT3_11 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_12 == 1:
      print('rd =',rd,'rs1 =',rs1,'shcnt32 =',shcnt32)
    elif FORMAT3_13 == 1:
      print('rd =',rd,'rs1 =',rs1,'shcnt64 =',shcnt64)
  if ((op == 2) and (op3_2 == 2) and (op3_1 == 07) and (FORMAT3_11 or FORMAT3_12 or FORMAT3_13)):
    print('SRA or SRAX')
    if FORMAT3_11 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_12 == 1:
      print('rd =',rd,'rs1 =',rs1,'shcnt32 =',shcnt32)
    elif FORMAT3_13 == 1:
      print('rd =',rd,'rs1 =',rs1,'shcnt64 =',shcnt64)

  if ((op == 2) and (op3_2 == 2) and (op3_1 == 12) and (FORMAT4_3 or FORMAT4_4)):
    print('MOVcc')
    if FORMAT4_3 == 1:
      print('rd =',rd,'rs2 =',rs2)
    elif FORMAT4_4 == 1:
      print('rd =',rd,'simm11 =',simm11)

   
   
   #wire allowed_op_3_instructions

          # probably want to disable load indirect to avoid mixing original and duplicate address space
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 0000) and (FORMAT3_1 or FORMAT3_2)):
    print('LDUW')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 0001) and (FORMAT3_1 or FORMAT3_2)):
    print('LDUB')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 002) and (FORMAT3_1 or FORMAT3_2)):
    print('LDUH')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 003) and (FORMAT3_1 or FORMAT3_2)):
    print('LDD')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 04) and (FORMAT3_1 or FORMAT3_2)):
    print('STW')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 05) and (FORMAT3_1 or FORMAT3_2)):
    print('STB ')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 06) and (FORMAT3_1 or FORMAT3_2)):
    print('STH  ') 
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 07) and (FORMAT3_1 or FORMAT3_2)):
    print('STD  ')  
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 8) and (FORMAT3_1 or FORMAT3_2)):
    print('LDSW   ') 
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 9) and (FORMAT3_1 or FORMAT3_2)):
    print('LDSB')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 10) and (FORMAT3_1 or FORMAT3_2)):
    print('LDSH')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 11) and (FORMAT3_1 or FORMAT3_2)):
    print('LDX')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  # if ((op == 3) and (op3_2 == 00) and (op3_1 == 1100)):
   #  rint('--- 
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 13) and (FORMAT3_1 or FORMAT3_2)):
    print('LDSTUB')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 14) and (FORMAT3_1 or FORMAT3_2)):
    print('STX')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)
  if ((op == 3) and (op3_2 == 00) and (op3_1 == 15) and (FORMAT3_1 or FORMAT3_2)):  
    print('SWAP')
    if FORMAT3_1 == 1:
      print('rd =',rd,'rs1 =',rs1,'rs2 =',rs2)
    elif FORMAT3_2 == 1:
      print('rd =',rd,'rs1 =',rs1,'simm13 =',simm13)

           
  
   
   
