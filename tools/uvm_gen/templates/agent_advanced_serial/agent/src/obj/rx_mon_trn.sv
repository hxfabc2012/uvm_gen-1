// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_{{ rx.upper() }}_MON_TRN_SV__
`define __UVMA_{{ name.upper() }}_{{ rx.upper() }}_MON_TRN_SV__


/**
 * {{ rx.upper() }} Phy Monitor Transaction sampled by monitor (uvma_{{ name }}_mon_c).
 * Analog of uvma_{{ name }}_{{ rx }}_seq_item_c.
 */
class uvma_{{ name }}_{{ rx }}_mon_trn_c extends uvml_mon_trn_c;

   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle

   /// @defgroup Data
   /// @{
   logic  {{ rx }}0p; ///< Positive {{ rx.upper() }} differential signal 0
   logic  {{ rx }}0n; ///< Negative {{ rx.upper() }} differential signal 0
   logic  {{ rx }}1p; ///< Positive {{ rx.upper() }} differential signal 1
   logic  {{ rx }}1n; ///< Negative {{ rx.upper() }} differential signal 1
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_{{ rx }}_mon_trn_c)
      `uvm_field_int({{ rx }}0p, UVM_DEFAULT)
      `uvm_field_int({{ rx }}0n, UVM_DEFAULT)
      `uvm_field_int({{ rx }}1p, UVM_DEFAULT)
      `uvm_field_int({{ rx }}1n, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ rx }}_mon_trn");

   /**
    * Describes transaction as metadata for uvml_logs_metadata_logger_c.
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_{{ name }}_{{ rx }}_mon_trn_c


function uvma_{{ name }}_{{ rx }}_mon_trn_c::new(string name="uvma_{{ name }}_{{ rx }}_mon_trn");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_{{ rx }}_mon_trn_c::get_metadata();

   string {{ rx }}0p_str = $sformatf("%h", {{ rx }}0p);
   string {{ rx }}0n_str = $sformatf("%h", {{ rx }}0n);
   string {{ rx }}1p_str = $sformatf("%h", {{ rx }}1p);
   string {{ rx }}1n_str = $sformatf("%h", {{ rx }}1n);

   get_metadata.push_back('{
      index     : 0,
      value     : {{ rx }}0p_str,
      col_name  : "{{ rx }}0p",
      col_width : {{ rx }}0p_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : {{ rx }}0n_str,
      col_name  : "{{ rx }}0n",
      col_width : {{ rx }}0n_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : {{ rx }}1p_str,
      col_name  : "{{ rx }}1p",
      col_width : {{ rx }}1p_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : {{ rx }}1n_str,
      col_name  : "{{ rx }}1n",
      col_width : {{ rx }}1n_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_{{ name.upper() }}_{{ rx.upper() }}_MON_TRN_SV__
