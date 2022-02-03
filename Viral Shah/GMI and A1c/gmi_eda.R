library(tidyverse)
library(segmented)
df = read.csv("/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/GMI and A1c/Data_Raw/gmiData 020222 .csv")
ggplot(df,aes(x = gluMean,y = a1cLab)) + 
  geom_point() + xlab("MBG") + ylab("HbA1c") + 
  theme_bw()
# Segmented model
mod = lm(a1cLab ~ gluMean,data = df)
seg = segmented(mod,seg.Z = ~gluMean,npsi = 1)
summary(seg)
# Add segmented line to plot
df$pred = predict(seg)
ggplot(df,aes(x = gluMean,y = a1cLab)) + 
  geom_point() + geom_line(aes(y = pred),color = "red") +
  xlab("MBG") + ylab("HbA1c") + 
  theme_bw()
  