// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_CLK_VSEQ_SV__
`define __UVME_${name_uppercase}_CLK_VSEQ_SV__


/**
 * Virtual sequence responsible for starting clock(s) for the ${name_normal_case} Block environment.
 */
class uvme_${name}_clk_vseq_c extends uvme_${name}_base_vseq_c;

   `uvm_object_utils(uvme_${name}_clk_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_clk_vseq_c");

   /**
    * Start clock generation with frequency set in #cfg.
    */
   extern virtual task body();

endclass : uvme_${name}_clk_vseq_c


function uvme_${name}_clk_vseq_c::new(string name="uvme_${name}_clk_vseq_c");

   super.new(name);

endfunction : new


task uvme_${name}_clk_vseq_c::body();

   uvma_clk_seq_item_c  clk_req;

   `uvm_do_on_with(clk_req, p_sequencer.clk_sequencer, {
      action        == UVMA_CLK_SEQ_ITEM_ACTION_START;
      new_frequency == cfg.clk_frequency;
   })

endtask : body


`endif // __UVME_${name_uppercase}_CLK_VSEQ_SV__
