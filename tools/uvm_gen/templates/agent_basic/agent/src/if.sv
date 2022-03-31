// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_IF_SV__
`define __UVMA_${name_uppercase}_IF_SV__


/**
 * Encapsulates all signals and clocking of ${name_normal_case} interface.
 * Used by monitor (uvma_${name}_mon_c) and driver (uvma_${name}_drv_c).
 * Assertions must be captured within uvma_${name}_if_chkr.
 */
interface uvma_${name}_if (
   input  clk    ,
   input  reset_n
);

   // TODO Add uvma_${name}_if signals
   // Ex:  wire        enable;
   //      wire [7:0]  data;


   /**
    * Used by uvma_${name}_drv_c.
    */
   clocking drv_cb @(posedge clk);
      // TODO Implement uvma_${name}_if::drv_cb()
      //      Ex: output  enable,
      //                  data  ;
   endclocking : drv_cb

   /**
    * Used by uvma_${name}_mon_c.
    */
   clocking mon_cb @(posedge clk);
      // TODO Implement uvma_${name}_if::mon_cb()
      //      Ex: input  enable,
      //                 data  ;
   endclocking : mon_cb


   /**
    * Used by uvma_${name}_drv_c.
    */
   modport drv_mp (
      clocking drv_cb ,
      input    clk    ,
      input    reset_n
   );

   /**
    * Used by uvma_${name}_mon_c.
    */
   modport mon_mp (
      clocking mon_cb ,
      input    clk    ,
      input    reset_n
   );

endinterface : uvma_${name}_if


`endif // __UVMA_${name_uppercase}_IF_SV__
