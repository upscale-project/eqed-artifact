// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T2 Processor File: l2t_tagd_dp.v
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
`define ADDR_MAP_HI      39
`define ADDR_MAP_LO      32
`define IO_ADDR_BIT      39

// CMP space
`define DRAM_DATA_LO     8'h00
`define DRAM_DATA_HI     8'h7f

// IOP space
`define JBUS1            8'h80
`define HASH_TBL_NRAM_CSR 8'h81
`define RESERVED_1       8'h82
`define ENET_MAC_CSR     8'h83
`define ENET_ING_CSR     8'h84
`define ENET_EGR_CMD_CSR 8'h85
`define ENET_EGR_DP_CSR  8'h86
`define RESERVED_2_LO    8'h87
`define RESERVED_2_HI    8'h92
`define BSC_CSR          8'h93
`define RESERVED_3       8'h94
`define RAND_GEN_CSR     8'h95
`define CLOCK_UNIT_CSR   8'h96
`define DRAM_CSR         8'h97
`define IOB_MAN_CSR      8'h98
`define TAP_CSR          8'h99
`define RESERVED_4_L0    8'h9a
`define RESERVED_4_HI    8'h9d
`define CPU_ASI          8'h9e
`define IOB_INT_CSR      8'h9f

// L2 space
`define L2C_CSR_LO       8'ha0
`define L2C_CSR_HI       8'hbf

// More IOP space
`define JBUS2_LO         8'hc0
`define JBUS2_HI         8'hfe
`define SPI_CSR          8'hff


//Cache Crossbar Width and Field Defines
//======================================
`define	PCX_WIDTH	130  //PCX payload packet width , BS and SR 11/12/03 N2 Xbar Packet format change
`define	PCX_WIDTH_LESS1	129  //PCX payload packet width , BS and SR 11/12/03 N2 Xbar Packet format change
`define	CPX_WIDTH	146  //CPX payload packet width, BS and SR 11/12/03 N2 Xbar Packet format change
`define	CPX_WIDTH_LESS1	145  //CPX payload packet width, BS and SR 11/12/03 N2 Xbar Packet format change
`define	CPX_WIDTH11	134 
`define	CPX_WIDTH11c	134c
`define	CPX_WIDTHc	146c  //CPX payload packet width , BS and SR 11/12/03 N2 Xbar Packet format change

`define PCX_VLD         123  //PCX packet valid 
`define PCX_RQ_HI       122  //PCX request type field 
`define PCX_RQ_LO       118
`define PCX_NC          117  //PCX non-cacheable bit
`define PCX_R           117  //PCX read/!write bit 
`define PCX_CP_HI       116  //PCX cpu_id field
`define PCX_CP_LO       114
`define PCX_TH_HI       113  //PCX Thread field
`define PCX_TH_LO       112
`define PCX_BF_HI       111  //PCX buffer id field
`define PCX_INVALL      111
`define PCX_BF_LO       109
`define PCX_WY_HI       108  //PCX replaced L1 way field
`define PCX_WY_LO       107
`define PCX_P_HI        108  //PCX packet ID, 1st STQ - 10, 2nd - 01
`define PCX_P_LO        107
`define PCX_SZ_HI       106  //PCX load/store size field
`define PCX_SZ_LO       104
`define PCX_ERR_HI      106  //PCX error field
`define PCX_ERR_LO      104
`define PCX_AD_HI       103  //PCX address field
`define PCX_AD_LO        64
`define PCX_DA_HI        63  //PCX Store data
`define PCX_DA_LO         0  

`define PCX_SZ_1B    3'b000  // encoding for 1B access
`define PCX_SZ_2B    3'b001  // encoding for 2B access
`define PCX_SZ_4B    3'b010  // encoding for 4B access
`define PCX_SZ_8B    3'b011  // encoding for 8B access
`define PCX_SZ_16B   3'b100  // encoding for 16B access

`define CPX_VLD         145  //CPX payload packet valid

`define CPX_RQ_HI       144  //CPX Request type
`define CPX_RQ_LO       141
`define CPX_L2MISS      140
`define CPX_ERR_HI      140  //CPX error field
`define CPX_ERR_LO      138
`define CPX_NC          137  //CPX non-cacheable
`define CPX_R           137  //CPX read/!write bit
`define CPX_TH_HI       136  //CPX thread ID field 
`define CPX_TH_LO       134

//bits 133:128 are shared by different fields
//for different packet types.

`define CPX_IN_HI       133  //CPX Interrupt source 
`define CPX_IN_LO       128  

`define CPX_WYVLD       133  //CPX replaced way valid
`define CPX_WY_HI       132  //CPX replaced I$/D$ way
`define CPX_WY_LO       131
`define CPX_BF_HI       130  //CPX buffer ID field - 3 bits
`define CPX_BF_LO       128

`define CPX_SI_HI       132  //L1 set ID - PA[10:6]- 5 bits
`define CPX_SI_LO       128  //used for invalidates

`define CPX_P_HI        131  //CPX packet ID, 1st STQ - 10, 2nd - 01 
`define CPX_P_LO        130

`define CPX_ASI         130  //CPX forward request to ASI
`define CPX_IF4B        130
`define CPX_IINV        124
`define CPX_DINV        123
`define CPX_INVPA5      122
`define CPX_INVPA4      121
`define CPX_CPUID_HI    120
`define CPX_CPUID_LO    118
`define CPX_INV_PA_HI   116
`define CPX_INV_PA_LO   112
`define CPX_INV_IDX_HI   117
`define CPX_INV_IDX_LO   112

`define CPX_DA_HI       127  //CPX data payload
`define CPX_DA_LO         0

`define	LOAD_RQ		5'b00000
`define MMU_RQ          5'b01000 // BS and SR 11/12/03 N2 Xbar Packet format change
`define	IMISS_RQ	5'b10000
`define	STORE_RQ	5'b00001
`define	CAS1_RQ		5'b00010
`define	CAS2_RQ		5'b00011
`define	SWAP_RQ		5'b00111 
`define	STRLOAD_RQ	5'b00100
`define	STRST_RQ	5'b00101
`define STQ_RQ          5'b00111
`define INT_RQ          5'b01001
`define FWD_RQ          5'b01101
`define FWD_RPY         5'b01110
`define RSVD_RQ         5'b11111

`define LOAD_RET        4'b0000
`define INV_RET         4'b0011
`define ST_ACK          4'b0100
`define AT_ACK          4'b0011
`define INT_RET         4'b0111
`define TEST_RET        4'b0101
`define FP_RET          4'b1000
`define IFILL_RET       4'b0001
`define	EVICT_REQ	4'b0011
//`define INVAL_ACK       4'b1000
`define INVAL_ACK       4'b0100
`define	ERR_RET		4'b1100
`define STRLOAD_RET     4'b0010
`define STRST_ACK       4'b0110
`define FWD_RQ_RET      4'b1010
`define FWD_RPY_RET     4'b1011
`define RSVD_RET        4'b1111

//End cache crossbar defines


// Number of COS supported by EECU 
`define EECU_COS_NUM  	  2


// 
// BSC bus sizes
// =============
//

// General
`define BSC_ADDRESS      40
`define MAX_XFER_LEN     7'b0
`define XFER_LEN_WIDTH   6

// CTags
`define BSC_CTAG_SZ      12
`define EICU_CTAG_PRE    5'b11101
`define EICU_CTAG_REM    7
`define EIPU_CTAG_PRE    3'b011
`define EIPU_CTAG_REM    9
`define EECU_CTAG_PRE    8'b11010000
`define EECU_CTAG_REM    4
`define EEPU_CTAG_PRE    6'b010000
`define EEPU_CTAG_REM    6
`define L2C_CTAG_PRE     2'b00
`define L2C_CTAG_REM     10
`define JBI_CTAG_PRE     2'b10
`define JBI_CTAG_REM     10
// reinstated temporarily
`define PCI_CTAG_PRE     7'b1101100
`define PCI_CTAG_REM     5


// CoS
`define EICU_COS         1'b0
`define EIPU_COS         1'b1
`define EECU_COS         1'b0
`define EEPU_COS         1'b1
`define PCI_COS          1'b0

// L2$ Bank
`define BSC_L2_BNK_HI    8
`define BSC_L2_BNK_LO    6

// L2$ Req
`define BSC_L2_REQ_SZ   62
`define BSC_L2_REQ	`BSC_L2_REQ_SZ	// used by rams in L2 code
`define BSC_L2_BUS      64
`define BSC_L2_CTAG_HI  61
`define BSC_L2_CTAG_LO  50
`define BSC_L2_ADD_HI   49
`define BSC_L2_ADD_LO   10
`define BSC_L2_LEN_HI    9
`define BSC_L2_LEN_LO    3
`define BSC_L2_ALLOC     2
`define BSC_L2_COS       1
`define BSC_L2_READ      0   

// L2$ Ack
`define L2_BSC_ACK_SZ   16
`define L2_BSC_BUS      64
`define L2_BSC_CBA_HI   14    // CBA - Critical Byte Address
`define L2_BSC_CBA_LO   13
`define L2_BSC_READ     12
`define L2_BSC_CTAG_HI  11
`define L2_BSC_CTAG_LO   0

// Enet Egress Command Unit
`define EECU_REQ_BUS    44
`define EECU_REQ_SZ     44
`define EECU_R_QID_HI   43
`define EECU_R_QID_LO   40
`define EECU_R_ADD_HI   39
`define EECU_R_ADD_LO    0

`define EECU_ACK_BUS    64
`define EECU_ACK_SZ      5
`define EECU_A_NACK      4
`define EECU_A_QID_HI    3
`define EECU_A_QID_LO    0


// Enet Egress Packet Unit
`define EEPU_REQ_BUS    55
`define EEPU_REQ_SZ     55
`define EEPU_R_TLEN_HI  54
`define EEPU_R_TLEN_LO  48
`define EEPU_R_SOF      47
`define EEPU_R_EOF      46
`define EEPU_R_PORT_HI  45
`define EEPU_R_PORT_LO  44
`define EEPU_R_QID_HI   43
`define EEPU_R_QID_LO   40
`define EEPU_R_ADD_HI   39
`define EEPU_R_ADD_LO    0

// This is cleaved in between Egress Datapath Ack's
`define EEPU_ACK_BUS     6
`define EEPU_ACK_SZ      6
`define EEPU_A_EOF       5
`define EEPU_A_NACK      4
`define EEPU_A_QID_HI    3
`define EEPU_A_QID_LO    0


