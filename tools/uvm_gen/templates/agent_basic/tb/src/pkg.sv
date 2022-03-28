// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_ST_PKG_SV__
`define __UVMT_${name_uppercase}_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.sv"
`include "uvml_logs_macros.sv"
`include "uvml_sb_macros.sv"
`include "uvma_${name}_macros.sv"
`include "uvme_${name}_st_macros.sv"
`include "uvmt_${name}_st_macros.sv"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_${name}_st_clknrst_gen_if.sv"


/**
 * Encapsulates the test library of the ${name_normal_case} UVM Agent Self-Test Bench.
 */
package uvmt_${name}_st_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;
   import uvml_sb_pkg  ::*;
   import uvma_${name}_pkg::*;
   import uvme_${name}_st_pkg::*;

   // Constants / Structs / Enums
   `include "uvmt_${name}_st_tdefs.sv"
   `include "uvmt_${name}_st_constants.sv"

   // Tests
   `include "uvmt_${name}_st_test_cfg.sv"
   `include "uvmt_${name}_st_base_test.sv"
   `include "uvmt_${name}_st_rand_stim_test.sv"

endpackage : uvmt_${name}_st_pkg


// Module(s) / Checker(s)
`include "uvmt_${name}_st_dut_wrap.sv"
`include "uvmt_${name}_st_dut_chkr.sv"
`include "uvmt_${name}_st_tb.sv"


`endif // __UVMT_${name_uppercase}_ST_PKG_SV__
