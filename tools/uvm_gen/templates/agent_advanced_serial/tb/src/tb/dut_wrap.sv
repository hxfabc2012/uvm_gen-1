// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ name.upper() }}_ST_DUT_WRAP_SV__
`define __UVMT_{{ name.upper() }}_ST_DUT_WRAP_SV__


/**
 * "DUT" wrapper connecting {{ full_name }} Agent Self-Test Bench interfaces.
 * All ports are SV interfaces.
 */
module uvmt_{{ name }}_st_dut_wrap(
   uvma_{{ name }}_if  {{ mode_1 }}_if,
   uvma_{{ name }}_if  {{ mode_2 }}_if,
   uvma_{{ name }}_if  passive_if
);

   /// @defgroup {{ tx.upper() }}
   /// @{
   reg {{ tx }}p;
   reg {{ tx }}n;

   assign {{ mode_2 }}_if.{{ tx }}p = {{ tx }}p;
   assign {{ mode_2 }}_if.{{ tx }}n = {{ tx }}n;
   assign passive_if.{{ tx }}p = {{ tx }}p;
   assign passive_if.{{ tx }}n = {{ tx }}n;

{% if ddr %}   always @({{ mode_1 }}_if.{{ tx }}_clk) begin
{% else %}   always @(posedge {{ mode_1 }}_if.{{ tx }}_clk) begin
{% endif %}      {{ tx }}p <= {{ mode_1 }}_if.{{ tx }}p;
      {{ tx }}n <= {{ mode_1 }}_if.{{ tx }}n;
   end
   /// @}


   /// @defgroup {{ rx.upper() }}
   /// @{
{% if symmetric %}   reg {{ rx }}p;
   reg {{ rx }}n;
{% else %}   reg {{ rx }}0p;
   reg {{ rx }}0n;
   reg {{ rx }}1p;
   reg {{ rx }}1n;
{% endif %}
{% if symmetric %}   assign {{ mode_1 }}_if.{{ rx }}p = {{ rx }}p;
   assign {{ mode_1 }}_if.{{ rx }}n = {{ rx }}n;
   assign passive_if.{{ rx }}p = {{ rx }}p;
   assign passive_if.{{ rx }}n = {{ rx }}n;
{% else %}   assign {{ mode_1 }}_if.{{ rx }}0p = {{ rx }}0p;
   assign {{ mode_1 }}_if.{{ rx }}0n = {{ rx }}0n;
   assign {{ mode_1 }}_if.{{ rx }}1p = {{ rx }}1p;
   assign {{ mode_1 }}_if.{{ rx }}1n = {{ rx }}1n;
   assign passive_if.{{ rx }}0p = {{ rx }}0p;
   assign passive_if.{{ rx }}0n = {{ rx }}0n;
   assign passive_if.{{ rx }}1p = {{ rx }}1p;
   assign passive_if.{{ rx }}1n = {{ rx }}1n;
{% endif %}
{% if ddr %}   always @({{ mode_2 }}_if.{{ rx }}_clk) begin
{% else %}   always @(posedge {{ mode_1 }}_if.{{ rx }}_clk) begin
{% endif %}{% if symmetric %}      {{ rx }}p <= {{ mode_2 }}_if.{{ rx }}p;
      {{ rx }}n <= {{ mode_2 }}_if.{{ rx }}n;
{% else %}      {{ rx }}0p <= {{ mode_2 }}_if.{{ rx }}0p;
      {{ rx }}0n <= {{ mode_2 }}_if.{{ rx }}0n;
      {{ rx }}1p <= {{ mode_2 }}_if.{{ rx }}1p;
      {{ rx }}1n <= {{ mode_2 }}_if.{{ rx }}1n;
{% endif %}   end
   /// @}

endmodule : uvmt_{{ name }}_st_dut_wrap


`endif // __UVMT_{{ name.upper() }}_ST_DUT_WRAP_SV__
