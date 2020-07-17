import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import math
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
import os
os.chdir("/Users/timvigers/Lipidomics")
# Read in CSVs
lipids = pd.read_csv("Data_Cleaned/combined_highlighted_cells_deleted.csv")
data = pd.read_csv("Data_Cleaned/all_clinical_data.csv")
# Merge
df = pd.merge(lipids,data,how="left",on="StudyID")
# Convert "dia" to string
df['dia'] = df['dia'].map({1:'case',0:'control'})
# Outcome
outcome = df["dia"]
# Descriptives
print(df.describe())
# Triglycerides PCA
# Filter DF
triglycerides = df.filter(like='TG', axis=1)
features = triglycerides.columns
# Remove rows with missing
triglycerides = triglycerides.dropna()
# Scale columns
x = StandardScaler().fit_transform(triglycerides)
# PCA
pca = PCA(n_components=2)
pc = pca.fit_transform(x)
pcDf = pd.DataFrame(data = pc,
                    columns = ['principal component 1', 'principal component 2'])
# Add outcome
finalpcDf = pd.concat([pcDf, df["dia"]], axis = 1, join="inner")
# Plot
sns.scatterplot(x="principal component 1", y="principal component 2", hue="dia",data=finalpcDf)
