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
plink2 --bfile biobank_merged --exclude plink.dupvar --make-bed --out biobank_merged
# QC - keeping the datasets separate for this analysis
# Check sex and exclude problems
plink --bfile redo --check-sex --out redo
grep "PROBLEM" redo.sexcheck | awk '{print$1,$2}'> sex_discrepancy_redo.txt
plink --bfile redo --remove sex_discrepancy_redo.txt --make-bed --out redo
plink --bfile biobank_merged --check-sex --out biobank
grep "PROBLEM" biobank.sexcheck | awk '{print$1,$2}'> sex_discrepancy_biobank.txt
plink --bfile biobank_merged --remove sex_discrepancy_biobank.txt --make-bed --out biobank_merged
# Delete SNPs and individuals with high levels of missingness
# Delete SNPs
plink --bfile redo --geno 0.02 --make-bed --out redo
plink --bfile biobank_merged --geno 0.02 --make-bed --out biobank_merged
# Delete individuals
plink --bfile redo --mind 0.02 --make-bed --out redo
plink --bfile biobank_merged --mind 0.02 --make-bed --out biobank_merged
# Remove variants based on MAF.
plink --bfile redo --maf 0.05 --make-bed --out redo
plink --bfile biobank_merged --maf 0.05 --make-bed --out biobank_merged
# Hardy-Weinberg equilibrium
plink --bfile redo --hwe 1e-10 --make-bed --out redo
plink --bfile biobank_merged --hwe 1e-10 --make-bed --out biobank_merged
# Check kinship - duplicate samples have kinship 0.5, not 1. none at 0.177 level
plink2 --bfile redo --king-cutoff 0.177 --out redo
plink2 --bfile biobank_merged --king-cutoff 0.177 --out biobank_merged
# Remove temporary files
find . -type f -name "*~" -delete
# Impute alleles
#plink --bfile redo --recode vcf
#minimac4 --refHaps /mnt/c/Users/Tim\ Vigers/Dropbox/Work/TGP/G1K_P3_M3VCF_FILES_WITH_ESTIMATES.tar.gz --haps redo.vcf --prefix testRun
# Analysis
# Allele frequency
plink --bfile redo --freq 'case-control' --out redo
plink --bfile biobank_merged --freq 'case-control' --out biobank_merged
# Logistic regression with ethnicity as outcome
plink --bfile redo --logistic sex --adjust --out redo
plink --bfile biobank_merged --logistic sex --adjust --out biobank_merged