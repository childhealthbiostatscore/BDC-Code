#!/bin/bash
# Working directory
cd /mnt/c/Users/Tim\ Vigers/Dropbox/Work/Kimber\ Simmons/GWAS
# Remove indels, limit to chromosomes 1-22 and pseudoautosomal regions of XY
plink --bfile Data_Raw/Simmons_MEGA1_Deliverable_06142019/cleaned_files/Simmons_Custom_MEGA_Analysi_03012019_snpFailsRemoved_passing_QC --make-bed --out Data_Cleaned/simplified_analysis/redo
# Same for Biobank files
plink --bfile Data_Raw/Simmons\ Biobank/Simmons_071520 --snps-only 'just-acgt' --autosome-xy --make-bed --out Data_Cleaned/simplified_analysis/biobank1
plink --bfile Data_Raw/V2\ -\ Biobank\ data\ on\ Hispanic\ Patients\ -\ Full\ Genetic\ Request/Simmons_120420 --snps-only 'just-acgt' --autosome-xy --make-bed --out Data_Cleaned/simplified_analysis/biobank2
# Phenotype - Hispanic vs. Non-Hispanic
Rscript /mnt/c/Users/Tim\ Vigers/Documents/GitHub/BDC-Code/Kimber\ Simmons/GWAS/phenotype_simplified_analysis.R
# Merge biobank files
cd Data_Cleaned/simplified_analysis/
plink --bfile biobank1 --bmerge biobank2 --make-bed --out biobank_merged
# Remove duplicates
plink --bfile biobank_merged --list-duplicate-vars suppress-first
# QC 
# Check sex
plink --bfile redo --check-sex
# Check missing
plink2 --bfile redo --missing
# Delete SNPs and individuals with high levels of missingness
# Delete SNPs
plink2 --bfile redo --geno 0.02 --make-bed --out redo
# Delete individuals
plink2 --bfile redo --mind 0.02 --make-bed --out redo
# Check missing post-deletion
plink2 --bfile redo --missing --out miss_post_del
# Remove variants based on MAF.
plink2 --bfile redo --maf 0.05 --make-bed --out redo
# Hardy-Weinberg equilibrium
plink2 --bfile redo --hwe 1e-10 --make-bed --out redo
# Check kinship - duplicate samples have kinship 0.5, not 1. none at 0.354 level
plink2 --bfile redo --make-king-table
# Remove temporary files
rm redo.bed~ redo.bim~ redo.fam~
# Analysis
# Allele frequency
plink --bfile redo --freq 'case-control' --out redo_freq
# Logistic regression with ethnicity as outcome
plink --bfile redo --logistic sex --adjust --out logistic_results