#!/bin/bash
# Find individuals to exclude
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_samples.R
# Working directory
cd ~/Dropbox/Work/Kimber\ Simmons/GWAS
# Remove indels, limit to chromosomes 1-22 and pseudoautosomal regions of XY
plink2 --bfile Data_Raw/Simmons_MEGA1_Deliverable_06142019/cleaned_files/Simmons_Custom_MEGA_Analysi_03012019_snpFailsRemoved_passing_QC \
  --snps-only 'just-acgt' \
  --autosome-xy \
  --make-bed --out Data_Cleaned/biobank_analysis/redo
plink2 --bfile Data_Raw/Simmons\ Biobank/Simmons_071520 \
  --snps-only 'just-acgt' \
  --autosome-xy \
  --make-bed --out Data_Cleaned/biobank_analysis/biobank1
plink2 --bfile Data_Raw/V2\ -\ Biobank\ data\ on\ Hispanic\ Patients\ -\ Full\ Genetic\ Request/Simmons_120420\
  --snps-only 'just-acgt'\
  --autosome-xy\
  --make-bed --out Data_Cleaned/biobank_analysis/biobank2
# Move to cleaned Data_Raw
cd Data_Cleaned/biobank_analysis
# Merge
# Try flipping
plink --bfile redo --bmerge biobank1 --make-bed --out merged
plink --bfile redo --flip merged-merge.missnp --make-bed --out redo_flipped
plink --bfile redo_flipped --bmerge biobank1 --make-bed --out merged
# Check for variants that are genuine mismatches
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_variants.R
# Exclude real mismatches
plink --bfile redo_flipped --exclude exclude_snps --make-bed --out redo_flipped
plink --bfile redo_flipped --bmerge biobank1 --make-bed --out merged
# Same again with biobank2
plink --bfile merged --bmerge biobank2 --make-bed --out merged
# Rename variants by position and exclude duplicates
plink2 --bfile merged --set-all-var-ids '@:#[b37]\$r,\$a' --rm-dup 'exclude-mismatch' --make-bed --out merged_final
# QC
# Delete SNPs
plink2 --bfile merged_final --geno 0.02 --make-bed --out merged_final
# Delete individuals
plink2 --bfile merged_final --mind 0.02 --make-bed --out merged_final
# Remove variants based on MAF.
plink2 --bfile merged_final --maf 0.05 --make-bed --out merged_final
# Hardy-Weinberg equilibrium
plink2 --bfile merged_final  --hwe 1e-10 --make-bed --out merged_final
# Check kinship - duplicate samples have kinship 0.5, not 1. none at 0.354 level
plink2 --bfile merged_final --king-cutoff 0.25 --make-bed --out merged_final
# Remove temporary files
find . -name "*~" -delete 
# SNP Imputation
# Recode merged data to VCF
plink2 --bfile merged_final --recode vcf --out merged_final
# Compress
bgzip -c merged_final.vcf > merged_final.vcf.gz
tabix -p vcf merged_final.vcf.gz
mkdir chr
for i in {1..22}
do
   bcftools filter merged_final.vcf.gz -r $i > chr/chr$i.vcf
   bgzip -c chr/chr$i.vcf > chr/chr$i.vcf.gz
   rm chr/chr$i.vcf
done
# Use https://imputation.biodatacatalyst.nhlbi.nih.gov for imputation instead of local
# GRCh37, r squared filter 0.3, QC frequency check vs. TOPMed
# Post-imputation QC
cd TOPMed
7z x "*.zip" -p$(cat password.txt)
# Merge together the results of imputation
cd ..
cd biobank_analysis/imputed
bcftools concat --threads 8 -O z -o merged_imputed.vcf.gz *.vcf.gz 
# Convert to plink format and exclude samples
plink2 --vcf merged_imputed.vcf.gz --remove exclude_samples --make-bed --out merged_imputed --threads 8
# Phenotype
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/phenotype_and_sex.R
# Delete SNPs
plink2 --bfile merged_imputed --geno 0.02 --make-bed --out merged_imputed_qc
# Delete individuals
plink2 --bfile merged_imputed_qc --mind 0.02 --make-bed --out merged_imputed_qc
# Hardy-Weinberg equilibrium
plink2 --bfile merged_imputed_qc  --hwe 1e-10 --make-bed --out merged_imputed_qc
# Check kinship - duplicate samples have kinship 0.5, not 1.
plink2 --bfile merged_imputed_qc --king-cutoff 0.25 --make-bed --out merged_imputed_qc
# Remove variants based on MAF.
plink2 --bfile merged_imputed_qc --maf 0.05 --make-bed --out merged_imputed_qc
# Prune
plink2 --bfile merged_imputed_qc --indep-pairwise 50 5 0.2 --out merged_imputed_qc
# Remove temporary files
find . -name "*~" -delete

plink2 --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --pca 10 --out merged_imputed_qc --threads 8
cut -f1,2,3,4 merged_imputed_qc.eigenvec > 2pcs
cut -f1,2,3,4,5 merged_imputed_qc.eigenvec > 3pcs
cut -f1,2,3,4,5,6 merged_imputed_qc.eigenvec > 4pcs
# Get sex and phenotype
cut -f1,2,5,6 merged_imputed_qc.fam > p.phen
# Logistic regression - effect sizes
plink2 --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --glm 
plink2 --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --glm --covar 2pcs --out logistic_2pcs
plink2 --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --glm --covar 3pcs --out logistic_3pcs
plink2 --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --glm --covar 4pcs --out logistic_4pcs
# Make covariate and p values files
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/regression_covariates.R
# Lasso - requires h2 estimate
plink --bfile merged_imputed_qc --extract merged_imputed_qc.prune.in --covar covar.txt --lasso 0.6
plink --bfile merged_imputed_qc --score plink.lasso 2 header sum
# P value thresholds)
echo "1e-20 0 1e-20" > range_list 
echo "1e-19 0 1e-19" >> range_list
echo "1e-18 0 1e-18" >> range_list
echo "1e-17 0 1e-17" >> range_list
echo "1e-16 0 1e-16" >> range_list
echo "1e-15 0 1e-15" >> range_list
echo "1e-14 0 1e-14" >> range_list
# Plink with p values thresholds
plink \
    --bfile merged_imputed_qc \
    --score effect_sizes 1 2 3 header \
    --q-score-range range_list SNP.pvalue \
    --extract merged_imputed_qc.prune.in \
    --out test