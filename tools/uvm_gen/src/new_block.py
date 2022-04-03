#!/usr/bin/python3
########################################################################################################################
# Copyright 2022 Datum Technology Corporation
########################################################################################################################
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


########################################################################################################################
# IMPORTS
########################################################################################################################
from datetime import date
import os
import sys
import re


########################################################################################################################
# GLOBALS
########################################################################################################################
dbg = False
uvm_gen_dir = re.sub("new_block.py", "", os.path.realpath(__file__)) + ".."
relative_path_to_template = uvm_gen_dir + "/templates/"
out_path = ""
default_copyright_owner = "Contributors"
default_license = "SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1"
name_of_copyright_owner = ""
name = ""
name_normal_case = ""


########################################################################################################################
# TEMPLATE DATA
########################################################################################################################
parameters = { }

files = {
    #              SRC                                 DST
    "agent_basic/agent/bin/package.py"                  : "uvma_${name}_cp/bin/package.py",
    "agent_basic/agent/docs/agent_block_diagram.svg"    : "uvma_${name}_cp/docs/agent_block_diagram.svg",
    "agent_basic/agent/examples/instantiation.sv"       : "uvma_${name}_cp/examples/instantiation.sv",
    "agent_basic/agent/examples/sequence.sv"            : "uvma_${name}_cp/examples/sequence.sv",
    "agent_basic/agent/src/comps/agent.sv"              : "uvma_${name}_cp/src/comps/uvma_${name}_cp_agent.sv",
    "agent_basic/agent/src/comps/cov_model.sv"          : "uvma_${name}_cp/src/comps/uvma_${name}_cp_cov_model.sv",
    "agent_basic/agent/src/comps/drv.sv"                : "uvma_${name}_cp/src/comps/uvma_${name}_cp_drv.sv",
    "agent_basic/agent/src/comps/logger.sv"             : "uvma_${name}_cp/src/comps/uvma_${name}_cp_logger.sv",
    "agent_basic/agent/src/comps/mon.sv"                : "uvma_${name}_cp/src/comps/uvma_${name}_cp_mon.sv",
    "agent_basic/agent/src/comps/sqr.sv"                : "uvma_${name}_cp/src/comps/uvma_${name}_cp_sqr.sv",
    "agent_basic/agent/src/obj/cfg.sv"                  : "uvma_${name}_cp/src/obj/uvma_${name}_cp_cfg.sv",
    "agent_basic/agent/src/obj/cntxt.sv"                : "uvma_${name}_cp/src/obj/uvma_${name}_cp_cntxt.sv",
    "agent_basic/agent/src/obj/mon_trn.sv"              : "uvma_${name}_cp/src/obj/uvma_${name}_cp_mon_trn.sv",
    "agent_basic/agent/src/seq/base_seq.sv"             : "uvma_${name}_cp/src/seq/uvma_${name}_cp_base_seq.sv",
    "agent_basic/agent/src/seq/seq_item.sv"             : "uvma_${name}_cp/src/seq/uvma_${name}_cp_seq_item.sv",
    "agent_basic/agent/src/seq/seq_lib.sv"              : "uvma_${name}_cp/src/seq/uvma_${name}_cp_seq_lib.sv",
    "agent_basic/agent/src/constants.sv"                : "uvma_${name}_cp/src/uvma_${name}_cp_constants.sv",
    "agent_basic/agent/src/if_chkr.sv"                  : "uvma_${name}_cp/src/uvma_${name}_cp_if_chkr.sv",
    "agent_basic/agent/src/if.sv"                       : "uvma_${name}_cp/src/uvma_${name}_cp_if.sv",
    "agent_basic/agent/src/macros.svh"                  : "uvma_${name}_cp/src/uvma_${name}_cp_macros.svh",
    "agent_basic/agent/src/pkg.flist"                   : "uvma_${name}_cp/src/uvma_${name}_cp_pkg.flist",
    "agent_basic/agent/src/pkg.flist.xsim"              : "uvma_${name}_cp/src/uvma_${name}_cp_pkg.flist.xsim",
    "agent_basic/agent/src/pkg.sv"                      : "uvma_${name}_cp/src/uvma_${name}_cp_pkg.sv",
    "agent_basic/agent/src/tdefs.sv"                    : "uvma_${name}_cp/src/uvma_${name}_cp_tdefs.sv",
    "agent_basic/agent/gitignore"                       : "uvma_${name}_cp/.gitignore",
    "agent_basic/agent/ip.yml"                          : "uvma_${name}_cp/ip.yml",
    "LICENSE_solderpad_v2p1.md"                         : "uvma_${name}_cp/LICENSE.md",
    "agent_basic/agent/README.md"                       : "uvma_${name}_cp/README.md",
    
    "agent_basic/agent/bin/package.py"                  : "uvma_${name}dp_in/bin/package.py",
    "agent_basic/agent/docs/agent_block_diagram.svg"    : "uvma_${name}dp_in/docs/agent_block_diagram.svg",
    "agent_basic/agent/examples/instantiation.sv"       : "uvma_${name}dp_in/examples/instantiation.sv",
    "agent_basic/agent/examples/sequence.sv"            : "uvma_${name}dp_in/examples/sequence.sv",
    "agent_basic/agent/src/comps/agent.sv"              : "uvma_${name}dp_in/src/comps/uvma_${name}_dp_in_agent.sv",
    "agent_basic/agent/src/comps/cov_model.sv"          : "uvma_${name}dp_in/src/comps/uvma_${name}_dp_in_cov_model.sv",
    "agent_basic/agent/src/comps/drv.sv"                : "uvma_${name}dp_in/src/comps/uvma_${name}_dp_in_drv.sv",
    "agent_basic/agent/src/comps/logger.sv"             : "uvma_${name}dp_in/src/comps/uvma_${name}_dp_in_logger.sv",
    "agent_basic/agent/src/comps/mon.sv"                : "uvma_${name}dp_in/src/comps/uvma_${name}_dp_in_mon.sv",
    "agent_basic/agent/src/comps/sqr.sv"                : "uvma_${name}dp_in/src/comps/uvma_${name}_dp_in_sqr.sv",
    "agent_basic/agent/src/obj/cfg.sv"                  : "uvma_${name}dp_in/src/obj/uvma_${name}_dp_in_cfg.sv",
    "agent_basic/agent/src/obj/cntxt.sv"                : "uvma_${name}dp_in/src/obj/uvma_${name}_dp_in_cntxt.sv",
    "agent_basic/agent/src/obj/mon_trn.sv"              : "uvma_${name}dp_in/src/obj/uvma_${name}_dp_in_mon_trn.sv",
    "agent_basic/agent/src/seq/base_seq.sv"             : "uvma_${name}dp_in/src/seq/uvma_${name}_dp_in_base_seq.sv",
    "agent_basic/agent/src/seq/seq_item.sv"             : "uvma_${name}dp_in/src/seq/uvma_${name}_dp_in_seq_item.sv",
    "agent_basic/agent/src/seq/seq_lib.sv"              : "uvma_${name}dp_in/src/seq/uvma_${name}_dp_in_seq_lib.sv",
    "agent_basic/agent/src/constants.sv"                : "uvma_${name}dp_in/src/uvma_${name}_dp_in_constants.sv",
    "agent_basic/agent/src/if_chkr.sv"                  : "uvma_${name}dp_in/src/uvma_${name}_dp_in_if_chkr.sv",
    "agent_basic/agent/src/if.sv"                       : "uvma_${name}dp_in/src/uvma_${name}_dp_in_if.sv",
    "agent_basic/agent/src/macros.svh"                  : "uvma_${name}dp_in/src/uvma_${name}_dp_in_macros.svh",
    "agent_basic/agent/src/pkg.flist"                   : "uvma_${name}dp_in/src/uvma_${name}_dp_in_pkg.flist",
    "agent_basic/agent/src/pkg.flist.xsim"              : "uvma_${name}dp_in/src/uvma_${name}_dp_in_pkg.flist.xsim",
    "agent_basic/agent/src/pkg.sv"                      : "uvma_${name}dp_in/src/uvma_${name}_dp_in_pkg.sv",
    "agent_basic/agent/src/tdefs.sv"                    : "uvma_${name}dp_in/src/uvma_${name}_dp_in_tdefs.sv",
    "agent_basic/agent/gitignore"                       : "uvma_${name}dp_in/.gitignore",
    "agent_basic/agent/ip.yml"                          : "uvma_${name}dp_in/ip.yml",
    "LICENSE_solderpad_v2p1.md"                         : "uvma_${name}dp_in/LICENSE.md",
    "agent_basic/agent/README.md"                       : "uvma_${name}dp_in/README.md",
    
    "agent_basic/agent/bin/package.py"                  : "uvma_${name}dp_out/bin/package.py",
    "agent_basic/agent/docs/agent_block_diagram.svg"    : "uvma_${name}dp_out/docs/agent_block_diagram.svg",
    "agent_basic/agent/examples/instantiation.sv"       : "uvma_${name}dp_out/examples/instantiation.sv",
    "agent_basic/agent/examples/sequence.sv"            : "uvma_${name}dp_out/examples/sequence.sv",
    "agent_basic/agent/src/comps/agent.sv"              : "uvma_${name}dp_out/src/comps/uvma_${name}_dp_out_agent.sv",
    "agent_basic/agent/src/comps/cov_model.sv"          : "uvma_${name}dp_out/src/comps/uvma_${name}_dp_out_cov_model.sv",
    "agent_basic/agent/src/comps/drv.sv"                : "uvma_${name}dp_out/src/comps/uvma_${name}_dp_out_drv.sv",
    "agent_basic/agent/src/comps/logger.sv"             : "uvma_${name}dp_out/src/comps/uvma_${name}_dp_out_logger.sv",
    "agent_basic/agent/src/comps/mon.sv"                : "uvma_${name}dp_out/src/comps/uvma_${name}_dp_out_mon.sv",
    "agent_basic/agent/src/comps/sqr.sv"                : "uvma_${name}dp_out/src/comps/uvma_${name}_dp_out_sqr.sv",
    "agent_basic/agent/src/obj/cfg.sv"                  : "uvma_${name}dp_out/src/obj/uvma_${name}_dp_out_cfg.sv",
    "agent_basic/agent/src/obj/cntxt.sv"                : "uvma_${name}dp_out/src/obj/uvma_${name}_dp_out_cntxt.sv",
    "agent_basic/agent/src/obj/mon_trn.sv"              : "uvma_${name}dp_out/src/obj/uvma_${name}_dp_out_mon_trn.sv",
    "agent_basic/agent/src/seq/base_seq.sv"             : "uvma_${name}dp_out/src/seq/uvma_${name}_dp_out_base_seq.sv",
    "agent_basic/agent/src/seq/seq_item.sv"             : "uvma_${name}dp_out/src/seq/uvma_${name}_dp_out_seq_item.sv",
    "agent_basic/agent/src/seq/seq_lib.sv"              : "uvma_${name}dp_out/src/seq/uvma_${name}_dp_out_seq_lib.sv",
    "agent_basic/agent/src/constants.sv"                : "uvma_${name}dp_out/src/uvma_${name}_dp_out_constants.sv",
    "agent_basic/agent/src/if_chkr.sv"                  : "uvma_${name}dp_out/src/uvma_${name}_dp_out_if_chkr.sv",
    "agent_basic/agent/src/if.sv"                       : "uvma_${name}dp_out/src/uvma_${name}_dp_out_if.sv",
    "agent_basic/agent/src/macros.svh"                  : "uvma_${name}dp_out/src/uvma_${name}_dp_out_macros.svh",
    "agent_basic/agent/src/pkg.flist"                   : "uvma_${name}dp_out/src/uvma_${name}_dp_out_pkg.flist",
    "agent_basic/agent/src/pkg.flist.xsim"              : "uvma_${name}dp_out/src/uvma_${name}_dp_out_pkg.flist.xsim",
    "agent_basic/agent/src/pkg.sv"                      : "uvma_${name}dp_out/src/uvma_${name}_dp_out_pkg.sv",
    "agent_basic/agent/src/tdefs.sv"                    : "uvma_${name}dp_out/src/uvma_${name}_dp_out_tdefs.sv",
    "agent_basic/agent/gitignore"                       : "uvma_${name}dp_out/.gitignore",
    "agent_basic/agent/ip.yml"                          : "uvma_${name}dp_out/ip.yml",
    "LICENSE_solderpad_v2p1.md"                         : "uvma_${name}dp_out/LICENSE.md",
    "agent_basic/agent/README.md"                       : "uvma_${name}dp_out/README.md",
    
    "block/env/bin/package.py"                          : "uvme_${name}/bin/package.py",
    "block/env/docs/env_block_diagram.svg"              : "uvme_${name}/docs/env_block_diagram.svg",
    "block/env/examples/virtual_sequence.sv"            : "uvme_${name}/examples/virtual_sequence.sv",
    "block/env/src/comps/cov_model.sv"                  : "uvme_${name}/src/comps/uvme_${name}_cov_model.sv",
    "block/env/src/comps/env.sv"                        : "uvme_${name}/src/comps/uvme_${name}_env.sv",
    "block/env/src/comps/prd.sv"                        : "uvme_${name}/src/comps/uvme_${name}_prd.sv",
    "block/env/src/comps/vsqr.sv"                       : "uvme_${name}/src/comps/uvme_${name}_vsqr.sv",
    "block/env/src/obj/cfg.sv"                          : "uvme_${name}/src/obj/uvme_${name}_cfg.sv",
    "block/env/src/obj/cntxt.sv"                        : "uvme_${name}/src/obj/uvme_${name}_cntxt.sv",
    "block/env/src/seq/base_vseq.sv"                    : "uvme_${name}/src/seq/uvme_${name}_base_vseq.sv",
    "block/env/src/seq/rand_stim_vseq.sv"               : "uvme_${name}/src/seq/uvme_${name}_rand_stim_vseq.sv",
    "block/env/src/seq/vseq_lib.sv"                     : "uvme_${name}/src/seq/uvme_${name}_vseq_lib.sv",
    "block/env/src/chkr.sv"                             : "uvme_${name}/src/uvme_${name}_chkr.sv",
    "block/env/src/constants.sv"                        : "uvme_${name}/src/uvme_${name}_constants.sv",
    "block/env/src/macros.svh"                          : "uvme_${name}/src/uvme_${name}_macros.svh",
    "block/env/src/pkg.flist"                           : "uvme_${name}/src/uvme_${name}_pkg.flist",
    "block/env/src/pkg.flist.xsim"                      : "uvme_${name}/src/uvme_${name}_pkg.flist.xsim",
    "block/env/src/pkg.sv"                              : "uvme_${name}/src/uvme_${name}_pkg.sv",
    "block/env/src/tdefs.sv"                            : "uvme_${name}/src/uvme_${name}_tdefs.sv",
    "block/env/gitignore"                               : "uvme_${name}/.gitignore",
    "block/env/ip.yml"                                  : "uvme_${name}/ip.yml",
    "LICENSE_solderpad_v2p1.md"                         : "uvme_${name}/LICENSE.md",
    "block/env/README.md"                               : "uvme_${name}/README.md",
    
    "block/tb/bin/package.py"                           : "uvmt_${name}/bin/package.py",
    "block/tb/docs/tb_block_diagram.svg"                : "uvmt_${name}/docs/tb_block_diagram.svg",
    "block/tb/examples/test.sv"                         : "uvmt_${name}/examples/test.sv",
    "block/tb/src/tb/dut_chkr.sv"                       : "uvmt_${name}/src/tb/uvmt_${name}_dut_chkr.sv",
    "block/tb/src/tb/dut_wrap.sv"                       : "uvmt_${name}/src/tb/uvmt_${name}_dut_wrap.sv",
    "block/tb/src/tb/tb.sv"                             : "uvmt_${name}/src/tb/uvmt_${name}_tb.sv",
    "block/tb/src/tests/base_test_workarounds.sv"       : "uvmt_${name}/src/tests/uvmt_${name}_base_test_workarounds.sv",
    "block/tb/src/tests/base_test.sv"                   : "uvmt_${name}/src/tests/uvmt_${name}_base_test.sv",
    "block/tb/src/tests/rand_stim_test.sv"              : "uvmt_${name}/src/tests/uvmt_${name}_rand_stim_test.sv",
    "block/tb/src/tests/test_cfg.sv"                    : "uvmt_${name}/src/tests/uvmt_${name}_test_cfg.sv",
    "block/tb/src/constants.sv"                         : "uvmt_${name}/src/uvmt_${name}_constants.sv",
    "block/tb/src/macros.svh"                           : "uvmt_${name}/src/uvmt_${name}_macros.svh",
    "block/tb/src/pkg.flist"                            : "uvmt_${name}/src/uvmt_${name}_pkg.flist",
    "block/tb/src/pkg.flist.xsim"                       : "uvmt_${name}/src/uvmt_${name}_pkg.flist.xsim",
    "block/tb/src/pkg.sv"                               : "uvmt_${name}/src/uvmt_${name}_pkg.sv",
    "block/tb/src/tdefs.sv"                             : "uvmt_${name}/src/uvmt_${name}_tdefs.sv",
    "block/tb/gitignore"                                : "uvmt_${name}/.gitignore",
    "block/tb/ip.yml"                                   : "uvmt_${name}/ip.yml",
    "LICENSE_solderpad_v2p1.md"                         : "uvmt_${name}/LICENSE.md",
    "block/tb/README.md"                                : "uvmt_${name}/README.md"
}

