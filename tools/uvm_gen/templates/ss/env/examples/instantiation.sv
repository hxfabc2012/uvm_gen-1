// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/**
 * This file contains sample code that demonstrates how to add an instance of the ${name_normal_case} UVM Environment
 * to another UVM environment.
 * NOTE It is recommended to split up class member declaration and definition.  These classes are all inline to keep the
 * example short.
 */


/**
 * Object encapsulating all configuration information for my_env.
 */
class my_env_cfg_c extends uvm_object;
   
   rand uvme_${name}_cfg_c  ${name}_cfg;
   
   `uvm_object_utils_begin(my_env_cfg_c)
      `uvm_field_object(${name}_cfg, UVM_DEFAULT)
   `uvm_object_utils_end
   
   constraint defaults_cons {
      soft ${name}_cfg.enabled == 1;
   }
   
   function new(uvm_component parent=null, string name="my_env");
      super.new(parent, name);
      cfg = uvme_${name}_cfg_c::type_id::create("${name}_cfg");
   endfunction : new
   
endclass : my_env_cfg_c


/**
 * Component encapsulating the environment.
 */
class my_env_c extends uvm_env;
   
   rand my_env_cfg_c  cfg;
   uvme_${name}_env_c  ${name}_env;
   
   `uvm_component_utils_begin(my_env_c)
      `uvm_field_object(cfg, UVM_DEFAULT)
   `uvm_component_utils_end
   
   function new(uvm_component parent=null, string name="my_env");
      super.new(parent, name);
   endfunction : new
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!cfg) begin
         `uvm_fatal("MY_ENV", "cfg is null")
      end
      else begin
         uvm_config_db#(uvme_${name}_cfg_c)::set(this, "${name}_env", "cfg", cfg.${name}_cfg);
         ${name}_env = uvme_${name}_env_c::type_id::create("${name}_env", this);
      end
   endfunction : build_phase
   
endclass : my_env_c
