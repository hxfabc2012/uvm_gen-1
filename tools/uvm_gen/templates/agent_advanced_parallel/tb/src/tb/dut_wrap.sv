// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__
`define __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__


/**
 * Module wrapper for {{ full_name }} RTL DUT. All ports are SV interfaces.
 */
module uvmt_{{ name }}_st_dut_wrap(
   uvma_{{ name }}_if  mstr_if,
   uvma_{{ name }}_if  slv_if
);
   // 'A Channel' signals
   assign slv_if .req     = mstr_if.req    ;
   assign mstr_if.gnt     = slv_if .gnt    ;
   assign slv_if .addr    = mstr_if.addr   ;
   assign slv_if .we      = mstr_if.we     ;
   assign slv_if .be      = mstr_if.be     ;
   assign slv_if .wdata   = mstr_if.wdata  ;
   assign slv_if .auser   = mstr_if.auser  ;
   assign slv_if .wuser   = mstr_if.wuser  ;
   assign slv_if .aid     = mstr_if.aid    ;
   assign slv_if .atop    = mstr_if.atop   ;
   assign slv_if .memtype = mstr_if.memtype;
   assign slv_if .prot    = mstr_if.prot   ;
   assign slv_if .reqpar  = mstr_if.reqpar ;
   assign mstr_if.gntpar  = slv_if .gntpar ;
   assign slv_if .achk    = mstr_if.achk   ;
   
   // 'R Channel' signals
   assign mstr_if.rvalid    = slv_if .rvalid   ;
   assign slv_if .rready    = mstr_if.rready   ;
   assign mstr_if.rdata     = slv_if .rdata    ;
   assign mstr_if.err       = slv_if .err      ;
   assign mstr_if.ruser     = slv_if .ruser    ;
   assign mstr_if.rid       = slv_if .rid      ;
   assign mstr_if.exokay    = slv_if .exokay   ;
   assign mstr_if.rvalidpar = slv_if .rvalidpar;
   assign slv_if .rreadypar = mstr_if.rreadypar;
   assign mstr_if.rchk      = slv_if .rchk     ;
   
endmodule : uvmt_{{ name }}_st_dut_wrap


`endif // __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__
