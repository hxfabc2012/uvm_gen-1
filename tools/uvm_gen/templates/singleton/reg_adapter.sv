// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __${name_uppercase}_REG_ADAPTER_SV__
`define __${name_uppercase}_REG_ADAPTER_SV__


/**
 * Object that converts between abstract register operations (UVM) and ${name_normal_case} operations.
 */
class ${name}_reg_adapter_c extends ${base_class};
   
   `uvm_object_utils(${name}_reg_adapter_c)
   
   
   /**
    * Default constructor
    */
   extern function new(string name="${name}_reg_adapter");
   
   /**
    * Converts from UVM register operation to ${name_normal_case}.
    */
   extern virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
   
   /**
    * Converts from ${name_normal_case} to UVM register operation.
    */
   extern virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
   
endclass : ${name}_reg_adapter_c


function ${name}_reg_adapter_c::new(string name="${name}_reg_adapter");
   
   super.new(name);
   
endfunction : new


function uvm_sequence_item ${name}_reg_adapter_c::reg2bus(const ref uvm_reg_bus_op rw);
   
   ${name}_seq_item_c  ${name}_trn = ${name}_seq_item_c::type_id::create("${name}_trn");
   
   // TODO Implement ${name}_reg_adapter_c::reg2bus()
   //      Ex: ${name}_trn.access = (rw.kind == UVM_READ) ? ${name_uppercase}_ACCESS_READ : ${name_uppercase}_ACCESS_WRITE;
   //          ${name}_trn.addr   = rw.addr;
   //          ${name}_trn.data   = rw.data;
   
   return ${name}_trn;
   
endfunction : reg2bus


function void ${name}_reg_adapter_c::bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
   
   ${name}_seq_item_c  ${name}_trn;
   
   if (!$cast(${name}_trn, bus_item)) begin
      `uvm_fatal("APB", $sformatf("Could not cast bus_item (%s) into ${name}_trn (%s)", $typename(bus_item), $typename(${name}_trn)))
   end
   
   // TODO Implement ${name}_reg_adapter_c::bus2reg()
   //      Ex: rw.kind   = (${name}_trn.access == ${name_uppercase}_ACCESS_READ) ? UVM_READ : UVM_WRITE;
   //          rw.addr   = ${name}_trn.addr;
   //          rw.data   = ${name}_trn.data;
   //          rw.status = UVM_IS_OK;
   
endfunction : bus2reg


`endif // __${name_uppercase}_REG_ADAPTER_SV__
