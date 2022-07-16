#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved.
########################################################################################################################


shopt -s expand_aliases
source ~/.bashrc


# 0. Remove old code
rm -rf ../../dv/uvma_block_cp ../../dv/uvma_block_dp_in ../../dv/uvma_block_dp_out ../../dv/uvme_block ../../dv/uvmt_block

# 1. Create code from spec files
cat ./tests/data/block.spec | ./src/new_block.py ../../dv/

# 2. Simulate
cd ../../sim
mio install uvmt_block -u admin -p Qc5SgRpk6cjsAjr
mio cpel uvmt_block
mio sim  uvmt_block -t rand_stim -s 1

# 3. Gather sim results
mio results uvmt_block block_tb
