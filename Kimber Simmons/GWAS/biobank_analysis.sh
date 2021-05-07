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
# Phenotype
Rscript ~/GitHub/BDC-Code/Kimber\ Simmons/GWAS/biobank_phenotype.R
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