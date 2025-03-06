#!/bin/bash

source ~/.bashrc

userCWD="$(pwd)"

if [ -d "GreenAlma" ]; then
    :
else
    mkdir GreenAlma
fi

cd "${shared_path}/apps/GreenAlgorithms4HPC/"

mamba activate "${shared_path}/conda/GA_env"
python3 "${shared_path}/apps/GreenAlgorithms4HPC/__init__.py" "$@" --userCWD "$userCWD"
mamba deactivate