// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_PKG_SV__
`define __UVMT_${name_uppercase}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvma_clk_macros.svh"
`include "uvma_reset_macros.svh"
`include "uvma_${ral_agent_type}_macros.svh"
`include "uvme_${name}_macros.svh"
`include "uvmt_${name}_macros.svh"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_${name}_probe_if.sv"


/**
 * Encapsulates all the types of the ${name_normal_case} Sub-System UVM Test Bench.
 */
package uvmt_${name}_pkg;

   import uvm_pkg       ::*;
   import uvml_pkg      ::*;
   import uvml_logs_pkg ::*;
   import uvml_sb_pkg   ::*;
   import uvml_ral_pkg  ::*;
   import uvma_clk_pkg  ::*;
   import uvma_reset_pkg::*;
   import uvma_${ral_agent_type}_pkg::*;
   import uvme_${name}_pkg::*;

   // Constants / Structs / Enums
   `include "uvmt_${name}_tdefs.sv"
   `include "uvmt_${name}_constants.sv"

   // Base tests
   `include "uvmt_${name}_test_cfg.sv"
   `include "uvmt_${name}_base_test.sv"
   `include "uvmt_${name}_reg_base_test.sv"

   // Functional tests
   `include "uvmt_${name}_reg_hw_reset_test.sv"
   `include "uvmt_${name}_reg_bit_bash_test.sv"

endpackage : uvmt_${name}_pkg


// Module(s) / Checker(s)
`include "uvmt_${name}_dut_wrap.sv"
`include "uvmt_${name}_dut_chkr.sv"
`include "uvmt_${name}_tb.sv"


`endif // __UVMT_${name_uppercase}_PKG_SV__
