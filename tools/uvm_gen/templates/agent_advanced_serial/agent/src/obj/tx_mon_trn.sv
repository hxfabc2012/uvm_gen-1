// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_{{ upper(tx) }}_MON_TRN_SV__
`define __UVMA_{{ upper(name) }}_{{ upper(tx) }}_MON_TRN_SV__


/**
 * Object rebuilt by the {{ full_name }} monitor's A Channel Master.  Analog of uvma_{{ name }}_{{ mode_1 }}_seq_item_c.
 */
class uvma_{{ name }}_{{ tx }}_mon_trn_c extends uvml_mon_trn_c;
   
   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle
   
   // Data
   logic  txdp; ///< TODO Describe uvma_{{ name }}_{{ tx }}_mon_trn_c::txd
   logic  txdn; ///< TODO Describe uvma_{{ name }}_{{ tx }}_mon_trn_c::txd
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_{{ tx }}_mon_trn_c)
      `uvm_field_int(txdp, UVM_DEFAULT)
      `uvm_field_int(txdn, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ tx }}_mon_trn");
   
   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
endclass : uvma_{{ name }}_{{ tx }}_mon_trn_c


function uvma_{{ name }}_{{ tx }}_mon_trn_c::new(string name="uvma_{{ name }}_{{ tx }}_mon_trn");
   
   super.new(name);
   
endfunction : new


function uvml_metadata_t uvma_{{ name }}_{{ tx }}_mon_trn_c::get_metadata();
   
   string txd_str = $sformatf("%h", txdp);
   
   get_metadata.push_back('{
      index     : 0,
      value     : txd_str,
      col_name  : "txd",
      col_width : txd_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   
endfunction : get_metadata


`endif // __UVMA_{{ upper(name) }}_{{ upper(tx) }}_MON_TRN_SV__
