#!/usr/bin/python3
########################################################################################################################
# Copyright 2021 Datum Technology Corporation
########################################################################################################################
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################
# Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
# with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
#                                       https://solderpad.org/licenses/SHL-2.1/
# Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
########################################################################################################################


########################################################################################################################
# IMPORTS
########################################################################################################################
from datetime import date
import os
import sys


########################################################################################################################
# GLOBALS
########################################################################################################################
dbg = False
relative_path_to_template = os.getcwd() + "/templates/env_st/"
out_path = ""
default_copyright_owner = ""
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
    "bin/package.py"                      : "uvme_${name}_st/bin/package.py",
    "docs/env_block_diagram.svg"          : "uvme_${name}_st/docs/env_block_diagram.svg",
    "examples/virtual_sequence.sv"        : "uvme_${name}_st/examples/virtual_sequence.sv",
    "src/comps/cov_model.sv"              : "uvme_${name}_st/src/comps/uvme_${name}_st_cov_model.sv",
    "src/comps/env.sv"                    : "uvme_${name}_st/src/comps/uvme_${name}_st_env.sv",
    "src/comps/prd.sv"                    : "uvme_${name}_st/src/comps/uvme_${name}_st_prd.sv",
    "src/comps/vsqr.sv"                   : "uvme_${name}_st/src/comps/uvme_${name}_st_vsqr.sv",
    "src/obj/cfg.sv"                      : "uvme_${name}_st/src/obj/uvme_${name}_st_cfg.sv",
    "src/obj/cntxt.sv"                    : "uvme_${name}_st/src/obj/uvme_${name}_st_cntxt.sv",
    "src/seq/base_vseq.sv"                : "uvme_${name}_st/src/seq/uvme_${name}_st_base_vseq.sv",
    "src/seq/vseq_lib.sv"                 : "uvme_${name}_st/src/seq/uvme_${name}_st_vseq_lib.sv",
    "src/chkr.sv"                         : "uvme_${name}_st/src/uvme_${name}_st_chkr.sv",
    "src/constants.sv"                    : "uvme_${name}_st/src/uvme_${name}_st_constants.sv",
    "src/macros.sv"                       : "uvme_${name}_st/src/uvme_${name}_st_macros.sv",
    "src/pkg.flist"                       : "uvme_${name}_st/src/uvme_${name}_st_pkg.flist",
    "src/pkg.flist.xsim"                  : "uvme_${name}_st/src/uvme_${name}_st_pkg.flist.xsim",
    "src/pkg.sv"                          : "uvme_${name}_st/src/uvme_${name}_st_pkg.sv",
    "src/tdefs.sv"                        : "uvme_${name}_st/src/uvme_${name}_st_tdefs.sv",
    ".gitignore"                          : "uvme_${name}_st/.gitignore",
    "ip.yml"                              : "uvme_${name}/ip.yml",
    "../LICENSE_solderpad_v2p1.md"        : "uvme_${name}_st/LICENSE.md",
    "README.md"                           : "uvme_${name}_st/README.md"
}

directories = [
    "uvme_${name}_st",
    "uvme_${name}_st/bin",
    "uvme_${name}_st/docs",
    "uvme_${name}_st/examples",
    "uvme_${name}_st/src",
    "uvme_${name}_st/src/comps",
    "uvme_${name}_st/src/obj",
    "uvme_${name}_st/src/seq"
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
    global reset_agent_type
    global name_of_copyright_owner
    global default_copyright_owner
    global parameters
    
    print("Moore.io Template Generator: UVM Environment - Self-Testing (ST) (v1p0)")
    print("***********************************************************************")
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
    
    name = input("Please enter the name of the Agent for this Self-Testing Environment (ex: 'apb'); this name will be used for all Environment types (ex: 'uvme_apb_st_env_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    name_normal_case = input("Please enter the (descriptive) name for this Agent (ex: 'Advanced Peripheral Bus (APB)'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    else:
        parameters["name_normal_case"] = name_normal_case
    
    name_1 = input("Please enter the name for the first Agent instance (default: 'mstr'):\n").strip()
    if name_1 == "":
        parameters["name_1"] = "mstr"
    else:
        parameters["name_1"] = name_1
    
    name_2 = input("Please enter the name for the second Agent instance (default: 'slv'):\n").strip()
    if name_2 == "":
        parameters["name_2"] = "slv"
    else:
        parameters["name_2"] = name_2
    


########################################################################################################################
# ENTRY POINT
########################################################################################################################
pick_out_path()
prompt_user_values()
create_directories()
process_all_files()
