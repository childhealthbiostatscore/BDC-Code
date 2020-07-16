#!/bin/bash
cd /Users/timvigers/simmons/biobank
# Check missing
plink --bfile Simmons_071520 --missing
# Delete SNPs and individuals with high levels of missingness
# Delete SNPs
plink --bfile Simmons_071520 --geno 0.02 --make-bed --out biobank_1
# Delete individuals
plink --bfile biobank_1 --mind 0.02 --make-bed --out biobank_1
# Check missing post-deletion
plink --bfile biobank_1 --missing --out miss_post_del
# Check sex discrepancy
plink --bfile biobank_1 --check-sex
