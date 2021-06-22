#!/bin/bash
# Working directory
cd ~/Dropbox/Work/Kimber\ Simmons/GWAS
# Get Kimber's samples from merged QCed data
awk '{print $1,$2}' Data_Cleaned/biobank_analysis/redo.fam > Data_Cleaned/kimber_only_analysis/kimber_samples
plink2 --bfile Data_Cleaned/biobank_analysis/merged_final \
  --keep Data_Cleaned/kimber_only_analysis/kimber_samples \
  --make-bed --out Data_Cleaned/kimber_only_analysis/kimber
# Make ethnicity the outcome
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/ethnicity_as_outcome.R
# Convert to VCF for TOPMed upload