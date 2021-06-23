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
# WD
cd Data_Cleaned/kimber_only_analysis
# Convert to VCF for TOPMed upload
plink2 --bfile kimber --recode vcf --out kimber
# Compress
bgzip -c kimber.vcf > kimber.vcf.gz
tabix -p vcf kimber.vcf.gz
rm kimber.vcf
# Split by chromosome
mkdir chr
for i in {1..22}
do
   bcftools filter kimber.vcf.gz -r $i > chr/chr$i.vcf
   bgzip -c chr/chr$i.vcf > chr/chr$i.vcf.gz
   rm chr/chr$i.vcf
done