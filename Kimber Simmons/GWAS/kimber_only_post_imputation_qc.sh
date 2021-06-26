#!/bin/bash
# Working directory
cd ~/Dropbox/Work/Kimber\ Simmons/GWAS/Data_Cleaned/kimber_only_analysis/imputed
# Merge together the results of imputation
bcftools concat --threads 8 -O z -o kimber_imputed.vcf.gz *.vcf.gz
# Convert to plink format
plink2 --vcf kimber_imputed.vcf.gz --make-bed --out kimber_imputed --threads 8
# Get sex and phenotype
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/phenotype_and_sex_kimber_only.R
# QC
# Delete SNPs
plink2 --bfile kimber_imputed --geno 0.02 --make-bed --out kimber_imputed_qc
# Delete individuals
plink2 --bfile kimber_imputed_qc --mind 0.02 --make-bed --out kimber_imputed_qc
# Hardy-Weinberg equilibrium
plink2 --bfile kimber_imputed_qc  --hwe 1e-10 --make-bed --out kimber_imputed_qc
# Check kinship - duplicate samples have kinship 0.5, not 1.
plink2 --bfile kimber_imputed_qc --king-cutoff 0.25 --make-bed --out kimber_imputed_qc
# Remove variants based on MAF.
plink2 --bfile kimber_imputed_qc --maf 0.05 --make-bed --out kimber_imputed_qc
# Prune
plink2 --bfile kimber_imputed_qc --indep-pairwise 50 5 0.2 --out kimber_imputed_qc
# Remove temporary files
find . -name "*~" -delete
# Regression
plink2 --bfile kimber_imputed_qc --extract kimber_imputed_qc.prune.in --glm 'sex' --adjust
# Get SNP frequencies and counts
plink --bfile kimber_imputed_qc --freq 'case-control'
# Frequencies for the 1kG data (AMR only)
cd ~/Dropbox/Work/GWAS/TGP
plink2 --pfile all_phase3 --keep AMR_participants --extract t1d_snps --freq --out AMR_t1d_snps
