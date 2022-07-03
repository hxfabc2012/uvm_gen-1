// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_MON_TRN_SV__
`define __UVMA_{{ upper(name) }}_MON_TRN_SV__


/**
 * Object rebuilt from the {{ full_name }} monitor.  Analog of uvma_{{ name }}_seq_item_c.
 */
class uvma_{{ name }}_mon_trn_c extends uvml_mon_trn_c;
   
   uvma_{{ name }}_cfg_c  cfg;
   
   // Data
   logic                 q0     ; ///< 
   uvma_{{ name }}_data_l_t  q_data ; ///< 
   uvma_{{ name }}_sync_l_t  q_sync ; ///< 
   logic                 {{ tx }}_ctrl; ///< 
   uvma_{{ name }}_data_l_t  i_data ; ///< 
   uvma_{{ name }}_sync_l_t  i_sync ; ///< 
   
   // Metadata
   uvma_{{ name }}_direction_enum  direction; ///< 
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_mon_trn_c)
      `uvm_field_enum(uvma_{{ name }}_direction_enum, direction, UVM_DEFAULT + UVM_NOPACK)
      `uvm_field_int (                            q0       , UVM_DEFAULT)
      `uvm_field_int (                            q_data   , UVM_DEFAULT)
      `uvm_field_int (                            q_sync   , UVM_DEFAULT)
      `uvm_field_int (                            {{ tx }}_ctrl  , UVM_DEFAULT)
      `uvm_field_int (                            i_data   , UVM_DEFAULT)
      `uvm_field_int (                            i_sync   , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon_trn");
   
   
   /**
    * Returns '1' if q_data, q0, {{ tx }}_ctrl and i_data are all 0s.
    */
   extern function bit is_idle();
   
   /**
    * TODO Describe uvma_{{ name }}_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
endclass : uvma_{{ name }}_mon_trn_c


function uvma_{{ name }}_mon_trn_c::new(string name="uvma_{{ name }}_mon_trn");
   
   super.new(name);
   
endfunction : new


function bit uvma_{{ name }}_mon_trn_c::is_idle();
   
   is_idle = 1;
   
   is_idle &= (q0      === 0);
   is_idle &= (q_data  === 0);
   is_idle &= ({{ tx }}_ctrl === 0);
   is_idle &= (i_data  === 0);
   
endfunction : is_idle


function uvml_metadata_t uvma_{{ name }}_mon_trn_c::get_metadata();
   
   string q0_str      = $sformatf("%b", q0     );
   string q_data_str  = $sformatf("%b", q_data );
   string q_sync_str  = $sformatf("%b", q_sync );
   string {{ tx }}_ctrl_str = $sformatf("%b", {{ tx }}_ctrl);
   string i_data_str  = $sformatf("%b", i_data );
   string i_sync_str  = $sformatf("%b", i_sync );
   
   if (!is_idle()) begin
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


`endif // __UVMA_{{ upper(name) }}_MON_TRN_SV__
