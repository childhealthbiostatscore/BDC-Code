import os
import glob
import parsedatetime
import pandas as pd
import numpy as np
from datetime import datetime
from statistics import mode
wd = "/Users/timvigers/Documents/Work/Viral Shah/Day and Night CGM/"
cal = parsedatetime.Calendar()
# Results dict for storing data
results = {"id":[],"visit":[],"sensor_readings":[],"total_tir":[],"night_tir":[],"day_tir":[],"a1c":[]}
# Calculate CGM values, etc. for each person
folders = os.listdir(wd + "Data_Raw/Cleaned Final Data/Cases_T1D+DR")
folders = [f for f in folders if "DS_Store" not in f]
for fol in folders:
    # Get ID
    subject_id = [int(i) for i in fol.split() if i.isdigit()][0]
    # Find summary and CSV files
    files = os.listdir(wd + "Data_Raw/Cleaned Final Data/Cases_T1D+DR/" + fol)
    csvs = [f for f in files if ".csv" in f]
    summary = [f for f in files if "summary" in f.lower()][0]
    summary = pd.read_excel(wd + "Data_Raw/Cleaned Final Data/Cases_T1D+DR/" + fol + "/" + summary,engine = 'openpyxl')
    for c in csvs:
        # Get visit number
        vis = c.split("_")[0]
        vis = [int(i) for i in vis.split() if i.isdigit()][0]
        # Two weeks of data leading up to visit
        end_date = summary.loc[summary.iloc[:,1] == vis]["Office Visit Date"]
        start_date = end_date - pd.to_timedelta(14, unit='d')
        end_date = end_date.dt.strftime('%Y-%m-%d').values[0]
        start_date = start_date.dt.strftime('%Y-%m-%d').values[0]
        # Import CGM file
        cgm = pd.read_csv(wd + "Data_Raw/Cleaned Final Data/Cases_T1D+DR/" + fol + "/" + c,low_memory = False)
        # Get timestamp and glucose columns, format
        if "Timestamp (YYYY-MM-DDThh:mm:ss)" in cgm.columns:
            cgm = cgm[["Timestamp (YYYY-MM-DDThh:mm:ss)","Glucose Value (mg/dL)"]]
        elif cgm.shape[1] == 19:
            start = cgm.loc[cgm.iloc[:,2] == "Device Timestamp"].index[0]
            cgm.columns = cgm.iloc[start,:]
            cgm = cgm.iloc[start+1:,:]
            cgm = cgm[["Device Timestamp","Historic Glucose mg/dL"]]
        elif cgm.shape[1] > 40:
            start = cgm.loc[cgm['Unnamed: 2'] == "Sensor"].index[0]
            cgm.columns = cgm.iloc[start+1,:]
            cgm = cgm.iloc[start+2:,:]
            cgm.reset_index(inplace = True)
            cgm["timestamp"] = cgm["Date"] + " " + cgm["Time"]
            cgm = cgm[["timestamp","Sensor Glucose (mg/dL)"]]
        cgm.columns = ["timestamp","glucose"]
        cgm.dropna(inplace = True)
        # Glucose to numeric replace "high" and "low" with limits of detection
        cgm["glucose"].replace("High",400,inplace = True)
        cgm["glucose"].replace("Low",40,inplace = True)
        cgm["glucose"] = pd.to_numeric(cgm["glucose"],errors='coerce')
        # Format timestamp if necessary
        cgm["timestamp"] = [t.replace("T", " ") for t in cgm["timestamp"]]
        cgm["timestamp"] = [cal.parse(t)[0] for t in cgm["timestamp"]]
        cgm["timestamp"] = [datetime(*t[:6]) for t in cgm["timestamp"]]
        # Complete cases
        cgm.dropna(inplace = True)
        # Re-index
        cgm.set_index("timestamp",inplace = True)
        # Remove all but two weeks prior
        cgm = cgm.loc[start_date:end_date]
        # All TIR
        total_r = cgm["glucose"].notna().sum()
        tir = [g for g in cgm["glucose"] if g >= 70 and g <= 180]
        # Split into day and night
        day = cgm.between_time("6:00","23:00",include_start=False,include_end=False)
        night = cgm.between_time("23:00","6:00")
        # Skip if no data
        if cgm.shape[0] == 0:
            continue
        # Day and night TIR
        day_r = day["glucose"].notna().sum()
        day_tir = [g for g in day["glucose"] if g >= 70 and g <= 180]
        night_r = night["glucose"].notna().sum()
        night_tir = [g for g in night["glucose"] if g >= 70 and g <= 180]
        # Write results
        results["total_tir"].append(round(len(tir) / total_r * 100,2))
        results["day_tir"].append(round(len(day_tir) / day_r * 100,2))
        results["night_tir"].append(round(len(night_tir) / night_r * 100,2))
        a1c = float(summary.loc[summary.iloc[:,1] == vis]["A1c"])
        results["a1c"].append(a1c)
        # ID etc.
        results["id"].append(subject_id)
        results["visit"].append(vis)
        results["sensor_readings"].append(total_r)
results = pd.DataFrame(results)
results.sort_values(by = ["id","visit"],inplace = True)
results.dropna(inplace = True)
results.to_csv(wd + "Data_Clean/analysis_data_jdrf.csv",index = False)