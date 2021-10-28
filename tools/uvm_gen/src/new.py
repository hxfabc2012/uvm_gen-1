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


"""Moore.io UVM Singleton Generator
   Generates single files of UVM code.
Usage:
   new.py component   [<out_dir>] [<copyright_owner>]  # Invokes 'Component' generator
   new.py object      [<out_dir>] [<copyright_owner>]  # Invokes 'Object' generator
   new.py reg_adapter [<out_dir>] [<copyright_owner>]  # Invokes 'Register Adapter' generator
   new.py reg         [<out_dir>] [<copyright_owner>]  # Invokes 'Register' generator
   new.py reg_block   [<out_dir>] [<copyright_owner>]  # Invokes 'Register Block' generator
   new.py seq         [<out_dir>] [<copyright_owner>]  # Invokes 'Sequence' generator
   new.py seq_lib     [<out_dir>] [<copyright_owner>]  # Invokes 'Sequence Library' generator
   new.py test        [<out_dir>] [<copyright_owner>]  # Invokes 'Test' generator
   new.py vseq        [<out_dir>] [<copyright_owner>]  # Invokes 'Virtual Sequence' generator
   new.py vseq_lib    [<out_dir>] [<copyright_owner>]  # Invokes 'Virtual Sequence Library' generator
   new.py (-h | --help)                                # Prints this help message
   
Examples:
   mio component ~/my_proj/src                # Deletes latest artifacts for Default IP
   mio clean --all                            # Deletes all artifacts for Default IP
   mio clean my_ip my_other_ip --sim --lint   # Deletes sim and lint artifacts for 2 IPs
   mio clean * --force -slf                   # Delete sim, lint and formal artifacts for all IPs (with force)
   mio clean * --all                          # Delete all artifacts for all IPs
   mio clean * -AF                            # Delete all artifacts for all IPs, overriding all access rights!"""


########################################################################################################################
# IMPORTS
########################################################################################################################
from datetime import date
import os
import sys
from docopt import docopt


########################################################################################################################
# GLOBALS
########################################################################################################################
dbg = False
args = {}
relative_path_to_template = os.getcwd() + "/templates/"
out_path = ""
default_copyright_owner = ""
name_of_copyright_owner = ""
name = ""
name_normal_case = ""


########################################################################################################################
# TEMPLATE DATA
########################################################################################################################
files = {
    'component' : {
        'in' : 'component.sv',
        'out' : '${pkg_name}_${name}.sv'
    },
    'object' : {
        'in' : 'object.sv',
        'out' : '${pkg_name}_${name}.sv'
    },
    'reg_adapter' : {
        'in' : 'reg_adapter.sv',
        'out' : '${pkg_name}_reg_adapter.sv'
    },
    'reg_block' : {
        'in' : 'reg_block.sv',
        'out' : '${pkg_name}_${name}_reg_block.sv'
    },
    'reg' : {
        'in' : 'reg.sv',
        'out' : '${pkg_name}_${name}_reg.sv'
    },
    'seq_lib' : {
        'in' : 'seq_lib.sv',
        'out' : '${pkg_name}_${name}_seq_lib.sv'
    },
    'seq' : {
        'in' : 'seq.sv',
        'out' : '${pkg_name}_${name}_seq.sv'
    },
    'test' : {
        'in' : 'test.sv',
        'out' : 'uvmt_${pkg_name}_${name}_test.sv'
    },
    'vseq_lib' : {
        'in' : 'vseq_lib.sv',
        'out' : '${pkg_name}_${name}_vseq_lib.sv'
    },
    'vseq' : {
        'in' : 'vseq.sv',
        'out' : '${pkg_name}_${name}_vseq.sv'
    }
}


########################################################################################################################
# MAIN
########################################################################################################################
def process_file(parameters, path, file_path_template):
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

def pick_out_path():
    global args
    global out_path
    global default_copyright_owner
    if (args['<out_dir>']):
        out_path = args['<out_dir>']
        print("Code will be output to " + out_path)
    if (args['<copyright_owner>']):
        default_copyright_owner = args['<copyright_owner>']
        print("Default copyright owner is " + default_copyright_owner)

def gen_component():
    global out_path
    global default_copyright_owner
    
    print("Moore.io Template Generator: Component (v1p0)")
    
    if out_path == "":
        out_path = input("Please enter the destination path for this new agent\n").strip()
    
    name_of_copyright_owner = input("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = input("Please enter the package name for this Component (ex: 'my_comp'); this name will be used for all agent types (ex: 'uvma_pcie_agent_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    name_normal_case = input("Please enter the (descriptive) name for this agent (ex: 'PCI Express'):\n").strip()
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
def main():
    global args
    args = docopt(__doc__, version='Moore.io UVM Singleton Generator v1.0 Beta 0')
    
    pick_out_path()
    
    if (args['component']):
        gen_component()
    
    if (args['object']):
        gen_object()
    
    if (args['reg_adapter']):
        gen_reg_adapter()
    
    if (args['reg']):
        gen_reg()
    
    if (args['reg_block']):
        gen_reg_block()
    
    if (args['seq']):
        gen_seq()
    
    if (args['seq_lib']):
        gen_seq_lib()
    
    if (args['test']):
        gen_test()
    
    if (args['vseq']):
        gen_vseq()
    
    if (args['vseq_lib']):
        gen_vseq_lib()

main()
