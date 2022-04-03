// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_${reset_agent_name_uppercase}_VSEQ_SV__
`define __UVME_${name_uppercase}_${reset_agent_name_uppercase}_VSEQ_SV__


/**
 * Virtual sequence responsible for asserting reset for the ${name_normal_case} Block environment.
 */
class uvme_${name}_${reset_agent_name}_vseq_c extends uvme_${name}_base_vseq_c;

   /// @defgroup Knobs
   /// @{
   rand int unsigned  duration_min; ///< Lower bound for reset pulse duration
   rand int unsigned  duration_max; ///< Upper bound for reset pulse duration
   /// @}


   `uvm_object_utils_begin(uvme_${name}_${reset_agent_name}_vseq_c)
      `uvm_field_int(duration_min, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(duration_max, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Sets safe defaults for knobs.
    */
   constraint defaults_cons {
      soft duration_min ==  10;
      soft duration_max == 100;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_${reset_agent_name}_vseq_c");

   /**
    * Sends single reset pulse.
    */
   extern virtual task body();

endclass : uvme_${name}_${reset_agent_name}_vseq_c


function uvme_${name}_${reset_agent_name}_vseq_c::new(string name="uvme_${name}_${reset_agent_name}_vseq_c");

   super.new(name);

endfunction : new


task uvme_${name}_${reset_agent_name}_vseq_c::body();

   uvma_reset_seq_item_c  reset_req;

   `uvm_do_on_with(reset_req, p_sequencer.${reset_agent_name}_sequencer, {
      duration >= duration_min;
      duration <= duration_max;
   })

endtask : body


`endif // __UVME_${name_uppercase}_${reset_agent_name_uppercase}_VSEQ_SV__
