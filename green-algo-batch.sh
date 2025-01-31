#!/bin/bash
#SBATCH --job-name=green-alma
#SBATCH --output=green-alma.out
#SBATCH --error=green-alma.err
#SBATCH --partition=compute
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=4000

source ~/.bashrc

userCWD="$(pwd)"
shared_path=$(cat /data/rds/DIT/SCICOM/SCRSE/shared/apps/GreenAlgorithms4HPC/shared_path.txt)

cd "${shared_path}apps/GreenAlgorithms4HPC/"

mamba activate "${shared_path}conda/GA_env"
python3 "${shared_path}apps/GreenAlgorithms4HPC/__init__.py" --userCWD "$userCWD" --user "$1" --startDay "$2" --endDay "$3"
mamba deactivate