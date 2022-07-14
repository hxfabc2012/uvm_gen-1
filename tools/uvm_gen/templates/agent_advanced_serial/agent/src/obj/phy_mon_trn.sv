// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_PHY_MON_TRN_SV__
`define __UVMA_{{ upper(name) }}_PHY_MON_TRN_SV__


/**
 * Object rebuilt by the {{ full_name }} monitor.  Analog of uvma_{{ name }}_phy_seq_item_c.
 */
class uvma_{{ name }}_phy_mon_trn_c extends uvml_mon_trn_c;

   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle

   /// @defgroup Data
   /// @{
   logic  dp; ///<
   logic  dn; ///<
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_phy_mon_trn_c)
      `uvm_field_int(dp, UVM_DEFAULT)
      `uvm_field_int(dn, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_phy_mon_trn");

   /**
    * TODO Describe uvma_{{ name }}_phy_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();

endclass : uvma_{{ name }}_phy_mon_trn_c


function uvma_{{ name }}_phy_mon_trn_c::new(string name="uvma_{{ name }}_phy_mon_trn");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_phy_mon_trn_c::get_metadata();

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


`endif // __UVMA_{{ upper(name) }}_PHY_MON_TRN_SV__
