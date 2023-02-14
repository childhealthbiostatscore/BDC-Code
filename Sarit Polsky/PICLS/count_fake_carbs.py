# Setup
import itertools
from glob import iglob
from os.path import basename
import pandas as pd
import numpy as np
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Sarit Polsky/PICLS/"
# Time range
time_range = "2 min"
# Dict for results
res = {"file": [], "num_other_events": [], "one_bolus": [], "zero_bolus": [],
       "more_than_one_bolus": [], "more_than_one_carb": []}
# Iterate through all files
for file in iglob(wd + "Data_Raw/CGM Downloads/" + "**/*.csv", recursive=True):
    # File name
    res["file"].append(basename(file))
    # Read in
    df = pd.read_csv(file, low_memory=False)
    # Rename columns from pump row
    df.columns = df.iloc[np.where(df.iloc[:, 2] == "Pump")[0][0] + 1, :]
    # Combine date and time
    df["timestamp"] = pd.to_datetime(
        df.iloc[:, 1] + " " + df.iloc[:, 2], errors="coerce")
    # Remove auto boluses
    df = df.iloc[list(np.where(df["Bolus Source"] !=
                      "CLOSED_LOOP_MICRO_BOLUS")[0]), :]
    # Convert 0 to missing
    df.loc[df["BWZ Carb Input (grams)"] == "0",
           "BWZ Carb Input (grams)"] = np.nan
    # Get all bolus timestamps
    bolus_times = list(df["timestamp"].iloc[list(
        np.where(pd.notna(df["Bolus Volume Delivered (U)"]))[0])].dropna())
    # Get all carb timestamps
    carb_times = list(df["timestamp"].iloc[list(
        np.where(pd.notna(df["BWZ Carb Input (grams)"]))[0])].dropna())
    # 'Other' event timestamps
    other_times = list(df["timestamp"].iloc[list(
        np.where(df["Event Marker"] == "Other")[0])].dropna())
    # Count the number of carbs and boluses associated with each 'Other' event
    num_bolus = []
    num_carbs = []
    for t in other_times:
        num_bolus.append(len([b for b in bolus_times if b < t + pd.to_timedelta(
            time_range) and b > t - pd.to_timedelta(time_range)]))
        num_carbs.append([c for c in carb_times if c < t +
                         pd.to_timedelta(time_range) and c > t - pd.to_timedelta(time_range)])
    # Convert any multiple carbs timestamps into a single string ()
    multiple_carbs = [l for l in num_carbs if len(l) > 1]
    multiple_carbs = ", ".join([str(i) for i in list(
        itertools.chain.from_iterable(multiple_carbs))])
    # Store results
    res["num_other_events"].append(len(other_times))
    res["one_bolus"].append(len([b for b in num_bolus if b == 1]))
    res["zero_bolus"].append(len([b for b in num_bolus if b == 0]))
    res["more_than_one_bolus"].append(len([b for b in num_bolus if b > 1]))
    res["more_than_one_carb"].append(multiple_carbs)
df = pd.DataFrame(res)
df.sort_values("file", inplace=True)
df.to_csv(wd + "Data_Clean/fake_carbs.csv", index=False)
