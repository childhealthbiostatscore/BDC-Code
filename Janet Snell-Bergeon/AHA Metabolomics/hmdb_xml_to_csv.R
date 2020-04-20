library(tidyverse)
library(xml2)
hmdb <- read_xml('/Users/timvigers/Downloads/serum_metabolites.xml')%>%
  as_list()

id = unlist(sapply(hmdb, "[[", "accession"))
name = unlist(sapply(hmdb, "[[", "name"))
hmdbclass = sapply(hmdb, "[[", "class")
