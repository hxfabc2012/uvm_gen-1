// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ name.upper() }}_ST_DUT_CHKR_SV__
`define __UVMT_{{ name.upper() }}_ST_DUT_CHKR_SV__


/**
 * Module encapsulating assertions for {{ full_name }} Self-Test DUT wrapper (uvmt_{{ name }}_st_dut_wrap).
 */
module uvmt_{{ name }}_st_dut_chkr (
   uvma_{{ name }}_if  {{ mode_1 }}_if,
   uvma_{{ name }}_if  {{ mode_2 }}_if,
   uvma_{{ name }}_if  passive_if
);

   // TODO Add assertions to uvmt_{{ name }}_st_dut_chkr

endmodule : uvmt_{{ name }}_st_dut_chkr


`endif // __UVMT_{{ name.upper() }}_ST_DUT_CHKR_SV__
