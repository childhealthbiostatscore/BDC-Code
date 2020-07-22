#!/bin/bash
cd /Users/timvigers/Documents/OneDrive\ -\ The\ University\ of\ Colorado\ Denver/simmons_biobank/
# Make plink2 files, move to QC directory
plink2 --bfile Simmons_071520 --make-pgen --out qc/simmons_qc
cd qc
# Check missing
plink2 --pfile simmons_qc --missing
# Delete SNPs and individuals with high levels of missingness
# Delete SNPs
plink --bfile simmons_qc --geno 0.02 --make-bed --out simmons_qc
# Delete individuals
plink --bfile simmons_qc --mind 0.02 --make-bed --out simmons_qc
# Check missing post-deletion
plink --bfile biobank_1 --missing --out miss_post_del
# Check sex discrepancy
plink --bfile biobank_1 --check-sex
