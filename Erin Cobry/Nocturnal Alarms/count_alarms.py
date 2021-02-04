import os
import math
import pandas as pd
wd = "C:/Users/Tim Vigers/Dropbox/Work/Erin Cobry/Nocturnal Alarms/"
# Dictionary for results
dict={'File': [], 'Total Alarms': [], 'Threshold Alarms': [], 'Maintenance Alarms': [], \
    'HCL Alarms': [], 'Pump Alarms': [], 'Other Alarms': []}
# Columns to read in
fields = ['Patient ID','Unnamed: 16']
# Iterate through files in wd
for file in os.listdir(wd+"Data_Raw/CSVs/"):
    df = pd.read_csv(wd+"Data_Raw/CSVs/"+file,usecols=fields,dtype={'Patient ID':'str','Unnamed: 16':'str'})
    df.columns = df.loc[5,]
    df = df.drop(list(range(0,6)),axis = 0)
    # Pull all alarms between 10p-6a 
    df['Time'] = pd.to_datetime(df['Time'],format="%H:%M:%S",errors="coerce")
    df = df.set_index('Time')
    all_alarms = df['Alarm'].between_time("22:00:00","6:00:00").dropna().str.lower()
    # Alarm types (per Cari)
    # Threshold
    threshold = [alarm for alarm in all_alarms if 'alert' in alarm]
    # Maintenance
    matches = ["sensor","cal","signal","transmtr"]
    maintenance = [alarm for alarm in all_alarms if any(x in alarm for x in matches)]
    # HCL specific
    hcl = [alarm for alarm in all_alarms if 'auto' in alarm]
    # Pump maintenance
    matches = ["pump","battery","reservoir"]
    pump = [alarm for alarm in all_alarms if any(x in alarm for x in matches)]
    # Other
    other = [alarm for alarm in all_alarms if 'other' in alarm]
    # Return
    dict['File'].append(file.replace(".csv","")) 
    dict['Total Alarms'].append(len(all_alarms)) 
    dict['Threshold Alarms'].append(len(threshold)) 
    dict['Maintenance Alarms'].append(len(maintenance)) 
    dict['HCL Alarms'].append(len(hcl)) 
    dict['Pump Alarms'].append(len(pump)) 
    dict['Other Alarms'].append(len(other))
# Results as a dataframe
df=pd.DataFrame(data=dict)
df.to_csv(wd+"Data_Clean/alarms.csv",index=False)