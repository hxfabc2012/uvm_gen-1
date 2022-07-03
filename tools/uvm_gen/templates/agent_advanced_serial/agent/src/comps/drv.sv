// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_DRV_SV__
`define __UVMA_{{ upper(name) }}_DRV_SV__


/**
 * Component driving a {{ full_name }} virtual interface (uvma_{{ name }}_if).
 */
class uvma_{{ name }}_drv_c extends uvm_component;
   
   // Objects
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   
   // Components
   uvma_{{ name }}_{{ tx }}_drv_c  {{ tx }}_driver; ///< TODO Describe uvma_{{ name }}_drv_c::{{ tx }}_driver
   uvma_{{ name }}_{{ rx }}_drv_c  {{ rx }}_driver; ///< TODO Describe uvma_{{ name }}_drv_c::{{ rx }}_driver
   
   // TLM
   uvm_analysis_port#(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_ap; ///< TODO Describe uvma_{{ name }}_drv_c:: {{ tx }}_ap
   uvm_analysis_port#(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_ap; ///< TODO Describe uvma_{{ name }}_drv_c:: {{ rx }}_ap
   
   
   `uvm_component_utils_begin(uvma_{{ name }}_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_drv", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_{{ name }}_drv_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_{{ name }}_drv_c


function uvma_{{ name }}_drv_c::new(string name="uvma_{{ name }}_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_{{ name }}_drv_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   uvm_config_db#(uvma_{{ name }}_cfg_c)::set(this, "*", "cfg", cfg);
   
   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   uvm_config_db#(uvma_{{ name }}_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
   // Create components
   {{ tx }}_driver = uvma_{{ name }}_{{ tx }}_drv_c::type_id::create("{{ tx }}_driver", this);
   {{ rx }}_driver = uvma_{{ name }}_{{ rx }}_drv_c::type_id::create("{{ rx }}_driver", this);
   
   // Create TLM Components
   {{ tx }}_ap = new("{{ tx }}_ap", this);
   {{ rx }}_ap = new("{{ rx }}_ap", this);
   
endfunction : build_phase


function void uvma_{{ name }}_drv_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   {{ tx }}_ap = {{ tx }}_driver.ap;
   {{ rx }}_ap = {{ rx }}_driver.ap;
   
endfunction : connect_phase


`endif // __UVMA_{{ upper(name) }}_DRV_SV__
