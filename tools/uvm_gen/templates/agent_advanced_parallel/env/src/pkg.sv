// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_PKG_SV__
`define __UVME_{{ upper(name) }}_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvma_{{ name }}_macros.svh"
`include "uvme_{{ name }}_st_macros.svh"

// Interface(s) / Module(s) / Checker(s)
`ifdef UVME_{{ upper(name) }}_ST_INC_CHKR
`include "uvme_{{ name }}_st_chkr.sv"
`endif


 /**
 * Encapsulates all the types needed for the Moore.io UVM environment capable of self-testing the {{ full_name }}
 * ({{ upper(name) }}) UVM Agent.
 */
package uvme_{{ name }}_st_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;
   import uvml_sb_pkg  ::*;
   import uvma_{{ name }}_pkg ::*;
   import uvml_mem_pkg ::*;

   // Constants / Structs / Enums
   `include "uvme_{{ name }}_st_tdefs.sv"
   `include "uvme_{{ name }}_st_constants.sv"

   // Objects
   `include "uvme_{{ name }}_st_cfg.sv"
   `include "uvme_{{ name }}_st_cntxt.sv"
   `include "uvme_{{ name }}_st_e2e_mon_trn.sv"
   `include "uvme_{{ name }}_st_mstr_mon_trn.sv"
   `include "uvme_{{ name }}_st_slv_mon_trn.sv"

   // Environment components
   `include "uvme_{{ name }}_st_cov_model.sv"
   `include "uvme_{{ name }}_st_prd.sv"
   `include "uvme_{{ name }}_st_vsqr.sv"
   `include "uvme_{{ name }}_st_env.sv"

   // Virtual Sequences
   `include "uvme_{{ name }}_st_vseq_lib.sv"

endpackage : uvme_{{ name }}_st_pkg


`endif // __UVME_{{ upper(name) }}_ST_PKG_SV__
