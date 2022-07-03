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
   logic  rxd24p;
   logic  rxd24n;
   logic  rxd09p;
   logic  rxd09n;
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_{{ rx }}_mon_trn_c)
      `uvm_field_int(rxd24p, UVM_DEFAULT)
      `uvm_field_int(rxd24n, UVM_DEFAULT)
      `uvm_field_int(rxd09p, UVM_DEFAULT)
      `uvm_field_int(rxd09n, UVM_DEFAULT)
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
   
   string rxd24_str = $sformatf("%h", rxd24p);
   string rxd09_str = $sformatf("%h", rxd09p);
   
   get_metadata.push_back('{
      index     : 0,
      value     : rxd24_str,
      col_name  : "rxd24",
      col_width : rxd24_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   
   get_metadata.push_back('{
      index     : 0,
      value     : rxd09_str,
      col_name  : "rxd09",
      col_width : rxd09_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   
endfunction : get_metadata


`endif // __UVMA_{{ upper(name) }}_{{ upper(rx) }}_MON_TRN_SV__
