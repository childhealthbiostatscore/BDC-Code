#!/bin/bash
# Find individuals to exclude
Rscript /home/tim/Documents/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_samples.R
# Working directory
cd Work/Kimber\ Simmons/GWAS
# Remove indels, limit to chromosomes 1-22 and pseudoautosomal regions of XY
plink2 --bfile Data_Raw/Simmons_MEGA1_Deliverable_06142019/cleaned_files/Simmons_Custom_MEGA_Analysi_03012019_snpFailsRemoved_passing_QC --snps-only 'just-acgt' --autosome --make-bed --out Data_Cleaned/plink/redo
plink2 --bfile Data_Raw/Simmons\ Biobank/Simmons_071520 --snps-only 'just-acgt' --autosome --make-bed --out Data_Cleaned/plink/biobank1
plink2 --bfile Data_Raw/V2\ -\ Biobank\ data\ on\ Hispanic\ Patients\ -\ Full\ Genetic\ Request/Simmons_120420 --snps-only 'just-acgt' --autosome --make-bed --out Data_Cleaned/plink/biobank2
# Phenotype
Rscript /home/tim/Documents/GitHub/BDC-Code/Kimber\ Simmons/GWAS/phenotype.R
# Move to cleaned Data_Raw
cd Data_Cleaned/plink
# Try to merge - lots of flipped SNPs
plink --bfile redo --bmerge biobank1 --make-bed --out merged1
plink --bfile redo --flip merged1-merge.missnp --make-bed --out redo_flip
plink --bfile redo_flip --bmerge biobank1 --make-bed --out merged2
# R code to update alleles
Rscript /home/tim/Documents/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_variants.R
# Plink update alleles
plink2 --bfile redo --update-alleles redo_update --make-bed --out redo_update
# Try merge again
plink --bfile redo_update --bmerge biobank1 --make-bed --out merged1
plink --bfile redo_update --flip merged1-merge.missnp --make-bed --out redo_flip_update
plink --bfile redo_flip_update --bmerge biobank1 --make-bed --out merge1_post_flip
# Second biobank dataset
plink --bfile merge1_post_flip --bmerge biobank2 --make-bed --out merged2
# Remove duplicates
plink --bfile merged2 --list-duplicate-vars suppress-first
plink2 --bfile merged2 --exclude plink.dupvar --remove exclude_samples --make-bed --out merged3
plink2 --bfile merged3 --exclude exclude_snps --make-bed --out merged_final