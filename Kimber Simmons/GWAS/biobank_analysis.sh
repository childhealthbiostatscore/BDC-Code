#!/bin/bash
# Find individuals to exclude
Rscript /Users/timvigers/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_samples.R
# Working directory
cd /Users/timvigers/Documents/Work/Kimber\ Simmons/GWAS
# Remove indels, limit to chromosomes 1-22 and pseudoautosomal regions of XY
plink --bfile Data_Raw/Simmons_MEGA1_Deliverable_06142019/cleaned_files/Simmons_Custom_MEGA_Analysi_03012019_snpFailsRemoved_passing_QC \
  --snps-only 'just-acgt' \
  --autosome-xy \
  --make-bed --out Data_Cleaned/biobank_analysis/redo
plink --bfile Data_Raw/Simmons\ Biobank/Simmons_071520\
  --snps-only 'just-acgt'/
  --autosome-xy\
  --make-bed --out Data_Cleaned/biobank_analysis/biobank1
plink --bfile Data_Raw/V2\ -\ Biobank\ data\ on\ Hispanic\ Patients\ -\ Full\ Genetic\ Request/Simmons_120420\
  --snps-only 'just-acgt'\
  --autosome-xy\
  --make-bed --out Data_Cleaned/biobank_analysis/biobank2
# Phenotype
Rscript /Users/timvigers/GitHub/BDC-Code/Kimber\ Simmons/GWAS/biobank_phenotype.R
# Move to cleaned Data_Raw
cd Data_Cleaned/biobank_analysis
# Try to merge - lots of flipped SNPs
plink --bfile redo --bmerge biobank1 --make-bed --out merged1
plink --bfile redo --flip merged1-merge.missnp --make-bed --out redo_flip
plink --bfile redo_flip --bmerge biobank1 --make-bed --out merged2
# R code to update alleles
Rscript /Users/timvigers/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_variants.R
# Plink update alleles
plink --bfile redo --update-alleles redo_update --make-bed --out redo_update
# Try merge again
plink --bfile redo_update --bmerge biobank1 --make-bed --out merged1
plink --bfile redo_update --flip merged1-merge.missnp --make-bed --out redo_flip_update
plink --bfile redo_flip_update --bmerge biobank1 --make-bed --out merge1_post_flip
# Second biobank dataset
plink --bfile merge1_post_flip --bmerge biobank2 --make-bed --out merged2
# Remove duplicates and problem SNPs
plink --bfile merged2 --list-duplicate-vars suppress-first
plink --bfile merged2 --exclude plink.dupvar --remove exclude_samples --make-bed --out merged3
plink --bfile merged3 --exclude exclude_snps --make-bed --out merged4
# Remove bad samples
plink --bfile merged4 --remove exclude_samples --make-bed --out merged_final
# QC
# Check missingness
plink --bfile merged_final --missing
# Delete SNPs
plink --bfile merged_final --geno 0.02 --make-bed --out merged_final
# Delete individuals
plink --bfile merged_final --mind 0.02 --make-bed --out merged_final
# Check missing post-deletion
plink --bfile merged_final --missing --out miss_post_del
# Remove variants based on MAF.
plink --bfile merged_final --maf 0.05 --make-bed --out merged_final
# Hardy-Weinberg equilibrium
plink --bfile merged_final  --hwe 1e-10 --write-snplist --make-bed --out merged_final
# Check kinship - duplicate samples have kinship 0.5, not 1. none at 0.354 level
plink2 --bfile merged_final --make-king-table
# Remove temporary files
find . -name "*~" -delete
# SNP Imputation
# Recode merged data to VCF
plink --bfile merged_final --recode vcf --out merged_final
# Compress
bgzip -c merged_final.vcf > merged_final.vcf.gz
# Loop tabix and bcftools over all chromosomes to split into individual files
# Code from https://www.biostars.org/p/173073/ and
# https://bioinformatics.stackexchange.com/questions/3401/how-to-subset-a-vcf-by-chromosome-and-keep-the-header
# Autosomes are coded 1 - 22 and the others are:
# X chromosome                    = 23
# Y chromosome                    = 24
# Pseudo-autosomal region of X    = 25
# Mitochondrial                   = 26
tabix -p vcf merged_final.vcf.gz
for i in {1..26}
do
   bcftools filter merged_final.vcf.gz -r $i > chr/chr$i.vcf
done
# Minimac imputation for autosomes - sex chromosomes not working yet
cps=4
for i in {1..22}
do
  minimac4\
    --refHaps ~/Dropbox/Work/GWAS/Minimac/G1K_P3_M3VCF_FILES_WITH_ESTIMATES/$i.1000g.Phase3.v5.With.Parameter.Estimates.m3vcf.gz \
    --haps chr/chr$i.vcf \
    --prefix imputed/$i\
    --cpus cps
done
# Merge the imputed files back into a single VCF - need to be indexed first
for i in {1..22}
do
  bcftools index imputed/$i.dose.vcf.gz
done
bcftools concat imputed/*vcf.gz -Oz -o Merged.vcf.gz