// Enet Egress Datapath
`define EEDP_ACK_BUS   128
`define EEDP_ACK_SZ     28
`define EEDP_A_NACK     27
`define EEDP_A_QID_HI   26
`define EEDP_A_QID_LO   21
`define EEDP_A_SOF      20
`define EEDP_A_EOF      19
`define EEDP_A_LEN_HI   18
`define EEDP_A_LEN_LO   12
`define EEDP_A_TAG_HI   11
`define EEDP_A_TAG_LO    0
`define EEDP_A_PORT_HI   5
`define EEDP_A_PORT_LO   4
`define EEDP_A_PORT_WIDTH 2


// In-Order / Ordered Queue: EEPU
// Tag is: TLEN, SOF, EOF, QID = 15
`define EEPU_TAG_ARY     (7+1+1+6)
`define EEPU_ENTRIES     16
`define EEPU_E_IDX        4
`define EEPU_PORTS        4
`define EEPU_P_IDX        2

// Nack + Tag Info + CTag
`define IOQ_TAG_ARY      (1+`EEPU_TAG_ARY+12)
`define EEPU_TAG_LOC     (`EEPU_P_IDX+`EEPU_E_IDX)


// ENET Ingress Queue Management Req
`define EICU_REQ_BUS     64 
`define EICU_REQ_SZ      62
`define EICU_R_CTAG_HI   61
`define EICU_R_CTAG_LO   50
`define EICU_R_ADD_HI    49
`define EICU_R_ADD_LO    10
`define EICU_R_LEN_HI     9
`define EICU_R_LEN_LO     3
`define EICU_R_COS        1
`define EICU_R_READ       0   


// ENET Ingress Queue Management Ack
`define EICU_ACK_BUS     64
`define EICU_ACK_SZ      14
`define EICU_A_NACK      13
`define EICU_A_READ      12
`define EICU_A_CTAG_HI   11
`define EICU_A_CTAG_LO    0


// Enet Ingress Packet Unit
`define EIPU_REQ_BUS    128 
`define EIPU_REQ_SZ      59
`define EIPU_R_CTAG_HI   58
`define EIPU_R_CTAG_LO   50
`define EIPU_R_ADD_HI    49
`define EIPU_R_ADD_LO    10
`define EIPU_R_LEN_HI     9
`define EIPU_R_LEN_LO     3
`define EIPU_R_COS        1
`define EIPU_R_READ       0   


// ENET Ingress Packet Unit Ack
`define EIPU_ACK_BUS      10
`define EIPU_ACK_SZ       10
`define EIPU_A_NACK       9
`define EIPU_A_CTAG_HI    8
`define EIPU_A_CTAG_LO    0


// In-Order / Ordered Queue: PCI
// Tag is: CTAG
`define PCI_TAG_ARY     12
`define PCI_ENTRIES     16
`define PCI_E_IDX        4
`define PCI_PORTS        2

// PCI-X Request
`define PCI_REQ_BUS      64
`define PCI_REQ_SZ       62
`define PCI_R_CTAG_HI    61
`define PCI_R_CTAG_LO    50
`define PCI_R_ADD_HI     49
`define PCI_R_ADD_LO     10
`define PCI_R_LEN_HI      9
`define PCI_R_LEN_LO      3
`define PCI_R_COS         1
`define PCI_R_READ        0

// PCI_X Acknowledge
`define PCI_ACK_BUS      64
`define PCI_ACK_SZ       14
`define PCI_A_NACK       13
`define PCI_A_READ       12 
`define PCI_A_CTAG_HI    11
`define PCI_A_CTAG_LO     0


`define BSC_MAX_REQ_SZ   62


//
// BSC array sizes
//================
//
`define BSC_REQ_ARY_INDEX        6
`define BSC_REQ_ARY_DEPTH       64
`define BSC_REQ_ARY_WIDTH       62
`define BSC_REQ_NXT_WIDTH       12
`define BSC_ACK_ARY_INDEX        6
`define BSC_ACK_ARY_DEPTH       64
`define BSC_ACK_ARY_WIDTH       14
`define BSC_ACK_NXT_WIDTH       12
`define BSC_PAY_ARY_INDEX        6
`define BSC_PAY_ARY_DEPTH       64
`define BSC_PAY_ARY_WIDTH      256

// ECC syndrome bits per memory element
`define BSC_PAY_ECC             10
`define BSC_PAY_MEM_WIDTH       (`BSC_PAY_ECC+`BSC_PAY_ARY_WIDTH)


//
// BSC Port Definitions
// ====================
//
// Bits 7 to 4 of curr_port_id
`define BSC_PORT_NULL       4'h0
`define BSC_PORT_SC         4'h1
`define BSC_PORT_EICU       4'h2
`define BSC_PORT_EIPU       4'h3
`define BSC_PORT_EECU       4'h4
`define BSC_PORT_EEPU       4'h8
`define BSC_PORT_PCI        4'h9

// Number of ports of each type
`define BSC_PORT_SC_CNT     8

// Bits needed to represent above
`define BSC_PORT_SC_IDX     3

// How wide the linked list pointers are
// 60b for no payload (2CoS)
// 80b for payload (2CoS)

//`define BSC_OBJ_PTR   80
//`define BSC_HD1_HI    69
//`define BSC_HD1_LO    60
//`define BSC_TL1_HI    59
//`define BSC_TL1_LO    50
//`define BSC_CT1_HI    49
//`define BSC_CT1_LO    40
//`define BSC_HD0_HI    29
//`define BSC_HD0_LO    20
//`define BSC_TL0_HI    19
//`define BSC_TL0_LO    10
//`define BSC_CT0_HI     9
//`define BSC_CT0_LO     0

`define BSC_OBJP_PTR  48
`define BSC_PYP1_HI   47
`define BSC_PYP1_LO   42
`define BSC_HDP1_HI   41
`define BSC_HDP1_LO   36
`define BSC_TLP1_HI   35
`define BSC_TLP1_LO   30
`define BSC_CTP1_HI   29
`define BSC_CTP1_LO   24
`define BSC_PYP0_HI   23
`define BSC_PYP0_LO   18
`define BSC_HDP0_HI   17
`define BSC_HDP0_LO   12
`define BSC_TLP0_HI   11
`define BSC_TLP0_LO    6
`define BSC_CTP0_HI    5
`define BSC_CTP0_LO    0

`define BSC_PTR_WIDTH     192
`define BSC_PTR_REQ_HI    191
`define BSC_PTR_REQ_LO    144
`define BSC_PTR_REQP_HI   143
`define BSC_PTR_REQP_LO    96
`define BSC_PTR_ACK_HI     95
`define BSC_PTR_ACK_LO     48
`define BSC_PTR_ACKP_HI    47
`define BSC_PTR_ACKP_LO     0

`define BSC_PORT_SC_PTR    96       // R, R+P
`define BSC_PORT_EECU_PTR  48       // A+P
`define BSC_PORT_EICU_PTR  96       // A, A+P
`define BSC_PORT_EIPU_PTR  48       // A

// I2C STATES in DRAMctl
`define I2C_CMD_NOP   4'b0000
`define I2C_CMD_START 4'b0001
`define I2C_CMD_STOP  4'b0010
`define I2C_CMD_WRITE 4'b0100
`define I2C_CMD_READ  4'b1000


//
// IOB defines
// ===========
//
`define IOB_ADDR_WIDTH       40
`define IOB_LOCAL_ADDR_WIDTH 32

`define IOB_CPU_INDEX         3
`define IOB_CPU_WIDTH         8
`define IOB_THR_INDEX         2
`define IOB_THR_WIDTH         4
`define IOB_CPUTHR_INDEX      5
`define IOB_CPUTHR_WIDTH     32

`define IOB_MONDO_DATA_INDEX  5
`define IOB_MONDO_DATA_DEPTH 32
`define IOB_MONDO_DATA_WIDTH 64
`define IOB_MONDO_SRC_WIDTH   5
`define IOB_MONDO_BUSY        5

`define IOB_INT_TAB_INDEX     6
`define IOB_INT_TAB_DEPTH    64 

`define IOB_INT_STAT_WIDTH   32
`define IOB_INT_STAT_HI      31
`define IOB_INT_STAT_LO       0

`define IOB_INT_VEC_WIDTH     6
`define IOB_INT_VEC_HI        5
`define IOB_INT_VEC_LO        0

`define IOB_INT_CPU_WIDTH     5
`define IOB_INT_CPU_HI       12 
`define IOB_INT_CPU_LO        8

`define IOB_INT_MASK          2
`define IOB_INT_CLEAR         1
`define IOB_INT_PEND          0

`define IOB_DISP_TYPE_HI     17
`define IOB_DISP_TYPE_LO     16
`define IOB_DISP_THR_HI      12
`define IOB_DISP_THR_LO       8
`define IOB_DISP_VEC_HI       5
`define IOB_DISP_VEC_LO       0

`define IOB_JBI_RESET         1
`define IOB_ENET_RESET        0

`define IOB_RESET_STAT_WIDTH  3
`define IOB_RESET_STAT_HI     3
`define IOB_RESET_STAT_LO     1

`define IOB_SERNUM_WIDTH     64

`define IOB_FUSE_WIDTH       22

`define IOB_TMSTAT_THERM     63

`define IOB_POR_TT            6'b01  // power-on-reset trap type

`define IOB_CPU_BUF_INDEX     4

`define IOB_INT_BUF_INDEX     4  
`define IOB_INT_BUF_WIDTH   153  // interrupt table read result buffer width

`define IOB_IO_BUF_INDEX      4
`define IOB_IO_BUF_WIDTH    153  // io-2-cpu return buffer width

`define IOB_L2_VIS_BUF_INDEX  5
`define IOB_L2_VIS_BUF_WIDTH 48  // l2 visibility buffer width

`define IOB_INT_AVEC_WIDTH   16  // availibility vector width
`define IOB_ACK_AVEC_WIDTH   16  // availibility vector width 

// fixme - double check address mapping
// CREG in `IOB_INT_CSR space
`define IOB_DEV_ADDR_MASK    32'hfffffe07
`define IOB_CREG_INTSTAT     32'h00000000
`define IOB_CREG_MDATA0      32'h00000400
`define IOB_CREG_MDATA1      32'h00000500
`define IOB_CREG_MBUSY       32'h00000900
`define IOB_THR_ADDR_MASK    32'hffffff07
`define IOB_CREG_MDATA0_ALIAS 32'h00000600
`define IOB_CREG_MDATA1_ALIAS 32'h00000700
`define IOB_CREG_MBUSY_ALIAS  32'h00000b00

// CREG in `IOB_MAN_CSR space
`define IOB_CREG_INTMAN      32'h00000000
`define IOB_CREG_INTCTL      32'h00000400
`define IOB_CREG_INTVECDISP  32'h00000800
`define IOB_CREG_RESETSTAT   32'h00000810
`define IOB_CREG_SERNUM      32'h00000820
`define IOB_CREG_TMSTATCTRL  32'h00000828
`define IOB_CREG_COREAVAIL   32'h00000830
`define IOB_CREG_SSYSRESET   32'h00000838
`define IOB_CREG_FUSESTAT    32'h00000840
`define IOB_CREG_JINTV       32'h00000a00

`define IOB_CREG_DBG_L2VIS_CTRL    32'h00001800 
`define IOB_CREG_DBG_L2VIS_MASKA   32'h00001820 
`define IOB_CREG_DBG_L2VIS_MASKB   32'h00001828 
`define IOB_CREG_DBG_L2VIS_CMPA    32'h00001830
`define IOB_CREG_DBG_L2VIS_CMPB    32'h00001838
`define IOB_CREG_DBG_L2VIS_TRIG    32'h00001840
`define IOB_CREG_DBG_IOBVIS_CTRL   32'h00001000
`define IOB_CREG_DBG_ENET_CTRL     32'h00002000
`define IOB_CREG_DBG_ENET_IDLEVAL  32'h00002008
`define IOB_CREG_DBG_JBUS_CTRL     32'h00002100
`define IOB_CREG_DBG_JBUS_LO_MASK0 32'h00002140
`define IOB_CREG_DBG_JBUS_LO_MASK1 32'h00002160
`define IOB_CREG_DBG_JBUS_LO_CMP0  32'h00002148
`define IOB_CREG_DBG_JBUS_LO_CMP1  32'h00002168
`define IOB_CREG_DBG_JBUS_LO_CNT0  32'h00002150
`define IOB_CREG_DBG_JBUS_LO_CNT1  32'h00002170
`define IOB_CREG_DBG_JBUS_HI_MASK0 32'h00002180
`define IOB_CREG_DBG_JBUS_HI_MASK1 32'h000021a0
`define IOB_CREG_DBG_JBUS_HI_CMP0  32'h00002188
`define IOB_CREG_DBG_JBUS_HI_CMP1  32'h000021a8
`define IOB_CREG_DBG_JBUS_HI_CNT0  32'h00002190
`define IOB_CREG_DBG_JBUS_HI_CNT1  32'h000021b0

`define IOB_CREG_TESTSTUB    32'h80000000

// Address map for TAP access of SPARC ASI
`define IOB_ASI_PC            4'b0000
`define IOB_ASI_BIST          4'b0001
`define IOB_ASI_MARGIN        4'b0010
`define IOB_ASI_DEFEATURE     4'b0011
`define IOB_ASI_L1DD          4'b0100
`define IOB_ASI_L1ID          4'b0101
`define IOB_ASI_L1DT          4'b0110

`define IOB_INT               2'b00
`define IOB_RESET             2'b01
`define IOB_IDLE              2'b10
`define IOB_RESUME            2'b11

//
// CIOP UCB Bus Width
// ==================
//
`define IOB_EECU_WIDTH       16  // ethernet egress command
`define EECU_IOB_WIDTH       16

`define IOB_NRAM_WIDTH       16  // NRAM (RLDRAM previously)
`define NRAM_IOB_WIDTH        4

`define IOB_JBI_WIDTH        16  // JBI
`define JBI_IOB_WIDTH        16 

`define IOB_ENET_ING_WIDTH   32  // ethernet ingress
`define ENET_ING_IOB_WIDTH    8

`define IOB_ENET_EGR_WIDTH    4  // ethernet egress
`define ENET_EGR_IOB_WIDTH    4

`define IOB_ENET_MAC_WIDTH    4  // ethernet MAC
`define ENET_MAC_IOB_WIDTH    4

`define IOB_DRAM_WIDTH        4  // DRAM controller
`define DRAM_IOB_WIDTH        4

`define IOB_BSC_WIDTH         4  // BSC
`define BSC_IOB_WIDTH         4

`define IOB_SPI_WIDTH         4  // SPI (Boot ROM)
`define SPI_IOB_WIDTH         4

`define IOB_CLK_WIDTH         4  // clk unit
`define CLK_IOB_WIDTH         4

`define IOB_CLSP_WIDTH        4  // clk spine unit
`define CLSP_IOB_WIDTH        4

`define IOB_TAP_WIDTH         8  // TAP
`define TAP_IOB_WIDTH         8


//
// CIOP UCB Buf ID Type
// ====================
//
`define UCB_BID_CMP          2'b00
`define UCB_BID_TAP          2'b01

//
// Interrupt Device ID
// ===================
//
// Caution: DUMMY_DEV_ID has to be 9 bit wide
//          for fields to line up properly in the IOB.
`define DUMMY_DEV_ID         9'h10   // 16
`define UNCOR_ECC_DEV_ID     7'd17   // 17

//
// Soft Error related definitions 
// ==============================
//
`define COR_ECC_CNT_WIDTH   16


//
// CMP clock
// =========
//

`define CMP_CLK_PERIOD   1333


//
// NRAM/IO Interface
// =================
//

`define DRAM_CLK_PERIOD  6000

`define NRAM_IO_DQ_WIDTH   32
`define IO_NRAM_DQ_WIDTH   32

`define NRAM_IO_ADDR_WIDTH 15
`define NRAM_IO_BA_WIDTH    2


//
// NRAM/ENET Interface
// ===================
//

`define NRAM_ENET_DATA_WIDTH 64
`define ENET_NRAM_ADDR_WIDTH 20

`define NRAM_DBG_DATA_WIDTH  40


//
// IO/FCRAM Interface
// ==================
//

`define FCRAM_DATA1_HI       63
`define FCRAM_DATA1_LO       32
`define FCRAM_DATA0_HI       31
`define FCRAM_DATA0_LO        0

//
// PCI Interface
// ==================
// Load/store size encodings
// -------------------------
// Size encoding
// 000 - byte
// 001 - half-word
// 010 - word
// 011 - double-word
// 100 - quad
`define LDST_SZ_BYTE        3'b000
`define LDST_SZ_HALF_WORD   3'b001
`define LDST_SZ_WORD        3'b010
`define LDST_SZ_DOUBLE_WORD 3'b011
`define LDST_SZ_QUAD        3'b100

//
// JBI<->SCTAG Interface
// =======================
// Outbound Header Format
`define JBI_BTU_OUT_ADDR_LO      0
`define JBI_BTU_OUT_ADDR_HI     42
`define JBI_BTU_OUT_RSV0_LO     43
`define JBI_BTU_OUT_RSV0_HI     43
`define JBI_BTU_OUT_TYPE_LO     44
`define JBI_BTU_OUT_TYPE_HI     48
`define JBI_BTU_OUT_RSV1_LO     49
`define JBI_BTU_OUT_RSV1_HI     51
`define JBI_BTU_OUT_REPLACE_LO  52
`define JBI_BTU_OUT_REPLACE_HI  56
`define JBI_BTU_OUT_RSV2_LO     57
`define JBI_BTU_OUT_RSV2_HI     59
`define JBI_BTU_OUT_BTU_ID_LO   60
`define JBI_BTU_OUT_BTU_ID_HI   71
`define JBI_BTU_OUT_DATA_RTN    72
`define JBI_BTU_OUT_RSV3_LO     73
`define JBI_BTU_OUT_RSV3_HI     75
`define JBI_BTU_OUT_CE          76
`define JBI_BTU_OUT_RSV4_LO     77
`define JBI_BTU_OUT_RSV4_HI     79
`define JBI_BTU_OUT_UE          80
`define JBI_BTU_OUT_RSV5_LO     81
`define JBI_BTU_OUT_RSV5_HI     83
`define JBI_BTU_OUT_DRAM        84
`define JBI_BTU_OUT_RSV6_LO     85
`define JBI_BTU_OUT_RSV6_HI    127

// Inbound Header Format
`define JBI_SCTAG_IN_ADDR_LO   0
`define JBI_SCTAG_IN_ADDR_HI  39
`define JBI_SCTAG_IN_SZ_LO    40
`define JBI_SCTAG_IN_SZ_HI    42
`define JBI_SCTAG_IN_RSV0     43
`define JBI_SCTAG_IN_TAG_LO   44
`define JBI_SCTAG_IN_TAG_HI   55
`define JBI_SCTAG_IN_REQ_LO   56
`define JBI_SCTAG_IN_REQ_HI   58
`define JBI_SCTAG_IN_POISON   59
`define JBI_SCTAG_IN_RSV1_LO  60
`define JBI_SCTAG_IN_RSV1_HI  63

`define JBI_SCTAG_REQ_WRI   3'b100
`define JBI_SCTAG_REQ_WR8   3'b010
`define JBI_SCTAG_REQ_RDD   3'b001
`define JBI_SCTAG_REQ_WRI_BIT 2
`define JBI_SCTAG_REQ_WR8_BIT 1
`define JBI_SCTAG_REQ_RDD_BIT 0

//
// JBI->IOB Mondo Header Format
// ============================
//
`define JBI_IOB_MONDO_RSV1_HI       15 // reserved 1
`define JBI_IOB_MONDO_RSV1_LO       13
`define JBI_IOB_MONDO_TRG_HI        12 // interrupt target
`define JBI_IOB_MONDO_TRG_LO         8 
`define JBI_IOB_MONDO_RSV0_HI        7 // reserved 0
`define JBI_IOB_MONDO_RSV0_LO        5
`define JBI_IOB_MONDO_SRC_HI         4 // interrupt source
`define JBI_IOB_MONDO_SRC_LO         0

`define JBI_IOB_MONDO_RSV1_WIDTH     3 
`define JBI_IOB_MONDO_TRG_WIDTH      5
`define JBI_IOB_MONDO_RSV0_WIDTH     3 
`define JBI_IOB_MONDO_SRC_WIDTH      5

// JBI->IOB Mondo Bus Width/Cycle
// ==============================
// Cycle  1 Header[15:8]
// Cycle  2 Header[ 7:0]
// Cycle  3 J_AD[127:120]
// Cycle  4 J_AD[119:112]
// .....
// Cycle 18 J_AD[  7:  0]
`define JBI_IOB_MONDO_BUS_WIDTH      8
`define JBI_IOB_MONDO_BUS_CYCLE     18 // 2 header + 16 data


 

`define	IQ_SIZE	8
`define	OQ_SIZE	12
`define	TAG_WIDTH	28
`define	TAG_WIDTH_LESS1	27
`define	TAG_WIDTHr	28r
`define	TAG_WIDTHc	28c
`define	TAG_WIDTH6	22
`define	TAG_WIDTH6r	22r
`define	TAG_WIDTH6c	22c


`define	MBD_WIDTH	106    // BS and SR 11/12/03 N2 Xbar Packet format change

// BS and SR 11/12/03 N2 Xbar Packet format change

`define	MBD_ECC_HI	105
`define	MBD_ECC_HI_PLUS1	106
`define	MBD_ECC_HI_PLUS5	110
`define	MBD_ECC_LO	100
`define	MBD_EVICT	99 
`define	MBD_DEP		98
`define	MBD_TECC	97
`define	MBD_ENTRY_HI	96
`define	MBD_ENTRY_LO	93

`define	MBD_POISON	92   
`define	MBD_RDMA_HI	91
`define	MBD_RDMA_LO	90
`define	MBD_RQ_HI	89
`define	MBD_RQ_LO	85
`define	MBD_NC		84
`define	MBD_RSVD	83
`define	MBD_CP_HI	82
`define	MBD_CP_LO	80
`define	MBD_TH_HI	79
`define	MBD_TH_LO	77
`define	MBD_BF_HI	76
`define	MBD_BF_LO	74
`define	MBD_WY_HI	73
`define	MBD_WY_LO	72
`define	MBD_SZ_HI	71
`define	MBD_SZ_LO	64
`define	MBD_DATA_HI	63
`define	MBD_DATA_LO	0

// BS and SR 11/12/03 N2 Xbar Packet format change
`define	L2_FBF		40
`define	L2_MBF		39
`define	L2_SNP		38
`define	L2_CTRUE	37
`define	L2_EVICT  	36
`define	L2_DEP		35
`define	L2_TECC		34
`define	L2_ENTRY_HI	33
`define	L2_ENTRY_LO	29

`define	L2_POISON	28
`define	L2_RDMA_HI	27
`define	L2_RDMA_LO	26
// BS and SR 11/12/03 N2 Xbar Packet format change , maps to bits [128:104] of PCXS packet , ther than RSVD bit
`define	L2_RQTYP_HI	25
`define	L2_RQTYP_LO	21
`define	L2_NC		20
`define	L2_RSVD		19
`define	L2_CPUID_HI	18
`define	L2_CPUID_LO	16
`define	L2_TID_HI	15	
`define	L2_TID_LO	13	
`define	L2_BUFID_HI     12	
`define	L2_BUFID_LO	10	
`define	L2_L1WY_HI	9
`define	L2_L1WY_LO	8
`define	L2_SZ_HI	7
`define	L2_SZ_LO	0


`define	ERR_MEU		63
`define	ERR_MEC		62
`define	ERR_RW		61
`define	ERR_ASYNC	60
`define	ERR_TID_HI	59 // PRM needs to change to reflect this : TID will be bits [59:54] instead of [58:54]
`define	ERR_TID_LO	54
`define	ERR_LDAC	53
`define	ERR_LDAU	52
`define	ERR_LDWC	51
`define	ERR_LDWU	50
`define	ERR_LDRC	49
`define	ERR_LDRU	48
`define	ERR_LDSC	47
`define	ERR_LDSU	46
`define	ERR_LTC		45
`define	ERR_LRU		44
`define	ERR_LVU		43
`define	ERR_DAC		42
`define	ERR_DAU		41
`define	ERR_DRC		40
`define	ERR_DRU		39
`define	ERR_DSC		38
`define	ERR_DSU		37
`define	ERR_VEC		36
`define	ERR_VEU		35
`define ERR_LVC         34
`define	ERR_SYN_HI	31
`define	ERR_SYN_LO	0



`define ERR_MEND	51
`define ERR_NDRW	50
`define ERR_NDSP	49
`define ERR_NDDM	48
`define ERR_NDVCID_HI   45
`define ERR_NDVCID_LO   40
`define ERR_NDADR_HI    39
`define ERR_NDADR_LO    4


//  Phase 2 : SIU Inteface and format change

`define	JBI_HDR_SZ	26 // BS and SR 11/12/03 N2 Xbar Packet format change
`define	JBI_HDR_SZ_LESS1	25 // BS and SR 11/12/03 N2 Xbar Packet format change
`define	JBI_HDR_SZ4     23	
`define	JBI_HDR_SZc	27c
`define	JBI_HDR_SZ4c    23c	

`define	JBI_ADDR_LO	0	
`define	JBI_ADDR_HI	7	
`define	JBI_SZ_LO	8	
`define	JBI_SZ_HI	15	
// `define	JBI_RSVD	16	NOt used
`define	JBI_CTAG_LO	16	
`define	JBI_CTAG_HI	23	
`define	JBI_RQ_RD	24	
`define	JBI_RQ_WR8	25	
`define	JBI_RQ_WR64	26	
`define JBI_OPES_LO	27	// 0 = 30, P=29, E=28, S=27
`define JBI_OPES_HI	30
`define	JBI_RQ_POISON	31	
`define	JBI_ENTRY_LO	32
`define	JBI_ENTRY_HI	33

//  Phase 2 : SIU Inteface and format change
// BS and SR 11/12/03 N2 Xbar Packet format change :
`define	JBINST_SZ_LO	0	
`define	JBINST_SZ_HI	7	
// `define	JBINST_RSVD	8 NOT used	
`define	JBINST_CTAG_LO	8	
`define	JBINST_CTAG_HI	15	
`define	JBINST_RQ_RD	16	
`define	JBINST_RQ_WR8	17	
`define	JBINST_RQ_WR64	18	
`define JBINST_OPES_LO  19	// 0 = 22, P=21, E=20, S=19
`define JBINST_OPES_HI  22
`define	JBINST_ENTRY_LO	23
`define	JBINST_ENTRY_HI	24
`define	JBINST_POISON   25


`define	ST_REQ_ST	1
`define	LD_REQ_ST	2
`define	IDLE	0


 
module l2t_tagd_dp (
  tcu_pce_ov, 
  tcu_aclk, 
  tcu_bclk, 
  tcu_scan_en, 
  tcu_clk_stop, 
  tcu_muxtest, 
  tcu_dectest, 
  arbadr_ncu_l2t_pm_n_dist, 
  arbadr_2bnk_true_enbld_dist, 
  arbadr_4bnk_true_enbld_dist, 
  arbadr_dir_cam_addr_c3, 
  arbadr_arbaddr_idx_c3, 
  arbadr_arbdp_tagdata_px2, 
  tagl_tag_quad0_c3, 
  tagl_tag_quad1_c3, 
  tagl_tag_quad2_c3, 
  tagl_tag_quad3_c3, 
  tagdp_tag_quad_muxsel_c3, 
  tagd_dmo_evict_tag_c4, 
  tagd_diag_data_c7, 
  tagd_lkup_addr_c4, 
  tagd_lkup_row_addr_dcd_c3, 
  tagd_lkup_row_addr_icd_c3, 
  tagd_mbdata_inst_tecc_c8, 
  scan_out, 
  tagd_lkup_tag_c1, 
  arbadr_arbdp_tag_idx_px2, 
  mbist_l2t_index, 
  arb_tag_way_px2, 
  mbist_l2t_dec_way, 
  arb_tag_rd_px2, 
  mbist_l2t_read, 
  arb_tag_wr_px2, 
  mbist_l2t_write, 
  arbadr_tag_wrdata_px2, 
  mbist_write_data, 
  tagd_arbdp_tag_idx_px2_buf_1, 
  tagd_arbdp_tag_idx_px2_buf_2, 
  tagd_mbist_l2t_index_buf, 
  tagd_arb_tag_way_px2_buf, 
  tagd_mbist_l2t_dec_way_buf, 
  tagd_arb_tag_rd_px2_buf, 
  tagd_mbist_l2t_read_buf, 
  tagd_arb_tag_wr_px2_buf, 
  tagd_mbist_l2t_write_buf, 
  tagd_tag_wrdata_px2_buf, 
  tagd_mbist_write_data_buf, 
  arb_evict_c3, 
  l2clk, 
  scan_in, 
  tagd_evict_tag_c3, 
  mbist_l2tag_fail);
wire stop;
wire pce_ov;
wire siclk;
wire soclk;
wire se;
wire muxtst;
wire test;
wire ff_wrdata_tag_c1_scanin;
wire ff_wrdata_tag_c1_scanout;
wire [29:6] tmp_lkup_tag_c1_unused;
wire arbadr_ncu_l2t_pm_n;
wire arbadr_4bnk_true_enbld;
wire arbadr_2bnk_true_enbld;
wire arb_evict_c3_n;
wire ff_tagd_lkup_addr_c4_scanin;
wire ff_tagd_lkup_addr_c4_scanout;
wire ff_tag_array_read_data_scanin;
wire ff_tag_array_read_data_scanout;
wire [27:0] tag_array_read_data;
wire [36:0] piped_vuad_data_input;
wire [7:0] tagd_mbist_write_data_r1;
wire [7:0] tagd_mbist_write_data_r2;
wire [7:0] tagd_mbist_write_data_r3;
wire mbist_l2t_read_r1;
wire mbist_l2t_read_r2;
wire mbist_l2t_read_r3;
wire mbist_l2tag_fail_unreg;
wire [7:0] tagd_mbist_write_data_r4;
wire mbist_l2t_read_r4;
wire [36:0] piped_vuad_data_output;
wire ff_piped_vuad0_scanin;
wire ff_piped_vuad0_scanout;
wire ff_piped_vuad1_scanin;
wire ff_piped_vuad1_scanout;
wire mbist_l2tag_fail_raw;
wire mbist_l2t_read_r4_n;
wire ff_tagd_evict_tag_c4_scanin;
wire ff_tagd_evict_tag_c4_scanout;
wire [27:0] tagd_evict_tag_c4;
wire ff_tagd_diag_data_c52_scanin;
wire ff_tagd_diag_data_c52_scanout;
wire ff_tagd_diag_data_c6_scanin;
wire ff_tagd_diag_data_c6_scanout;
wire ff_tagd_diag_data_c7_scanin;
wire ff_tagd_diag_data_c7_scanout;
wire ff_ecc_staging1_4_scanin;
wire ff_ecc_staging1_4_scanout;
wire ff_ecc_staging5_8_scanin;
wire ff_ecc_staging5_8_scanout;
 

 input tcu_pce_ov;
 input tcu_aclk;
 input tcu_bclk;
 input tcu_scan_en;
 input tcu_clk_stop;
 input tcu_muxtest;
 input tcu_dectest;

input          arbadr_ncu_l2t_pm_n_dist; // BS 03/25/04 for partial bank/core modes support
input          arbadr_2bnk_true_enbld_dist;// BS 03/25/04 for partial bank/core modes support
input          arbadr_4bnk_true_enbld_dist; // BS 03/25/04 for partial bank/core modes support
input	[39:7] arbadr_dir_cam_addr_c3; // from arbaddr 
input	[10:0] 	arbadr_arbaddr_idx_c3; // from arbaddr 
input	[`TAG_WIDTH-1:6] arbadr_arbdp_tagdata_px2 ; // write data for tag. 
 
