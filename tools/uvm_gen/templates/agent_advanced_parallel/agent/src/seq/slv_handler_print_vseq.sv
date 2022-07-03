// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SLV_HANDLER_PRINT_VSEQ_SV__
`define __UVMA_{{ upper(name) }}_SLV_HANDLER_PRINT_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_slv_handler_print_vseq_c
 */
class uvma_{{ name }}_slv_handler_print_vseq_c extends uvma_{{ name }}_slv_handler_base_vseq_c;

   uvma_{{ name }}_addr_l_t  print_location; ///<
   string             id            ; ///<


   `uvm_object_utils(uvma_{{ name }}_slv_handler_print_vseq_c)


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_slv_handler_print_vseq");

   /**
    * TODO Describe uvma_{{ name }}_slv_handler_print_vseq_c::body()
    */
   extern virtual task body();

   /**
    * TODO Describe uvma_{{ name }}_slv_handler_print_vseq_c::body()
    */
   extern virtual task handle_mstr_req(ref uvma_{{ name }}_mstr_a_mon_trn_c trn, bit handled);

endclass : uvma_{{ name }}_slv_handler_print_vseq_c


function uvma_{{ name }}_slv_handler_print_vseq_c::new(string name="uvma_{{ name }}_slv_handler_print_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_slv_handler_print_vseq_c::body();

   p_sequencer.cntxt.slv_handlers.push_back(this);
   forever begin
      wait_clk();
   end

endtask : body


task uvma_{{ name }}_slv_handler_print_vseq_c::handle_mstr_req(ref uvma_{{ name }}_mstr_a_mon_trn_c trn, bit handled);

   uvma_{{ name }}_data_b_t          readback_data ;
   uvma_{{ name }}_slv_r_seq_item_c  slv_r_seq_item;

   // TODO Add response latency cycles

   `uvm_info("{{ upper(name) }}_SLV_PRINT_VSEQ", $sformatf("Responding to \n%s", trn.sprint()), UVM_DEBUG)
   if ((trn.addr === print_location) && (trn.we === 1'b1)) begin
      `uvm_info("{{ upper(name) }}_SLV_PRINT_VSEQ", $sformatf("Call to print location '%s' with data: '%h'", id, trn.wdata), UVM_NONE)
      do begin
         `uvm_create_on(slv_r_seq_item, p_sequencer.slv_r_sequencer)
         slv_r_seq_item.rvalid = 1'b1;
         slv_r_seq_item.err    = 1'b0;
         `uvm_send_pri(slv_r_seq_item, `UVMA_{{ upper(name) }}_SLV_DRV_SEQ_ITEM_PRI)
      end while (slv_r_seq_item.rready !== 1'b1);

      `uvm_info("{{ upper(name) }}_SLV_PRINT_VSEQ", $sformatf("Location '%s' responded to \n%s\nwith\n%s", id, trn.sprint(), slv_r_seq_item.sprint()), UVM_DEBUG)
      handled = 1;
   end
   else begin
      handled = 0;
   end

endtask : handle_mstr_req


`endif // __UVMA_{{ upper(name) }}_SLV_HANDLER_PRINT_VSEQ_SV__
