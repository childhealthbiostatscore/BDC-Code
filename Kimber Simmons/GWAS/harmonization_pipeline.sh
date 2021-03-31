#!/bin/bash



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
# Convert each chromosome dose file to plink format
for i in {1..22}
do
  bcftools index imputed/$i.dose.vcf.gz
  plink --vcf imputed/$i.dose.vcf.gz --recode --double-id --make-bed --out imputed/$i.plink
done
# Remove .map, .ped, etc. files
cd imputed
find . -type f -name "*.ped" -delete
find . -type f -name "*.map" -delete
find . -type f -name "*.nosex" -delete
find . -type f -name "*.log" -delete
cd ..