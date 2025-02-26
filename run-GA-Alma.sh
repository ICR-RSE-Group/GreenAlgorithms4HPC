#!/bin/bash

source ~/.bashrc

userCWD="$(pwd)"

[ -d GreenAlma ] || mkdir GreenAlma

cd "${shared_path}/apps/GreenAlgorithms4HPC/"

mamba activate "${shared_path}/conda/GA_env"
python3 "${shared_path}/apps/GreenAlgorithms4HPC/__init__.py" "$@" --userCWD "$userCWD"
mamba deactivate