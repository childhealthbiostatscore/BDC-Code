
###Summary Stats###
source("S:/Shared Material/Shared Code/R/temp_table1.R")

table1<-final_table(dat.one,c("Gender","Race.Ethnicity"),
                        dat.one$MRN,margin=2,single=F,2,col.names=T, summary.stat='mean')
table1
