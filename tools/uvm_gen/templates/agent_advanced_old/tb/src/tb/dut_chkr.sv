// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ name_uppercase }}_ST_DUT_CHKR_SV__
`define __UVMT_{{ name_uppercase }}_ST_DUT_CHKR_SV__


/**
 * Module encapsulating assertions for the {{ name_proper }} UVM Agent Self-Test DUT wrapper (uvmt_{{ name }}_st_dut_wrap).
 */
module uvmt_{{ name }}_st_dut_chkr (
   uvma_{{ name }}_if  {{ mode_1 }}_if , ///< Active agent interface
   uvma_{{ name }}_if  {{ mode_2 }}_if ///< Passive agent interface
);

   // TODO Add assertions to uvmt_{{ name }}_st_dut_chkr

endmodule : uvmt_{{ name }}_st_dut_chkr


`endif // __UVMT_{{ name_uppercase }}_ST_DUT_CHKR_SV__
