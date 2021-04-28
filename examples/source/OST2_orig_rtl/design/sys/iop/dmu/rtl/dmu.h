/*
* ========== Copyright Header Begin ==========================================
* 
* OpenSPARC T2 Processor File: dmu.h
* Copyright (C) 1995-2007 Sun Microsystems, Inc. All Rights Reserved
* 4150 Network Circle, Santa Clara, California 95054, U.S.A.
*
* DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER. 
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; version 2 of the License.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*
* For the avoidance of doubt, and except that if any non-GPL license 
* choice is available it will apply instead, Sun elects to use only 
* the General Public License version 2 (GPLv2) at this time for any 
* software where a choice of GPL license versions is made 
* available with the language indicating that GPLv2 or any later version 
* may be used, or where a choice of which version of the GPL is applied is 
* otherwise unspecified. 
*
* Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa Clara, 
* CA 95054 USA or visit www.sun.com if you need additional information or 
* have any questions. 
*
* 
* ========== Copyright Header End ============================================
*/
`define FIRE_DLC_ICR_SBDTAG_LSB   0                                                          // 0 start of SBDTAG field
`define FIRE_DLC_ICR_SBDTAG_WDTH  5
`define FIRE_DLC_ICR_SBDTAG_MSB  `FIRE_DLC_ICR_SBDTAG_LSB + `FIRE_DLC_ICR_SBDTAG_WDTH -1
// ~~~~~ sbdtag field access ~~~~~
`define FIRE_DLC_ICR_SBDTAG      `FIRE_DLC_ICR_SBDTAG_MSB:`FIRE_DLC_ICR_SBDTAG_LSB

`define FIRE_DLC_ICR_DPTR_LSB    `FIRE_DLC_ICR_SBDTAG_LSB + `FIRE_DLC_ICR_SBDTAG_WDTH    // 6 start of DPTR field
`define FIRE_DLC_ICR_DPTR_WDTH    7
`define FIRE_DLC_ICR_DPTR_MSB    `FIRE_DLC_ICR_DPTR_LSB + `FIRE_DLC_ICR_DPTR_WDTH -1
// ~~~~~ dptr field access ~~~~~
`define FIRE_DLC_ICR_DPTR        `FIRE_DLC_ICR_DPTR_MSB:`FIRE_DLC_ICR_DPTR_LSB

`define FIRE_DLC_ICR_STAT_LSB    `FIRE_DLC_ICR_DPTR_LSB + `FIRE_DLC_ICR_DPTR_WDTH        //11 start of STAT field
`define FIRE_DLC_ICR_STAT_WDTH    3
`define FIRE_DLC_ICR_STAT_MSB    `FIRE_DLC_ICR_STAT_LSB + `FIRE_DLC_ICR_STAT_WDTH -1
// ~~~~~ stat field access ~~~~~
`define FIRE_DLC_ICR_STAT        `FIRE_DLC_ICR_STAT_MSB:`FIRE_DLC_ICR_STAT_LSB

`define FIRE_DLC_ICR_ADDR_LSB    `FIRE_DLC_ICR_STAT_LSB + `FIRE_DLC_ICR_STAT_WDTH        //14 start of ADDR field
//BP n2 5-24-04
//`define FIRE_DLC_ICR_ADDR_WDTH    37
`define FIRE_DLC_ICR_ADDR_WDTH    38
`define FIRE_DLC_ICR_ADDR_MSB    `FIRE_DLC_ICR_ADDR_LSB + `FIRE_DLC_ICR_ADDR_WDTH -1
// ~~~~~ addr field access ~~~~~
`define FIRE_DLC_ICR_ADDR        `FIRE_DLC_ICR_ADDR_MSB:`FIRE_DLC_ICR_ADDR_LSB

`define FIRE_DLC_ICR_CLSTS_LSB   `FIRE_DLC_ICR_ADDR_LSB + `FIRE_DLC_ICR_ADDR_WDTH        //51 start of cl_sts feld
`define FIRE_DLC_ICR_CLSTS_WDTH   1
`define FIRE_DLC_ICR_CLSTS_MSB   `FIRE_DLC_ICR_CLSTS_LSB + `FIRE_DLC_ICR_CLSTS_WDTH -1
// ~~~~~ clsts field access ~~~~~
`define FIRE_DLC_ICR_CLSTS       `FIRE_DLC_ICR_CLSTS_MSB:`FIRE_DLC_ICR_CLSTS_LSB

`define FIRE_DLC_ICR_TYP_LSB     `FIRE_DLC_ICR_CLSTS_LSB + `FIRE_DLC_ICR_CLSTS_WDTH      //52 start of TYPE field
`define FIRE_DLC_ICR_TYP_WDTH     7
`define FIRE_DLC_ICR_TYP_MSB     `FIRE_DLC_ICR_TYP_LSB + `FIRE_DLC_ICR_TYP_WDTH -1
// ~~~~~ typ field access ~~~~~
`define FIRE_DLC_ICR_TYP         `FIRE_DLC_ICR_TYP_MSB:`FIRE_DLC_ICR_TYP_LSB

`define FIRE_DLC_ICR_REC_WDTH    `FIRE_DLC_ICR_TYP_LSB + `FIRE_DLC_ICR_TYP_WDTH          //59 Command Record Width

`define FIRE_DLC_ICR_MSB          `FIRE_DLC_ICR_REC_WDTH -1                              // Command Record MSB

//#############################
// INGRESS PACKET RECORD (IPR)
// From RCM to PRM
//#############################

`define FIRE_DLC_IPR_SBDTAG_LSB     0                                                          // 0 start of SBD Tag field
`define FIRE_DLC_IPR_SBDTAG_WDTH    5
`define FIRE_DLC_IPR_SBDTAG_MSB    `FIRE_DLC_IPR_SBDTAG_LSB + `FIRE_DLC_IPR_SBDTAG_WDTH -1  
 
`define FIRE_DLC_IPR_DPTR_LSB      `FIRE_DLC_IPR_SBDTAG_LSB + `FIRE_DLC_IPR_SBDTAG_WDTH        // 5 start of DPTR field
`define FIRE_DLC_IPR_DPTR_WDTH      7
`define FIRE_DLC_IPR_DPTR_MSB      `FIRE_DLC_IPR_DPTR_LSB + `FIRE_DLC_IPR_DPTR_WDTH -1      

`define FIRE_DLC_IPR_ADDRERR_LSB   `FIRE_DLC_IPR_DPTR_LSB + `FIRE_DLC_IPR_DPTR_WDTH            //12 start of ADDRERR field
`define FIRE_DLC_IPR_ADDRERR_WDTH   1
`define FIRE_DLC_IPR_ADDRERR_MSB   `FIRE_DLC_IPR_ADDRERR_LSB + `FIRE_DLC_IPR_ADDRERR_WDTH -1

`define FIRE_DLC_IPR_ADDR_LSB      `FIRE_DLC_IPR_ADDRERR_LSB + `FIRE_DLC_IPR_ADDRERR_WDTH      //13 start of ADDR field
`define FIRE_DLC_IPR_ADDR_WDTH      41
`define FIRE_DLC_IPR_ADDR_MSB      `FIRE_DLC_IPR_ADDR_LSB + `FIRE_DLC_IPR_ADDR_WDTH -1      

`define FIRE_DLC_IPR_PKSEQNUM_LSB  `FIRE_DLC_IPR_ADDR_LSB + `FIRE_DLC_IPR_ADDR_WDTH            //54 start of PKSEQ# field
`define FIRE_DLC_IPR_PKSEQNUM_WDTH  5
`define FIRE_DLC_IPR_PKSEQNUM_MSB  `FIRE_DLC_IPR_PKSEQNUM_LSB + `FIRE_DLC_IPR_PKSEQNUM_WDTH -1

`define FIRE_DLC_IPR_CNTXTNUM_LSB  `FIRE_DLC_IPR_PKSEQNUM_LSB + `FIRE_DLC_IPR_PKSEQNUM_WDTH    //59 start of CNTX# field
`define FIRE_DLC_IPR_CNTXTNUM_WDTH  5
`define FIRE_DLC_IPR_CNTXTNUM_MSB  `FIRE_DLC_IPR_CNTXTNUM_LSB + `FIRE_DLC_IPR_CNTXTNUM_WDTH -1

`define FIRE_DLC_IPR_BYTCNT_LSB    `FIRE_DLC_IPR_CNTXTNUM_LSB + `FIRE_DLC_IPR_CNTXTNUM_WDTH    //64 start of BYTE CNT field
`define FIRE_DLC_IPR_BYTCNT_WDTH    12 
`define FIRE_DLC_IPR_BYTCNT_MSB    `FIRE_DLC_IPR_BYTCNT_LSB + `FIRE_DLC_IPR_BYTCNT_WDTH -1    

`define FIRE_DLC_IPR_LEN_LSB       `FIRE_DLC_IPR_BYTCNT_LSB + `FIRE_DLC_IPR_BYTCNT_WDTH        //76 start of LENGTH field
`define FIRE_DLC_IPR_LEN_WDTH       10
`define FIRE_DLC_IPR_LEN_MSB       `FIRE_DLC_IPR_LEN_LSB + `FIRE_DLC_IPR_LEN_WDTH -1          

`define FIRE_DLC_IPR_TYP_LSB       `FIRE_DLC_IPR_LEN_LSB + `FIRE_DLC_IPR_LEN_WDTH              //86 start of TYPE field
`define FIRE_DLC_IPR_TYP_WDTH       7
`define FIRE_DLC_IPR_TYP_MSB       `FIRE_DLC_IPR_TYP_LSB + `FIRE_DLC_IPR_TYP_WDTH -1          

`define FIRE_DLC_IPR_REC_WDTH      `FIRE_DLC_IPR_TYP_LSB + `FIRE_DLC_IPR_TYP_WDTH              //93 Packet Record Width

`define FIRE_DLC_IPR_MSB           `FIRE_DLC_IPR_REC_WDTH -1                                   // Packet Record MSB

//#############################
// INGRESS SCHEDULE RECORD (ISR)
// From MMU to RCM
//#############################

`define FIRE_DLC_ISR_SBDTAG_LSB     0                                                          // 0 start of SBD Tag field
`define FIRE_DLC_ISR_SBDTAG_WDTH    5
`define FIRE_DLC_ISR_SBDTAG_MSB    `FIRE_DLC_ISR_SBDTAG_LSB + `FIRE_DLC_ISR_SBDTAG_WDTH -1
`define FIRE_DLC_ISR_SBDTAG_BITS   `FIRE_DLC_ISR_SBDTAG_MSB : `FIRE_DLC_ISR_SBDTAG_LSB
 
`define FIRE_DLC_ISR_DPTR_LSB      `FIRE_DLC_ISR_SBDTAG_LSB + `FIRE_DLC_ISR_SBDTAG_WDTH        // 5 start of DPTR field
`define FIRE_DLC_ISR_DPTR_WDTH      7
`define FIRE_DLC_ISR_DPTR_MSB      `FIRE_DLC_ISR_DPTR_LSB + `FIRE_DLC_ISR_DPTR_WDTH -1    
`define FIRE_DLC_ISR_DPTR_BITS      `FIRE_DLC_ISR_DPTR_MSB : `FIRE_DLC_ISR_DPTR_LSB

