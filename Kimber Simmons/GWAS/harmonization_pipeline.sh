#!/bin/bash
# Module 1: Within-array processing
# Cohort QC prior to merge
# Find individuals to exclude
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_samples.R
# Working directory
cd ~/Dropbox/Work/Kimber\ Simmons/GWAS
# Remove indels limit to chromosomes 1-22 and pseudoautosomal regions of XY
plink --bfile Data_Raw/Simmons_MEGA1_Deliverable_06142019/cleaned_files/Simmons_Custom_MEGA_Analysi_03012019_snpFailsRemoved_passing_QC \
  --snps-only 'just-acgt' \
  --autosome-xy \
  --list-duplicate-vars suppress-first \
  --make-bed --out Data_Cleaned/harmonized_analysis/redo
plink --bfile Data_Raw/Simmons\ Biobank/Simmons_071520 \
  --snps-only 'just-acgt' \
  --autosome-xy \
  --list-duplicate-vars suppress-first \
  --make-bed --out Data_Cleaned/harmonized_analysis/biobank1
plink --bfile Data_Raw/V2\ -\ Biobank\ data\ on\ Hispanic\ Patients\ -\ Full\ Genetic\ Request/Simmons_120420\
  --snps-only 'just-acgt'\
  --autosome-xy\
  --list-duplicate-vars suppress-first \
  --make-bed --out Data_Cleaned/harmonized_analysis/biobank2
# Phenotypes
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/biobank_phenotype.R
# QC from list
cd Data_Cleaned/harmonized_analysis
for value in redo biobank1 biobank2
do
  # Remove duplicates
  plink --bfile $value \
    --exclude $value.dupvar \
    --make-bed --out $value
  # Remove samples with missing rate greater than 2%
  plink --bfile $value --mind 0.02 --make-bed --out $value
  # Check sex
  plink --bfile $value --check-sex
  grep "PROBLEM" plink.sexcheck| awk '{print$1,$2}'> sex_discrepancy.txt
  plink --bfile $value --remove sex_discrepancy.txt --make-bed --out $value
  # Check for relationships between individuals with a pihat > 0.2.
  plink --bfile $value --genome --min 0.625 --out pihat
  awk '{print$1,$2}' pihat.genome > pihat_high.txt
  plink --bfile $value --remove pihat_high.txt --make-bed --out $value
  # Check inbreeding
  plink --bfile $value --het --out R_check
  Rscript --no-save /Users/timvigers/GitHub/BDC-Code/Kimber\ Simmons/GWAS/heterozygosity.R
  sed 's/"// g' fail-het-qc.txt | awk '{print$1, $2}'> het_fail_ind.txt
  plink --bfile $value --remove het_fail_ind.txt --make-bed --out $value
  # Remove variants with missing rate greater than 1%
  plink --bfile $value --geno 0.01 --make-bed --out $value
done
# Remove temporary files
find . -name "*~" -delete 
# Ancestry inference


python3 ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/ancestry_rf.py