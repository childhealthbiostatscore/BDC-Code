import os
import math
from itertools import combinations
import pandas as pd
import numpy as np
wd = "/Users/timvigers/Dropbox/Work/Erin Cobry/Nocturnal Alarms/"
# Subject information and dates
subject_dates = pd.read_csv(wd+"Data_Cleaned/subject_dates.csv")
names = [name.lower() for name in subject_dates['name']]
names = np.array(names)
# Dictionary for results
dict={'Name': [],'Timepoint': [], 'Nights': [], 'Total Alarms': [], 'Threshold Alarms': [],\
'Maintenance Alarms': [], 'HCL Alarms': [], 'Pump Alarms': [], 'Other Alarms': []}
# Iterate through files in wd
for file in os.listdir(wd+"Data_Cleaned/CSVs/"):
    if file == ".DS_Store":
        continue
    # Get subject name and dates
    df = pd.read_csv(wd+"Data_Raw/CSVs/"+file,low_memory=False)
    t = file.split(" ")[1]
    t_cols = [col for col in subject_dates.columns if t.lower() in col]
    if len(t_cols) < 1:
        t_cols = ['week2_start','week2_end']
    last = df[["Last Name"]].iloc[0]
    first = df[["First Name"]].iloc[0]
    ind = np.where(names == first[0].lower()+" "+last[0].lower())[0]
    start = subject_dates.loc[ind,t_cols[0]].item()
    end = subject_dates.loc[ind,t_cols[1]].item()
    # Check dates
    if type(start)!=str and type(end)!=str:
        continue
                # Remove unnecessary top rows
    df.columns = df.loc[5,]
    df = df.drop(list(range(0,6)),axis = 0)
    # Get correct dates
    df['Datetime'] = pd.to_datetime(df['Date'] + ' ' + df['Time'],format="%m/%d/%y %H:%M:%S",errors="coerce")
    df = df.set_index('Datetime')
    df = df.loc[start:end]
    nights = df['Date'].nunique() - 1
    # Pull all alarms between 10p-6a
    df['Time'] = pd.to_datetime(df['Time'],format="%H:%M:%S",errors="coerce")
    df = df.set_index('Time')
    # Alarms
    all_alarms = df['Alarm'].between_time("22:00:00","6:00:00",include_end=False).dropna().str.lower()
    dates = df.loc[all_alarms.index,'Date']
    # Don't count the alarm if it includes the words:  QUIET, BOLUS, ENTER BG,
    matches = ["quiet","bolus","enter bg"]
    all_alarms = [alarm for alarm in all_alarms if all(x not in alarm for x in matches)]
    # Alarm types (per Cari)
    # Threshold
    threshold = [alarm for alarm in all_alarms if 'alert' in alarm]
    threshold = [alarm for alarm in threshold if 'cal' not in alarm]
    # Maintenance
    matches = ["sensor","cal","signal","transmtr"]
    maintenance = [alarm for alarm in all_alarms if any(x in alarm for x in matches)]
    maintenance = [alarm for alarm in maintenance if 'auto mode' not in alarm]
    # HCL specific
    hcl = [alarm for alarm in all_alarms if 'auto' in alarm]
    # Pump maintenance
    matches = ["pump","battery","reservoir"]
    pump = [alarm for alarm in all_alarms if any(x in alarm for x in matches)]
    # Other
    other = len(all_alarms)-sum([len(threshold),len(maintenance),len(hcl),len(pump)])
    # Return
    dict['Name'].append(first[0].lower().strip()+last[0].lower().strip())
    dict['Timepoint'].append(t)
    dict['Nights'].append(nights)
    dict['Total Alarms'].append(len(all_alarms))
    dict['Threshold Alarms'].append(len(threshold))
    dict['Maintenance Alarms'].append(len(maintenance))
    dict['HCL Alarms'].append(len(hcl))
    dict['Pump Alarms'].append(len(pump))
    dict['Other Alarms'].append(other)
# Results as a dataframe
df=pd.DataFrame(data=dict)
df.to_csv(wd+"Data_Cleaned/nocturnal_alarms.csv",index=False)
