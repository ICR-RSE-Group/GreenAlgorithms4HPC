#!/bin/bash

### FILE FOR MAMBA ENVIRONMENT SET UP ON ALMA ###

shared_path=$(cat /data/rds/DIT/SCICOM/SCRSE/shared/apps/GreenAlgorithms4HPC/shared_path.txt)

source ~/.bashrc
mamba create --prefix "${shared_path}conda/GA_env" python=3.10 pandas numpy pyyaml jinja2 plotly 
mamba activate "${shared_path}conda/GA_env"
mamba deactivate

