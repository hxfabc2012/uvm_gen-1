// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_CFG_SV__
`define __UVMA_{{ name.upper() }}_CFG_SV__


// Default sequences
typedef class uvma_{{ name }}_mon_vseq_c   ;
typedef class uvma_{{ name }}_idle_vseq_c  ;
{% if symmetric %}typedef class uvma_{{ name }}_phy_drv_vseq_c;
{% else %}typedef class uvma_{{ name }}_{{ tx }}_drv_vseq_c;
typedef class uvma_{{ name }}_{{ rx }}_drv_vseq_c;
{% endif %}

/**
 * Object encapsulating all parameters for creating, connecting and running all {{ full_name }} agent
 * (uvma_{{ name }}_agent_c) components.
 */
class uvma_{{ name }}_cfg_c extends uvm_object;

   /// @defgroup Generic options
   /// @{
   rand bit                      enabled          ; ///< Sub-components are not created if '0'.
   rand bit                      bypass_mode      ; ///< Does not drive interface when '1' (only TLM).
   rand uvm_active_passive_enum  is_active        ; ///< Driver is not created if 'UVM_PASSIVE'.
   rand uvml_reset_type_enum     reset_type       ; ///< Sets whether the monitor is sensitive to a/synchronous reset.
   rand bit                      cov_model_enabled; ///< Gates the creation of the functional coverage model.
   rand bit                      trn_log_enabled  ; ///< Gates the creation of the transaction logger.
   /// @}

   /// @defgroup Protocol Options
   /// @{
   rand uvma_{{ name }}_mode_enum  drv_mode; ///< Specifies which data stream to drive when in active mode.
   /// @}

   /// @defgroup Objects
   /// @{
   uvm_object_wrapper  mon_vseq_type   ; ///< Type for Monitor Virtual Sequence to be started by agent at start of run_phase().
   uvm_object_wrapper  idle_vseq_type  ; ///< Type for Idle Virtual Sequence to be started by agent at start of run_phase().
   uvm_object_wrapper  {{ tx }}_drv_vseq_type; ///< Type for {{ tx.upper() }} Driver Virtual Sequence to be started by agent at start of run_phase().
   uvm_object_wrapper  {{ rx }}_drv_vseq_type; ///< Type for {{ rx.upper() }} Driver Virtual Sequence to be started by agent at start of run_phase().
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_int (                         bypass_mode      , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvml_reset_type_enum   , reset_type       , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)
      `uvm_field_enum(uvma_{{ name }}_mode_enum, drv_mode, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Sets usual values for generic options.
    */
   constraint defaults_cons {
      soft enabled           == 1;
      soft bypass_mode       == 0;
      soft is_active         == UVM_PASSIVE;
      soft reset_type        == UVML_RESET_TYPE_SYNCHRONOUS;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;
   }


   /**
    * Creates objects.
    */
   extern function new(string name="uvma_{{ name }}_cfg");

endclass : uvma_{{ name }}_cfg_c


function uvma_{{ name }}_cfg_c::new(string name="uvma_{{ name }}_cfg");

   super.new(name);
   mon_vseq_type    = uvma_{{ name }}_mon_vseq_c   ::get_type();
   idle_vseq_type   = uvma_{{ name }}_idle_vseq_c  ::get_type();
{% if symmetric %}   {{ tx }}_drv_vseq_type = uvma_{{ name }}_phy_drv_vseq_c::get_type();
   {{ rx }}_drv_vseq_type = uvma_{{ name }}_phy_drv_vseq_c::get_type();
{% else %}   {{ tx }}_drv_vseq_type = uvma_{{ name }}_{{ tx }}_drv_vseq_c::get_type();
   {{ rx }}_drv_vseq_type = uvma_{{ name }}_{{ rx }}_drv_vseq_c::get_type();
{% endif %}
endfunction : new


`endif // __UVMA_{{ name.upper() }}_CFG_SV__
