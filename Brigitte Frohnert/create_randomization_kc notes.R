
######################################
#1) Set data frame based on REDCap   #
######################################
#Sample size of 36 needed, 18 per treatment group, 24 non-FDR and 12 FDR, randomize an additional 36 for 72 total allocations

#data frame based on variables used in randomization- 36 patients per each combo of gender and age, based on total randomization n
# later double this
temp<-data.frame(fdr=c(rep(1,24),rep(2,12))) #1: non-FDR, 2: FDR
#check 
table(temp)

#######################
#2) Input parameters  #
#######################

set.seed(1017) #change from development/ testing to production

n_groups<-2 #number of study groups
#block_size<-4
block_size<-3  #must be a multiple of the sum of ratio of group allocation, i.e. 1:1 needs multiple of 2, 
#also needs to be multiple of number stratification groups, i.e. 2 sex levels x 2 age groups
#also needs to be a factor of number of subjects in each stratification group
n_tot<-144 #must be a multiple of the block size, inflate needed sample size to allow for additional randomizations

#############################
#3) Generate randomization  #
#############################
x<-NULL #randomization variable

z<-seq(1,n_tot,block_size) #set break points for each block 

#treatment group: 1: Control (1/3), 2: Intervention (2/3)
#group assignment for each block
for(i in z){
  x[i:(i+(block_size-1))]<-c(sample(c(rep(1,each=block_size*(1/3)),rep(2,each=block_size*(2/3)))))
  x
}

##########################################
#4) Create randomization allocation table#
##########################################

#add randomization to dataset created earlier
dat<-cbind(treatment=x, temp)

#check
table(dat$fdr) #non-FDR (1): 96, FDR (2): 48 - correct, twice as many non-FDR
table(dat$treatment) # control (1): 48, treatment (2): 96 - correct, twice as many treatment

table(dat$treatment,dat$fdr) #control & non-FDR (1/1): 32, control & FDR (1/2): 16, treatment & non-FDR (2/1): 64, treatment & FDR: 32

#export
write.csv(dat,'allocation.csv',row.names=FALSE)
