import os
import math
from itertools import combinations
from datetime import datetime
from dateutil.parser import parse
import xlrd
import pandas as pd
import numpy as np
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/Nocturnal Alarms/"
# Subject information and dates
subject_dates = pd.read_csv(wd+"Data_Cleaned/subject_dates.csv")
names = [name.lower() for name in subject_dates['name']]
names = np.array(names)
# Dictionary for results
dict={'id': [], 'timepoint': [], 'start_date': [], 'end_date': [], 'num_nights': [],\
'num_alarms': [], 'threshold_alarms': [], 'maintenance_alarms': [], 'hcl_alarms': [],\
'pump_alarms': [], 'other_alarms': []}
# Iterate through files in wd
for file in os.listdir(wd+"Data_Cleaned/CSVs/"):
    if file == ".DS_Store":
        continue
    # Get subject name and dates
    df = pd.read_csv(wd+"Data_Cleaned/CSVs/"+file,low_memory=False)
    t = file.split(" ")[1]
    t = t.replace(".csv","")
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
    if "/" not in df['Date'].iloc[0]:
        df["Date"] = pd.to_numeric(df["Date"], errors='coerce')
        df["Time"] = pd.to_numeric(df["Time"], errors='coerce')
        df['Datetime'] = df["Date"]+df["Time"]
        df['Datetime'] = pd.to_datetime(df['Datetime'],unit='D',origin='1899-12-30',errors='coerce')
    else:
        df['Datetime'] = df['Date'] + ' ' + df['Time']
        df['Datetime'] = pd.to_datetime(df['Datetime'],errors='coerce')    
    df = df.set_index('Datetime')
    df.sort_index(inplace=True)
    df = df[df.index.notnull()]
    df = df.loc[start:end]
    nights = df['Date'].nunique() - 1
    # Pull all alarms between 10p-6a
    df['Time'] = pd.to_datetime(df['Time'],format="%H:%M:%S",errors="coerce")
    df = df.set_index('Time')
    # Alarms
    all_alarms = df['Alarm'].between_time("22:00:00","6:00:00",inclusive = "right").dropna().str.lower()
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
    hcl = [alarm for alarm in hcl if 'pump' not in alarm]
    # Pump maintenance
    matches = ["pump","battery","reservoir"]
    pump = [alarm for alarm in all_alarms if any(x in alarm for x in matches)]
    # Other
    other = len(all_alarms)-sum([len(threshold),len(maintenance),len(hcl),len(pump)])
    # Return
    dict['id'].append(first[0].lower()+last[0].lower())
    dict['timepoint'].append(t)
    dict['start_date'].append(start)
    dict['end_date'].append(end)
    dict['num_nights'].append(nights)
    dict['num_alarms'].append(len(all_alarms))
    dict['threshold_alarms'].append(len(threshold))
    dict['maintenance_alarms'].append(len(maintenance))
    dict['hcl_alarms'].append(len(hcl))
    dict['pump_alarms'].append(len(pump))
    dict['other_alarms'].append(other)
# Results as a dataframe
df=pd.DataFrame(data=dict)
df.to_csv(wd+"Data_Cleaned/nocturnal_alarms.csv",index=False)