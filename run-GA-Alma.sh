#!/bin/bash

source ~/.bashrc

userCWD="$(pwd)"
shared_path=$(cat /data/rds/DIT/SCICOM/SCRSE/shared/apps/GreenAlgorithms4HPC/shared_path.txt)

cd "${shared_path}apps/GreenAlgorithms4HPC/"

mamba activate "${shared_path}conda/GA_env"
python3 "${shared_path}apps/GreenAlgorithms4HPC/__init__.py" "$@" --userCWD "$userCWD"
mamba deactivate