#!/bin/bash

source /data/rds/DIT/SCICOM/SCRSE/shared/source/.mamba

userCWD="$(pwd)"

cd "${shared_path}/apps/GreenAlgorithms4HPC/"

mamba activate "${shared_path}/conda/GA_env"
python3 "${shared_path}/apps/GreenAlgorithms4HPC/__init__.py" "$@" --userCWD "$userCWD"
mamba deactivate