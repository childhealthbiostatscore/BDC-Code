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
from dateutil.parser import parse
import pandas as pd
import datetime as dt
import os
import collections
import math
import csv
# List of files
path = "/Users/timvigers/Desktop/cleaned/"
files = os.listdir(path)
files = [path + f for f in files]
# Empty results dictionary
results = collections.OrderedDict()
# Output
output = pd.DataFrame()
# Iterate through files
for f in files:
	if ".DS_Store" in f:
		continue
	# Get ID
	subject_id = os.path.basename(str(f))
	subject_id = subject_id.replace("_cleaned.csv","")
	results["Subject ID"] = subject_id
	# Read in data
	data = pd.read_csv(f)
	# Make timestamp column, sort by it 
	data["Timestamp"] = data["Date"] + " " + data["Time"]
	all_times = [parse(str(t)) for t in data["Timestamp"]]
	data["Timestamp"] = all_times
	data = data.sort_values(by = "Timestamp")
	# reset the index
	data.reset_index(inplace=True)
	# Weekday column
	data["Weekday"] = [dt.datetime.weekday(t) for t in all_times]
	# Total days of data
	days = (max(all_times) - min(all_times)).days + 1
	results["Total Days"] = days
	# Count weekdays and weekends
	weekdays = data.loc[data["Weekday"] <= 4,"Date"]
	weekdays = len(set(weekdays))
	weekends = data.loc[data["Weekday"] >= 5,"Date"]
	weekends = len(set(weekends))
	# Get BG reading times and convert to datetime
	bg_reading_times = data.loc[data["Sensor Calibration BG (mg/dL)"] > 0,"Timestamp"]
	bg_reading_weekday = [dt.datetime.weekday(t) for t in bg_reading_times]
	bg_reading_dates = [dt.datetime.date(t) for t in bg_reading_times]
	# Basic BG variables
	bgs = data.loc[data["Sensor Calibration BG (mg/dL)"] > 0,"Sensor Calibration BG (mg/dL)"]
	total_readings = len(bg_reading_times)
	results["Total Readings"] = total_readings
	readings_per_day = total_readings / days
	results["Readings per Day"] = readings_per_day
	if weekdays != 0:
		readings_per_weekday = len([i for i in bg_reading_weekday if i <= 4]) / weekdays
	elif weekdays == 0:
		readings_per_weekday = float('NaN')
	results["Readings per Weekday"] = readings_per_weekday
	if weekends != 0:
		readings_per_weekend = len([i for i in bg_reading_weekday if i >= 5]) / weekends
	elif weekends == 0:
		readings_per_weekend = float('NaN')
	results["Readings per Weekend Day"] = readings_per_weekend
	readings_date_counts = collections.Counter(bg_reading_dates)
	perc_days_4_more_readings = len([i for i in readings_date_counts.values() if i > 4]) / days
	results["Perc. of Days with >= 4 Readings"] = perc_days_4_more_readings
	# Days with readings >= 6 hours apart
	bg_times_reindex = bg_reading_times.reset_index(drop = True)
	days_reading_6_hours = 0
	for i in range(1,len(bg_times_reindex)):
		if dt.datetime.date(bg_times_reindex[i]) != dt.datetime.date(bg_times_reindex[i-1]):
			continue
		tdiff = bg_times_reindex[i] - bg_times_reindex[i-1]
		if tdiff.seconds > (60*60*6):
			days_reading_6_hours += 1
	results["Days with >= 6 Hours Between Readings"] = days_reading_6_hours
	# Bolus times
	bolus_times = data.loc[data["Bolus Volume Delivered (U)"] > 0,"Timestamp"]
	# Get carb times and convert to datetime
	carb_times = data.loc[data["BWZ Carb Input (grams)"] > 0,"Timestamp"]
	carb_weekday = [dt.datetime.weekday(t) for t in carb_times]
	carb_dates = [dt.datetime.date(t) for t in carb_times]
	# Carb variables
	total_carbs = len(carb_times)
	results["Total Carb Inputs"] = total_carbs
	carbs_per_day = total_carbs / days
	results["Carb Inputs per Day"] = carbs_per_day
	if weekdays != 0:
		carbs_per_weekday = len([i for i in carb_weekday if i <= 4]) / weekdays
	elif weekdays == 0:
		carbs_per_weekday = float('NaN')
	results["Carb Inputs per Weekday"] = carbs_per_weekday
	if weekends != 0:
		carbs_per_weekend = len([i for i in carb_weekday if i >= 5]) / weekends
	elif weekends == 0:
		carbs_per_weekend = float('NaN')
	results["Carb Inputs per Weekend Day"] = carbs_per_weekend
	carb_date_counts = collections.Counter(carb_dates)
	perc_days_3_more_carbs = len([i for i in carb_date_counts.values() if i > 3]) / days
	results["Perc. Days With >= 3 Carb Inputs"] = perc_days_3_more_carbs
	# BG counters
	# Totals in range
	total_70 = 0
	total_70_149 = 0
	total_150_249 = 0
	total_above_250 = 0
	total_70_180 = 0
	total_181_250 = 0
	total_251_400 = 0
	total_above_400 = 0
	# Number in range followed by bolus alone or bolus and carb
	bg_70_followed_by_bolus = 0
	bg_70_149_followed_by_bolus = 0
	bg_70_180_followed_by_bolus = 0
	bg_150_249_followed_by_bolus = 0
	bg_181_250_followed_by_bolus = 0
	bg_above_250_followed_by_bolus = 0
	bg_251_400_followed_by_bolus = 0
	bg_above_400_followed_by_bolus = 0
	bg_70_followed_by_bolus_and_carb = 0
	bg_70_149_followed_by_bolus_and_carb = 0
	bg_70_180_followed_by_bolus_and_carb = 0
	bg_150_249_followed_by_bolus_and_carb = 0
	bg_181_250_followed_by_bolus_and_carb = 0
	bg_above_250_followed_by_bolus_and_carb = 0
	bg_251_400_followed_by_bolus_and_carb = 0
	bg_above_400_followed_by_bolus_and_carb = 0
	# Iterate through rows - BG as anchor
	for r in range(data.shape[0]):
		# Count BG checks in various ranges
	    bg = data.loc[r,"Sensor Calibration BG (mg/dL)"]
	    if math.isnan(bg):
	    	continue
	    bg_time = data.loc[r,"Timestamp"]
	    bg_period_forw = bg_time + dt.timedelta(minutes=15)
	    # Look for BG checks in the next 15 minutes
	    if len([i for i in bg_reading_times if ((i > bg_time) & (i <= bg_period_forw))]) > 0:
	        continue
	    if bg < 70:
	        total_70 += 1
	    if 70 <= bg <= 149:
	        total_70_149 += 1
	    if 70 <= bg <= 180:
	        total_70_180 += 1
	    if 150 <= bg <= 249:
	        total_150_249 += 1
	    if 181 <= bg <= 250:
	        total_181_250 += 1
	    if bg > 250:
	        total_above_250 += 1
	        if bg <= 400:
	            total_251_400 += 1
	        elif bg > 400:
	            total_above_400 += 1
	    # Check for boluses and carbs within 15 minutes
	    if len([i for i in bolus_times if ((i > bg_time) & (i <= bg_period_forw))]) > 0:
	        if bg < 70:
	            bg_70_followed_by_bolus += 1
	        if 70 <= bg <= 149:
	            bg_70_149_followed_by_bolus += 1
	        if 70 <= bg <= 180:
	            bg_70_180_followed_by_bolus += 1
	        if 150 <= bg <= 249:
	            bg_150_249_followed_by_bolus += 1
	        if 181 <= bg <= 250:
	            bg_181_250_followed_by_bolus += 1
	        if bg > 250:
	            bg_above_250_followed_by_bolus += 1
	            if bg <= 400:
	                bg_251_400_followed_by_bolus += 1
	            elif bg > 400:
	                bg_above_400_followed_by_bolus += 1
	        if len([i for i in carb_times if ((i > bg_time) & (i <= bg_period_forw))]) > 0:
	            if bg < 70:
	                bg_70_followed_by_bolus_and_carb += 1
	            if 70 <= bg <= 149:
	                bg_70_149_followed_by_bolus_and_carb += 1
	            if 70 <= bg <= 180:
	                bg_70_180_followed_by_bolus_and_carb += 1
	            if 150 <= bg <= 249:
	                bg_150_249_followed_by_bolus_and_carb += 1
	            if 181 <= bg <= 250:
	                bg_181_250_followed_by_bolus_and_carb += 1
	            if bg > 250:
	                bg_above_250_followed_by_bolus_and_carb += 1
	                if bg <= 400:
	                    bg_251_400_followed_by_bolus_and_carb += 1
	                elif bg > 400:
	                    bg_above_400_followed_by_bolus_and_carb += 1
	results.update({
		"Total BG Readings < 70":total_70,
		"Total BG Readings < 70 Followed by Bolus":bg_70_followed_by_bolus,
		"Total BG Readings < 70 Followed by Bolus and Carb":bg_70_followed_by_bolus_and_carb,
		"Total BG Readings 70 - 149":total_70_149,
		"Total BG Readings 70 - 149 Followed by Bolus":bg_70_149_followed_by_bolus,
		"Total BG Readings 70 - 149 Followed by Bolus and Carb":bg_70_149_followed_by_bolus_and_carb,
		"Total BG Readings 70 - 180":total_70_180,
		"Total BG Readings 70 - 180 Followed by Bolus":bg_70_180_followed_by_bolus,
		"Total BG Readings 70 - 180 Followed by Bolus and Carb":bg_70_180_followed_by_bolus_and_carb,
		"Total BG Readings 150 - 249":total_150_249,
		"Total BG Readings 150 - 249 Followed by Bolus":bg_150_249_followed_by_bolus,
		"Total BG Readings 150 - 249 Followed by Bolus and Carb":bg_150_249_followed_by_bolus_and_carb,
		"Total BG Readings 181 - 250":total_181_250,
		"Total BG Readings 181 - 250 Followed by Bolus":bg_181_250_followed_by_bolus,
		"Total BG Readings 181 - 250 Followed by Bolus and Carb":bg_181_250_followed_by_bolus_and_carb,
		"Total BG Readings 250+":total_above_250,
		"Total BG Readings 250+ Followed by Bolus":bg_above_250_followed_by_bolus,
		"Total BG Readings 250+ Followed by Bolus and Carb":bg_above_250_followed_by_bolus_and_carb,
		"Total BG Readings 251 - 400":total_251_400,
		"Total BG Readings 251 - 400 Followed by Bolus":bg_251_400_followed_by_bolus,
		"Total BG Readings 251 - 400 Followed by Bolus and Carb":bg_251_400_followed_by_bolus_and_carb,
		"Total BG Readings 400+":total_above_400,
		"Total BG Readings 400+ Followed by Bolus":bg_above_400_followed_by_bolus,
		"Total BG Readings 400+ Followed by Bolus and Carb":bg_above_400_followed_by_bolus_and_carb,
		})
	# Bolus counters
	total_bolus = 0
	double_bolus = 0
	weekday_bolus = 0
	weekend_bolus = 0
	bolus_within_15_70 = 0
	bolus_within_15_70_149 = 0
	bolus_within_15_70_180 = 0
	bolus_within_15_150_249 = 0
	bolus_within_15_181_250 = 0
	bolus_within_15_above_250 = 0
	bolus_within_15_251_400 = 0
	bolus_within_15_above_400 = 0
	bolus_within_30_70 = 0
	bolus_within_30_70_149 = 0
	bolus_within_30_70_180 = 0
	bolus_within_30_150_249 = 0
	bolus_within_30_181_250 = 0
	bolus_within_30_above_250 = 0
	bolus_within_30_251_400 = 0
	bolus_within_30_above_400 = 0
	bolus_within_5_70 = 0
	bolus_within_5_70_149 = 0
	bolus_within_5_70_180 = 0
	bolus_within_5_150_249 = 0
	bolus_within_5_181_250 = 0
	bolus_within_5_above_250 = 0
	bolus_within_5_251_400 = 0
	bolus_within_5_above_400 = 0
	# Lists of last BG prior to bolus and the time difference
	last_bg_times = list()
	last_bg = list()
	# Iterate through rows - bolus as anchor
	for r in range(data.shape[0]):
		# Get bolus value and time
		bolus = data.loc[r,"Bolus Volume Delivered (U)"]
		# If NaN or 0, next
		if math.isnan(bolus) or bolus == 0:
			continue
		bol_time = data.loc[r,"Timestamp"]
		# Check for additional boluses within 20 minutes, if so next row
		bol_period_forw = bol_time + dt.timedelta(minutes=20)
		if len([i for i in bolus_times if ((i > bol_time) & (i <= bol_period_forw))]) > 0:
			continue
		# See if there are boluses within 20 minutes before, get earliest 
		for b in range(r,0,-1):
			bol = data.loc[b,"Bolus Volume Delivered (U)"]
			if math.isnan(bol) or bol == 0:
				continue
			bol_start = data.loc[b,"Timestamp"]
			bol_period_back = bol_start - dt.timedelta(minutes=20)
			prev_boluses = [i for i in bolus_times if ((i >= bol_period_back) & (i < bol_start))]
			if len(prev_boluses) == 0:
				break
		if len([i for i in bolus_times if ((i >= bol_period_back) & (i < bol_time))]) > 0:
			double_bolus += 1
		total_bolus += 1
		if data.loc[r,"Weekday"] >= 5:
			weekend_bolus += 1
		elif data.loc[r,"Weekday"] < 5:
			weekday_bolus += 1
		# Find time from last BG and last BG value
		for b in range(r,0,-1):
			bg = data.loc[b,"Sensor Calibration BG (mg/dL)"]
			if math.isfinite(bg):
				bg_time = data.loc[b,"Timestamp"]
				time_diff = bol_start - bg_time
				last_bg_times.append(time_diff.seconds)
				last_bg.append(bg)
				break
	# Loop through last BG check times and classify based on BG level
	for t in range(len(last_bg_times)):
		if last_bg_times[t] <= (15 * 60):
			if last_bg[t] < 70:
				bolus_within_15_70 += 1
			if 70 <= last_bg[t] <= 149:
				bolus_within_15_70_149 += 1
			if 70 <= last_bg[t] <= 180:
				bolus_within_15_70_180 += 1
			if 150 <= last_bg[t] <= 249:
				bolus_within_15_150_249 += 1
			if 181 <= last_bg[t] <= 250:
				bolus_within_15_181_250 += 1
			if last_bg[t] > 250:
				bolus_within_15_above_250 += 1
				if last_bg[t] <= 400:
					bolus_within_15_251_400 += 1
				if last_bg[t] > 400:
					bolus_within_15_above_400 += 1
		# 30 minutes
		if last_bg_times[t] <= (30 * 60):
			if last_bg[t] < 70:
				bolus_within_30_70 += 1
			if 70 <= last_bg[t] <= 149:
				bolus_within_30_70_149 += 1
			if 70 <= last_bg[t] <= 180:
				bolus_within_30_70_180 += 1
			if 150 <= last_bg[t] <= 249:
				bolus_within_30_150_249 += 1
			if 181 <= last_bg[t] <= 250:
				bolus_within_30_181_250 += 1
			if last_bg[t] > 250:
				bolus_within_30_above_250 += 1
				if last_bg[t] <= 400:
					bolus_within_30_251_400 += 1
				if last_bg[t] > 400:
					bolus_within_30_above_400 += 1
		# 5 minutes
		if last_bg_times[t] <= (5 * 60):
			if last_bg[t] < 70:
				bolus_within_5_70 += 1
			if 70 <= last_bg[t] <= 149:
				bolus_within_5_70_149 += 1
			if 70 <= last_bg[t] <= 180:
				bolus_within_5_70_180 += 1
			if 150 <= last_bg[t] <= 249:
				bolus_within_5_150_249 += 1
			if 181 <= last_bg[t] <= 250:
				bolus_within_5_181_250 += 1
			if last_bg[t] > 250:
				bolus_within_5_above_250 += 1
				if last_bg[t] <= 400:
					bolus_within_5_251_400 += 1
				if last_bg[t] > 400:
					bolus_within_5_above_400 += 1
	if weekdays != 0:
		bolus_per_weekday = weekday_bolus / weekdays
	elif weekdays == 0:
		bolus_per_weekday = float('NaN')
	if weekends != 0:
		bolus_per_weekend = weekend_bolus / weekends
	elif weekends == 0:
		bolus_per_weekend = float('NaN')
	results.update({
		"Total Bolus Actions":total_bolus,
		"Total Double Boluses":double_bolus,
		"Total Weekday Boluses":weekday_bolus,
		"Total Weekend Boluses":weekend_bolus,
		"Boluses per Weekday":bolus_per_weekday,
		"Boluses per Weekend Day":bolus_per_weekend,
		"Boluses With BG < 70 15 Minutes Prior":bolus_within_15_70,
		"Boluses With BG 70 - 149 15 Minutes Prior":bolus_within_15_70_149,
		"Boluses With BG 70 - 180 15 Minutes Prior":bolus_within_15_70_180,
		"Boluses With BG 150 - 249 15 Minutes Prior":bolus_within_15_150_249,
		"Boluses With BG 181 - 250 15 Minutes Prior":bolus_within_15_181_250,
		"Boluses With BG 250+ 15 Minutes Prior":bolus_within_15_above_250,
		"Boluses With BG 251 - 400 15 Minutes Prior":bolus_within_15_251_400,
		"Boluses With BG 400+ 15 Minutes Prior":bolus_within_15_above_400,
		"Boluses With BG < 70 30 Minutes Prior":bolus_within_30_70,
		"Boluses With BG 70 - 149 30 Minutes Prior":bolus_within_30_70_149,
		"Boluses With BG 70 - 180 30 Minutes Prior":bolus_within_30_70_180,
		"Boluses With BG 150 - 249 30 Minutes Prior":bolus_within_30_150_249,
		"Boluses With BG 181 - 250 30 Minutes Prior":bolus_within_30_181_250,
		"Boluses With BG 250+ 30 Minutes Prior":bolus_within_30_above_250,
		"Boluses With BG 251 - 400 30 Minutes Prior":bolus_within_30_251_400,
		"Boluses With BG 400+ 30 Minutes Prior":bolus_within_30_above_400,
		"Boluses With BG < 70 5 Minutes Prior":bolus_within_5_70,
		"Boluses With BG 70 - 149 5 Minutes Prior":bolus_within_5_70_149,
		"Boluses With BG 70 - 180 5 Minutes Prior":bolus_within_5_70_180,
		"Boluses With BG 150 - 249 5 Minutes Prior":bolus_within_5_150_249,
		"Boluses With BG 181 - 250 5 Minutes Prior":bolus_within_5_181_250,
		"Boluses With BG 250+ 5 Minutes Prior":bolus_within_5_above_250,
		"Boluses With BG 251 - 400 5 Minutes Prior":bolus_within_5_251_400,
		"Boluses With BG 400+ 5 Minutes Prior":bolus_within_5_above_400,
		})
	# Rebound BGs
	rebound_bgs = 0
	over_300_times = data.loc[data["Sensor Calibration BG (mg/dL)"] >= 300,"Timestamp"]
	under_70_times = data.loc[data["Sensor Calibration BG (mg/dL)"] < 70,"Timestamp"]
	for r in range(0,len(data["Sensor Calibration BG (mg/dL)"])):
		if data.loc[r,"Sensor Calibration BG (mg/dL)"] >= 70:
			continue
		elif data.loc[r,"Sensor Calibration BG (mg/dL)"] < 70:
			time = data.loc[r,"Timestamp"]
			time_forw = time + dt.timedelta(hours = 24)
			for t in over_300_times:
				if t > time and t <= time_forw:
					rebound_bgs += 1
					continue
	results["Rebound BGs"] = rebound_bgs
	# Store all results
	output = output.append(results,ignore_index=True)
# Write
output.to_csv("/Users/timvigers/Desktop/results.csv",index = False)