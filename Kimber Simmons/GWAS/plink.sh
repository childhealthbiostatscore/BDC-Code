#!/bin/bash
# Set directory
cd kimber_gwas/Data_Cleaned/
# Raw file name
file="Simmons_redo"
# Check missing
plink --noweb --bfile $file --missing
# Delete SNPs and individuals with high levels of missingness
# Delete SNPs
plink --noweb --bfile $file --geno 0.02 --make-bed --out "${file}_remove_miss"
# Delete individuals
plink --noweb --bfile "${file}_remove_miss" --mind 0.02 --make-bed --out "${file}_remove_miss"
# Check missing post-deletion
plink --noweb --bfile "${file}_remove_miss" --missing --out "${file}_check_miss"
# Check sex discrepancy
plink --noweb --bfile "${file}_remove_miss" --check-sex --out "${file}_sex"
# Impute sex
plink --noweb --bfile "${file}_sex" --impute-sex --make-bed --out "${file}_imputed_sex"
