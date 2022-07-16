// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_IF_SV__
`define __UVMA_{{ name.upper() }}_IF_SV__


/**
 * Encapsulates all signals and clocking of the {{ full_name }}.
 */
interface uvma_{{ name }}_if (
   input  {{ tx }}_clk , ///< The bus clock times all bus transfers. All signal timings are related to the rising edge of clk.
   input  {{ rx }}_clk , ///< The bus clock times all bus transfers. All signal timings are related to the rising edge of clk.
   input  reset_n  ///< The bus reset signal is active LOW and resets the system and the bus. This is the only active LOW signal.
);

   /// @defgroup Signals
   /// @{
{% if symmetric %}   wire  {{ tx }}p; ///<
   wire  {{ tx }}n; ///<
   wire  {{ rx }}p; ///<
   wire  {{ rx }}n; ///<
{% else %}   wire  {{ tx }}p; ///<
   wire  {{ tx }}n; ///<
   wire  {{ rx }}0p; ///<
   wire  {{ rx }}0n; ///<
   wire  {{ rx }}1p; ///<
   wire  {{ rx }}1n; ///<
{% endif %}   /// @}


   /**
    * Used by DUT {{ tx.upper() }}.
    */
   {% if ddr %}clocking dut_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking dut_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      output  {{ tx }}p,
              {{ tx }}n;
   endclocking : dut_{{ tx }}_cb

   /**
    * Used by DUT {{ rx.upper() }}.
    */
   {% if ddr %}clocking dut_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking dut_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      input  {{ rx }}p,
             {{ rx }}n;
{% else %}      input  {{ rx }}0p,
             {{ rx }}0n,
             {{ rx }}1p,
             {{ rx }}1n;
{% endif %}
   endclocking : dut_{{ rx }}_cb

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
      output  {{ tx }}p,
              {{ tx }}n;
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
             {{ rx }}1n;
{% endif %}
   endclocking : mon_{{ rx }}_cb


   /**
    * Used by  DUT {{ tx.upper() }}.
    */
   modport dut_{{ tx }}_mp (
      clocking dut_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by DUT {{ rx.upper() }}.
    */
   modport dut_{{ rx }}_mp (
      clocking dut_{{ rx }}_cb,{% if ddr %}
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
