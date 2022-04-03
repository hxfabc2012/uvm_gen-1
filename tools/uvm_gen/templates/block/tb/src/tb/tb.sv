// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_TB_SV__
`define __UVMT_${name_uppercase}_TB_SV__


/**
 * Module encapsulating the ${name_normal_case} Block DUT wrapper, agents and clock generating interfaces.
 */
module uvmt_${name}_tb;

   import uvm_pkg::*;
   import uvmt_${name}_pkg::*;

   uvma_clk_if  ${clk_agent_name}_if(); ///< Clock generating interface
   uvma_reset_if  ${reset_agent_name}_if(.clk(${clk_agent_name}_if.clk)); ///< Reset assertion interface
   uvma_${name}_cp_if      cp_if(.clk(${clk_agent_name}_if.clk), .reset_n(${reset_agent_name}_if.reset_n)); ///< Control plane interface
   uvma_${name}_dp_in_if   dp_in_if(.clk(${clk_agent_name}_if.clk), .reset_n(${reset_agent_name}_if.reset_n)); ///< Data plane input interface
   uvma_${name}_dp_out_if  dp_out_if(.clk(${clk_agent_name}_if.clk), .reset_n(${reset_agent_name}_if.reset_n)); ///< Data plane output interface
   uvmt_${name}_probe_if   probe_if(); ///< Misc. signals interface
   uvmt_${name}_dut_wrap   dut_wrap(.*); ///< DUT instance with interface ports


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
      uvm_config_db#(virtual uvma_${name}_cp_if    )::set(null, "*.env.cp_agent"    , "vif", cp_if    );
      uvm_config_db#(virtual uvma_${name}_dp_in_if )::set(null, "*.env.dp_in_agent" , "vif", dp_in_if );
      uvm_config_db#(virtual uvma_${name}_dp_out_if)::set(null, "*.env.dp_out_agent", "vif", dp_out_if);
      uvm_config_db#(virtual uvmt_${name}_probe_if )::set(null, "*"                 , "vif", probe_if );

      // Run test
      uvm_top.enable_print_topology = 0;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end


   /**
    * End-of-test summary printout.
    */
   final begin
      string             summary_string;
      uvm_report_server  rs;
      int                err_count;
      int                fatal_count;
      static bit         sim_finished = 0;

      static string  red   = "\033[31m\033[1m";
      static string  green = "\033[32m\033[1m";
      static string  reset = "\033[0m";

      rs          = uvm_top.get_report_server();
      err_count   = rs.get_severity_count(UVM_ERROR);
      fatal_count = rs.get_severity_count(UVM_FATAL);

      void'(uvm_config_db#(bit)::get(null, "", "sim_finished", sim_finished));

      $display("\n*** Test Summary ***\n");

      if (sim_finished && (err_count == 0) && (fatal_count == 0)) begin
         $display("    PPPPPPP    AAAAAA    SSSSSS    SSSSSS   EEEEEEEE  DDDDDDD     ");
         $display("    PP    PP  AA    AA  SS    SS  SS    SS  EE        DD    DD    ");
         $display("    PP    PP  AA    AA  SS        SS        EE        DD    DD    ");
         $display("    PPPPPPP   AAAAAAAA   SSSSSS    SSSSSS   EEEEE     DD    DD    ");
         $display("    PP        AA    AA        SS        SS  EE        DD    DD    ");
         $display("    PP        AA    AA  SS    SS  SS    SS  EE        DD    DD    ");
         $display("    PP        AA    AA   SSSSSS    SSSSSS   EEEEEEEE  DDDDDDD     ");
         $display("    ----------------------------------------------------------");
         $display("                        SIMULATION PASSED                     ");
         $display("    ----------------------------------------------------------");
      end
      else begin
         $display("    FFFFFFFF   AAAAAA   IIIIII  LL        EEEEEEEE  DDDDDDD       ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FFFFF     AAAAAAAA    II    LL        EEEEE     DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA    II    LL        EE        DD    DD      ");
         $display("    FF        AA    AA  IIIIII  LLLLLLLL  EEEEEEEE  DDDDDDD       ");

         if (sim_finished == 0) begin
            $display("    --------------------------------------------------------");
            $display("                   SIMULATION FAILED - ABORTED              ");
            $display("    --------------------------------------------------------");
         end
         else begin
            $display("    --------------------------------------------------------");
            $display("                       SIMULATION FAILED                    ");
            $display("    --------------------------------------------------------");
         end
      end
   end

endmodule : uvmt_${name}_tb


`endif // __UVMT_${name_uppercase}_TB_SV__