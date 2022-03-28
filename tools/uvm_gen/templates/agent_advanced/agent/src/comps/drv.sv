// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMA_${name_uppercase}_DRV_SV__
`define __UVMA_${name_uppercase}_DRV_SV__


/**
 * Component driving a Open Bus Interface virtual interface (uvma_${name}_if).
 */
class uvma_${name}_drv_c extends uvm_component;
   
   // Objects
   uvma_${name}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_${name}_cntxt_c  cntxt; ///< Agent context handle
   
   // Components
   uvma_${name}_mstr_a_drv_c  mstr_a_driver; ///< TODO Describe uvma_${name}_drv_c::mstr_a_driver
   uvma_${name}_mstr_r_drv_c  mstr_r_driver; ///< TODO Describe uvma_${name}_drv_c::mstr_r_driver
   uvma_${name}_slv_a_drv_c   slv_a_driver ; ///< TODO Describe uvma_${name}_drv_c::slv_a_driver
   uvma_${name}_slv_r_drv_c   slv_r_driver ; ///< TODO Describe uvma_${name}_drv_c::slv_r_driver
   
   // TLM
   uvm_analysis_port#(uvma_${name}_mstr_r_seq_item_c)  mstr_r_ap; ///< TODO Describe uvma_${name}_drv_c:: mstr_r_ap
   uvm_analysis_port#(uvma_${name}_mstr_a_seq_item_c)  mstr_a_ap; ///< TODO Describe uvma_${name}_drv_c:: mstr_a_ap
   uvm_analysis_port#(uvma_${name}_slv_r_seq_item_c )  slv_r_ap ; ///< TODO Describe uvma_${name}_drv_c:: slv_r_ap
   uvm_analysis_port#(uvma_${name}_slv_a_seq_item_c )  slv_a_ap ; ///< TODO Describe uvma_${name}_drv_c:: slv_a_ap
   
   
   `uvm_component_utils_begin(uvma_${name}_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_drv", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_drv_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_${name}_drv_c


function uvma_${name}_drv_c::new(string name="uvma_${name}_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_drv_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   uvm_config_db#(uvma_${name}_cfg_c)::set(this, "*", "cfg", cfg);
   
   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   uvm_config_db#(uvma_${name}_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
   // Create components
   mstr_a_driver = uvma_${name}_mstr_a_drv_c::type_id::create("mstr_a_driver", this);
   mstr_r_driver = uvma_${name}_mstr_r_drv_c::type_id::create("mstr_r_driver", this);
   slv_a_driver  = uvma_${name}_slv_a_drv_c ::type_id::create("slv_a_driver" , this);
   slv_r_driver  = uvma_${name}_slv_r_drv_c ::type_id::create("slv_r_driver" , this);
   
   // Create TLM Components
   mstr_a_ap = new("mstr_a_ap", this);
   mstr_r_ap = new("mstr_r_ap", this);
   slv_a_ap  = new("slv_a_ap" , this);
   slv_r_ap  = new("slv_r_ap" , this);
   
endfunction : build_phase


function void uvma_${name}_drv_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   mstr_r_ap = mstr_a_driver.ap;
   mstr_a_ap = mstr_r_driver.ap;
   slv_r_ap  = slv_a_driver .ap;
   slv_a_ap  = slv_r_driver .ap;
   
endfunction : connect_phase


`endif // __UVMA_${name_uppercase}_DRV_SV__
