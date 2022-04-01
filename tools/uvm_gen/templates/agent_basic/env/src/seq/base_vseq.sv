// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ST_BASE_VSEQ_SV__
`define __UVME_${name_uppercase}_ST_BASE_VSEQ_SV__


/**
 * Abstract virtual sequence from which ${name_normal_case} UVM Agent Self-Test environment virtual sequences extend.
 * Subclasses must be run on uvme_${name}_st_vsqr_c.
 * @note Does not generate any sequence items of its own.
 */
class uvme_${name}_st_base_vseq_c extends uvml_vseq_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   /// @defgroup Objects
   /// @{
   uvme_${name}_st_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_${name}_st_cntxt_c  cntxt; ///< Environment context handle
   /// @}


   `uvm_object_utils(uvme_${name}_st_base_vseq_c)
   `uvm_declare_p_sequencer(uvme_${name}_st_vsqr_c)


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_st_base_vseq");

   /**
    * Retrieve #cfg and #cntxt handles from p_sequencer.
    */
   extern virtual task pre_start();

endclass : uvme_${name}_st_base_vseq_c


function uvme_${name}_st_base_vseq_c::new(string name="uvme_${name}_st_base_vseq");

   super.new(name);

endfunction : new


task uvme_${name}_st_base_vseq_c::pre_start();

   cfg   = p_sequencer.cfg;
   cntxt = p_sequencer.cntxt;

endtask : pre_start


`endif // __UVME_${name_uppercase}_ST_BASE_VSEQ_SV__
