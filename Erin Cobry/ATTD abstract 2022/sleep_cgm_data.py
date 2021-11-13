import pandas as pd
from os import listdir
from parsedatetime import parsedatetime
from datetime import datetime
from statistics import mode
from collections import defaultdict,Counter
# Working directory and date parser
wd = "Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/Prospective HCL and sleep study"
cal = parsedatetime.Calendar()
# CGM metric function
def cgm_metrics(cleaned_cgm):
    # Store results
    results = {"id":[],"total_sensor_readings":[],"percent_cgm_wear":[],"mean_sensor":[],"sensor_sd":[],
               "percent_time_under_54":[],"minutes_under_54":[],"num_values_under_54":[],
               "percent_time_55_69":[],"minutes_55_69":[],"num_values_55_69":[],
               "percent_time_70_180":[],"minutes_70_180":[],"num_values_70_180":[],
               "percent_time_181_250":[],"minutes_181_250":[],"num_values_181_250":[],
               "percent_time_over_250":[],"minutes_over_250":[],"num_values_over_250":[]}
    # Variables
    c = Counter(cleaned_cgm["id"])
    results["id"].append(c.most_common(1)[0][0])
    # CGM wear metrics
    total_r = cleaned_cgm["glucose"].notna().sum()
    results["total_sensor_readings"].append(total_r)
    results["percent_cgm_wear"].append(round(total_r / cleaned_cgm.shape[0] * 100,2))
    # Mean and SD
    results["mean_sensor"].append(round(clean["glucose"].mean(skipna = True),2))
    results["sensor_sd"].append(round(clean["glucose"].std(skipna = True),2))
    # Hypoglycemia
    # Under 54
    hypo_54 = [g for g in cleaned_cgm["glucose"] if g <= 54]
    results["percent_time_under_54"].append(round(len(hypo_54) / total_r * 100,2))
    results["minutes_under_54"].append(len(hypo_54) * (s / 60))
    results["num_values_under_54"].append(len(hypo_54))
    # >= 55 and < 70
    hypo_55_69 = [g for g in cleaned_cgm["glucose"] if g >= 55 and g < 70]
    results["percent_time_55_69"].append(round(len(hypo_55_69) / total_r * 100,2))
    results["minutes_55_69"].append(len(hypo_55_69) * (s / 60))
    results["num_values_55_69"].append(len(hypo_55_69))
    # TIR 
    tir = [g for g in cleaned_cgm["glucose"] if g >= 70 and g <= 180]
    results["percent_time_70_180"].append(round(len(tir) / total_r * 100,2))
    results["minutes_70_180"].append(len(tir) * (s / 60))
    results["num_values_70_180"].append(len(tir))
     # 181 - 250
    hyper_181_250 = [g for g in cleaned_cgm["glucose"] if g > 180 and g <= 250]
    results["percent_time_181_250"].append(round(len(hyper_181_250) / total_r * 100,2))
    results["minutes_181_250"].append(len(hyper_181_250) * (s / 60))
    results["num_values_181_250"].append(len(hyper_181_250))
    # Over 150
    hyper_250 = [g for g in cleaned_cgm["glucose"] if g > 250]
    results["percent_time_over_250"].append(round(len(hyper_250) / total_r * 100,2))
    results["minutes_over_250"].append(len(hyper_250) * (s / 60))
    results["num_values_over_250"].append(len(hyper_250))
    # Return results
    return results
# Get file paths
files = listdir(wd + "./Data raw/CGM")
# Iterate through, clean, and calculate variables
all_results = []
night_results = []
evening_results = []
for f in files:
    # Read in
    path = wd + "/Data raw/CGM/" + f
    df = pd.read_csv(path)
    # Find columns
    time_col = [c for c in df.columns if "times" in c.lower()]
    gluc_col = [c for c in df.columns if "glucose value" in c.lower()]
    # Remove unnecessary columns
    clean = pd.concat([df[time_col],df[gluc_col]],axis = 1)
    clean.columns = ["time","glucose"]
    # Remove rows with missing time
    clean = clean[clean['time'].notnull()]
    # Glucose to numeric replace "high" and "low" with limits of detection
    clean["glucose"].replace("High",400,inplace = True)
    clean["glucose"].replace("Low",40,inplace = True)
    clean["glucose"] = [float(g) for g in clean["glucose"]]
    # Format time
    clean["time"] = clean["time"].str.replace('T',' ')
    clean["time"] = [cal.parse(t)[0] for t in clean["time"]]
    clean["time"] = [datetime(*t[:6]) for t in clean["time"]]
    # Add ID
    clean.reset_index(inplace = True)
    clean["id"] = f
    # Find sampling interval
    s = mode(clean["time"].diff()).total_seconds()
    # Re-index and expand to every 5 minutes
    clean.set_index("time",inplace = True)
    clean = clean[~clean.index.duplicated(keep='first')]
    clean = clean.resample(str(s / 60) + "T").ffill()
    # Filter into night and evening
    night = clean.between_time('00:00', '06:00')
    evening = clean.between_time('18:00','23:59')
    # Reset indices
    clean.reset_index(inplace = True)
    clean = clean[["id","time","glucose"]]
    night.reset_index(inplace = True)
    night = night[["id","time","glucose"]]
    evening.reset_index(inplace = True)
    evening = evening[["id","time","glucose"]]
    # Write
    clean.to_csv(wd + "/Data clean/CGM/" + f,index = False)
    # Get metrics
    all_results.append(cgm_metrics(clean))
    night_results.append(cgm_metrics(night))
    evening_results.append(cgm_metrics(evening))
# Write results
df = defaultdict(list)
for d in all_results: # you can list as many input dicts as you want here
    for key, value in d.items():
        df[key].append(value[0])
df = pd.DataFrame(data=df)
df.to_csv(wd+"/Data Clean/all_cgm.csv",index=False)
df = defaultdict(list)
for d in night_results: # you can list as many input dicts as you want here
    for key, value in d.items():
        df[key].append(value[0])
df = pd.DataFrame(data=df)
df.to_csv(wd+"/Data Clean/night_cgm.csv",index=False)
df = defaultdict(list)
for d in evening_results: # you can list as many input dicts as you want here
    for key, value in d.items():
        df[key].append(value[0])
df = pd.DataFrame(data=df)
df.to_csv(wd+"/Data Clean/evening_cgm.csv",index=False)