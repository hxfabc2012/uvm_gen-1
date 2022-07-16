#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved.
########################################################################################################################


# 0. Remove old code
rm -rf ../../dv/uvml_math
rm -rf ../../dv/uvmt_misc_st/src/tests/uvmt_misc_st_my_comp.sv
rm -rf ../../dv/uvmt_misc_st/src/tests/uvmt_misc_st_my_obj.sv
rm -rf ../../dv/uvmt_misc_st/src/tests/uvmt_misc_st_reg_adapter.sv
rm -rf ../../dv/uvmt_misc_st/src/tests/uvmt_misc_st_status_reg.sv
rm -rf ../../dv/uvmt_misc_st/src/tests/uvmt_misc_st_top_reg_block.sv
rm -rf ../../dv/uvmt_misc_st/src/tests/uvmt_misc_st_smoke_test.sv
rm -rf ../../dv/uvmt_misc_st/src/seq/uvmt_misc_st_traffic_seq.sv
rm -rf ../../dv/uvmt_misc_st/src/seq/uvmt_misc_st_mstr_seq_lib.sv
rm -rf ../../dv/uvmt_misc_st/src/seq/uvmt_misc_st_basic_access_vseq.sv
rm -rf ../../dv/uvmt_misc_st/src/seq/uvmt_misc_st_cpu_vseq_lib.sv


# 1. Create code from spec files
cat ./tests/data/lib.spec | ./src/new_lib.py ../../dv/
./src/new.py component   -f ./tests/data/component.spec   -o ../../dv/uvmt_misc_st/src/tests
./src/new.py object      -f ./tests/data/object.spec      -o ../../dv/uvmt_misc_st/src/tests
./src/new.py reg_adapter -f ./tests/data/reg_adapter.spec -o ../../dv/uvmt_misc_st/src/tests
./src/new.py reg         -f ./tests/data/reg.spec         -o ../../dv/uvmt_misc_st/src/tests
./src/new.py reg_block   -f ./tests/data/reg_block.spec   -o ../../dv/uvmt_misc_st/src/tests
./src/new.py seq         -f ./tests/data/seq.spec         -o ../../dv/uvmt_misc_st/src/seq
./src/new.py seq_lib     -f ./tests/data/seq_lib.spec     -o ../../dv/uvmt_misc_st/src/seq
./src/new.py test        -f ./tests/data/test.spec        -o ../../dv/uvmt_misc_st/src/tests
./src/new.py vseq        -f ./tests/data/vseq.spec        -o ../../dv/uvmt_misc_st/src/seq
./src/new.py vseq_lib    -f ./tests/data/vseq_lib.spec    -o ../../dv/uvmt_misc_st/src/seq

# 2. Simulate
cd ../../sim
shopt -s expand_aliases
source ~/.bashrc
mio install uvmt_misc_st -u admin -p Qc5SgRpk6cjsAjr
mio cpel    uvmt_misc_st
mio sim     uvmt_misc_st -t smoke -s 1

# 3. Gather sim results
mio results uvmt_misc_st misc
