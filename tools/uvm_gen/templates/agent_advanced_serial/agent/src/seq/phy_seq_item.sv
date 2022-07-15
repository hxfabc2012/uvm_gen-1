// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_PHY_SEQ_ITEM_SV__
`define __UVMA_{{ name.upper() }}_PHY_SEQ_ITEM_SV__


/**
 * Object created by {{ full_name }} agent sequences extending uvma_{{ name }}_seq_base_c.
 */
class uvma_{{ name }}_phy_seq_item_c extends uvml_seq_item_c;

   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle

   /// @defgroup Data
   /// @{
   rand bit  dp; ///<
   rand bit  dn; ///<
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_phy_seq_item_c)
      `uvm_field_int(dp, UVM_DEFAULT)
      `uvm_field_int(dn, UVM_DEFAULT)
   `uvm_object_utils_end


   constraint limits_cons {
      dp != dn;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_phy_seq_item");

   /**
    * TODO Describe uvma_{{ name }}_phy_seq_item_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_{{ name }}_phy_seq_item_c


function uvma_{{ name }}_phy_seq_item_c::new(string name="uvma_{{ name }}_phy_seq_item");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_phy_seq_item_c::get_metadata();

   string dp_str = $sformatf("%b", dp);
   string dn_str = $sformatf("%b", dn);

   get_metadata.push_back('{
      index     : 0,
      value     : dp_str,
      col_name  : "dp",
      col_width : dp_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });
   get_metadata.push_back('{
      index     : 0,
      value     : dn_str,
      col_name  : "dn",
      col_width : dn_str.len(),
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   });

endfunction : get_metadata


`endif // __UVMA_{{ name.upper() }}_PHY_SEQ_ITEM_SV__
