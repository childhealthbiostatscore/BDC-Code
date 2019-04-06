import pandas as pandas
import statsmodels as sm
import statsmodels.formula.api as smf
data = pandas.read_csv("~/Desktop/clean_glycemic_data.csv")

md = smf.mixedlm("hba1c ~ tpoint", data, groups=data["record_id"],missing="drop")

mdf = md.fit()
print(mdf.summary())