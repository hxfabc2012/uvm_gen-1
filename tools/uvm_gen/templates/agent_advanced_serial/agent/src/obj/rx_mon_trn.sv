// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_{{ upper(rx) }}_MON_TRN_SV__
`define __UVMA_{{ upper(name) }}_{{ upper(rx) }}_MON_TRN_SV__


/**
 * Object rebuilt by the {{ full_name }} monitor.  Analog of uvma_{{ name }}_{{ rx }}_seq_item_c.
 */
class uvma_{{ name }}_{{ rx }}_mon_trn_c extends uvml_mon_trn_c;

   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle

   // Data
   logic  rx0p; ///<
   logic  rx0n; ///<
   logic  rx1p; ///<
   logic  rx1n; ///<


   `uvm_object_utils_begin(uvma_{{ name }}_{{ rx }}_mon_trn_c)
      `uvm_field_int(rx0p, UVM_DEFAULT)
      `uvm_field_int(rx0n, UVM_DEFAULT)
      `uvm_field_int(rx1p, UVM_DEFAULT)
      `uvm_field_int(rx1n, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ rx }}_mon_trn");

   /**
    * TODO Describe uvma_{{ name }}_{{ rx }}_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_{{ name }}_{{ rx }}_mon_trn_c


function uvma_{{ name }}_{{ rx }}_mon_trn_c::new(string name="uvma_{{ name }}_{{ rx }}_mon_trn");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_{{ rx }}_mon_trn_c::get_metadata();

   string rx0p_str = $sformatf("%h", rx0p);
   string rx0n_str = $sformatf("%h", rx0n);
   string rx1p_str = $sformatf("%h", rx1p);
   string rx1n_str = $sformatf("%h", rx1n);

   get_metadata.push_back('{
      index     : 0,
      value     : rx0p_str,
      col_name  : "rx0p",
      col_width : rx0p_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : rx0n_str,
      col_name  : "rx0n",
      col_width : rx0n_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : rx1p_str,
      col_name  : "rx1p",
      col_width : rx1p_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : rx1n_str,
      col_name  : "rx1n",
      col_width : rx1n_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_{{ upper(name) }}_{{ upper(rx) }}_MON_TRN_SV__
