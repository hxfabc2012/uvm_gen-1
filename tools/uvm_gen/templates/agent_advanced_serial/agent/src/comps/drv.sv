// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_DRV_SV__
`define __UVMA_{{ upper(name) }}_DRV_SV__


/**
 * Component driving a {{ full_name }} virtual interface (uvma_{{ name }}_if).
 */
class uvma_{{ name }}_drv_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   // @}

   /// @defgroup Components
   /// @{
{% if symmetric %}   uvma_{{ name }}_phy_drv_c  {{ tx }}_driver; ///< TODO Describe uvma_{{ name }}_drv_c::{{ tx }}_driver
   uvma_{{ name }}_phy_drv_c  {{ rx }}_driver; ///< TODO Describe uvma_{{ name }}_drv_c::{{ rx }}_driver
{% else %}   uvma_{{ name }}_{{ tx }}_drv_c  {{ tx }}_driver; ///< TODO Describe uvma_{{ name }}_drv_c::{{ tx }}_driver
   uvma_{{ name }}_{{ rx }}_drv_c  {{ rx }}_driver; ///< TODO Describe uvma_{{ name }}_drv_c::{{ rx }}_driver
{% endif %}   /// @}

   /// @defgroup TLM
   /// @{
{% if symmetric %}   uvm_analysis_port#(uvma_{{ name }}_phy_seq_item_c)  {{ tx }}_ap; ///< TODO Describe uvma_{{ name }}_drv_c:: {{ tx }}_ap
   uvm_analysis_port#(uvma_{{ name }}_phy_seq_item_c)  {{ rx }}_ap; ///< TODO Describe uvma_{{ name }}_drv_c:: {{ rx }}_ap
{% else %}   uvm_analysis_port#(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_ap; ///< TODO Describe uvma_{{ name }}_drv_c:: {{ tx }}_ap
   uvm_analysis_port#(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_ap; ///< TODO Describe uvma_{{ name }}_drv_c:: {{ rx }}_ap
{% endif %}   /// @}

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

   /**
    * Uses uvm_config_db to retrieve cfg and hand out to sub-components.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt and hand out to sub-components.
    */
   extern function void get_cntxt();

   /**
    *
    */
   extern function void create_components();

   /**
    *
    */
   extern function void create_ports();

   /**
    *
    */
   extern function void connect_ports();

endclass : uvma_{{ name }}_drv_c


function uvma_{{ name }}_drv_c::new(string name="uvma_{{ name }}_drv", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_drv_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   get_cfg          ();
   get_cntxt        ();
   create_components();
   create_ports     ();

endfunction : build_phase


function void uvma_{{ name }}_drv_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   connect_ports();

endfunction : connect_phase


function void uvma_{{ name }}_drv_c::get_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_DRV", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_{{ name }}_drv_c::get_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ upper(name) }}_DRV", "Context handle is null")
   end

endfunction : get_cntxt


function void uvma_{{ name }}_drv_c::create_components();

{% if symmetric %}   {{ tx }}_driver = uvma_{{ name }}_phy_drv_c::type_id::create("{{ tx }}_driver", this);
   {{ rx }}_driver = uvma_{{ name }}_phy_drv_c::type_id::create("{{ rx }}_driver", this);
{% else %}   {{ tx }}_driver = uvma_{{ name }}_{{ tx }}_drv_c::type_id::create("{{ tx }}_driver", this);
   {{ rx }}_driver = uvma_{{ name }}_{{ rx }}_drv_c::type_id::create("{{ rx }}_driver", this);
{% endif %}
endfunction : create_components


function void uvma_{{ name }}_drv_c::create_ports();

   {{ tx }}_ap = new("{{ tx }}_ap", this);
   {{ rx }}_ap = new("{{ rx }}_ap", this);

endfunction : create_ports


function void uvma_{{ name }}_drv_c::connect_ports();

   {{ tx }}_ap = {{ tx }}_driver.ap;
   {{ rx }}_ap = {{ rx }}_driver.ap;

endfunction : connect_ports


`endif // __UVMA_{{ upper(name) }}_DRV_SV__
