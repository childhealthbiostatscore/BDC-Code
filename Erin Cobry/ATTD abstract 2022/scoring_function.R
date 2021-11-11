require(tidyverse)
require(lubridate)
psqi_scores = function(df){
  # Score surveys
  scores = t(apply(df,1,function(r){
    # Duration
    psqidurat = as.character(r["psqi_4"])
    if(psqidurat != ""){
      psqidurat = as.numeric(as.duration(hm(psqidurat)))/3600
      psqidurat = cut(psqidurat,c(-Inf,5,6,7,Inf),c(3,2,1,0),right = F)
      psqidurat = as.numeric(as.character(psqidurat))
    } else {psqidurat = NA}
    # Disturbance
    q5b_j = r %>% select(wake_up:other)
    if(is.na(q5b_j["other"])){q5b_j["other"] = 1}
    psqidistb = sum(as.numeric(q5b_j)-1)
    psqidistb = cut(psqidistb,c(-Inf,0,9,18,Inf),c(0,1,2,3),right = T)
    # Latency
    q2 = as.character(r["psqi_2"])
    if(q2 != ""){
      q2 = as.numeric(as.duration(hm(q2)))/60
      q2 = cut(q2,c(-Inf,15,30,60,Inf),c(0,1,2,3),right = T)
      q2 = as.numeric(as.character(q2))
    } else {q2 = NA}
    q5a = as.numeric(r["minutes"])-1
    psqilaten = q5a + q2
    # Day dysfunction
    psqidaydys = as.numeric(r["psqi_8"] + r["psqi_9"])
    if(!is.na(psqidaydys)){
      psqidaydys = cut(psqidaydys,c(-Inf,0,2,4,6),c(0,1,2,3),right = T)
      psqidaydys = as.numeric(as.character(psqidaydys))
    }
    # Sleep efficiency
    ## Parse q1 and q3 free text 
    q1 = as.character(r["psqi_1"])
    if(agrepl(trimws(tolower(q1)),"midnight")){q1 = "12:00pm"}
    q1 = as.character(sapply(str_split(q1,"or|to|-")[[1]],trimws))
    if(length(q1) > 1){q1 = paste0(q1[1],":30")}
    q1 = parse_date_time(q1,orders = c("%H:%M","%H%Op","%H %Op"))
    q3 = as.character(r["psqi_3"])
    if(agrepl(trimws(tolower(q3)),"midnight")){q3 = "12:00pm"}
    q3 = as.character(sapply(str_split(q3,"or|to|-")[[1]],trimws))
    if(length(q3) > 1){q3 = paste0(q3[1],":30")}
    q3 = parse_date_time(q3,orders = c("%H:%M","%H%Op","%H %Op"))
    # Overall quality
    psqislpqual = as.numeric(r["psqi_6t"])
    # Need meds
    psqimeds = as.numeric(r["psqi_7t"])
    # Output
    return(c(psqidurat,q2,psqidaydys,psqislpqual,psqimeds))
  }))
}
