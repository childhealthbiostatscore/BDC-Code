# Import variants
bim1 <- read.table("/Users/timvigers/Documents/OneDrive - The University of Colorado Denver/simmons/Simmons_071520.bim",
                  header=F,stringsAsFactors = F)
bim2 <- read.table("/Users/timvigers/Documents/OneDrive - The University of Colorado Denver/simmons/Simmons_passed_qc.bim",
                   header=F,stringsAsFactors = F)
# Get the matching variants
bim1 <- bim1[which(bim1$V2 %in% bim2$V2),]
bim2 <- bim2[which(bim2$V2 %in% bim1$V2),]
# Sort
bim1 <- bim1[order(bim1$V2),]
bim2 <- bim2[order(bim2$V2),]
# Check position differences
diffs <- bim1$V4 - bim2$V4
max(abs(diffs))