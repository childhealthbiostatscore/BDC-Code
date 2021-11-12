import pandas as pd
import numpy as np
import parsedatetime
import re
from datetime import datetime
# Import and get PSQI columns
wd = "Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/Prospective HCL and sleep study/Data raw/"
df = pd.read_csv(wd + "AdvancedHybridClosed-ATTDAbstracts2022_DATA_2021-11-08_2000.csv")
psqi = df.loc[:,"psqi_1":"psqi_complete"]
# Date parser
cal = parsedatetime.Calendar()
# Dictionary for storing results
scores = {"psqihse":[],"psqidurat":[]}
# Iterate through rows and calculate scores
for i, r in df.iterrows():
    # PSQIDURAT
    q4 = r["psqi_4"]
    if type(q4) != str:
        psqidurat = ""
    elif "." in q4:
        psqidurat = float(q4)
    elif "or" in q4 or "to" in q4 or "-" in q4:
        ints = [float(n) for n in q4 if str.isdigit(n)]
        psqidurat = np.mean([n for n in ints])
    else:
        if len(q4.strip()) == 1:
            q4 = q4 + ":00"
        q4_time, q4_parse = cal.parse(q4)
        q4_time = datetime(*q4_time[:6])
        tod, par = cal.parse("midnight")
        tod = datetime(*tod[:6])
        delta = q4_time - tod
        if ":" not in q4:
            q4_time,now = cal.parse(q4)[0],cal.parse("now")[0]
            q4_time = datetime(*q4_time[:6])
            now = datetime(*now[:6])
            delta = q4_time - now
        psqidurat = round(delta.seconds / 3600,2)
    scores['psqidurat'].append(psqidurat)
    # PSQIHSE
    q1 = r["psqi_1"]
    q3 = r["psqi_3"]
    if type(q1) != str or type(q3) != str:
        psqihse = ""
    else:   
        q1 = q1.lower()
        q3 = q3.lower()
        if "or" in q3 or "to" in q3 or "-" in q3:
            q3 = re.search(r'\d+', q3).group()
        if ":" not in q3 and len(q3) <= 2:
            q3 = q3 + ":00am"
        elif ":" not in q3 and "a" not in q3:
            q3 = q3[:-2] + ":" + q3[-2:] + "am"
        if "a" not in q3:
            q3 = q3 + "am"
        if "midnight" in q1:
            q1 = "12"
        if "or" in q1 or "to" in q1 or "-" in q1:
            q1 = re.search(r'\d+', q1).group()
        if ":" not in q1 and len(q1) <= 2:
            q1 = q1 + ":00pm"
        elif ":" not in q1 and "p" not in q1:
            q1 = q1[:-2] + ":" + q1[-2:] + "pm"
        if "p" not in q1 and "12" not in q1:
            q1 = q1 + "pm"
        elif "12" in q1:
            q1 = "12:00am"
        q1_time, q1_parse = cal.parse(q1)
        q1_time = datetime(*q1_time[:6])
        q3_time, q3_parse = cal.parse(q3)
        q3_time = datetime(*q3_time[:6])
        delta = q3_time - q1_time
        psqihse = round(delta.seconds / 3600,2)
    scores['psqihse'].append(psqihse)