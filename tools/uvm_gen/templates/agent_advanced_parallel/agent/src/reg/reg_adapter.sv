// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_REG_ADAPTER_SV__
`define __UVMA_{{ upper(name) }}_REG_ADAPTER_SV__


/**
 * Object that converts between abstract register operations (UVM) and {{ full_name }} ({{ upper(name) }}) Agent operations.
 */
class uvma_{{ name }}_reg_adapter_c extends uvm_reg_adapter;
   
   `uvm_object_utils(uvma_{{ name }}_reg_adapter_c)
   
   
   /**
    * Default constructor
    */
   extern function new(string name="uvma_{{ name }}_reg_adapter");
   
   /**
    * Converts from UVM register operation to {{ full_name }} ({{ upper(name) }}) Agent.
    */
   extern virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
   
   /**
    * Converts from {{ full_name }} ({{ upper(name) }}) Agent to UVM register operation.
    */
   extern virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
   
endclass : uvma_{{ name }}_reg_adapter_c


function uvma_{{ name }}_reg_adapter_c::new(string name="uvma_{{ name }}_reg_adapter");
   
   super.new(name);
   supports_byte_enable = 1;
   
endfunction : new


function uvm_sequence_item uvma_{{ name }}_reg_adapter_c::reg2bus(const ref uvm_reg_bus_op rw);
   
   uvma_{{ name }}_seq_item_c  {{ name }}_seq_item = uvma_{{ name }}_seq_item_c::type_id::create("{{ name }}_seq_item");
   
   {{ name }}_seq_item.access_type  = (rw.kind == UVM_READ) ? UVMA_{{ upper(name) }}_ACCESS_READ : UVMA_{{ upper(name) }}_ACCESS_WRITE;
   {{ name }}_seq_item.address      = rw.addr;
   {{ name }}_seq_item.data         = rw.data;
   {{ name }}_seq_item.be           = rw.byte_en;
   
   if (rw.status == UVM_NOT_OK) begin
      {{ name }}_seq_item.set_error(1);
   end
   
   return {{ name }}_seq_item;
   
endfunction : reg2bus


function void uvma_{{ name }}_reg_adapter_c::bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
   
   uvma_{{ name }}_seq_item_c  {{ name }}_seq_item;
   
   if (!$cast({{ name }}_seq_item, bus_item)) begin
      `uvm_fatal("APB", $sformatf("Could not cast bus_item (%s) into {{ name }}_seq_item (%s)", $typename(bus_item), $typename({{ name }}_seq_item)))
   end
   
   rw.kind    = ({{ name }}_seq_item.access_type == UVMA_{{ upper(name) }}_ACCESS_READ) ? UVM_READ : UVM_WRITE;
   rw.addr    = {{ name }}_seq_item.address;
   rw.data    = {{ name }}_seq_item.data;
   rw.byte_en = {{ name }}_seq_item.be;
   
   if ({{ name }}_seq_item.has_error()) begin
      rw.status = UVM_NOT_OK;
   end
   else begin
      rw.status = UVM_IS_OK;
   end
   
endfunction : bus2reg


`endif // __UVMA_{{ upper(name) }}_REG_ADAPTER_SV__