input  [`TAG_WIDTH-1:0] tagl_tag_quad0_c3; 
input  [`TAG_WIDTH-1:0] tagl_tag_quad1_c3; 
input  [`TAG_WIDTH-1:0] tagl_tag_quad2_c3; 
input  [`TAG_WIDTH-1:0] tagl_tag_quad3_c3; 
 
input	 [3:0]   tagdp_tag_quad_muxsel_c3 ; // to tagd 
 
output	[`TAG_WIDTH-1:0] tagd_dmo_evict_tag_c4; // to wbdata.  
output	[`TAG_WIDTH-1:0] tagd_diag_data_c7; // to oque 
 
output	[17:9]	tagd_lkup_addr_c4;	// to the directory, BS and SR 11/18/03 Reverse Directory change 
output	[2:0]	tagd_lkup_row_addr_dcd_c3, tagd_lkup_row_addr_icd_c3; 
 
 
output	[5:0]	tagd_mbdata_inst_tecc_c8; // to miss buffer data. 
output scan_out; 
 
// tagd_lkup_tag_c1[`TAG_WIDTH-1:6] replaces wrdata_tag_c1; 
 
output	[`TAG_WIDTH-1:1] tagd_lkup_tag_c1; // to tag. 
 
input	[8:0]	arbadr_arbdp_tag_idx_px2; // BS & SR 10/28/03 
input	[8:0]	mbist_l2t_index; // BS & SR 10/28/03 
 
input	[15:0]	arb_tag_way_px2; // BS & SR 10/28/03 
input	[15:0]	mbist_l2t_dec_way; // BS & SR 10/28/03 
 
input		arb_tag_rd_px2; 
input		mbist_l2t_read; 
 
input		arb_tag_wr_px2; 
input		mbist_l2t_write; 
 
input	[27:0]	arbadr_tag_wrdata_px2; 
input	[7:0]	mbist_write_data; 
 
output   [8:0]   tagd_arbdp_tag_idx_px2_buf_1; // BS & SR 10/28/03 
output   [8:0]   tagd_arbdp_tag_idx_px2_buf_2; // BS & SR 10/28/03 
output   [8:0]   tagd_mbist_l2t_index_buf; // BS & SR 10/28/03 
 
output   [15:0]  tagd_arb_tag_way_px2_buf; // BS & SR 10/28/03 
output   [15:0]  tagd_mbist_l2t_dec_way_buf; // BS & SR 10/28/03         
 
output           tagd_arb_tag_rd_px2_buf; 
output           tagd_mbist_l2t_read_buf; 
 
output           tagd_arb_tag_wr_px2_buf; 
output           tagd_mbist_l2t_write_buf; 
 
output   [27:0]  tagd_tag_wrdata_px2_buf; 
output   [7:0]   tagd_mbist_write_data_buf; 
input	        arb_evict_c3; 
input		l2clk; 
input 		scan_in; 

output	[27:0]	tagd_evict_tag_c3;

output		mbist_l2tag_fail;

assign stop = tcu_clk_stop;
assign pce_ov = tcu_pce_ov;
assign siclk = tcu_aclk;
assign soclk = tcu_bclk;
assign se = tcu_scan_en;
assign muxtst = tcu_muxtest;
assign test = tcu_dectest;


 
wire	[5:0]	parity_c1; 
wire	[5:0]	tag_acc_ecc_c1, tag_acc_ecc_c2, tag_acc_ecc_c3; 
wire	[5:0]	tag_acc_ecc_c4, tag_acc_ecc_c5, tag_acc_ecc_c52, tag_acc_ecc_c6; // BS 03/11/04 extra cycle for mem access 
wire	[5:0]	tag_acc_ecc_c7; 
 
wire	[`TAG_WIDTH-1:0] tagd_evict_tag_c3, tagd_diag_data_c6, tagd_diag_data_c52; // to oque 
wire	[39:7]  evict_addr_c3; 
wire    [21:0]        tagd_evict_tag_orig_c3;
wire	[39:7]	lkup_addr_c3; 
wire	[`TAG_WIDTH-1:6] wrdata_tag_c1; 
 
 
wire    [8:0]   lkup_addr_c3_tmp; 
 
//**************************************************************** 
// Changes start here. 
 
// reduced the width of this flop. 

l2t_tagd_dp_msff_macro__dmsff_32x__stack_22r__width_22 ff_wrdata_tag_c1  // int 5.0 changes
		(.din(arbadr_arbdp_tagdata_px2[`TAG_WIDTH-1:6]), .clk(l2clk), 
               .scan_in(ff_wrdata_tag_c1_scanin),
               .scan_out(ff_wrdata_tag_c1_scanout),
               .dout(wrdata_tag_c1[`TAG_WIDTH-1:6]), .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop) 
); 
 
l2t_ecc24b_dp     tagecc0 
	(
	.din({2'b0,wrdata_tag_c1[`TAG_WIDTH-1:6]}), 
        .dout(tmp_lkup_tag_c1_unused[29:6]), 
        .parity(parity_c1[5:0])
	); 
 
