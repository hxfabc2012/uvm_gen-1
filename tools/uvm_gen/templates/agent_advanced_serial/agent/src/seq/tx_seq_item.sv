// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_{{ upper(tx) }}_SEQ_ITEM_SV__
`define __UVMA_{{ upper(name) }}_{{ upper(tx) }}_SEQ_ITEM_SV__


/**
 * Object created by {{ full_name }} agent sequences extending uvma_{{ name }}_seq_base_c.
 */
class uvma_{{ name }}_{{ tx }}_seq_item_c extends uvml_seq_item_c;

   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle

   /// @defgroup Data
   /// @{
   rand bit  txp; ///<
   rand bit  txn; ///<
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_{{ tx }}_seq_item_c)
      `uvm_field_int(txp, UVM_DEFAULT)
      `uvm_field_int(txn, UVM_DEFAULT)
   `uvm_object_utils_end


   constraint limits_cons {
      txp != txn;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ tx }}_seq_item");

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_seq_item_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_{{ name }}_{{ tx }}_seq_item_c


function uvma_{{ name }}_{{ tx }}_seq_item_c::new(string name="uvma_{{ name }}_{{ tx }}_seq_item");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_{{ tx }}_seq_item_c::get_metadata();

   string txp_str = $sformatf("%b", txp);
   string txn_str = $sformatf("%b", txn);

   get_metadata.push_back('{
      index     : 0,
      value     : txp_str,
      col_name  : "txp",
      col_width : txp_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : txn_str,
      col_name  : "txn",
      col_width : txn_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_{{ upper(name) }}_{{ upper(tx) }}_SEQ_ITEM_SV__
