// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_MON_TRN_SV__
`define __UVMA_{{ name.upper() }}_MON_TRN_SV__


/**
 * Monitor Transaction rebuilt by the Monitor Virtual Sequence (uvma_{{ name }}_mon_vseq_c).
 * Analog of uvma_{{ name }}_seq_item_c.
 */
class uvma_{{ name }}_mon_trn_c extends uvml_mon_trn_c;

   /// @defgroup Metadata
   /// @{
   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle
   uvma_{{ name }}_direction_enum  direction; ///< Data path from which this transaction was sampled.
   /// @}

   /// @defgroup Data
   /// @{
   uvma_{{ name }}_header_enum  header; ///< Sync bits indicating IDLE or DATA contents.
   uvma_{{ name }}_data_l_t     data ; ///< 'Payload' data.
   uvma_{{ name }}_tail_l_t     tail ; ///< Bits indicating the end to the 'payload' data.
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_mon_trn_c)
      `uvm_field_enum(uvma_{{ name }}_direction_enum, direction, UVM_DEFAULT + UVM_NOCOMPARE + UVM_NOPACK)
      `uvm_field_enum(uvma_{{ name }}_header_enum, header, UVM_DEFAULT)
      `uvm_field_int(data, UVM_DEFAULT          )
      `uvm_field_int(tail, UVM_DEFAULT + UVM_BIN)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon_trn");

   /**
    * Describes transaction as metadata for uvml_logs_metadata_logger_c.
    */
   extern function uvml_metadata_t get_metadata();

   /**
    * Performs self-consistency checks on data.
    * Returns '1' if all is OK.  '0' otherwise.
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
         self_check = 0;
      end
   end
   if (tail !== uvma_{{ name }}_tail_symbol) begin
      `uvm_error("{{ name.upper() }}_MON_TRN", $sformatf("Invalid tail symbol: %b", tail))
      self_check = 0;
   end

endfunction : self_check


`endif // __UVMA_{{ name.upper() }}_MON_TRN_SV__
