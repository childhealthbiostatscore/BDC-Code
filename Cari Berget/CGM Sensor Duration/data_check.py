import pandas as pd
import os
import math
import datetime
import dateutil
# Serial numbers from Cari
sns = pd.read_excel("/Users/timvigers/Documents/OneDrive - The University of Colorado Denver/Control IQ/DCLP pump SN.xlsx")
# SNs only
sns = sns['pump 1 SN '].tolist() + \
    sns['pump 2 SN '].tolist() + \
    sns['pump 3 SN'].tolist()
sns = [x for x in sns if str(x) != 'nan']
# Get list of pump files
control_dir = "/Users/timvigers/Documents/OneDrive - The University of Colorado Denver/Control IQ/Controls/"
control_files = os.listdir(control_dir)
iq_dir = "/Users/timvigers/Documents/OneDrive - The University of Colorado Denver/Control IQ/Control-IQ/"
iq_files = os.listdir(iq_dir)
# Loop through control files - if missing from Cari's file add to list
# If present in Cari's file, get dates
# Empty lists
garret_sns = []
missing_from_cari = []
from_cari = []
start = []
end = []
# Control files
for file in control_files:
	df = pd.read_csv(control_dir+file)
	sn = pd.Series(df.iloc[0,0])
	garret_sns.append(sn)
	dates = df['pump_date']
	dates = [dateutil.parser.parse(d) for d in dates]
	if not sn.isin(sns)[0]:
		missing_from_cari.append(float(sn))
	elif sn.isin(sns)[0]:
		from_cari.append(float(sn)) 
		start.append(min(dates))
		end.append(max(dates))
# IQ files
for file in iq_files:
	df = pd.read_csv(iq_dir+file)
	sn = pd.Series(df.iloc[0,0])
	garret_sns.append(sn)
	dates = df['pump_date']
	dates = [dateutil.parser.parse(d) for d in dates]
	if not sn.isin(sns)[0]:
		missing_from_cari.append(float(sn))
	elif sn.isin(sns)[0]:
		from_cari.append(float(sn)) 
		start.append(min(dates))
		end.append(max(dates))
# Find which of Cari's SNs are missing from Garret
missing_from_garret = []
for s in sns:
  sn = pd.Series(s)
  if not sn.isin(garret_sns)[0]:
    missing_from_garret.append(s)
# For the files from Garrett that are in Cari's document, 
print(len(from_cari))
print(len(start))
# Write CSV
temp = pd.DataFrame(missing_from_garret,
                    columns =['Missing from Garrett'])
temp2 = pd.DataFrame(missing_from_cari,columns = ['Missing from Cari'])
df = pd.concat([temp,temp2],axis=1)
df.to_csv("/Users/timvigers/Desktop/python.csv",index=False)