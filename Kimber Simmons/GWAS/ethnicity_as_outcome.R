setwd("~/Dropbox/Work/Kimber Simmons/GWAS/Data_Cleaned")
# Import Kimber's file
fam = read.delim("./kimber_only_analysis/kimber.fam",header = F)
# Import ethnicity
eth = read.csv("genotypehispanicnhw_deidentified 10232018 clean.csv")
fam$V6 = eth$Hispanic..0.N..1.Y.[match(sub("NA","",sapply(strsplit(fam$V2,"_"),"[[",3)),eth$correct_labID)]+1
# Write
write.table(fam,file="./kimber_only_analysis/kimber.fam",row.names = F,quote = F,col.names = F)
