// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_TB_SV__
`define __UVMT_${name_uppercase}_TB_SV__


/**
 * Module encapsulating the ${name_normal_case} Sub-System DUT wrapper, agents and clock generating interfaces.
 */
module uvmt_${name}_tb;

   import uvm_pkg::*;
   import uvmt_${name}_pkg::*;

   uvma_clk_if  ${clk_agent_name}_if(); ///< Clock generating interface
   uvma_reset_if  ${reset_agent_name}_if(.clk(${clk_agent_name}_if.clk)); ///< Reset assertion interface
   uvma_${ral_agent_type}_if  ${ral_agent_name}_if(.clk(${clk_agent_name}_if.clk), .reset_n(${reset_agent_name}_if.reset_n)); ///< ${ral_agent_type} interface
   uvmt_${name}_probe_if  probe_if(); ///< Misc. signals interface
   uvmt_${name}_dut_wrap  dut_wrap(.*); ///< DUT instance with interface ports


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
      uvm_config_db#(virtual uvma_clk_if)::set(null, "*.env.${clk_agent_name}_agent", "vif", ${clk_agent_name}_if);
      uvm_config_db#(virtual uvma_reset_if)::set(null, "*.env.${reset_agent_name}_agent", "vif", ${reset_agent_name}_if);
      uvm_config_db#(virtual uvma_${ral_agent_type}_if)::set(null, "*.env.${ral_agent_name}_agent", "vif", ${ral_agent_name}_if);
      uvm_config_db#(virtual uvmt_${name}_probe_if)::set(null, "*", "vif", probe_if);

      // Run test
      uvm_top.enable_print_topology = 0;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end

endmodule : uvmt_${name}_tb


`endif // __UVMT_${name_uppercase}_TB_SV__
