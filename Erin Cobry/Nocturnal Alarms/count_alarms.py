import os
import math
import pandas as pd
wd = "C:/Users/Tim Vigers/Dropbox/Work/Erin Cobry/Nocturnal Alarms/Data_Raw/CSVs/"
# Iterate through files in wd
for file in os.listdir(wd):
    df = pd.read_csv(wd+file)