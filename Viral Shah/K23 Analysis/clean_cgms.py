import os
import pandas as pd
import numpy as np
import datetime
from dateutil.parser import parse
# Import data
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/K23/"
# Most recent HbA1c information
a1cs = pd.read_csv(wd + "Data_Clean/a1cs.csv",
                   parse_dates=["MostRecentVisitDate"])
# Iterate through CGM files, match with row in a1cs df, calculate metrics
# Dictionary for storing results
df = {
    "ID": [],
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
    print(file)
    # Read in
    d = pd.read_csv(file)
    # Identify type of CGM file
    if "Index" in d.columns:
        # Pull timestamp and glucose
        d = d[['Timestamp (YYYY-MM-DDThh:mm:ss)','Glucose Value (mg/dL)']]
        # Format time
        d['Timestamp (YYYY-MM-DDThh:mm:ss)'] = [pd.to_datetime(str(date).replace("T"," ")) for date in d['Timestamp (YYYY-MM-DDThh:mm:ss)']]
    elif "Study ID" in d.columns:
        d.columns = d.iloc[1,:]
        d = d[['Device Timestamp','Historic Glucose mg/dL']]
        d['Device Timestamp'] = [pd.to_datetime(date,errors="coerce") for date in d['Device Timestamp']]
    # Limit to two weeks up to most recent
    d.dropna(inplace=True)
    d.columns = ['timestamp','glucose']
    d['glucose'] = pd.to_numeric(d['glucose'],errors="coerce")
    end = max(d['timestamp'])
    start = end - pd.to_timedelta(14, unit='d')
    d.sort_values(by = 'timestamp',inplace=True)
    d.set_index('timestamp',inplace=True)
    d = d.loc[start:end]
    # Calculate metrics
    df["14 Day Mean"].append(d['glucose'].mean())
# Results as a dataframe
df = pd.DataFrame(data=df)
df.to_csv("/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/GMI and A1c/Data_Clean/kaan_mean_glucose.csv", index=False)
