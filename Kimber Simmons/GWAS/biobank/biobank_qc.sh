#!/bin/bash
cd /Users/timvigers/Documents/OneDrive\ -\ The\ University\ of\ Colorado\ Denver/simmons/
# Make plink2 files, move to QC directory
plink2 --bfile Simmons_071520 --make-bed --out qc/simmons_biobank_qc
cd qc
# Check for sex discrepancies - per Nick, the 7 participants marked as problems are okay to keep in the study.
plink --bfile simmons_biobank_qc --check-sex
# Check missing
plink --bfile simmons_biobank_qc --missing
# Delete SNPs and individuals with high levels of missingness
# Delete SNPs
plink --bfile simmons_biobank_qc --geno 0.02 --make-bed --out simmons_biobank_qc
# Delete individuals
plink --bfile simmons_biobank_qc --mind 0.02 --make-bed --out simmons_biobank_qc
# Check missing post-deletion
plink --bfile simmons_biobank_qc --missing --out miss_post_del
