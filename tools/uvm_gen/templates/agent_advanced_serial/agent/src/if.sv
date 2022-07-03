// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SV__
`define __UVMA_{{ upper(name) }}_SV__


/**
 * Encapsulates all signals and clocking of the {{ full_name }}.
 */
interface uvma_{{ name }}_if (
   input  clk    , ///< The bus clock times all bus transfers. All signal timings are related to the rising edge of clk.
   input  reset_n  ///< The bus reset signal is active LOW and resets the system and the bus. This is the only active LOW signal.
);
   
   // Signals
   wire  txdp  ; ///< 
   wire  txdn  ; ///< 
   wire  rxd24p; ///< 
   wire  rxd24n; ///< 
   wire  rxd09p; ///< 
   wire  rxd09n; ///< 
   
   
   /**
    * Used by {{ upper(mode_1) }} DUT.
    */
   clocking dut_{{ mode_1 }}_cb @(clk);
      input   rxd24p,
              rxd24n,
              rxd09p,
              rxd09n;
      output  txdp,
              txdn;
   endclocking : dut_{{ mode_1 }}_cb
   
   /**
    * Used by {{ upper(mode_2) }} DUT.
    */
   clocking dut_{{ mode_2 }}_cb @(clk);
      output  rxd24p,
              rxd24n,
              rxd09p,
              rxd09n;
      input   txdp,
              txdn;
   endclocking : dut_{{ mode_2 }}_cb
   
   /**
    * Used by uvma_{{ name }}_drv_{{ tx }}_c.
    */
   clocking drv_{{ tx }}_cb @(clk);
      output  txdp,
              txdn;
   endclocking : drv_{{ tx }}_cb
   
   /**
    * Used by uvma_{{ name }}_drv_{{ rx }}_c.
    */
   clocking drv_{{ rx }}_cb @(clk);
      output  rxd24p,
              rxd24n,
              rxd09p,
              rxd09n;
   endclocking : drv_{{ rx }}_cb
   
   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   clocking mon_cb @(clk);
      input  txdp  ,
             txdn  ,
             rxd24p,
             rxd24n,
             rxd09p,
             rxd09n;
   endclocking : mon_cb
   
   
   /**
    * Used by target DUT.
    */
   modport dut_{{ mode_1 }}_mp (
      clocking dut_{{ mode_1 }}_cb,
      input    clk       ,
      input    reset_n
   );
   
   /**
    * Used by target DUT.
    */
   modport dut_{{ mode_2 }}_mp (
      clocking dut_{{ mode_2 }}_cb,
      input    clk       ,
      input    reset_n
   );
   
   /**
    * Used by uvma_{{ name }}_drv_{{ tx }}_c.
    */
   modport drv_{{ tx }}_mp (
      clocking drv_{{ tx }}_cb,
      input    clk      ,
      input    reset_n
   );
   
   /**
    * Used by uvma_{{ name }}_drv_{{ rx }}_c.
    */
   modport drv_{{ rx }}_mp (
      clocking drv_{{ rx }}_cb,
      input    clk      ,
      input    reset_n   
   );
   
   /**
    * Used by uvma_{{ name }}_mon_c.
    */
   modport mon_mp(
      clocking mon_cb ,
      input    clk    ,
      input    reset_n 
   );
   
endinterface : uvma_{{ name }}_if


`endif // __UVMA_{{ upper(name) }}_SV__
