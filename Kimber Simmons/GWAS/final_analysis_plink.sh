#!/bin/bash
# Working directory
cd Work/Kimber\ Simmons/GWAS
# Remove indels, limit to chromosomes 1-22 and pseudoautosomal regions of XY
plink2 --bfile Data_Raw/Simmons_Redo_Deliverable_061119_Final/raw_files/Simmons_redo --snps-only 'just-acgt' --autosome --make-bed --out Data_Cleaned/plink/redo
plink2 --bfile Data_Raw/Simmons\ Biobank/Simmons_071520 --snps-only 'just-acgt' --autosome --make-bed --out Data_Cleaned/plink/biobank1
plink2 --bfile Data_Raw/V2\ -\ Biobank\ data\ on\ Hispanic\ Patients\ -\ Full\ Genetic\ Request/Simmons_120420 --snps-only 'just-acgt' --autosome --make-bed --out Data_Cleaned/plink/biobank2
# Find individuals to exclude
Rscript /Users/timvigers/GitHub/BDC-Code/Kimber\ Simmons/GWAS/check_samples.R
# Move to cleaned Data_Raw
cd Data_Cleaned/plink
# Merge
plink --bfile redo --bmerge biobank1 --make-bed --out merged1
plink --bfile redo --flip merged1-merge.missnp --make-bed --out redo_flip
plink --bfile redo_flip --bmerge biobank1 --make-bed --out merged2

plink --bfile merged1 --bmerge biobank2 --make-bed --out merged2
