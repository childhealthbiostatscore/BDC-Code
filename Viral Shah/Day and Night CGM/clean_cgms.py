import os
import pathlib
import pandas as pd
import numpy as np
import datetime
from dateutil.parser import parse

# Import data
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/Day and Night CGM/"
# Most recent HbA1c information
a1cs = pd.read_csv(wd + "Data_Clean/a1cs.csv", parse_dates=["MostRecentVisitDate"])
# Iterate through CGM files, match with row in a1cs df, calculate metrics
# Dictionary for storing results
df = {
    "ID": [],
    "Gender": [],
    "Age": [],
    "Insulin": [],
    "HbA1c": [],
    "14 Day Mean": [],
    "14 Day TIR": [],
    "14 Night Mean": [],
    "14 Night TIR": [],
    "30 Day Mean": [],
    "30 Day TIR": [],
    "30 Night Mean": [],
    "30 Night TIR": [],
    "60 Day Mean": [],
    "60 Day TIR": [],
    "60 Night Mean": [],
    "60 Night TIR": [],
    "90 Day Mean": [],
    "90 Day TIR": [],
    "90 Night Mean": [],
    "90 Night TIR": [],
}
# Iterate through files in wd
# os.listdir(wd+'Data_Clean/cgms/')
# ['Nessinger.12.9.2019_90days.xlsx']
for file in os.listdir(wd + "Data_Clean/cgms/"):
    # File extensioncontinueading in
    ext = pathlib.Path(wd + "Data_Raw/Patient 90 days/" + file).suffix
    if "xls" in ext:
        d = pd.read_excel(wd + "Data_Raw/Patient 90 days/" + file, engine="openpyxl")
    elif "csv" in ext:
        d = pd.read_csv(wd + "Data_Raw/Patient 90 days/" + file)
    # Identify type of CGM file
    if "Patient Info" in d.columns:
        # Pull A1c and dempgraphic data
        n = d["Patient Info"].iloc[0].lower() + "_" + d["Patient Info"].iloc[1].lower()
        mask = a1cs["ID"].isin([n])
        r = a1cs.loc[mask]
        # Get cgm data
        time = d["Timestamp (YYYY-MM-DDThh:mm:ss)"]
        time = [parse(t.replace("T", " ")) if type(t) == str else t for t in time]
        gluc = d["Glucose Value (mg/dL)"]
        cgm = pd.concat([pd.Series(time), gluc], axis=1)
        cgm.columns = ["time", "glucose"]
    else:
        print("Wrong columns")
        print(file)
        break
    # A1c date
    end = r["MostRecentVisitDate"].iloc[0]
    # Format data
    cgm.dropna(axis=0, subset=["glucose"], inplace=True)
    cgm["tir_glucose"] = pd.to_numeric(
        cgm["glucose"].replace("Low", 40).replace("High", 400)
    )
    cgm.set_index("time", inplace=True, drop=False)
    for delta in [14, 30, 60, 90]:
        # Get CGM data within time delta from HbA1c
        start = end - datetime.timedelta(days=delta)
        c = cgm[(cgm["time"] >= start) & (cgm["time"] < end)]
        # Calculate CGM metrics
        day = c.between_time("6:00", "23:00", inclusive = "neither")
        night = c.between_time("23:00", "6:00")
        # TIR
        day_r = day["glucose"].notna().sum()
        df[str(delta) + " Day TIR"].append(
            len([g for g in day["tir_glucose"] if g >= 70 and g < 180]) / day_r * 100
        )
        night_r = night["glucose"].notna().sum()
        df[str(delta) + " Night TIR"].append(
            len([g for g in night["tir_glucose"] if g >= 70 and g < 180])
            / night_r
            * 100
        )
        # Mean
        day = day[(day["glucose"] != "Low") & (day["glucose"] != "High")]
        night = night[(night["glucose"] != "Low") & (night["glucose"] != "High")]
        df[str(delta) + " Day Mean"].append(np.mean(day["glucose"].astype("int")))
        df[str(delta) + " Night Mean"].append(np.mean(night["glucose"].astype("int")))
    # Add dempgraphic information
    df["ID"].append(n)
    df["Gender"].append(r["Gender"].iloc[0])
    df["Age"].append(r["Age"].iloc[0])
    df["Insulin"].append(r["InsulinRegimen"].iloc[0])
    df["HbA1c"].append(r["MostRecentA1C"].iloc[0])
# Results as a dataframe
df = pd.DataFrame(data=df)
df.to_csv(wd + "Data_Clean/analysis_data.csv", index=False)
