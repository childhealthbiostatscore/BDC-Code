# Lower and upper sample size limit
n = seq(2,1000)
# CI
ci = 0.8
# Standardized effect size
d = 0.1
# Upper 
t = d * sqrt(n)/2
p = pt(t,df = n-1)
# Minimum sample size
max(which(p <= ci)) + 1
