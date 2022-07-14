// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_CFG_SV__
`define __UVMA_{{ upper(name) }}_CFG_SV__


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
   rand bit                      enabled          ; ///< TODO Describe uvma_{{ name }}_cfg_c::enabled
   rand bit                      bypass_mode      ; ///<
   rand uvm_active_passive_enum  is_active        ; ///< TODO Describe uvma_{{ name }}_cfg_c::is_active
   rand uvml_reset_type_enum     reset_type       ; ///< TODO Describe uvma_{{ name }}_cfg_c::reset_type
   rand uvm_sequencer_arb_mode   sqr_arb_mode     ; ///< TODO Describe uvma_{{ name }}_cfg_c::sqr_arb_mode
   rand bit                      cov_model_enabled; ///< TODO Describe uvma_{{ name }}_cfg_c::cov_model_enabled
   rand bit                      trn_log_enabled  ; ///< TODO Describe uvma_{{ name }}_cfg_c::trn_log_enabled
   /// @}

   /// @defgroup Protocol Options
   /// @{
   rand bit  big_endian; ///<
   rand uvma_{{ name }}_mode_enum  drv_mode; ///< TODO Describe uvma_{{ name }}_cfg_c::drv_mode
   /// @}

   /// @defgroup Sequence Types
   /// @{
   uvm_object_wrapper  mon_vseq_type   ; ///< TODO Describe uvma_{{ name }}_cfg_c::mon_vseq_type
   uvm_object_wrapper  idle_vseq_type  ; ///< TODO Describe uvma_{{ name }}_cfg_c::idle_vseq_type
   uvm_object_wrapper  {{ tx }}_drv_vseq_type; ///< TODO Describe uvma_{{ name }}_cfg_c::mstr_drv_vseq_type
   uvm_object_wrapper  {{ rx }}_drv_vseq_type; ///< TODO Describe uvma_{{ name }}_cfg_c::slv_drv_vseq_type
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_int (                         bypass_mode      , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvml_reset_type_enum   , reset_type       , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode     , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)

      `uvm_field_int (                           big_endian, UVM_DEFAULT)
      `uvm_field_enum(uvma_{{ name }}_mode_enum, drv_mode  , UVM_DEFAULT)
   `uvm_object_utils_end


   constraint defaults_cons {
      soft enabled           == 1;
      soft bypass_mode       == 0;
      soft is_active         == UVM_PASSIVE;
      soft reset_type        == UVML_RESET_TYPE_SYNCHRONOUS;
      soft sqr_arb_mode      == UVM_SEQ_ARB_FIFO;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;
   }


   /**
    * Default constructor.
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


`endif // __UVMA_{{ upper(name) }}_CFG_SV__
