// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_PKG_SV__
`define __UVMA_{{ upper(name) }}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvma_{{ name }}_macros.svh"

// Interface(s)
`include "uvma_{{ name }}_if.sv"


/**
 * Encapsulates all the types needed for an UVM agent capable of driving and/or monitoring {{ full_name }}.
 */
package uvma_{{ name }}_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;

   // Constants / Structs / Enums
   `include "uvma_{{ name }}_tdefs.sv"
   `include "uvma_{{ name }}_constants.sv"

   // Objects
   `include "uvma_{{ name }}_cfg.sv"
   `include "uvma_{{ name }}_mon_fsm_cntxt.sv"
   `include "uvma_{{ name }}_cntxt.sv"

   // Transactions
   `include "uvma_{{ name }}_mon_trn.sv"
{% if symmetric %}   `include "uvma_{{ name }}_phy_mon_trn.sv"
{% else %}   `include "uvma_{{ name }}_{{ tx }}_mon_trn.sv"
   `include "uvma_{{ name }}_{{ rx }}_mon_trn.sv"
{% endif %}   `include "uvma_{{ name }}_seq_item.sv"
{% if symmetric %}   `include "uvma_{{ name }}_phy_seq_item.sv"
{% else %}   `include "uvma_{{ name }}_{{ tx }}_seq_item.sv"
   `include "uvma_{{ name }}_{{ rx }}_seq_item.sv"
{% endif %}
   // Drivers
{% if symmetric %}   `include "uvma_{{ name }}_phy_drv.sv"
{% else %}   `include "uvma_{{ name }}_{{ tx }}_drv.sv"
   `include "uvma_{{ name }}_{{ rx }}_drv.sv"
{% endif %}
   // Sequencers
{% if symmetric %}   `include "uvma_{{ name }}_phy_sqr.sv"
{% else %}   `include "uvma_{{ name }}_{{ tx }}_sqr.sv"
   `include "uvma_{{ name }}_{{ rx }}_sqr.sv"
{% endif %}
   // Agent-Level Components
   `include "uvma_{{ name }}_mon.sv"
   `include "uvma_{{ name }}_drv.sv"
   `include "uvma_{{ name }}_vsqr.sv"
   `include "uvma_{{ name }}_logger.sv"
   `include "uvma_{{ name }}_cov_model.sv"
   `include "uvma_{{ name }}_agent.sv"

   // Sequences
   `include "uvma_{{ name }}_base_vseq.sv"
   `include "uvma_{{ name }}_mon_vseq.sv"
   `include "uvma_{{ name }}_training_vseq.sv"
{% if symmetric %}   `include "uvma_{{ name }}_phy_drv_vseq.sv"
{% else %}   `include "uvma_{{ name }}_{{ tx }}_drv_vseq.sv"
   `include "uvma_{{ name }}_{{ rx }}_drv_vseq.sv"
{% endif %}   `include "uvma_{{ name }}_idle_vseq.sv"

endpackage : uvma_{{ name }}_pkg


// Module(s) / Checker(s)
`ifdef UVMA_{{ upper(name) }}_INC_CHKR
`include "uvma_{{ name }}_if_chkr.sv"
`endif


`endif // __UVMA_{{ upper(name) }}_PKG_SV__
