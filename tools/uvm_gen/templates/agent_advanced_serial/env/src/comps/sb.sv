// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_SB_SV__
`define __UVME_{{ upper(name) }}_ST_SB_SV__


/**
 * TODO Describe uvme_{{ name }}_st_sb_c
 */
class uvme_{{ name }}_st_sb_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvme_{{ name }}_st_cfg_c    cfg  ; ///<
   uvme_{{ name }}_st_cntxt_c  cntxt; ///<
   /// @}

   /// @defgroup Components
   /// @{
   uvme_{{ name }}_st_sb_simplex_c  sb_{{ tx }}; ///<
   uvme_{{ name }}_st_sb_simplex_c  sb_{{ rx }}; ///<
   uvme_{{ name }}_st_sb_simplex_c  sb_{{ mode_1 }}; ///<
   uvme_{{ name }}_st_sb_simplex_c  sb_{{ mode_2 }}; ///<
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c)  {{ tx }}_act_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c)  {{ tx }}_exp_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c)  {{ rx }}_act_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c)  {{ rx }}_exp_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c)  {{ mode_1 }}_act_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c)  {{ mode_1 }}_exp_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c)  {{ mode_2 }}_act_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c)  {{ mode_2 }}_exp_export; ///<
   /// @}


   `uvm_component_utils_begin(uvme_{{ name }}_st_sb_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_sb", uvm_component parent=null);

   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects exports to scoreboards'.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt.
    */
   extern function void get_cntxt();

   /**
    * Assigns configuration handles to components using UVM Configuration Database.
    */
   extern function void assign_cfg();

   /**
    * Assigns context handles to components using UVM Configuration Database.
    */
   extern function void assign_cntxt();

   /**
    * Creates scoreboard components.
    */
   extern function void create_components();

   /**
    * Conect scoreboard TLM ports.
    */
   extern function void connect_ports();

endclass : uvme_{{ name }}_st_sb_c


function uvme_{{ name }}_st_sb_c::new(string name="uvme_{{ name }}_st_sb", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_{{ name }}_st_sb_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg          ();
   get_cntxt        ();
   assign_cfg       ();
   assign_cntxt     ();
   create_components();

endfunction : build_phase


function void uvme_{{ name }}_st_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   connect_ports();

endfunction: connect_phase


function void uvme_{{ name }}_st_sb_c::get_cfg();

   void'(uvm_config_db#(uvme_{{ name }}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_ST_SB", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvme_{{ name }}_st_sb_c::get_cntxt();

   void'(uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ upper(name) }}_ST_SB", "Context handle is null")
   end

endfunction : get_cntxt


function void uvme_{{ name }}_st_sb_c::assign_cfg();

   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_{{ tx }}", "cfg", cfg.sb_{{ tx }}_cfg);
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_{{ rx }}", "cfg", cfg.sb_{{ rx }}_cfg);
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_{{ mode_1 }}", "cfg", cfg.sb_{{ mode_1 }}_cfg);
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_{{ mode_2 }}", "cfg", cfg.sb_{{ mode_2 }}_cfg);

endfunction: assign_cfg


function void uvme_{{ name }}_st_sb_c::assign_cntxt();

   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_{{ tx }}", "cntxt", cntxt.sb_{{ tx }}_cntxt);
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_{{ rx }}", "cntxt", cntxt.sb_{{ rx }}_cntxt);
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_{{ mode_1 }}", "cntxt", cntxt.sb_{{ mode_1 }}_cntxt);
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_{{ mode_2 }}", "cntxt", cntxt.sb_{{ mode_2 }}_cntxt);

endfunction: assign_cntxt


function void uvme_{{ name }}_st_sb_c::create_components();

   sb_{{ tx }} = uvme_{{ name }}_st_sb_simplex_c::type_id::create("sb_{{ tx }}", this);
   sb_{{ rx }} = uvme_{{ name }}_st_sb_simplex_c::type_id::create("sb_{{ rx }}", this);
   sb_{{ mode_1 }} = uvme_{{ name }}_st_sb_simplex_c::type_id::create("sb_{{ mode_1 }}", this);
   sb_{{ mode_2 }} = uvme_{{ name }}_st_sb_simplex_c::type_id::create("sb_{{ mode_2 }}", this);

endfunction: create_components


function void uvme_{{ name }}_st_sb_c::connect_ports();

   {{ tx }}_act_export.connect(sb_{{ tx }}.act_export);
   {{ tx }}_exp_export.connect(sb_{{ tx }}.exp_export);
   {{ rx }}_act_export.connect(sb_{{ rx }}.act_export);
   {{ rx }}_exp_export.connect(sb_{{ rx }}.exp_export);
   {{ mode_1 }}_act_export.connect(sb_{{ mode_1 }}.act_export);
   {{ mode_1 }}_exp_export.connect(sb_{{ mode_1 }}.exp_export);
   {{ mode_2 }}_act_export.connect(sb_{{ mode_2 }}.act_export);
   {{ mode_2 }}_exp_export.connect(sb_{{ mode_2 }}.exp_export);

endfunction: connect_ports


`endif // __UVME_{{ upper(name) }}_ST_SB_SV__
