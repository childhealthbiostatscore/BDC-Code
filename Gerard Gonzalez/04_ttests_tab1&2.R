###t-tests table 2

source('C:/Users/campbkri/Documents/GitHub/BDC-Code/Gerard Gonzalez/00_data.R')
#TABLE 1: tests within control group, between age grps
t.test(dat$a1c_last_in_year[dat$trt_grp=="LP" & dat$yeargrouping=="Base1"],
       dat$a1c_last_in_year[dat$trt_grp=="Control" & dat$yeargrouping=="Base1"])

t.test(dat$a1c_last_in_year[dat$trt_grp=="LP" & dat$yeargrouping=="Year1"],
       dat$a1c_last_in_year[dat$trt_grp=="Control" & dat$yeargrouping=="Year1"])

t.test(dat$a1c_last_in_year[dat$trt_grp=="LP" & dat$yeargrouping=="Year2"],
       dat$a1c_last_in_year[dat$trt_grp=="Control" & dat$yeargrouping=="Year2"])

t.test(dat$a1c_last_in_year[dat$trt_grp=="LP" & dat$yeargrouping=="Year3"],
       dat$a1c_last_in_year[dat$trt_grp=="Control" & dat$yeargrouping=="Year3"])
#controls
t.test(dat$checks_last_in_year[dat$trt_grp=="LP" & dat$yeargrouping=="Base1"],
       dat$checks_last_in_year[dat$trt_grp=="Control" & dat$yeargrouping=="Base1"])

t.test(dat$checks_last_in_year[dat$trt_grp=="LP" & dat$yeargrouping=="Year1"],
       dat$checks_last_in_year[dat$trt_grp=="Control" & dat$yeargrouping=="Year1"])

t.test(dat$checks_last_in_year[dat$trt_grp=="LP" & dat$yeargrouping=="Year2"],
       dat$checks_last_in_year[dat$trt_grp=="Control" & dat$yeargrouping=="Year2"])

t.test(dat$checks_last_in_year[dat$trt_grp=="LP" & dat$yeargrouping=="Year3"],
       dat$checks_last_in_year[dat$trt_grp=="Control" & dat$yeargrouping=="Year3"])


#TABLE 2: tests within control group, between age grps
t.test(dat.con$a1c_last_in_year[dat.con$group=="Less than 12" & dat.con$yeargrouping=="Base1"],
       dat.con$a1c_last_in_year[dat.con$group=="greater than or equal to 12" & dat.con$yeargrouping=="Base1"])

t.test(dat.con$a1c_last_in_year[dat.con$group=="Less than 12" & dat.con$yeargrouping=="Year1"],
       dat.con$a1c_last_in_year[dat.con$group=="greater than or equal to 12" & dat.con$yeargrouping=="Year1"])

t.test(dat.con$a1c_last_in_year[dat.con$group=="Less than 12" & dat.con$yeargrouping=="Year2"],
       dat.con$a1c_last_in_year[dat.con$group=="greater than or equal to 12" & dat.con$yeargrouping=="Year2"])

t.test(dat.con$a1c_last_in_year[dat.con$group=="Less than 12" & dat.con$yeargrouping=="Year3"],
       dat.con$a1c_last_in_year[dat.con$group=="greater than or equal to 12" & dat.con$yeargrouping=="Year3"])

#tests within trt group, between age grps
t.test(dat.trt$a1c_last_in_year[dat.trt$group=="Less than 12" & dat.trt$yeargrouping=="Base1"],
       dat.trt$a1c_last_in_year[dat.trt$group=="greater than or equal to 12" & dat.trt$yeargrouping=="Base1"])

t.test(dat.trt$a1c_last_in_year[dat.trt$group=="Less than 12" & dat.trt$yeargrouping=="Year1"],
       dat.trt$a1c_last_in_year[dat.trt$group=="greater than or equal to 12" & dat.trt$yeargrouping=="Year1"])

t.test(dat.trt$a1c_last_in_year[dat.trt$group=="Less than 12" & dat.trt$yeargrouping=="Year2"],
       dat.trt$a1c_last_in_year[dat.trt$group=="greater than or equal to 12" & dat.trt$yeargrouping=="Year2"])

