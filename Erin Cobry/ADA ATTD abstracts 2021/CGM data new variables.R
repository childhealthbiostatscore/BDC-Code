library(cgmanalysis)

cleandata(inputdirectory = "B:\\Projects\\Erin Cobry\\Prospective HCL and sleep study\\CGM data\\Raw files",
          outputdirectory = "B:\\Projects\\Erin Cobry\\Prospective HCL and sleep study\\CGM data\\Cleaned files",
          removegaps = FALSE, gapfill = T,maximumgap = 20,id_filename = T)

cgmvariables(inputdirectory = "B:\\Projects\\Erin Cobry\\Prospective HCL and sleep study\\CGM data\\Cleaned files",
             outputdirectory = "B:\\Projects\\Erin Cobry\\Prospective HCL and sleep study\\CGM data\\Results",
             printname = T,
             outputname = "REDCap Upload evening 6-12",
             daystart = 0,
             dayend = 18,
             customintervals = list(c(55,69),c(181,251)))

cgmvariables(inputdirectory = "B:\\Projects\\Erin Cobry\\Prospective HCL and sleep study\\CGM data\\Cleaned files",
             outputdirectory = "B:\\Projects\\Erin Cobry\\Prospective HCL and sleep study\\CGM data\\Results",
             printname = T,
             outputname = "REDCap Upload night 12-6",
             daystart = 6,
             dayend = 24,
             customintervals = list(c(55,69),c(181,251)))