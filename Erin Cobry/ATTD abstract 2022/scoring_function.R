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
    psqilaten = as.character(r["psqi_2"])
    if(psqilaten != ""){
      psqilaten = as.numeric(as.duration(hm(psqilaten)))/60
      psqilaten = cut(psqilaten,c(-Inf,15,30,60,Inf),c(0,1,2,3),right = T)
      psqilaten = as.numeric(as.character(psqilaten))
    } else {psqilaten = NA}
  }))
}
