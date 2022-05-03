import os
import pathlib
import pandas as pd
import numpy as np
import datetime
from glob import glob
from dateutil.parser import parse
# Import data
wd = "/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/K23/"
# Most recent HbA1c information
a1cs = pd.read_csv(wd + "Data_Clean/a1cs.csv",
                   parse_dates=["MostRecentVisitDate"])
# Iterate through CGM files, match with row in a1cs df, calculate metrics
# Dictionary for storing results
df = {
    "ID": [],
    "Gender": [],
    "Age": [],
    "Insulin": [],
    "HbA1c": [],
    "14 Overall Mean": [],
    "14 Overall TIR 70 - 140": [],
    "14 Overall TIR 70 - 180": [],
    "14 Overall TIR Over 180": [],
    "14 Day Mean": [],
    "14 Day TIR 70 - 140": [],
    "14 Day TIR 70 - 180": [],
    "14 Day TIR Over 180": [],
    "14 Night Mean": [],
    "14 Night TIR 70 - 140": [],
    "14 Night TIR 70 - 180": [],
    "14 Night TIR Over 180": [],
    "30 Overall Mean": [],
    "30 Overall TIR 70 - 140": [],
    "30 Overall TIR 70 - 180": [],
    "30 Overall TIR Over 180": [],
    "30 Day Mean": [],
    "30 Day TIR 70 - 140": [],
    "30 Day TIR 70 - 180": [],
    "30 Day TIR Over 180": [],
    "30 Night Mean": [],
    "30 Night TIR 70 - 140": [],
    "30 Night TIR 70 - 180": [],
    "30 Night TIR Over 180": [],
    "60 Overall Mean": [],
    "60 Overall TIR 70 - 140": [],
    "60 Overall TIR 70 - 180": [],
    "60 Overall TIR Over 180": [],
    "60 Day Mean": [],
    "60 Day TIR 70 - 140": [],
    "60 Day TIR 70 - 180": [],
    "60 Day TIR Over 180": [],
    "60 Night Mean": [],
    "60 Night TIR 70 - 140": [],
    "60 Night TIR 70 - 180": [],
    "60 Night TIR Over 180": [],
    "90 Overall Mean": [],
    "90 Overall TIR 70 - 140": [],
    "90 Overall TIR 70 - 180": [],
    "90 Overall TIR Over 180": [],
    "90 Day Mean": [],
    "90 Day TIR 70 - 140": [],
    "90 Day TIR 70 - 180": [],
    "90 Day TIR Over 180": [],
    "90 Night Mean": [],
    "90 Night TIR 70 - 140": [],
    "90 Night TIR 70 - 180": [],
    "90 Night TIR Over 180": [],
}
# Iterate through files in wd
files = os.listdir()
files = glob(wd + "5. Subject data/K-23/" + '/**/*.csv', recursive=True)
os.li
files.sort()
for file in files:
    # File extensioncontinueading in
    ext = pathlib.Path(wd + "Data_Clean/cgms/" + file).suffix
    if "xls" in ext:
        d = pd.read_excel(wd + "Data_Clean/cgms/" +
                          file, engine="openpyxl")
    elif "csv" in ext:
        d = pd.read_csv(wd + "Data_Clean/cgms/" + file)
    # Identify type of CGM file
    if "Patient Info" in d.columns:
        # Pull A1c and dempgraphic data
        n = d["Patient Info"].iloc[0].lower() + "_" + \
            d["Patient Info"].iloc[1].lower()
        mask = a1cs["ID"].isin([n])
        r = a1cs.loc[mask]
        # Get cgm data
        time = d["Timestamp (YYYY-MM-DDThh:mm:ss)"]
        time = [parse(t.replace("T", " ")) if type(t)
                == str else t for t in time]
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
    cgm["mean_glucose"] = pd.to_numeric(
        cgm["glucose"].replace("Low", np.nan).replace("High", np.nan)
    )
    cgm.set_index("time", inplace=True, drop=False)
    for delta in [14, 30, 60, 90]:
        # Get CGM data within time delta from HbA1c
        start = end - datetime.timedelta(days=delta)
        c = cgm[(cgm["time"] >= start) & (cgm["time"] < end)]
        # Calculate CGM metrics
        df[str(delta) + " Overall Mean"].append(np.nanmean(cgm["mean_glucose"]))
        all_r = cgm["glucose"].notna().sum()
        df[str(delta) + " Overall TIR 70 - 140"].append(
            len([g for g in cgm["tir_glucose"] if g >=
                70 and g <= 140]) / all_r * 100
        )
        df[str(delta) + " Overall TIR 70 - 180"].append(
            len([g for g in cgm["tir_glucose"] if g >=
                70 and g <= 180]) / all_r * 100
        )
        df[str(delta) + " Overall TIR Over 180"].append(
            len([g for g in cgm["tir_glucose"] if g > 180]) / all_r * 100
        )
        # By day and night
        day = c.between_time(
            "6:00", "23:00", inclusive = "neither")
        night = c.between_time("23:00", "6:00")
        # TIR
        # Day
        day_r = day["glucose"].notna().sum()
        df[str(delta) + " Day TIR 70 - 140"].append(
            len([g for g in day["tir_glucose"] if g >=
                70 and g <= 140]) / day_r * 100
        )
        df[str(delta) + " Day TIR 70 - 180"].append(
            len([g for g in day["tir_glucose"] if g >=
                70 and g <= 180]) / day_r * 100
        )
        df[str(delta) + " Day TIR Over 180"].append(
            len([g for g in day["tir_glucose"] if g > 180]) / day_r * 100
        )
        # Night
        night_r = night["glucose"].notna().sum()
        df[str(delta) + " Night TIR 70 - 140"].append(
            len([g for g in night["tir_glucose"] if g >=
                70 and g <= 140]) / night_r * 100
        )
        df[str(delta) + " Night TIR 70 - 180"].append(
            len([g for g in night["tir_glucose"] if g >=
                70 and g <= 180]) / night_r * 100
        )
        df[str(delta) + " Night TIR Over 180"].append(
            len([g for g in night["tir_glucose"] if g > 180]) / night_r * 100
        )
        # Mean
        day = day[(day["glucose"] != "Low") & (day["glucose"] != "High")]
        night = night[(night["glucose"] != "Low") &
                      (night["glucose"] != "High")]
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
df.to_csv("/Volumes/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Viral Shah/GMI and A1c/Data_Clean/kaan_mean_glucose.csv", index=False)
