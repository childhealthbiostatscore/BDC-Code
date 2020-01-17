#########Maki: TCL Analysis#########
library(Hmisc)
library(nlme)
require(lsmeans)
source('S:/Shared Material/Shared Code/R/temp_table1.R')


####FIGURE 1 ANALYSIS####
dat.1c_a<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Maki Nakayama/TCL/Data/fig1c_alpha.csv")
dat.1c_b<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Maki Nakayama/TCL/Data/fig1c_beta.csv")

nrow_tot_a<-nrow(subset(dat.1c_a,!is.na(dat.1c_a$X7.mice)))+
  nrow(subset(dat.1c_a,!is.na(dat.1c_a$X6.mice)))+
  nrow(subset(dat.1c_a,!is.na(dat.1c_a$X5.mice)))+
  nrow(subset(dat.1c_a,!is.na(dat.1c_a$X4.mice)))+
  nrow(subset(dat.1c_a,!is.na(dat.1c_a$X3.mice)))+
  nrow(subset(dat.1c_a,!is.na(dat.1c_a$X2.mice)))+
  nrow(subset(dat.1c_a,!is.na(dat.1c_a$X1.mouse)))

dat1_a<-data.frame(group=rep(NA,nrow_tot_a))
dat1_a$group<-c(rep("7",nrow(subset(dat.1c_a,!is.na(dat.1c_a$X7.mice)))),
                      rep("6",nrow(subset(dat.1c_a,!is.na(dat.1c_a$X6.mice)))),
                      rep("5",nrow(subset(dat.1c_a,!is.na(dat.1c_a$X5.mice)))),
                      rep("4",nrow(subset(dat.1c_a,!is.na(dat.1c_a$X4.mice)))),
                      rep("3",nrow(subset(dat.1c_a,!is.na(dat.1c_a$X3.mice)))),
                      rep("2",nrow(subset(dat.1c_a,!is.na(dat.1c_a$X2.mice)))),
                      rep("1",nrow(subset(dat.1c_a,!is.na(dat.1c_a$X1.mouse)))))
dat1_a$outcome<-c(dat.1c_a$X7.mice[!is.na(dat.1c_a$X7.mice)],dat.1c_a$X6.mice[!is.na(dat.1c_a$X6.mice)],
                  dat.1c_a$X5.mice[!is.na(dat.1c_a$X5.mice)],dat.1c_a$X4.mice[!is.na(dat.1c_a$X4.mice)],
                  dat.1c_a$X3.mice[!is.na(dat.1c_a$X3.mice)],dat.1c_a$X2.mice[!is.na(dat.1c_a$X2.mice)],
                  dat.1c_a$X1.mouse[!is.na(dat.1c_a$X1.mouse)])

dat1_a$group<-as.factor(dat1_a$group)
all.aov_a <- aov(outcome ~ group, data = dat1_a)
all.p_a<-round(summary(all.aov_a)[[1]][["Pr(>F)"]][1],5)
all.p_a[all.p_a<0.0001]<-"<0.0001"
tuk_a<-TukeyHSD(x=all.aov_a)
tuk_a<-round(tuk_a$group,3)
tuk_a<-data.frame(tuk_a)
tuk_a$sig<-0
tuk_a$sig[tuk_a$p.adj<0.05]<-1
tuk_a<-subset(tuk_a,tuk_a$sig==1)

nrow_tot_b<-nrow(subset(dat.1c_b,!is.na(dat.1c_b$X7.mice)))+
  nrow(subset(dat.1c_b,!is.na(dat.1c_b$X6.mice)))+
  nrow(subset(dat.1c_b,!is.na(dat.1c_b$X5.mice)))+
  nrow(subset(dat.1c_b,!is.na(dat.1c_b$X4.mice)))+
  nrow(subset(dat.1c_b,!is.na(dat.1c_b$X3.mice)))+
  nrow(subset(dat.1c_b,!is.na(dat.1c_b$X2.mice)))+
  nrow(subset(dat.1c_b,!is.na(dat.1c_b$X1.mouse)))

dat1_b<-data.frame(group=rep(NA,nrow_tot_b))
dat1_b$group<-c(rep("7",nrow(subset(dat.1c_b,!is.na(dat.1c_b$X7.mice)))),
                rep("6",nrow(subset(dat.1c_b,!is.na(dat.1c_b$X6.mice)))),
                rep("5",nrow(subset(dat.1c_b,!is.na(dat.1c_b$X5.mice)))),
                rep("4",nrow(subset(dat.1c_b,!is.na(dat.1c_b$X4.mice)))),
                rep("3",nrow(subset(dat.1c_b,!is.na(dat.1c_b$X3.mice)))),
                rep("2",nrow(subset(dat.1c_b,!is.na(dat.1c_b$X2.mice)))),
                rep("1",nrow(subset(dat.1c_b,!is.na(dat.1c_b$X1.mouse)))))
