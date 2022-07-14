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
   rand uvma_{{ name }}_sync_b_t  start; ///<
   rand uvma_{{ name }}_data_b_t  data ; ///<
   rand uvma_{{ name }}_sync_b_t  stop ; ///<
   /// @}



   `uvm_object_utils_begin(uvma_{{ name }}_seq_item_c)
      `uvm_field_int(start, UVM_DEFAULT + UVM_BIN)
      `uvm_field_int(data , UVM_DEFAULT          )
      `uvm_field_int(stop , UVM_DEFAULT + UVM_BIN)
   `uvm_object_utils_end


   constraint limits_cons {
      soft start == uvma_{{ name }}_start_symbol;
      soft stop  == uvma_{{ name }}_stop_symbol ;
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

   string start_str = $sformatf("%b", start);
   string stop_str  = $sformatf("%b", stop );
   string data_str  = $sformatf("%h", data );

   if (!is_idle) begin
      get_metadata.push_back('{
         index     : 0,
         value     : start_str,
         col_name  : "start",
         col_width : start_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_INT
      });
      get_metadata.push_back('{
         index     : 0,
         value     : stop_str,
         col_name  : "stop",
         col_width : stop_str.len(),
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
   end

endfunction : get_metadata


`endif // __UVMA_{{ upper(name) }}_SEQ_ITEM_SV__
