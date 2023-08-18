#### MANUSCRIPT FIGURES ####

PLOT_CAID<-jskm(any,xlab="Years from Diabetes Onset",ylab="Proportion CAID-Free",table=T,
     main="A. Time-to-Any CAID",ylim=c(0.6,1),marks=F,linecols = 'black',ci=T,
     legend=F,timeby = 2,ystratalabs="",xlim=c(-0.5,8))
PLOT_CAID+theme(axis.text.x = element_blank(),
                axis.ticks.x = element_blank(),
                axis.title.x = element_blank(),
                plot.margin = unit(c(5.5, 5.5, 3, 5.5), "pt"))

PLOT_THY<-jskm(thy,xlab="Years from Diabetes Onset",ylab="Proportion Thyroid Disease-Free",table=T,
     main="B. Time-to-Thyroid Disease",ylim=c(0.6,1),marks=F,linecols = 'black',ci=T,
     legend=F,timeby = 2,ystratalabs="",xlim=c(-0.5,8))
PLOT_THY+theme(axis.text.x = element_blank(),
                axis.ticks.x = element_blank(),
                axis.title.x = element_blank(),
                plot.margin = unit(c(5.5, 5.5, 3, 5.5), "pt"))

PLOT_CEL<- jskm(cel,xlab="Years from Diabetes Onset",ylab="Proportion Celiac Disease-Free",table=T,
                main="C. Time-to-Celiac Disease",ylim=c(0.6,1),marks=F,linecols = 'black',ci=T,
                legend=F,timeby = 2,ystratalabs="",xlim=c(-0.5,8))
PLOT_CEL+theme(plot.margin = unit(c(5.5, 5.5, 3, 5.5), "pt"))
jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/FIGURE1_MANUSCRIPT.jpeg",
     height=6,width=12,units='in',res=1200)
grid.arrange(PLOT_CAID+theme(plot.margin = unit(c(2, 0, 3, 0), "pt")),PLOT_THY+theme(plot.margin = unit(c(2, 0, 3, 0), "pt")),PLOT_CEL+theme(plot.margin = unit(c(2, 0, 3, 0), "pt")),ncol=3)
dev.off()

##### FIGURE 2 

thy_gen_plot<-jskm(thy_gen,xlab="Years from Diabetes Onset",ylab="Proportion Thyroid Disease-Free",table=F,
                   main="A. Thyroid Disease, by Gender",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.thy$Gender),pval=T,
                   legendposition = c(0.85,0.2))

thy_race_plot<-jskm(thy_race,xlab="Years from Diabetes Onset",ylab="Proportion Thyroid Disease-Free",table=F,
                    main="B. Thyroid Disease, by Race/Ethnicity",ylim=c(0.6,1),marks=F,linecols = 'Set2',ci=T,
                    ystratalabs=levels(dat.thy$RaceEthinicity_cat),pval=T,
                    legendposition = c(0.85,0.2),ystrataname = "") 

thy_age_plot<-jskm(thy_age,xlab="Years from Diabetes Onset",ylab="Proportion Thyroid Disease-Free",table=F,
                   main="C. Thyroid Disease, by Median Age",ylim=c(0.6,1),marks=F,linecols = 'Dark2',ci=T,
                   ystratalabs=levels(dat.thy$age_cat),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 

cel_gen_plot<-jskm(cel_gen,xlab="Years from Diabetes Onset",ylab="Proportion Celiac Disease-Free",table=F,
                   main="D. Celiac Disease, by Gender",ylim=c(0.6,1),marks=F,linecols = 'Set1',ci=T,
                   ystratalabs=levels(dat.cel$Gender),pval=T,
                   legendposition = c(0.85,0.2))

cel_race_plot<-jskm(cel_race,xlab="Years from Diabetes Onset",ylab="Proportion Celiac Disease-Free",table=F,
                    main="E. Celiac Disease, by Race/Ethnicity",ylim=c(0.6,1),marks=F,linecols = 'Set2',ci=T,
                    ystratalabs=levels(dat.cel$RaceEthinicity_cat),pval=T,
                    legendposition = c(0.85,0.2),ystrataname = "")  

cel_age_plot<-jskm(cel_age,xlab="Years from Diabetes Onset",ylab="Proportion Celiac Disease-Free",table=F,
                   main="F. Celiac Disease, by Median Age",ylim=c(0.6,1),marks=F,linecols = 'Dark2',ci=T,
                   ystratalabs=levels(dat.cel$age_cat),pval=T,
                   legendposition = c(0.85,0.2),ystrataname = "") 

jpeg("S:/Shared Projects/Laura/BDC/Projects/Kimber Simmons/CAID/Results/plots/FIGURE2_MANUSCRIPT.jpeg",
     height=10,width=12,units='in',res=1200)
grid.arrange(thy_gen_plot,thy_race_plot,thy_age_plot,
             cel_gen_plot,cel_race_plot,cel_age_plot,ncol=3,nrow=2)
dev.off()