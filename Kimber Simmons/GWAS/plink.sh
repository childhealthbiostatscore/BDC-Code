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