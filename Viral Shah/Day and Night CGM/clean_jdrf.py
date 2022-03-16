import os
import glob
import parsedatetime
import pandas as pd
import numpy as np
from datetime import datetime
from statistics import mode
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/JDRF/"
cal = parsedatetime.Calendar()
# Results dict for storing data
results = {
    "id": [],
    "visit": [],
    "age": [],
    "sensor_readings": [],
    "total_tir": [],
    "night_tir": [],
    "day_tir": [],
    "mbg": [],
    "day_mbg": [],
    "night_mbg": [],
    "a1c": [],
}
# Calculate CGM values, etc. for each person
folders = os.listdir(wd + "Data_Raw/Cases_T1D+DR")
folders.sort()
folders = [f for f in folders if "DS_Store" not in f]
for fol in folders:
    # Get ID
    subject_id = [int(i) for i in fol.split() if i.isdigit()][0]
    # Find summary and CSV files
    files = os.listdir(wd + "Data_Raw/Cases_T1D+DR/" + fol)
    csvs = [f for f in files if ".csv" in f]
    csvs.sort()
    summary = [f for f in files if "summary" in f.lower()][0]
    summary = pd.read_excel(
        wd + "Data_Raw/Cases_T1D+DR/" + fol + "/" + summary,
        engine="openpyxl",
    )
    dob = summary.iloc[0, 0]
    for c in csvs:
        # Get visit number
        vis = c.split("_")[0]
        vis = [int(i) for i in vis.split() if i.isdigit()][0]
        # Two weeks of data leading up to visit
        end_date = summary.loc[summary.iloc[:, 1] == vis]["Office Visit Date"]
        start_date = end_date - pd.to_timedelta(14, unit="d")
        if (not pd.isnull(dob)):
            age = start_date - dob
            age = float(age.dt.days / 365.25)
        else:
            age = np.nan
        end_date = end_date.dt.strftime("%Y-%m-%d").values[0]
        start_date = start_date.dt.strftime("%Y-%m-%d").values[0]
        # Import CGM file
        cgm = pd.read_csv(
            wd + "Data_Raw/Cases_T1D+DR/" + fol + "/" + c,
            low_memory=False,
        )
        # Get timestamp and glucose columns, format
        if "Timestamp (YYYY-MM-DDThh:mm:ss)" in cgm.columns:
            cgm = cgm[["Timestamp (YYYY-MM-DDThh:mm:ss)",
                       "Glucose Value (mg/dL)"]]
        elif cgm.shape[1] == 19:
            start = cgm.loc[cgm.iloc[:, 2] == "Device Timestamp"].index[0]
            cgm.columns = cgm.iloc[start, :]
            cgm = cgm.iloc[start + 1:, :]
            cgm = cgm[["Device Timestamp", "Historic Glucose mg/dL"]]
        elif cgm.shape[1] > 40:
            start = cgm.loc[cgm.iloc[:, 2] == "Sensor"].index[0]
            cgm.columns = cgm.iloc[start + 1, :]
            cgm = cgm.iloc[start + 2:, :]
            cgm.reset_index(inplace=True)
            cgm["timestamp"] = cgm["Date"] + " " + cgm["Time"]
            cgm = cgm[["timestamp", "Sensor Glucose (mg/dL)"]]
        cgm.columns = ["timestamp", "glucose"]
        cgm.dropna(inplace=True)
        # Glucose to numeric replace "high" and "low" with limits of detection
        cgm["glucose"].replace("High", 400, inplace=True)
        cgm["glucose"].replace("Low", 40, inplace=True)
        cgm["glucose"] = pd.to_numeric(cgm["glucose"], errors="coerce")
        # Format timestamp if necessary
        cgm["timestamp"] = [t.replace("T", " ") for t in cgm["timestamp"]]
        cgm["timestamp"] = [cal.parse(t)[0] for t in cgm["timestamp"]]
        cgm["timestamp"] = [datetime(*t[:6]) for t in cgm["timestamp"]]
        # Complete cases
        cgm.dropna(inplace=True)
        # Re-index and sort
        cgm.set_index("timestamp", inplace=True)
        cgm.sort_index(inplace=True)
        # Remove all but two weeks prior
        cgm = cgm.loc[start_date:end_date]
        # All
        total_r = cgm["glucose"].notna().sum()
        tir = [g for g in cgm["glucose"] if g >= 70 and g <= 140]
        mbg = cgm["glucose"].mean()
        # Split into day and night
        day = cgm.between_time(
            "6:00", "23:00", include_start=False, include_end=False)
        night = cgm.between_time("23:00", "6:00")
        # Skip if no data
        if cgm.shape[0] == 0:
            continue
        # Day and night TIR
        day_r = day["glucose"].notna().sum()
        day_tir = [g for g in day["glucose"] if g >= 70 and g <= 140]
        day_mbg = day["glucose"].mean()
        night_r = night["glucose"].notna().sum()
        night_tir = [g for g in night["glucose"] if g >= 70 and g <= 140]
        night_mbg = night["glucose"].mean()
        # Write results
        results["total_tir"].append(len(tir) / total_r * 100)
        results["day_tir"].append(len(day_tir) / day_r * 100)
        results["night_tir"].append(len(night_tir) / night_r * 100)
        results["mbg"].append(mbg)
        results["day_mbg"].append(day_mbg)
        results["night_mbg"].append(night_mbg)
        a1c = float(summary.loc[summary.iloc[:, 1] == vis]["A1c"])
        results["a1c"].append(a1c)
        # ID etc.
        results["id"].append(subject_id)
        results["visit"].append(vis)
        results["age"].append(age)
        results["sensor_readings"].append(total_r)
results = pd.DataFrame(results)
results.sort_values(by=["id", "visit"], inplace=True)
results.dropna(inplace=True)
results.to_csv("/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/\
    Laura/BDC/Projects/Viral Shah/Day and Night CGM/Data_Clean/\
        analysis_data_jdrf_cases.csv",index=False)
