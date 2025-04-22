#!/bin/bash

### FILE FOR MAMBA ENVIRONMENT SET UP ON ALMA ###

path="$1"

source /data/rds/DIT/SCICOM/SCRSE/shared/source/.mamba
mamba create --prefix "${path}/GA_env" python=3.10 pandas numpy pyyaml jinja2 plotly 
mamba activate "${path}/GA_env"
mamba deactivate

