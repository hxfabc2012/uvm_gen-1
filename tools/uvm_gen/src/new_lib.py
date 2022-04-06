#!/usr/bin/python3
########################################################################################################################
# Copyright 2022 Datum Technology Corporation
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
uvm_gen_dir = re.sub("new_lib.py", "", os.path.realpath(__file__)) + ".."
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
    "lib/bin/package.py"               : "uvml_${name}/bin/package.py",
    "lib/examples/component.sv"        : "uvml_${name}/examples/component.sv",
    "lib/examples/object.sv"           : "uvml_${name}/examples/object.sv",
    "lib/src/constants.sv"             : "uvml_${name}/src/uvml_${name}_constants.sv",
    "lib/src/macros.svh"               : "uvml_${name}/src/uvml_${name}_macros.svh",
    "lib/src/pkg.flist"                : "uvml_${name}/src/uvml_${name}_pkg.flist",
    "lib/src/pkg.flist.xsim"           : "uvml_${name}/src/uvml_${name}_pkg.flist.xsim",
    "lib/src/pkg.sv"                   : "uvml_${name}/src/uvml_${name}_pkg.sv",
    "lib/src/tdefs.sv"                 : "uvml_${name}/src/uvml_${name}_tdefs.sv",
    "lib/gitignore"                    : "uvml_${name}/.gitignore",
    "lib/ip.yml"                       : "uvml_${name}/ip.yml",
    #"LICENSE_solderpad_v2p1.md"        : "uvml_${name}/LICENSE.md",
    "lib/README.md"                    : "uvml_${name}/README.md"
}

directories = [
    "uvml_${name}",
    "uvml_${name}/bin",
    "uvml_${name}/examples",
    "uvml_${name}/src"
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
    
    print("Moore.io Template Generator: UVM Library (v1p1)")
    print("***********************************************************************")
    print("The answers to the following questionnaire will be used to generate the code for your new UVM Library")
    print("")
    
    if out_path == "":
        out_path = input("Please enter the destination path for this new Library (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    
    name_of_copyright_owner = input("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    
    license = input("Please enter a usage license or hit RETURN for the default (default is '" + default_license + "'):\n").strip()
    if license == "":
        license = default_license
    
    name = input("Please enter the name of this new Library (ex: 'math'); this name will be used for all Library types (ex: 'uvml_math_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    
    name_normal_case = input("Please enter the (descriptive) name for this new Library (ex: 'Mathematical Objects'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    
    parameters = {
        "name_normal_case"        : name_normal_case,
        "name"                    : name,
        "name_uppercase"          : name.upper(),
        "year"                    : date.today().year,
        "name_of_copyright_owner" : name_of_copyright_owner,
        "license"                 : license
    }


########################################################################################################################
# ENTRY POINT
########################################################################################################################
pick_out_path()
prompt_user_values()
create_directories()
process_all_files()
