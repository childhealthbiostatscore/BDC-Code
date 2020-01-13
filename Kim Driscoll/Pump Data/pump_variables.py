# Install packages if necessary - function to check
import pip
def import_or_install(package):
    try:
        __import__(package)
    except ImportError:
        pip.main(['install', package]) 
# Required packages
import_or_install("pandas")
# Load packages
import pandas as pd
import os

# List of files
path = "/Users/timvigers/Desktop/Pump Files Original/"
files = os.listdir(path)
files = [path + f for f in files]

# variable function 
data = pd.read_csv(files[1])
print(data)