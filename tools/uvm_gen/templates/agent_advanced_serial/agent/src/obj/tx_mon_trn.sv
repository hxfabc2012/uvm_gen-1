// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_{{ tx.upper() }}_MON_TRN_SV__
`define __UVMA_{{ name.upper() }}_{{ tx.upper() }}_MON_TRN_SV__


/**
 * Object rebuilt by the {{ full_name }} monitor's A Channel Master.  Analog of uvma_{{ name }}_{{ mode_1 }}_seq_item_c.
 */
class uvma_{{ name }}_{{ tx }}_mon_trn_c extends uvml_mon_trn_c;

   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle

   /// @defgroup Data
   /// @{
   logic  {{ tx }}p; ///< TODO Describe uvma_{{ name }}_{{ tx }}_mon_trn_c::{{ tx }}p
   logic  {{ tx }}n; ///< TODO Describe uvma_{{ name }}_{{ tx }}_mon_trn_c::{{ tx }}n
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_{{ tx }}_mon_trn_c)
      `uvm_field_int({{ tx }}p, UVM_DEFAULT)
      `uvm_field_int({{ tx }}n, UVM_DEFAULT)
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

   string {{ tx }}p_str = $sformatf("%h", {{ tx }}p);
   string {{ tx }}n_str = $sformatf("%h", {{ tx }}n);

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


`endif // __UVMA_{{ name.upper() }}_{{ tx.upper() }}_MON_TRN_SV__
