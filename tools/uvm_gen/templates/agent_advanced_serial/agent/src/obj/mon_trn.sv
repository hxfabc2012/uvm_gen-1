// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_MON_TRN_SV__
`define __UVMA_{{ name.upper() }}_MON_TRN_SV__


/**
 * Object rebuilt from the {{ full_name }} monitor.  Analog of uvma_{{ name }}_seq_item_c.
 */
class uvma_{{ name }}_mon_trn_c extends uvml_mon_trn_c;

   /// @defgroup Metadata
   /// @{
   uvma_{{ name }}_cfg_c  cfg;
   uvma_{{ name }}_direction_enum  direction; ///<
   /// @}

   /// @defgroup Data
   /// @{
   uvma_{{ name }}_header_enum  header; ///<
   uvma_{{ name }}_data_l_t     data ; ///<
   uvma_{{ name }}_tail_l_t     tail ; ///<
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_mon_trn_c)
      `uvm_field_enum(uvma_{{ name }}_direction_enum, direction, UVM_DEFAULT)
      `uvm_field_enum(uvma_{{ name }}_header_enum, header, UVM_DEFAULT)
      `uvm_field_int(data , UVM_DEFAULT          )
      `uvm_field_int(tail , UVM_DEFAULT + UVM_BIN)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon_trn");

   /**
    * TODO Describe uvma_{{ name }}_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();

   /**
    * TODO Describe uvma_{{ name }}_mon_trn_c::self_check()
    */
   extern function bit self_check();

endclass : uvma_{{ name }}_mon_trn_c


function uvma_{{ name }}_mon_trn_c::new(string name="uvma_{{ name }}_mon_trn");

   super.new(name);

endfunction : new


function uvml_metadata_t uvma_{{ name }}_mon_trn_c::get_metadata();

   string header_str = header.name();
   string tail_str = $sformatf("%b", tail);
   string data_str = $sformatf("%h", data);

   if (header == UVMA_{{ name.upper() }}_HEADER_DATA) begin
      header_str = "DATA";
   end
   else if (header == UVMA_{{ name.upper() }}_HEADER_IDLE) begin
      header_str = "IDLE";
   end
   else begin
      header_str = $sformatf("? %b", header);
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


function bit uvma_{{ name }}_mon_trn_c::self_check();

   self_check = 1;
   case (header)
      UVMA_{{ name.upper() }}_HEADER_DATA: ;
      UVMA_{{ name.upper() }}_HEADER_IDLE: ;
      default: begin
         `uvm_error("{{ name.upper() }}_MON_TRN", $sformatf("Invalid header: %b", header))
         self_check = 0;
      end
   endcase
   if (header == UVMA_{{ name.upper() }}_HEADER_IDLE) begin
      if (data !== uvma_{{ name }}_idle_data) begin
         `uvm_error("{{ name.upper() }}_MON_TRN", $sformatf("Invalid IDLE data: %b", data))
         sself_check = 0;
      end
   end
   if (tail !== uvma_{{ name }}_tail_symbol) begin
      `uvm_error("{{ name.upper() }}_MON_TRN", $sformatf("Invalid tail symbol: %b", data))
      self_check = 0;
   end

endfunction : self_check


`endif // __UVMA_{{ name.upper() }}_MON_TRN_SV__
