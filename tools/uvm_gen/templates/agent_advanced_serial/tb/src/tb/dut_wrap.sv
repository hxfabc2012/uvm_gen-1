// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__
`define __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__


/**
 * Module wrapper for connecting {{ full_name }} Self-Test Bench interfaces.
 * All ports are SV interfaces.
 */
module uvmt_{{ name }}_st_dut_wrap(
   uvma_{{ name }}_if  {{ mode_1 }}_if,
   uvma_{{ name }}_if  {{ mode_2 }}_if,
   uvma_{{ name }}_if  passive_if
   );

{% if symmetric %}   reg rxp;
   reg rxn;
{% else %}   reg rx0p;
   reg rx0n;
   reg rx1p;
   reg rx1n;
{% endif %}   reg txp;
   reg txn;

{% if symmetric %}   assign {{ mode_1 }}_if.rxp = rxp;
   assign {{ mode_1 }}_if.rxn = rxn;
   assign passive_if.rxp = rxp;
   assign passive_if.rxn = rxn;
{% else %}   assign {{ mode_1 }}_if.rx0p = rx0p;
   assign {{ mode_1 }}_if.rx0n = rx0n;
   assign {{ mode_1 }}_if.rx1p = rx1p;
   assign {{ mode_1 }}_if.rx1n = rx1n;
   assign passive_if.rx0p = rx0p;
   assign passive_if.rx0n = rx0n;
   assign passive_if.rx1p = rx1p;
   assign passive_if.rx1n = rx1n;
{% endif %}
   assign {{ mode_2 }}_if.txp = txp;
   assign {{ mode_2 }}_if.txn = txn;
   assign passive_if.txp = txp;
   assign passive_if.txn = txn;

{% if ddr %}   always @({{ mode_1 }}_if.tx_clk) begin
{% else %}   always @(posedge {{ mode_1 }}_if.tx_clk) begin
{% endif %}      txp = {{ mode_1 }}_if.txp;
      txn = {{ mode_1 }}_if.txn;
   end

{% if ddr %}   always @({{ mode_2 }}_if.rx_clk) begin
{% else %}   always @(posedge {{ mode_1 }}_if.rx_clk) begin
{% endif %}{% if symmetric %}   rx0p = {{ mode_2 }}_if.rxp;
      rxp = {{ mode_2 }}_if.rxp;
{% else %}      rx0p = {{ mode_2 }}_if.rx0p;
      rx0p = {{ mode_2 }}_if.rx0p;
      rx0n = {{ mode_2 }}_if.rx0n;
      rx1p = {{ mode_2 }}_if.rx1p;
      rx1n = {{ mode_2 }}_if.rx1n;
{% endif %}
   end

endmodule : uvmt_{{ name }}_st_dut_wrap


`endif // __UVMT_{{ upper(name) }}_ST_DUT_WRAP_SV__