directories = [
    "uvma_${name}_cp",
    "uvma_${name}_cp/bin",
    "uvma_${name}_cp/docs",
    "uvma_${name}_cp/examples",
    "uvma_${name}_cp/src",
    "uvma_${name}_cp/src/comps",
    "uvma_${name}_cp/src/obj",
    "uvma_${name}_cp/src/seq",
    "uvma_${name}_dp_in",
    "uvma_${name}_dp_in/bin",
    "uvma_${name}_dp_in/docs",
    "uvma_${name}_dp_in/examples",
    "uvma_${name}_dp_in/src",
    "uvma_${name}_dp_in/src/comps",
    "uvma_${name}_dp_in/src/obj",
    "uvma_${name}_dp_in/src/seq"
    "uvma_${name}_dp_out",
    "uvma_${name}_dp_out/bin",
    "uvma_${name}_dp_out/docs",
    "uvma_${name}_dp_out/examples",
    "uvma_${name}_dp_out/src",
    "uvma_${name}_dp_out/src/comps",
    "uvma_${name}_dp_out/src/obj",
    "uvma_${name}_dp_out/src/seq"
    "uvme_${name}",
    "uvme_${name}/bin",
    "uvme_${name}/docs",
    "uvme_${name}/examples",
    "uvme_${name}/src",
    "uvme_${name}/src/comps",
    "uvme_${name}/src/obj",
    "uvme_${name}/src/seq",
    "uvmt_${name}",
    "uvmt_${name}/bin",
    "uvmt_${name}/docs",
    "uvmt_${name}/examples",
    "uvmt_${name}/src",
    "uvmt_${name}/src/tb",
    "uvmt_${name}/src/tests"
]


