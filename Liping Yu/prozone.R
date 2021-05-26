library(skimr)

data <- read.csv("B:\\Projects\\Liping Yu\\Prozone\\Copy of Prozone yes or no.csv")

skim(data)


hist(data$index)
hist(data[data$index<5000,]$index)

hist(data$cps)

data$log_cps <- log(data$cps)
data$log_index <- log(data$index)

# do not appear to be log-normal
hist(data$log_cps)
hist(data$log_index)
