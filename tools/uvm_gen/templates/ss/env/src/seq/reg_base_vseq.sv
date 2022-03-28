// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVME_${name_uppercase}_REG_BASE_VSEQ_SV__
`define __UVME_${name_uppercase}_REG_BASE_VSEQ_SV__


/**
 * Abstract object from which all other ${name_normal_case} register-oriented virtual sequences must extend.
 */
class uvme_${name}_reg_base_vseq_c extends uvme_${name}_base_vseq_c;
   
   `include "uvme_${name}_reg_base_vseq_ignore_list.sv"
   
   // Knobs
   rand bit       single_block_mode;
   uvm_reg_block  single_block     ;
   
   `uvm_object_utils_begin(uvme_${name}_reg_base_vseq_c)
      `uvm_field_int   (single_block_mode, UVM_DEFAULT)
      `uvm_field_object(single_block     , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_reg_base_vseq");
   
   /**
    * Executes run_single_block() or run_all_blocks(), depending on
    * single_block_mode.
    */
   extern virtual task body();
   
   /**
    * Pure virtual task
    */
   extern virtual task run_single_block();
   
   /**
    * Pure virtual task
    */
   extern virtual task run_all_blocks();
   
endclass : uvme_${name}_reg_base_vseq_c


function uvme_${name}_reg_base_vseq_c::new(string name="uvme_${name}_reg_base_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_${name}_reg_base_vseq_c::body();
   
   if (single_block_mode) begin
      run_single_block();
   end
   else begin
      run_all_blocks();
   end
   
endtask : body


task uvme_${name}_reg_base_vseq_c::run_single_block();
   
   `uvm_fatal("VSEQ", "Call to pure virtual task")
   
endtask : run_single_block


task uvme_${name}_reg_base_vseq_c::run_all_blocks();
   
   `uvm_fatal("VSEQ", "Call to pure virtual task")
   
endtask : run_all_blocks


`endif // __UVME_${name_uppercase}_REG_BASE_VSEQ_SV__
