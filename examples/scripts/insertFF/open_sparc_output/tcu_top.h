/*
* ========== Copyright Header Begin ==========================================
* 
* OpenSPARC T2 Processor File: tcu_top.h
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
`ifdef PALLADIUM
`else
`timescale      1ps/1ps
`endif

`ifdef TOP
// External environment should specify TOP
`else
`define TOP     tb_top
`endif

// Dispmon defines (See also N2 :/verif/env/common/verilog/misc)
`include "dispmonDefines.vh"


// These defines are used for all environments (TCU_SAT, FC, DFT_SAT)
`define TCK_HALF_PERIOD     25400    // ps., 20Mhz  == 50000ps 19.7Mhz = 25400
`define SYS_HALF_PERIOD      2500    // ps., 200Mhz == 5000ps

// Monitors and aids to 0-in
`define MONTCU  `TOP.tcu_mon    // Verilog DUT monitors
`define MONCCU  `TOP.ccu_mon    // Verilog DUT monitors
`define MONRST  `TOP.rst_mon    // Verilog DUT monitors

`ifdef TCU_SAT
// These are used in the verilog finishVera() call
`ifdef DFT_CFG
`define TOP_SHELL dft_top_shell
`else
`define TOP_SHELL tcu_top_shell
`endif

// Timeout for simulation
`define TOP_MAX_CYCLE      50_000

// These should be defined in higher level simulation
`define CPU     `TOP.cpu    // Chip level
`define TCU	`CPU.tcu    // Test control unit
`define CCU     `CPU.ccu    // Clock control unit
`define RST     `CPU.rst    // Reset logic unit
`define EFU     `CPU.efu    // Electronic fuse unit
`define NCU     `CPU.ncu    // Non-cacheable unit
`define SII     `CPU.sii    // sii unit
`define SIO     `CPU.sio    // sio unit

`endif
