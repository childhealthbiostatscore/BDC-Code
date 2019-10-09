
#read in data
dat<-read.csv("S:/Shared Projects/Laura/BDC/Projects/Maki Nakayama/t-cells/all_data.csv")
dat$group_2<-"AM"
dat$group_2[dat$Group=="LO+BFP"]<-"LO"
dat$group_2[dat$Group=="LO+CR"]<-"LO"
dat$group_2[dat$Group=="LO+mChe"]<-"LO"
dat$group_2[dat$Group=="LO+TM"]<-"LO"
dat$group_2<-as.factor(dat$group_2)

dat$group_4<-NA
dat$group_4[dat$Group=="AM+BFP"]<-"BFP"
dat$group_4[dat$Group=="LO+BFP"]<-"BFP"
dat$group_4[dat$Group=="AM+CR"]<-"CR"
dat$group_4[dat$Group=="LO+CR"]<-"CR"
dat$group_4[dat$Group=="AM+mChe"]<-"mChe"
dat$group_4[dat$Group=="LO+mChe"]<-"mChe"
dat$group_4[dat$Group=="AM+TM"]<-"TM"
dat$group_4[dat$Group=="LO+TM"]<-"TM"
dat$group_4<-as.factor(dat$group_4)

###OVERALL###
dat$Group<-as.factor(dat$Group)
all.aov <- aov(Value ~ Group, data = dat)
all.p<-round(summary(all.aov)[[1]][["Pr(>F)"]][1],5)
tuk<-TukeyHSD(x=all.aov)
tuk<-round(tuk$Group,3)
tuk<-data.frame(tuk)
tuk$sig<-0
tuk$sig[tuk$p.adj<0.05]<-1
tuk<-subset(tuk,tuk$sig==1)
# pairwise.kr<-pairwise.wilcox.test(dat$Value, dat$Group,
#                      p.adjust.method = "BH")
###Four Groups###
four.aov <- aov(Value ~ group_4, data = dat)
four.p<-round(summary(four.aov)[[1]][["Pr(>F)"]][1],5)
tuk.4<-TukeyHSD(x=four.aov)
tuk.4<-round(tuk.4$group_4,3)
tuk.4<-data.frame(tuk.4)
tuk.4$sig<-0
tuk.4$sig[tuk.4$p.adj<0.05]<-1
tuk.4<-subset(tuk.4,tuk.4$sig==1)

###Two Groups###
mean_table<-function(x,group){
  
  mean.x<-t.test(x~as.factor(group),dat)
  mean.x.model<-lm(x ~ 0 + as.factor(group), dat)
  mean.x.ci<-confint(mean.x.model)
  
  #table for x
  tab.x<-data.frame(
    No=paste0(round(mean.x$estimate[1],1)," ","(",round(mean.x.ci[1,1],1),","," ",round(mean.x.ci[1,2],1),")"),
    Yes=paste0(round(mean.x$estimate[2],1)," ","(",round(mean.x.ci[2,1],1),","," ",round(mean.x.ci[2,2],1),")"),
    Pval=as.character(round(mean.x$p.value,4)))
  
  return(tab.x)
}
tab.2grp<-mean_table(dat$Value,dat$group_2)
t.test(dat$Value[dat$group_2=="AM"],dat$Value[dat$group_2=="LO"])
b <- boxplot(dat$Value~dat$Group,data=dat, plot=0)

boxplot(dat$Value~dat$Group,
        xlab="Fluorochromes",main="All Combinations",
        ylab="% ZsGreen-1 Positive",
        names=paste(b$names, "(n=", b$n, ")"))

b <- boxplot(dat$Value~dat$group_4, data=dat, plot=0)
boxplot(dat$Value~dat$group_4,
        xlab="Fluorochromes",main="BFP/CR/TM/mChe",
        ylab="% ZsGreen-1 Positive",
        names=paste(b$names, "(n=", b$n, ")"))

b <- boxplot(dat$Value~dat$group_2, data=dat, plot=0)
boxplot(dat$Value~dat$group_2,
        xlab="Fluorochromes",main="AM/LO",
        ylab="% ZsGreen-1 Positive",
        names=paste(b$names, "(n=", b$n, ")"))
