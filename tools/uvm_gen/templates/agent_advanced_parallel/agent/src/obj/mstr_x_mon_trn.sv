// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_MSTR_A_MON_TRN_SV__
`define __UVMA_{{ upper(name) }}_MSTR_A_MON_TRN_SV__


/**
 * Object rebuilt by the {{ full_name }} monitor's A Channel Master.  Analog of uvma_{{ name }}_mstr_a_seq_item_c.
 */
class uvma_{{ name }}_mstr_a_mon_trn_c extends uvml_mon_trn_c;
   
   uvma_{{ name }}_cfg_c  cfg; ///< Agent configuration handle
   
   // Data
   uvma_{{ name }}_req_l_t      req    ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::req
   uvma_{{ name }}_addr_l_t     addr   ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::addr
   uvma_{{ name }}_we_l_t       we     ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::we
   uvma_{{ name }}_be_l_t       be     ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::be
   uvma_{{ name }}_data_l_t     wdata  ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::wdata
   uvma_{{ name }}_auser_l_t    auser  ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::auser
   uvma_{{ name }}_wuser_l_t    wuser  ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::wuser
   uvma_{{ name }}_id_l_t       aid    ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::aid
   uvma_{{ name }}_atop_l_t     atop   ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::atop
   uvma_{{ name }}_memtype_l_t  memtype; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::memtype
   uvma_{{ name }}_prot_l_t     prot   ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::prot
   uvma_{{ name }}_reqpar_l_t   reqpar ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::reqpar
   uvma_{{ name }}_achk_l_t     achk   ; ///< TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::achk
   
   // Metadata
   uvma_{{ name }}_gnt_l_t  gnt;
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_mstr_a_mon_trn_c)
      `uvm_field_int(req    , UVM_DEFAULT              )
      `uvm_field_int(addr   , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(we     , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(be     , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(wdata  , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(auser  , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(wuser  , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(aid    , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(atop   , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(memtype, UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(prot   , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(reqpar , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(achk   , UVM_DEFAULT + UVM_NOPRINT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mstr_a_mon_trn");
   
   /**
    * TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::do_print()
    */
   extern function void do_print(uvm_printer printer);
   
   /**
    * TODO Describe uvma_{{ name }}_mstr_a_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
endclass : uvma_{{ name }}_mstr_a_mon_trn_c


function uvma_{{ name }}_mstr_a_mon_trn_c::new(string name="uvma_{{ name }}_mstr_a_mon_trn");
   
   super.new(name);
   req     = 0;
   addr    = 0;
   we      = 0;
   be      = 0;
   wdata   = 0;
   auser   = 0;
   wuser   = 0;
   aid     = 0;
   atop    = 0;
   memtype = 0;
   prot    = 0;
   reqpar  = 0;
   achk    = 0;
   
endfunction : new


function void uvma_{{ name }}_mstr_a_mon_trn_c::do_print(uvm_printer printer);
   
   super.do_print(printer);
   
   if (cfg != null) begin
      printer.print_field("addr"  , addr , cfg.addr_width );
      printer.print_field("we"    , we   , $bits(we)      );
      printer.print_field("be"    , be   , cfg.data_width );
      printer.print_field("wdata" , wdata, cfg.data_width );
      
      if (cfg.auser_width > 0) begin
         printer.print_field("auser", auser, cfg.auser_width);
      end
      if (cfg.wuser_width > 0) begin
         printer.print_field("wuser", wuser, cfg.wuser_width);
      end
      if (cfg.id_width > 0) begin
         printer.print_field("aid", aid, cfg.id_width);
      end
      printer.print_field("atop"   , atop   , $bits(atop   ));
      printer.print_field("memtype", memtype, $bits(memtype));
      printer.print_field("prot"   , prot   , $bits(prot   ));
      printer.print_field("reqpar" , reqpar , $bits(reqpar ));
      
      if (cfg.achk_width > 0) begin
         printer.print_field("achk", achk, cfg.achk_width);
      end
   end
   
endfunction : do_print


function uvml_metadata_t uvma_{{ name }}_mstr_a_mon_trn_c::get_metadata();
   
   int unsigned  field_count = 0;
   string  addr_str    = $sformatf("%h", addr);
   string  we_str      = (we === 1'b1) ? "  W" : "R  ";
   string  be_str      = $sformatf("%b", be     );
   string  wdata_str   = $sformatf("%h", wdata  );
   string  auser_str   = $sformatf("%h", auser  );
   string  wuser_str   = $sformatf("%h", wuser  );
   string  aid_str     = $sformatf("%h", aid    );
   string  atop_str    = $sformatf("%h", atop   );
   string  memtype_str = $sformatf("%h", memtype);
   string  prot_str    = $sformatf("%h", prot   );
   string  reqpar_str  = $sformatf("%b", reqpar );
   string  achk_str    = $sformatf("%h", achk   );
   
   if (((req === 1'b1) && (gnt === 1'b1)) && (cfg != null)) begin
      addr_str = addr_str.substr(addr_str.len() - (cfg.addr_width/4), addr_str.len()-1);
      get_metadata.push_back('{
         index     : field_count,
         value     : addr_str,
         col_name  : "addr",
         col_width : addr_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_ENUM
      });
      field_count++;
      
      get_metadata.push_back('{
         index     : field_count,
         value     : we_str,
         col_name  : "r/w",
         col_width : we_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_ENUM
      });
      field_count++;
      
      be_str = be_str.substr(be_str.len() - (cfg.data_width/8), be_str.len()-1);
      get_metadata.push_back('{
         index     : field_count,
         value     : be_str,
         col_name  : "be",
         col_width : be_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_ENUM
      });
      field_count++;
      
      wdata_str = wdata_str.substr(wdata_str.len() - (cfg.data_width/4), wdata_str.len()-1);
      get_metadata.push_back('{
         index     : field_count,
         value     : wdata_str,
         col_name  : "wdata",
         col_width : wdata_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_ENUM
      });
      field_count++;
      
      if (cfg.auser_width > 0) begin
         auser_str = auser_str.substr(auser_str.len() - (cfg.auser_width/4), auser_str.len()-1);
         get_metadata.push_back('{
            index     : field_count,
            value     : auser_str,
            col_name  : "auser",
            col_width : auser_str.len(),
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_ENUM
         });
         field_count++;
      end
      
      if (cfg.wuser_width > 0) begin
         wuser_str = wuser_str.substr(wuser_str.len() - (cfg.wuser_width/4), wuser_str.len()-1);
         get_metadata.push_back('{
            index     : field_count,
            value     : wuser_str,
            col_name  : "wuser",
            col_width : wuser_str.len(),
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_ENUM
         });
         field_count++;
      end
      
      if (cfg.id_width > 0) begin
         aid_str = aid_str.substr(aid_str.len() - (cfg.id_width/4), aid_str.len()-1);
         get_metadata.push_back('{
            index     : field_count,
            value     : aid_str,
            col_name  : "aid",
            col_width : aid_str.len(),
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_ENUM
         });
         field_count++;
      end
      
      get_metadata.push_back('{
         index     : field_count,
         value     : atop_str,
         col_name  : "atop",
         col_width : atop_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_ENUM
      });
      field_count++;
      
      get_metadata.push_back('{
         index     : field_count,
         value     : memtype_str,
         col_name  : "memtype",
         col_width : memtype_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_ENUM
      });
      field_count++;
      
      get_metadata.push_back('{
         index     : field_count,
         value     : prot_str,
         col_name  : "prot",
         col_width : prot_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_ENUM
      });
      field_count++;
      
      get_metadata.push_back('{
         index     : field_count,
         value     : reqpar_str,
         col_name  : "reqpar",
         col_width : reqpar_str.len(),
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_ENUM
      });
      field_count++;
      
      if (cfg.achk_width > 0) begin
         achk_str = achk_str.substr(achk_str.len() - (cfg.achk_width/4), achk_str.len()-1);
         get_metadata.push_back('{
            index     : field_count,
            value     : achk_str,
            col_name  : "achk",
            col_width : achk_str.len(),
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_ENUM
         });
         field_count++;
      end
   end
   
endfunction : get_metadata


`endif // __UVMA_{{ upper(name) }}_MSTR_A_MON_TRN_SV__
