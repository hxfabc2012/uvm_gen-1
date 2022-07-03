#! /bin/bash
########################################################################################################################
## Copyright {{ year }} {{ name_of_copyright_owner }}
## {{ license }}
########################################################################################################################


# Launched from uvml project sim dir
python ./setup_project.py
source ./setup_terminal.sh
../tools/.imports/mio/src/__main__.py cpel uvmt_{{ name }}_st
../tools/.imports/mio/src/__main__.py sim uvmt_{{ name }}_st -t reads -s 1 -c
../tools/.imports/mio/src/__main__.py sim uvmt_{{ name }}_st -t writes -s 1 -c
../tools/.imports/mio/src/__main__.py sim uvmt_{{ name }}_st -t all_access -s 1 -c
../tools/.imports/mio/src/__main__.py results uvmt_{{ name }}_st results
../tools/.imports/mio/src/__main__.py cov uvmt_{{ name }}_st
