
######################################
#1) Set data frame based on REDCap   #
######################################

#data frame based on variables used in randomization
temp<-data.frame(rando_site=c(rep(0,50),rep(1,50),rep(2,50)))

#temp<-data.frame(var1=rep(1:3,each=60))

#######################
#2) Input parameters  #
#######################

set.seed(1234) #change from development/ testing to production

n_groups<-2 #number of study groups
block_size<-6  #must be a multiple of the sum of ratio of group allocation, i.e. 1:1 needs multiple of 2, 
                #also needs to be multiple of # stratification groups, i.e. 2 sex levels x 2 age groups
n_tot<-150  #must be a multiple of the block size, inflate needed sample size to allow for additional randomizations

#############################
#3) Generate randomization  #
#############################
x<-NULL #randomization variable

z<-seq(1,n_tot,block_size) #set break points for each block 

#group assignment for each block
for(i in z){
  x[i:(i+(block_size-1))]<-c(sample(c(rep(1:n_groups,each=block_size/n_groups))))
  x
}

##########################################
#4) Create randomization allocation table#
##########################################

#add randomization to dataset created earlier
dat<-cbind(rando_group=x-1, temp)

#check
table(dat$rando_group,dat$rando_site)

#export
write.csv(dat,'/Volumes/BDC/Projects/Greg Forlenza/FCL at home/RandomizationAllocationTable_Production.csv',row.names=FALSE)

################
# double check file from UVA
dev <- read.csv("/Volumes/BDC/Projects/Greg Forlenza/FCL at home/RandomizationAllocationTable_Dev.csv")
table(dev$rando_group,dev$rando_site)
