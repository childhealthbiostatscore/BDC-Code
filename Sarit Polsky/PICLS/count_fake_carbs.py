# Setup
from glob import iglob
from os.path import basename
from os import listdir
import pandas as pd
import numpy as np
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Sarit Polsky/PICLS/"
# Time range
bwz_time_range = "5 min"
bolus_time_range = "15 min"
# Dict for results
res = {"Filename": [], "Number of 'Other' Events": [],
       "Number of 'Other' Events With Bolus": [],
       "Total Bolus Volume Associated With 'Other' Event": [],
       "Total Bolus Volume Associated With Fake Carbs": []}
# Iterate through all files
files = listdir(wd + "Data_Clean/Carelink Pump Files")
files.sort()
for file in files:
    # File name
    res["Filename"].append(file.replace(".csv", ""))
    # Read in
    df = pd.read_csv(wd + "Data_Clean/Carelink Pump Files/" +
                     file, low_memory=False)
    # Combine date and time
    df["timestamp"] = pd.to_datetime(
        df.iloc[:, 1] + " " + df.iloc[:, 2], errors="coerce")
    # Remove auto boluses
    df = df.iloc[list(np.where(df["Bolus Source"] !=
                               "CLOSED_LOOP_MICRO_BOLUS")[0]), :]
    # Get all bolus timestamps
    bolus_times = list(df["timestamp"].iloc[list(
        np.where(pd.notna(df["Bolus Volume Delivered (U)"]))[0])].dropna())
    # Get all correction estimate timestamps
    correction_times = list(df["timestamp"].iloc[list(
        np.where(pd.notna(df["BWZ Correction Estimate (U)"]))[0])].dropna())
    # 'Other' event timestamps
    other_times = list(df["timestamp"].iloc[list(
        np.where(df["Event Marker"] == "Other")[0])].dropna())
    # For each "other" event, calculate the bolus delivered due to fake carbs
    total_bolus = 0
    total_bolus_fake_carbs = 0
    fake_carb_bolus = 0
    if len(other_times) > 0:
        for t in other_times:
            # Check for BWZ within 2 minutes (before or after)
            corrections = [c for c in correction_times if c < t +
                           pd.to_timedelta(bwz_time_range) and c > t - pd.to_timedelta(bwz_time_range)]
            corrections = pd.to_numeric(df.loc[df["timestamp"].isin(
                corrections), "BWZ Correction Estimate (U)"])
            # Check for boluses with 15 minutes after
            boluses = [b for b in bolus_times if b < t +
                       pd.to_timedelta(bolus_time_range) and b > t]
            boluses = pd.to_numeric(df.loc[df["timestamp"].isin(
                boluses), "Bolus Volume Delivered (U)"])
            if len(boluses) > 0:
                total_bolus += boluses.sum()
                total_bolus_fake_carbs += boluses.sum() - corrections.sum()
                fake_carb_bolus += 1
    # Store results
    res["Number of 'Other' Events"].append(len(other_times))
    res["Number of 'Other' Events With Bolus"].append(fake_carb_bolus)
    res["Total Bolus Volume Associated With 'Other' Event"].append(total_bolus)
    res["Total Bolus Volume Associated With Fake Carbs"].append(
        total_bolus_fake_carbs)
df = pd.DataFrame(res)
df.sort_values("Filename", inplace=True)
df.to_csv(wd + "Data_Clean/fake_carb_boluses.csv", index=False)
