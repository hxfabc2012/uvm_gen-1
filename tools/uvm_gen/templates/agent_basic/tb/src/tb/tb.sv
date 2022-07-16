// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_ST_TB_SV__
`define __UVMT_${name_uppercase}_ST_TB_SV__


/**
 * Module instantiating the ${name_normal_case} UVM Agent interfaces, a clock % reset generating interface and a "DUT".
 */
module uvmt_${name}_st_tb;

   import uvm_pkg::*;
   import uvmt_${name}_st_pkg::*;

   uvmt_${name}_st_clknrst_gen_if  gen_if(); ///< Provides clocking & reset
   uvma_${name}_if  active_if (.clk(gen_if.clk), .reset_n(gen_if.reset_n)); ///< Active agent interface
   uvma_${name}_if  passive_if(.clk(gen_if.clk), .reset_n(gen_if.reset_n)); ///< Passive agent interface
   uvmt_${name}_st_dut_wrap  dut_wrap(.*); ///< Connects the agent interfaces


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
      uvm_config_db#(virtual uvmt_${name}_st_clknrst_gen_if)::set(null, "*", "vif", gen_if);
      uvm_config_db#(virtual uvma_${name}_if)::set(null, "*.env.active_agent" , "vif", active_if );
      uvm_config_db#(virtual uvma_${name}_if)::set(null, "*.env.passive_agent", "vif", passive_if);

      // Run test
      uvm_top.enable_print_topology = 0;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end

endmodule : uvmt_${name}_st_tb


`endif // __UVMT_${name_uppercase}_ST_TB_SV__
