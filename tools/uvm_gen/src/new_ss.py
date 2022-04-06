#!/usr/bin/python3
########################################################################################################################
# Copyright 2022 Datum Technology Corporation
# All rights reserved.
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
uvm_gen_dir = re.sub("new_ss.py", "", os.path.realpath(__file__)) + ".."
relative_path_to_template = uvm_gen_dir + "/templates/"
out_path = ""
default_copyright_owner = "Contributors"
default_license = "SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1"
name_of_copyright_owner = ""
name = ""
name_normal_case = ""
clk_agent_name = ""
clk_agent_type = ""
ral_agent_name = ""
ral_agent_type = ""
reset_agent_name = ""
reset_agent_type = ""


########################################################################################################################
# TEMPLATE DATA
########################################################################################################################
parameters = {
    "name"                    : "",
    "name_uppercase"          : "",
    "name_normal_case"        : "",
    "name_of_copyright_owner" : "",
}

files = {
    #              SRC                                 DST
    "ss/env/bin/package.py"                           : "uvme_${name}/bin/package.py",
    "ss/env/docs/env_block_diagram.svg"               : "uvme_${name}/docs/env_block_diagram.svg",
    "ss/env/examples/instantiation.sv"                : "uvme_${name}/examples/instantiation.sv",
    "ss/env/examples/virtual_sequence.sv"             : "uvme_${name}/examples/virtual_sequence.sv",
    "ss/env/src/comps/cov_model.sv"                   : "uvme_${name}/src/comps/uvme_${name}_cov_model.sv",
    "ss/env/src/comps/env.sv"                         : "uvme_${name}/src/comps/uvme_${name}_env.sv",
    "ss/env/src/comps/prd.sv"                         : "uvme_${name}/src/comps/uvme_${name}_prd.sv",
    "ss/env/src/comps/sb.sv"                          : "uvme_${name}/src/comps/uvme_${name}_sb.sv",
    "ss/env/src/comps/vsqr.sv"                        : "uvme_${name}/src/comps/uvme_${name}_vsqr.sv",
    "ss/env/src/obj/cfg.sv"                           : "uvme_${name}/src/obj/uvme_${name}_cfg.sv",
    "ss/env/src/obj/cntxt.sv"                         : "uvme_${name}/src/obj/uvme_${name}_cntxt.sv",
    "ss/env/src/reg/reg_block.sv"                     : "uvme_${name}/src/reg/uvme_${name}_reg_block.sv",
    "ss/env/src/seq/base_vseq.sv"                     : "uvme_${name}/src/seq/uvme_${name}_base_vseq.sv",
    "ss/env/src/seq/clk_vseq.sv"                      : "uvme_${name}/src/seq/uvme_${name}_${clk_agent_name}_vseq.sv",
    "ss/env/src/seq/reg_base_vseq.sv"                 : "uvme_${name}/src/seq/uvme_${name}_reg_base_vseq.sv",
    "ss/env/src/seq/reg_base_vseq_ignore_list.sv"     : "uvme_${name}/src/seq/uvme_${name}_reg_base_vseq_ignore_list.sv",
    "ss/env/src/seq/reg_bit_bash_vseq.sv"             : "uvme_${name}/src/seq/uvme_${name}_reg_bit_bash_vseq.sv",
    "ss/env/src/seq/reg_bit_bash_vseq_ignore_list.sv" : "uvme_${name}/src/seq/uvme_${name}_reg_bit_bash_vseq_ignore_list.sv",
    "ss/env/src/seq/reg_hw_reset_vseq.sv"             : "uvme_${name}/src/seq/uvme_${name}_reg_hw_reset_vseq.sv",
    "ss/env/src/seq/reg_hw_reset_vseq_ignore_list.sv" : "uvme_${name}/src/seq/uvme_${name}_reg_hw_reset_vseq_ignore_list.sv",
    "ss/env/src/seq/reset_vseq.sv"                    : "uvme_${name}/src/seq/uvme_${name}_${reset_agent_name}_vseq.sv",
    "ss/env/src/seq/vseq_lib.sv"                      : "uvme_${name}/src/seq/uvme_${name}_vseq_lib.sv",
    "ss/env/src/chkr.sv"                              : "uvme_${name}/src/uvme_${name}_chkr.sv",
    "ss/env/src/constants.sv"                         : "uvme_${name}/src/uvme_${name}_constants.sv",
    "ss/env/src/macros.svh"                           : "uvme_${name}/src/uvme_${name}_macros.svh",
    "ss/env/src/pkg.flist"                            : "uvme_${name}/src/uvme_${name}_pkg.flist",
    "ss/env/src/pkg.flist.xsim"                       : "uvme_${name}/src/uvme_${name}_pkg.flist.xsim",
    "ss/env/src/pkg.sv"                               : "uvme_${name}/src/uvme_${name}_pkg.sv",
    "ss/env/src/tdefs.sv"                             : "uvme_${name}/src/uvme_${name}_tdefs.sv",
    "gitignore"                                       : "uvme_${name}/.gitignore",
    "ss/env/ip.yml"                                   : "uvme_${name}/ip.yml",
    #"LICENSE_solderpad_v2p1.md"                       : "uvme_${name}/LICENSE.md",
    "ss/env/README.md"                                : "uvme_${name}/README.md",
    "ss/tb/bin/package.py"                            : "uvmt_${name}/bin/package.py",
    "ss/tb/docs/tb_block_diagram.svg"                 : "uvmt_${name}/docs/tb_block_diagram.svg",
    "ss/tb/examples/test.sv"                          : "uvmt_${name}/examples/test.sv",
    "ss/tb/src/tb/probe_if.sv"                        : "uvmt_${name}/src/tb/uvmt_${name}_probe_if.sv",
    "ss/tb/src/tb/dut_chkr.sv"                        : "uvmt_${name}/src/tb/uvmt_${name}_dut_chkr.sv",
    "ss/tb/src/tb/dut_wrap.sv"                        : "uvmt_${name}/src/tb/uvmt_${name}_dut_wrap.sv",
    "ss/tb/src/tb/tb.sv"                              : "uvmt_${name}/src/tb/uvmt_${name}_tb.sv",
    "ss/tb/src/tests/reg_base_test.sv"                : "uvmt_${name}/src/tests/uvmt_${name}_reg_base_test.sv",
    "ss/tb/src/tests/reg_bit_bash_test.sv"            : "uvmt_${name}/src/tests/uvmt_${name}_reg_bit_bash_test.sv",
    "ss/tb/src/tests/reg_hw_reset_test.sv"            : "uvmt_${name}/src/tests/uvmt_${name}_reg_hw_reset_test.sv",
    "ss/tb/src/tests/base_test_workarounds.sv"        : "uvmt_${name}/src/tests/uvmt_${name}_base_test_workarounds.sv",
    "ss/tb/src/tests/base_test.sv"                    : "uvmt_${name}/src/tests/uvmt_${name}_base_test.sv",
    "ss/tb/src/tests/test_cfg.sv"                     : "uvmt_${name}/src/tests/uvmt_${name}_test_cfg.sv",
    "ss/tb/src/constants.sv"                          : "uvmt_${name}/src/uvmt_${name}_constants.sv",
    "ss/tb/src/macros.svh"                            : "uvmt_${name}/src/uvmt_${name}_macros.svh",
    "ss/tb/src/pkg.flist"                             : "uvmt_${name}/src/uvmt_${name}_pkg.flist",
    "ss/tb/src/pkg.flist.xsim"                        : "uvmt_${name}/src/uvmt_${name}_pkg.flist.xsim",
    "ss/tb/src/pkg.sv"                                : "uvmt_${name}/src/uvmt_${name}_pkg.sv",
    "ss/tb/src/tdefs.sv"                              : "uvmt_${name}/src/uvmt_${name}_tdefs.sv",
    "gitignore"                                       : "uvmt_${name}/.gitignore",
    "ss/tb/ip.yml"                                    : "uvmt_${name}/ip.yml",
    #"LICENSE_solderpad_v2p1.md"                       : "uvmt_${name}/LICENSE.md",
    "ss/tb/README.md"                                 : "uvmt_${name}/README.md"
}

