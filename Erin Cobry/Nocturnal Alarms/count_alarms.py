import os
import math
import functools
from itertools import combinations
from datetime import datetime
from unittest import result
from dateutil.parser import parse
import xlrd
import pandas as pd
import numpy as np
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/Nocturnal Alarms/"
# Subject information and dates
subject_dates = pd.read_csv(wd+"Data_Cleaned/subject_dates.csv")
names = [name.lower() for name in subject_dates['name']]
names = np.array(names)
# Time intervals
times = {"day": ["06:00:00", "22:00:00"], "night": ["22:00:00", "06:00:00"],
         "10pm_12am": ["22:00:00", "00:00:00"], "12am_2am": ["00:00:00", "02:00:00"],
         "2am_4am": ["02:00:00", "04:00:00"], "4am_6am": ["04:00:00", "06:00:00"]}
# Dictionary for results
base_vars = ['num_alarms', 'threshold_alarms', 'maintenance_alarms',
             'hcl_alarms', 'pump_alarms', 'other_alarms']
vars = [[v+"_"+var for var in list(times.keys())] for v in base_vars]
vars = [item for sublist in vars for item in sublist]
vars = ['id', 'timepoint', 'start_date', 'end_date', 'days_with_data'] + vars
results = {k: [] for k in vars}
# Iterate through files in wd
files = os.listdir(wd+"Data_Cleaned/CSVs/")
files.sort()
for file in files:
    if file == ".DS_Store":
        continue
    # Get subject name and dates
    df = pd.read_csv(wd+"Data_Cleaned/CSVs/"+file, low_memory=False)
    t = file.split(" ")[1]
    t = t.replace(".csv", "")
    t_cols = [col for col in subject_dates.columns if t.lower() in col]
    if len(t_cols) < 1:
        t_cols = ['week2_start', 'week2_end']
    last = df[["Last Name"]].iloc[0]
    first = df[["First Name"]].iloc[0]
    ind = np.where(names == first[0].lower()+" "+last[0].lower())[0]
    start = subject_dates.loc[ind, t_cols[0]].item()
    end = subject_dates.loc[ind, t_cols[1]].item()
    # Check dates
    if type(start) != str and type(end) != str:
        continue
    # Remove unnecessary top rows
    df.columns = df.loc[5, ]
    df = df.drop(list(range(0, 6)), axis=0)
    # Get correct dates
    if "/" not in df['Date'].iloc[0]:
        df["Date"] = pd.to_numeric(df["Date"], errors='coerce')
        df["Time"] = pd.to_numeric(df["Time"], errors='coerce')
        df['Datetime'] = df["Date"]+df["Time"]
        df['Datetime'] = pd.to_datetime(
            df['Datetime'], unit='D', origin='1899-12-30', errors='coerce')
    else:
        df['Datetime'] = df['Date'] + ' ' + df['Time']
        df['Datetime'] = pd.to_datetime(df['Datetime'], errors='coerce')
    df['Datetime'] = df['Datetime'].round('s')
    df['Date'] = df['Datetime'].dt.date
    df['Time'] = df['Datetime'].dt.time
    df = df.set_index('Datetime', drop=False)
    df.sort_index(inplace=True)
    df = df[df.index.notnull()]
    df = df.loc[start:end]
    days = df['Date'].nunique()
    # Base variables
    results['id'].append(first[0].lower()+last[0].lower())
    results['timepoint'].append(t)
    results['start_date'].append(start)
    results['end_date'].append(end)
    results['days_with_data'].append(days)
    # Pull all alarms for each time period
    for time in times:
        t1 = times[time][0]
        t2 = times[time][1]
        # Pull all alarms in time period
        all_alarms = df['Alarm'].between_time(
            t1, t2, inclusive="right").dropna().str.lower()
        # Number of hours
        hours = (pd.to_datetime(t2)-pd.to_datetime(t1)).seconds/3600
        hours = hours*days
        # Don't count the alarm if it includes the words:  QUIET, BOLUS, ENTER BG,
        matches = ["quiet", "bolus", "enter bg"]
        all_alarms = [alarm for alarm in all_alarms if all(
            x not in alarm for x in matches)]
        if len(all_alarms) == 0 and hours == 0:
            hours = 1
        # Alarm types (per Cari)
        # Threshold
        threshold = [alarm for alarm in all_alarms if 'alert' in alarm]
        threshold = [alarm for alarm in threshold if 'cal' not in alarm]
        # Maintenance
        matches = ["sensor", "cal", "signal", "transmtr"]
        maintenance = [alarm for alarm in all_alarms if any(
            x in alarm for x in matches)]
        maintenance = [
            alarm for alarm in maintenance if 'auto mode' not in alarm]
        # HCL specific
        hcl = [alarm for alarm in all_alarms if 'auto' in alarm]
        hcl = [alarm for alarm in hcl if 'pump' not in alarm]
        # Pump maintenance
        matches = ["pump", "battery", "reservoir"]
        pump = [alarm for alarm in all_alarms if any(
            x in alarm for x in matches)]
        # Other
        other = len(all_alarms) - \
            sum([len(threshold), len(maintenance), len(hcl), len(pump)])
        # Return
        results['num_alarms'+'_'+time].append(len(all_alarms)/hours)
        results['threshold_alarms'+'_'+time].append(len(threshold)/hours)
        results['maintenance_alarms'+'_'+time].append(len(maintenance)/hours)
        results['hcl_alarms'+'_'+time].append(len(hcl)/hours)
        results['pump_alarms'+'_'+time].append(len(pump)/hours)
        results['other_alarms'+'_'+time].append(other/hours)
# Results as a dataframe
df = pd.DataFrame(data=results)
# Remove those missing data
df = df.loc[df['days_with_data'] > 0, :]
# Write
df.to_csv(wd+"Data_Cleaned/alarms_per_hour.csv", index=False)
