library(MultiAssayExperiment)
library(SummarizedExperiment)

data("miniACC")
miniACC

# view patient data
colData(miniACC)
table(miniACC$race)

# view experiments
experiments(miniACC)

# create new MAE with these genes
newmae <- miniACC[c("MAPK14", "IGFBP2"), , ]

# creating toy example
# https://bioconductor.org/packages/release/bioc/vignettes/MultiAssayExperiment/inst/doc/MultiAssayExperiment.html

# expression data
(arraydat <- matrix(seq(101, 108), ncol=4,
                    dimnames=list(c("ENST00000294241", "ENST00000355076"),
                                  c("array1", "array2", "array3", "array4"))))

# patient information
coldat <- data.frame(slope53=rnorm(4),
                     row.names=c("array1", "array2", "array3", "array4"))

# put them together as a Summarized Experiment
exprdat <- SummarizedExperiment(arraydat, colData=coldat)
exprdat

# create sample map
(exprmap <- data.frame(primary=c("Jack", "Jill", "Barbara", "Bob"),
                       colname=c("array1", "array2", "array3", "array4"),
                       stringsAsFactors = FALSE))

# methylation data
(methyldat <-
    matrix(1:10, ncol=5,
           dimnames=list(c("ENST00000355076", "ENST00000383706"),
                         c("methyl1", "methyl2", "methyl3",
                           "methyl4", "methyl5"))))
(methylmap <- data.frame(primary = c("Jack", "Jack", "Jill", "Barbara", "Bob"),
                         colname = c("methyl1", "methyl2", "methyl3", "methyl4", "methyl5"),
                         stringsAsFactors = FALSE))

# microRNA data
(microdat <- matrix(201:212, ncol=3,
                    dimnames=list(c("hsa-miR-21", "hsa-miR-191",
                                    "hsa-miR-148a", "hsa-miR148b"),
                                  c("micro1", "micro2", "micro3"))))
(micromap <- data.frame(primary = c("Jack", "Barbara", "Bob"),
                        colname = c("micro1", "micro2", "micro3"), stringsAsFactors = FALSE))
