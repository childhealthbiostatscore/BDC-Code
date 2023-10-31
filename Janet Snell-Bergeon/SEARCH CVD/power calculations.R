# Aim 2 design effect
# effective sample size = (m * k)/DE
# DE = 1 + rho * (m - 1)
# m = number of subjects in cluster
# k = number of clusters
# rho = ICC

# for search, # of subjects is # of observations per subject
m <- 6
# for search, # of clusters is # of subjects
k <- 1000
DE <- 1 + (0.7 * (m - 1))
ESS <- k / DE




# Aim 3 mediation - ended up not using this 

library(powerMediation)

# minimum detectable slope for mediator given sample size and power in simple linear regression
# using Vittinghoff, Sen, and McCulloch's method

minEffect.VSMc(n=1000, power=0.8, sigma.m = 1, sigma.e = 1, 
               corr.xm = 0.5, alpha=0.05, verbose=TRUE)
# the problem is that I don't know sigma.m or sigma.e

