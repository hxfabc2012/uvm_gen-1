#! /bin/bash
########################################################################################################################
# Copyright 2022 Datum Technology Corporation
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# 1. Create code from spec files
cat ./tests/data/block.spec | ./src/new_block.py ../../dv/

# 2. Simulate
cd ../../sim
./setup_project.py
source ./setup_terminal.sh
../tools/.imports/mio/src/mio.py cpel uvmt_block
../tools/.imports/mio/src/mio.py sim  uvmt_block -t rand_stim -s 1

# 3. Gather sim results
../tools/.imports/mio/src/mio.py results uvmt_block tb_block