########################################################################################################################
# MAIN
########################################################################################################################
def process_file(path, file_path_template):
    if dbg:
        print("Processing file " + path + " with path template " + file_path_template)
    
    if not dbg:
        fin = open(relative_path_to_template + path, "rt")
    
    fout_path = file_path_template
    for param in parameters:
        fout_path = fout_path.replace("${" + param + "}", str(parameters[param]))
    fout_path = out_path + "/" + fout_path
    if dbg:
        print("Templated path: " + fout_path)
    else:
        fout = open(fout_path, "w+")
        data = fin.read()
    
    for param in parameters:
        if dbg:
            print("Replacing string '${" + param + "}' with '" + str(parameters[param]) + "'")
        else:
            data = data.replace("${" + param + "}", str(parameters[param]))
    
    if not dbg:
        fin.close()
        print("Writing " + fout_path)
        fout.write(data)
        fout.close()
    
def process_all_files():
    for file in files:
        process_file(file, files[file])

def create_directories():
    for dir in directories:
        dir_name = out_path + "/" + dir
        for param in parameters:
            dir_name = dir_name.replace("${" + param + "}", str(parameters[param]))
        if dbg:
            print("Creating directory '" + dir_name + "'")
        else:
            os.mkdir(dir_name)

def pick_out_path():
    global out_path
    global default_copyright_owner
    if len(sys.argv) > 1:
        out_path = sys.argv[1]
        print("Code will be output to " + out_path)
    if len(sys.argv) > 2:
        default_copyright_owner = sys.argv[2].replace('"', "")
        print("Default copyright owner is " + default_copyright_owner)