assign  tag_acc_ecc_c1 = { parity_c1[4:0], parity_c1[5] } ; 
 
 
///////////////////////////////////////////////////////// 
// To prevent the tag_acc_ecc_c1 bits from being 
// part of the critical path in the tag compare operation, 
// the overall parity bit P is not compared  
// 
// The check bits in tag_acc_ecc_c1 take 4 levels of XOR 
// to compute whereas the overall parity P takes 5 levels. 
// 
// Not comparing P means that a hit could be signalled 
// inspite of an error in the P bit. This requires the 
// parity computation in C2 to account for this case 
// and not cause any Miss Buffer insertions. 
///////////////////////////////////////////////////////// 
 
assign  tagd_lkup_tag_c1[`TAG_WIDTH-1:6] =   wrdata_tag_c1[`TAG_WIDTH-1:6] ; 
assign  tagd_lkup_tag_c1[5:1] =   tag_acc_ecc_c1[5:1]  ;  
 
///////////////////////////////////////////// 
// Directory lkup address 
///////////////////////////////////////////// 

l2t_tagd_dp_mux_macro__mux_aonpe__ports_3__stack_22r__width_22 mux_tagd_evict_tag_orig_c3 
                        (.dout (tagd_evict_tag_orig_c3[21:0]) ,
                        .din0(tagd_evict_tag_c3[`TAG_WIDTH-1:6]), // original idx , all banks enabled
                        .din1({1'b0,tagd_evict_tag_c3[`TAG_WIDTH-1:7]}),
                                      // 1 bit shifted idx in case of 4 banks enabled
                        .din2({2'b0,tagd_evict_tag_c3[`TAG_WIDTH-1:8]}), 
                                     // 2 bit shifted idx in case of 2 banks enabled
                        .sel0(arbadr_ncu_l2t_pm_n),
                        .sel1(arbadr_4bnk_true_enbld),
                        .sel2(arbadr_2bnk_true_enbld)
                        );

 
assign	evict_addr_c3[39:7] = { tagd_evict_tag_orig_c3[21:0], 
				arbadr_arbaddr_idx_c3[10:0] } ; 
 
l2t_tagd_dp_inv_macro__width_1 arb_evict_c3_inv_slice   (
        .dout   (arb_evict_c3_n),
        .din    (arb_evict_c3)
        );
 
l2t_tagd_dp_mux_macro__mux_aonpe__ports_2__stack_33r__width_33 mux_cam_addr_c3 
			( .dout (lkup_addr_c3[39:7]), 
              .din0(arbadr_dir_cam_addr_c3[39:7]), .din1(evict_addr_c3[39:7]), 
              .sel0(arb_evict_c3_n), .sel1(arb_evict_c3)); 

// BS 03/25/04 for partial bank/core modes support
// index shift before writing to Directory 

l2t_tagd_dp_mux_macro__mux_aonpe__ports_3__stack_10r__width_9 mux_lkup_addr_c3_tmp 
                        (.dout (lkup_addr_c3_tmp[8:0]) , 
                        .din0(lkup_addr_c3[17:9]), // original idx , all banks enabled
                        .din1(lkup_addr_c3[16:8]), // 1 bit shifted idx in case of 4 banks enabled
                        .din2(lkup_addr_c3[15:7]), // 2 bit shifted idx in case of 2 banks enabled
                        .sel0(arbadr_ncu_l2t_pm_n),
                        .sel1(arbadr_4bnk_true_enbld),
                        .sel2(arbadr_2bnk_true_enbld)
                        );

 
l2t_tagd_dp_msff_macro__stack_9r__width_9 ff_tagd_lkup_addr_c4  // BS and SR 11/18/03 Reverse Directory change
		  (.din(lkup_addr_c3_tmp[8:0]), .clk(l2clk), 
              .scan_in(ff_tagd_lkup_addr_c4_scanin),
              .scan_out(ff_tagd_lkup_addr_c4_scanout),
              .dout(tagd_lkup_addr_c4[17:9]), .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop) 
); 
 
 
///////////////////////////////////////////// 
// Mbist logic
///////////////////////////////////////////// 


