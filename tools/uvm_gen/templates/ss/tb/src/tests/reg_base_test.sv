// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_REG_BASE_TEST_SV__
`define __UVMT_${name_uppercase}_REG_BASE_TEST_SV__


/**
 * Abstract test from which all other ${name_normal_case} Sub-System register tests must extend.
 */
class uvmt_${name}_reg_base_test_c extends uvmt_${name}_base_test_c;

   uvm_reg_block  selected_block; ///< Register block that will be targeted for testing


   `uvm_component_utils_begin(uvmt_${name}_reg_base_test_c)
      `uvm_field_object(selected_block, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_${name}_reg_base_test", uvm_component parent=null);

   /**
    * Sets target register block from CLI argument.
    */
   extern virtual function void connect_phase(uvm_phase phase);

endclass : uvmt_${name}_reg_base_test_c


function uvmt_${name}_reg_base_test_c::new(string name="uvmt_${name}_reg_base_test", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvmt_${name}_reg_base_test_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   if (test_cfg.cli_block_name_override) begin
      test_cfg.selected_reg_block = reg_block.get_block_by_name(test_cfg.cli_block_name_parsed_str);
   end

endfunction : connect_phase


`endif // __UVMT_${name_uppercase}_REG_BASE_TEST_SV__
