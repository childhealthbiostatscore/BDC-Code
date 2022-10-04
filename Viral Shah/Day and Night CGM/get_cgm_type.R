library(tidyverse)
df = read.csv("/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/Day and Night CGM/Data_Clean/analysis_data_jdrf.csv")
df = df %>% group_by(id) %>% slice_max(sensor_readings)

t = apply(df,1, function(r){
  id = as.numeric(r["id"])
  vis = as.numeric(r["visit"])
  if(id<200){
    fol = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/JDRF/Data_Raw/13. JDRF_TIR/3. Data Collection/Cleaned Final Data/Group 1/Cases_T1D+DR/"
    id = paste("Case",str_pad(id,3,"left","0"))
    sub_fol = paste0(fol,id)
  } else if(id>=200){
    fol = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/JDRF/Data_Raw/13. JDRF_TIR/3. Data Collection/Cleaned Final Data/Group 2/Control_T1D+No DR/"
    id = paste("Control",id)
    sub_fol = paste0(fol,id)
  }
  files = list.files(sub_fol)
  f = files[grep(paste0("visit ",vis,"_","|",
                        "visit ",str_pad(vis,2,"left","0"),"_","|",
                        "visit ",str_pad(vis,2,"left","0")," ","|",
                        "visit ",vis," "),
                 
                 tolower(files))]
  if(length(f)==0){
    return(NA)
  } else {
    f = f[1]
    t = read.csv(paste0(sub_fol,"/",f))
    if(ncol(t)==14){
      return("dexcom")
    } else if (ncol(t)>45){
      return("carelink")
    } else if (ncol(t)==19){
      return("freestyle")
    } else {
      return(NA)
    }
  }
})
