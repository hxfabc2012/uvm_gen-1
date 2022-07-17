#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved.
########################################################################################################################


shopt -s expand_aliases
source ~/.bashrc


# 0. Remove old code
rm -rf ../../dv/uvma_ab ../../dv/uvme_ab_st ../../dv/uvmt_ab_st

# 1. Generate code
cat ./tests/data/agent_basic.spec | ./src/new_agent_basic.py  ../../dv

# 2. Simulate
cd ../../sim
mio install uvmt_ab_st -u admin -p Qc5SgRpk6cjsAjr
mio cpel    uvmt_ab_st
mio sim     uvmt_ab_st -t rand_stim -s 1

# 3. Gather sim results
mio results uvmt_ab_st agent_basic
