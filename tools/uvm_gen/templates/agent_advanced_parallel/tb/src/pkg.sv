// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ upper(name) }}_ST_PKG_SV__
`define __UVMT_{{ upper(name) }}_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvml_mem_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvma_{{ name }}_macros.svh"
`include "uvme_{{ name }}_st_macros.svh"
`include "uvmt_{{ name }}_st_macros.svh"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_{{ name }}_st_clknrst_gen_if.sv"


/**
 * Encapsulates all the types and test cases for self-testing the {{ full_name }} ({{ upper(name) }}) UVM Agent.
 */
package uvmt_{{ name }}_st_pkg;

   import uvm_pkg        ::*;
   import uvml_pkg       ::*;
   import uvml_logs_pkg  ::*;
   import uvml_mem_pkg   ::*;
   import uvml_sb_pkg    ::*;
   import uvma_{{ name }}_pkg   ::*;
   import uvme_{{ name }}_st_pkg::*;

   // Constants / Structs / Enums
   `include "uvmt_{{ name }}_st_tdefs.sv"
   `include "uvmt_{{ name }}_st_constants.sv"

   // Virtual sequence library
   `include "uvmt_{{ name }}_st_vseq_lib.sv"

   // Base test
   `include "uvmt_{{ name }}_st_test_cfg.sv"
   `include "uvmt_{{ name }}_st_base_test.sv"

   // Tests
   `include "uvmt_{{ name }}_st_reads_test.sv"
   `include "uvmt_{{ name }}_st_writes_test.sv"
   `include "uvmt_{{ name }}_st_all_access_test.sv"
   `include "uvmt_{{ name }}_st_print_test.sv"

endpackage : uvmt_{{ name }}_st_pkg


// Module(s) / Checker(s)
`include "uvmt_{{ name }}_st_dut_wrap.sv"
`include "uvmt_{{ name }}_st_dut_chkr.sv"
`include "uvmt_{{ name }}_st_tb.sv"


`endif // __UVMT_{{ upper(name) }}_ST_PKG_SV__
