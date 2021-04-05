import scipy
import sklearn
import pandas as pd
import numpy as np
# Import data
wd = "~/Dropbox/Work/GWAS/TGP/QC/"
sample_info = pd.read_csv(wd+"super_pop.csv")
pca = pd.read_csv(wd+"plink.eigenvec", sep=' ')
# Join
data = pca.set_index('IID').join(sample_info.set_index('IID'))
# Get outcome (Y) and data (X) - first 6 PCs
pcs = ["PC"+str(n) for n in range(1, 6+1)]
y = data[["SuperPop"]]
x = data[pcs]
from sklearn.ensemble import RandomForestClassifier
# Set up a classifier with 100 bootstrap samples
clf = RandomForestClassifier(bootstrap=True,max_samples=100)
# Fit
model = clf.fit(X = x,y = y.values.ravel())
from sklearn.model_selection import train_test_split
# Test the model
X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.75,random_state=1017)
model = clf.fit(X_train,y_train.values.ravel())
y_pred=clf.predict(X_test)
print("Accuracy of RF model based on a 75/25 training/test split of 1k Genomes data:",\
    sklearn.metrics.accuracy_score(y_test, y_pred).round(3))
# Apply to Kimber's data
wd = "~/Dropbox/Work/Kimber Simmons/GWAS/Data_Cleaned/harmonized_analysis/"
# Import PCA from Kimber
redo_PCA = pd.read_csv(wd+"redo.eigenvec", sep=' ').set_index('IID')
redo_PCA = redo_PCA[pcs]
biobank1_PCA = pd.read_csv(wd+"biobank1.eigenvec", sep=' ')
biobank1_PCA = biobank1_PCA[pcs]
biobank2_PCA = pd.read_csv(wd+"biobank2.eigenvec", sep=' ')
biobank2_PCA = biobank2_PCA[pcs]
# Predict ancestry group
redo_pop = clf.predict(redo_PCA)
biobank1_pop = clf.predict(biobank1_PCA)
biobank2_pop = clf.predict(biobank2_PCA)
# Write 
pd.DataFrame(redo_pop).to_csv(wd+'redo_pop.csv',index=False,header=['SuperPop'])
pd.DataFrame(biobank1_pop).to_csv(wd+'biobank1_pop.csv',index=False,header=['SuperPop'])
pd.DataFrame(biobank2_pop).to_csv(wd+'biobank2_pop.csv',index=False,header=['SuperPop'])