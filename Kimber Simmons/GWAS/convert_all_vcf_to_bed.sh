#!bin/bash
for i in *.vcf.gz
do 
	plink --vcf "$i" --make-bed --out "${i%.vcf.gz}" --memory 11892
done
