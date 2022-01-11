#!/bin/bash
cd Dropbox/Work/Janet\ Snell-Bergeon/AHA/Genomics
# Concatenate all dose, pmap, and pfam file
cat Data_Raw/New\ imputed\ SNPS/CACTI_chr1.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr2.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr3.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr4.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr5.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr6.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr7.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr8.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr9.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr10.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr11.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr12.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr13.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr14.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr15.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr16.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr17.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr18.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr19.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr20.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr21.dose.gz \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr22.dose.gz \
        > Data_Cleaned/allfiles.gz

cat Data_Raw/New\ imputed\ SNPS/CACTI_chr1.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr2.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr3.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr4.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr5.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr6.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr7.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr8.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr9.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr10.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr11.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr12.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr13.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr14.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr15.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr16.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr17.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr18.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr19.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr20.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr21.pmap \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr22.pmap \
        > Data_Cleaned/allfiles.pmap

cat Data_Raw/New\ imputed\ SNPS/CACTI_chr1.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr2.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr3.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr4.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr5.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr6.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr7.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr8.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr9.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr10.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr11.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr12.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr13.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr14.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr15.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr16.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr17.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr18.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr19.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr20.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr21.pfam \
    Data_Raw/New\ imputed\ SNPS/CACTI_chr22.pfam \
        > Data_Cleaned/allfiles1.pfam
    
# Samples to keep
sort -u Data_Cleaned/allfiles1.pfam > Data_Cleaned/allfiles.pfam
rm Data_Cleaned/allfiles1.pfam
cut -f2 Data_Cleaned/allfiles.pfam > Data_Cleaned/keep