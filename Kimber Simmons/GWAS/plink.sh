#!/bin/bash
# Set directory
cd /Volumes/som/PEDS/RI\ Biostatistics\ Core/Shared/Shared\ Projects/Laura/BDC/Projects/Kimber\ Simmons/GWAS/Data_Cleaned/
# Combine files
plink --noweb --bfile Simmons_redo --merge-list files_to_combine.txt --make-bed --out Simmons_combined
# Check missing
plink --noweb --bfile Simmons_combined --missing
# Delete SNPs and individuals with high levels of missingness
# Delete SNPs
plink --noweb --bfile Simmons_combined --geno 0.02 --make-bed --out Simmons_combined_remove_miss
# Delete individuals
plink --noweb --bfile Simmons_combined_remove_miss --mind 0.02 --make-bed --out Simmons_combined_remove_miss
# Check missing post-deletion
plink --noweb --bfile Simmons_combined_remove_miss --missing --out Simmons_combined_check_miss
# Check sex discrepancy
plink --noweb --bfile Simmons_combined_remove_miss --check-sex
# Remove subjects with problematic X chromosome homozygosity
grep "PROBLEM" plink.sexcheck| awk '{print$1,$2}'> sex_discrepancy.txt
plink --noweb --bfile Simmons_combined_remove_miss --remove sex_discrepancy.txt --make-bed --out Simmons_combined_remove_miss_and_sex --noweb
# Check sex discrepancy again
plink --noweb --bfile Simmons_combined_remove_miss_and_sex --check-sex --out post_del
# Select autosomal SNPs only (i.e., from chromosomes 1 to 22).
awk '{ if ($1 >= 1 && $1 <= 22) print $2 }' Simmons_combined_remove_miss_and_sex > snp_1_22.txt
plink --noweb --bfile Simmons_combined_remove_miss_and_sex --extract snp_1_22.txt --make-bed --out Simmons_combined_auto
# Check minor allele frequency
plink --noweb --bfile Simmons_combined_auto --freq --out MAF_check
# Remove SNPs with a low MAF frequency.
plink --noweb --bfile Simmons_combined_auto --maf 0.05 --make-bed --out Simmons_combined_auto_maf
# Check minor allele frequency again
plink --noweb --bfile Simmons_combined_auto_maf --freq --out MAF_check_post
