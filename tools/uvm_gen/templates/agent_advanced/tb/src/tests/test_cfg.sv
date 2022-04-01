// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMT_${name_uppercase}_ST_TEST_CFG_SV__
`define __UVMT_${name_uppercase}_ST_TEST_CFG_SV__


/**
 * Object encapsulating configuration parameters common to most if not all tests
 * extending from uvmt_${name}_st_base_test_c.
 */
class uvmt_${name}_st_test_cfg_c extends uvm_object;
   
   // Knobs
   rand int unsigned  clk_period        ; // Specified in picoseconds (ps)
   rand int unsigned  reset_period      ; // Specified in nanoseconds (ns)
   rand int unsigned  startup_timeout   ; // Specified in nanoseconds (ns)
   rand int unsigned  heartbeat_period  ; // Specified in nanoseconds (ns)
   rand int unsigned  simulation_timeout; // Specified in nanoseconds (ns)
   
   // Command line arguments
   // TODO Add command line argument descriptors
   //      Ex: bit           cli_num_pkts_override = 0;
   //          int unsigned  cli_num_pkts_parsed;
   
   
   `uvm_object_utils_begin(uvmt_${name}_st_test_cfg_c)
      `uvm_field_int(clk_period        , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(reset_period      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(startup_timeout   , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(heartbeat_period  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(simulation_timeout, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      clk_period         == uvmt_${name}_st_default_clk_period        ;
      reset_period       == uvmt_${name}_st_default_reset_period      ;
      startup_timeout    == uvmt_${name}_st_default_startup_timeout   ;
      heartbeat_period   == uvmt_${name}_st_default_heartbeat_period  ;
      simulation_timeout == uvmt_${name}_st_default_simulation_timeout;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_${name}_st_test_cfg");
   
   /**
    * TODO Describe uvmt_${name}_st_test_cfg_c::process_cli_args()
    */
   extern function void process_cli_args();
   
endclass : uvmt_${name}_st_test_cfg_c


function uvmt_${name}_st_test_cfg_c::new(string name="uvmt_${name}_st_test_cfg");
   
   super.new(name);
   
endfunction : new


function void uvmt_${name}_st_test_cfg_c::process_cli_args();
   
   // TODO Process command line arguments
   //      Ex: string  cli_num_pkts_parsed_str  = "";
   //          if ($value$plusargs("NUM_PKTS=", cli_num_pkts_parsed_str)) begin
   //             if (cli_num_pkts_parsed_str != "") begin
   //                cli_num_pkts_override = 1;
   //                cli_num_pkts_parsed = cli_num_pkts_parsed_str.atoi();
   //             end
   //             else begin
   //                cli_num_pkts_override = 0;
   //             end
   //          end
   //          else begin
   //             cli_num_pkts_override = 0;
   //          end
   
endfunction : process_cli_args


`endif // __UVMT_${name_uppercase}_ST_TEST_CFG_SV__
