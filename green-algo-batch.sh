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

cd "$1"

mamba activate "$1/conda/GA_env"
python3 "$1/apps/GreenAlgorithms4HPC/__init__.py" --userCWD "$userCWD" --user "$2" --startDay "$3" --endDay "$4"
mamba deactivate