// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ upper(name) }}_ST_TB_SV__
`define __UVMT_{{ upper(name) }}_ST_TB_SV__


/**
 * Module encapsulating the {{ full_name }} Self-Test DUT wrapper, agents and clock generating interfaces.
 */
module uvmt_{{ name }}_st_tb;

   import uvm_pkg::*;
   import uvmt_{{ name }}_st_pkg::*;

   // Clocking & Reset
   uvmt_{{ name }}_st_clknrst_gen_if  clknrst_gen_if();

   // Agent interfaces
   uvma_{{ name }}_if  {{ mode_1 }}_if(.clk(clknrst_gen_if.clk), .reset_n(clknrst_gen_if.reset_n));
   uvma_{{ name }}_if  {{ mode_2 }}_if(.clk(clknrst_gen_if.clk), .reset_n(clknrst_gen_if.reset_n));

   // DUT instance
   uvmt_{{ name }}_st_dut_wrap  dut_wrap(.*);


   /**
    * Test bench entry point.
    */
   initial begin
      // Specify time format for simulation
      $timeformat(
         .units_number       (   -9),
         .precision_number   (    3),
         .suffix_string      (" ns"),
         .minimum_field_width(   18)
      );

      // Add interfaces to uvm_config_db
      uvm_config_db#(virtual uvmt_{{ name }}_st_clknrst_gen_if)::set(null, "*", "clknrst_gen_vif", clknrst_gen_if);
      uvm_config_db#(virtual uvma_{{ name }}_if)::set(null, "*.env.{{ mode_1 }}_agent", "vif", {{ mode_1 }}_if);
      uvm_config_db#(virtual uvma_{{ name }}_if)::set(null, "*.env.{{ mode_2 }}_agent", "vif", {{ mode_2 }}_if);

      // Run test
      uvm_top.enable_print_topology = 0;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end

endmodule : uvmt_{{ name }}_st_tb


`endif // __UVMT_{{ upper(name) }}_ST_TB_SV__
