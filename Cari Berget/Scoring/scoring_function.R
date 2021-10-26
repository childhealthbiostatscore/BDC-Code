surveys = c("c_paid","c_hfs_maintain","c_hfs_helpless","c_hfs_worry","c_inspire",
            "ya_paid","ya_hfs_behave","ya_hfs_worry","adult_inspire","tech")
score_for_cari = function(df){
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
    tech = as.numeric(r[grep("tech\\d{,2}$",names(r))]) + 1
    tech = sum(tech)
    # Return all
    return(c(c_paid,c_hfs_maintain,c_hfs_helpless,c_hfs_worry,c_inspire,
             ya_paid,ya_hfs_behave,ya_hfs_worry,adult_inspire,tech))
  }))
  colnames(scores) = surveys
  scores[is.nan(scores)] = NA
  scores = data.frame(scores)
  # Bind
  df = cbind(df,scores)
  return(as.data.frame(df))
}
