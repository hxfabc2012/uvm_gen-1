// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_DP_IF_SV__
`define __UVMA_${name_uppercase}_DP_IF_SV__


/**
 * Encapsulates all signals and clocking of ${name_normal_case} Data Plane interface.
 * Used by monitor (uvma_${name}_dp_mon_c) and driver (uvma_${name}_dp_drv_c).
 * Assertions must be captured within uvma_${name}_dp_if_chkr.
 */
interface uvma_${name}_dp_if (
   input  clk    ,
   input  reset_n
);

   // TODO Add uvma_${name}_dp_if signals
   // Ex:  wire        enable;
   //      wire [7:0]  data;


   /**
    * Used by uvma_${name}_dp_drv_c.
    */
   clocking drv_cb @(posedge clk);
      // TODO Add signals to uvma_${name}_dp_if::drv_cb()
      //      Ex: output  enable,
      //                  data  ;
   endclocking : drv_cb

   /**
    * Used by uvma_${name}_dp_mon_c.
    */
   clocking mon_in_cb @(posedge clk);
      // TODO Add signals to uvma_${name}_dp_if::mon_in_cb()
      //      Ex: input  enable,
      //                 data  ;
   endclocking : mon_in_cb

   /**
    * Used by uvma_${name}_dp_mon_c.
    */
   clocking mon_out_cb @(posedge clk);
      // TODO Add signals to uvma_${name}_dp_if::mon_out_cb()
      //      Ex: input  enable,
      //                 data  ;
   endclocking : mon_out_cb


   /**
    * Used by uvma_${name}_dp_drv_c.
    */
   modport drv_mp (
      clocking drv_cb ,
      input    clk    ,
      input    reset_n
   );

   /**
    * Used by uvma_${name}_dp_mon_c.
    */
   modport mon_in_mp (
      clocking mon_in_cb,
      input    clk      ,
      input    reset_n
   );

   /**
    * Used by uvma_${name}_dp_mon_c.
    */
   modport mon_out_mp (
      clocking mon_out_cb,
      input    clk       ,
      input    reset_n
   );

endinterface : uvma_${name}_dp_if


`endif // __UVMA_${name_uppercase}_DP_IF_SV__
