// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_IF_SV__
`define __UVMA_{{ name.upper() }}_IF_SV__


/**
 * Encapsulates all signals and clocking of the {{ full_name }}.
 */
interface uvma_{{ name }}_if (
   input  {{ tx }}_clk , ///< All {{ tx.upper() }} signal timings are related to the rising edge of this signal.
   input  {{ rx }}_clk , ///< All {{ rx.upper() }} signal timings are related to the rising edge of this signal.
   input  reset_n  ///< Active LOW reset signal.
);

   /// @defgroup Signals
   /// @{
{% if symmetric %}   wire  {{ tx }}p; ///< Positive {{ tx.upper() }} differential signal
   wire  {{ tx }}n; ///< Negative {{ tx.upper() }} differential signal
   wire  {{ rx }}p; ///< Positive {{ rx.upper() }} differential signal
   wire  {{ rx }}n; ///< Negative {{ rx.upper() }} differential signal
{% else %}   wire  {{ tx }}p; ///< Positive {{ tx.upper() }} differential signal
   wire  {{ tx }}n; ///< Negative {{ tx.upper() }} differential signal
   wire  {{ rx }}0p; ///< Positive {{ rx.upper() }} differential signal 0
   wire  {{ rx }}0n; ///< Negative {{ rx.upper() }} differential signal 0
   wire  {{ rx }}1p; ///< Positive {{ rx.upper() }} differential signal 1
   wire  {{ rx }}1n; ///< Negative {{ rx.upper() }} differential signal 1
{% endif %}   /// @}


   /**
    * Used by {{ mode_1.upper() }} DUT {{ tx.upper() }}.
    */
   {% if ddr %}clocking dut_{{ mode_1 }}_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking dut_{{ mode_1 }}_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      output  {{ tx }}p,
              {{ tx }}n;
   endclocking : dut_{{ mode_1 }}_{{ tx }}_cb

   /**
    * Used by {{ mode_1.upper() }} DUT {{ rx.upper() }}.
    */
   {% if ddr %}clocking dut_{{ mode_1 }}_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking dut_{{ mode_1 }}_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      input  {{ rx }}p,
             {{ rx }}n;
{% else %}      input  {{ rx }}0p,
             {{ rx }}0n,
             {{ rx }}1p,
             {{ rx }}1n;{% endif %}
   endclocking : dut_{{ mode_1 }}_{{ rx }}_cb

   /**
    * Used by {{ mode_2.upper() }} DUT {{ tx.upper() }}.
    */
   {% if ddr %}clocking dut_{{ mode_2 }}_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking dut_{{ mode_2 }}_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      input  {{ tx }}p,
             {{ tx }}n;
   endclocking : dut_{{ mode_2 }}_{{ tx }}_cb

   /**
    * Used by {{ mode_2.upper() }} DUT {{ rx.upper() }}.
    */
   {% if ddr %}clocking dut_{{ mode_2 }}_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking dut_{{ mode_2 }}_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      output  {{ rx }}p,
              {{ rx }}n;
{% else %}      output  {{ rx }}0p,
              {{ rx }}0n,
              {{ rx }}1p,
              {{ rx }}1n;{% endif %}
   endclocking : dut_{{ mode_2 }}_{{ rx }}_cb

   /**
    * Used by uvma_{{ name }}_drv_{{ tx }}_c.
    */
   {% if ddr %}clocking drv_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking drv_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      output  {{ tx }}p,
              {{ tx }}n;
   endclocking : drv_{{ tx }}_cb

   /**
    * Used by uvma_{{ name }}_drv_{{ rx }}_c.
    */
   {% if ddr %}clocking drv_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking drv_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      output {{ rx }}p,
             {{ rx }}n;
{% else %}      output {{ rx }}0p,
             {{ rx }}0n,
             {{ rx }}1p,
             {{ rx }}1n;{% endif %}
   endclocking : drv_{{ rx }}_cb

   /**
    * Used by uvma_{{ name }}_mon_c {{ tx.upper() }}.
    */
   {% if ddr %}clocking mon_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking mon_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      input  {{ tx }}p,
             {{ tx }}n;
   endclocking : mon_{{ tx }}_cb

   /**
    * Used by uvma_{{ name }}_mon_c {{ rx.upper() }}.
    */
   {% if ddr %}clocking mon_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking mon_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      input  {{ rx }}p,
             {{ rx }}n;
{% else %}      input  {{ rx }}0p,
             {{ rx }}0n,
             {{ rx }}1p,
             {{ rx }}1n;{% endif %}
   endclocking : mon_{{ rx }}_cb


   /**
    * Used by {{ mode_1.upper() }} DUT {{ tx.upper() }}.
    */
   modport dut_{{ mode_1 }}_{{ tx }}_mp (
      clocking dut_{{ mode_1 }}_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_1.upper() }} DUT {{ rx.upper() }}.
    */
   modport dut_{{ mode_1 }}_{{ rx }}_mp (
      clocking dut_{{ mode_1 }}_{{ rx }}_cb,{% if ddr %}
      input    {{ rx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_2.upper() }} DUT {{ tx.upper() }}.
    */
   modport dut_{{ mode_2 }}_{{ tx }}_mp (
      clocking dut_{{ mode_2 }}_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_2.upper() }} DUT {{ rx.upper() }}.
    */
   modport dut_{{ mode_2 }}_{{ rx }}_mp (
      clocking dut_{{ mode_2 }}_{{ rx }}_cb,{% if ddr %}
      input    {{ rx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_drv_{{ tx }}_c.
    */
   modport drv_{{ tx }}_mp (
      clocking drv_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_drv_{{ rx }}_c.
    */
   modport drv_{{ rx }}_mp (
      clocking drv_{{ rx }}_cb,{% if ddr %}
      input    {{ rx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c {{ tx.upper() }}.
    */
   modport mon_{{ tx }}_mp (
      clocking mon_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c {{ rx.upper() }}.
    */
   modport mon_{{ rx }}_mp (
      clocking mon_{{ rx }}_cb,{% if ddr %}
      input    {{ rx }}_clk ,{% endif %}
      input    reset_n
   );

endinterface : uvma_{{ name }}_if


`endif // __UVMA_{{ name.upper() }}_IF_SV__