`define FIRE_DLC_ISR_ADDRERR_LSB   `FIRE_DLC_ISR_DPTR_LSB + `FIRE_DLC_ISR_DPTR_WDTH            //12 start of ADDRERR field
`define FIRE_DLC_ISR_ADDRERR_WDTH   1
`define FIRE_DLC_ISR_ADDRERR_MSB   `FIRE_DLC_ISR_ADDRERR_LSB + `FIRE_DLC_ISR_ADDRERR_WDTH -1
`define FIRE_DLC_ISR_ADDRERR_BITS  `FIRE_DLC_ISR_ADDRERR_MSB : `FIRE_DLC_ISR_ADDRERR_LSB

`define FIRE_DLC_ISR_ADDR_LSB      `FIRE_DLC_ISR_ADDRERR_LSB + `FIRE_DLC_ISR_ADDRERR_WDTH      //13 start of ADDR field
`define FIRE_DLC_ISR_ADDR_WDTH      41
`define FIRE_DLC_ISR_ADDR_MSB      `FIRE_DLC_ISR_ADDR_LSB + `FIRE_DLC_ISR_ADDR_WDTH -1      
`define FIRE_DLC_ISR_ADDR_BITS     `FIRE_DLC_ISR_ADDR_MSB : `FIRE_DLC_ISR_ADDR_LSB

`define FIRE_DLC_ISR_DWBE_LSB      `FIRE_DLC_ISR_ADDR_LSB + `FIRE_DLC_ISR_ADDR_WDTH            //54 start of BYTE CNT field
`define FIRE_DLC_ISR_DWBE_WDTH      8 
`define FIRE_DLC_ISR_DWBE_MSB      `FIRE_DLC_ISR_DWBE_LSB + `FIRE_DLC_ISR_DWBE_WDTH -1      
`define FIRE_DLC_ISR_DWBE_BITS     `FIRE_DLC_ISR_DWBE_MSB : `FIRE_DLC_ISR_DWBE_LSB

`define FIRE_DLC_ISR_LEN_LSB       `FIRE_DLC_ISR_DWBE_LSB + `FIRE_DLC_ISR_DWBE_WDTH            //62 start of LENGTH field
`define FIRE_DLC_ISR_LEN_WDTH       10
`define FIRE_DLC_ISR_LEN_MSB       `FIRE_DLC_ISR_LEN_LSB + `FIRE_DLC_ISR_LEN_WDTH -1        
`define FIRE_DLC_ISR_LEN_BITS      `FIRE_DLC_ISR_LEN_MSB : `FIRE_DLC_ISR_LEN_LSB

`define FIRE_DLC_ISR_TYP_LSB       `FIRE_DLC_ISR_LEN_LSB + `FIRE_DLC_ISR_LEN_WDTH              //72 start of TYPE field
`define FIRE_DLC_ISR_TYP_WDTH       7
`define FIRE_DLC_ISR_TYP_MSB       `FIRE_DLC_ISR_TYP_LSB + `FIRE_DLC_ISR_TYP_WDTH -1        
`define FIRE_DLC_ISR_TYP_BITS      `FIRE_DLC_ISR_TYP_MSB : `FIRE_DLC_ISR_TYP_LSB

`define FIRE_DLC_ISR_REC_WDTH      `FIRE_DLC_ISR_TYP_LSB + `FIRE_DLC_ISR_TYP_WDTH              //79 Schedule Record Width

`define FIRE_DLC_ISR_LSB           `FIRE_DLC_ISR_SBDTAG_LSB
`define FIRE_DLC_ISR_MSB           `FIRE_DLC_ISR_REC_WDTH -1                                   // Schedule Record MSB
`define FIRE_DLC_ISR_BITS          `FIRE_DLC_ISR_MSB : `FIRE_DLC_ISR_LSB

//#############################
// INGRESS SCHEDULE RECORD (SRM)
// From RMU to MMU
//#############################

`define FIRE_DLC_SRM_SBDTAG_LSB     0
`define FIRE_DLC_SRM_SBDTAG_WDTH    5
`define FIRE_DLC_SRM_SBDTAG_MSB    `FIRE_DLC_SRM_SBDTAG_LSB + `FIRE_DLC_SRM_SBDTAG_WDTH - 1
`define FIRE_DLC_SRM_SBDTAG_BITS   `FIRE_DLC_SRM_SBDTAG_MSB : `FIRE_DLC_SRM_SBDTAG_LSB

`define FIRE_DLC_SRM_DPTR_LSB      `FIRE_DLC_SRM_SBDTAG_LSB + `FIRE_DLC_SRM_SBDTAG_WDTH
`define FIRE_DLC_SRM_DPTR_WDTH      7
`define FIRE_DLC_SRM_DPTR_MSB      `FIRE_DLC_SRM_DPTR_LSB + `FIRE_DLC_SRM_DPTR_WDTH - 1
`define FIRE_DLC_SRM_DPTR_BITS     `FIRE_DLC_SRM_DPTR_MSB : `FIRE_DLC_SRM_DPTR_LSB

`define FIRE_DLC_SRM_ADDR_LSB      `FIRE_DLC_SRM_DPTR_LSB + `FIRE_DLC_SRM_DPTR_WDTH
`define FIRE_DLC_SRM_ADDR_WDTH      62
`define FIRE_DLC_SRM_ADDR_MSB      `FIRE_DLC_SRM_ADDR_LSB + `FIRE_DLC_SRM_ADDR_WDTH - 1
`define FIRE_DLC_SRM_ADDR_BITS     `FIRE_DLC_SRM_ADDR_MSB : `FIRE_DLC_SRM_ADDR_LSB

`define FIRE_DLC_SRM_DWBE_LSB      `FIRE_DLC_SRM_ADDR_LSB + `FIRE_DLC_SRM_ADDR_WDTH
`define FIRE_DLC_SRM_DWBE_WDTH      8 
`define FIRE_DLC_SRM_DWBE_MSB      `FIRE_DLC_SRM_DWBE_LSB + `FIRE_DLC_SRM_DWBE_WDTH - 1
`define FIRE_DLC_SRM_DWBE_BITS     `FIRE_DLC_SRM_DWBE_MSB : `FIRE_DLC_SRM_DWBE_LSB

`define FIRE_DLC_SRM_REQID_LSB     `FIRE_DLC_SRM_DWBE_LSB + `FIRE_DLC_SRM_DWBE_WDTH
`define FIRE_DLC_SRM_REQID_WDTH     16
`define FIRE_DLC_SRM_REQID_MSB     `FIRE_DLC_SRM_REQID_LSB + `FIRE_DLC_SRM_REQID_WDTH - 1
`define FIRE_DLC_SRM_REQID_BITS    `FIRE_DLC_SRM_REQID_MSB : `FIRE_DLC_SRM_REQID_LSB

`define FIRE_DLC_SRM_LEN_LSB       `FIRE_DLC_SRM_REQID_LSB + `FIRE_DLC_SRM_REQID_WDTH
`define FIRE_DLC_SRM_LEN_WDTH       10
`define FIRE_DLC_SRM_LEN_MSB       `FIRE_DLC_SRM_LEN_LSB + `FIRE_DLC_SRM_LEN_WDTH - 1
`define FIRE_DLC_SRM_LEN_BITS      `FIRE_DLC_SRM_LEN_MSB : `FIRE_DLC_SRM_LEN_LSB

`define FIRE_DLC_SRM_TYPE_LSB      `FIRE_DLC_SRM_LEN_LSB + `FIRE_DLC_SRM_LEN_WDTH
`define FIRE_DLC_SRM_TYPE_WDTH      7
`define FIRE_DLC_SRM_TYPE_MSB      `FIRE_DLC_SRM_TYPE_LSB + `FIRE_DLC_SRM_TYPE_WDTH - 1
`define FIRE_DLC_SRM_TYPE_BITS     `FIRE_DLC_SRM_TYPE_MSB : `FIRE_DLC_SRM_TYPE_LSB

`define FIRE_DLC_SRM_LSB           `FIRE_DLC_SRM_SBDTAG_LSB
`define FIRE_DLC_SRM_WDTH          `FIRE_DLC_SRM_TYPE_LSB + `FIRE_DLC_SRM_TYPE_WDTH
`define FIRE_DLC_SRM_MSB           `FIRE_DLC_SRM_WDTH - 1
`define FIRE_DLC_SRM_BITS          `FIRE_DLC_SRM_MSB : `FIRE_DLC_SRM_LSB

//###############################
// TABLEWALK COMMAND RECORD (TCR)
// From MMU to CLU
//###############################

`define FIRE_DLC_TCR_MTAG_LSB       0
`define FIRE_DLC_TCR_MTAG_WDTH      6
`define FIRE_DLC_TCR_MTAG_MSB      `FIRE_DLC_TCR_MTAG_LSB + `FIRE_DLC_TCR_MTAG_WDTH - 1
`define FIRE_DLC_TCR_MTAG_BITS     `FIRE_DLC_TCR_MTAG_MSB : `FIRE_DLC_TCR_MTAG_LSB
// ~~~~~ mtag field access ~~~~~
`define FIRE_DLC_TCR_MTAG          `FIRE_DLC_TCR_MTAG_MSB:`FIRE_DLC_TCR_MTAG_LSB

`define FIRE_DLC_TCR_ADDR_LSB      `FIRE_DLC_TCR_MTAG_LSB + `FIRE_DLC_TCR_MTAG_WDTH
`define FIRE_DLC_TCR_ADDR_WDTH      37
`define FIRE_DLC_TCR_ADDR_MSB      `FIRE_DLC_TCR_ADDR_LSB + `FIRE_DLC_TCR_ADDR_WDTH - 1
`define FIRE_DLC_TCR_ADDR_BITS     `FIRE_DLC_TCR_ADDR_MSB : `FIRE_DLC_TCR_ADDR_LSB
// ~~~~~ addr field access ~~~~~
`define FIRE_DLC_TCR_ADDR          `FIRE_DLC_TCR_ADDR_MSB:`FIRE_DLC_TCR_ADDR_LSB

`define FIRE_DLC_TCR_LSB           `FIRE_DLC_TCR_MTAG_LSB
`define FIRE_DLC_TCR_WDTH          `FIRE_DLC_TCR_ADDR_LSB + `FIRE_DLC_TCR_ADDR_WDTH
`define FIRE_DLC_TCR_MSB           `FIRE_DLC_TCR_WDTH - 1
`define FIRE_DLC_TCR_BITS          `FIRE_DLC_TCR_MSB : `FIRE_DLC_TCR_LSB

//############################
// TABLEWALK DATA RECORD (TDR)
// From CLU to MMU
//############################

`define FIRE_DLC_TDR_DATA_LSB       0
`define FIRE_DLC_TDR_DATA_WDTH      128
`define FIRE_DLC_TDR_DATA_MSB      `FIRE_DLC_TDR_DATA_LSB + `FIRE_DLC_TDR_DATA_WDTH - 1
`define FIRE_DLC_TDR_DATA_BITS     `FIRE_DLC_TDR_DATA_MSB : `FIRE_DLC_TDR_DATA_LSB
// ~~~~~ data field access ~~~~~
`define FIRE_DLC_TDR_DATA          `FIRE_DLC_TDR_DATA_MSB:`FIRE_DLC_TDR_DATA_LSB

`define FIRE_DLC_TDR_DPAR_LSB      `FIRE_DLC_TDR_DATA_LSB + `FIRE_DLC_TDR_DATA_WDTH
`define FIRE_DLC_TDR_DPAR_WDTH      4
`define FIRE_DLC_TDR_DPAR_MSB      `FIRE_DLC_TDR_DPAR_LSB + `FIRE_DLC_TDR_DPAR_WDTH - 1
`define FIRE_DLC_TDR_DPAR_BITS     `FIRE_DLC_TDR_DPAR_MSB : `FIRE_DLC_TDR_DPAR_LSB
// ~~~~~ dpar field access ~~~~~
`define FIRE_DLC_TDR_DPAR          `FIRE_DLC_TDR_DPAR_MSB:`FIRE_DLC_TDR_DPAR_LSB

