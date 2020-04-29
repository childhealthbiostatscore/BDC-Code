# Get T1D status from Laura's data
original = read.csv("/Volumes/peds/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/CACTI/Metabolon insulin resistance pilot/Data_clean/original_scale.csv",
                    na.strings = "",stringsAsFactors = F)
cats = read.csv("/Volumes/peds/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/CACTI/Metabolon insulin resistance pilot/Data_clean/Metaboanalyst T1D vs control.csv",
                na.strings = "",stringsAsFactors = F)
original = original[,which(colnames(original) %in% colnames(cats))]
original[1,] = cats[1,match(colnames(original),colnames(cats))]
# T tests/ANOVA

#
write.csv(original,file = "/Volumes/peds/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/CACTI/Metabolon insulin resistance pilot/Data_clean/Metaboanalyst T1D vs control original scale.csv",row.names = F,na = "")
