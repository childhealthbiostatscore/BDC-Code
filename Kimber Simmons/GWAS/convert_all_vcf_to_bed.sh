#!bin/bash

# Below is a bunch of stuff I tried but it failed

# Combine all vcf files
# bcftools concat ALL.chr{1..22}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -Oz -o  \
# ALL.autosomes.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz

#plink --vcf ALL.autosomes.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--make-bed --out ALL.autosomes.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes

# This doesn't work because plink runs out of memory trying to convery the huge combined file

# Tried converting then merging:

# Convert all to plink format
# for i in *.vcf.gz
# do 
# 	plink --vcf "$i" --make-bed --out "${i%.vcf.gz}" --memory 11892
# done

# plink --merge-list files_to_merge.txt --make-bed --out all.autosomes

# This doesn't work either because plink doesn't handle multi-allelic sites well

# Downloading all the files and combining them myself has been an enormous pain,
# but it turns out you can download pre-combined files from plink2 and convert them back to 
# plink1. https://www.cog-genomics.org/plink/2.0/resources#1kg_phase3

# A good vignette for newbies
# https://cran.r-project.org/web/packages/plinkQC/vignettes/Genomes1000.pdf

cd '/media/tim/Tim/plink_TGP'
plink2 --zst-decompress all_phase3.pgen.zst > all_phase3.pgen
plink2 --pfile all_phase3 vzs --max-alleles 2 --make-bed --out all_phase3