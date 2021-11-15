# PSQI questions 1, 3, and 4 were entered as free text, so psqi_4 need to be
# converted to a numeric value manually. The difference between psqi_3 and 
# psqi_1 (psqi_3_1) also needs to be calculated manually. psqi_2 needs to be 
# manually converted to minutes.
require(tidyverse)
require(lubridate)
psqi_scores = function(df){
  # Score surveys
  scores = t(apply(df,1,function(r){
    # Duration
    psqidurat = as.numeric(r["psqi_4"])
    if(!is.na(psqidurat)){
      psqidurat = cut(psqidurat,c(-Inf,5,6,7,Inf),c(3,2,1,0),right = F)
      psqidurat = as.numeric(as.character(psqidurat))
    } else {psqidurat = NA}
    # Disturbance
    q5b_j = r %>% select(wake_up:other)
    if(is.na(q5b_j["other"])){q5b_j["other"] = 1}
    psqidistb = sum(as.numeric(q5b_j)-1)
    psqidistb = cut(psqidistb,c(-Inf,0,9,18,Inf),c(0,1,2,3),right = T)
    # Latency
    q2 = as.numeric(r["psqi_2"])
    if(!is.na(q2)){
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
    
    # Overall quality
    psqislpqual = as.numeric(r["psqi_6t"])
    # Need meds
    psqimeds = as.numeric(r["psqi_7t"])
    # Output
    return(c(psqidurat,q2,psqidaydys,psqislpqual,psqimeds))
  }))
}