`define FIRE_DLC_TDR_MTAG_LSB      `FIRE_DLC_TDR_DPAR_LSB + `FIRE_DLC_TDR_DPAR_WDTH
`define FIRE_DLC_TDR_MTAG_WDTH      6
`define FIRE_DLC_TDR_MTAG_MSB      `FIRE_DLC_TDR_MTAG_LSB + `FIRE_DLC_TDR_MTAG_WDTH - 1
`define FIRE_DLC_TDR_MTAG_BITS     `FIRE_DLC_TDR_MTAG_MSB : `FIRE_DLC_TDR_MTAG_LSB
// ~~~~~ mtag field access ~~~~~
`define FIRE_DLC_TDR_MTAG          `FIRE_DLC_TDR_MTAG_MSB:`FIRE_DLC_TDR_MTAG_LSB

`define FIRE_DLC_TDR_DERR_LSB      `FIRE_DLC_TDR_MTAG_LSB + `FIRE_DLC_TDR_MTAG_WDTH
`define FIRE_DLC_TDR_DERR_WDTH      1
`define FIRE_DLC_TDR_DERR_MSB      `FIRE_DLC_TDR_DERR_LSB + `FIRE_DLC_TDR_DERR_WDTH - 1
`define FIRE_DLC_TDR_DERR_BITS     `FIRE_DLC_TDR_DERR_MSB : `FIRE_DLC_TDR_DERR_LSB
// ~~~~~ derr field access ~~~~~
`define FIRE_DLC_TDR_DERR          `FIRE_DLC_TDR_DERR_MSB:`FIRE_DLC_TDR_DERR_LSB

`define FIRE_DLC_TDR_CERR_LSB      `FIRE_DLC_TDR_DERR_LSB + `FIRE_DLC_TDR_DERR_WDTH
`define FIRE_DLC_TDR_CERR_WDTH      1
`define FIRE_DLC_TDR_CERR_MSB      `FIRE_DLC_TDR_CERR_LSB + `FIRE_DLC_TDR_CERR_WDTH - 1
`define FIRE_DLC_TDR_CERR_BITS     `FIRE_DLC_TDR_CERR_MSB : `FIRE_DLC_TDR_CERR_LSB
// ~~~~~ cerr field access ~~~~~
`define FIRE_DLC_TDR_CERR          `FIRE_DLC_TDR_CERR_MSB:`FIRE_DLC_TDR_CERR_LSB

`define FIRE_DLC_TDR_LSB           `FIRE_DLC_TDR_DATA_LSB
`define FIRE_DLC_TDR_WDTH          `FIRE_DLC_TDR_CERR_LSB + `FIRE_DLC_TDR_CERR_WDTH
`define FIRE_DLC_TDR_MSB           `FIRE_DLC_TDR_WDTH - 1
`define FIRE_DLC_TDR_BITS          `FIRE_DLC_TDR_MSB : `FIRE_DLC_TDR_LSB

//###########################
// EGRESS PACKET RECORD (EPR)
// From CRM to TCM
//###########################

`define FIRE_DLC_EPR_CNTXTNUM_LSB   0                                                          // 0 start of CNTX# field
`define FIRE_DLC_EPR_CNTXTNUM_WDTH  5
`define FIRE_DLC_EPR_CNTXTNUM_MSB  `FIRE_DLC_EPR_CNTXTNUM_LSB + `FIRE_DLC_EPR_CNTXTNUM_WDTH -1
// ~~~~~ cntxtnum field access ~~~~~
`define FIRE_DLC_EPR_CNTXTNUM      `FIRE_DLC_EPR_CNTXTNUM_MSB:`FIRE_DLC_EPR_CNTXTNUM_LSB

`define FIRE_DLC_EPR_PKSEQNUM_LSB  `FIRE_DLC_EPR_CNTXTNUM_LSB + `FIRE_DLC_EPR_CNTXTNUM_WDTH    // 5 start of PKSEQ# field
`define FIRE_DLC_EPR_PKSEQNUM_WDTH  5
`define FIRE_DLC_EPR_PKSEQNUM_MSB  `FIRE_DLC_EPR_PKSEQNUM_LSB + `FIRE_DLC_EPR_PKSEQNUM_WDTH -1
// ~~~~~ pkseqnum field access ~~~~~
`define FIRE_DLC_EPR_PKSEQNUM      `FIRE_DLC_EPR_PKSEQNUM_MSB:`FIRE_DLC_EPR_PKSEQNUM_LSB

`define FIRE_DLC_EPR_DPTR_LSB      `FIRE_DLC_EPR_PKSEQNUM_LSB + `FIRE_DLC_EPR_PKSEQNUM_WDTH    //10 start of DPTR field
`define FIRE_DLC_EPR_DPTR_WDTH      6
`define FIRE_DLC_EPR_DPTR_MSB      `FIRE_DLC_EPR_DPTR_LSB + `FIRE_DLC_EPR_DPTR_WDTH -1
// ~~~~~ dptr field access ~~~~~
`define FIRE_DLC_EPR_DPTR          `FIRE_DLC_EPR_DPTR_MSB:`FIRE_DLC_EPR_DPTR_LSB

`define FIRE_DLC_EPR_SBDTAG_LSB    `FIRE_DLC_EPR_DPTR_LSB + `FIRE_DLC_EPR_DPTR_WDTH            //16 start of SBD Tag field
`define FIRE_DLC_EPR_SBDTAG_WDTH    5
`define FIRE_DLC_EPR_SBDTAG_MSB    `FIRE_DLC_EPR_SBDTAG_LSB + `FIRE_DLC_EPR_SBDTAG_WDTH -1
// ~~~~~ sbdtag field access ~~~~~
`define FIRE_DLC_EPR_SBDTAG        `FIRE_DLC_EPR_SBDTAG_MSB:`FIRE_DLC_EPR_SBDTAG_LSB

`define FIRE_DLC_EPR_ADDR_LSB      `FIRE_DLC_EPR_SBDTAG_LSB + `FIRE_DLC_EPR_SBDTAG_WDTH        //21 start of ADDR field
`define FIRE_DLC_EPR_ADDR_WDTH      34
`define FIRE_DLC_EPR_ADDR_MSB      `FIRE_DLC_EPR_ADDR_LSB + `FIRE_DLC_EPR_ADDR_WDTH -1
// ~~~~~ addr field access ~~~~~
`define FIRE_DLC_EPR_ADDR          `FIRE_DLC_EPR_ADDR_MSB:`FIRE_DLC_EPR_ADDR_LSB

`define FIRE_DLC_EPR_DWBE_LSB      `FIRE_DLC_EPR_ADDR_LSB + `FIRE_DLC_EPR_ADDR_WDTH            //55 start of BYTE CNT field
`define FIRE_DLC_EPR_DWBE_WDTH      8
`define FIRE_DLC_EPR_DWBE_MSB      `FIRE_DLC_EPR_DWBE_LSB + `FIRE_DLC_EPR_DWBE_WDTH -1

`define FIRE_DLC_EPR_LEN_LSB       `FIRE_DLC_EPR_DWBE_LSB + `FIRE_DLC_EPR_DWBE_WDTH            //63 start of LENGTH field
`define FIRE_DLC_EPR_LEN_WDTH       10
`define FIRE_DLC_EPR_LEN_MSB       `FIRE_DLC_EPR_LEN_LSB + `FIRE_DLC_EPR_LEN_WDTH -1
// ~~~~~ len field access ~~~~~
`define FIRE_DLC_EPR_LEN           `FIRE_DLC_EPR_LEN_MSB:`FIRE_DLC_EPR_LEN_LSB

`define FIRE_DLC_EPR_TYP_LSB       `FIRE_DLC_EPR_LEN_LSB + `FIRE_DLC_EPR_LEN_WDTH              //73 start of TYPE field
`define FIRE_DLC_EPR_TYP_WDTH       7
`define FIRE_DLC_EPR_TYP_MSB       `FIRE_DLC_EPR_TYP_LSB + `FIRE_DLC_EPR_TYP_WDTH -1
// ~~~~~ type field access ~~~~~
`define FIRE_DLC_EPR_TYP           `FIRE_DLC_EPR_TYP_MSB:`FIRE_DLC_EPR_TYP_LSB

`define FIRE_DLC_EPR_REC_WDTH      `FIRE_DLC_EPR_TYP_LSB + `FIRE_DLC_EPR_TYP_WDTH              //80 Packet Record WIDTH

`define FIRE_DLC_EPR_MSB           `FIRE_DLC_EPR_REC_WDTH -1                                   // Packet Record MSB

//#############################
// EGRESS RETIRE RECORD (ERR)
// From TCM to RRM
//#############################

`define FIRE_DLC_ERR_DPTR_LSB       0                                                          // 0 start of DPTR field
`define FIRE_DLC_ERR_DPTR_WDTH      6
`define FIRE_DLC_ERR_DPTR_MSB      `FIRE_DLC_ERR_DPTR_LSB + `FIRE_DLC_ERR_DPTR_WDTH -1 
// ~~~~ dptr field access ~~~~
`define	FIRE_DLC_ERR_DPTR	   `FIRE_DLC_ERR_DPTR_MSB:`FIRE_DLC_ERR_DPTR_LSB

`define FIRE_DLC_ERR_SBDTAG_LSB    `FIRE_DLC_ERR_DPTR_LSB + `FIRE_DLC_ERR_DPTR_WDTH            // 6 start of SBD Tag field
`define FIRE_DLC_ERR_SBDTAG_WDTH    5
`define FIRE_DLC_ERR_SBDTAG_MSB    `FIRE_DLC_ERR_SBDTAG_LSB + `FIRE_DLC_ERR_SBDTAG_WDTH -1   
// ~~~~ sbdtag field access ~~~~
`define	FIRE_DLC_ERR_SBDTAG	   `FIRE_DLC_ERR_SBDTAG_MSB:`FIRE_DLC_ERR_SBDTAG_LSB

`define FIRE_DLC_ERR_ADDR_LSB      `FIRE_DLC_ERR_SBDTAG_LSB + `FIRE_DLC_ERR_SBDTAG_WDTH        //11 start of ADDR field
`define FIRE_DLC_ERR_ADDR_WDTH      34
`define FIRE_DLC_ERR_ADDR_MSB      `FIRE_DLC_ERR_ADDR_LSB + `FIRE_DLC_ERR_ADDR_WDTH -1      
// ~~~~ addr field access ~~~~
`define	FIRE_DLC_ERR_ADDR	   `FIRE_DLC_ERR_ADDR_MSB:`FIRE_DLC_ERR_ADDR_LSB

`define FIRE_DLC_ERR_FDWBE_LSB     `FIRE_DLC_ERR_ADDR_LSB + `FIRE_DLC_ERR_ADDR_WDTH            //45 start of FDWBE field
`define FIRE_DLC_ERR_FDWBE_WDTH     4 
`define FIRE_DLC_ERR_FDWBE_MSB     `FIRE_DLC_ERR_FDWBE_LSB + `FIRE_DLC_ERR_FDWBE_WDTH -1      
// ~~~~ fdwbe field access ~~~~
`define	FIRE_DLC_ERR_FDWBE	   `FIRE_DLC_ERR_FDWBE_MSB:`FIRE_DLC_ERR_FDWBE_LSB

`define FIRE_DLC_ERR_LDWBE_LSB     `FIRE_DLC_ERR_FDWBE_LSB + `FIRE_DLC_ERR_FDWBE_WDTH          //49 start of LDWBE field
`define FIRE_DLC_ERR_LDWBE_WDTH     4 
`define FIRE_DLC_ERR_LDWBE_MSB     `FIRE_DLC_ERR_LDWBE_LSB + `FIRE_DLC_ERR_LDWBE_WDTH -1      
// ~~~~ ldwbe field access ~~~~
`define	FIRE_DLC_ERR_LDWBE	   `FIRE_DLC_ERR_LDWBE_MSB:`FIRE_DLC_ERR_LDWBE_LSB

`define FIRE_DLC_ERR_LEN_LSB       `FIRE_DLC_ERR_LDWBE_LSB + `FIRE_DLC_ERR_LDWBE_WDTH          //53 start of LENGTH field
`define FIRE_DLC_ERR_LEN_WDTH       10
`define FIRE_DLC_ERR_LEN_MSB       `FIRE_DLC_ERR_LEN_LSB + `FIRE_DLC_ERR_LEN_WDTH -1        
// ~~~~ len field access ~~~~
`define	FIRE_DLC_ERR_LEN	   `FIRE_DLC_ERR_LEN_MSB:`FIRE_DLC_ERR_LEN_LSB

`define FIRE_DLC_ERR_TYP_LSB       `FIRE_DLC_ERR_LEN_LSB + `FIRE_DLC_ERR_LEN_WDTH              //63 start of TYPE field
`define FIRE_DLC_ERR_TYP_WDTH       7
`define FIRE_DLC_ERR_TYP_MSB       `FIRE_DLC_ERR_TYP_LSB + `FIRE_DLC_ERR_TYP_WDTH -1        
// ~~~~ type field access ~~~~
`define FIRE_DLC_ERR_TYP	   `FIRE_DLC_ERR_TYP_MSB:`FIRE_DLC_ERR_TYP_LSB

`define FIRE_DLC_ERR_REC_WDTH      `FIRE_DLC_ERR_TYP_LSB + `FIRE_DLC_ERR_TYP_WDTH              //70 Retire Record Width

