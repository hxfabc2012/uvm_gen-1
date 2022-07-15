// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name.upper() }}_ST_VSQR_SV__
`define __UVME_{{ name.upper() }}_ST_VSQR_SV__


/**
 * Component on which all {{ full_name }} Self-Test virtual sequences are run.
 */
class uvme_{{ name }}_st_vsqr_c extends uvml_vsqr_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   /// @defgroup Objects
   /// @{
   uvme_{{ name }}_st_cfg_c    cfg  ; ///<
   uvme_{{ name }}_st_cntxt_c  cntxt; ///<
   /// @}

   /// @defgroup Sequencer handles
   /// @{
   uvma_{{ name }}_vsqr_c  {{ mode_1 }}_vsequencer; ///<
   uvma_{{ name }}_vsqr_c  {{ mode_2 }}_vsequencer; ///<
   uvma_{{ name }}_vsqr_c  passive_vsequencer; ///<
   /// @}


   `uvm_component_utils_begin(uvme_{{ name }}_st_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_sqr", uvm_component parent=null);

   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt.
    */
   extern function void get_cntxt();

endclass : uvme_{{ name }}_st_vsqr_c


function uvme_{{ name }}_st_vsqr_c::new(string name="uvme_{{ name }}_st_sqr", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_{{ name }}_st_vsqr_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg();
   get_cntxt();

endfunction : build_phase


function void uvme_{{ name }}_st_vsqr_c::get_cfg();

   void'(uvm_config_db#(uvme_{{ name }}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ name.upper() }}_ST_VSQR", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvme_{{ name }}_st_vsqr_c::get_cntxt();

   void'(uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ name.upper() }}_ST_VSQR", "Context handle is null")
   end

endfunction : get_cntxt


`endif // __UVME_{{ name.upper() }}_ST_VSQR_SV__
