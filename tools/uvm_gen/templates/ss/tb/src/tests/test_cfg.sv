// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_TEST_CFG_SV__
`define __UVMT_${name_uppercase}_TEST_CFG_SV__


/**
 * Object encapsulating common configuration parameters for ${name_normal_case} Sub-System tests.
 */
class uvmt_${name}_test_cfg_c extends uvml_test_cfg_c;

   /// @defparam Generic knobs
   /// @{
   rand int unsigned  startup_timeout   ; ///< Timer ending test if no heartbeat is detected from start of simulation (ns)
   rand int unsigned  heartbeat_period  ; ///< Timer ending phase if no heartbeat is detected from start of a phase (ns)
   rand int unsigned  simulation_timeout; ///< Timer ending simulation (ns)
   /// @}

   /// @defparam Register tests knobs
   /// @{
   uvm_reg_block  selected_reg_block; ///< Register block to be tested.
   /// @}

   /// @defgroup Command line arguments
   /// @{
   bit     cli_block_name_override = 0; ///< Set to '1' if argument was found for #selected_reg_block
   string  cli_block_name_parsed_str  ; ///< Parsed string value from the CLI for #selected_reg_block
   /// @}


   `uvm_object_utils_begin(uvmt_${name}_test_cfg_c)
      `uvm_field_int(startup_timeout   , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(heartbeat_period  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(simulation_timeout, UVM_DEFAULT + UVM_DEC)

      `uvm_field_object(selected_reg_block, UVM_DEFAULT)

      `uvm_field_int   (cli_block_name_override  , UVM_DEFAULT)
      `uvm_field_string(cli_block_name_parsed_str, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Sets safe defaults for all simulation timing parameters.
    */
   constraint timeouts_default_cons {
      startup_timeout    == uvmt_${name}_default_startup_timeout   ;
      heartbeat_period   == uvmt_${name}_default_heartbeat_period  ;
      simulation_timeout == uvmt_${name}_default_simulation_timeout;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_${name}_test_cfg");

   /**
    * Processes command line interface arguments.
    */
   extern function void process_cli_args();

endclass : uvmt_${name}_test_cfg_c


function uvmt_${name}_test_cfg_c::new(string name="uvmt_${name}_test_cfg");

   super.new(name);

endfunction : new


function void uvmt_${name}_test_cfg_c::process_cli_args();

   if (uvm_cmdline_proc.get_arg_value("BLKNM=", cli_block_name_parsed_str)) begin
      if (cli_block_name_parsed_str != "") begin
         cli_block_name_override = 1;
      end
      else begin
         cli_block_name_override = 0;
      end
   end
   else begin
      cli_block_name_override = 0;
   end

endfunction : process_cli_args


`endif // __UVMT_${name_uppercase}_TEST_CFG_SV__
