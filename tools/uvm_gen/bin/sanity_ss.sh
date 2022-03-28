#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
########################################################################################################################
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# 1. Create code from spec files
cat ./tests/ss.spec | ./src/new_ss.py ../../dv/

# 2. Simulate
cd ../../sim
./setup_project.py
source ./setup_terminal.sh
../tools/.imports/mio/src/mio.py cpel uvmt_ss
../tools/.imports/mio/src/mio.py sim  uvmt_ss -t base -s 1

# 3. Gather sim results
../tools/.imports/mio/src/mio.py results uvmt_ss tb_ss
