# Install packages if necessary - function to check
# import pip
# def import_or_install(package):
#     try:
#         __import__(package)
#     except ImportError:
#         pip.main(['install', package]) 
# # Required packages
# import_or_install("pandas")
# Load packages
import pandas as pd
import datetime as dt
import os
import collections
import math

# List of files
path = "/Users/timvigers/Desktop/Pump Files Original/"
files = os.listdir(path)
files = [path + f for f in files]

# Read in data
data = pd.read_csv(files[1])
# Sort
data = data.sort_index()
# Make timestamp column, sort by it 
data["Timestamp"] = data["Date"] + " " + data["Time"]
all_times = [dt.datetime.strptime(str(t),"%m/%d/%Y %H:%M:%S") for t in data["Timestamp"]]
data["Timestamp"] = all_times
data = data.sort_values(by = "Timestamp")
# reset the index
data.reset_index(inplace=True)
# Weekday column
data["Weekday"] = [dt.datetime.weekday(t) for t in all_times]
# Total days of data
days = (max(all_times) - min(all_times)).days
# Get BG reading times and convert to datetime
bg_reading_times = data.loc[data["Sensor Calibration BG (mg/dL)"] > 0,"Timestamp"]
bg_reading_weekday = [dt.datetime.weekday(t) for t in bg_reading_times]
# Basic BG variables
total_readings = len(bg_reading_times)
readings_per_day = total_readings / days
readings_per_weekday = len([i for i in bg_reading_weekday if i <= 4]) / days
readings_per_weekend = len([i for i in bg_reading_weekday if i >= 5]) / days
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
    if math.isnan(bg):
    	continue
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
# Get carb times and convert to datetime
carb_times = data.loc[data["BWZ Carb Input (grams)"] > 0,"Timestamp"]
carb_weekday = [dt.datetime.weekday(t) for t in carb_times]
carb_dates = [dt.datetime.date(t) for t in carb_times]
# Carb variables
total_carbs = len(carb_times)
carbs_per_day = total_carbs / days
carbs_per_weekday = len([i for i in carb_weekday if i <= 4]) / days
carbs_per_weekend = len([i for i in carb_weekday if i >= 5]) / days
carb_date_counts = collections.Counter(carb_dates)
perc_days_3_more_carbs = len([i for i in carb_date_counts.values() if i >3]) / days
# Boluses
bolus_times = data.loc[data["Bolus Volume Delivered (U)"] > 0,"Timestamp"]
# Iterate through rows - bolus as anchor
for r in range(data.shape[0]):
	# Get bolus value and time
	bolus = data.loc[r,"Bolus Volume Delivered (U)"]
	# If NaN, next
	if math.isnan(bolus):
		continue
	bol_time = data.loc[r,"Timestamp"]
	# Check for additional boluses within 15 minutes
	bol_period_end = bol_time + dt.timedelta(minutes=15)
	
	
