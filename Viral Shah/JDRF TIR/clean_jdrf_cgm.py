import os
import re
import pandas as pd
import numpy as np
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/JDRF/"
# List all CGM files
# Group 1
# List subject folders
case_folders = [f.path for f in os.scandir(
    wd + "Data_Raw/13. JDRF_TIR/3. Data Collection/Cleaned Final Data/Group 1/Cases_T1D+DR") if f.is_dir()]
control_folders = [f.path for f in os.scandir(
    wd + "Data_Raw/13. JDRF_TIR/3. Data Collection/Cleaned Final Data/Group 2/Control_T1D+No DR") if f.is_dir()]
folders = case_folders + control_folders
folders.sort()
# List for storing results from all participants
final = []
for subject_folder in folders:
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
    subject_info.dropna(subset=["visit date"], inplace=True)
    # Combine all CGM data from CSVs for each subject
    csvs = [f for f in files if ".csv" in f.lower()]
    all_cgm = []
    if len(csvs) == 0:
        continue
    for cgm_file in csvs:
        cgm = pd.read_csv(subject_folder+"/"+cgm_file, low_memory=False)
        # Detect file type and format accordingly
        if cgm.shape[1] == 14:  # Dexcom
            # Get datetime and glucose columns
            cols = [c for c in cgm.columns if (
                "timestamp" in c.lower()) or ("glucose value" in c.lower())]
            cgm = cgm[cols]
            cgm.columns = ["datetime" if "timestamp" in c.lower()
                           else "sensor_glucose" for c in cgm.columns]
            # Format date
            cgm["datetime"] = [str(d).replace("T", " ")
                               for d in cgm["datetime"]]
        elif cgm.shape[1] == 19:
            cgm.columns = cgm.iloc[1, :]
            cols = [c for c in cgm.columns if ("timestamp" in c.lower()) or (
                "historic glucose" in c.lower())]
            cgm = cgm[cols]
            cgm.columns = ["datetime", "sensor_glucose"]
        elif cgm.shape[1] >= 46:
            cgm_list = []
            sensor_starts = np.where(cgm.iloc[:, 2] == "Sensor")[0]
            if len(sensor_starts) == 0:
                continue
            for i in range(0, len(sensor_starts)):
                sens_start = sensor_starts[i]
                if(i+1 < len(sensor_starts)):
                    sens_end = sensor_starts[i+1]-1
                else:
                    sens_end = cgm.shape[0]

                t = cgm.iloc[sens_start:sens_end, :]
                t.columns = t.iloc[1, :]
                t = t.loc[:, t.columns.notna()]
                t["datetime"] = t["Date"] + " " + t["Time"]
                cols = [c for c in t.columns if (
                    "datetime" in c.lower()) or ("sensor glucose" in c.lower())]
                t = t[cols]
                colnames = t.columns.to_list()
                colnames[np.where(colnames != "datetime")[
                    0][0]] = "sensor_glucose"
                t.columns = colnames
                cgm_list.append(t)
            cgm = pd.concat(cgm_list)
        elif cgm.shape[1] == 40 | cgm.shape[1] == 41:
            file_end = np.where(cgm.iloc[:, 4] == "BG")[0][0] - 1
            cgm.columns = cgm.iloc[5, :]
            cols = ["EventDateTime", "Readings (CGM / BGM)"]
            cgm = cgm[cols]
            cgm.columns = ["datetime", "sensor_glucose"]
            cgm = cgm.iloc[:file_end, :]
        else:
            break
        # Format columns
        cgm = cgm[["datetime", "sensor_glucose"]]
        # Format datetime (some have decimal points?)
        cgm["datetime"] = [re.sub(r"\..*", "", str(d))
                           for d in cgm["datetime"]]
        cgm["datetime"] = pd.to_datetime(cgm["datetime"],
                                         errors="coerce")
        # "Low" and "High" to 40 and 400 respectively
        cgm.loc[cgm["sensor_glucose"] == "Low", "sensor_glucose"] = 40
        cgm.loc[cgm["sensor_glucose"] == "High", "sensor_glucose"] = 400
        cgm["sensor_glucose"] = pd.to_numeric(
            cgm["sensor_glucose"], errors="coerce")
        # Remove ISIG values (they have )
        # Drop missing
        cgm.dropna(inplace=True)
        if cgm.shape[0] == 0:
            continue
        # Add to combined
        all_cgm.append(cgm)
    # Flatten lists and convert to dataframe
    all_cgm = pd.concat(all_cgm)
    all_cgm.sort_values(by="datetime", inplace=True)
    # Drop duplicates
    all_cgm.drop_duplicates(inplace=True)
    # Go through visit dates and get two weeks of data
    subject_data = {"id": [], "visit_num": [], "visit_date": [], "a1c": [],
                    "sensor_readings": [], "sensor_interval": [],
                    "tbr": [], "ttir": [], "tir": [], "tar": [], "mean_glucose": []}
    for index, row in subject_info.iterrows():
        # Fill in summary data from Viral
        subject_data["id"].append(id)
        subject_data["visit_num"].append(row.iloc[1])
        subject_data["visit_date"].append(row.iloc[2].strftime("%Y-%m-%d"))
        subject_data["a1c"].append(row.iloc[3])
        # Calculate last two weeks CGM metrics
        visit_date = row.iloc[2]
        start = visit_date - pd.Timedelta(14, unit="d")
        cgm = all_cgm.loc[(all_cgm["datetime"] >= start) &
                          (all_cgm["datetime"] <= visit_date)]
        # Check that CGM data exists
        if cgm.shape[0] == 0:
            subject_data["sensor_readings"].append(np.nan)
            subject_data["sensor_interval"].append(np.nan)
            subject_data["tbr"].append(np.nan)
            subject_data["ttir"].append(np.nan)
            subject_data["tir"].append(np.nan)
            subject_data["tar"].append(np.nan)
            subject_data["mean_glucose"].append(np.nan)
            continue
        subject_data["sensor_readings"].append(cgm.shape[0])
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
            round(cgm["datetime"].diff().mode()[0].seconds/60))
        subject_data["tbr"].append(round(tbr, 3))
        subject_data["ttir"].append(round(ttir, 3))
        subject_data["tir"].append(round(tir, 3))
        subject_data["tar"].append(round(tar, 3))
        subject_data["mean_glucose"].append(round(mean_glu, 3))
    # Add to final results
    subject_data = pd.DataFrame(subject_data)
    final.append(subject_data)
# Write
final = pd.concat(final)
final.dropna(subset=["sensor_readings"], inplace=True)
final = final[final["sensor_readings"] >= 100]
final.to_csv(wd+"Data_Cleaned/cgm_metrics_from_csvs.csv", index=False)
