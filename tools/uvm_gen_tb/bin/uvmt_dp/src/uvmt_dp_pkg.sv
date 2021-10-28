// Copyright 2021 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_DP_PKG_SV__
`define __UVMT_DP_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.sv"
`include "uvml_logs_macros.sv"
`include "uvma_clk_macros.sv"
`include "uvma_reset_macros.sv"
`include "uvma_axil_macros.sv"
`include "uvme_dp_macros.sv"
`include "uvmt_dp_macros.sv"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_dp_probe_if.sv"


/**
 * Encapsulates all the types and test cases for the verification of a Data Plane RTL design.
 */
package uvmt_dp_pkg;
   
   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;
   import uvma_clk_pkg::*;
   import uvma_reset_pkg::*;
   import uvma_axil_pkg::*;
   import uvme_dp_pkg::*;
   
   // Constants / Structs / Enums
   `include "uvmt_dp_tdefs.sv"
   `include "uvmt_dp_constants.sv"
   
   // Base tests
   `include "uvmt_dp_test_cfg.sv"
   `include "uvmt_dp_base_test.sv"
   `include "uvmt_dp_reg_base_test.sv"
   
   // Functional tests
   `include "uvmt_dp_reg_hw_reset_test.sv"
   `include "uvmt_dp_reg_bit_bash_test.sv"
   
endpackage : uvmt_dp_pkg


// Module(s) / Checker(s)
`include "uvmt_dp_dut_wrap.sv"
`include "uvmt_dp_dut_chkr.sv"
`include "uvmt_dp_tb.sv"


`endif // __UVMT_DP_PKG_SV__
