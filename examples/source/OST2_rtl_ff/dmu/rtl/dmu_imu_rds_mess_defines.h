/*
* ========== Copyright Header Begin ==========================================
* 
* OpenSPARC T2 Processor File: dmu_imu_rds_mess_defines.h
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
`ifdef FIRE_DLC_IMU_RDS_MESS_DEFINES
`else
`define FIRE_DLC_IMU_RDS_MESS_DEFINES

`define FIRE_DLC_IMU_RDS_MESS_INSTANCE_ID_VALUE_A 1'h0
`define FIRE_DLC_IMU_RDS_MESS_INSTANCE_ID_VALUE_B 1'h1

//-------------------------------------------------------
//----- Variable definitions for register fire_dlc_imu_rds_mess_csr_err_cor_mapping
//-------------------------------------------------------

`define FIRE_DLC_IMU_RDS_MESS_CSR_A_ERR_COR_MAPPING_HW_ADDR	27'b000000011000110000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_A_ERR_COR_MAPPING_ADDR	30'b000000011000110000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_ERR_COR_MAPPING_HW_ADDR	27'b000000011100110000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_ERR_COR_MAPPING_ADDR	30'b000000011100110000000000000000

`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_WIDTH	64
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_DEPTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_INT_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_LOW_ADDR_WIDTH	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_ADDR_RANGE	26:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_READ_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_READ_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_WRITE_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_WRITE_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_SET_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_CLEAR_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_TOGGLE_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_RMASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_RESERVED_BIT_MASK	64'b0111111111111111111111111111111111111111111111111111111111000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_POR_VALUE	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_INTERNAL_REG	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_ZERO_TIME_OMNI	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_NUM_FIELDS	2
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_V_FID	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_V_SLC	63:63
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_V_WIDTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_V_INT_SLC	0:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_V_POSITION	63
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_V_FMASK	64'b1000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_V_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_V_POR_VALUE	1'b0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_EQNUM_FID	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_EQNUM_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_EQNUM_WIDTH	6
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_EQNUM_INT_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_EQNUM_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_EQNUM_FMASK	64'b0000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_EQNUM_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_COR_MAPPING_EQNUM_POR_VALUE	6'b000000

//-------------------------------------------------------
//----- Variable definitions for register fire_dlc_imu_rds_mess_csr_err_nonfatal_mapping
//-------------------------------------------------------

`define FIRE_DLC_IMU_RDS_MESS_CSR_A_ERR_NONFATAL_MAPPING_HW_ADDR	27'b000000011000110000000000001
`define FIRE_DLC_IMU_RDS_MESS_CSR_A_ERR_NONFATAL_MAPPING_ADDR	30'b000000011000110000000000001000
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_ERR_NONFATAL_MAPPING_HW_ADDR	27'b000000011100110000000000001
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_ERR_NONFATAL_MAPPING_ADDR	30'b000000011100110000000000001000

`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_WIDTH	64
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_DEPTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_INT_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_LOW_ADDR_WIDTH	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_ADDR_RANGE	26:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_READ_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_READ_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_WRITE_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_WRITE_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_SET_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_CLEAR_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_TOGGLE_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_RMASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_RESERVED_BIT_MASK	64'b0111111111111111111111111111111111111111111111111111111111000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_POR_VALUE	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_INTERNAL_REG	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_ZERO_TIME_OMNI	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_NUM_FIELDS	2
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_V_FID	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_V_SLC	63:63
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_V_WIDTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_V_INT_SLC	0:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_V_POSITION	63
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_V_FMASK	64'b1000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_V_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_V_POR_VALUE	1'b0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_EQNUM_FID	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_EQNUM_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_EQNUM_WIDTH	6
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_EQNUM_INT_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_EQNUM_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_EQNUM_FMASK	64'b0000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_EQNUM_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_NONFATAL_MAPPING_EQNUM_POR_VALUE	6'b000000

//-------------------------------------------------------
//----- Variable definitions for register fire_dlc_imu_rds_mess_csr_err_fatal_mapping
//-------------------------------------------------------

`define FIRE_DLC_IMU_RDS_MESS_CSR_A_ERR_FATAL_MAPPING_HW_ADDR	27'b000000011000110000000000010
`define FIRE_DLC_IMU_RDS_MESS_CSR_A_ERR_FATAL_MAPPING_ADDR	30'b000000011000110000000000010000
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_ERR_FATAL_MAPPING_HW_ADDR	27'b000000011100110000000000010
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_ERR_FATAL_MAPPING_ADDR	30'b000000011100110000000000010000

`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_WIDTH	64
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_DEPTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_INT_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_LOW_ADDR_WIDTH	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_ADDR_RANGE	26:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_READ_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_READ_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_WRITE_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_WRITE_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_SET_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_CLEAR_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_TOGGLE_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_RMASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_RESERVED_BIT_MASK	64'b0111111111111111111111111111111111111111111111111111111111000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_POR_VALUE	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_INTERNAL_REG	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_ZERO_TIME_OMNI	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_NUM_FIELDS	2
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_V_FID	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_V_SLC	63:63
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_V_WIDTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_V_INT_SLC	0:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_V_POSITION	63
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_V_FMASK	64'b1000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_V_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_V_POR_VALUE	1'b0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_EQNUM_FID	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_EQNUM_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_EQNUM_WIDTH	6
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_EQNUM_INT_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_EQNUM_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_EQNUM_FMASK	64'b0000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_EQNUM_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_ERR_FATAL_MAPPING_EQNUM_POR_VALUE	6'b000000

//-------------------------------------------------------
//----- Variable definitions for register fire_dlc_imu_rds_mess_csr_pm_pme_mapping
//-------------------------------------------------------

`define FIRE_DLC_IMU_RDS_MESS_CSR_A_PM_PME_MAPPING_HW_ADDR	27'b000000011000110000000000011
`define FIRE_DLC_IMU_RDS_MESS_CSR_A_PM_PME_MAPPING_ADDR	30'b000000011000110000000000011000
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_PM_PME_MAPPING_HW_ADDR	27'b000000011100110000000000011
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_PM_PME_MAPPING_ADDR	30'b000000011100110000000000011000

`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_WIDTH	64
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_DEPTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_INT_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_LOW_ADDR_WIDTH	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_ADDR_RANGE	26:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_READ_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_READ_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_WRITE_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_WRITE_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_SET_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_CLEAR_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_TOGGLE_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_RMASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_RESERVED_BIT_MASK	64'b0111111111111111111111111111111111111111111111111111111111000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_POR_VALUE	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_INTERNAL_REG	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_ZERO_TIME_OMNI	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_NUM_FIELDS	2
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_V_FID	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_V_SLC	63:63
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_V_WIDTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_V_INT_SLC	0:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_V_POSITION	63
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_V_FMASK	64'b1000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_V_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_V_POR_VALUE	1'b0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_EQNUM_FID	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_EQNUM_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_EQNUM_WIDTH	6
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_EQNUM_INT_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_EQNUM_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_EQNUM_FMASK	64'b0000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_EQNUM_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PM_PME_MAPPING_EQNUM_POR_VALUE	6'b000000

//-------------------------------------------------------
//----- Variable definitions for register fire_dlc_imu_rds_mess_csr_pme_to_ack_mapping
//-------------------------------------------------------

`define FIRE_DLC_IMU_RDS_MESS_CSR_A_PME_TO_ACK_MAPPING_HW_ADDR	27'b000000011000110000000000100
`define FIRE_DLC_IMU_RDS_MESS_CSR_A_PME_TO_ACK_MAPPING_ADDR	30'b000000011000110000000000100000
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_PME_TO_ACK_MAPPING_HW_ADDR	27'b000000011100110000000000100
`define FIRE_DLC_IMU_RDS_MESS_CSR_B_PME_TO_ACK_MAPPING_ADDR	30'b000000011100110000000000100000

`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_WIDTH	64
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_DEPTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_INT_SLC	63:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_LOW_ADDR_WIDTH	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_ADDR_RANGE	26:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_READ_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_READ_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_WRITE_MASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_WRITE_ONLY_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_SET_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_CLEAR_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_TOGGLE_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_RMASK	64'b1000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_RESERVED_BIT_MASK	64'b0111111111111111111111111111111111111111111111111111111111000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_POR_VALUE	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_INTERNAL_REG	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_ZERO_TIME_OMNI	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_NUM_FIELDS	2
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_V_FID	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_V_SLC	63:63
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_V_WIDTH	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_V_INT_SLC	0:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_V_POSITION	63
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_V_FMASK	64'b1000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_V_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_V_POR_VALUE	1'b0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_EQNUM_FID	1
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_EQNUM_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_EQNUM_WIDTH	6
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_EQNUM_INT_SLC	5:0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_EQNUM_POSITION	0
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_EQNUM_FMASK	64'b0000000000000000000000000000000000000000000000000000000000111111
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_EQNUM_HW_LD_MASK	64'b0000000000000000000000000000000000000000000000000000000000000000
`define FIRE_DLC_IMU_RDS_MESS_CSR_PME_TO_ACK_MAPPING_EQNUM_POR_VALUE	6'b000000


`endif
