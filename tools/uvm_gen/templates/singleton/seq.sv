// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __${pkg_name_uppercase}_${name_uppercase}_SEQ_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_SEQ_SV__


/**
 * TODO Describe ${pkg_name}_${name}_seq_c
 */
class ${pkg_name}_${name}_seq_c extends ${base_class};

   // Fields


   `uvm_object_utils_begin(${pkg_name}_${name}_seq_c)

   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="${pkg_name}_${name}_seq");

   /**
    * TODO Describe ${pkg_name}_${name}_seq_c::body()
    */
   extern virtual task body();

endclass : ${pkg_name}_${name}_seq_c


function ${pkg_name}_${name}_seq_c::new(string name="${pkg_name}_${name}_seq");

   super.new(name);

endfunction : new


task ${pkg_name}_${name}_seq_c::body();

   // TODO Implement ${pkg_name}_${name}_seq_c::body()

endtask : body


`endif // __${pkg_name_uppercase}_${name_uppercase}_SEQ_SV__
