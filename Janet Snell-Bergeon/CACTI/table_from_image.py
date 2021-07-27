import os
import re
import pickle
import pandas as pd
from ExtractTable import ExtractTable
# API for table extraction
api_key = 'bVZ9bFKRxoku6FFrcYVtWMTJVQ6jV2AK2CEvmSYH'
et_sess = ExtractTable(api_key)
# Get all files recursively
top_dir = "/Users/timvigers/Desktop/G4 Cleaned"
files_only = []
for path, subdirs, files in os.walk(top_dir):
    for name in files:
        if ".pdf" in name:
            files_only.append(str(os.path.join(path, name)))
# Dict for storing results
res = {'file_name':[],'summary':[],'hourly':[]}
# Extract tables - may need to manually rotate and deletes some pages
for file in files_only:
    # Extract data
    table_data = et_sess.process_file(filepath=file,output_format="df",pages="all")
    # Get summary table
    summary_stats = table_data[1].loc[0:6].copy()
    summary_stats.iloc[:,0] = ['Average Glucose','% Sensor Usage','Calibrations / day',
                               'Standard Deviation','High','Target','Low']
    summary_stats.iloc[:,1] = [re.findall('\d*\.?\d+',i) for i in summary_stats['1']]
    summary_stats.iloc[:,1] = [float(i[0]) if len(i) == 1 else float(i[0])/float(i[1])*100 for i in summary_stats.iloc[:,1]]
    # Get hourly stats
    hourly_am = table_data[3].copy()
    hourly_am.columns = hourly_am.iloc[0,:]
    hourly_am.drop(0,0,inplace=True)
    hourly_pm = table_data[4].copy()
    hourly_pm.columns = hourly_pm.iloc[0,:]
    hourly_pm.drop(0,0,inplace=True)
    # Merge
    hourly = pd.merge(hourly_am,hourly_pm,on=['Stat','Totals'])
    # Add to results
    res['file_name'].append()(re.sub('/Users/timvigers/Desktop/G4 Cleaned.*/','',file))
    res['summary'].append(summary_stats)
    res['hourly'].append(hourly)
# Save
filename = '/Users/timvigers/Desktop/g4_data'
outfile = open(filename,'wb')
pickle.dump(res,outfile)
outfile.close()