`define FIRE_DLC_ERR_MSB           `FIRE_DLC_ERR_REC_WDTH -1                                   // Retire Record MSB

//#############################
// INTERRUPT IN RECORD  (IIN)
// From LRM to IMU
//#############################

`define FIRE_DLC_IIN_LRMTAG_LSB  	0							// Start of LRM TAG Field
`define FIRE_DLC_IIN_LRMTAG_WDTH  	8							// Width of LRM TAG Field
`define FIRE_DLC_IIN_LRMTAG_MSB  	`FIRE_DLC_IIN_LRMTAG_LSB + `FIRE_DLC_IIN_LRMTAG_WDTH -1	// MSB of LRM TAG Field

`define FIRE_DLC_IIN_DPTR_LSB 		`FIRE_DLC_IIN_LRMTAG_LSB + `FIRE_DLC_IIN_LRMTAG_WDTH	// Start of Data Pointer Field
`define FIRE_DLC_IIN_DPTR_WDTH  	7							// Width of Data Pointer Field
`define FIRE_DLC_IIN_DPTR_MSB  		`FIRE_DLC_IIN_DPTR_LSB + `FIRE_DLC_IIN_DPTR_WDTH -1	// MSB of Data Pointer Field

`define FIRE_DLC_IIN_ADDR_LSB	  	`FIRE_DLC_IIN_DPTR_LSB + `FIRE_DLC_IIN_DPTR_WDTH	// Start of Address Field
`define FIRE_DLC_IIN_ADDR_WDTH  	62							// Width of Address Field
`define FIRE_DLC_IIN_ADDR_MSB	  	`FIRE_DLC_IIN_ADDR_LSB + `FIRE_DLC_IIN_ADDR_WDTH -1 	// MSB of Address Field

`define FIRE_DLC_IIN_DATA_LSB  		`FIRE_DLC_IIN_ADDR_LSB + `FIRE_DLC_IIN_ADDR_WDTH	// Start of Data Field
`define FIRE_DLC_IIN_DATA_WDTH  	8							// Width of Data Field
`define FIRE_DLC_IIN_DATA_MSB  		`FIRE_DLC_IIN_DATA_LSB + `FIRE_DLC_IIN_DATA_WDTH -1	// MSB of Data Field

`define FIRE_DLC_IIN_TLPTAG_LSB	  	`FIRE_DLC_IIN_DATA_LSB + `FIRE_DLC_IIN_DATA_WDTH	// Start of TLP Tag Field
`define FIRE_DLC_IIN_TLPTAG_WDTH  	8							// Width of TLP Tag Field
`define FIRE_DLC_IIN_TLPTAG_MSB  	`FIRE_DLC_IIN_TLPTAG_LSB + `FIRE_DLC_IIN_TLPTAG_WDTH -1	// MSB of TLP Tag Field

`define FIRE_DLC_IIN_REQID_LSB  	`FIRE_DLC_IIN_TLPTAG_LSB + `FIRE_DLC_IIN_TLPTAG_WDTH	// Start of REQ ID Field
`define FIRE_DLC_IIN_REQID_WDTH  	16							// Width of REQ ID Field
`define FIRE_DLC_IIN_REQID_MSB  	`FIRE_DLC_IIN_REQID_LSB + `FIRE_DLC_IIN_REQID_WDTH -1	// MSB of REQ ID Field

`define FIRE_DLC_IIN_LEN_LSB  		`FIRE_DLC_IIN_REQID_LSB + `FIRE_DLC_IIN_REQID_WDTH	// Start of Length Field
`define FIRE_DLC_IIN_LEN_WDTH  		10							// Width of Length Field
`define FIRE_DLC_IIN_LEN_MSB  		`FIRE_DLC_IIN_LEN_LSB + `FIRE_DLC_IIN_LEN_WDTH -1	// MSB of Length Field

`define FIRE_DLC_IIN_ATR_LSB  		`FIRE_DLC_IIN_LEN_LSB + `FIRE_DLC_IIN_LEN_WDTH		// Start of Attribute Field
`define FIRE_DLC_IIN_ATR_WDTH  		2							// Width of Attribute Field
`define FIRE_DLC_IIN_ATR_MSB  		`FIRE_DLC_IIN_ATR_LSB + `FIRE_DLC_IIN_ATR_WDTH -1	// MSB of Attribute Field

`define FIRE_DLC_IIN_TC_LSB  		`FIRE_DLC_IIN_ATR_LSB + `FIRE_DLC_IIN_ATR_WDTH		// Start of TC Field 
`define FIRE_DLC_IIN_TC_WDTH  		3							// Width of TC Field 
`define FIRE_DLC_IIN_TC_MSB 		`FIRE_DLC_IIN_TC_LSB + `FIRE_DLC_IIN_TC_WDTH -1		// MSB of TC Field 

`define FIRE_DLC_IIN_TYPE_LSB  		`FIRE_DLC_IIN_TC_LSB + `FIRE_DLC_IIN_TC_WDTH		// Start of Type Field 
`define FIRE_DLC_IIN_TYPE_WDTH  	7							// Width of Type Field 
`define FIRE_DLC_IIN_TYPE_MSB  		`FIRE_DLC_IIN_TYPE_LSB + `FIRE_DLC_IIN_TYPE_WDTH -1	// MSB of Type Field 

`define FIRE_DLC_IIN_REC_WDTH  		`FIRE_DLC_IIN_TYPE_LSB + `FIRE_DLC_IIN_TYPE_WDTH	// Complete Record With

//#############################
// MSI DATA FORMAT  (MDF)
// From DIM to IMU
//#############################

`define FIRE_DLC_MDF_DATA_LSB  		0							// Start of Data Field
`define FIRE_DLC_MDF_DATA_WDTH  	32							// Width of Data Field
`define FIRE_DLC_MDF_DATA_MSB  		`FIRE_DLC_MDF_DATA_LSB + `FIRE_DLC_MDF_DATA_WDTH -1	// MSB of Data Field

`define FIRE_DLC_MDF_PERR_LSB 		`FIRE_DLC_MDF_DATA_LSB + `FIRE_DLC_MDF_DATA_WDTH	// Start of Parity Error Field
`define FIRE_DLC_MDF_PERR_WDTH  	1							// Width of Parity Error Field
`define FIRE_DLC_MDF_PERR_MSB  		`FIRE_DLC_MDF_PERR_LSB + `FIRE_DLC_MDF_PERR_WDTH -1	// MSB of Parity Error Field

`define FIRE_DLC_MDF_REC_WDTH  		`FIRE_DLC_MDF_PERR_LSB + `FIRE_DLC_MDF_PERR_WDTH	// Complete Record With

//#############################
// STATIC CSR WIDTHS  (SCW)
// From IMU to TMU
//#############################

`define FIRE_DLC_SCW_MSI32_WDTH  	16
`define FIRE_DLC_SCW_MSI64_WDTH  	48
`define FIRE_DLC_SCW_MEM64_WDTH  	40

//#############################
// INTERRUPT  OUT RECORD  (IOT)
// From IMU to LRM
//#############################

`define FIRE_DLC_IOT_LRMTAG_LSB  	0							// Start of LRM TAG Field
`define FIRE_DLC_IOT_LRMTAG_WDTH  	8							// Width of LRM TAG Field
`define FIRE_DLC_IOT_LRMTAG_MSB  	`FIRE_DLC_IOT_LRMTAG_LSB + `FIRE_DLC_IOT_LRMTAG_WDTH -1	// MSB of LRM TAG Field

`define FIRE_DLC_IOT_DPTR_LSB 		`FIRE_DLC_IOT_LRMTAG_LSB + `FIRE_DLC_IOT_LRMTAG_WDTH	// Start of Data Pointer Field
`define FIRE_DLC_IOT_DPTR_WDTH  	7							// Width of Data Pointer Field
`define FIRE_DLC_IOT_DPTR_MSB  		`FIRE_DLC_IOT_DPTR_LSB + `FIRE_DLC_IOT_DPTR_WDTH -1	// MSB of Data Pointer Field
// ~~~~ dptr field access ~~~~
`define	FIRE_DLC_IOT_DPTR	   	`FIRE_DLC_IOT_DPTR_MSB:`FIRE_DLC_IOT_DPTR_LSB

`define FIRE_DLC_IOT_ADDR_LSB	  	`FIRE_DLC_IOT_DPTR_LSB + `FIRE_DLC_IOT_DPTR_WDTH	// Start of Address Field
`define FIRE_DLC_IOT_ADDR_WDTH  	62							// Width of Address Field
`define FIRE_DLC_IOT_ADDR_MSB	  	`FIRE_DLC_IOT_ADDR_LSB + `FIRE_DLC_IOT_ADDR_WDTH -1 	// MSB of Address Field
// ~~~~ addr field access ~~~~
`define	FIRE_DLC_IOT_ADDR	   	`FIRE_DLC_IOT_ADDR_MSB:`FIRE_DLC_IOT_ADDR_LSB

`define FIRE_DLC_IOT_DATA_LSB  		`FIRE_DLC_IOT_ADDR_LSB + `FIRE_DLC_IOT_ADDR_WDTH	// Start of Data Field
`define FIRE_DLC_IOT_DATA_WDTH  	8							// Width of Data Field
`define FIRE_DLC_IOT_DATA_MSB  		`FIRE_DLC_IOT_DATA_LSB + `FIRE_DLC_IOT_DATA_WDTH -1	// MSB of Data Field
// ~~~~ data field access ~~~~
`define	FIRE_DLC_IOT_DATA	   	`FIRE_DLC_IOT_DATA_MSB:`FIRE_DLC_IOT_DATA_LSB

