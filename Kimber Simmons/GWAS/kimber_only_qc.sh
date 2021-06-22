#!/bin/bash
# Working directory
cd ~/Dropbox/Work/Kimber\ Simmons/GWAS
# Remove indels, limit to chromosomes 1-22 and pseudoautosomal regions of XY
plink2 --bfile Data_Raw/Simmons_MEGA1_Deliverable_06142019/raw_files/Simmons_Custom_MEGA_Analysi_03012019_removeKnownFails \
  --snps-only 'just-acgt' \
  --autosome-xy \
  --set-all-var-ids '@:#[b37]\$r,\$a' \
  --rm-dup 'exclude-mismatch' \
  --make-bed --out Data_Cleaned/kimber_only_analysis/kimber
# Move to cleaned Data_Raw
cd Data_Cleaned/kimber_only_analysis
# Flip strand for the SNPs that were excluded from the first attempt at TOPMed imputation
#Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/flip_for_imputation.R
# QC
# Delete SNPs
plink2 --bfile kimber --geno 0.02 --make-bed --out kimber
# Delete individuals
plink2 --bfile kimber --mind 0.02 --make-bed --out kimber
# Remove variants based on MAF.
plink2 --bfile kimber --maf 0.05 --make-bed --out kimber
# Hardy-Weinberg equilibrium
plink2 --bfile kimber  --hwe 1e-10 --make-bed --out kimber
# Check kinship - duplicate samples have kinship 0.5, not 1. none at 0.354 level
plink2 --bfile kimber --king-cutoff 0.25 --make-bed --out kimber
# Remove temporary files
find . -name "*~" -delete 
# SNP Imputation
# Recode merged data to VCF
plink2 --bfile kimber --recode vcf --out kimber
# Compress
bgzip -c kimber.vcf > kimber.vcf.gz
tabix -p vcf kimber.vcf.gz
# Delete uncompressed VCF
rm kimber.vcf
# Split by chromosome
mkdir kimber_chr
for i in {1..22}
do
   bcftools filter kimber.vcf.gz -r $i > kimber_chr/chr$i.vcf
   bgzip -c kimber_chr/chr$i.vcf > kimber_chr/chr$i.vcf.gz
   rm kimber_chr/chr$i.vcf
done
# # Use https://imputation.biodatacatalyst.nhlbi.nih.gov for imputation instead of local
# # GRCh37, r squared filter 0.3, QC frequency check vs. TOPMed
# # Post-imputation QC
# cd TOPMed
# 7z x "*.zip" -p$(cat password.txt)
# # Merge together the results of imputation
# cd ..
# cd biobank_analysis/imputed
# bcftools concat --threads 8 -O z -o merged_imputed.vcf.gz *.vcf.gz 
# # Convert to plink format and exclude samples
# plink2 --vcf merged_imputed.vcf.gz --remove exclude_samples --make-bed --out merged_imputed --threads 8
# # Phenotype
# Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/phenotype_and_sex.R
# # Delete SNPs
# plink2 --bfile merged_imputed --geno 0.02 --make-bed --out merged_imputed_qc
# # Delete individuals
# plink2 --bfile merged_imputed_qc --mind 0.02 --make-bed --out merged_imputed_qc
# # Hardy-Weinberg equilibrium
# plink2 --bfile merged_imputed_qc  --hwe 1e-10 --make-bed --out merged_imputed_qc
# # Check kinship - duplicate samples have kinship 0.5, not 1.
# plink2 --bfile merged_imputed_qc --king-cutoff 0.25 --make-bed --out merged_imputed_qc
# # Remove variants based on MAF.
# plink2 --bfile merged_imputed_qc --maf 0.05 --make-bed --out merged_imputed_qc
# # Prune
# plink2 --bfile merged_imputed_qc --indep-pairwise 50 5 0.2 --out merged_imputed_qc
# # Remove temporary files
# find . -name "*~" -delete

# plink2 --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --pca 10 --out merged_imputed_qc --threads 8
# cut -f1,2,3,4 merged_imputed_qc.eigenvec > 2pcs
# cut -f1,2,3,4,5 merged_imputed_qc.eigenvec > 3pcs
# cut -f1,2,3,4,5,6 merged_imputed_qc.eigenvec > 4pcs
# # Get sex and phenotype
# cut -f1,2,5,6 merged_imputed_qc.fam > p.phen
# # Make covariate files and test/train sets
# Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/regression_covariates.R
# # Basic regression for choosing the SNPs that go into the lasso
# plink2 --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --keep train_samples --glm
# # Lasso on the training set - h2 estimate comes from Lam et al. 
# plink --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --keep train_samples --covar covar.txt --lasso 0.6
# # Get scores for training set and test set
# plink --bfile merged_imputed_qc --keep train_samples --score plink.lasso 2 header sum --out train
# plink --bfile merged_imputed_qc --keep test_samples --score plink.lasso 2 header sum --out test