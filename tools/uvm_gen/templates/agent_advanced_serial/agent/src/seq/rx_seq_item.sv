// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_{{ upper(rx) }}_SEQ_ITEM_SV__
`define __UVMA_{{ upper(name) }}_{{ upper(rx) }}_SEQ_ITEM_SV__


/**
 * Object created by sequences running on uvma_{{ name }}_{{ rx }}_sqr_c.
 */
class uvma_{{ name }}_{{ rx }}_seq_item_c extends uvml_seq_item_c;
   
   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle
   
   // Data
   rand bit  rxd24p;
   rand bit  rxd24n;
   rand bit  rxd09p;
   rand bit  rxd09n;
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_{{ rx }}_seq_item_c)
      `uvm_field_int(rxd24p, UVM_DEFAULT)
      `uvm_field_int(rxd24n, UVM_DEFAULT)
      `uvm_field_int(rxd09p, UVM_DEFAULT)
      `uvm_field_int(rxd09n, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint default_cons {
      rxd24p != rxd24n;
      rxd09p != rxd09n;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ rx }}_seq_item");
   
   /**
    * TODO Describe uvma_{{ name }}_{{ rx }}_seq_item_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
endclass : uvma_{{ name }}_{{ rx }}_seq_item_c


function uvma_{{ name }}_{{ rx }}_seq_item_c::new(string name="uvma_{{ name }}_{{ rx }}_seq_item");
   
   super.new(name);
   
endfunction : new


function uvml_metadata_t uvma_{{ name }}_{{ rx }}_seq_item_c::get_metadata();
   
   string rxd24_str = $sformatf("%b", rxd24p);
   string rxd09_str = $sformatf("%b", rxd09p);
   
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


`endif // __UVMA_{{ upper(name) }}_{{ upper(rx) }}_SEQ_ITEM_SV__
