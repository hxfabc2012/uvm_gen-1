// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SEQ_ITEM_SV__
`define __UVMA_{{ upper(name) }}_SEQ_ITEM_SV__


/**
 * Object created by {{ full_name }} agent sequences extending uvma_{{ name }}_seq_base_c.
 */
class uvma_{{ name }}_seq_item_c extends uvml_seq_item_c;

   /// @defgroup Metadata
   /// @{
   uvma_{{ name }}_cfg_c  cfg;
   /// @}

   /// @defgroup Data
   /// @{
   rand uvma_{{ name }}_header_enum  header; ///<
   rand uvma_{{ name }}_data_b_t     data  ; ///<
   rand uvma_{{ name }}_tail_b_t     tail  ; ///<
   /// @}



   `uvm_object_utils_begin(uvma_{{ name }}_seq_item_c)
      `uvm_field_enum(uvma_{{ name }}_header_enum, header, UVM_DEFAULT)
      `uvm_field_int(data , UVM_DEFAULT          )
      `uvm_field_int(tail , UVM_DEFAULT + UVM_BIN)
   `uvm_object_utils_end


   constraint limits_cons {
      soft tail == uvma_{{ name }}_tail_symbol;
      if (header == UVMA_{{ upper(name) }}_HEADER_IDLE) {
         data == uvma_{{ name }}_idle_data;
      }
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_seq_item");

   /**
    * TODO Describe uvma_{{ name }}_seq_item_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_{{ name }}_seq_item_c


function uvma_{{ name }}_seq_item_c::new(string name="uvma_{{ name }}_seq_item");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_seq_item_c::get_metadata();

   string header_str = header.name();
   string tail_str = $sformatf("%b", tail);
   string data_str = $sformatf("%h", data);

   if (header == UVMA_{{ upper(name) }}_HEADER_DATA) begin
      header_str = "DATA";
   end
   else if (header == UVMA_{{ upper(name) }}_HEADER_IDLE) begin
      header_str = "IDLE";
   end
   else begin
      header_str = $sformatf("??(%b)", header);
   end
   get_metadata.push_back('{
      index     : 0,
      value     : header_str,
      col_name  : "header",
      col_width : header_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : tail_str,
      col_name  : "tail",
      col_width : tail_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : data_str,
      col_name  : "data",
      col_width : data_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_{{ upper(name) }}_SEQ_ITEM_SV__
