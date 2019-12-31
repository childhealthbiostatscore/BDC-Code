cd /Volumes/som/PEDS/RI\ Biostatistics\ Core/Shared
# QC reference
# Remove variants based on missing genotype data, write to Kimber's folder.
plink --bfile Shared\ Material/Reference\ Genomes/plink_TGP/all_phase3_ns --geno 0.2 --allow-no-sex --make-bed --out Shared\ Projects/Laura/BDC/Projects/Kimber\ Simmons/GWAS/Data_Cleaned/population_stratification/1kG_MDS --allow-extra-chr --memory 6144
# Move to population stratification folder
cd Shared\ Projects/Laura/BDC/Projects/Kimber\ Simmons/GWAS/Data_Cleaned/population_stratification
# Remove individuals based on missing genotype data.
plink --bfile 1kG_MDS --mind 0.2 --allow-no-sex --make-bed --out 1kG_MDS2 --allow-extra-chr --memory 6144
# Remove variants based on MAF.
plink --bfile 1kG_MDS2 --maf 0.05 --allow-no-sex --make-bed --out 1kG_MDS3 --allow-extra-chr --memory 6144
# Exclude all non-autosomal variants, except those with chromosome code XY. Filter out founders.
plink --bfile 1kG_MDS3 --allow-extra-chr --allow-no-sex --autosome-xy --make-bed --out 1kG_MDS4 --memory 6144 --filter-founders
# TGP data QC done
# Allele frequency
plink --bfile Simmons_passed_qc --freq --memory 6144 --out Simmons_passed_qc
# Extract the variants present in Kimber's dataset from the 1000 genomes dataset.
plink --bfile 1kG_MDS4 --extract list.snps --make-bed --out 1kG_MDS5 --memory 6144
# Vice versa
plink --bfile Simmons_passed_qc --extract list.snps --make-bed --out Simmons_MDS --memory 6144
# Make a list of multiple-position SNPs
plink --bfile Simmons_MDS --bmerge 1kG_MDS5.bed 1kG_MDS5.bim 1kG_MDS5.fam --make-bed --out first_merge --memory 6144
# Exclude
plink --bfile Simmons_MDS --make-bed --out Simmons_trimmed --memory 6144 --exclude first_merge-merge.missnp
plink --bfile 1kG_MDS5 --make-bed --out 1kG_MDS6 --memory 6144 --exclude first_merge-merge.missnp
# Merge again
plink --bfile Simmons_trimmed --bmerge 1kG_MDS6.bed 1kG_MDS6.bim 1kG_MDS6.fam --make-bed --out MDS_merge --memory 6144
# Prune
plink --bfile MDS_merge --indep-pairwise 50 5 0.2 --out mergeSNP --memory 6144
plink --bfile MDS_merge --extract mergeSNP.prune.in --make-bed --out final_merge --memory 6144
# PCA
plink --bfile final_merge --cluster --pca --out PCA --memory 6144