#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved.
########################################################################################################################


shopt -s expand_aliases
source ~/.bashrc


# 0. Remove old code
rm -rf ../../dv/uvme_ss ../../dv/uvmt_ss

# 1. Create code from spec files
cat ./tests/data/ss.spec | ./src/new_ss.py ../../dv/

# 2. Simulate
cd ../../sim
mio install uvmt_ss -u admin -p Qc5SgRpk6cjsAjr
mio cpel    uvmt_ss
mio sim     uvmt_ss -t base -s 1

# 3. Gather sim results
mio results uvmt_ss ss_tb
