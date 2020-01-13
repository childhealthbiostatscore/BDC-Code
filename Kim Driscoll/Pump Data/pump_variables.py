# Install packages if necessary - function to check
import pip
def import_or_install(package):
    try:
        __import__(package)
    except ImportError:
        pip.main(['install', package]) 
# Required packages
import_or_install("pandas")
# Load packages
import pandas as pd
import os

# List of files
path = "/Users/timvigers/Desktop/Pump Files Original/"
files = os.listdir(path)
files = [path + f for f in files]

# Variable function 

# Read in data
data = pd.read_csv(files[1])
# Make Timestamp column, list of all times, weekday column
data["Timestamp"] = data["Date"] + " " + data["Time"]
all_times = [dt.datetime.strptime(str(t),"%m/%d/%Y %H:%M:%S") for t in data["Timestamp"]]
data["Weekday"] = [dt.datetime.weekday(t) for t in all_times]
# Total days of data
days = (max(all_times) - min(all_times)).days 

# Get BG reading times and convert to datetime
bg_reading_times = all_times.loc[data["Sensor Calibration BG (mg/dL)"] > 0,"Timestamp"]
bg_reading_times = [dt.datetime.strptime(str(t),"%m/%d/%Y %H:%M:%S") for t in bg_reading_times]
# BG variables
total_readings = len(bg_reading_times)
readings_per_day = total_readings / days
# BG counters
total_piu_70 = 0
total_piu_70_149 = 0
total_piu_150_249 = 0
total_piu_above_250 = 0
total_bwp_70 = 0
total_bwp_70_180 = 0
total_bwp_181_250 = 0
total_bwp_251_400 = 0
total_bwp_above_400 = 0
# Iterate through rows - BG as anchor
for r in range(data.shape[0]):
	# Count BG checks in various ranges
    bg = data.loc[r,"Sensor Calibration BG (mg/dL)"]
    if bg < 70:
        total_piu_70 += 1
        total_bwp_70 += 1
    if 70 <= bg <= 149:
        total_piu_70_149 += 1
    if 70 <= bg <= 180:
        total_bwp_70_180 += 1
    if 150 <= bg <= 249:
        total_piu_150_249 += 1
    if 181 <= bg <= 250:
        total_bwp_181_250 += 1
    if bg > 250:
        total_piu_above_250 += 1
        if bg <= 400:
            total_bwp_251_400 += 1
        elif bg > 400:
            total_bwp_above_400 += 1