dat1_b$outcome<-c(dat.1c_b$X7.mice[!is.na(dat.1c_b$X7.mice)],dat.1c_b$X6.mice[!is.na(dat.1c_b$X6.mice)],
                  dat.1c_b$X5.mice[!is.na(dat.1c_b$X5.mice)],dat.1c_b$X4.mice[!is.na(dat.1c_b$X4.mice)],
                  dat.1c_b$X3.mice[!is.na(dat.1c_b$X3.mice)],dat.1c_b$X2.mice[!is.na(dat.1c_b$X2.mice)],
                  dat.1c_b$X1.mouse[!is.na(dat.1c_b$X1.mouse)])

dat1_b$group<-as.factor(dat1_b$group)
all.aov_b <- aov(outcome ~ group, data = dat1_b)
all.p_b<-round(summary(all.aov_b)[[1]][["Pr(>F)"]][1],5)
all.p_b[all.p_b<0.0001]<-"<0.0001"

tuk_b<-TukeyHSD(x=all.aov_b)
tuk_b<-round(tuk_b$group,3)
tuk_b<-data.frame(tuk_b)
tuk_b$sig<-0
tuk_b$sig[tuk_b$p.adj<0.05]<-1
tuk_b<-subset(tuk_b,tuk_b$sig==1)


####FIGURE 3 ANALYSIS####
dat.3<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Maki Nakayama/TCL/Data/fig3b.csv")
dat.3<-as.data.frame(t(dat.3))
colnames(dat.3)<-c("10","100","1000", "All")
dat.3<-dat.3[-c(1),]
dat.3$id<-rep(1:nrow(dat.3))
dat.3$group<-"Blood"
dat.3$group[dat.3$id %in% c(1:3,7:9)]<-"PLN"
dat.3$alpha<-"Alpha"
dat.3$alpha[dat.3$id %in% c(7:12)]<-"Beta"

dat.3a<-subset(dat.3,dat.3$alpha=="Alpha")
dat.3b<-subset(dat.3,dat.3$alpha=="Beta")

dat.3a_long<-reshape(dat.3a,direction = "long",varying=list(names(dat.3a)[1:4]),
                     v.names = "outcome",
                     idvar = c("id", "group","alpha"),
                     timevar = "rank",
                     times = c(10,100,1000,"all"))
dat.3a_long$rank<-as.factor(dat.3a_long$rank)
dat.3a_long$outcome<-as.numeric(as.character(dat.3a_long$outcome))
mixed_3a<-lme(outcome~factor(rank)*group
              ,random=~1|id,data=dat.3a_long)
summary(mixed_3a)

anova_3a<-anova(mixed_3a)
ref_3a <- lsmeans(mixed_3a, c("rank", "group"))
c_list_3a <- list(c_rank10 = c(-1, 0, 0, 0, 1, 0, 0, 0),
                  c_rank100 = c(0, -1, 0, 0, 0, 1, 0, 0),
                  c_rank1000 = c(0, 0, -1, 0, 0, 0, 1, 0),
                  c_all= c(0, 0, 0, -1, 0, 0, 0, 1)
)
contrasts_3a<-summary(contrast(ref_3a, c_list_3a))
contrasts_3a<-contrasts_3a[,c(1,2,3,6)]
contrasts_3a$estimate<-round(contrasts_3a$estimate,3)
contrasts_3a$SE<-round(contrasts_3a$SE,3)
contrasts_3a$p.value<-round(contrasts_3a$p.value,3)

dat.3b_long<-reshape(dat.3b,direction = "long",varying=list(names(dat.3b)[1:4]),
                     v.names = "outcome",
                     idvar = c("id", "group","alpha"),
                     timevar = "rank",
                     times = c(10,100,1000,"all"))
dat.3b_long$rank<-as.factor(dat.3b_long$rank)
dat.3b_long$outcome<-as.numeric(as.character(dat.3b_long$outcome))
mixed_3b<-lme(outcome~factor(rank)*group
              ,random=~1|id,data=dat.3b_long)
summary(mixed_3b)

anova_3b<-anova(mixed_3b)
ref_3b <- lsmeans(mixed_3b, c("rank", "group"))
c_list_3b <- list(c_rank10 = c(-1, 0, 0, 0, 1, 0, 0, 0),
                  c_rank100 = c(0, -1, 0, 0, 0, 1, 0, 0),
                  c_rank1000 = c(0, 0, -1, 0, 0, 0, 1, 0),
                  c_all= c(0, 0, 0, -1, 0, 0, 0, 1)
)
contrasts_3b<-summary(contrast(ref_3b, c_list_3b))
contrasts_3b<-contrasts_3b[,c(1,2,3,6)]
contrasts_3b$estimate<-round(contrasts_3b$estimate,3)
contrasts_3b$SE<-round(contrasts_3b$SE,3)
contrasts_3b$p.value<-round(contrasts_3b$p.value,3)

####FIGURE 4 ANALYSIS####
dat.4a<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Maki Nakayama/TCL/Data/fig4a.csv")
dat.4b<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Maki Nakayama/TCL/Data/fig4b.csv")
dat.4c<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Maki Nakayama/TCL/Data/fig4c.csv")
dat.4d<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Maki Nakayama/TCL/Data/fig4d.csv")

