// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMT_${tb_name_uppercase}_${name_uppercase}_TEST_SV__
`define __UVMT_${tb_name_uppercase}_${name_uppercase}_TEST_SV__


/**
 * TODO Describe uvmt_${tb_name}_${name}_test_c
 */
class uvmt_${tb_name}_${name}_test_c extends ${base_class};
   
   rand uvme_${tb_name}_${vseq_name}_vseq_c  ${vseq_name}_vseq;
   
   
   `uvm_component_utils(uvmt_${tb_name}_${name}_test_c)
   
   
   /**
    * Creates ${name}_vseq.
    */
   extern function new(string name="uvmt_${tb_name}_${name}_test", uvm_component parent=null);
   
   /**
    * Runs ${name}_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_${tb_name}_${name}_test_c


function uvmt_${tb_name}_${name}_test_c::new(string name="uvmt_${tb_name}_${name}_test", uvm_component parent=null);
   
   super.new(name, parent);
   
   ${vseq_name}_vseq = uvme_${tb_name}_${vseq_name}_vseq_c::type_id::create("${vseq_name}_vseq");
   
endfunction : new


task uvmt_${tb_name}_${name}_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting ${vseq_name} virtual sequence:\n%s", ${vseq_name}_vseq.sprint()), UVM_NONE)
   ${vseq_name}_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished ${vseq_name} virtual sequence:\n%s", ${vseq_name}_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_${tb_name_uppercase}_${name_uppercase}_TEST_SV__
