# Original files
files <- list.files("/Users/timvigers/Documents/libre_cleaned",full.names = T)
summary = as.data.frame(matrix(nrow = 0,ncol = length(files)))
colnames(summary) <- rep("Record",length(files))
# Clean
for (f in 1:length(files)) {
  table <- read.csv(files[f],stringsAsFactors = FALSE,na.strings = c("NA",""))
  summary["ID",f] = sub("_V1.*","",basename(files[f]))
  summary["Mean Sensor Glucose",f] = mean(as.numeric(table$sensorglucose),na.rm = T)
  summary["SD Sensor Glucose",f] = sd(as.numeric(table$sensorglucose),na.rm = T)
  # High and low
  table$sensorglucose[table$sensorglucose == "High"] = 400
  table$sensorglucose[table$sensorglucose == "Low"] = 40
  table$sensorglucose = as.numeric(table$sensorglucose)
  # TIR
  summary["% really low <54",f] = round((sum(table$sensorglucose < 54,na.rm = T)/
                                    sum(!is.na(table$sensorglucose)))*100,2)
  summary["% low <70",f] = round((sum(table$sensorglucose < 70,na.rm = T)/
    sum(!is.na(table$sensorglucose)))*100,2)
  summary["% in range 70-180",f] = (sum(table$sensorglucose >= 70 & table$sensorglucose <= 180,na.rm = T)/
                                            sum(!is.na(table$sensorglucose)))*100
    
  summary["% high 180-249",f] = (sum(table$sensorglucose > 180 & table$sensorglucose < 250,na.rm = T)/
                                            sum(!is.na(table$sensorglucose)))*100
  summary["% really high 250+",f] = (sum(table$sensorglucose >= 250,na.rm = T)/
                                          sum(!is.na(table$sensorglucose)))*100
}
summary = t(summary)
summary = as.data.frame(apply(summary,2,function(c){round((as.numeric(c)),2)}))
write.csv(summary,file = "/Users/timvigers/Documents/libre_summary.csv",row.names = F,na="")
