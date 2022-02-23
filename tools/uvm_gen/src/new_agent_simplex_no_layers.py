#!/usr/bin/python3
########################################################################################################################
# Copyright 2022 Datum Technology Corporation
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
relative_path_to_template = os.getcwd() + "/templates/agent_simplex_no_layers/"
out_path = ""
default_copyright_owner = ""
name_of_copyright_owner = ""
name = ""
name_normal_case = ""


########################################################################################################################
# TEMPLATE DATA
########################################################################################################################
parameters = {
    "name"                    : "",
    "name_uppercase"          : "",
    "name_normal_case"        : "",
    "name_of_copyright_owner" : "",
    "year"                    : date.today().year
}

files = {
    #              SRC                                 DST
    "bin/package.py"               : "uvma_${name}/bin/package.py",
    "docs/agent_block_diagram.svg" : "uvma_${name}/docs/agent_block_diagram.svg",
    "examples/instantiation.sv"    : "uvma_${name}/examples/instantiation.sv",
    "examples/sequence.sv"         : "uvma_${name}/examples/sequence.sv",
    "src/comps/agent.sv"           : "uvma_${name}/src/comps/uvma_${name}_agent.sv",
    "src/comps/cov_model.sv"       : "uvma_${name}/src/comps/uvma_${name}_cov_model.sv",
    "src/comps/drv.sv"             : "uvma_${name}/src/comps/uvma_${name}_drv.sv",
    "src/comps/mon_trn_logger.sv"  : "uvma_${name}/src/comps/uvma_${name}_mon_trn_logger.sv",
    "src/comps/mon.sv"             : "uvma_${name}/src/comps/uvma_${name}_mon.sv",
    "src/comps/seq_item_logger.sv" : "uvma_${name}/src/comps/uvma_${name}_seq_item_logger.sv",
    "src/comps/sqr.sv"             : "uvma_${name}/src/comps/uvma_${name}_sqr.sv",
    "src/obj/cfg.sv"               : "uvma_${name}/src/obj/uvma_${name}_cfg.sv",
    "src/obj/cntxt.sv"             : "uvma_${name}/src/obj/uvma_${name}_cntxt.sv",
    "src/obj/mon_trn.sv"           : "uvma_${name}/src/obj/uvma_${name}_mon_trn.sv",
    "src/seq/base_seq.sv"          : "uvma_${name}/src/seq/uvma_${name}_base_seq.sv",
    "src/seq/seq_item.sv"          : "uvma_${name}/src/seq/uvma_${name}_seq_item.sv",
    "src/constants.sv"             : "uvma_${name}/src/uvma_${name}_constants.sv",
    "src/if_chkr.sv"               : "uvma_${name}/src/uvma_${name}_if_chkr.sv",
    "src/if.sv"                    : "uvma_${name}/src/uvma_${name}_if.sv",
    "src/macros.sv"                : "uvma_${name}/src/uvma_${name}_macros.sv",
    "src/pkg.flist"                : "uvma_${name}/src/uvma_${name}_pkg.flist",
    "src/pkg.flist.xsim"           : "uvma_${name}/src/uvma_${name}_pkg.flist.xsim",
    "src/pkg.sv"                   : "uvma_${name}/src/uvma_${name}_pkg.sv",
    "src/tdefs.sv"                 : "uvma_${name}/src/uvma_${name}_tdefs.sv",
    "gitignore"                    : "uvma_${name}/.gitignore",
    "ip.yml"                       : "uvma_${name}/ip.yml",
    "../LICENSE_solderpad_v2p1.md" : "uvma_${name}/LICENSE.md",
    "README.md"                    : "uvma_${name}/README.md"
}

directories = [
    "uvma_${name}",
    "uvma_${name}/bin",
    "uvma_${name}/docs",
    "uvma_${name}/examples",
    "uvma_${name}/src",
    "uvma_${name}/src/comps",
    "uvma_${name}/src/obj",
    "uvma_${name}/src/seq"
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
    
    print("Moore.io Template Generator: UVM Agent - Simplex, no layers (v1p0)")
    print("******************************************************************")
    print("The answers to the following questionnaire will be used to generate the code for your new UVM Agent")
    print("")
    
    if out_path == "":
        out_path = input("Please enter the destination path for this new agent (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    name_of_copyright_owner = input("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = input("Please enter the package name for this agent (ex: 'apb'); this name will be used for all agent types (ex: 'uvma_apb_agent_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    name_normal_case = input("Please enter the (descriptive) name for this agent (ex: 'Advanced Peripheral Bus (APB)'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    else:
        parameters["name_normal_case"] = name_normal_case
    
    parameters = {
    "name"                    : name,
    "name_uppercase"          : name.upper(),
    "name_normal_case"        : name_normal_case,
    "name_of_copyright_owner" : name_of_copyright_owner,
    "year"                    : date.today().year
}


########################################################################################################################
# ENTRY POINT
########################################################################################################################
pick_out_path()
prompt_user_values()
create_directories()
process_all_files()
