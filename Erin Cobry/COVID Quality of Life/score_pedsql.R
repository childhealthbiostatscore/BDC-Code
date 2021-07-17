############
# AGES 5-7 #
############

# read in data from children ages 5-7
data57 <- read.csv("B:\\Projects\\Erin Cobry\\COVID Quality of Life\\Data_Raw\\HealthRelatedQuality-PedsQLAges57_DATA_2021-07-15_1431.csv",na.strings = c("",NA))
# first we need to fix scoring
data57$"pedsql_child_self_report_ages_57_complete" <- NULL
temp <- rep(NA,ncol(data57)*nrow(data57))
fixed57 <- as.data.frame(matrix(temp,nrow=nrow(data57),ncol=ncol(data57)))
fixed57[,1:2] <- data57[,1:2]
for (i in 3:ncol(data57)) {
  fixed57[,i] <- ifelse(data57[,i]==1,0,
                       ifelse(data57[,i]==2,2,4))
}
colnames(fixed57) <- colnames(data57)
temp <- NULL
# reverse scoring
temp <- rep(NA,ncol(data57)*nrow(data57))
reverse57 <- as.data.frame(matrix(temp,nrow=nrow(data57),ncol=ncol(data57)))
reverse57[,1:2] <- data57[,1:2]
for (i in 3:ncol(fixed57)) {
  reverse57[,i] <- ifelse(fixed57[,i]==0,100,
                        ifelse(fixed57[,i]==2,50,
                               ifelse(fixed57[,i]==4,0,NA)))
}
colnames(reverse57) <- colnames(fixed57)
temp <- NULL
# scale names
diabetes <- c("ychild_hungry","ychild_thirsty","ychild_bathroom","ychild_stomachache","ychild_headaches","ychild_low",        
              "ychild_tired","ychild_shaky","ychild_sweaty","ychild_sleeping","ychild_irritable")
tx1 <- c("ychild_finger","ychild_embarrassed","ychild_argue","ychild_plan")
tx2 <- c( "ychild_tests","ychild_shots","ychild_exercise","ychild_carb","ychild_id","ychild_carry","ychild_snacks")
worry <- c("ychild_go_low","ychild_worry_treat","ychild_problem")
comm <- c("ychild_doctors","ychild_ask","ychild_explain")
# count number of missing responses in each scale
reverse57$nmissdiabetes <- apply(is.na(reverse57[,diabetes]), 1, sum)
reverse57$nmisstx1 <- apply(is.na(reverse57[,tx1]), 1, sum)
reverse57$nmisstx2 <- apply(is.na(reverse57[,tx2]), 1, sum)
reverse57$nmissworry <- apply(is.na(reverse57[,worry]), 1, sum)
reverse57$nmisscomm <- apply(is.na(reverse57[,comm]), 1, sum)
# if <=50% of items are completed, impute mean of completed scale for missing values
for (i in 3:(length(diabetes)+3)) {
  for (j in 1:nrow(reverse57)) {
    reverse57[j,i] <- ifelse(reverse57[j,]$nmissdiabetes>0 & reverse57[j,]$nmissdiabetes<(length(reverse57[j,]$nmissdiabetes)*0.5) & is.na(reverse57[j,i]),
           apply(reverse57[j,diabetes],1,mean,na.rm=T),reverse57[j,i])
  }
}
for (i in 3:(length(tx1)+3)) {
  for (j in 1:nrow(reverse57)) {
    reverse57[j,i] <- ifelse(reverse57[j,]$nmisstx1>0 & reverse57[j,]$nmisstx1<(length(reverse57[j,]$nmisstx1)*0.5) & is.na(reverse57[j,i]),
                             apply(reverse57[j,tx1],1,mean,na.rm=T),reverse57[j,i])
  }
}
for (i in 3:(length(tx2)+3)) {
  for (j in 1:nrow(reverse57)) {
    reverse57[j,i] <- ifelse(reverse57[j,]$nmisstx2>0 & reverse57[j,]$nmisstx2<(length(reverse57[j,]$nmisstx1)*0.5) & is.na(reverse57[j,i]),
                             apply(reverse57[j,tx2],1,mean,na.rm=T),reverse57[j,i])
  }
}
# THE ABOVE IS NOT WORKING RIGHT

# clean up
diabetes <- NULL
tx1 <- NULL
tx2 <- NULL
worry <- NULL
comm <- NULL

#############
# AGES 8-17 #
#############

