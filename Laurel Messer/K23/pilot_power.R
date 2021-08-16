# Lower and upper sample size limit
n = seq(2,1000)
# CI
ci = 0.8
# Standardized effect size
d = 0.15
# Upper 
t = d * sqrt(n)/2
p = pt(t,df = n-1)
# Minimum sample size
max(which(p <= ci)) + 1

# From Cocks K, Torgerson DJ. Sample size calculations for pilot randomized 
#  trials: a confidence interval approach. J Clin Epidemiol. 2013;66(2):197-201. 
#  doi:10.1016/j.jclinepi.2012.09.002

# SD of TIR = 15%
# clinically meaningful change is 5-10%

# Standardized effect size of 0.33 (i.e., 5%/15%)
# Lower and upper sample size limit
n = seq(2,1000)
# CI
ci = 0.8
# Standardized effect size
d = 0.33
# Upper 
t = d * sqrt(n)/2
p = pt(t,df = n-1)
# Minimum sample size
max(which(p <= ci)) + 1
# N=26

# Standardized effect size of 0.66 (i.e., 10%/15%)
# Lower and upper sample size limit
n = seq(2,1000)
# CI
ci = 0.8
# Standardized effect size
d = 0.66
# Upper 
t = d * sqrt(n)/2
p = pt(t,df = n-1)
# Minimum sample size
max(which(p <= ci)) + 1
# N=7