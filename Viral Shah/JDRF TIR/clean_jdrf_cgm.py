import os
import itertools
import pandas as pd
wd = "/Users/timvigers/Documents/Work/Viral Shah/JDRF/"
# List all CGM files
# Group 1
# List subject folders
case_folders = [f.path for f in os.scandir(
    wd + "Data_Raw/13. JDRF_TIR/3. Data Collection/Cleaned Final Data/Group 1/Cases_T1D+DR") if f.is_dir()]
case_folders.sort()
for subject_folder in case_folders:
    files = os.listdir(subject_folder)
    subject_info = [f for f in files if "summary" in f.lower()]
    subject_info = pd.read_excel(subject_folder + "/" + subject_info[0])
    # Format subject info for easier reading
    subject_info.columns = [c.lower() for c in subject_info.columns]
    # Combine all CGM data from CSVs
    csvs = [f for f in files if ".csv" in f.lower()]
    all_cgm = {"datetime": [], "sensor_glucose": []}
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
            cgm[cgm['sensor_glucose'] == "Low"] = 40
            cgm[cgm['sensor_glucose'] == "High"] = 400
            cgm['sensor_glucose'] = pd.to_numeric(cgm['sensor_glucose'])
        # Add to combined
        all_cgm["datetime"].append(cgm["datetime"])
        all_cgm["sensor_glucose"].append(cgm["sensor_glucose"])
    # Flatten lists and convert to dataframe
    all_cgm["datetime"] = list(itertools.chain(*all_cgm["datetime"]))
    all_cgm["sensor_glucose"] = \
        list(itertools.chain(*all_cgm["sensor_glucose"]))
    all_cgm = pd.DataFrame(all_cgm)
