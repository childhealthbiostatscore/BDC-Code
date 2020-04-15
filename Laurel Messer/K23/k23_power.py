import pandas as pd
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
# Drop missing
data_no_miss = data.dropna()
# Simplest
X = data_no_miss[['70-180']]
Y = data_no_miss[['HbA1c']]

data_no_miss.plot(x='70-180', y='HbA1c', style='o')  

# Add intercept to model
X = sm.add_constant(X)
# Regression
model = sm.OLS(Y, X).fit()
# Results
print(model.summary())
