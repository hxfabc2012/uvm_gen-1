// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_TX_MON_TRN_SV__
`define __UVMA_{{ upper(name) }}_TX_MON_TRN_SV__


/**
 * Object rebuilt by the {{ full_name }} monitor's A Channel Master.  Analog of uvma_{{ name }}_{{ mode_1 }}_seq_item_c.
 */
class uvma_{{ name }}_tx_mon_trn_c extends uvml_mon_trn_c;

   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle

   // Data
   logic  txp; ///< TODO Describe uvma_{{ name }}_tx_mon_trn_c::txd
   logic  txn; ///< TODO Describe uvma_{{ name }}_tx_mon_trn_c::txd


   `uvm_object_utils_begin(uvma_{{ name }}_tx_mon_trn_c)
      `uvm_field_int(txp, UVM_DEFAULT)
      `uvm_field_int(txn, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_tx_mon_trn");

   /**
    * TODO Describe uvma_{{ name }}_tx_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_{{ name }}_tx_mon_trn_c


function uvma_{{ name }}_tx_mon_trn_c::new(string name="uvma_{{ name }}_tx_mon_trn");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_tx_mon_trn_c::get_metadata();

   string txp_str = $sformatf("%h", txp);
   string txn_str = $sformatf("%h", txn);

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


`endif // __UVMA_{{ upper(name) }}_TX_MON_TRN_SV__
