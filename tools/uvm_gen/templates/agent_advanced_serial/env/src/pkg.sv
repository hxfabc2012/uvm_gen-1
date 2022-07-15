// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name.upper() }}_ST_PKG_SV__
`define __UVME_{{ name.upper() }}_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.sv"
`include "uvml_logs_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvma_{{ name }}_macros.svh"
`include "uvme_{{ name }}_st_macros.svh"

// Interface(s)


 /**
 * Encapsulates all the types needed for an UVM environment capable of self-testing the {{ full_name }}.
 */
package uvme_{{ name }}_st_pkg;

   import uvm_pkg         ::*;
   import uvml_pkg        ::*;
   import uvml_logs_pkg   ::*;
   import uvml_sb_pkg     ::*;
   import uvma_{{ name }}_pkg::*;

   // Constants / Structs / Enums
   `include "uvme_{{ name }}_st_tdefs.sv"
   `include "uvme_{{ name }}_st_constants.sv"

   // Objects
   `include "uvme_{{ name }}_st_cfg.sv"
   `include "uvme_{{ name }}_st_cntxt.sv"

   // Environment components
   `include "uvme_{{ name }}_st_cov_model.sv"
   `include "uvme_{{ name }}_st_prd.sv"
   `include "uvme_{{ name }}_st_sb.sv"
   `include "uvme_{{ name }}_st_vsqr.sv"
   `include "uvme_{{ name }}_st_env.sv"

   // Sequences
   `include "uvme_{{ name }}_st_vseq_lib.sv"

endpackage : uvme_{{ name }}_st_pkg


// Module(s) / Checker(s)
`ifdef UVME_{{ name.upper() }}_ST_INC_CHKR
`include "uvme_{{ name }}_st_chkr.sv"
`endif


`endif // __UVME_{{ name.upper() }}_ST_PKG_SV__
