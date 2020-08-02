#!/bin/bash
cd /Users/timvigers/Documents/OneDrive\ -\ The\ University\ of\ Colorado\ Denver/simmons/
# Some variants are at slightly different positions between the two datasets - check they're not too far apart in R.
# Maximum difference is 1 bp, so okay to merge I think.
# Merge Kimber's data with biobank
plink --bfile Simmons_passed_qc --bmerge Simmons_071520 --make-bed --out qc/first_merge
# Exclude problem variants - flipping did not seem to fix this issue
plink --bfile Simmons_passed_qc --make-bed --out qc/Simmons_passed_qc_trimmed --exclude qc/first_merge-merge.missnp
plink --bfile Simmons_071520 --make-bed --out qc/Simmons_071520_trimmed --exclude qc/first_merge-merge.missnp
# Merge again
plink --bfile qc/Simmons_passed_qc_trimmed --bmerge qc/Simmons_071520_trimmed --make-bed --out analysis/biobank_simmons_merge
# Add 1000 genomes data
plink --bfile analysis/biobank_simmons_merge --bmerge /Users/timvigers/Documents/Work/GWAS/G1K/Phase3/merged/all_phase3_qc --allow-extra-chr --make-bed --out qc/second_merge
# Exclude problem variants - flipping did not seem to fix this issue either
plink --bfile analysis/biobank_simmons_merge --make-bed --out qc/biobank_simmons_merge_trimmed --exclude qc/second_merge-merge.missnp --allow-extra-chr
plink --bfile /Users/timvigers/Documents/Work/GWAS/G1K/Phase3/merged/all_phase3_qc --make-bed --out qc/all_phase3_trimmed --exclude qc/second_merge-merge.missnp --allow-extra-chr
# Merge again
plink --bfile analysis/biobank_simmons_merge --bmerge qc/all_phase3_trimmed --allow-extra-chr --make-bed --out qc/biobank_simmons_1kg_merge
# QC merged file again
plink2 --bfile qc/biobank_simmons_1kg_merge --autosome-xy --geno 0.02 --make-bed --out qc/biobank_simmons_1kg_merge
plink2 --bfile qc/biobank_simmons_1kg_merge --mind 0.02 --make-bed --out qc/biobank_simmons_1kg_merge
plink2 --bfile qc/biobank_simmons_1kg_merge --maf 0.05 --make-bed --out qc/biobank_simmons_1kg_merge
plink2 --bfile qc/biobank_simmons_1kg_merge --hwe 1e-6 --make-bed --out qc/biobank_simmons_1kg_merge_final
plink2 --bfile qc/biobank_simmons_1kg_merge --hwe 1e-10 --make-bed --out qc/biobank_simmons_1kg_merge_final
# Kinship check - none (good!)
plink2 --bfile qc/biobank_simmons_1kg_merge --make-king-table --king-table-filter 0.354 --out qc/biobank_simmons_1kg_kin
# Prune
plink2 --bfile qc/biobank_simmons_1kg_merge --indep-pairwise 50 5 0.2 --out qc/mergeSNP
plink2 --bfile qc/biobank_simmons_1kg_merge --extract qc/mergeSNP.prune.in --make-bed --out qc/final_merge
# Delete temp files 
rm qc/biobank_simmons_1kg_merge.bed~ qc/biobank_simmons_1kg_merge.bim~ qc/biobank_simmons_1kg_merge.fam~
rm analysis/biobank_simmons_merge.bed~ analysis/biobank_simmons_merge.bim~ analysis/biobank_simmons_merge.fam~
# PCA for population stratification
plink --bfile qc/final_merge --cluster --pca --out qc/1kG_PCA
# Per Nick, should use the full data set for ethnic misclassifications, but re-do PCA on Simmons/Biobank alone for analysis
plink2 --bfile analysis/biobank_simmons_merge --geno 0.02 --make-bed --out analysis/biobank_simmons_merge
plink2 --bfile analysis/biobank_simmons_merge --mind 0.02 --make-bed --out analysis/biobank_simmons_merge
plink2 --bfile analysis/biobank_simmons_merge --maf 0.05 --make-bed --out analysis/biobank_simmons_merge
plink2 --bfile analysis/biobank_simmons_merge --mac 20 --make-bed --out analysis/biobank_simmons_merge # Recommended in plink2 glm documentation
plink2 --bfile analysis/biobank_simmons_merge --hwe 1e-6 --make-bed --out analysis/biobank_simmons_merge
plink2 --bfile analysis/biobank_simmons_merge --hwe 1e-10 --make-bed --out analysis/biobank_simmons_merge
# Prune
plink2 --bfile analysis/biobank_simmons_merge --indep-pairwise 50 5 0.2 --out analysis/indepSNP
plink2 --bfile analysis/biobank_simmons_merge --extract analysis/indepSNP.prune.in --make-bed --out analysis/biobank_simmons_merge_final
# Delete temp files
rm analysis/biobank_simmons_merge.bed~ analysis/biobank_simmons_merge.bim~ analysis/biobank_simmons_merge.fam~
# Check for relatedness - none
plink2 --bfile analysis/biobank_simmons_merge_final --make-king-table --king-table-filter 0.354 --out analysis/biobank_simmons_kin
# PCA
plink2 --bfile analysis/biobank_simmons_merge_final --pca --out analysis/PCA
# Covariate file created in R
# Logistic regression
plink2 --bfile analysis/biobank_simmons_merge_final --covar analysis/covar.txt  --logistic --out analysis/logistic_results
# Adjusted p values
plink2 --adjust-file analysis/logistic_results.PHENO1.glm.logistic.hybrid 'test=ADD' --out analysis/logistic_results