directories = [
    "uvme_${name}",
    "uvme_${name}/bin",
    "uvme_${name}/docs",
    "uvme_${name}/examples",
    "uvme_${name}/src",
    "uvme_${name}/src/comps",
    "uvme_${name}/src/obj",
    "uvme_${name}/src/reg",
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
    global clk_agent_name
    global clk_agent_type
    global ral_agent_name
    global ral_agent_type
    global reset_agent_name
    global reset_agent_type
    global name_of_copyright_owner
    global default_copyright_owner
    global parameters
    
    print("Moore.io Template Generator: UVM Environment - Sub-System (SS) (v1p0)")
    print("*********************************************************************")
    print("The answers to the following questionnaire will be used to generate the code for your new UVM Environment")
    print("")
    
    if out_path == "":
        out_path = input("Please enter the destination path for this new agent (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "name"          : name,
        "name_uppercase": name.upper(),
        "year"          : date.today().year
    }
    
    name_of_copyright_owner = input("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    license = input("Please enter a usage license or hit RETURN for the default (default is '" + default_license + "'):\n").strip()
    if license == "":
        license = default_license
    parameters["license"] = license
    
    name = input("Please enter the package name for this Environment (ex: 'dp'); this name will be used for all Environment types (ex: 'uvme_dp_env_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    name_normal_case = input("Please enter the (descriptive) name for this Environment (ex: 'Data Plane'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    else:
        parameters["name_normal_case"] = name_normal_case
    
    clk_agent_name = input("Please enter the name of the Clock Agent (default: 'sys_clk'):\n").strip()
    if clk_agent_name == "":
        parameters["clk_agent_name"] = "sys_clk"
        parameters["clk_agent_name_uppercase"] = "SYS_CLK"
    else:
        parameters["clk_agent_name"] = clk_agent_name
        parameters["clk_agent_name_uppercase"] = clk_agent_name.upper()
    
    reset_agent_name = input("Please enter the name of the Reset Agent (default: 'sys_reset'):\n").strip()
    if reset_agent_name == "":
        parameters["reset_agent_name"] = "sys_reset"
        parameters["reset_agent_name_uppercase"] = "SYS_RESET"
    else:
        parameters["reset_agent_name"] = reset_agent_name
        parameters["reset_agent_name_uppercase"] = reset_agent_name.upper()
    
    ral_agent_type = input("Please enter the type for the RAL Agent (default: 'axil'):\n").strip()
    if ral_agent_type == "":
        parameters["ral_agent_type"] = "axil"
        parameters["ral_agent_type_uppercase"] = "AXIL"
    else:
        parameters["ral_agent_type_uppercase"] = ral_agent_type
        parameters["ral_agent_type_uppercase"] = ral_agent_type.upper()
    
    ral_agent_name = input("Please enter the name of the RAL Agent (default: 'axil'):\n").strip()
    if ral_agent_name == "":
        parameters["ral_agent_name"] = "axil"
        parameters["ral_agent_name_uppercase"] = "AXIL"
    else:
        parameters["ral_agent_name"] = ral_agent_name
        parameters["ral_agent_name_uppercase"] = ral_agent_name.upper()
    


########################################################################################################################
# ENTRY POINT
########################################################################################################################
pick_out_path()
prompt_user_values()
create_directories()
process_all_files()
