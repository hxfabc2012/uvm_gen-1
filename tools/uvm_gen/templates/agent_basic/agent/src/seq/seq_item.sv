// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_SEQ_ITEM_SV__
`define __UVMA_${name_uppercase}_SEQ_ITEM_SV__


/**
 * Object created by ${name_normal_case} agent sequences running on uvma_${name}_sqr_c and used by uvma_${name}_drv_c.
 */
class uvma_${name}_seq_item_c extends uvml_seq_item_c;

   /// @defgroup Data
   /// @{
   // TODO Add uvma_${name}_seq_item_c fields
   //      Ex: rand bit [7:0]  abc; ///< Describe abc here
   /// @}

   /// @defgroup Metadata
   /// @{
   uvma_${name}_cfg_c  cfg; ///< Agent configuration handle
   /// @}


   `uvm_object_utils_begin(uvma_${name}_seq_item_c)
      // TODO Add uvma_${name}_seq_item_c UVM field utils
      //      Ex: `uvm_field_int(abc, UVM_DEFAULT)
   `uvm_object_utils_end


   // TODO Add uvma_${name}_seq_item_c constraints
   //      Ex: /**
   //           * Describe constraint here
   //           */
   //          constraint default_cons {
   //             abc inside {0,2,4,8,16,32};
   //          }


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_seq_item");

   /**
    * Describes transaction as metadata for uvml_logs_metadata_logger_c.
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_${name}_seq_item_c


function uvma_${name}_seq_item_c::new(string name="uvma_${name}_seq_item");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_${name}_seq_item_c::get_metadata();

   // TODO Create metadata for transaction logger
   //      Ex: string  abc_str = $sformatf("%h", abc);
   //          get_metadata.push_back('{
   //             index     : 0,
   //             value     : abc_str
   //             col_name  : "abc",
   //             col_width : abc_str.len(),
   //             col_align : UVML_TEXT_ALIGN_RIGHT,
   //             data_type : UVML_FIELD_INT
   //          });

endfunction : get_metadata


`endif // __UVMA_${name_uppercase}_SEQ_ITEM_SV__
