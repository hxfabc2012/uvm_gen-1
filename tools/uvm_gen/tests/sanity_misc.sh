#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


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
./setup_project.py
source ./setup_terminal.sh
../tools/.imports/mio/src/__main__.py cpel uvmt_misc_st
../tools/.imports/mio/src/__main__.py sim uvmt_misc_st -t smoke -s 1

# 3. Gather sim results
../tools/.imports/mio/src/__main__.py results uvmt_misc_st misc
