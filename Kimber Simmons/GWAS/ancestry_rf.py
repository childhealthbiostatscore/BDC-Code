import sklearn
import pandas as pd
# Import data
wd = "~/Dropbox/Work/GWAS/TGP/QC/"
sample_info = pd.read_csv(wd+"super_pop.csv")
pca = pd.read_csv(wd+"plink.eigenvec", sep=' ')
# Join
data = pca.set_index('IID').join(sample_info.set_index('IID'))
# Get outcome (Y) and data (X)
y = data[["SuperPop"]]
x = data[["PC" + s for s in ["1","2","3","4","5","6"]]]
# Set up a classifier with 100 bootstrap samples
clf = sklearn.ensemble.RandomForestClassifier(bootstrap=True,max_samples=100)
# Fit
model = clf.fit(X = x,y = y.values.ravel())
# Test the model
X_train, X_test, y_train, y_test = sklearn.model_selection.train_test_split(x, y, test_size=0.70)
model = clf.fit(X_train,y_train.values.ravel())
y_pred=clf.predict(X_test)
print("Accuracy:",sklearn.metrics.accuracy_score(y_test, y_pred))