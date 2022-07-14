// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SV__
`define __UVMA_{{ upper(name) }}_SV__


/**
 * Encapsulates all signals and clocking of the {{ full_name }}.
 */
interface uvma_{{ name }}_if (
   input  tx_clk , ///< The bus clock times all bus transfers. All signal timings are related to the rising edge of clk.
   input  rx_clk , ///< The bus clock times all bus transfers. All signal timings are related to the rising edge of clk.
   input  reset_n  ///< The bus reset signal is active LOW and resets the system and the bus. This is the only active LOW signal.
);

   /// @defgroup Signals
   /// @{
{% if symmetric %}   wire  txp; ///<
   wire  txn; ///<
   wire  rxp; ///<
   wire  rxn; ///<
{% else %}   wire  txp; ///<
   wire  txn; ///<
   wire  rx0p; ///<
   wire  rx0n; ///<
   wire  rx1p; ///<
   wire  rx1n; ///<
{% endif %}   /// @}


   /**
    * Used by {{ mode_1 }} DUT Tx.
    */
   {% if ddr %}clocking dut_{{ mode_1 }}_tx_cb @(tx_clk);
   {% else %}clocking dut_{{ mode_1 }}_tx_cb @(posedge tx_clk);{% endif %}
      output  txp,
              txn;
   endclocking : dut_{{ mode_1 }}_tx_cb

   /**
    * Used by {{ mode_1 }} DUT Rx.
    */
   {% if ddr %}clocking dut_{{ mode_1 }}_rx_cb @(rx_clk);
   {% else %}clocking dut_{{ mode_1 }}_rx_cb @(posedge rx_clk);{% endif %}
{% if symmetric %}      input  rxp,
             rxn;
{% else %}      input  rx0p,
             rx0n;
                input  rx1p,
             rx1n;
{% endif %}
   endclocking : dut_{{ mode_1 }}_rx_cb

   /**
    * Used by {{ mode_2 }} DUT Tx.
    */
   {% if ddr %}clocking dut_{{ mode_2 }}_tx_cb @(tx_clk);
   {% else %}clocking dut_{{ mode_2 }}_tx_cb @(posedge tx_clk);{% endif %}
      output  txp,
              txn;
   endclocking : dut_{{ mode_2 }}_tx_cb

   /**
    * Used by {{ mode_2 }} DUT Rx.
    */
   {% if ddr %}clocking dut_{{ mode_2 }}_rx_cb @(rx_clk);
   {% else %}clocking dut_{{ mode_2 }}_rx_cb @(posedge rx_clk);{% endif %}
{% if symmetric %}      input  rxp,
             rxn;
{% else %}      input  rx0p,
             rx0n;
                input  rx1p,
             rx1n;
{% endif %}
   endclocking : dut_{{ mode_2 }}_rx_cb

   /**
    * Used by uvma_{{ name }}_drv_tx_c.
    */
   {% if ddr %}clocking drv_tx_cb @(tx_clk);
   {% else %}clocking drv_tx_cb @(posedge tx_clk);{% endif %}
      output  txp,
              txn;
   endclocking : drv_tx_cb

   /**
    * Used by uvma_{{ name }}_drv_rx_c.
    */
   {% if ddr %}clocking drv_rx_cb @(rx_clk);
   {% else %}clocking drv_rx_cb @(posedge rx_clk);{% endif %}
      output  txp,
              txn;
   endclocking : drv_rx_cb

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   {% if ddr %}clocking mon_{{ mode_1 }}_tx_cb @(tx_clk);
   {% else %}clocking mon_{{ mode_1 }}_tx_cb @(posedge tx_clk);{% endif %}
      input  txp,
             txn;
   endclocking : mon_{{ mode_1 }}_tx_cb

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   {% if ddr %}clocking mon_{{ mode_1 }}_rx_cb @(rx_clk);
   {% else %}clocking mon_{{ mode_1 }}_rx_cb @(posedge rx_clk);{% endif %}
{% if symmetric %}      input  rxp,
             rxn;
{% else %}      input  rx0p,
             rx0n;
                input  rx1p,
             rx1n;
{% endif %}
   endclocking : mon_{{ mode_1 }}_rx_cb

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   {% if ddr %}clocking mon_{{ mode_2 }}_tx_cb @(tx_clk);
   {% else %}clocking mon_{{ mode_2 }}_tx_cb @(posedge tx_clk);{% endif %}
      input  txp,
             txn;
   endclocking : mon_{{ mode_2 }}_tx_cb

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   {% if ddr %}clocking mon_{{ mode_2 }}_rx_cb @(rx_clk);
   {% else %}clocking mon_{{ mode_2 }}_rx_cb @(posedge rx_clk);{% endif %}
{% if symmetric %}      input  rxp,
             rxn;
{% else %}      input  rx0p,
             rx0n;
                input  rx1p,
             rx1n;
{% endif %}
   endclocking : mon_{{ mode_2 }}_rx_cb


   /**
    * Used by {{ mode_1 }} DUT Tx.
    */
   modport dut_{{ mode_1 }}_mp (
      clocking dut_{{ mode_1 }}_tx_cb,{% if ddr %}
      input    tx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_1 }} DUT Rx.
    */
   modport dut_{{ mode_1 }}_mp (
      clocking dut_{{ mode_1 }}_rx_cb,{% if ddr %}
      input    rx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_2 }} DUT Tx.
    */
   modport dut_{{ mode_2 }}_mp (
      clocking dut_{{ mode_2 }}_tx_cb,{% if ddr %}
      input    tx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by {{ mode_2 }} DUT Rx.
    */
   modport dut_{{ mode_2 }}_mp (
      clocking dut_{{ mode_2 }}_rx_cb,{% if ddr %}
      input    rx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_drv_tx_c.
    */
   modport drv_tx_mp (
      clocking drv_tx_cb,{% if ddr %}
      input    tx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_drv_rx_c.
    */
   modport drv_rx_mp (
      clocking drv_rx_cb,{% if ddr %}
      input    rx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_{{ mode_1 }}_tx_mp (
      clocking mon_{{ mode_1 }}_tx_cb,{% if ddr %}
      input    tx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_{{ mode_1 }}_rx_mp (
      clocking mon_{{ mode_1 }}_rx_cb,{% if ddr %}
      input    rx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_{{ mode_2 }}_tx_mp (
      clocking mon_{{ mode_2 }}_tx_cb,{% if ddr %}
      input    tx_clk ,{% endif %}
      input    reset_n
   );

   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_{{ mode_2 }}_rx_mp (
      clocking mon_{{ mode_2 }}_rx_cb,{% if ddr %}
      input    rx_clk ,{% endif %}
      input    reset_n
   );

endinterface : uvma_{{ name }}_if


`endif // __UVMA_{{ upper(name) }}_SV__
