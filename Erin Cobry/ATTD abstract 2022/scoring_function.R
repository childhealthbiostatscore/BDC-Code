library(lubridate)
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
    # Latency
    q2 = as.character(r["psqi_2"])
    if(q2 != ""){
      q2 = as.numeric(as.duration(hm(q2)))/60
      q2 = cut(q2,c(-Inf,15,30,60,Inf),c(0,1,2,3),right = T)
      q2 = as.numeric(as.character(q2))
    } else {q2 = NA}
    # Need Q5a but not sure where it is
    
    # Day dysfunction
    psqidaydys = as.numeric(r["psqi_8"] + r["psqi_9"])
    if(!is.na(psqidaydys)){
      psqidaydys = cut(psqidaydys,c(-Inf,0,2,4,6),c(0,1,2,3),right = T)
      psqidaydys = as.numeric(as.character(psqidaydys))
    }
    # Overall quality
    psqislpqual = as.numeric(r["psqi_6t"])
    # Need meds
    psqimeds = as.numeric(r["psqi_7t"])
  }))
}
