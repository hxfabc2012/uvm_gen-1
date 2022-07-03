// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__
`define __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__


/**
 * Module wrapper for {{ full_name }} RTL DUT.  All ports are SV interfaces.
 */
module uvmt_{{ name }}_st_dut_wrap(
   uvma_{{ name }}_if  {{ mode_1 }}_if,
   uvma_{{ name }}_if  {{ mode_2 }}_if
   );

   reg rxd24p;
   reg rxd24n;
   reg rxd09p;
   reg rxd09n;
   reg txdp;
   reg txdn;
   
   assign {{ mode_1 }}_if.rxd24p = rxd24p;
   assign {{ mode_1 }}_if.rxd24n = rxd24n;
   assign {{ mode_1 }}_if.rxd09p = rxd09p;
   assign {{ mode_1 }}_if.rxd09n = rxd09n;
   
   assign {{ mode_2 }}_if.txdp = txdp;
   assign {{ mode_2 }}_if.txdn = txdn;

   always @ ({{ mode_2 }}_if.clk)
   begin
      rxd24p = {{ mode_2 }}_if.rxd24p;
      rxd24p = {{ mode_2 }}_if.rxd24p;
      rxd24n = {{ mode_2 }}_if.rxd24n;
      rxd09p = {{ mode_2 }}_if.rxd09p;
      rxd09n = {{ mode_2 }}_if.rxd09n;
      
      txdp = {{ mode_1 }}_if.txdp;
      txdn = {{ mode_1 }}_if.txdn;
   end 
    
endmodule : uvmt_{{ name }}_st_dut_wrap


`endif // __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__