`define FIRE_DLC_IOT_TLPTAG_LSB	  	`FIRE_DLC_IOT_DATA_LSB + `FIRE_DLC_IOT_DATA_WDTH	// Start of TLP Tag Field
`define FIRE_DLC_IOT_TLPTAG_WDTH  	8							// Width of TLP Tag Field
`define FIRE_DLC_IOT_TLPTAG_MSB  	`FIRE_DLC_IOT_TLPTAG_LSB + `FIRE_DLC_IOT_TLPTAG_WDTH -1	// MSB of TLP Tag Field

`define FIRE_DLC_IOT_REQID_LSB  	`FIRE_DLC_IOT_TLPTAG_LSB + `FIRE_DLC_IOT_TLPTAG_WDTH	// Start of REQ ID Field
`define FIRE_DLC_IOT_REQID_WDTH  	16							// Width of REQ ID Field
`define FIRE_DLC_IOT_REQID_MSB  	`FIRE_DLC_IOT_REQID_LSB + `FIRE_DLC_IOT_REQID_WDTH -1	// MSB of REQ ID Field
// ~~~~ reqid field access ~~~~
`define	FIRE_DLC_IOT_REQID   		`FIRE_DLC_IOT_REQID_MSB:`FIRE_DLC_IOT_REQID_LSB

`define FIRE_DLC_IOT_LEN_LSB  		`FIRE_DLC_IOT_REQID_LSB + `FIRE_DLC_IOT_REQID_WDTH	// Start of Length Field
`define FIRE_DLC_IOT_LEN_WDTH  		10							// Width of Length Field
`define FIRE_DLC_IOT_LEN_MSB  		`FIRE_DLC_IOT_LEN_LSB + `FIRE_DLC_IOT_LEN_WDTH -1	// MSB of Length Field
// ~~~~ reqid field access ~~~~
`define	FIRE_DLC_IOT_LEN   		`FIRE_DLC_IOT_LEN_MSB:`FIRE_DLC_IOT_LEN_LSB

`define FIRE_DLC_IOT_ATR_LSB  		`FIRE_DLC_IOT_LEN_LSB + `FIRE_DLC_IOT_LEN_WDTH		// Start of Attribute Field
`define FIRE_DLC_IOT_ATR_WDTH  		2							// Width of Attribute Field
`define FIRE_DLC_IOT_ATR_MSB  		`FIRE_DLC_IOT_ATR_LSB + `FIRE_DLC_IOT_ATR_WDTH -1	// MSB of Attribute Field

`define FIRE_DLC_IOT_TC_LSB  		`FIRE_DLC_IOT_ATR_LSB + `FIRE_DLC_IOT_ATR_WDTH		// Start of TC Field 
`define FIRE_DLC_IOT_TC_WDTH  		3							// Width of TC Field 
`define FIRE_DLC_IOT_TC_MSB 		`FIRE_DLC_IOT_TC_LSB + `FIRE_DLC_IOT_TC_WDTH -1		// MSB of TC Field 

`define FIRE_DLC_IOT_TYPE_LSB  		`FIRE_DLC_IOT_TC_LSB + `FIRE_DLC_IOT_TC_WDTH		// Start of Type Field 
`define FIRE_DLC_IOT_TYPE_WDTH  	7							// Width of Type Field 
`define FIRE_DLC_IOT_TYPE_MSB  		`FIRE_DLC_IOT_TYPE_LSB + `FIRE_DLC_IOT_TYPE_WDTH -1	// MSB of Type Field 
// ~~~~ type field access ~~~~
`define	FIRE_DLC_IOT_TYPE   		`FIRE_DLC_IOT_TYPE_MSB:`FIRE_DLC_IOT_TYPE_LSB

`define FIRE_DLC_IOT_REC_WDTH  		`FIRE_DLC_IOT_TYPE_LSB + `FIRE_DLC_IOT_TYPE_WDTH	// Complete Record With

//#############################
// MONDO REQUEST RECORD  (MQR)
// From IMU to LRM
//#############################

`define FIRE_DLC_MQR_ID_LSB             0                                                       // Start of ID Field
`define FIRE_DLC_MQR_ID_WDTH            2                                                       // Width of ID Field
`define FIRE_DLC_MQR_ID_MSB             `FIRE_DLC_MQR_ID_LSB + `FIRE_DLC_MQR_ID_WDTH -1         // MSB of ID Field

`define FIRE_DLC_MQR_TID_LSB            `FIRE_DLC_MQR_ID_LSB + `FIRE_DLC_MQR_ID_WDTH            // Start of TID Field
`define FIRE_DLC_MQR_TID_WDTH           5                                                       // Width of TID Field
`define FIRE_DLC_MQR_TID_MSB            `FIRE_DLC_MQR_TID_LSB + `FIRE_DLC_MQR_TID_WDTH -1       // MSB of TID Field

`define FIRE_DLC_MQR_INO_LSB            `FIRE_DLC_MQR_TID_LSB + `FIRE_DLC_MQR_TID_WDTH           // Start of INO Field
`define FIRE_DLC_MQR_INO_WDTH           6                                                       // Width of INO Field
`define FIRE_DLC_MQR_INO_MSB            `FIRE_DLC_MQR_INO_LSB + `FIRE_DLC_MQR_INO_WDTH -1       // MSB of INO Field

`define FIRE_DLC_MQR_MODE_LSB           `FIRE_DLC_MQR_INO_LSB + `FIRE_DLC_MQR_INO_WDTH           // Start of MODE Field
`define FIRE_DLC_MQR_MODE_WDTH          1                                                       // Width of MODE Field
`define FIRE_DLC_MQR_MODE_MSB           `FIRE_DLC_MQR_MODE_LSB + `FIRE_DLC_MQR_MODE_WDTH -1     // MSB of MODE Field

`define FIRE_DLC_MQR_REC_WDTH           `FIRE_DLC_MQR_MODE_LSB + `FIRE_DLC_MQR_MODE_WDTH +1       // Complete Record With

//#############################
// MONDO REPLY RECORD  (MRR)
// From RRM to IMU
//#############################

`define FIRE_DLC_MRR_ACK_LSB  		0							// Start of ACK Field
`define FIRE_DLC_MRR_ACK_WDTH  		1							// Width of ACK Field
`define FIRE_DLC_MRR_ACK_MSB  		`FIRE_DLC_MRR_ACK_LSB + `FIRE_DLC_MRR_ACK_WDTH -1	// MSB of ACK Field

`define FIRE_DLC_MRR_TAG_LSB 		`FIRE_DLC_MRR_ACK_LSB + `FIRE_DLC_MRR_ACK_WDTH		// Start of Tag Field
`define FIRE_DLC_MRR_TAG_WDTH  		2							// Width of Tag Field
`define FIRE_DLC_MRR_TAG_MSB  		`FIRE_DLC_MRR_TAG_LSB + `FIRE_DLC_MRR_TAG_WDTH -1	// MSB of Tag Field

`define FIRE_DLC_MRR_REC_WDTH  		`FIRE_DLC_MRR_TAG_LSB + `FIRE_DLC_MRR_TAG_WDTH		// Complete Record With

//#############################
// IMU's DMS DIU RAM RECORD  (IRD)
// From IMU's DMS to DIU
//#############################

`define FIRE_DLC_IRD_ADDR_WDTH  	4	// Address width, to address 16 entries
`define FIRE_DLC_IRD_DATA_WDTH  	128	// Data width, 16 bytes
`define FIRE_DLC_IRD_DPAR_WDTH  	5	// Parity width 32 bit parity on data 1 bit for 16 bit bmask
`define FIRE_DLC_IRD_BMASK_WDTH 	16	// 16 bit bmask

//#############################
// TMU's DIM DIU RAM RECORD  (TRD)
// From TMU's DIM to DIU
//#############################

`define FIRE_DLC_TRD_ADDR_WDTH  	8	// Address width, to address 128 entries DMA / 64 entries PIO 1 bit select
`define FIRE_DLC_TRD_DATA_WDTH  	128	// Data width, 16 bytes
`define FIRE_DLC_TRD_DPAR_WDTH  	5	// Parity width 32 bit parity on data 1 bit for 16 bit bmask
`define FIRE_DLC_TRD_BMASK_WDTH 	16	// 16 bit bmask

//#############################
// CLU's CTM DIU RAM RECORD  (CRD)
// From CLU's CTM to DIU
//#############################

`define FIRE_DLC_CRD_ADDR_WDTH  	9	// Address width, to address 128 entries DMA / 64 entries PIO / 16 entries INT 2 bit select

// from DIU to CLU's CTM
`define FIRE_DLC_CRD_DATA_WDTH  	128	// Data with, 16 bytes
`define FIRE_DLC_CRD_DPAR_WDTH  	5	// Parity width 32 bit parity on data 1 bit for 16 bit bmask
`define FIRE_DLC_CRD_BMASK_WDTH 	16	// 16 bit bmask

//#############################
// CLU's CRM DOU DMA RAM RECORD  (CDD)
// From CLU's CRM to DOU
//#############################

`define FIRE_DLC_CDD_ADDR_WDTH  	7	// Address width, to address 128 entries DMA
`define FIRE_DLC_CDD_DATA_WDTH  	128	// Data width, 16 bytes
`define FIRE_DLC_CDD_DPAR_WDTH  	4	// Parity width 32 bit parity on data

//#############################
// CLU's CRM DOU PIO RAM RECORD  (CPD)
// From CLU's CRM to DOU
//#############################

`define FIRE_DLC_CPD_ADDR_WDTH  	6	// Address width, to address 64 entries PIO
`define FIRE_DLC_CPD_DATA_WDTH  	128	// Data width, 16 bytes
`define FIRE_DLC_CPD_DPAR_WDTH  	4	// Parity width 32 bit parity on data

//#############################
// ILU's EIL DOU RAM RECORD  (ERD)
// From ILU's EIL to DOU
//#############################

`define FIRE_DLC_ERD_ADDR_WDTH  	8	// Address width, to address 128 entries DMA / 64 entries PIO

//#############################
// From DOU to ILU's EIL
//#############################

`define FIRE_DLC_ERD_DATA_WDTH  	128	// Data width, 16 bytes
`define FIRE_DLC_ERD_DPAR_WDTH  	4	// Parity width 32 bit parity on data 

//#############################
// Ingress Data Path TMU-ILU (ITI)
//#############################

`define FIRE_DLC_ITI_ADDR_WDTH  	8	// Address width, to IDB
`define FIRE_DLC_ITI_DATA_WDTH  	128	// Data width, 16 bytes
`define FIRE_DLC_ITI_DPAR_WDTH  	4	// Parity width 32 bit parity on data

//#############################
// Ingress MPS width from ILU to CMU
//#############################

`define FIRE_DLC_MPS                    3       // max. payload size

//#############################
// PSB RECORD  (PSR)
// From PMU and CLU to PSB
//#############################

`define FIRE_DLC_PSR_CMD_TYPE_LSB       0							    // LSB of Command Type Field
`define FIRE_DLC_PSR_CMD_TYPE_WDTH      4                                                           // Command Type Width
`define FIRE_DLC_PSR_CMD_TYPE_MSB       `FIRE_DLC_PSR_CMD_TYPE_LSB + `FIRE_DLC_PSR_CMD_TYPE_WDTH-1  // MSB of Command Type Field

