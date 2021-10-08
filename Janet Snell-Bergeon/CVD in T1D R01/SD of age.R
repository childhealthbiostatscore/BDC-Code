sdsave <- NULL
for (i in 1:1000) {
  d <- runif(n=400,min=18,max=59)
  temp <- sd(d)
  sdsave <- c(sdsave,temp)
}
