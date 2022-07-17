// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_{{ tx.upper() }}_SEQ_ITEM_SV__
`define __UVMA_{{ name.upper() }}_{{ tx.upper() }}_SEQ_ITEM_SV__


/**
 * Sequence Item created by {{ full_name }} sequences for driving uvma_{{ name }}_{{ tx }}_drv_c.
 */
class uvma_{{ name }}_{{ tx }}_seq_item_c extends uvml_seq_item_c;

   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle

   /// @defgroup Data
   /// @{
   rand bit  {{ tx }}p; ///< Positive {{ tx.upper() }} differential signal
   rand bit  {{ tx }}n; ///< Negative {{ tx.upper() }} differential signal
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_{{ tx }}_seq_item_c)
      `uvm_field_int({{ tx }}p, UVM_DEFAULT)
      `uvm_field_int({{ tx }}n, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Implements differential encoding.
    */
   constraint limits_cons {
      {{ tx }}p != {{ tx }}n;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ tx }}_seq_item");

   /**
    * Describes transaction as metadata for uvml_logs_metadata_logger_c.
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_{{ name }}_{{ tx }}_seq_item_c


function uvma_{{ name }}_{{ tx }}_seq_item_c::new(string name="uvma_{{ name }}_{{ tx }}_seq_item");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_{{ tx }}_seq_item_c::get_metadata();

   string {{ tx }}p_str = $sformatf("%b", {{ tx }}p);
   string {{ tx }}n_str = $sformatf("%b", {{ tx }}n);

   get_metadata.push_back('{
      index     : 0,
      value     : {{ tx }}p_str,
      col_name  : "{{ tx }}p",
      col_width : {{ tx }}p_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : {{ tx }}n_str,
      col_name  : "{{ tx }}n",
      col_width : {{ tx }}n_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_{{ name.upper() }}_{{ tx.upper() }}_SEQ_ITEM_SV__
