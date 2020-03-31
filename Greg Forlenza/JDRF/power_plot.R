library(pROC)

ns = seq(from = 50,to = 300)
auc = lapply(ns, function(x){
  power = power.roc.test(ncontrols = x/2,ncases = x/2,power = 0.8)
  power$auc - 0.5
})

plot(ns,unlist(auc),type = "l",ylab = "Detectable AUC Difference (Above 0.5)",
     xlab = "Total Sample Size (1:1 cases:controls)")
