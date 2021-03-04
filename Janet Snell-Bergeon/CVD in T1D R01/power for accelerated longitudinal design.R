 # code from Moerbeek

nr.cohorts <- 12 ### number of cohorts
var.e <- 5 ### variance random error
D <- matrix(0, 2, 2) ### covariance matrix
D[1, 1] <- 1 ### variance random intercept
D[2, 2] <- 1 ### variance random slope
D[1, 2] <- -0.1 ### covariance random intercept and slope
D[2, 1] <- -0.1
delta <- 0.32 ### standardized effect size

age1 <- c(30, 32.5) ### age stages of measurement cohort 1
age2 <- c(32.5, 35) ### age stages of measurement cohort 2
age3 <- c(35, 37.5) ### age stages of measurement cohort 3
age4 <- c(37.5, 40)### age stages of measurement cohort 4
age5 <- c(40, 42.5)
age6 <- c(42.5, 45)
age7 <- c(45, 47.5)
age8 <- c(47.5, 50)
age9 <- c(50, 52.5)
age10 <- c(52.5, 55)
age11 <- c(55, 57.5)
age12 <- c(57.5, 60)

X1 <- cbind(rep(1,length(age1)),age1) ### design matrix fixed part cohort 1
Z1 <- X1 ### design matrix random part cohort 1
X2 <- cbind(rep(1,length(age2)),age2) ### design matrix fixed part cohort 2
Z2 <- X2 ### design matrix random part cohort 2
X3 <- cbind(rep(1,length(age3)),age3) ### design matrix fixed part cohort 3
Z3 <- X3 ### design matrix random part cohort 3
X4 <- cbind(rep(1,length(age4)),age4) ### design matrix fixed part cohort 4
Z4 <- X4 ### design matrix random part cohort 4
X5 <- cbind(rep(1,length(age5)),age5) ### design matrix fixed part cohort 5
Z5 <- X5 ### design matrix random part cohort 5
X6 <- cbind(rep(1,length(age6)),age6) ### design matrix fixed part cohort 6
Z6 <- X6 ### design matrix random part cohort 6
X7 <- cbind(rep(1,length(age7)),age7) ### design matrix fixed part cohort 7
Z7 <- X7 ### design matrix random part cohort 7
X8 <- cbind(rep(1,length(age8)),age8) ### design matrix fixed part cohort 8
Z8 <- X8 ### design matrix random part cohort 8
X9 <- cbind(rep(1,length(age9)),age9) ### design matrix fixed part cohort 9
Z9 <- X9 ### design matrix random part cohort 9
X10 <- cbind(rep(1,length(age10)),age10) ### design matrix fixed part cohort 10
Z10 <- X10 ### design matrix random part cohort 10
X11 <- cbind(rep(1,length(age11)),age11) ### design matrix fixed part cohort 11
Z11 <- X11 ### design matrix random part cohort 11
X12 <- cbind(rep(1,length(age12)),age12) ### design matrix fixed part cohort 12
Z12 <- X12 ### design matrix random part cohort 12

I1 <- diag(length(age1))
V1 <- Z1 %*% D %*% t(Z1) + var.e * I1 ### covariance matrix of responses cohort 1
I2 <- diag(length(age2))
V2 <- Z2 %*% D %*% t(Z2) + var.e * I2 ### covariance matrix of responses cohort 2
I3 <- diag(length(age3)) 
V3 <- Z3 %*% D %*% t(Z3) + var.e * I3 ### covariance matrix of responses cohort 3
I4 <- diag(length(age4)) 
V4 <- Z4 %*% D %*% t(Z4) + var.e * I4 ### covariance matrix of responses cohort 4
I5 <- diag(length(age5)) 
V5 <- Z5 %*% D %*% t(Z5) + var.e * I5 ### covariance matrix of responses cohort 5
I6 <- diag(length(age6)) 
V6 <- Z6 %*% D %*% t(Z6) + var.e * I6 ### covariance matrix of responses cohort 6
I7 <- diag(length(age7)) 
V7 <- Z7 %*% D %*% t(Z7) + var.e * I7 ### covariance matrix of responses cohort 7
I8 <- diag(length(age8)) 
V8 <- Z8 %*% D %*% t(Z8) + var.e * I8 ### covariance matrix of responses cohort 8
I9 <- diag(length(age9)) 
V9 <- Z9 %*% D %*% t(Z9) + var.e * I9 ### covariance matrix of responses cohort 9
I10 <- diag(length(age10)) 
V10 <- Z10 %*% D %*% t(Z10) + var.e * I10 ### covariance matrix of responses cohort 10
I11 <- diag(length(age11)) 
V11 <- Z11 %*% D %*% t(Z11) + var.e * I11 ### covariance matrix of responses cohort 11
I12 <- diag(length(age12)) 
V12 <- Z12 %*% D %*% t(Z12) + var.e * I12 ### covariance matrix of responses cohort 12

### calculate and plot power as a function of the total number of subjects
plot.new()
nr.subjects <- c(204)
power <- rep(0, length(nr.subjects))
for(ii in 1:length(nr.subjects)) {
  XVX <- ((t(X1) %*% solve(V1) %*% X1 
           + t(X2) %*%solve(V2) %*% X2
           + t(X3) %*% solve(V3) %*% X3 
           + t(X4) %*% solve(V4) %*% X4
           + t(X5) %*% solve(V5) %*% X5
           + t(X6) %*% solve(V6) %*% X6
           + t(X7) %*% solve(V7) %*% X7
           + t(X8) %*% solve(V8) %*% X8
           + t(X9) %*% solve(V9) %*% X9
           + t(X10) %*% solve(V10) %*% X10
           + t(X11) %*% solve(V11) %*% X11
           + t(X12) %*% solve(V12) %*% X12           ) 
          * nr.subjects[ii])/nr.cohorts
  var.beta <- solve(XVX)
  power[ii] <- pnorm((delta * sqrt(D[2, 2]))/sqrt(var.beta[2, 2])- qnorm(0.975))
}
plot(nr.subjects, power, type = "l", ylim=c(0,1))
temp <- cbind(nr.subjects,power)
print(temp)

### calculate and plot power as a function of the total number of measurements
nr.measurements <- c(50, 100, 150, 200, 250, 300, 350, 400, 450, 500)
nr.subjects <- nr.measurements/(length(c(age1, age2, age3))/nr.cohorts)
power <- rep(0, length(nr.measurements))
for(ii in 1:length(nr.measurements)) {
  XVX <- ((t(X1) %*% solve(V1) %*% X1 + t(X2) %*%solve(V2) %*% X2
  + t(X3) %*% solve(V3) %*% X3 + t(X4) %*% solve(V4) %*% X4) * nr.subjects[ii])/nr.cohorts
  var.beta <- solve(XVX)
  power[ii] <- pnorm((delta  * sqrt(D[2, 2]))/sqrt(var.beta[2, 2])- qnorm(0.975))
}
plot(nr.measurements, power, type = "l", ylim=c(0,1))
