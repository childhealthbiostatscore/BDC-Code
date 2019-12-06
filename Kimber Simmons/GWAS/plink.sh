#!/bin/bash
cd /Volumes/Tim/kimber/population_stratification/
# Remove individuals based on missing genotype data.
plink --bfile 1kG_MDS --mind 0.2 --allow-no-sex --make-bed --out 1kG_MDS2 --allow-extra-chr --memory 6144
# Remove variants based on missing genotype data.
plink --bfile 1kG_MDS2 --geno 0.02 --allow-no-sex --make-bed --out 1kG_MDS3 --allow-extra-chr --memory 6144
# Remove individuals based on missing genotype data.
plink --bfile 1kG_MDS3 --mind 0.02 --allow-no-sex --make-bed --out 1kG_MDS4 --allow-extra-chr --memory 6144
# Remove variants based on MAF.
plink --bfile 1kG_MDS4 --maf 0.05 --allow-no-sex --make-bed --out 1kG_MDS5 --allow-extra-chr --memory 6144
# Exclude all non-autosomal variants, except those with chromosome code XY
plink --bfile 1kG_MDS5 --allow-extra-chr --allow-no-sex --autosome --filter-founders --make-bed --out 1kG_MDS6 --memory 6144
# Relatedness
plink --bfile 1kG_MDS6 --extract indepSNP.prune.in --genome --min 0.2 --out pihat_min0.2 --memory 6144
awk '{ if ($8 >0.9) print $0 }' pihat_min0.2.genome>zoom_pihat.genome
plink --bfile 1kG_MDS6 --missing --memory 6144
# Delete related
plink --bfile 1kG_MDS6 --keep keep.txt --make-bed --out 1kG_MDS7 --memory 6144

# Extract the variants present in Kimber's dataset from the 1000 genomes dataset.
awk '{print$2}' Simmons_passed_qc.bim > Simmons_SNPs.txt
plink --bfile 1kG_MDS7 --extract Simmons_SNPs.txt --make-bed --out 1kG_MDS8 --memory 6144
# Extract the variants present in 1000 Genomes dataset from the HapMap dataset.
awk '{print$2}' 1kG_MDS8.bim > 1kG_MDS8_SNPs.txt
plink --bfile Simmons_passed_qc --extract 1kG_MDS8_SNPs.txt --recode --make-bed --out Simmons_MDS --memory 6144
# The datasets now contain the exact same variants.
## The datasets must have the same build. Change the build 1000 Genomes data build.
awk '{print$2,$4}' Simmons_MDS.map > buildSimmons.txt
# buildhapmap.txt contains one SNP-id and physical position per line.
plink --bfile 1kG_MDS8 --update-map buildSimmons.txt --make-bed --out 1kG_MDS9 --memory 6144
# 1kG_MDS7 and HapMap_MDS now have the same build.

# 1) set reference genome 
awk '{print$2,$5}' 1kG_MDS9.bim > 1kg_ref-list.txt
plink --bfile Simmons_MDS --reference-allele 1kg_ref-list.txt --make-bed --out Simmons-adj --memory 6144
# The 1kG_MDS7 and the Simmons-adj have the same reference genome for all SNPs.
# This command will generate some warnings for impossible A1 allele assignment.

# 2) Resolve strand issues.
# Check for potential strand issues.
awk '{print$2,$5,$6}' 1kG_MDS9.bim > 1kGMDS9_tmp
awk '{print$2,$5,$6}' Simmons-adj.bim > Simmons-adj_tmp
sort 1kGMDS9_tmp Simmons-adj_tmp |uniq -u > all_differences.txt

## Flip SNPs for resolving strand issues.
# Print SNP-identifier and remove duplicates.
awk '{print$1}' all_differences.txt | sort -u > flip_list.txt
# These are the non-corresponding SNPs between the two files. 
# Flip the non-corresponding SNPs. 
plink --bfile Simmons-adj --flip flip_list.txt --reference-allele 1kg_ref-list.txt --make-bed --out corrected_Simmons --memory 6144

# Check for SNPs which are still problematic after they have been flipped.
awk '{print$2,$5,$6}' corrected_Simmons.bim > corrected_Simmons_tmp
sort 1kGMDS8_tmp corrected_Simmons_tmp |uniq -u  > uncorresponding_SNPs.txt

# 3) Remove problematic SNPs from Simmons and 1000 Genomes.
awk '{print$1}' uncorresponding_SNPs.txt | sort -u > SNPs_for_exlusion.txt
# The command above generates a list of the 42 SNPs which caused the 84 differences between the Simmons and the 1000 Genomes data sets after flipping and setting of the reference genome.

# Remove the problematic SNPs from both datasets.
plink --bfile corrected_Simmons --exclude SNPs_for_exlusion.txt --make-bed --out Simmons_MDS2 --memory 6144
plink --bfile 1kG_MDS9 --exclude SNPs_for_exlusion.txt --make-bed --out 1kG_MDS10 --memory 6144

# Merge Simmons with 1000 Genomes Data.
plink --bfile Simmons_MDS2 --bmerge 1kG_MDS9.bed 1kG_MDS9.bim 1kG_MDS9.fam --allow-no-sex --make-bed --out MDS_merge2 --memory 6144

# Using a set of pruned SNPs
# plink --bfile MDS_merge2 --extract indepSNP.prune.in --genome --out MDS_merge2 --memory 6144
# MDS
plink --bfile MDS_merge2 --read-genome MDS_merge2.genome --cluster --mds-plot 10 --out MDS_merge2 --memory 6144
# PCA
plink --bfile MDS_merge2 --read-genome MDS_merge2.genome --cluster --pca --out MDS_merge2