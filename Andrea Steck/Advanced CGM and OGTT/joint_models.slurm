#!/bin/bash

#SBATCH --job-name=
#SBATCH --mail-type=END
#SBATCH --mail-user=tvigers@uw.edu
#SBATCH --account=togo
#SBATCH --partition=cpu-g2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=120G
#SBATCH --time=01-00:00:00 # Max runtime in DD-HH:MM:SS format.
#SBATCH --export=all

# Pick which container to use
sif_file="/gscratch/togo/containers/ubuntu/ubuntu24.04/ubuntu24.04_cuda12.6.0.sif"
# Download data
data_dir="/gscratch/togo/tvigers/Data/BDC/andrea_steck/advanced_cgm"
mkdir -p $data_dir
s3cmd sync "s3://uwmdi/Andrea Steck/Advanced CGM and OGTT/Data_Clean" $data_dir -v
# Run the code
apptainer exec --bind /gscratch/togo --fakeroot $sif_file \
    "quarto render '/gscratch/togo/tvigers/GitHub/BDC-Code/Andrea Steck/Advanced CGM and OGTT/joint_models.qmd' --to html"