def prompt_user_values():
    global out_path
    global name
    global name_normal_case
    global name_of_copyright_owner
    global default_copyright_owner
    global parameters
    
    print("Moore.io Template Generator: RTL Block UVM DV Combo (v1p0)")
    print("******************************************************************")
    print("The answers to the following questionnaire will be used to generate the code for your new UVM Agent")
    print("")
    
    if out_path == "":
        out_path = input("Please enter the destination path (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    name_of_copyright_owner = input("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    
    license = input("Please enter a usage license or hit RETURN for the default (default is '" + default_license + "'):\n").strip()
    if license == "":
        license = default_license
    
    name = input("Please enter the package name for this block (ex: 'apb'); this name will be used for all UVM types (ex: 'uvma_apb_cp_agent_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    
    name_normal_case = input("Please enter the (descriptive) name for this block (ex: 'Advanced Peripheral Bus (APB)'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    
    parameters = {
    "name"                    : name,
    "name_uppercase"          : name.upper(),
    "name_normal_case"        : name_normal_case + " Block",
    "name_of_copyright_owner" : name_of_copyright_owner,
    "license"                 : license,
    "year"                    : date.today().year
}


def print_end_message():
    print("Code successfully generated")


########################################################################################################################
# ENTRY POINT
########################################################################################################################
pick_out_path()
prompt_user_values()
create_directories()
process_all_files()
print_end_message()
