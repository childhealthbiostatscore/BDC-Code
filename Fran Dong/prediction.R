library(survival)

data <- sas7bdat::read.sas7bdat("B:/Projects/Fran Dong/ASK predictive model/iacombined01062023.sas7bdat")
data$SEX <- as.factor(data$SEX)
data$SEX <- relevel(data$SEX, ref = "Male")


res.cox <- coxph(Surv(fup_t1D2, T1D_case) ~ as.factor(SEX) + as.factor(NHW) + as.factor(T1D_Fam) + HbA1c, data = data)

new <- read.csv("B:/Projects/Fran Dong/ASK predictive model/new.csv")

p1 <- predict(res.cox, data, type="survival")

p2 <- predict(res.cox, newdata = new, type="survival")