`define FIRE_DLC_PSR_TRN_LSB            0							    // LSB of PKTAG Field
`define FIRE_DLC_PSR_TRN_WDTH           5                                                           // PKTAG Width
`define FIRE_DLC_PSR_TRN_MSB            `FIRE_DLC_PSR_TRN_LSB + `FIRE_DLC_PSR_TRN_WDTH -1           // MSB of PKTAG Field 

// DMA READ, DMA WRITE

`define FIRE_DLC_PSR_BYTECNT_LSB        0
`define FIRE_DLC_PSR_BYTECNT_WDTH       12                                                          // BYTE COUNT Width
`define FIRE_DLC_PSR_BYTECNT_MSB        `FIRE_DLC_PSR_BYTECNT_LSB + `FIRE_DLC_PSR_BYTECNT_WDTH -1   // MSB of BYTE COUNT Field
// ~~~~ bytecount field access ~~~~
`define FIRE_DLC_PSR_BYTECNT		`FIRE_DLC_PSR_BYTECNT_MSB:`FIRE_DLC_PSR_BYTECNT_LSB

`define FIRE_DLC_PSR_LENGTH_LSB         `FIRE_DLC_PSR_BYTECNT_LSB + `FIRE_DLC_PSR_BYTECNT_WDTH      // LSB of LENGTH Field
`define FIRE_DLC_PSR_LENGTH_WDTH        10                                                          // LENGTH Width
`define FIRE_DLC_PSR_LENGTH_MSB         `FIRE_DLC_PSR_LENGTH_LSB + `FIRE_DLC_PSR_LENGTH_WDTH -1     // MSB of LENGTH Field
// ~~~~ length field access ~~~~
`define FIRE_DLC_PSR_LENGTH		`FIRE_DLC_PSR_LENGTH_MSB:`FIRE_DLC_PSR_LENGTH_LSB

`define FIRE_DLC_PSR_CLTOT_LSB          `FIRE_DLC_PSR_LENGTH_LSB + `FIRE_DLC_PSR_LENGTH_WDTH        // LSB of CLTOT Field 
`define FIRE_DLC_PSR_CLTOT_WDTH         4                                                           // CLTOT Width
`define FIRE_DLC_PSR_CLTOT_MSB          `FIRE_DLC_PSR_CLTOT_LSB + `FIRE_DLC_PSR_CLTOT_WDTH -1       // MSB of CLTOT Field 
// ~~~~ cl_total field access ~~~~
`define FIRE_DLC_PSR_CLTOT		`FIRE_DLC_PSR_CLTOT_MSB:`FIRE_DLC_PSR_CLTOT_LSB

`define FIRE_DLC_PSR_PKSEQ_LSB          `FIRE_DLC_PSR_CLTOT_LSB + `FIRE_DLC_PSR_CLTOT_WDTH          // LSB of PKSEQ  Field
`define FIRE_DLC_PSR_PKSEQ_WDTH         5                                                           // PKSEQ Width
`define FIRE_DLC_PSR_PKSEQ_MSB          `FIRE_DLC_PSR_PKSEQ_LSB + `FIRE_DLC_PSR_PKSEQ_WDTH -1       // MSB of PKSEQ Field
// ~~~~ pkt_sequence field access ~~~~
`define FIRE_DLC_PSR_PKSEQ		`FIRE_DLC_PSR_PKSEQ_MSB:`FIRE_DLC_PSR_PKSEQ_LSB

`define FIRE_DLC_PSR_CNTX_LSB           `FIRE_DLC_PSR_PKSEQ_LSB + `FIRE_DLC_PSR_PKSEQ_WDTH          // LSB of CNTX  Field
`define FIRE_DLC_PSR_CNTX_WDTH          5                                                           // CNTX Width
`define FIRE_DLC_PSR_CNTX_MSB           `FIRE_DLC_PSR_CNTX_LSB + `FIRE_DLC_PSR_CNTX_WDTH -1         // MSB of CNTX  Field
// ~~~~ context_number field access ~~~~
`define FIRE_DLC_PSR_CNTX		`FIRE_DLC_PSR_CNTX_MSB:`FIRE_DLC_PSR_CNTX_LSB

`define FIRE_DLC_PSR_TRTAG_LSB          `FIRE_DLC_PSR_CNTX_LSB + `FIRE_DLC_PSR_CNTX_WDTH            // LSB of TRTAG Field
`define FIRE_DLC_PSR_TRTAG_WDTH         5                                                           // TRTAG Width
`define FIRE_DLC_PSR_TRTAG_MSB          `FIRE_DLC_PSR_TRTAG_LSB + `FIRE_DLC_PSR_TRTAG_WDTH -1       // MSB of TRTAG Field
// ~~~~ psb sbd tag field access ~~~~
`define FIRE_DLC_PSR_TRTAG		`FIRE_DLC_PSR_TRTAG_MSB:`FIRE_DLC_PSR_TRTAG_LSB

`define FIRE_DLC_PSR_DMA_DATA_WDTH      `FIRE_DLC_PSR_TRTAG_LSB + `FIRE_DLC_PSR_TRTAG_WDTH          // DMA Read/Write Data width == 41


// PIO READ, PIO WRITE
//BP n2 5-24-04
//`define FIRE_DLC_PSR_TRANSID_LSB        0							    // LSB of TRANSID Field
//`define FIRE_DLC_PSR_TRANSID_WDTH       2							    // TRANSIDS Width
//`define FIRE_DLC_PSR_TRANSID_MSB        `FIRE_DLC_PSR_TRANSID_LSB + `FIRE_DLC_PSR_TRANSID_WDTH -1   // MSB of TRANSID Field

//`define FIRE_DLC_PSR_AGENTID_LSB        `FIRE_DLC_PSR_TRANSID_LSB + `FIRE_DLC_PSR_TRANSID_WDTH	    // 
//`define FIRE_DLC_PSR_AGENTID_WDTH       4							    // AGENTID Width
//`define FIRE_DLC_PSR_AGENTID_MSB        `FIRE_DLC_PSR_AGENTID_LSB + `FIRE_DLC_PSR_AGENTID_WDTH -1   // 

`define FIRE_DLC_PSR_THRDID_LSB        0	    // 
`define FIRE_DLC_PSR_THRDID_WDTH       7							    // THRDID Width
`define FIRE_DLC_PSR_THRDID_MSB        `FIRE_DLC_PSR_THRDID_LSB + `FIRE_DLC_PSR_THRDID_WDTH -1   // 

//`define FIRE_DLC_PSR_PIO_DATA_WDTH	`FIRE_DLC_PSR_AGENTID_LSB + `FIRE_DLC_PSR_AGENTID_WDTH	    // PIO Read/Write Data width == 6
`define FIRE_DLC_PSR_PIO_DATA_WDTH	`FIRE_DLC_PSR_THRDID_LSB + `FIRE_DLC_PSR_THRDID_WDTH	    // PIO Read/Write Data width == 7

//#############################
// TSB RECORD  (TSR)
// From RMU to TSB
//#############################

`define FIRE_DLC_TSR_CMD_TYPE_LSB       0                                                           // LSB of COMMAND TYPE
`define FIRE_DLC_TSR_CMD_TYPE_WDTH      4                                                           // COMMAND TYPE Width
`define FIRE_DLC_TSR_CMD_TYPE_MSB       `FIRE_DLC_TSR_CMD_TYPE_LSB + `FIRE_DLC_TSR_CMD_TYPE_WDTH -1 // MSB of COMMAND TYPE

`define FIRE_DLC_TSR_TRN_LSB            0                                                           // LSB of TRN Field
`define FIRE_DLC_TSR_TRN_WDTH           5                                                           // TRN Width
`define FIRE_DLC_TSR_TRN_MSB             `FIRE_DLC_TSR_TRN_LSB + `FIRE_DLC_TSR_TRN_WDTH -1          // LSB of TRN Field


`define FIRE_DLC_TSR_ADALIGN_LSB        0                                                           // LSB of ADDRESS ALIGN Field
`define FIRE_DLC_TSR_ADALIGN_WDTH       7                                                           // ADDRESS ALIGN Width
`define FIRE_DLC_TSR_ADALIGN_MSB        `FIRE_DLC_TSR_ADALIGN_LSB + `FIRE_DLC_TSR_ADALIGN_WDTH -1   // MSB of ADDRESS ALIGN Field
// ~~~~~ ADALIGN field access ~~~~~
`define FIRE_DLC_TSR_ADALIGN           	`FIRE_DLC_TSR_ADALIGN_MSB:`FIRE_DLC_TSR_ADALIGN_LSB

`define FIRE_DLC_TSR_TLPTAG_LSB         `FIRE_DLC_TSR_ADALIGN_LSB + `FIRE_DLC_TSR_ADALIGN_WDTH      // LSB of TLP TAG Field
`define FIRE_DLC_TSR_TLPTAG_WDTH        8                                                           // TLP TAG Width
`define FIRE_DLC_TSR_TLPTAG_MSB         `FIRE_DLC_TSR_TLPTAG_LSB + `FIRE_DLC_TSR_TLPTAG_WDTH -1     // MSB of TLP TAG Field
// ~~~~~ TLPTAG field access ~~~~~
`define FIRE_DLC_TSR_TLPTAG           	`FIRE_DLC_TSR_TLPTAG_MSB:`FIRE_DLC_TSR_TLPTAG_LSB

`define FIRE_DLC_TSR_REQID_LSB          `FIRE_DLC_TSR_TLPTAG_LSB + `FIRE_DLC_TSR_TLPTAG_WDTH        // LSB of REQUEST ID Field
`define FIRE_DLC_TSR_REQID_WDTH         16                                                          // REQUEST ID Width
`define FIRE_DLC_TSR_REQID_MSB          `FIRE_DLC_TSR_REQID_LSB + `FIRE_DLC_TSR_REQID_WDTH -1       // MSB of REQUEST ID Field
// ~~~~~ REQID field access ~~~~~
`define FIRE_DLC_TSR_REQID           	`FIRE_DLC_TSR_REQID_MSB:`FIRE_DLC_TSR_REQID_LSB

`define FIRE_DLC_TSR_BYTECNT_LSB        `FIRE_DLC_TSR_REQID_LSB + `FIRE_DLC_TSR_REQID_WDTH          // LSB of BYTE COUNT Field
`define FIRE_DLC_TSR_BYTECNT_WDTH       12                                                          // BYTE COUNT Width
`define FIRE_DLC_TSR_BYTECNT_MSB        `FIRE_DLC_TSR_BYTECNT_LSB + `FIRE_DLC_TSR_BYTECNT_WDTH -1   // MSB of BYTE COUNT Field
// ~~~~~ BYTECNT field access ~~~~~
`define FIRE_DLC_TSR_BYTECNT           	`FIRE_DLC_TSR_BYTECNT_MSB:`FIRE_DLC_TSR_BYTECNT_LSB

`define FIRE_DLC_TSR_ATTR_LSB           `FIRE_DLC_TSR_BYTECNT_LSB + `FIRE_DLC_TSR_BYTECNT_WDTH      // LSB of ATTRIBUTE Field
`define FIRE_DLC_TSR_ATTR_WDTH          2                                                           // ATTRIBUTE Width
`define FIRE_DLC_TSR_ATTR_MSB           `FIRE_DLC_TSR_ATTR_LSB + `FIRE_DLC_TSR_ATTR_WDTH -1         // MSB of ATTRIBUTE Field
// ~~~~~ ATTR field access ~~~~~
`define FIRE_DLC_TSR_ATTR           	`FIRE_DLC_TSR_ATTR_MSB:`FIRE_DLC_TSR_ATTR_LSB

`define FIRE_DLC_TSR_TC_LSB             `FIRE_DLC_TSR_ATTR_LSB + `FIRE_DLC_TSR_ATTR_WDTH            // LSB of TRAFFIC CLASS Field
`define FIRE_DLC_TSR_TC_WDTH            3                                                           // TRAFFIC CLASS Width
`define FIRE_DLC_TSR_TC_MSB             `FIRE_DLC_TSR_TC_LSB + `FIRE_DLC_TSR_TC_WDTH -1             // MSB of TRAFFIC CLASS Field
// ~~~~~ TC field access ~~~~~
`define FIRE_DLC_TSR_TC           	`FIRE_DLC_TSR_TC_MSB:`FIRE_DLC_TSR_TC_LSB

`define FIRE_DLC_TSR_RD_DATA_WDTH       `FIRE_DLC_TSR_TC_LSB + `FIRE_DLC_TSR_TC_WDTH                // Read Data width == 48
`define FIRE_DLC_TSR_WR_DATA_WDTH       `FIRE_DLC_TSR_TC_LSB + `FIRE_DLC_TSR_TC_WDTH                // Write Data width == 48

//#############################
// Ingress DIM Record (DIM)
// From DIM to LRM
//#############################

`define FIRE_DLC_DIM_DPTR_LSB  		0							// Start of DPTR Field
`define FIRE_DLC_DIM_DPTR_WDTH  	7							// Width of DPTR Field
`define FIRE_DLC_DIM_DPTR_MSB  		`FIRE_DLC_DIM_DPTR_LSB + `FIRE_DLC_DIM_DPTR_WDTH -1	// MSB of DPTR Field

