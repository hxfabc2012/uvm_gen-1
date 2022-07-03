// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SEQ_ITEM_SV__
`define __UVMA_{{ upper(name) }}_SEQ_ITEM_SV__


/**
 * Object created by {{ full_name }} agent sequences extending uvma_{{ name }}_seq_base_c.
 */
class uvma_{{ name }}_seq_item_c extends uvml_seq_item_c;
   
   uvma_{{ name }}_cfg_c  cfg;
   
   // Data
   rand bit                   q0     ; ///< 
   rand uvma_{{ name }}_data_b_t  q_data ; ///< 
   rand uvma_{{ name }}_sync_b_t  q_sync ; ///< 
   rand bit                   {{ tx }}_ctrl; ///< 
   rand uvma_{{ name }}_data_b_t  i_data ; ///< 
   rand uvma_{{ name }}_sync_b_t  i_sync ; ///< 
   
   // Metadata
   rand uvma_{{ name }}_direction_enum  direction;
   bit                              is_idle  ;
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_seq_item_c)
      `uvm_field_enum(uvma_{{ name }}_direction_enum, direction, UVM_DEFAULT + UVM_NOPACK)
      `uvm_field_int (                            is_idle  , UVM_DEFAULT + UVM_NOPACK)
      `uvm_field_int (                            q0       , UVM_DEFAULT)
      `uvm_field_int (                            q_data   , UVM_DEFAULT)
      `uvm_field_int (                            q_sync   , UVM_DEFAULT)
      `uvm_field_int (                            {{ tx }}_ctrl  , UVM_DEFAULT)
      `uvm_field_int (                            i_data   , UVM_DEFAULT)
      `uvm_field_int (                            i_sync   , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint limits_cons {
      q_sync == 2'b01;
      i_sync == 2'b10;
      if (direction == UVMA_{{ upper(name) }}_DIRECTION_{{ upper(rx) }}) {
         q0      == 0;
         {{ tx }}_ctrl == 0;
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
   
   string q0_str      = $sformatf("%b", q0     );
   string q_data_str  = $sformatf("%b", q_data );
   string q_sync_str  = $sformatf("%b", q_sync );
   string {{ tx }}_ctrl_str = $sformatf("%b", {{ tx }}_ctrl);
   string i_data_str  = $sformatf("%b", i_data );
   string i_sync_str  = $sformatf("%b", i_sync );
   
   if (!is_idle) begin
      get_metadata.push_back('{
         index     : 0,
         value     : i_sync_str,
         col_name  : "i sync",
         col_width : i_sync_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_INT
      });
      
      get_metadata.push_back('{
         index     : 0,
         value     : i_data_str,
         col_name  : "i data",
         col_width : i_data_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_INT
      });
      
      get_metadata.push_back('{
         index     : 0,
         value     : {{ tx }}_ctrl_str,
         col_name  : "tx ctrl",
         col_width : {{ tx }}_ctrl_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_INT
      });
      
      get_metadata.push_back('{
         index     : 0,
         value     : q_sync_str,
         col_name  : "q sync",
         col_width : q_sync_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_INT
      });
      
      get_metadata.push_back('{
         index     : 0,
         value     : q_data_str,
         col_name  : "q data",
         col_width : q_data_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_INT
      });
      
      get_metadata.push_back('{
         index     : 0,
         value     : q0_str,
         col_name  : "q0",
         col_width : q0_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_INT
      });
   end
   
endfunction : get_metadata


`endif // __UVMA_{{ upper(name) }}_SEQ_ITEM_SV__
