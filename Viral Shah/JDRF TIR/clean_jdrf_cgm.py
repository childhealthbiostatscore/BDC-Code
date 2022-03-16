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
    "visit_date": [],
    "age": [],
    "sensor_readings": [],
    "sensor_interval_mins": [],
    "time_below_54": [],
    "time_below_70": [],
    "tir_70_180": [],
    "time_above_180": [],
    "time_above_250": [],
    "mean_sensor": [],
    "sd_sensor": [],
    "cv_sensor": [],
    "a1c": [],
}
# Calculate CGM values, etc. for each person
folders = os.listdir(wd + "Data_Raw/Control_T1D+No DR")
folders.sort()
folders = [f for f in folders if "DS_Store" not in f]
for fol in folders:
    # Get ID
    subject_id = [int(i) for i in fol.split() if i.isdigit()][0]
    # Find summary and CSV files
    files = os.listdir(wd + "Data_Raw/Control_T1D+No DR/" + fol)
    csvs = [f for f in files if ".csv" in f]
    csvs.sort()
    summary = [f for f in files if "summary" in f.lower()][0]
    summary = pd.read_excel(
        wd + "Data_Raw/Control_T1D+No DR/" + fol + "/" + summary,
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
            wd + "Data_Raw/Control_T1D+No DR/" + fol + "/" + c,
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
        # Get sensor interval
        sens_int = cgm['timestamp'].diff().mode()
        sens_int = sens_int.dt.total_seconds().abs()/60
        # Complete cases
        cgm.dropna(inplace=True)
        # Re-index and sort
        cgm.set_index("timestamp", inplace=True)
        cgm.sort_index(inplace=True)
        # Remove all but two weeks prior
        cgm = cgm.loc[start_date:end_date]
        # All
        total_r = cgm["glucose"].notna().sum()
        time_below_54 = [g for g in cgm["glucose"] if g < 54]
        time_below_70 = [g for g in cgm["glucose"] if g < 70]
        tir_70_180 = [g for g in cgm["glucose"] if g >= 70 and g <= 180]
        time_above_180 = [g for g in cgm["glucose"] if g > 180]
        time_above_250 = [g for g in cgm["glucose"] if g > 250]
        mean_sensor = cgm["glucose"].mean()
        sd_sensor = cgm["glucose"].std()
        cv_sensor = sd_sensor / mean_sensor
        # Skip if no data
        if cgm.shape[0] == 0:
            continue
        # Write results
        results["time_below_54"].append(len(time_below_54) / total_r * 100)
        results["time_below_70"].append(len(time_below_70) / total_r * 100)
        results["tir_70_180"].append(len(tir_70_180) / total_r * 100)
        results["time_above_180"].append(len(time_above_180) / total_r * 100)
        results["time_above_250"].append(len(time_above_250) / total_r * 100)
        results["mean_sensor"].append(mean_sensor)
        results["sd_sensor"].append(sd_sensor)
        results["cv_sensor"].append(cv_sensor)
        a1c = float(summary.loc[summary.iloc[:, 1] == vis]["A1c"])
        results["a1c"].append(a1c)
        visit_date = summary.loc[summary.iloc[:, 1]
                                 == vis]["Office Visit Date"]
        results["visit_date"].append(
            np.datetime_as_string(visit_date, unit='D')[0])
        # ID etc.
        results["id"].append(subject_id)
        results["visit"].append(vis)
        results["age"].append(age)
        results["sensor_readings"].append(total_r)
        results["sensor_interval_mins"].append(sens_int[0])
results = pd.DataFrame(results)
results.sort_values(by=["id", "visit"], inplace=True)
results.dropna(inplace=True)
results.to_csv(wd + "Data_Cleaned/cgm_controls.csv", index=False)
