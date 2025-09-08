#!/bin/bash

#SBATCH --job-name="Tim Hyak Test"
#SBATCH --mail-type=END
#SBATCH --mail-user=tvigers@uw.edu
#SBATCH --account=togo
#SBATCH --partition=cpu-g2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=10G
#SBATCH --time=00-01:00:00 # Max runtime in DD-HH:MM:SS format.
#SBATCH --export=all

# Your programs to run.
apptainer exec --cleanenv --bind /gscratch r-base_latest.sif Rscript /gscratch/togo/tvigers/GitHub/BDC-Code/Andrea\ Steck/Advanced\ CGM\ and\ OGTT/fpca_fit.R
