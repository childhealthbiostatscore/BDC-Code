peds_surveys = c("c_paid","c_hfs_maintain","c_hfs_helpless","c_hfs_worry","c_inspire",
            "ya_paid","ya_hfs_behave","ya_hfs_worry","adult_inspire","c_tech")
peds_scores = function(df){
  # Score surveys
  scores = t(apply(df,1,function(r){
    # PAID
    c_paid = as.numeric(r[grep("c_paid\\d{,2}$",names(r))])
    c_paid = mean(5 - c_paid,na.rm = T)*25
    ya_paid = as.numeric(r[grep("ya_paid\\d{,2}$",names(r))])
    ya_paid = sum(ya_paid)*1.25
    # HFS Peds
    c_hfs_maintain = sum(as.numeric(r[grep("c_hfs_behave[347]$",names(r))]))
    c_hfs_helpless = 
      sum(as.numeric(r[paste0("c_hfs_worry",c(11,12,13,14,16,18,19,22,23))]))
    c_hfs_worry = 
      sum(as.numeric(r[paste0("c_hfs_worry",c(15,17,20,21,25))]))
    # HFS YA
    ya_hfs_behave = sum(as.numeric(r[grep("ya_hfs_f_behave\\d{,2}$",names(r))]))
    ya_hfs_worry = sum(as.numeric(r[grep("ya_hfs_f_worry\\d{,2}$",names(r))]))
    # INSPIRE Youth
    c_inspire = as.numeric(r[grep("inspire_[[:alnum:]]{,3}$",names(r))])
    c_inspire[c_inspire == 5] = NA
    c_inspire = mean(c_inspire,na.rm = T)*25
    # INSPIRE Adult
    adult_inspire = as.numeric(r[grep("inspire_[[:alnum:]]{,3}_adult$",names(r))])
    adult_inspire[adult_inspire == 5] = NA
    adult_inspire = mean(adult_inspire,na.rm = T)*25
    # Tech survey
    c_tech = as.numeric(r[grep("tech\\d{,2}$",names(r))]) + 1
    c_tech = sum(c_tech)
    # Return all
    return(c(c_paid,c_hfs_maintain,c_hfs_helpless,c_hfs_worry,c_inspire,
             ya_paid,ya_hfs_behave,ya_hfs_worry,adult_inspire,c_tech))
  }))
  colnames(scores) = peds_surveys
  scores[is.nan(scores)] = NA
  scores = data.frame(scores)
  # Bind
  df = cbind(df,scores)
  return(as.data.frame(df))
}
# Parent surveys are in wide format
parent_scores = function(df){
  # Score surveys
  scores = t(apply(df,1,function(r){
    # PAID
    p_paid_b = 5 - as.numeric(r[grep("p_paid\\d{,2}_b$",names(r))])
    p_paid_m1 = 5 - as.numeric(r[grep("p_paid\\d{,2}$",names(r))])
    p_paid_t1 = 5 - as.numeric(r[grep("p_paid\\d{,2}_t1$",names(r))])
    p_paid_t2 = 5 - as.numeric(r[grep("p_paid\\d{,2}_t2$",names(r))])
    p_paid_t3 = 5 - as.numeric(r[grep("p_paid\\d{,2}_t3$",names(r))])
    p_paid_t4 = 5 - as.numeric(r[grep("p_paid\\d{,2}_t4$",names(r))])
    p_paid = list(p_paid_b,p_paid_m1,p_paid_t1,p_paid_t2,p_paid_t3,p_paid_t4)
    p_paid = sapply(p_paid,function(x){mean(x,na.rm = T)*25})
    names(p_paid) = c("p_paid_b","p_paid_m1","p_paid_t1","p_paid_t2","p_paid_t3","p_paid_t4")
    # HFS maintain
    p_hfs_maintain_b =  sum(as.numeric(r[grep("p_hfs_b_behave[347]$",names(r))]))
    p_hfs_maintain_m1 = sum(5 - as.numeric(r[grep("p_hfs_behave[347]$",names(r))]))
    p_hfs_maintain_t1 = sum(5 - as.numeric(r[grep("p_hfs_behave[347]_t1$",names(r))]))
    p_hfs_maintain_t2 = sum(5 - as.numeric(r[grep("p_hfs_behave[347]_t2$",names(r))]))
    p_hfs_maintain_t3 = sum(5 - as.numeric(r[grep("p_hfs_behave[347]_t3$",names(r))]))
    p_hfs_maintain_t4 = sum(5 - as.numeric(r[grep("p_hfs_behave[347]_t4$",names(r))]))
    p_hfs_maintain = c(p_hfs_maintain_b,p_hfs_maintain_m1,p_hfs_maintain_t1,p_hfs_maintain_t2,
                         p_hfs_maintain_t3,p_hfs_maintain_t4)
    names(p_hfs_maintain) = c("p_hfs_maintain_b","p_hfs_maintain_m1","p_hfs_maintain_t1",
                                "p_hfs_maintain_t2","p_hfs_maintain_t3",
                                "p_hfs_maintain_t4")
    # HFS helpless
    p_hfs_helpless_b =  sum(as.numeric(r[paste0("p_hfs_b_worry",c(12,13,14,15,17,20,23,24,25,26))]))
    p_hfs_helpless_m1 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(12,13,14,15,17,20,23,24,25,26))]))
    p_hfs_helpless_t1 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(12,13,14,15,17,20,23,24,25,26),"_t1")]))
    p_hfs_helpless_t2 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(12,13,14,15,17,20,23,24,25,26),"_t2")]))
    p_hfs_helpless_t3 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(12,13,14,15,17,20,23,24,25,26),"_t3")]))
    p_hfs_helpless_t4 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(12,13,14,15,17,20,23,24,25,26),"_t4")]))
    p_hfs_helpless = c(p_hfs_helpless_b,p_hfs_helpless_m1,p_hfs_helpless_t1,p_hfs_helpless_t2,
                         p_hfs_helpless_t3,p_hfs_helpless_t4)
    names(p_hfs_helpless) = c("p_hfs_helpless_b","p_hfs_helpless_m1","p_hfs_helpless_t1",
                                "p_hfs_helpless_t2","p_hfs_helpless_t3",
                                "p_hfs_helpless_t4")
    # HFS worry
    p_hfs_worry_b =  sum(as.numeric(r[paste0("p_hfs_b_worry",c(16,18,19,21,22))]))
    p_hfs_worry_m1 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(16,18,19,21,22))]))
    p_hfs_worry_t1 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(16,18,19,21,22),"_t1")]))
    p_hfs_worry_t2 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(16,18,19,21,22),"_t2")]))
    p_hfs_worry_t3 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(16,18,19,21,22),"_t3")]))
    p_hfs_worry_t4 = sum(5 - as.numeric(r[paste0("p_hfs_worry",c(16,18,19,21,22),"_t4")]))
    p_hfs_worry = c(p_hfs_worry_b,p_hfs_worry_m1,p_hfs_worry_t1,p_hfs_worry_t2,
                         p_hfs_worry_t3,p_hfs_worry_t4)
    names(p_hfs_worry) = c("p_hfs_worry_b","p_hfs_worry_m1","p_hfs_worry_t1",
                                "p_hfs_worry_t2","p_hfs_worry_t3",
                                "p_hfs_worry_t4")
    # INSPIRE
    p_inspire_b = as.numeric(r[grep("p_b_inspire\\d{,2}$",names(r))])
    p_inspire_t1 = as.numeric(r[grep("p_inspire\\d{,2}_t1$",names(r))])
    p_inspire_t2 = as.numeric(r[grep("p_inspire\\d{,2}_t2$",names(r))])
    p_inspire_t3 = as.numeric(r[grep("p_inspire\\d{,2}_t3$",names(r))])
    p_inspire_t4 = as.numeric(r[grep("p_inspire\\d{,2}_t4$",names(r))])
    p_inspire = list(p_inspire_b,p_inspire_t1,p_inspire_t2,p_inspire_t3,p_inspire_t4)
    p_inspire = sapply(p_inspire,function(x){
      x[x==5] = NA
      mean(x,na.rm = T)*25
      })
    names(p_inspire) = c("p_inspire_b","p_inspire_t1","p_inspire_t2","p_inspire_t3","p_inspire_t4")
    # Technology attitudes
    p_tech = sum(as.numeric(r[grep("tech\\d{,2}$",names(r))]) + 1)
    names(p_tech) = "p_tech_b"
    # Return all
    return(c(p_paid,p_hfs_maintain,p_hfs_helpless,p_hfs_worry,p_inspire,p_tech))
  }))
  scores[is.nan(scores)] = NA
  scores = data.frame(scores)
  # Bind
  df = cbind(df,scores)
  return(as.data.frame(df))
}
