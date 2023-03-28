# Setup
from os import listdir
import pandas as pd
import numpy as np
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Sarit Polsky/PICLS/"
# Combine all files into a large dataframe
files = listdir(wd + "Data_Clean/Carelink Pump Files")
files.sort()
if ".DS_Store" in files:
    files.remove(".DS_Store")
all_df = []
for file in files:
    # Get ID
    id = file.split("_")[0]
    # Read in - only necessary columns
    df = pd.read_csv(wd + "Data_Clean/Carelink Pump Files/" + file,
                     usecols=["datetime", "Event Marker", "Bolus Source",
                              "BWZ Food Estimate (U)",
                              "Bolus Volume Delivered (U)"])
    df.rename({"datetime": "Timestamp"}, inplace=True, axis=1)
    # Remove auto boluses
    df = df.iloc[list(np.where(df["Bolus Source"] !=
                               "CLOSED_LOOP_MICRO_BOLUS")[0]), :]
    df.drop("Bolus Source", axis=1)
    # Drop rows with all missing or no timestamp
    df.dropna(subset=list(df.columns[:-1]), how="all", inplace=True)
    df.dropna(subset="Timestamp", inplace=True)
    # Add ID
    df["ID"] = id
    # Put in list
    all_df.append(df)
# Combine list of dataframes
all_df = pd.concat(all_df)
# Convert to datetime
all_df["Timestamp"] = pd.to_datetime(all_df["Timestamp"])
# Sort
all_df.sort_values(by=["ID", "Timestamp"], inplace=True)
# Get participant dates
dates = pd.read_csv(wd + "Data cleaning/CGM Data Check.csv",
                    usecols=["pid", "randomization_date"])
dates.rename({"pid": "ID", "randomization_date": "Randomization Date"},
             axis=1, inplace=True)
# Add to big dataframe
all_df = all_df.merge(dates, how="left")
all_df["Randomization Date"] = pd.to_datetime(all_df["Randomization Date"])
# Calculate weeks from randomization
all_df["Days from Randomization"] = \
    (all_df["Timestamp"] - all_df["Randomization Date"]).dt.days
all_df["Week Num."] = all_df["Days from Randomization"] / 7
all_df["Week Num."] = np.floor(all_df["Week Num."])
# Write to check
all_df.to_csv(wd + "Data_Clean/" + "combined_pump_data.csv", index=False)


# Split by ID and week
all_df = [y for x, y in all_df.groupby(["ID", "Week Num."])]
# Iterate through by ID
# Time range
bwz_time_range = "5 min"
bolus_time_range = "15 min"
# Dict for results
res = {"ID": [], "Randomization Date": [], "Week Num.": [],
       "Number of 'Other' Events": [],
       "Number of 'Other' Events With Bolus": [],
       "Total Bolus Volume Associated With 'Other' Event": [],
       "Total Bolus Volume Associated With Fake Carbs": [],
       "Total Bolus Volume": []}
for df in all_df:
    # File name
    res["ID"].append(df["ID"].iloc[0])
    res["Randomization Date"].append(df["Randomization Date"].iloc[0])
    res["Week Num."].append(df["Week Num."].iloc[0])
    # Get all bolus timestamps
    bolus_times = list(df["Timestamp"].iloc[list(
        np.where(pd.notna(df["Bolus Volume Delivered (U)"]))[0])].dropna())
    # Convert to numeric
    df["Bolus Volume Delivered (U)"] = pd.to_numeric(
        df["Bolus Volume Delivered (U)"], errors="coerce")
    # Get all correction estimate timestamps
    correction_times = list(df["Timestamp"].iloc[list(
        np.where(pd.notna(df["BWZ Food Estimate (U)"]))[0])].dropna())
    # 'Other' event timestamps
    other_times = list(df["Timestamp"].iloc[list(
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
            corrections = pd.to_numeric(df.loc[df["Timestamp"].isin(
                corrections), "BWZ Food Estimate (U)"])
            # Check for boluses with 15 minutes after
            boluses = [b for b in bolus_times if b < t +
                       pd.to_timedelta(bolus_time_range) and b > t]
            boluses = df.loc[df["Timestamp"].isin(boluses),
                             "Bolus Volume Delivered (U)"]
            if len(boluses) > 0:
                total_bolus += boluses.sum()
                fake_carb_bolus += 1
                if boluses.sum() >= corrections.sum():
                    total_bolus_fake_carbs += corrections.sum()
                elif corrections.sum() > boluses.sum():
                    total_bolus_fake_carbs += boluses.sum()
    # Store results
    res["Number of 'Other' Events"].append(len(other_times))
    res["Number of 'Other' Events With Bolus"].append(fake_carb_bolus)
    res["Total Bolus Volume Associated With 'Other' Event"].append(total_bolus)
    res["Total Bolus Volume Associated With Fake Carbs"].append(
        total_bolus_fake_carbs)
    res["Total Bolus Volume"].append(df["Bolus Volume Delivered (U)"].sum())
df = pd.DataFrame(res)
df.to_csv(wd + "Data_Clean/fake_carb_boluses.csv", index=False)
