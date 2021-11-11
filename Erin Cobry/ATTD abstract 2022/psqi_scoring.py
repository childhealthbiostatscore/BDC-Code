import pandas as pd
import numpy as np
import parsedatetime
from datetime import datetime
# Import and get PSQI columns
wd = "Z:/PEDS/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Erin Cobry/Prospective HCL and sleep study/Data raw/"
df = pd.read_csv(wd + "AdvancedHybridClosed-ATTDAbstracts2022_DATA_2021-11-08_2000.csv")
psqi = df.loc[:,"psqi_1":"psqi_complete"]
# Date parser
cal = parsedatetime.Calendar()
# Iterate through rows and calculate scores
for i, r in df.iterrows():
    # PSQIHSE
    q1 = r["psqi_1"]
    q3 = r["psqi_3"]
    if type(q1) != str or type(q3) != str:
        psqihse = ""
    else:
        if "a" not in q3:
            q3 = q3 + "am"
        if "p" not in q1:
            q1 = q1 + "pm"
        q1_time, q1_parse = cal.parse(q1)
        q1_time = datetime(*q1_time[:6])
        q3_time, q3_parse = cal.parse(q3)
        q3_time = datetime(*q3_time[:6])
        delta = q3_time - q1_time
        psqihse = round(delta.seconds / 3600,2)
    print(psqihse)