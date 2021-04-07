#!/bin/bash
# From Chen et al. “A Data Harmonization Pipeline to Leverage External Controls and Boost Power in GWAS.” 
# BioRxiv, December 2, 2020, 2020.11.30.405415. https://doi.org/10.1101/2020.11.30.405415.
# Module 1: Within-array processing
# Cohort QC prior to merge
# Find individuals to exclude
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_samples.R
# Working directory
cd ~/Documents/Work/Kimber\ Simmons/GWAS
# Remove indels limit to chromosomes 1-22 and pseudoautosomal regions of XY
plink2 --bfile Data_Raw/Simmons_MEGA1_Deliverable_06142019/cleaned_files/Simmons_Custom_MEGA_Analysi_03012019_snpFailsRemoved_passing_QC \
  --snps-only 'just-acgt' \
  --autosome-xy \
  --make-bed --out Data_Cleaned/harmonized_analysis/redo
plink2 --bfile Data_Raw/Simmons\ Biobank/Simmons_071520 \
  --snps-only 'just-acgt' \
  --autosome-xy \
  --make-bed --out Data_Cleaned/harmonized_analysis/biobank1
plink2 --bfile Data_Raw/V2\ -\ Biobank\ data\ on\ Hispanic\ Patients\ -\ Full\ Genetic\ Request/Simmons_120420\
  --snps-only 'just-acgt'\
  --autosome-xy\
  --make-bed --out Data_Cleaned/harmonized_analysis/biobank2
# Phenotypes
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/biobank_phenotype.R
# QC from list
cd Data_Cleaned/harmonized_analysis
for value in redo biobank1 biobank2
do
  # Remove duplicates
  plink2 --bfile $value --set-all-var-ids '@:#[b37]\$r,\$a' --make-bed --out $value
  plink2 --bfile $value --rm-dup 'exclude-mismatch' --make-bed --out $value
  # Remove samples with missing rate greater than 2%
  plink2 --bfile $value --mind 0.02 --make-bed --out $value
  # Check sex
  plink2 --bfile $value --check-sex
  grep "PROBLEM" plink.sexcheck| awk '{print$1,$2}'> sex_discrepancy.txt
  plink2 --bfile $value --remove sex_discrepancy.txt --make-bed --out $value
  # Check for relationships between individuals with a pihat > 0.2.
  plink2 --bfile $value --genome --min 0.625 --out pihat
  awk '{print$1,$2}' pihat.genome > pihat_high.txt
  plink2 --bfile $value --remove pihat_high.txt --make-bed --out $value
  # Check inbreeding
  plink2 --bfile $value --het --out R_check
  Rscript --no-save /Users/timvigers/GitHub/BDC-Code/Kimber\ Simmons/GWAS/heterozygosity.R
  sed 's/"// g' fail-het-qc.txt | awk '{print$1, $2}'> het_fail_ind.txt
  plink2 --bfile $value --remove het_fail_ind.txt --make-bed --out $value
  # Remove variants with missing rate greater than 1%
  plink2 --bfile $value --geno 0.01 --make-bed --out $value
done 
# # Ancestry inference
# Project onto PC space from 1kG data
for value in redo biobank1 biobank2
do
  plink2 --bfile $value \
    --read-freq ~/Documents/Work/GWAS/TGP/QC/ref_pcs.acount \
    --score ~/Documents/Work/GWAS/TGP/QC/ref_pcs.eigenvec.allele 2 5 header-read variance-standardize no-mean-imputation \
    --score-col-nums 6-15 \
    --out ${value}
done
# RF code
python3 ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/ancestry_rf.py
# Array-level pre-imputation QC
# Merge by ancestry type and array (in this set all are on the same array, so use cohort)
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/split_by_ancestry.R
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/all_pcs.R
# Iterate through population types
while read line
do
  echo $line
  plink2 --bfile $(echo $line | cut -f2 -d_) --keep $line --make-bed --out $line
  # Variant QC
  plink2 --bfile $line --maf 0.01 --mind 0.02 --make-bed --out $line
  plink --bfile $line --genome --min 0.625 --out "${line}_pihat"
  awk '{print$1,$2}' ${line}_pihat.genome > pihat_high.txt
  plink2 --bfile $line --remove pihat_high.txt --make-bed --out $line
  plink2 --bfile $line --hwe 1e-4 --make-bed --out $line
  # Pseudo GWAS
  awk '$6=2' $line.fam > temp.fam
  mv temp.fam $line.fam
  ## Merge
  plink --bfile $line --bmerge /Users/timvigers/Documents/Work/GWAS/TGP/QC/phase3_qc \
    --allow-extra-chr \
    --make-bed --out "${line}_merged"
  ## First 3 PCs only - this is different from the paper. Many of these fail due to perfect separation
  ## so those should be deleted
  plink2 --bfile "${line}_merged" --glm hide-covar --covar all_pcs \
    --covar-variance-standardize --out $line
done < "ancestry_split_files"
# Remove temporary files
find . -name "*~" -delete