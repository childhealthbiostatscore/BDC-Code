import os
import re
import pickle
import pandas as pd
from ExtractTable import ExtractTable
# API for table extraction
api_key = 'Kr5kmFv60TbpnFKfFWE3UNxnuWFq8o2Mu868Nlau'
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
    print(file)
    # Extract data
    table_data = et_sess.process_file(filepath=file,output_format="df",pages="all")
    # Get summary table
    summary_stats = [t for t in table_data if t.shape == (9, 2)]
    summary_stats = summary_stats[0]
    summary_stats = summary_stats.iloc[0:7,:].copy()
    summary_stats.iloc[:,0] = ['Average Glucose','% Sensor Usage','Calibrations / day','Standard Deviation','High','Target','Low']
    summary_stats.iloc[:,1] = [re.findall('\d*\.?\d+',i) for i in summary_stats['1']]
    summary_stats.iloc[:,1] = [float(i[0]) if len(i) == 1 else float(i[0])/float(i[1])*100 for i in summary_stats.iloc[:,1]]
    # Get hourly stats
    hourly = [t for t in table_data if t.shape == (13, 14)]
    hourly_am = hourly[0].copy()
    hourly_am.columns = hourly_am.iloc[0,:]
    hourly_am.drop(0,0,inplace=True)
    hourly_pm = hourly[1].copy()
    hourly_pm.columns = hourly_pm.iloc[0,:]
    hourly_pm.drop(0,0,inplace=True)
    # Merge
    hourly = pd.merge(hourly_am,hourly_pm,on=['Stat','Totals'])
    # Add to results
    res['file_name'].append(re.sub('/Users/timvigers/Desktop/G4 Cleaned.*/','',file))
    res['summary'].append(summary_stats)
    res['hourly'].append(hourly)
# Save
filename = '/Users/timvigers/Desktop/g4_data'
outfile = open(filename,'wb')
pickle.dump(res,outfile)
outfile.close()