`define FIRE_DLC_DIM_ADDR_LSB 		`FIRE_DLC_DIM_DPTR_LSB + `FIRE_DLC_DIM_DPTR_WDTH	// Start of ADDR Field
`define FIRE_DLC_DIM_ADDR_WDTH  	62							// Width of ADDR Field
`define FIRE_DLC_DIM_ADDR_MSB  		`FIRE_DLC_DIM_ADDR_LSB + `FIRE_DLC_DIM_ADDR_WDTH -1	// MSB of ADDR Field

`define FIRE_DLC_DIM_FDWBE_LSB 		`FIRE_DLC_DIM_ADDR_LSB + `FIRE_DLC_DIM_ADDR_WDTH	
`define FIRE_DLC_DIM_FDWBE_WDTH  	4							
`define FIRE_DLC_DIM_FDWBE_MSB  	`FIRE_DLC_DIM_FDWBE_LSB + `FIRE_DLC_DIM_FDWBE_WDTH -1	

`define FIRE_DLC_DIM_LDWBE_LSB 		`FIRE_DLC_DIM_FDWBE_LSB + `FIRE_DLC_DIM_FDWBE_WDTH	// Start of Field
`define FIRE_DLC_DIM_LDWBE_WDTH  	4							// Width of Field
`define FIRE_DLC_DIM_LDWBE_MSB  	`FIRE_DLC_DIM_LDWBE_LSB + `FIRE_DLC_DIM_LDWBE_WDTH -1	// MSB of Field

`define FIRE_DLC_DIM_TAG_LSB 		`FIRE_DLC_DIM_LDWBE_LSB + `FIRE_DLC_DIM_LDWBE_WDTH	// Start of Field
`define FIRE_DLC_DIM_TAG_WDTH  		8							// Width of Field
`define FIRE_DLC_DIM_TAG_MSB  		`FIRE_DLC_DIM_TAG_LSB + `FIRE_DLC_DIM_TAG_WDTH -1	// MSB of Field

`define FIRE_DLC_DIM_REQID_LSB 		`FIRE_DLC_DIM_TAG_LSB + `FIRE_DLC_DIM_TAG_WDTH		// Start of Field
`define FIRE_DLC_DIM_REQID_WDTH  	16							// Width of Field
`define FIRE_DLC_DIM_REQID_MSB  	`FIRE_DLC_DIM_REQID_LSB + `FIRE_DLC_DIM_REQID_WDTH -1	// MSB of Field

`define FIRE_DLC_DIM_LEN_LSB 		`FIRE_DLC_DIM_REQID_LSB + `FIRE_DLC_DIM_REQID_WDTH	// Start of Field
`define FIRE_DLC_DIM_LEN_WDTH  		10							// Width of Field
`define FIRE_DLC_DIM_LEN_MSB  		`FIRE_DLC_DIM_LEN_LSB + `FIRE_DLC_DIM_LEN_WDTH -1	// MSB of Field

`define FIRE_DLC_DIM_ATR_LSB 		`FIRE_DLC_DIM_LEN_LSB + `FIRE_DLC_DIM_LEN_WDTH		// Start of Field
`define FIRE_DLC_DIM_ATR_WDTH  		2							// Width of Field
`define FIRE_DLC_DIM_ATR_MSB  		`FIRE_DLC_DIM_ATR_LSB + `FIRE_DLC_DIM_ATR_WDTH -1	// MSB of Field

`define FIRE_DLC_DIM_TC_LSB 		`FIRE_DLC_DIM_ATR_LSB + `FIRE_DLC_DIM_ATR_WDTH		// Start of Field
`define FIRE_DLC_DIM_TC_WDTH  		3							// Width of Field
`define FIRE_DLC_DIM_TC_MSB  		`FIRE_DLC_DIM_TC_LSB + `FIRE_DLC_DIM_TC_WDTH -1 	// MSB of Field

`define FIRE_DLC_DIM_TYPE_LSB 		`FIRE_DLC_DIM_TC_LSB + `FIRE_DLC_DIM_TC_WDTH		// Start of Field
`define FIRE_DLC_DIM_TYPE_WDTH  	7							// Width of Field
`define FIRE_DLC_DIM_TYPE_MSB  		`FIRE_DLC_DIM_TYPE_LSB + `FIRE_DLC_DIM_TYPE_WDTH -1	// MSB of Field

`define FIRE_DLC_DIM_REC_WDTH  		`FIRE_DLC_DIM_TYPE_LSB + `FIRE_DLC_DIM_TYPE_WDTH	// Complete Record With

//#############################
// Egress RRM Record (RRM)
// From RRM to DEM
//#############################

`define FIRE_DLC_RRM_DPTR_LSB 		0	                                                // Start of Field
`define FIRE_DLC_RRM_DPTR_WDTH 		6							// Width of Field
`define FIRE_DLC_RRM_DPTR_MSB  		`FIRE_DLC_RRM_DPTR_LSB + `FIRE_DLC_RRM_DPTR_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_TAG_LSB 		`FIRE_DLC_RRM_DPTR_LSB + `FIRE_DLC_RRM_DPTR_WDTH	// Start of Field
`define FIRE_DLC_RRM_TAG_WDTH  		8							// Width of Field
`define FIRE_DLC_RRM_TAG_MSB  		`FIRE_DLC_RRM_TAG_LSB + `FIRE_DLC_RRM_TAG_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_ADDR_LSB 		`FIRE_DLC_RRM_TAG_LSB + `FIRE_DLC_RRM_TAG_WDTH		// Start of Field
`define FIRE_DLC_RRM_ADDR_WDTH  	34							// Width of Field
`define FIRE_DLC_RRM_ADDR_MSB  		`FIRE_DLC_RRM_ADDR_LSB + `FIRE_DLC_RRM_ADDR_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_FDWBE_LSB 		`FIRE_DLC_RRM_ADDR_LSB + `FIRE_DLC_RRM_ADDR_WDTH	// Start of Field
`define FIRE_DLC_RRM_FDWBE_WDTH  	4							// Width of Field
`define FIRE_DLC_RRM_FDWBE_MSB  	`FIRE_DLC_RRM_FDWBE_LSB + `FIRE_DLC_RRM_FDWBE_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_LDWBE_LSB 		`FIRE_DLC_RRM_FDWBE_LSB + `FIRE_DLC_RRM_FDWBE_WDTH	// Start of Field
`define FIRE_DLC_RRM_LDWBE_WDTH  	4							// Width of Field
`define FIRE_DLC_RRM_LDWBE_MSB  	`FIRE_DLC_RRM_LDWBE_LSB + `FIRE_DLC_RRM_LDWBE_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_REQID_LSB 		`FIRE_DLC_RRM_LDWBE_LSB + `FIRE_DLC_RRM_LDWBE_WDTH	// Start of Field
`define FIRE_DLC_RRM_REQID_WDTH  	16							// Width of Field
`define FIRE_DLC_RRM_REQID_MSB 		`FIRE_DLC_RRM_REQID_LSB + `FIRE_DLC_RRM_REQID_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_LEN_LSB 		`FIRE_DLC_RRM_REQID_LSB + `FIRE_DLC_RRM_REQID_WDTH	// Start of Field
`define FIRE_DLC_RRM_LEN_WDTH  		10							// Width of Field
`define FIRE_DLC_RRM_LEN_MSB  		`FIRE_DLC_RRM_LEN_LSB + `FIRE_DLC_RRM_LEN_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_ATR_LSB 		`FIRE_DLC_RRM_LEN_LSB + `FIRE_DLC_RRM_LEN_WDTH		// Start of Field
`define FIRE_DLC_RRM_ATR_WDTH  		2							// Width of Field
`define FIRE_DLC_RRM_ATR_MSB  		`FIRE_DLC_RRM_ATR_LSB + `FIRE_DLC_RRM_ATR_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_TC_LSB 		`FIRE_DLC_RRM_ATR_LSB + `FIRE_DLC_RRM_ATR_WDTH		// Start of Field
`define FIRE_DLC_RRM_TC_WDTH  		3							// Width of Field
`define FIRE_DLC_RRM_TC_MSB  		`FIRE_DLC_RRM_TC_LSB + `FIRE_DLC_RRM_TC_WDTH -1		// MSB of Field

`define FIRE_DLC_RRM_TYPE_LSB 		`FIRE_DLC_RRM_TC_LSB + `FIRE_DLC_RRM_TC_WDTH		// Start of Field
`define FIRE_DLC_RRM_TYPE_WDTH  	7							// Width of Field
`define FIRE_DLC_RRM_TYPE_MSB  		`FIRE_DLC_RRM_TYPE_LSB + `FIRE_DLC_RRM_TYPE_WDTH -1	// MSB of Field

`define FIRE_DLC_RRM_REC_WDTH  		`FIRE_DLC_RRM_TYPE_LSB + `FIRE_DLC_RRM_TYPE_WDTH	// Complete Record With

//#############################
// Ingress PEC Record (IPE)
// From IIL to DIM
//#############################

`define FIRE_DLC_IPE_ADDR_LSB 		0
`define FIRE_DLC_IPE_ADDR_WDTH  	62							// Width of Field
`define FIRE_DLC_IPE_ADDR_MSB  		`FIRE_DLC_IPE_ADDR_LSB + `FIRE_DLC_IPE_ADDR_WDTH -1	// MSB of Field

`define FIRE_DLC_IPE_FDWBE_LSB 		`FIRE_DLC_IPE_ADDR_LSB + `FIRE_DLC_IPE_ADDR_WDTH	// Start of Field
`define FIRE_DLC_IPE_FDWBE_WDTH  	4							// Width of Field
`define FIRE_DLC_IPE_FDWBE_MSB  	`FIRE_DLC_IPE_FDWBE_LSB + `FIRE_DLC_IPE_FDWBE_WDTH -1	// MSB of Field

`define FIRE_DLC_IPE_LDWBE_LSB 		`FIRE_DLC_IPE_FDWBE_LSB + `FIRE_DLC_IPE_FDWBE_WDTH	// Start of Field
`define FIRE_DLC_IPE_LDWBE_WDTH  	4							// Width of Field
`define FIRE_DLC_IPE_LDWBE_MSB 		`FIRE_DLC_IPE_LDWBE_LSB + `FIRE_DLC_IPE_LDWBE_WDTH -1	// MSB of Field

