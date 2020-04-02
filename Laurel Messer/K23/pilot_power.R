# Lower and upper sample size limit
n = seq(2,1000)
# Standardized effect size
effect = 0.3
# Upper 
t = lapply(n, function(n){
  qt(1-0.05,n-1)/sqrt(n)
})
# Minimum sample size
n[which.max(t <= effect)]