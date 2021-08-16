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
n[max(which(p <= ci))]

# From Cocks K, Torgerson DJ. Sample size calculations for pilot randomized 
#  trials: a confidence interval approach. J Clin Epidemiol. 2013;66(2):197-201. 
#  doi:10.1016/j.jclinepi.2012.09.002
