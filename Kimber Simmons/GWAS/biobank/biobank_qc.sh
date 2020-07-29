#!/bin/bash
cd /Users/timvigers/Documents/OneDrive\ -\ The\ University\ of\ Colorado\ Denver/simmons/
# Make plink2 files, move to QC directory
plink2 --bfile Simmons_071520 --make-bed --out qc/simmons_biobank_qc
cd qc
# Check for sex discrepancies - per Nick, the 7 participants marked as problems are okay to keep in the study.
plink2 --bfile simmons_biobank_qc --check-sex
# Check missing
plink2 --bfile simmons_biobank_qc --missing
# Delete SNPs and individuals with high levels of missingness
# Delete SNPs
plink2 --bfile simmons_biobank_qc --autosome-xy --geno 0.02 --make-bed --out simmons_biobank_qc
# Delete individuals
plink2 --bfile simmons_biobank_qc --mind 0.02 --make-bed --out simmons_biobank_qc
# Check missing post-deletion
plink2 --bfile simmons_biobank_qc --missing --out miss_post_del
# Remove variants based on MAF.
plink2 --bfile simmons_biobank_qc --maf 0.05 --make-bed --out simmons_biobank_qc
# Hardy-Weinberg equilibrium
plink2 --bfile simmons_biobank_qc --hwe 1e-10 --make-bed --out simmons_biobank_qc
# Check kinship - duplicate samples have kinship 0.5, not 1. none at 0.354 level
plink2 --bfile simmons_biobank_qc --make-king-table
# Remove temporary files
rm simmons_biobank_qc.bed~ simmons_biobank_qc.bim~ simmons_biobank_qc.fam~
# simmons_biobank_qc.fam manually edited to make everyone a control