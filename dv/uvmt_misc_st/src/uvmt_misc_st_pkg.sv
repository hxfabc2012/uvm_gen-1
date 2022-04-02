// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MISC_ST_PKG_SV__
`define __UVMT_MISC_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvml_math_macros.svh"
`include "uvmt_misc_st_macros.svh"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_misc_st_clknrst_gen_if.sv"


/**
 * Encapsulates all the types and test cases for self-testing Miscellaneous.
 */
package uvmt_misc_st_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;
   import uvml_sb_pkg  ::*;
   import uvml_math_pkg::*;

   // Constants / Structs / Enums
   `include "uvmt_misc_st_tdefs.sv"
   `include "uvmt_misc_st_constants.sv"

   // Objects
   `include "uvmt_misc_st_seq_item.sv"

   // Components
   `include "uvme_misc_st_vsqr.sv"

   // Generated code
   `include "uvmt_misc_st_my_obj.sv"
   `include "uvmt_misc_st_my_comp.sv"
   `include "uvmt_misc_st_reg_adapter.sv"
   `include "uvmt_misc_st_status_reg.sv"
   `include "uvmt_misc_st_top_reg_block.sv"
   `include "uvmt_misc_st_traffic_seq.sv"
   `include "uvme_misc_st_basic_access_vseq.sv"
   `include "uvmt_misc_st_mstr_seq_lib.sv"
   `include "uvmt_misc_st_cpu_vseq_lib.sv"

   // Base test
   `include "uvmt_misc_st_test_cfg.sv"
   `include "uvmt_misc_st_base_test.sv"

   // Generated test
   `include "uvmt_misc_st_smoke_test.sv"

endpackage : uvmt_misc_st_pkg


// Module(s) / Checker(s)
`include "uvmt_misc_st_dut_wrap.sv"
`include "uvmt_misc_st_dut_chkr.sv"
`include "uvmt_misc_st_tb.sv"


`endif // __UVMT_MISC_ST_PKG_SV__