#A:
dat.4a<-as.data.frame(t(dat.4a))
colnames(dat.4a)<-c("week5","week10","week15", "week20")
dat.4a<-dat.4a[-c(1),]
dat.4a$id<-rep(1:nrow(dat.4a))
dat.4a$group[dat.4a$id %in% c(1:9)]<-"Wild-type NOD"
dat.4a$group[dat.4a$id %in% c(10:16)]<-"Insulin-KO NOD"
#make into long dataset:
dat.4a_long<-reshape(dat.4a,direction = "long",varying=list(names(dat.4a)[1:4]),
                     v.names = "outcome",
                     idvar = c("id", "group"),
                     timevar = "week",
                     times = c(5,10,15,20))
dat.4a_long<-subset(dat.4a_long,!is.na(dat.4a_long$outcome))
dat.4a_long$week<-factor(dat.4a_long$week,levels=c(5,10,15,20))
mixed_4a<-lme(outcome~factor(week)*group
                     ,random=~1|id,data=dat.4a_long)
summary(mixed_4a)
anova_4a<-anova(mixed_4a)
ref_4a <- lsmeans(mixed_4a, c("week", "group"))
c_list_4a <- list(c_week5 = c(-1, 0, 0, 0, 1, 0, 0, 0),
                 c_week10 = c(0, -1, 0, 0, 0, 1, 0, 0),
                 c_week15 = c(0, 0, -1, 0, 0, 0, 1, 0),
                 c_week20 = c(0, 0, 0, -1, 0, 0, 0, 1)
)
contrasts_4a<-summary(contrast(ref_4a, c_list_4a))
contrasts_4a<-contrasts_4a[,c(1,2,3,6)]
contrasts_4a$estimate<-round(contrasts_4a$estimate,3)
contrasts_4a$SE<-round(contrasts_4a$SE,3)
contrasts_4a$p.value<-round(contrasts_4a$p.value,3)

#A:
dat.4b<-as.data.frame(t(dat.4b))
colnames(dat.4b)<-c("week5","week10","week15", "week20")
dat.4b<-dat.4b[-c(1),]
dat.4b$id<-rep(1:nrow(dat.4b))
dat.4b$group[dat.4b$id %in% c(1:9)]<-"Wild-type NOD"
dat.4b$group[dat.4b$id %in% c(10:16)]<-"Insulin-KO NOD"
#make into long dataset:
dat.4b_long<-reshape(dat.4b,direction = "long",varying=list(names(dat.4b)[1:4]),
                     v.names = "outcome",
                     idvar = c("id", "group"),
                     timevar = "week",
                     times = c(5,10,15,20))
dat.4b_long<-subset(dat.4b_long,!is.na(dat.4b_long$outcome))
dat.4b_long$week<-factor(dat.4b_long$week,levels=c(5,10,15,20))
mixed_4b<-lme(outcome~factor(week)*group
              ,random=~1|id,data=dat.4b_long)
summary(mixed_4b)
anova_4b<-anova(mixed_4b)
ref_4b <- lsmeans(mixed_4b, c("week", "group"))
c_list_4b <- list(c_week5 = c(-1, 0, 0, 0, 1, 0, 0, 0),
                  c_week10 = c(0, -1, 0, 0, 0, 1, 0, 0),
                  c_week15 = c(0, 0, -1, 0, 0, 0, 1, 0),
                  c_week20 = c(0, 0, 0, -1, 0, 0, 0, 1)
)
contrasts_4b<-summary(contrast(ref_4b, c_list_4b))
contrasts_4b<-contrasts_4b[,c(1,2,3,6)]
contrasts_4b$estimate<-round(contrasts_4b$estimate,3)
contrasts_4b$SE<-round(contrasts_4b$SE,3)
contrasts_4b$p.value<-round(contrasts_4b$p.value,3)

#B:
#two proportion function (fischers or chi square)
dat.4c$above_5<-0
dat.4c$above_5[dat.4c$Outcome>0.5]<-1
dat.4c$above_5<-as.factor(dat.4c$above_5)
label(dat.4c$above_5)<-"%Public NY8.3>0.5%"
levels(dat.4c$Group)<-c("Insulin-KO NOD","Wild-type NOD")

#C:
#Fisher's test:
tab.4c<-final_table(dat.4c,'above_5',dat.4c$Group,margin=2,single=F,ron, col.names=T, summary.stat='both')

dat.4d$above_6<-0
dat.4d$above_6[dat.4d$Outcome>0.6]<-1
dat.4d$above_6<-as.factor(dat.4d$above_6)
label(dat.4d$above_6)<-"%Public NY8.3>0.6%"
levels(dat.4d$Group)<-c("Insulin-KO NOD","Wild-type NOD")
#Fisher's test:
tab.4d<-final_table(dat.4d,'above_6',dat.4d$Group,margin=2,single=F,ron, col.names=T, summary.stat='both')

