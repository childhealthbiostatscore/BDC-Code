import os
import pandas as pd
import numpy as np
import datetime
from dateutil.parser import parse
from scipy.stats import mode
# Import data
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/K23/"
# Iterate through CGM files, match with row in a1cs df, calculate metrics
# Dictionary for storing results
df = {
    "ID": [],
    "Sensor Readings": [],
    "Sensor Interval (minutes)":[],
    "14 Day Mean": [],
    "14 Day TIR < 70": [],
    "14 Day TIR 70 - 140": [],
    "14 Day TIR 70 - 180": [],
    "14 Day TIR Over 180": [],
    "CV": []
}
# Get CGM file names
all_files = []
for root, subdirs, files in os.walk(wd+"5. Subject data/K-23"):
    all_files += [os.path.join(root, file) for file in files]
r1_csvs = [f for f in all_files if "r1-" in f.lower() or "r1_" in f.lower()]
# Iterate through CGM files
for file in r1_csvs:
    df['ID'].append(file.split("/")[14])
    # Read in
    d = pd.read_csv(file,low_memory=False)
    # Identify type of CGM file
    if "Index" in d.columns:
        # Pull timestamp and glucose
        d = d[['Timestamp (YYYY-MM-DDThh:mm:ss)','Glucose Value (mg/dL)']]
        # Format time
        d['Timestamp (YYYY-MM-DDThh:mm:ss)'] = [str(date).replace("T"," ") for date in d['Timestamp (YYYY-MM-DDThh:mm:ss)']]
    elif 'Generated on' in d.columns:
        d.columns = d.iloc[1,:]
        d = d[['Device Timestamp','Historic Glucose mg/dL']]
    elif 'Study ID' in d.columns:
        sensor_start = np.where(d.iloc[:,2] == "Sensor")[0][0] + 1
        d.columns = d.iloc[sensor_start,:]
        d = d.iloc[range(sensor_start+1,d.shape[0]),:]
        d['datetime'] = d['Date'] + ' ' + d['Time']
        d = d[['datetime','Sensor Glucose (mg/dL)']]
    # Column names
    d.columns = ['timestamp','glucose']
    # Format time
    d['timestamp'] = [pd.to_datetime(date,errors="coerce") for date in d['timestamp']]
    d['glucose'] = pd.to_numeric(d['glucose'],errors="coerce")
    # Limit to two weeks up to most recent
    d.dropna(inplace=True)
    end = max(d['timestamp'])
    start = end - pd.to_timedelta(14, unit='d')
    d.sort_values(by = 'timestamp',inplace=True)
    d.set_index('timestamp',inplace=True)
    d = d.loc[start:end]
    # Calculate metrics
    df["Sensor Readings"].append(d.shape[0])
    df["Sensor Interval (minutes)"].append(mode(np.diff(d.index))[0][0].astype('timedelta64[m]')/np.timedelta64(1, 'm'))
    df["14 Day Mean"].append(d['glucose'].mean())
    df['14 Day TIR < 70'].append((d['glucose'] < 70).mean()*100)
    df['14 Day TIR 70 - 140'].append(((d['glucose'] >= 70) & (d['glucose'] <= 140)).mean()*100)
    df['14 Day TIR 70 - 180'].append(((d['glucose'] >= 70) & (d['glucose'] <= 180)).mean()*100)
    df['14 Day TIR Over 180'].append((d['glucose'] > 180).mean()*100)
    df['CV'].append(d['glucose'].std()/d['glucose'].mean())
    # Round to 3 places
    for key in list(df.keys())[1:]:
        df[key] = [round(n,3) for n in df[key]]
# Results as a dataframe
df = pd.DataFrame(data=df)
df.to_csv(wd+"Data_Clean/cgm_r1_summary_stats.csv", index=False)
