psqi_scores = function(df){
  # Score surveys
  scores = t(apply(df,1,function(r){
    comp1 = as.numeric(r["psqi_6t"])
    # Q2
    q2 = as.character(r["psqi_2"])
    if(q2 == ""){q2 = NA} else {q2 = as.numeric(lubridate::hm(q2))/60}
    if(!is.na(q2)){
      if(q2 <= 15){c2 = 0} 
      else if (q2 <= 30){c2 = 1} 
      else if (q2 <= 60){c2 = 2} 
      else if (q2 > 60){c2 = 3}
    } else {c2 = NA}
    # q5a
    q5a = as.character(r["psqi_3"])
    if(q5a == ""){q5a = NA} else {q5a = as.numeric(lubridate::hm(q5a))/60}
    if(!is.na(q5a)){
      if(q5a <= 15){c3 = 0} 
      else if (q5a <= 30){c3 = 1} 
      else if (q5a <= 60){c3 = 2} 
      else if (q5a > 60){c3 = 3}
    } else {c3 = NA}
    # Comp 2
    co2 = c2 + c3
    if(!is.na(co2)){
      if (co2 == 0){comp2 = 0} 
      else if (co2 %in% 1:2){comp2 = 1}
      else if (co2 %in% 3:4){comp2 = 2}
      else if (co2 > 4){comp2 = 3}
    } else {comp2 = NA}
  }))
  # Comp3 
  q4 = as.character(r["psqi_3"])
  if(q4 == ""){q4 = NA} else {q4 = as.numeric(lubridate::hm(q4))/3600}
  if(!is.na(q4)){
    if(q4 > 7){c4 = 0} 
    else if (q4 > 6 & q4 <= 7){c4 = 1} 
    else if (q4 > 5 & q4 <= 6){c4 = 2} 
    else if (q4 <= 5){c4 = 3}
  } else {c4 = NA}
  
}