l2t_tagd_dp_msff_macro__stack_28r__width_28 ff_tag_array_read_data  
                  (.din(tagd_evict_tag_c3[`TAG_WIDTH-1:0]), .clk(l2clk),
              .scan_in(ff_tag_array_read_data_scanin),
              .scan_out(ff_tag_array_read_data_scanout),
              .dout(tag_array_read_data[`TAG_WIDTH-1:0]), .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop)
);

//////////////////////////////////////////////////////////////////////////////////////////////////
//assign piped_vuad_data_input[36:0] = {mbist_write_data[7:0],tagd_mbist_write_data_r1[7:0],
//                tagd_mbist_write_data_r2[7:0],tagd_mbist_write_data_r3[7:0],
//                mbist_l2t_read,mbist_l2t_read_r1,mbist_l2t_read_r2,
//                mbist_l2t_read_r3,mbist_l2tag_fail_unreg};
//
//assign piped_vuad_data_output[36:0] = {tagd_mbist_write_data_r1[7:0],tagd_mbist_write_data_r2[7:0],
//                tagd_mbist_write_data_r3[7:0],tagd_mbist_write_data_r4[7:0],
//                mbist_l2t_read_r1,mbist_l2t_read_r2,mbist_l2t_read_r3,
//                mbist_l2t_read_r4,mbist_l2tag_fail};
//
//msff_macro ff_piped_vuad (width=37,stack=38r)
//       (.din({mbist_write_data[7:0],tagd_mbist_write_data_r1[7:0],
//		tagd_mbist_write_data_r2[7:0],tagd_mbist_write_data_r3[7:0],
//		mbist_l2t_read,mbist_l2t_read_r1,mbist_l2t_read_r2,
//		mbist_l2t_read_r3,mbist_l2tag_fail_unreg}),
//	.scan_in(ff_piped_vuad_scanin),
//	.scan_out(ff_piped_vuad_scanout),
//	.clk(l2clk),
//        .dout({tagd_mbist_write_data_r1[7:0],tagd_mbist_write_data_r2[7:0],
//		tagd_mbist_write_data_r3[7:0],tagd_mbist_write_data_r4[7:0],
//		mbist_l2t_read_r1,mbist_l2t_read_r2,mbist_l2t_read_r3,
//		mbist_l2t_read_r4,mbist_l2tag_fail}),
//	.en(1'b1),
//	);
//////////////////////////////////////////////////////////////////////////////////////////////////

