// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_BASE_VSEQ_SV__
`define __UVME_{{ upper(name) }}_ST_BASE_VSEQ_SV__


/**
 * Abstract object from which all other {{ full_name }} virtual sequences extend.
 * Does not generate any sequence items of its own. Subclasses must be run on {{ full_name }} Virtual Sequencer
 * (uvme_{{ name }}_st_vsqr_c) instance.
 */
class uvme_{{ name }}_st_base_vseq_c extends uvml_seq_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   // Environment handles
   uvme_{{ name }}_st_cfg_c    cfg  ;
   uvme_{{ name }}_st_cntxt_c  cntxt;


   `uvm_object_utils(uvme_{{ name }}_st_base_vseq_c)
   `uvm_declare_p_sequencer(uvme_{{ name }}_st_vsqr_c)


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_base_vseq");

   /**
    * Retrieve cfg and cntxt handles from p_sequencer.
    */
   extern virtual task pre_start();

endclass : uvme_{{ name }}_st_base_vseq_c


function uvme_{{ name }}_st_base_vseq_c::new(string name="uvme_{{ name }}_st_base_vseq");

   super.new(name);

endfunction : new


task uvme_{{ name }}_st_base_vseq_c::pre_start();

   cfg   = p_sequencer.cfg  ;
   cntxt = p_sequencer.cntxt;

endtask : pre_start


`endif // __UVME_{{ upper(name) }}_ST_BASE_VSEQ_SV__