t.test(dat.trt$a1c_last_in_year[dat.trt$group=="Less than 12" & dat.trt$yeargrouping=="Year3"],
       dat.trt$a1c_last_in_year[dat.trt$group=="greater than or equal to 12" & dat.trt$yeargrouping=="Year3"])

#tests within control group, between age grps
t.test(dat.con$checks_last_in_year[dat.con$group=="Less than 12" & dat.con$yeargrouping=="Base1"],
       dat.con$checks_last_in_year[dat.con$group=="greater than or equal to 12" & dat.con$yeargrouping=="Base1"])

t.test(dat.con$checks_last_in_year[dat.con$group=="Less than 12" & dat.con$yeargrouping=="Year1"],
       dat.con$checks_last_in_year[dat.con$group=="greater than or equal to 12" & dat.con$yeargrouping=="Year1"])

t.test(dat.con$checks_last_in_year[dat.con$group=="Less than 12" & dat.con$yeargrouping=="Year2"],
       dat.con$checks_last_in_year[dat.con$group=="greater than or equal to 12" & dat.con$yeargrouping=="Year2"])

t.test(dat.con$checks_last_in_year[dat.con$group=="Less than 12" & dat.con$yeargrouping=="Year3"],
       dat.con$checks_last_in_year[dat.con$group=="greater than or equal to 12" & dat.con$yeargrouping=="Year3"])

#tests within trt group, between age grps
t.test(dat.trt$checks_last_in_year[dat.trt$group=="Less than 12" & dat.trt$yeargrouping=="Base1"],
       dat.trt$checks_last_in_year[dat.trt$group=="greater than or equal to 12" & dat.trt$yeargrouping=="Base1"])

t.test(dat.trt$checks_last_in_year[dat.trt$group=="Less than 12" & dat.trt$yeargrouping=="Year1"],
       dat.trt$checks_last_in_year[dat.trt$group=="greater than or equal to 12" & dat.trt$yeargrouping=="Year1"])

t.test(dat.trt$checks_last_in_year[dat.trt$group=="Less than 12" & dat.trt$yeargrouping=="Year2"],
       dat.trt$checks_last_in_year[dat.trt$group=="greater than or equal to 12" & dat.trt$yeargrouping=="Year2"])

t.test(dat.trt$checks_last_in_year[dat.trt$group=="Less than 12" & dat.trt$yeargrouping=="Year3"],
       dat.trt$checks_last_in_year[dat.trt$group=="greater than or equal to 12" & dat.trt$yeargrouping=="Year3"])

##SENSITIVITY ANALYSIS:
t.test(dat.3$a1c_last_in_year[dat.3$trt_grp=="LP" & dat.3$yeargrouping=="Base1"],
       dat.3$a1c_last_in_year[dat.3$trt_grp=="Control" & dat.3$yeargrouping=="Base1"])

t.test(dat.3$a1c_last_in_year[dat.3$trt_grp=="LP" & dat.3$yeargrouping=="Year1"],
       dat.3$a1c_last_in_year[dat.3$trt_grp=="Control" & dat.3$yeargrouping=="Year1"])

t.test(dat.3$a1c_last_in_year[dat.3$trt_grp=="LP" & dat.3$yeargrouping=="Year2"],
       dat.3$a1c_last_in_year[dat.3$trt_grp=="Control" & dat.3$yeargrouping=="Year2"])

t.test(dat.3$a1c_last_in_year[dat.3$trt_grp=="LP" & dat.3$yeargrouping=="Year3"],
       dat.3$a1c_last_in_year[dat.3$trt_grp=="Control" & dat.3$yeargrouping=="Year3"])

#paired test:
t.test(dat.3$a1c_last_in_year[dat.3$trt_grp=="LP" & dat.3$yeargrouping=="Base1"],
       dat.3$a1c_last_in_year[dat.3$trt_grp=="LP" & dat.3$yeargrouping=="Year3"],paired=T)
