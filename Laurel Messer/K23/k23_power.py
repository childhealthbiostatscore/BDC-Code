import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
from tableone import TableOne
# Read in CSV 
data = pd.read_csv("/Volumes/peds/RI Biostatistics Core/Shared/Shared Projects/Laura/BDC/Projects/Laurel Messer/K award/Data_Cleaned/CGM_clinic_data.csv")
# Summarize variables
columns = ['70-180', 'HbA1c']
t1 = TableOne(data, columns, decimals=2)
print(t1)
# Linear models
# Drop missing rows
data_no_miss = data[data['HbA1c'].notna() & data['70-180'].notna()]
# Add gender dummy variable and intercept (HbA1c ~ b0 + b1(70-180) + b2(gender) + e)
X = data_no_miss[['70-180']]
dummy = pd.get_dummies(data_no_miss[['Patient gender']],drop_first=True)
X = X.join(dummy)
X = sm.add_constant(X)

Y = np.array(data_no_miss[['HbA1c']])

data_no_miss.plot(x='70-180', y='HbA1c', style='o')  

# Regression
model = sm.OLS(Y, X).fit()
# Results
print(model.summary())
