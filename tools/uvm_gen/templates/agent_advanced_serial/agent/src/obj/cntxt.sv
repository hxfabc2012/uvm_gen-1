// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_CNTXT_SV__
`define __UVMA_{{ upper(name) }}_CNTXT_SV__


/**
 * Object encapsulating all state variables for all {{ full_name }} agent (uvma_{{ name }}_agent_c) components.
 */
class uvma_{{ name }}_cntxt_c extends uvm_object;
   
   virtual uvma_{{ name }}_if  vif        ; ///< Handle to agent interface
   uvml_reset_state_enum   reset_state; ///< TODO Describe uvma_{{ name }}_cntxt_c::reset_state
   
   uvm_sequence_base  mon_vseq   ; ///< 
   uvm_sequence_base  idle_vseq  ; ///< 
   uvm_sequence_base  {{ tx }}_drv_vseq; ///< 
   uvm_sequence_base  {{ rx }}_drv_vseq; ///< 
   
   uvma_{{ name }}_mon_fsm_cntxt_c  mon_fsm_{{ tx }}_cntxt;
   uvma_{{ name }}_mon_fsm_cntxt_c  mon_fsm_{{ rx }}_cntxt;
   
   // Events
   uvm_event  sample_cfg_e  ; ///< 
   uvm_event  sample_cntxt_e; ///< 
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_cntxt_c)
      `uvm_field_enum(uvml_reset_state_enum, reset_state, UVM_DEFAULT)
      
      `uvm_field_object(mon_fsm_{{ tx }}_cntxt, UVM_DEFAULT)
      `uvm_field_object(mon_fsm_{{ rx }}_cntxt, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events.
    */
   extern function new(string name="uvma_{{ name }}_cntxt");
   
   /**
    * TODO Describe uvma_{{ name }}_cntxt_c::reset()
    */
   extern function void reset();
   
endclass : uvma_{{ name }}_cntxt_c


function uvma_{{ name }}_cntxt_c::new(string name="uvma_{{ name }}_cntxt");
   
   super.new(name);
   reset_state    = UVML_RESET_STATE_PRE_RESET;
   mon_fsm_{{ tx }}_cntxt = uvma_{{ name }}_mon_fsm_cntxt_c::type_id::create("mon_fsm_{{ tx }}_cntxt");
   mon_fsm_{{ rx }}_cntxt = uvma_{{ name }}_mon_fsm_cntxt_c::type_id::create("mon_fsm_{{ rx }}_cntxt");
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


function void uvma_{{ name }}_cntxt_c::reset();
   
   mon_fsm_{{ tx }}_cntxt.reset();
   mon_fsm_{{ rx }}_cntxt.reset();
   
endfunction : reset


`endif // __UVMA_{{ upper(name) }}_CNTXT_SV__
