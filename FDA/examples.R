library(refund.shiny)
library(refund)

# Diffusion tensor imaging dataset 
# Cerebral white matter tracts (collections of axons) for MS patients and healthy controls
# DTI is a method to quantify white matter integrity
# Dataset contains tract profiles for 142 participants across multiple visits
# Also includes covariates: Paced Auditory Serial Addition Test (PASAT) score (brain reactivity and attention span) and sex
data(DTI)

# FPCA
fit.fpca = fpca.sc(Y=DTI$cca)
summary(fit.fpca)
fit.fpca$efunctions
plot_shiny(obj=fit.fpca)

# function on scalar regression
DTI = DTI[complete.cases(DTI),]
fit.fosr = bayes_fosr(cca ~ pasat + sex, data=DTI)
fit.fosr$beta.hat
plot_shiny(fit.fosr)