# read in data from children ages 8-17
data817 <- read.csv("B:\\Projects\\Erin Cobry\\COVID Quality of Life\\Data_Raw\\HealthRelatedQuality-PedsQLAges817_DATA_2021-07-15_1433.csv",na.strings = c("",NA))
# first we need to fix scoring
data817$"pedsql_child_self_report_ages_817_complete" <- NULL
temp <- rep(NA,ncol(data817)*nrow(data817))
fixed817 <- as.data.frame(matrix(temp,nrow=nrow(data817),ncol=ncol(data817)))
fixed817[,1:2] <- data817[,1:2]
for (i in 3:ncol(data817)) {
  fixed817[,i] <- ifelse(data817[,i]==1,0,
                        ifelse(data817[,i]==2,1,
                               ifelse(data817[,i]==3,2,
                                      ifelse(data817[,i]==4,3,
                                             ifelse(data817[,i]==5,4,NA)))))
}
colnames(fixed817) <- colnames(data817)
temp <- NULL
# reverse scoring
temp <- rep(NA,ncol(data817)*nrow(data817))
reverse817 <- as.data.frame(matrix(temp,nrow=nrow(data817),ncol=ncol(data817)))
reverse817[,1:2] <- data817[,1:2]
for (i in 3:ncol(fixed817)) {
  reverse817[,i] <- ifelse(fixed817[,i]==0,100,
                          ifelse(fixed817[,i]==1,75,
                                 ifelse(fixed817[,i]==2,50,
                                        ifelse(fixed817[,i]==3,25,
                                               ifelse(fixed817[,i]==4,0,NA)))))
}
colnames(reverse817) <- colnames(fixed817)
temp <- NULL
# scale names
diabetes <- c("feel_hungry","feel_thirsty","bathroom_often","have_stomachaches","have_headaches",
              "go_low","tired_fatigued","get_shaky","get_sweaty","sleeping_trouble","get_irritable")
tx1 <- c("hurts_shots","embarrasses_diabetes","argue_parents","hard_care_plan")
tx2 <- c("hard_tests","hard_shots","hard_exercise","hard_carbohydrates","hard_id","hard_fast_acting","hard_snacks")
worry <- c("worry_low","worry_treatments","worry_complications")
comm <- c("hard_doctors","hard_ask","hard_explain")
# count number of missing responses in each scale
reverse817$nmissdiabetes <- apply(is.na(reverse817[,diabetes]), 1, sum)
reverse817$nmisstx1 <- apply(is.na(reverse817[,tx1]), 1, sum)
reverse817$nmisstx2 <- apply(is.na(reverse817[,tx2]), 1, sum)
reverse817$nmissworry <- apply(is.na(reverse817[,worry]), 1, sum)
reverse817$nmisscomm <- apply(is.na(reverse817[,comm]), 1, sum)
# clean up
diabetes <- NULL
tx1 <- NULL
tx2 <- NULL
worry <- NULL
comm <- NULL


############
# PARENTS  #
############

# read in parent data for ages 5-17
dataparent <- read.csv("B:\\Projects\\Erin Cobry\\COVID Quality of Life\\Data_Raw\\HealthRelatedQuality-PedsQLParentProxyAge_DATA_2021-07-15_1451.csv",na.strings = c("",NA))
# first we need to fix scoring
dataparent$pedsql_parent_proxy_all_ages_complete <- NULL
temp <- rep(NA,ncol(dataparent)*nrow(dataparent))
fixedparent <- as.data.frame(matrix(temp,nrow=nrow(dataparent),ncol=ncol(dataparent)))
fixedparent[,1:2] <- dataparent[,1:2]
for (i in 3:ncol(dataparent)) {
  fixedparent[,i] <- ifelse(dataparent[,i]==1,0,
                         ifelse(dataparent[,i]==2,1,
                                ifelse(dataparent[,i]==3,2,
                                       ifelse(dataparent[,i]==4,3,
                                              ifelse(dataparent[,i]==5,4,NA)))))
}
colnames(fixedparent) <- colnames(dataparent)
temp <- NULL
# reverse scoring
temp <- rep(NA,ncol(dataparent)*nrow(dataparent))
reverseparent <- as.data.frame(matrix(temp,nrow=nrow(dataparent),ncol=ncol(dataparent)))
reverseparent[,1:2] <- dataparent[,1:2]
for (i in 3:ncol(fixedparent)) {
  reverseparent[,i] <- ifelse(fixedparent[,i]==0,100,
                           ifelse(fixedparent[,i]==1,75,
                                  ifelse(fixedparent[,i]==2,50,
                                         ifelse(fixedparent[,i]==3,25,
                                                ifelse(fixedparent[,i]==4,0,NA)))))
}
colnames(reverseparent) <- colnames(fixedparent)
temp <- NULL
# scale names
diabetes <- c("hungry","thirsty","bathroom","stomachaches","headaches","low","tired",            
              "shaky","sweaty","trouble_sleeping","irritable")
tx1 <- c("pain","arguing","embarrassed","plan" )
tx2 <- c("tests","shots","exercise","cho","id","fast_acting,snacks")
worry <- c("going_low","working","complications")
comm <- c("feels","questions","explaining")
# count number of missing responses in each scale
reverseparent$nmissdiabetes <- apply(is.na(reverseparent[,diabetes]), 1, sum)
reverseparent$nmisstx1 <- apply(is.na(reverseparent[,tx1]), 1, sum)
reverseparent$nmisstx2 <- apply(is.na(reverseparent[,tx2]), 1, sum)
reverseparent$nmissworry <- apply(is.na(reverseparent[,worry]), 1, sum)
reverseparent$nmisscomm <- apply(is.na(reverseparent[,comm]), 1, sum)
# clean up
diabetes <- NULL
tx1 <- NULL
tx2 <- NULL
worry <- NULL
comm <- NULL