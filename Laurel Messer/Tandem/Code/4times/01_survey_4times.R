
#source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Laurel Messer/Tandem/Code/00_data.R')

####Reverse score:
reverse<-function(x){
  ##x<-dat$Baseline_7
  temp<-NA
  temp[x==1]<-10
  temp[x==2]<-9
  temp[x==3]<-8
  temp[x==4]<-7
  temp[x==5]<-6
  temp[x==6]<-5
  temp[x==7]<-4
  temp[x==8]<-3
  temp[x==9]<-2
  temp[x==10]<-1
  
  label(temp)<-paste0(label(x))
  return(temp)
}
dat$Baseline_5<-reverse(dat$Baseline_5)
dat$Baseline_7<-reverse(dat$Baseline_7)
dat$post2m_5<-reverse(dat$post2m_5)
dat$post2m_7<-reverse(dat$post2m_7)
dat$post4m_5<-reverse(dat$post4m_5)
dat$post4m_7<-reverse(dat$post4m_7)
dat$post6m_5<-reverse(dat$post6m_5)
dat$post6m_7<-reverse(dat$post6m_7)

####SURVEY FACTORS:
dat$baseline_factor1<-NA
dat$baseline_factor1<-rowMeans(dat[,c(which(colnames(dat)=="Baseline_1"):
                                        which(colnames(dat)=="Baseline_7"))],na.rm=T)
label(dat$baseline_factor1)<-"Baseline: Factor 1 Benefit"

dat$post2m_factor1<-NA
dat$post2m_factor1<-rowMeans(dat[,c(which(colnames(dat)=="post2m_1"):
                                      which(colnames(dat)=="post2m_7"))],na.rm=T)
label(dat$post2m_factor1)<-"Post 2m: Factor 1 Benefit"

dat$post4m_factor1<-NA
dat$post4m_factor1<-rowMeans(dat[,c(which(colnames(dat)=="post4m_1"):
                                      which(colnames(dat)=="post4m_7"))],na.rm=T)
label(dat$post4m_factor1)<-"Post 4m: Factor 1 Benefit"

dat$post6m_factor1<-NA
dat$post6m_factor1<-rowMeans(dat[,c(which(colnames(dat)=="post6m_1"):
                                      which(colnames(dat)=="post6m_7"))],na.rm=T)
label(dat$post6m_factor1)<-"6 month: Factor 1 Benefit"

####8/29/19 removed "treat low blood glucose by eating snacks" from burden factor
dat$baseline_factor2<-NA
dat$baseline_factor2<-rowMeans(dat[,c(which(colnames(dat)=="Baseline_8"):
                                        which(colnames(dat)=="Baseline_11"))],na.rm=T)
label(dat$baseline_factor2)<-"Baseline: Factor 2 Burden"

dat$post2m_factor2<-NA
dat$post2m_factor2<-rowMeans(dat[,c(which(colnames(dat)=="post2m_8"):
                                      which(colnames(dat)=="post2m_11"))],na.rm=T)
label(dat$post2m_factor2)<-"Post 2m: Factor 2 Burden"

dat$post4m_factor2<-NA
dat$post4m_factor2<-rowMeans(dat[,c(which(colnames(dat)=="post4m_8"):
                                      which(colnames(dat)=="post4m_11"))],na.rm=T)
label(dat$post4m_factor2)<-"Post 4m: Factor 2 Burden"

dat$post6m_factor2<-NA
dat$post6m_factor2<-rowMeans(dat[,c(which(colnames(dat)=="post6m_8"):
                                      which(colnames(dat)=="post6m_11"))],na.rm=T)
label(dat$post6m_factor2)<-"6 month: Factor 2 Burden"