assign piped_vuad_data_input[36:0] = {mbist_write_data[7:0],tagd_mbist_write_data_r1[7:0],
                tagd_mbist_write_data_r2[7:0],tagd_mbist_write_data_r3[7:0],
                mbist_l2t_read,mbist_l2t_read_r1,mbist_l2t_read_r2,
                mbist_l2t_read_r3,mbist_l2tag_fail_unreg};

assign {tagd_mbist_write_data_r1[7:0],tagd_mbist_write_data_r2[7:0],
                tagd_mbist_write_data_r3[7:0],tagd_mbist_write_data_r4[7:0],
                mbist_l2t_read_r1,mbist_l2t_read_r2,mbist_l2t_read_r3,
                mbist_l2t_read_r4,mbist_l2tag_fail} = piped_vuad_data_output[36:0];



l2t_tagd_dp_msff_macro__stack_28r__width_28 ff_piped_vuad0 
 	(
	.scan_in(ff_piped_vuad0_scanin),
	.scan_out(ff_piped_vuad0_scanout),
	.din(piped_vuad_data_input[27:0]),
	.dout(piped_vuad_data_output[27:0]),
	.clk(l2clk),
        .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop)
	);


l2t_tagd_dp_msff_macro__stack_10r__width_9 ff_piped_vuad1 
        (
        .scan_in(ff_piped_vuad1_scanin),
        .scan_out(ff_piped_vuad1_scanout),
        .din(piped_vuad_data_input[36:28]),
        .dout(piped_vuad_data_output[36:28]),
        .clk(l2clk),
        .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop)
        );