`define FIRE_DLC_IPE_TAG_LSB 		`FIRE_DLC_IPE_LDWBE_LSB + `FIRE_DLC_IPE_LDWBE_WDTH	// Start of Field
`define FIRE_DLC_IPE_TAG_WDTH  		8							// Width of Field
`define FIRE_DLC_IPE_TAG_MSB  		`FIRE_DLC_IPE_TAG_LSB + `FIRE_DLC_IPE_TAG_WDTH -1	// MSB of Field

`define FIRE_DLC_IPE_REQID_LSB 		`FIRE_DLC_IPE_TAG_LSB + `FIRE_DLC_IPE_TAG_WDTH		// Start of Field
`define FIRE_DLC_IPE_REQID_WDTH  	16							// Width of Field
`define FIRE_DLC_IPE_REQID_MSB 		`FIRE_DLC_IPE_REQID_LSB + `FIRE_DLC_IPE_REQID_WDTH -1	// MSB of Field

`define FIRE_DLC_IPE_LEN_LSB 		`FIRE_DLC_IPE_REQID_LSB + `FIRE_DLC_IPE_REQID_WDTH	// Start of Field
`define FIRE_DLC_IPE_LEN_WDTH  		10							// Width of Field
`define FIRE_DLC_IPE_LEN_MSB  		`FIRE_DLC_IPE_LEN_LSB + `FIRE_DLC_IPE_LEN_WDTH -1	// MSB of Field

`define FIRE_DLC_IPE_ATR_LSB 		`FIRE_DLC_IPE_LEN_LSB + `FIRE_DLC_IPE_LEN_WDTH		// Start of Field
`define FIRE_DLC_IPE_ATR_WDTH  		2							// Width of Field
`define FIRE_DLC_IPE_ATR_MSB  		`FIRE_DLC_IPE_ATR_LSB + `FIRE_DLC_IPE_ATR_WDTH -1	// MSB of Field

`define FIRE_DLC_IPE_TC_LSB 		`FIRE_DLC_IPE_ATR_LSB + `FIRE_DLC_IPE_ATR_WDTH		// Start of Field
`define FIRE_DLC_IPE_TC_WDTH  		3							// Width of Field
`define FIRE_DLC_IPE_TC_MSB  		`FIRE_DLC_IPE_TC_LSB + `FIRE_DLC_IPE_TC_WDTH -1		// MSB of Field

`define FIRE_DLC_IPE_TYPE_LSB 		`FIRE_DLC_IPE_TC_LSB + `FIRE_DLC_IPE_TC_WDTH		// Start of Field
`define FIRE_DLC_IPE_TYPE_WDTH  	5							// Width of Field
`define FIRE_DLC_IPE_TYPE_MSB  		`FIRE_DLC_IPE_TYPE_LSB + `FIRE_DLC_IPE_TYPE_WDTH -1	// MSB of Field

`define FIRE_DLC_IPE_F_LSB 		`FIRE_DLC_IPE_TYPE_LSB + `FIRE_DLC_IPE_TYPE_WDTH	// Start of Field
`define FIRE_DLC_IPE_F_WDTH  		2							// Width of Field
`define FIRE_DLC_IPE_F_MSB  		`FIRE_DLC_IPE_F_LSB + `FIRE_DLC_IPE_F_WDTH -1		// MSB of Field

`define FIRE_DLC_IPE_REC_WDTH  		`FIRE_DLC_IPE_F_LSB + `FIRE_DLC_IPE_F_WDTH		// Complete Record With

//#############################
// Egress PEC Record (EPE)
// From DEM to EIL
//#############################

`define FIRE_DLC_EPE_DPTR_LSB 		0                                                       // Start of Field
`define FIRE_DLC_EPE_DPTR_WDTH  	6							// Width of Field
`define FIRE_DLC_EPE_DPTR_MSB  		`FIRE_DLC_EPE_DPTR_LSB + `FIRE_DLC_EPE_DPTR_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_ADDR_LSB 		`FIRE_DLC_EPE_DPTR_LSB + `FIRE_DLC_EPE_DPTR_WDTH	// Start of Field
`define FIRE_DLC_EPE_ADDR_WDTH  	64							// Width of Field
`define FIRE_DLC_EPE_ADDR_MSB  		`FIRE_DLC_EPE_ADDR_LSB + `FIRE_DLC_EPE_ADDR_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_FDWBE_LSB 		`FIRE_DLC_EPE_ADDR_LSB + `FIRE_DLC_EPE_ADDR_WDTH	// Start of Field
`define FIRE_DLC_EPE_FDWBE_WDTH  	4							// Width of Field
`define FIRE_DLC_EPE_FDWBE_MSB 		`FIRE_DLC_EPE_FDWBE_LSB + `FIRE_DLC_EPE_FDWBE_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_LDWBE_LSB 		`FIRE_DLC_EPE_FDWBE_LSB + `FIRE_DLC_EPE_FDWBE_WDTH	// Start of Field
`define FIRE_DLC_EPE_LDWBE_WDTH  	4							// Width of Field
`define FIRE_DLC_EPE_LDWBE_MSB 		`FIRE_DLC_EPE_LDWBE_LSB + `FIRE_DLC_EPE_LDWBE_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_TAG_LSB 		`FIRE_DLC_EPE_LDWBE_LSB + `FIRE_DLC_EPE_LDWBE_WDTH	// Start of Field
`define FIRE_DLC_EPE_TAG_WDTH  		8							// Width of Field
`define FIRE_DLC_EPE_TAG_MSB  		`FIRE_DLC_EPE_TAG_LSB + `FIRE_DLC_EPE_TAG_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_REQID_LSB 		`FIRE_DLC_EPE_TAG_LSB + `FIRE_DLC_EPE_TAG_WDTH		// Start of Field
`define FIRE_DLC_EPE_REQID_WDTH  	16							// Width of Field
`define FIRE_DLC_EPE_REQID_MSB 		`FIRE_DLC_EPE_REQID_LSB + `FIRE_DLC_EPE_REQID_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_LEN_LSB 		`FIRE_DLC_EPE_REQID_LSB + `FIRE_DLC_EPE_REQID_WDTH	// Start of Field
`define FIRE_DLC_EPE_LEN_WDTH  		10							// Width of Field
`define FIRE_DLC_EPE_LEN_MSB  		`FIRE_DLC_EPE_LEN_LSB + `FIRE_DLC_EPE_LEN_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_ATR_LSB 		`FIRE_DLC_EPE_LEN_LSB + `FIRE_DLC_EPE_LEN_WDTH		// Start of Field
`define FIRE_DLC_EPE_ATR_WDTH  		2							// Width of Field
`define FIRE_DLC_EPE_ATR_MSB  		`FIRE_DLC_EPE_ATR_LSB + `FIRE_DLC_EPE_ATR_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_TC_LSB 		`FIRE_DLC_EPE_ATR_LSB + `FIRE_DLC_EPE_ATR_WDTH		// Start of Field
`define FIRE_DLC_EPE_TC_WDTH  		3							// Width of Field
`define FIRE_DLC_EPE_TC_MSB  		`FIRE_DLC_EPE_TC_LSB + `FIRE_DLC_EPE_TC_WDTH -1		// MSB of Field

`define FIRE_DLC_EPE_TYPE_LSB 		`FIRE_DLC_EPE_TC_LSB + `FIRE_DLC_EPE_TC_WDTH		// Start of Field
`define FIRE_DLC_EPE_TYPE_WDTH  	5							// Width of Field
`define FIRE_DLC_EPE_TYPE_MSB  		`FIRE_DLC_EPE_TYPE_LSB + `FIRE_DLC_EPE_TYPE_WDTH -1	// MSB of Field

`define FIRE_DLC_EPE_F_LSB 		`FIRE_DLC_EPE_TYPE_LSB + `FIRE_DLC_EPE_TYPE_WDTH	// Start of Field
`define FIRE_DLC_EPE_F_WDTH  		2							// Width of Field
`define FIRE_DLC_EPE_F_MSB  		`FIRE_DLC_EPE_F_LSB + `FIRE_DLC_EPE_F_WDTH -1		// MSB of Field

`define FIRE_DLC_EPE_REC_WDTH  		`FIRE_DLC_EPE_F_LSB + `FIRE_DLC_EPE_F_WDTH		// Complete Record With

//#############################
// Ingress (Upbound) Release Record (URR)
// From DIM to IIL
//#############################

`define FIRE_DLC_URR_DPTR_LSB 		0							// Start of Field
`define FIRE_DLC_URR_DPTR_WDTH  	8							// Width of Field
`define FIRE_DLC_URR_DPTR_MSB  		`FIRE_DLC_URR_DPTR_LSB + `FIRE_DLC_URR_DPTR_WDTH -1	// MSB of Field

`define FIRE_DLC_URR_TYPE_LSB 		`FIRE_DLC_URR_DPTR_LSB + `FIRE_DLC_URR_DPTR_WDTH	// Start of Field
`define FIRE_DLC_URR_TYPE_WDTH  	1							// Width of Field
`define FIRE_DLC_URR_TYPE_MSB  		`FIRE_DLC_URR_TYPE_LSB + `FIRE_DLC_URR_TYPE_WDTH -1	// MSB of Field

`define FIRE_DLC_URR_REC_WDTH  		`FIRE_DLC_URR_TYPE_LSB + `FIRE_DLC_URR_TYPE_WDTH

//#############################
// Egress (Downbound) Release Record (DRR)
// From EIL to RRM
//#############################

`define FIRE_DLC_DRR_DPTR_LSB 		0							// Start of Field
`define FIRE_DLC_DRR_DPTR_WDTH  	8							// Width of Field
`define FIRE_DLC_DRR_DPTR_MSB  		`FIRE_DLC_DRR_DPTR_LSB + `FIRE_DLC_DRR_DPTR_WDTH -1	// MSB of Field

`define FIRE_DLC_DRR_TYPE_LSB 		`FIRE_DLC_DRR_DPTR_LSB + `FIRE_DLC_DRR_DPTR_WDTH	// Start of Field
`define FIRE_DLC_DRR_TYPE_WDTH  	1							// Width of Field
`define FIRE_DLC_DRR_TYPE_MSB  		`FIRE_DLC_DRR_TYPE_LSB + `FIRE_DLC_DRR_TYPE_WDTH -1	// MSB of Field

`define FIRE_DLC_DRR_REC_WDTH  		`FIRE_DLC_DRR_TYPE_LSB + `FIRE_DLC_DRR_TYPE_WDTH

//#############################
// Ingress DIU Buffer Read/write Pointers
// Between CLU to TMU
//#############################

`define FIRE_DLC_DMA_RPTR_WDTH		6
`define FIRE_DLC_INT_RPTR_WDTH		5

`define FIRE_DLC_DMA_WPTR_WDTH		6
`define FIRE_DLC_PIO_WPTR_WDTH		5

//#############################
// Egress DOU Buffer Release
// From RMU to CLU
//#############################

`define FIRE_DLC_DOU_REL_WDTH		5

//#######################################
// Egress DOU DMA Read Completion Buffer 
// Status Record Portion k2y_dou_dptr
// From CLU to ILU 
//#######################################

`define FIRE_DLC_DOU_DPTR_WDTH   	5
`define FIRE_DLC_DOU_DPTR_DPTH         32


//#######################################
// Debug Ports 
// 
//#######################################
`define FIRE_DLC_DEBUG_SEL_WDTH         6
`define FIRE_DLC_DBG_SEL_BITS           `FIRE_DLC_DEBUG_SEL_WDTH-1:0
