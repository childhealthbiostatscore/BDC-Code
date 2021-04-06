import scipy
import sklearn
import pandas as pd
import numpy as np
# Import data
wd = "~/Dropbox/Work/GWAS/TGP/"
sample_info = pd.read_csv(wd+"all_phase3.csv")
pca = pd.read_csv(wd+"QC/ref_pcs.eigenvec", sep='\t')
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
pcs = [n + "_AVG" for n in pcs]
# Import PCA from Kimber
redo_PCA = pd.read_csv(wd+"redo.sscore", sep='\t')
biobank1_PCA = pd.read_csv(wd+"biobank1.sscore", sep='\t')
biobank2_PCA = pd.read_csv(wd+"biobank2.sscore", sep='\t')
# Predict ancestry group
redo_pop = pd.DataFrame(clf.predict(redo_PCA[pcs]))
redo_pop = pd.concat([redo_PCA[["#FID","IID"]],redo_pop],axis=1)
biobank1_pop = pd.DataFrame(clf.predict(biobank1_PCA[pcs]))
biobank1_pop = pd.concat([biobank1_PCA[["#FID","IID"]],biobank1_pop],axis=1)
biobank2_pop = pd.DataFrame(clf.predict(biobank2_PCA[pcs]))
biobank2_pop = pd.concat([biobank2_PCA[["#FID","IID"]],biobank2_pop],axis=1)
# Write 
redo_pop.to_csv(wd+'redo_pop.csv',index=False,header=["FID","IID","SuperPop"])
biobank1_pop.to_csv(wd+'biobank1_pop.csv',index=False,header=["FID","IID","SuperPop"])
biobank2_pop.to_csv(wd+'biobank2_pop.csv',index=False,header=["FID","IID","SuperPop"])