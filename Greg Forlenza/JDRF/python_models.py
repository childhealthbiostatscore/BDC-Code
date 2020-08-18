#-------------------------------------------------------------------------------
#
# This file contains example code for calculating probability based on a
# logistic regression.
#
# Tim Vigers
# Last updated August 18, 2020
#
#-------------------------------------------------------------------------------
import math
# We created 4 different models, to give people the option enter what kind of
# data they collected. Users can choose to enter either time in automode
# (time_am) or sensor wear (sensor_wear) at either 1 month (m1) or 3 months (m3)
# of HCL use.

# Define a function for calculating probability.
def get_prob(intercept,hba1c_coeff,time_am_coeff,tir_coeff,age14_18_coeff,age18_plus_coeff,sex_coeff):
    estimate = intercept + (hba1c_coeff*(hba1c - hba1c_center)) + (time_am_coeff*(m3_time_am - m3_time_am_center)) + (tir_coeff*(m3_tir - m3_tir_center)) + (age14_18_coeff*age14_18) + (age18_plus_coeff*age18_plus) + (sex_coeff*sex)
    prob = math.exp(estimate)/(1+math.exp(estimate))
    print(prob)

# The models used centered data, so we need to subtract the mean from each
# input.
hba1c_center = 8.787778

m1_time_am_center = 66.06667
m1_sensor_wear = 76.28
m1_tir_center = 60.14667

m3_time_am_center = 51.6087
m3_sensor_wear = 64.27536
m3_tir_center = 59.28571

# Values that are in all 4 models
hba1c = "user_input: float"
age6_13 = "user_input: 1 if TRUE or 0 if FALSE"
age14_18 = "user_input: 1 if TRUE or 0 if FALSE"
age18_plus = "user_input: 1 if TRUE or 0 if FALSE"
sex = "user_input: 1 if M or 0 if F"

# M1 models
# time_am

# M3 models
# time_am
m3_time_am = 63
m3_tir = 53

hba1c = 8.5
age6_13 = 1
age14_18 = 0
age18_plus = 0
sex = 0


get_prob(-2.4260285,-1.1275911,0.0544609,-0.0077418,-0.9361760,-0.5360715,1.4472430)
