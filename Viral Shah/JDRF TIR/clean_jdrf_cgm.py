from datetime import datetime
import os
import itertools
import pandas as pd
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/JDRF/"
# List all CGM files
# Group 1
# List subject folders
case_folders = [f.path for f in os.scandir(
    wd + "Data_Raw/13. JDRF_TIR/3. Data Collection/Cleaned Final Data/Group 1/Cases_T1D+DR") if f.is_dir()]
case_folders.sort()
for subject_folder in case_folders:
    # Get ID
    id = os.path.basename(subject_folder)
    id = [int(s) for s in id.split() if s.isdigit()][0]
    id = str(id).zfill(3)
    # Find relevant files
    files = os.listdir(subject_folder)
    subject_info = [f for f in files if "summary" in f.lower()]
    subject_info = pd.read_excel(subject_folder + "/" + subject_info[0])
    # Format subject info for easier reading
    subject_info.columns = [c.lower() for c in subject_info.columns]
    subject_info.columns = ["visit date" if "date" in c.lower()
                            else c for c in subject_info.columns]
    # Combine all CGM data from CSVs
    csvs = [f for f in files if ".csv" in f.lower()]
    all_cgm = []
    for cgm_file in csvs:
        cgm = pd.read_csv(subject_folder+"/"+cgm_file)
        # Detect file type and format accordingly
        if cgm.shape[1] == 14:  # Dexcom
            # Get datetime and glucose columns
            cols = [c for c in cgm.columns if (
                "timestamp" in c.lower()) or ("glucose value" in c.lower())]
            cgm = cgm[cols]
            cgm.columns = ["datetime" if "timestamp" in c.lower()
                           else 'sensor_glucose' for c in cgm.columns]
            # Drop missing, format columns
            cgm.dropna(inplace=True)
            cgm["datetime"] = [pd.to_datetime(d.replace("T", " "))
                               for d in cgm["datetime"]]
            # "Low" and "High" to 40 and 400 respectively
            cgm.loc[cgm['sensor_glucose'] == "Low", 'sensor_glucose'] = 40
            cgm.loc[cgm['sensor_glucose'] == "High", 'sensor_glucose'] = 400
            cgm['sensor_glucose'] = pd.to_numeric(cgm['sensor_glucose'])
        # Add to combined
        all_cgm.append(cgm)
    # Flatten lists and convert to dataframe
    all_cgm = pd.concat(all_cgm)
    all_cgm.sort_values(by="datetime", inplace=True)
    # Go through visit dates and get two weeks of data
    subject_data = {"id": [], "visit_num": [], "visit_date": [], "a1c": [],
                    "sensor_readings": [], "sensor_interval": [],
                    "tbr": [], "ttir": [], "tir": [], "tar": [], "mean_glucose": []}
    for index, row in subject_info.iterrows():
        # Fill in summary data from Viral
        subject_data["id"].append(id)
        subject_data["visit_num"].append(row.iloc[1])
        subject_data["visit_date"].append(row.iloc[2].strftime('%Y-%m-%d'))
        subject_data["a1c"].append(row.iloc[3])
        # Calculate last two weeks CGM metrics
        visit_date = row.iloc[2]
        start = visit_date - pd.Timedelta(14, unit="d")
        cgm = all_cgm.loc[(all_cgm["datetime"] >= start) &
                          (all_cgm["datetime"] <= visit_date)]
        # Basic metrics
        subject_data["sensor_readings"].append(cgm.shape[0])
        # Check that CGM data exists
        if cgm.shape[0] == 0:
            subject_data["sensor_interval"].append("NA")
            subject_data["tbr"].append("NA")
            subject_data["ttir"].append("NA")
            subject_data["tir"].append("NA")
            subject_data["tar"].append("NA")
            subject_data["mean_glucose"].append("NA")
            continue
        # TIR, etc.
        ttir = len([g for g in cgm["sensor_glucose"] if g >=
                   70 and g <= 140])/cgm.shape[0] * 100
        tir = len([g for g in cgm["sensor_glucose"] if g >=
                  70 and g <= 180])/cgm.shape[0] * 100
        tbr = len([g for g in cgm["sensor_glucose"] if g < 70]) / \
            cgm.shape[0] * 100
        tar = len([g for g in cgm["sensor_glucose"] if g > 180]) / \
            cgm.shape[0] * 100
        mean_glu = cgm["sensor_glucose"].mean()
        # Append
        subject_data["sensor_interval"].append(
            cgm["datetime"].diff().mode()[0].seconds/60)
        subject_data["tbr"].append(round(tbr, 3))
        subject_data["ttir"].append(round(ttir, 3))
        subject_data["tir"].append(round(tir, 3))
        subject_data["tar"].append(round(tar, 3))
        subject_data["mean_glucose"].append(round(mean_glu, 3))
