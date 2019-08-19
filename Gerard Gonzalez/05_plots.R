##### PLOTS - 8/19/2019 #####
library(reshape2)
library(RColorBrewer)

source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/00_data.R')
source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/02_tables.R')

table_prep<-function(tab){
  #tab<-tab.5a.plot
  temp<-tab
  temp[1,1]<-(tab[1,1]+tab[1,2])/sum(tab)
  temp[2,1]<-1-temp[1,1]
  temp[1,2]<-(tab[1,1]+tab[2,1])/sum(tab)
  temp[2,2]<-1-temp[1,2]
  colnames(temp)<-c("Year1","Year3")
  rownames(temp)<-c("Year1","Year3")
  #tab.out<-matrix(c(row2,row3),nrow=2,ncol=length(levels(xvar)),byrow=T,dimnames=list(c(1,0),levels(xvar)))
  tab.out<-as.table(temp)
}
pump.lp.old<-table_prep(tab.5a.plot)
pump.con.old<-table_prep(tab.5b.plot)
pump.lp.young<-table_prep(tab.6a.plot)
pump.con.young<-table_prep(tab.6b.plot)
par(mfrow=c(1,4),mar=c(6,4.2,4,0))
barplot(pump.lp.old,col=c('grey','white'), xlab="",
        ylab="Percent of Patients Using Pump", main = "LP - teens",
        sub=paste0("p=",round(test.5a,3),"; n=",sum(tab.5a.plot)),
        cex.main=1.5,
        cex.names = 1.5,
        cex.axis = 1.5,
        cex.sub=1.5,
        cex.lab=1.5)
#par(mar=c(5,2,4,2))
barplot(pump.lp.young,col=c('grey','white'), xlab="",yaxt="n",
        ylab="", main = "LP - children", sub=paste0("p=",round(test.6a,3),"; n=",
                                                    sum(tab.6a.plot)),
        cex.main=1.5,
        cex.sub=1.5,
        cex.names = 1.5)
barplot(pump.con.old,col=c('grey','white'), xlab="",yaxt="n",
        ylab="", main = "Comparison - teens",sub=paste0("p=",round(test.5b,3),"; n=",sum(tab.5b.plot)),
        cex.main=1.5,
        cex.sub=1.5,
        cex.names = 1.5)
barplot(pump.con.young,col=c('grey','white'), xlab="",yaxt="n",
        ylab="", main = "Comparison - children",sub=paste0("p=",round(test.6b,3),"; n=",sum(tab.6b.plot)),
        cex.main=1.5,
        cex.sub=1.5,
        cex.names = 1.5)
legend('topright',c('Pump','No Pump'),
       fill=c('grey','white'),bty='o',bg="lightgrey",box.col='black',
       cex=1.5)
#mtext("% Pump Use Over Time",outer=T,line=-2,cex=1.5)

###CGM Use:
cgm.lp.old<-table_prep(tab.7a.plot)
cgm.con.old<-table_prep(tab.7b.plot)
cgm.lp.young<-table_prep(tab.8a.plot)
cgm.con.young<-table_prep(tab.8b.plot)
par(mfrow=c(1,4),mar=c(6,4.2,4,0))
barplot(cgm.lp.old,col=c('grey','white'), xlab="",
        ylab="Percent of Patients Using CGM", main = "LP - teens",
        sub=paste0("p=",round(test.7a,3),"; n=",sum(tab.7a.plot)),
        cex.main=1.5,
        cex.names = 1.5,
        cex.axis = 1.5,
        cex.sub=1.5,
        cex.lab=1.5)
#par(mar=c(5,2,4,2))
barplot(cgm.lp.young,col=c('grey','white'), xlab="",yaxt="n",
        ylab="", main = "LP - children", sub=paste0("p=",round(test.8a,3),"; n=",
                                                    sum(tab.8a.plot)),
        cex.main=1.5,
        cex.sub=1.5,
        cex.names = 1.5)
barplot(cgm.con.old,col=c('grey','white'), xlab="",yaxt="n",
        ylab="", main = "Comparison - teens",sub=paste0("p=",round(test.7b,3),"; n=",sum(tab.7b.plot)),
        cex.main=1.5,
        cex.sub=1.5,
        cex.names = 1.5)
barplot(cgm.con.young,col=c('grey','white'), xlab="",yaxt="n",
        ylab="", main = "Comparison - children",sub=paste0("p=",round(test.8b,3),"; n=",sum(tab.8b.plot)),
        cex.main=1.5,
        cex.sub=1.5,
        cex.names = 1.5)
legend('topright',c('CGM','No CGM'),
       fill=c('grey','white'),bty='o',bg="lightgrey",box.col='black',
       cex=1.5)
