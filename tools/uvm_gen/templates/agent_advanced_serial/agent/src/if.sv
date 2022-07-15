// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_SV__
`define __UVMA_{{ name.upper() }}_SV__


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
    * Used by {{ mode_1 }} DUT Tx.
    */
   {% if ddr %}clocking dut_{{ mode_1 }}_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking dut_{{ mode_1 }}_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      output  txp,
              txn;
   endclocking : dut_{{ mode_1 }}_{{ tx }}_cb

   /**
    * Used by {{ mode_1 }} DUT Rx.
    */
   {% if ddr %}clocking dut_{{ mode_1 }}_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking dut_{{ mode_1 }}_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      input  rxp,
             rxn;
{% else %}      input  rx0p,
             rx0n,
             rx1p,
             rx1n;
{% endif %}
   endclocking : dut_{{ mode_1 }}_{{ rx }}_cb

   /**
    * Used by {{ mode_2 }} DUT Tx.
    */
   {% if ddr %}clocking dut_{{ mode_2 }}_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking dut_{{ mode_2 }}_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      output  txp,
              txn;
   endclocking : dut_{{ mode_2 }}_{{ tx }}_cb

   /**
    * Used by {{ mode_2 }} DUT Rx.
    */
   {% if ddr %}clocking dut_{{ mode_2 }}_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking dut_{{ mode_2 }}_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      input  rxp,
             rxn;
{% else %}      input  rx0p,
             rx0n,
             rx1p,
             rx1n;
{% endif %}
   endclocking : dut_{{ mode_2 }}_{{ rx }}_cb

   /**
    * Used by uvma_{{ name }}_drv_{{ tx }}_c.
    */
   {% if ddr %}clocking drv_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking drv_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      output  txp,
              txn;
   endclocking : drv_{{ tx }}_cb

   /**
    * Used by uvma_{{ name }}_drv_{{ rx }}_c.
    */
   {% if ddr %}clocking drv_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking drv_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
      output  txp,
              txn;
   endclocking : drv_{{ rx }}_cb

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   {% if ddr %}clocking mon_{{ mode_1 }}_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking mon_{{ mode_1 }}_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      input  txp,
             txn;
   endclocking : mon_{{ mode_1 }}_{{ tx }}_cb

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   {% if ddr %}clocking mon_{{ mode_1 }}_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking mon_{{ mode_1 }}_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      input  rxp,
             rxn;
{% else %}      input  rx0p,
             rx0n,
             rx1p,
             rx1n;
{% endif %}
   endclocking : mon_{{ mode_1 }}_{{ rx }}_cb

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   {% if ddr %}clocking mon_{{ mode_2 }}_{{ tx }}_cb @({{ tx }}_clk);
   {% else %}clocking mon_{{ mode_2 }}_{{ tx }}_cb @(posedge {{ tx }}_clk);{% endif %}
      input  txp,
             txn;
   endclocking : mon_{{ mode_2 }}_{{ tx }}_cb

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   {% if ddr %}clocking mon_{{ mode_2 }}_{{ rx }}_cb @({{ rx }}_clk);
   {% else %}clocking mon_{{ mode_2 }}_{{ rx }}_cb @(posedge {{ rx }}_clk);{% endif %}
{% if symmetric %}      input  rxp,
             rxn;
{% else %}      input  rx0p,
             rx0n,
             rx1p,
             rx1n;
{% endif %}
   endclocking : mon_{{ mode_2 }}_{{ rx }}_cb


   /**
    * Used by {{ mode_1 }} DUT Tx.
    */
   modport dut_{{ mode_1 }}_mp (
      clocking dut_{{ mode_1 }}_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_1 }} DUT Rx.
    */
   modport dut_{{ mode_1 }}_mp (
      clocking dut_{{ mode_1 }}_{{ rx }}_cb,{% if ddr %}
      input    {{ rx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_2 }} DUT Tx.
    */
   modport dut_{{ mode_2 }}_mp (
      clocking dut_{{ mode_2 }}_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_2 }} DUT Rx.
    */
   modport dut_{{ mode_2 }}_mp (
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
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_{{ mode_1 }}_{{ tx }}_mp (
      clocking mon_{{ mode_1 }}_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_{{ mode_1 }}_{{ rx }}_mp (
      clocking mon_{{ mode_1 }}_{{ rx }}_cb,{% if ddr %}
      input    {{ rx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_{{ mode_2 }}_{{ tx }}_mp (
      clocking mon_{{ mode_2 }}_{{ tx }}_cb,{% if ddr %}
      input    {{ tx }}_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_{{ mode_2 }}_{{ rx }}_mp (
      clocking mon_{{ mode_2 }}_{{ rx }}_cb,{% if ddr %}
      input    {{ rx }}_clk ,{% endif %}
      input    reset_n
   );

endinterface : uvma_{{ name }}_if


`endif // __UVMA_{{ name.upper() }}_SV__
