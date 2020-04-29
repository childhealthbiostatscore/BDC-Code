# Get T1D status from Laura's data
original = read.csv("/Users/timvigers/Desktop/original_scale.csv",
                    na.strings = "",stringsAsFactors = F)
cats = read.csv("/Volumes/peds/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/CACTI/Metabolon insulin resistance pilot/Data_clean/Metaboanalyst T1D vs control.csv",
                na.strings = "",stringsAsFactors = F)
original = original[,which(colnames(original) %in% colnames(cats))]
original[1,] = cats[1,match(colnames(original),colnames(cats))]
# Format df
t = as.data.frame(t(original))
colnames(t) = t[1,]
t = t[-c(1),]
t = as.data.frame(lapply(t,function(x){as.numeric(gsub(",","",x))}))
t[,2:ncol(t)] = lapply(t[,2:ncol(t)],scale)
t$diabetes = factor(as.numeric(t$diabetes))
# T tests
l = lapply(names(t)[2:ncol(t)], function(x){
  form = as.formula(paste0(x,"~diabetes"))
  test = try(t.test(form,data = t),silent = T)
  if(typeof(test) == "list") {
    return(c(x,test$p.value,test$statistic))
  } else {NA}
})
# Format output for Metaboanalyst
l = as.data.frame(do.call(rbind,l))
l[,1] = sub("X","",l[,1])
# Some names are duplicates, so remove second decimal e.g. 248.1493.1 -> 248.14931 
l[,1] = sapply(l[,1], function(x){
  newx = strsplit(x,"\\.")
   x = paste0(newx[[1]][1],".",paste0(newx[[1]][2:length(newx[[1]])],collapse = ""))
   x
  })
# Remove NAs
l = l[complete.cases(l),]
colnames(l) = c("m.z","p.value","t.score")
#
write.csv(l,file = "/Users/timvigers/Desktop/Metaboanalyst T1D t tests.csv",row.names = F,na = "")