l2t_tagd_dp_cmp_macro__width_32  cmp_mbist_data 
	(
	.dout	(mbist_l2tag_fail_raw),
	.din0	({4'b0,tag_array_read_data[`TAG_WIDTH-1:0]}),
	.din1	({4'b0,tagd_mbist_write_data_r4[3:0],{3{tagd_mbist_write_data_r4[7:0]}}})
	);

l2t_tagd_dp_inv_macro__width_1 inv_mbist_l2t_read_r4 
	(
	.dout	(mbist_l2t_read_r4_n),
	.din	(mbist_l2t_read_r4)
	);

l2t_tagd_dp_mux_macro__dmux_8x__mux_aonpe__ports_2__width_1 mux_l2tag_fail_mbist 
	(
	.dout	(mbist_l2tag_fail_unreg),
	.din0	(mbist_l2tag_fail_raw),
	.din1	(1'b1),
	.sel0	(mbist_l2t_read_r4),
	.sel1	(mbist_l2t_read_r4_n)
	);


/////////////////////////////////////////////
// LRU mux.
/////////////////////////////////////////////

 
l2t_tagd_dp_mux_macro__mux_pgpe__ports_4__stack_28r__width_28 mux_lru_tag  // ATPG clean up
			(.dout (tagd_evict_tag_c3[`TAG_WIDTH-1:0]), 
                             .din0(tagl_tag_quad0_c3[`TAG_WIDTH-1:0]), 
                             .din1(tagl_tag_quad1_c3[`TAG_WIDTH-1:0]), 
                             .din2(tagl_tag_quad2_c3[`TAG_WIDTH-1:0]), 
                             .din3(tagl_tag_quad3_c3[`TAG_WIDTH-1:0]), 
                             .sel0(tagdp_tag_quad_muxsel_c3[0]), 
                             .sel1(tagdp_tag_quad_muxsel_c3[1]), 
                             .sel2(tagdp_tag_quad_muxsel_c3[2]),
  .muxtst(muxtst),
  .test(test) 
                             //.sel3(tagdp_tag_quad_muxsel_c3[3])
				); 
 
////////////////////////////////////////////////////////////////////////////////////////////// 
// Tag Diagnostic data pipeline 
//------------------------------------------------------------------------------------------ 
//	C1	C2	C3	C4	C5	C6	C7	C8	C9 
//------------------------------------------------------------------------------------------ 
//	diag	px2	rd tag	prepare mux	flop 	flop  	mux	data ret. 
// 	decode  idx mux		way mux out tag			with 
//				sels	and flop		other 
//								diag data 
//------------------------------------------------------------------------------------------ 
////////////////////////////////////////////////////////////////////////////////////////////// 

l2t_tagd_dp_msff_macro__stack_28r__width_28 ff_tagd_evict_tag_c4 
		  (.din(tagd_evict_tag_c3[`TAG_WIDTH-1:0]), .clk(l2clk), 
                   .scan_in(ff_tagd_evict_tag_c4_scanin),
                   .scan_out(ff_tagd_evict_tag_c4_scanout),
                   .dout(tagd_evict_tag_c4[`TAG_WIDTH-1:0]), .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop) 
); 

assign tagd_dmo_evict_tag_c4[`TAG_WIDTH-1:0] = tagd_evict_tag_c4[`TAG_WIDTH-1:0];

l2t_tagd_dp_msff_macro__minbuff_1__stack_28r__width_28 ff_tagd_diag_data_c52 
                  (.din(tagd_evict_tag_c4[`TAG_WIDTH-1:0]), .clk(l2clk),
                   .scan_in(ff_tagd_diag_data_c52_scanin),
                   .scan_out(ff_tagd_diag_data_c52_scanout),
                   .dout(tagd_diag_data_c52[`TAG_WIDTH-1:0]), .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop)
);

 
l2t_tagd_dp_msff_macro__stack_28r__width_28 ff_tagd_diag_data_c6 
		  (.din(tagd_diag_data_c52[`TAG_WIDTH-1:0]), .clk(l2clk), 
                   .scan_in(ff_tagd_diag_data_c6_scanin),
                   .scan_out(ff_tagd_diag_data_c6_scanout),
                   .dout(tagd_diag_data_c6[`TAG_WIDTH-1:0]), .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop) 
); 
 
l2t_tagd_dp_msff_macro__stack_28r__width_28 ff_tagd_diag_data_c7 
		  (.din(tagd_diag_data_c6[`TAG_WIDTH-1:0]), .clk(l2clk), 
                   .scan_in(ff_tagd_diag_data_c7_scanin),
                   .scan_out(ff_tagd_diag_data_c7_scanout),
                   .dout(tagd_diag_data_c7[`TAG_WIDTH-1:0]), .en(1'b1),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop) 
); 
 
 
///////////////////////////////////////////// 
// DP is 32 bits wide. The following 
// logic and flops are pushed to one side. 
///////////////////////////////////////////// 


l2t_tagd_dp_msff_macro__stack_24r__width_24 ff_ecc_staging1_4	 
	(
	.scan_in(ff_ecc_staging1_4_scanin),
	.scan_out(ff_ecc_staging1_4_scanout),
	.din	({tag_acc_ecc_c1[5:0],tag_acc_ecc_c2[5:0],
		  tag_acc_ecc_c3[5:0],tag_acc_ecc_c4[5:0]}),
	.dout	({tag_acc_ecc_c2[5:0],tag_acc_ecc_c3[5:0],
		  tag_acc_ecc_c4[5:0],tag_acc_ecc_c5[5:0]}),
  	.en	( 1'b1 ),
	.clk	(l2clk),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop)
	);

l2t_tagd_dp_msff_macro__stack_27r__width_27 ff_ecc_staging5_8       
        (
        .scan_in(ff_ecc_staging5_8_scanin),
        .scan_out(ff_ecc_staging5_8_scanout),
        .din({arbadr_ncu_l2t_pm_n_dist,arbadr_2bnk_true_enbld_dist,arbadr_4bnk_true_enbld_dist,
		tag_acc_ecc_c5[5:0],tag_acc_ecc_c52[5:0],tag_acc_ecc_c6[5:0],tag_acc_ecc_c7[5:0]}),
        .dout({arbadr_ncu_l2t_pm_n,arbadr_2bnk_true_enbld,arbadr_4bnk_true_enbld,
		tag_acc_ecc_c52[5:0],tag_acc_ecc_c6[5:0],tag_acc_ecc_c7[5:0],tagd_mbdata_inst_tecc_c8[5:0]}),
        .en     ( 1'b1 ),
        .clk    (l2clk),
  .se(se),
  .siclk(siclk),
  .soclk(soclk),
  .pce_ov(pce_ov),
  .stop(stop)
        );

assign	tagd_lkup_row_addr_dcd_c3[2:0] = lkup_addr_c3[11:9]; 
assign	tagd_lkup_row_addr_icd_c3[2:0] = lkup_addr_c3[11:9]; 
 
 
//////////////////////////////////////////////////////////// 
// The following signals need to be bufferred before 
// the tag. 
// INput pins are arranged on the top. 
// Try to align with the data path cell placement information 
// provided below. 
//////////////////////////////////////////////////////////// 
 
// repeater row1 ( 24 bits wide ) arranged as follows from left to right. 
// index [0 ..... 9] 
// way [11 .... 0 ] 
// rd  
// wr  
//assign	 tagd_arbdp_tag_idx_px2_buf[8:0]	= arbadr_arbdp_tag_idx_px2[8:0] ; // BS & SR 10/28/03 
//assign	tagd_arb_tag_way_px2_buf[15:0]	= arb_tag_way_px2[15:0] ; // BS & SR 10/28/03 
//assign	tagd_arb_tag_rd_px2_buf	= 	arb_tag_rd_px2; 
//assign	tagd_arb_tag_wr_px2_buf	= 	arb_tag_wr_px2; 
//
//buff_macro buff_tagd_arbdp_tag_idx_way_rd_wr_buf (width=36,dbuff=32x)
//	(
//	.dout	({tagd_arbdp_tag_idx_px2_buf_1[8:0],tagd_arbdp_tag_idx_px2_buf_2[8:0],tagd_arb_tag_way_px2_buf[15:0],
//		  tagd_arb_tag_rd_px2_buf,tagd_arb_tag_wr_px2_buf}),
//	.din	({arbadr_arbdp_tag_idx_px2[8:0],arbadr_arbdp_tag_idx_px2[8:0],arb_tag_way_px2[15:0],
//		  arb_tag_rd_px2,arb_tag_wr_px2})
//	);

l2t_tagd_dp_buff_macro__dbuff_32x__width_18 buff_tagd_arbdp_tag_idx_way_rd_wr_buf 
      (
      .dout   ({tagd_arb_tag_way_px2_buf[15:0],tagd_arb_tag_rd_px2_buf,tagd_arb_tag_wr_px2_buf}),
      .din    ({arb_tag_way_px2[15:0],arb_tag_rd_px2,arb_tag_wr_px2})
      );


l2t_tagd_dp_inv_macro__dinv_32x__width_18 inv_arbadr_arbdp_tag_idx_px2 
	(
	.dout	({tagd_arbdp_tag_idx_px2_buf_1[8:0],tagd_arbdp_tag_idx_px2_buf_2[8:0]}),
	.din	({arbadr_arbdp_tag_idx_px2[8:0],arbadr_arbdp_tag_idx_px2[8:0]})
	);

 
// repeater row2 ( 24 bits wide ) arranged as follows from left to right. 
// index [0 ..... 9] 
// way [11 .... 0 ] 
// rd  
// wr  
//assign	 tagd_mbist_l2t_index_buf[8:0]	=  mbist_l2t_index[8:0] ; // BS & SR 10/28/03 
//assign	 tagd_mbist_l2t_dec_way_buf[15:0]    = mbist_l2t_dec_way[15:0] ; // BS & SR 10/28/03 
//assign	 tagd_mbist_l2t_read_buf		= mbist_l2t_read; 
//assign	 tagd_mbist_l2t_write_buf		= mbist_l2t_write; 

l2t_tagd_dp_buff_macro__dbuff_16x__width_27 buff_mbist_tagd_arbdp_tag_idx_way_rd_wr_buf 
        (
        .dout   ({tagd_mbist_l2t_index_buf[8:0],tagd_mbist_l2t_dec_way_buf[15:0],
                  tagd_mbist_l2t_read_buf,tagd_mbist_l2t_write_buf}),
        .din    ({mbist_l2t_index[8:0],mbist_l2t_dec_way[15:0],
                  mbist_l2t_read,mbist_l2t_write})
        );




 
// repeater row 3 ( 28 bits wide ) arranged as follows from left to right. 
// wr_data [0 .. 27] 
 
// assign	tagd_tag_wrdata_px2_buf = 	arbadr_tag_wrdata_px2 ; 

l2t_tagd_dp_buff_macro__dbuff_16x__width_28 buff_tagd_tag_wrdata_px2_buf 
	(
	.dout	(tagd_tag_wrdata_px2_buf[27:0]),
	.din	(arbadr_tag_wrdata_px2[27:0])
	);
 
// repeater row 4  ( 8 bits wide ) arranged as follows from left to right. 
 
//assign	tagd_mbist_write_data_buf = mbist_write_data; 

l2t_tagd_dp_buff_macro__dbuff_16x__width_8 buff_tagd_mbist_write_data_buf 
        (
        .dout   (tagd_mbist_write_data_buf[7:0]),
        .din    (mbist_write_data[7:0])
        );

 
 
// fixscan start:
assign ff_wrdata_tag_c1_scanin   = scan_in                  ;
assign ff_tagd_lkup_addr_c4_scanin = ff_wrdata_tag_c1_scanout ;
assign ff_tag_array_read_data_scanin = ff_tagd_lkup_addr_c4_scanout;
assign ff_piped_vuad0_scanin     = ff_tag_array_read_data_scanout;
assign ff_piped_vuad1_scanin     = ff_piped_vuad0_scanout   ;
assign ff_tagd_evict_tag_c4_scanin = ff_piped_vuad1_scanout   ;
assign ff_tagd_diag_data_c52_scanin = ff_tagd_evict_tag_c4_scanout;
assign ff_tagd_diag_data_c6_scanin = ff_tagd_diag_data_c52_scanout;
assign ff_tagd_diag_data_c7_scanin = ff_tagd_diag_data_c6_scanout;
assign ff_ecc_staging1_4_scanin  = ff_tagd_diag_data_c7_scanout;
assign ff_ecc_staging5_8_scanin  = ff_ecc_staging1_4_scanout;
assign scan_out                  = ff_ecc_staging5_8_scanout;
// fixscan end:
endmodule 






// any PARAMS parms go into naming of macro

module l2t_tagd_dp_msff_macro__dmsff_32x__stack_22r__width_22 (
  din, 
  clk, 
  en, 
  se, 
  scan_in, 
  siclk, 
  soclk, 
  pce_ov, 
  stop, 
  dout, 
  scan_out);
wire l1clk;
wire siclk_out;
wire soclk_out;
wire [20:0] so;

  input [21:0] din;


  input clk;
  input en;
  input se;
  input scan_in;
  input siclk;
  input soclk;
  input pce_ov;
  input stop;



  output [21:0] dout;


  output scan_out;




cl_dp1_l1hdr_8x c0_0 (
.l2clk(clk),
.pce(en),
.aclk(siclk),
.bclk(soclk),
.l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop),
  .siclk_out(siclk_out),
  .soclk_out(soclk_out)
);
dff #(22)  d0_0 (
.l1clk(l1clk),
.siclk(siclk_out),
.soclk(soclk_out),
.d(din[21:0]),
.si({scan_in,so[20:0]}),
.so({so[20:0],scan_out}),
.q(dout[21:0])
);




















endmodule








//
//   xor macro for ports = 2,3
//
//





module l2t_tagd_dp_xor_macro__dxor_8x__ports_3__width_1 (
  din0, 
  din1, 
  din2, 
  dout);
  input [0:0] din0;
  input [0:0] din1;
  input [0:0] din2;
  output [0:0] dout;





xor3 #(1)  d0_0 (
.in0(din0[0:0]),
.in1(din1[0:0]),
.in2(din2[0:0]),
.out(dout[0:0])
);








endmodule





//
//   xor macro for ports = 2,3
//
//





module l2t_tagd_dp_xor_macro__dxor_8x__ports_2__width_1 (
  din0, 
  din1, 
  dout);
  input [0:0] din0;
  input [0:0] din1;
  output [0:0] dout;





xor2 #(1)  d0_0 (
.in0(din0[0:0]),
.in1(din1[0:0]),
.out(dout[0:0])
);








endmodule





//
//   xor macro for ports = 2,3
//
//





module l2t_tagd_dp_xor_macro__dxor_16x__ports_3__width_1 (
  din0, 
  din1, 
  din2, 
  dout);
  input [0:0] din0;
  input [0:0] din1;
  input [0:0] din2;
  output [0:0] dout;





xor3 #(1)  d0_0 (
.in0(din0[0:0]),
.in1(din1[0:0]),
.in2(din2[0:0]),
.out(dout[0:0])
);








endmodule





// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module l2t_tagd_dp_mux_macro__mux_aonpe__ports_3__stack_22r__width_22 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  din2, 
  sel2, 
  dout);
wire buffout0;
wire buffout1;
wire buffout2;

  input [21:0] din0;
  input sel0;
  input [21:0] din1;
  input sel1;
  input [21:0] din2;
  input sel2;
  output [21:0] dout;





cl_dp1_muxbuff3_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .in2(sel2),
 .out0(buffout0),
 .out1(buffout1),
 .out2(buffout2)
);
mux3s #(22)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .sel2(buffout2),
  .in0(din0[21:0]),
  .in1(din1[21:0]),
  .in2(din2[21:0]),
.dout(dout[21:0])
);









  



endmodule


//
//   invert macro
//
//





module l2t_tagd_dp_inv_macro__width_1 (
  din, 
  dout);
  input [0:0] din;
  output [0:0] dout;






inv #(1)  d0_0 (
.in(din[0:0]),
.out(dout[0:0])
);









endmodule





// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module l2t_tagd_dp_mux_macro__mux_aonpe__ports_2__stack_33r__width_33 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  dout);
wire buffout0;
wire buffout1;

  input [32:0] din0;
  input sel0;
  input [32:0] din1;
  input sel1;
  output [32:0] dout;





cl_dp1_muxbuff2_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .out0(buffout0),
 .out1(buffout1)
);
mux2s #(33)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .in0(din0[32:0]),
  .in1(din1[32:0]),
.dout(dout[32:0])
);









  



endmodule


// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module l2t_tagd_dp_mux_macro__mux_aonpe__ports_3__stack_10r__width_9 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  din2, 
  sel2, 
  dout);
wire buffout0;
wire buffout1;
wire buffout2;

  input [8:0] din0;
  input sel0;
  input [8:0] din1;
  input sel1;
  input [8:0] din2;
  input sel2;
  output [8:0] dout;





cl_dp1_muxbuff3_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .in2(sel2),
 .out0(buffout0),
 .out1(buffout1),
 .out2(buffout2)
);
mux3s #(9)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .sel2(buffout2),
  .in0(din0[8:0]),
  .in1(din1[8:0]),
  .in2(din2[8:0]),
.dout(dout[8:0])
);









  



endmodule






// any PARAMS parms go into naming of macro

module l2t_tagd_dp_msff_macro__stack_9r__width_9 (
  din, 
  clk, 
  en, 
  se, 
  scan_in, 
  siclk, 
  soclk, 
  pce_ov, 
  stop, 
  dout, 
  scan_out);
wire l1clk;
wire siclk_out;
wire soclk_out;
wire [7:0] so;

  input [8:0] din;


  input clk;
  input en;
  input se;
  input scan_in;
  input siclk;
  input soclk;
  input pce_ov;
  input stop;



  output [8:0] dout;


  output scan_out;




cl_dp1_l1hdr_8x c0_0 (
.l2clk(clk),
.pce(en),
.aclk(siclk),
.bclk(soclk),
.l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop),
  .siclk_out(siclk_out),
  .soclk_out(soclk_out)
);
dff #(9)  d0_0 (
.l1clk(l1clk),
.siclk(siclk_out),
.soclk(soclk_out),
.d(din[8:0]),
.si({scan_in,so[7:0]}),
.so({so[7:0],scan_out}),
.q(dout[8:0])
);




















endmodule













// any PARAMS parms go into naming of macro

module l2t_tagd_dp_msff_macro__stack_28r__width_28 (
  din, 
  clk, 
  en, 
  se, 
  scan_in, 
  siclk, 
  soclk, 
  pce_ov, 
  stop, 
  dout, 
  scan_out);
wire l1clk;
wire siclk_out;
wire soclk_out;
wire [26:0] so;

  input [27:0] din;


  input clk;
  input en;
  input se;
  input scan_in;
  input siclk;
  input soclk;
  input pce_ov;
  input stop;



  output [27:0] dout;


  output scan_out;




cl_dp1_l1hdr_8x c0_0 (
.l2clk(clk),
.pce(en),
.aclk(siclk),
.bclk(soclk),
.l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop),
  .siclk_out(siclk_out),
  .soclk_out(soclk_out)
);
dff #(28)  d0_0 (
.l1clk(l1clk),
.siclk(siclk_out),
.soclk(soclk_out),
.d(din[27:0]),
.si({scan_in,so[26:0]}),
.so({so[26:0],scan_out}),
.q(dout[27:0])
);




















endmodule













// any PARAMS parms go into naming of macro

module l2t_tagd_dp_msff_macro__stack_10r__width_9 (
  din, 
  clk, 
  en, 
  se, 
  scan_in, 
  siclk, 
  soclk, 
  pce_ov, 
  stop, 
  dout, 
  scan_out);
wire l1clk;
wire siclk_out;
wire soclk_out;
wire [7:0] so;

  input [8:0] din;


  input clk;
  input en;
  input se;
  input scan_in;
  input siclk;
  input soclk;
  input pce_ov;
  input stop;



  output [8:0] dout;


  output scan_out;




cl_dp1_l1hdr_8x c0_0 (
.l2clk(clk),
.pce(en),
.aclk(siclk),
.bclk(soclk),
.l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop),
  .siclk_out(siclk_out),
  .soclk_out(soclk_out)
);
dff #(9)  d0_0 (
.l1clk(l1clk),
.siclk(siclk_out),
.soclk(soclk_out),
.d(din[8:0]),
.si({scan_in,so[7:0]}),
.so({so[7:0],scan_out}),
.q(dout[8:0])
);




















endmodule









//
//   comparator macro (output is 1 if both inputs are equal; 0 otherwise)
//
//





module l2t_tagd_dp_cmp_macro__width_32 (
  din0, 
  din1, 
  dout);
  input [31:0] din0;
  input [31:0] din1;
  output dout;






cmp #(32)  m0_0 (
.in0(din0[31:0]),
.in1(din1[31:0]),
.out(dout)
);










endmodule





// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module l2t_tagd_dp_mux_macro__dmux_8x__mux_aonpe__ports_2__width_1 (
  din0, 
  sel0, 
  din1, 
  sel1, 
  dout);
wire buffout0;
wire buffout1;

  input [0:0] din0;
  input sel0;
  input [0:0] din1;
  input sel1;
  output [0:0] dout;





cl_dp1_muxbuff2_8x  c0_0 (
 .in0(sel0),
 .in1(sel1),
 .out0(buffout0),
 .out1(buffout1)
);
mux2s #(1)  d0_0 (
  .sel0(buffout0),
  .sel1(buffout1),
  .in0(din0[0:0]),
  .in1(din1[0:0]),
.dout(dout[0:0])
);









  



endmodule


// general mux macro for pass-gate and and-or muxes with/wout priority encoders
// also for pass-gate with decoder





// any PARAMS parms go into naming of macro

module l2t_tagd_dp_mux_macro__mux_pgpe__ports_4__stack_28r__width_28 (
  din0, 
  din1, 
  din2, 
  din3, 
  sel0, 
  sel1, 
  sel2, 
  muxtst, 
  test, 
  dout);
wire psel0;
wire psel1;
wire psel2;
wire psel3;

  input [27:0] din0;
  input [27:0] din1;
  input [27:0] din2;
  input [27:0] din3;
  input sel0;
  input sel1;
  input sel2;
  input muxtst;
  input test;
  output [27:0] dout;





cl_dp1_penc4_8x  c0_0 (
 .sel0(sel0),
 .sel1(sel1),
 .sel2(sel2),
 .psel0(psel0),
 .psel1(psel1),
 .psel2(psel2),
 .psel3(psel3),
  .test(test)
);

mux4 #(28)  d0_0 (
  .sel0(psel0),
  .sel1(psel1),
  .sel2(psel2),
  .sel3(psel3),
  .in0(din0[27:0]),
  .in1(din1[27:0]),
  .in2(din2[27:0]),
  .in3(din3[27:0]),
.dout(dout[27:0]),
  .muxtst(muxtst)
);









  



endmodule






// any PARAMS parms go into naming of macro

module l2t_tagd_dp_msff_macro__minbuff_1__stack_28r__width_28 (
  din, 
  clk, 
  en, 
  se, 
  scan_in, 
  siclk, 
  soclk, 
  pce_ov, 
  stop, 
  dout, 
  scan_out);
wire l1clk;
wire siclk_out;
wire soclk_out;
wire [26:0] so;

  input [27:0] din;


  input clk;
  input en;
  input se;
  input scan_in;
  input siclk;
  input soclk;
  input pce_ov;
  input stop;



  output [27:0] dout;


  output scan_out;




cl_dp1_l1hdr_8x c0_0 (
.l2clk(clk),
.pce(en),
.aclk(siclk),
.bclk(soclk),
.l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop),
  .siclk_out(siclk_out),
  .soclk_out(soclk_out)
);
dff #(28)  d0_0 (
.l1clk(l1clk),
.siclk(siclk_out),
.soclk(soclk_out),
.d(din[27:0]),
.si({scan_in,so[26:0]}),
.so({so[26:0],scan_out}),
.q(dout[27:0])
);




















endmodule













// any PARAMS parms go into naming of macro

module l2t_tagd_dp_msff_macro__stack_24r__width_24 (
  din, 
  clk, 
  en, 
  se, 
  scan_in, 
  siclk, 
  soclk, 
  pce_ov, 
  stop, 
  dout, 
  scan_out);
wire l1clk;
wire siclk_out;
wire soclk_out;
wire [22:0] so;

  input [23:0] din;


  input clk;
  input en;
  input se;
  input scan_in;
  input siclk;
  input soclk;
  input pce_ov;
  input stop;



  output [23:0] dout;


  output scan_out;




cl_dp1_l1hdr_8x c0_0 (
.l2clk(clk),
.pce(en),
.aclk(siclk),
.bclk(soclk),
.l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop),
  .siclk_out(siclk_out),
  .soclk_out(soclk_out)
);
dff #(24)  d0_0 (
.l1clk(l1clk),
.siclk(siclk_out),
.soclk(soclk_out),
.d(din[23:0]),
.si({scan_in,so[22:0]}),
.so({so[22:0],scan_out}),
.q(dout[23:0])
);




















endmodule













// any PARAMS parms go into naming of macro

module l2t_tagd_dp_msff_macro__stack_27r__width_27 (
  din, 
  clk, 
  en, 
  se, 
  scan_in, 
  siclk, 
  soclk, 
  pce_ov, 
  stop, 
  dout, 
  scan_out);
wire l1clk;
wire siclk_out;
wire soclk_out;
wire [25:0] so;

  input [26:0] din;


  input clk;
  input en;
  input se;
  input scan_in;
  input siclk;
  input soclk;
  input pce_ov;
  input stop;



  output [26:0] dout;


  output scan_out;




cl_dp1_l1hdr_8x c0_0 (
.l2clk(clk),
.pce(en),
.aclk(siclk),
.bclk(soclk),
.l1clk(l1clk),
  .se(se),
  .pce_ov(pce_ov),
  .stop(stop),
  .siclk_out(siclk_out),
  .soclk_out(soclk_out)
);
dff #(27)  d0_0 (
.l1clk(l1clk),
.siclk(siclk_out),
.soclk(soclk_out),
.d(din[26:0]),
.si({scan_in,so[25:0]}),
.so({so[25:0],scan_out}),
.q(dout[26:0])
);




















endmodule









//
//   buff macro
//
//





module l2t_tagd_dp_buff_macro__dbuff_32x__width_18 (
  din, 
  dout);
  input [17:0] din;
  output [17:0] dout;






buff #(18)  d0_0 (
.in(din[17:0]),
.out(dout[17:0])
);








endmodule





//
//   invert macro
//
//





module l2t_tagd_dp_inv_macro__dinv_32x__width_18 (
  din, 
  dout);
  input [17:0] din;
  output [17:0] dout;






inv #(18)  d0_0 (
.in(din[17:0]),
.out(dout[17:0])
);









endmodule





//
//   buff macro
//
//





module l2t_tagd_dp_buff_macro__dbuff_16x__width_27 (
  din, 
  dout);
  input [26:0] din;
  output [26:0] dout;






buff #(27)  d0_0 (
.in(din[26:0]),
.out(dout[26:0])
);








endmodule





//
//   buff macro
//
//





module l2t_tagd_dp_buff_macro__dbuff_16x__width_28 (
  din, 
  dout);
  input [27:0] din;
  output [27:0] dout;






buff #(28)  d0_0 (
.in(din[27:0]),
.out(dout[27:0])
);








endmodule





//
//   buff macro
//
//





module l2t_tagd_dp_buff_macro__dbuff_16x__width_8 (
  din, 
  dout);
  input [7:0] din;
  output [7:0] dout;






buff #(8)  d0_0 (
.in(din[7:0]),
.out(dout[7:0])
);








endmodule




