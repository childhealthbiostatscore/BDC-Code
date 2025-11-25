#!/bin/bash

#SBATCH --job-name="Joint Models"
#SBATCH --mail-type=END
#SBATCH --mail-user=tvigers@uw.edu
#SBATCH --account=togo
#SBATCH --partition=cpu-g2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=100G
#SBATCH --time=02-00:00:00 # Max runtime in DD-HH:MM:SS format.
#SBATCH --export=all

# Your programs to run.
apptainer exec --bind /gscratch debian.sif Rscript /gscratch/togo/tvigers/GitHub/BDC-Code/Andrea\ Steck/Advanced\ CGM\ and\ OGTT/joint_models.r
apptainer exec --bind /gscratch debian.sif quarto render /gscratch/togo/tvigers/GitHub/BDC-Code/Andrea\ Steck/Advanced\ CGM\ and\ OGTT/joint_models.qmd