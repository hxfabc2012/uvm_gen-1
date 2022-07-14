// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_{{ upper(tx) }}_SQR_SV__
`define __UVMA_{{ upper(name) }}_{{ upper(tx) }}_SQR_SV__


/**
 * Component running {{ full_name }} sequences extending uvma_{{ name }}_vseq_base_c.
 */
class uvma_{{ name }}_{{ tx }}_sqr_c extends uvml_sqr_c #(
   .REQ(uvma_{{ name }}_{{ tx }}_seq_item_c),
   .RSP(uvma_{{ name }}_{{ tx }}_seq_item_c)
);

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   /// @}


   `uvm_component_utils_begin(uvma_{{ name }}_{{ tx }}_sqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ tx }}_sqr", uvm_component parent=null);

   /**
    * Ensures cfg & cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg and hand out to sub-components.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt and hand out to sub-components.
    */
   extern function void get_cntxt();

endclass : uvma_{{ name }}_{{ tx }}_sqr_c


function uvma_{{ name }}_{{ tx }}_sqr_c::new(string name="uvma_{{ name }}_{{ tx }}_sqr", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_{{ tx }}_sqr_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg  ();
   get_cntxt();

endfunction : build_phase


function void uvma_{{ name }}_{{ tx }}_sqr_c::get_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_{{ upper(tx) }}_SQR", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_{{ name }}_{{ tx }}_sqr_c::get_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ upper(name) }}_{{ upper(tx) }}_SQR", "Context handle is null")
   end

endfunction : get_cntxt


`endif // __UVMA_{{ upper(name) }}_{{ upper(tx) }}_SQR_SV__
