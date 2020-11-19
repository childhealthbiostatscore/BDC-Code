library(stringr)
library(qdapRegex)
library(dplyr)
library(wmwpow)
library(fitdistrplus)

data <- read.csv("T:\\Marian Rewers\\DAISY\\Renewal proposal\\Virscan data\\Copy of virus_pep_NCPHIPzscores_DetectSpecie_counting_combined.csv")
row.names(data) <- data$X
data$X <- NULL
data <- as.data.frame(t(data))
data$id <- row.names(data)

# extract group infro
data$group <- NA
data$group <- ifelse(str_detect(data$id,"Healthy"),1,0)

# extract IDs
data$subject_id <- NA
for (i in 1:nrow(data)) {
  data[i,"subject_id"] <- qdapRegex::ex_between(data$id, ".", ".")[[i]][[1]]
}

# extract age
data$age <- NA
for (i in 1:nrow(data)) {
  data[i,"age"] <- as.numeric(qdapRegex::ex_between(data$id, "age.", ".A")[[i]][[1]])
}

# make dataset of data record for each person
data <- data[with(data,order(subject_id,age)),]
first <- data %>% group_by(subject_id) %>% filter(row_number()==1)

# EV A
summary(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_A`)
sd(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_A`)
summary(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_A`)
sd(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_A`)
sd(data$`Picornaviridae;Enterovirus;Enterovirus_A`)
wilcox.test(data$`Picornaviridae;Enterovirus;Enterovirus_A` ~ data$group)
wmwpowd(100,100,"norm(3.95,2.37)","norm(5.59,4.59)",alpha=0.05,sides = "two.sided",nsims=10000)
hist(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_A`)
hist(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_A`)
fit <- fitdist(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_A`,'exp')

# EV B
summary(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_B`)
sd(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_B`)
summary(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_B`)
sd(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_B`)
sd(data$`Picornaviridae;Enterovirus;Enterovirus_B`)
wilcox.test(data$`Picornaviridae;Enterovirus;Enterovirus_B` ~ data$group)
hist(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_B`)
hist(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_B`)
fit <- fitdist(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_B`,'exp') # rate=0.19
fit <- fitdist(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_B`,'exp') # rate=0.27

# EV C
summary(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_C`)
sd(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_C`)
summary(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_C`)
sd(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_C`)
sd(data$`Picornaviridae;Enterovirus;Enterovirus_C`)
wilcox.test(data$`Picornaviridae;Enterovirus;Enterovirus_C` ~ data$group)
wmwpowd(100,100,"norm(4.5,2.7)","norm(4.7,8.2)",alpha=0.05,sides = "two.sided",nsims=100)
hist(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_C`)
hist(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_C`)

fitc <- fitdist(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_C`,'exp')

# EV D
summary(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_D`)
sd(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_D`)
summary(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_D`)
sd(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_D`)
sd(data$`Picornaviridae;Enterovirus;Enterovirus_D`)
wilcox.test(data$`Picornaviridae;Enterovirus;Enterovirus_D` ~ data$group)
hist(data[data$group==0,]$`Picornaviridae;Enterovirus;Enterovirus_D`)
hist(data[data$group==1,]$`Picornaviridae;Enterovirus;Enterovirus_D`)
# these look normal

# plot data over time

p <- ggplot(data=data[data$group==0,],
            aes(x=age,y=`Picornaviridae;Enterovirus;Enterovirus_A`,group=subject_id)) + geom_line()
p + ggtitle("T1D")
p <- ggplot(data=data[data$group==1,],
            aes(x=age,y=`Picornaviridae;Enterovirus;Enterovirus_A`,group=subject_id)) + geom_line()
p + ggtitle("Control")

# for change over time, calculate max-min for each person
maxa <- aggregate(`Picornaviridae;Enterovirus;Enterovirus_A`~subject_id, data, function(x) max(x))
colnames(maxa) <- c("subject_id","maxa")
data <- merge(data,maxa, by="subject_id")
maxc <- aggregate(`Picornaviridae;Enterovirus;Enterovirus_C`~subject_id, data, function(x) max(x))
colnames(maxc) <- c("subject_id","maxc")
data <- merge(data,maxc, by="subject_id")
mina <- aggregate(`Picornaviridae;Enterovirus;Enterovirus_A`~subject_id, data, function(x) min(x))
colnames(mina) <- c("subject_id","mina")
data <- merge(data,mina, by="subject_id")
minc <- aggregate(`Picornaviridae;Enterovirus;Enterovirus_C`~subject_id, data, function(x) min(x))
colnames(minc) <- c("subject_id","minc")
data <- merge(data,minc, by="subject_id")
data$delta_a <- data$maxa - data$mina
data$delta_c <- data$maxc - data$minc

# EV A
summary(data[data$group==1,]$delta_a)
sd(data[data$group==1,]$delta_a)
summary(data[data$group==0,]$delta_a)
sd(data[data$group==0,]$delta_a)
sd(data$delta_a)
wilcox.test(data$delta_a ~ data$group)
hist(data[data$group==0,]$delta_a)
hist(data[data$group==1,]$delta_a)
fit <- fitdist(data[data$group==1,]$delta_a,'exp')

# EV C
summary(data[data$group==1,]$delta_c)
sd(data[data$group==1,]$delta_c)
summary(data[data$group==0,]$delta_c)
sd(data[data$group==0,]$delta_c)
sd(data$delta_c)
wilcox.test(data$delta_c ~ data$group)
hist(data[data$group==0,]$delta_c)
hist(data[data$group==1,]$delta_c)
fit <- fitdist(data[data$group==1,]$delta_c,'exp')
