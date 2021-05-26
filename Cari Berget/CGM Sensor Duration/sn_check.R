library(readxl)
DCLP_pump_SN = read_excel("/Users/timvigers/OneDrive - The University of Colorado Denver/Control IQ/DCLP pump SN.xlsx")
sns = unlist(DCLP_pump_SN[,2:4])
sns = sns[!is.na(sns)]
# Event 171
event171_dclp3 = read.csv("~/OneDrive - The University of Colorado Denver/Control IQ/cgmdata/cgmdata/dclp3/_event171_dclp3_raw__202011021224.csv")
event171_dclp5 = read.csv("~/OneDrive - The University of Colorado Denver/Control IQ/cgmdata/cgmdata/dclp5/_event171_dclp5_raw__202011021221.csv")
event171 = unique(c(event171_dclp3$serialnumber,event171_dclp5$serialnumber))
missing_171 = sns[which(!(sns %in% event171))]
# Event 14
event14_dclp3 = read.csv("~/OneDrive - The University of Colorado Denver/Control IQ/cgmdata/cgmdata/dclp3/_event014_dclp3_raw__202010301759.csv")
event14_dclp5 = read.csv("~/OneDrive - The University of Colorado Denver/Control IQ/cgmdata/cgmdata/dclp5/_event014_dclp5_raw__202010301801.csv")
event14 = unique(c(event14_dclp3$serialnumber,event14_dclp5$serialnumber))
missing_14 = sns[which(!(sns %in% event14))]
# Event 256
event256_dclp3 = read.csv("~/OneDrive - The University of Colorado Denver/Control IQ/cgmdata/cgmdata/dclp3/dclp3_256_202010301759.csv")
event256_dclp5 = read.csv("~/OneDrive - The University of Colorado Denver/Control IQ/cgmdata/cgmdata/dclp5/dclp5_256_202010301801.csv")
event256 = unique(c(event256_dclp3$serialnumber,event256_dclp5$serialnumber))
missing_256 = sns[which(!(sns %in% event256))]
# Missing
missing = cbind(missing_14,c(missing_171,rep(NA,20)),c(missing_256,rep(NA,8)))
colnames(missing) = c("missing_14","missing_171","missing_256")

# Check files
files = list.files("/Users/timvigers/OneDrive - The University of Colorado Denver/Control IQ/Control-IQ",full.names = T)
l = lapply(files, function(f){
  t = read.csv(f)
  t$pump_serial_number[1]
})

file_check = unlist(l)

files = list.files("/Users/timvigers/OneDrive - The University of Colorado Denver/Control IQ/Controls",full.names = T)
l = lapply(files, function(f){
  t = read.csv(f)
  t$pump_serial_number[1]
})

file_check = c(file_check,unlist(l))

missing[missing %in% file_check] = NA

write.csv(missing,"missing_sns.csv",row.names = F,na="")
