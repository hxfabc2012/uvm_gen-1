// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_SB_SV__
`define __UVME_${name_uppercase}_SB_SV__


/**
 * Component encapsulating scoreboards which compare ${name_normal_case} Sub-System's expected (from predictor) vs. actual (monitored) transactions.
 */
class uvme_${name}_sb_c extends uvm_scoreboard;

   /// @defgroup Objects
   /// @{
   uvme_${name}_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_${name}_cntxt_c  cntxt; ///< Environment context handle
   /// @}

   /// @defgroup Components
   /// @{
   // TODO Add sub-scoreboards
   //      Ex: uvml_sb_simplex_c  egress_sb ; ///< Describe me!
   //          uvml_sb_simplex_c  ingress_sb; ///< Describe me!
   /// @}


   `uvm_component_utils_begin(uvme_${name}_sb_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_sb", uvm_component parent=null);

   /**
    * Create and configures sub-scoreboards via:
    * 1. assign_cfg()
    * 2. assign_cntxt()
    * 3. create_sbs()
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Assigns configuration handles.
    */
   extern function void assign_cfg();

   /**
    * Assigns context handles.
    */
   extern function void assign_cntxt();

   /**
    * Creates sub-scoreboard components.
    */
   extern function void create_sbs();

endclass : uvme_${name}_sb_c


function uvme_${name}_sb_c::new(string name="uvme_${name}_sb", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_${name}_sb_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppercase}_SB", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvme_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppercase}_SB", "Context handle is null")
   end

   assign_cfg  ();
   assign_cntxt();
   create_sbs  ();

endfunction : build_phase


function void uvme_${name}_sb_c::assign_cfg();

   // TODO Implement uvme_${name}_sb_c::assign_cfg()
   //      Ex: uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "egress_sb" , "cfg", cfg.sb_egress_cfg );
   //          uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "ingress_sb", "cfg", cfg.sb_ingress_cfg);

endfunction : assign_cfg


function void uvme_${name}_sb_c::assign_cntxt();

   // TODO Implement uvme_${name}_sb_c::assign_cntxt()
   //      Ex: uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "egress_sb" , "cntxt", cntxt.sb_egress_cntxt );
   //          uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "ingress_sb", "cntxt", cntxt.sb_ingress_cntxt);

endfunction : assign_cntxt


function void uvme_${name}_sb_c::create_sbs();

   // TODO Implement uvme_${name}_sb_c::create_sbs()
   //      Ex: egress_sb  = uvml_sb_simplex_c::type_id::create("egress_sb" , this);
   //          ingress_sb = uvml_sb_simplex_c::type_id::create("ingress_sb", this);

endfunction : create_sbs


`endif // __UVME_${name_uppercase}_SB_SV__
