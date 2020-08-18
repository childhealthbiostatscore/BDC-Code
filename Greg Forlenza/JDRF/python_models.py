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
import numpy
# We created 4 different models, to give people the option enter what kind of
# data they collected. Users can choose to enter either time in automode
# (time_am) or sensor wear (sensor_wear) at either 1 month (m1) or 3 months (m3)
# of HCL use.

# Define a function for calculating probability and CI
def get_prob(c,estimates,vcov):
    # Calculate probability
    logit = numpy.matmul(c,estimates)
    prob = math.exp(logit)/(1+math.exp(logit))
    # Calculate se
    se = math.sqrt(numpy.matmul(numpy.matmul(c,vcov),c))
    # Upper and lower limits
    ll = logit - 1.96*se
    ul = logit + 1.96*se
    prob_ll = math.exp(ll)/(1+math.exp(ll))
    prob_ul = math.exp(ul)/(1+math.exp(ul))
    # For now just print probability
    rounded = round(prob,3)
    print("Probability of success: "+str(rounded*100)+"%")

# The models used centered data, so we need to subtract the mean from each
# input.
hba1c_center = 8.787778

m1_time_am_center = 66.06667
m1_sensor_wear_center = 76.28
m1_tir_center = 60.14667

m3_time_am_center = 51.6087
m3_sensor_wear_center = 64.27536
m3_tir_center = 59.28571

# User values that are in all 4 models
hba1c = "user_input: float"
age6_13 = "user_input: 1 if TRUE or 0 if FALSE"
age14_18 = "user_input: 1 if TRUE or 0 if FALSE"
age18_plus = "user_input: 1 if TRUE or 0 if FALSE"
sex = "user_input: 1 if M or 0 if F"

# M1 models
# time_am
m1_time_am = "user_input: float"
m1_tir = "user_input: float"
# Inputs from user
c = [1,hba1c,m1_time_am,m1_tir,age14_18,age18_plus,sex]
# Model estimates and variance covariance matrix
estimates = [-2.60784627,-0.45462717,0.07159490,0.05767671,-1.01317769,0.21172931,1.55851854]
vcov = [[0.765153944,0.084745592,-0.017734542,-0.003408186,-0.153613931,-0.225159252,-0.436491263],\
[0.084745592,0.170659005,-0.000228788,0.004704214,0.061210945,0.178616043,-0.038268238],\
[-0.017734542,-0.000228788,0.001095046,-0.000327652,0.000723357,0.005878825,0.005841245],\
[-0.003408186,0.004704214,-0.000327652,0.001868201,-0.008096695,0.00072031,0.005336462],\
[-0.153613931,0.061210945,0.000723357,-0.008096695,0.570553547,0.290301601,-0.003214015],\
[-0.225159252,0.178616043,0.005878825,0.00072031,0.290301601,1.705865528,0.02864854],\
[-0.436491263,-0.038268238,0.005841245,0.005336462,-0.003214015,0.02864854,0.522746231]]
# Probability
get_prob(c,estimates,vcov)
# sensor_wear
# Inputs from user
c = [1,hba1c,m1_sensor_wear,m1_tir,age14_18,age18_plus,sex]
# Model estimates and variance covariance matrix
estimates = [-3.28378476,-0.46814817,0.13683827,0.08861053,-1.16189279,0.84836364,1.54567578]
vcov = [[1.10347701,0.109512897,-0.040021662,-0.015930244,-0.086561769,-0.544436044,-0.497416027],\
[0.109512897,0.200789597,-0.00157004,0.004490022,0.078930045,0.230446206,-0.026681187],\
[-0.040021662,-0.00157004,0.002609524,0.000473351,-0.004156809,0.024870735,0.009806841],\
[-0.015930244,0.004490022,0.000473351,0.00203532,-0.010705008,0.011415006,0.009420393],\
[-0.086561769,0.078930045,-0.004156809,-0.010705008,0.667486028,0.274626379,-0.020144305],\
[-0.544436044,0.230446206,0.024870735,0.011415006,0.274626379,2.174095926,0.145322254],\
[-0.497416027,-0.026681187,0.009806841,0.009420393,-0.020144305,0.145322254,0.566737841]]
# Probability
get_prob(c,estimates,vcov)

# M3 models
# time_am
m3_time_am = "user_input: float"
m3_tir = "user_input: float"
# Inputs from user
c = [1,hba1c,m3_time_am,m3_tir,age14_18,age18_plus,sex]
# Model estimates and variance covariance matrix
estimates = [-2.426028546,-1.127591137,0.054460858,-0.007741838,-0.936175956,-0.536071497,1.447243022]
vcov = [[0.741524163,0.228664559,-0.008626397,0.007736141,-0.154150279,-0.088315025,-0.461022925],\
[0.228664559,0.281199529,-0.003467854,0.01172579,0.053107578,0.140609042,-0.111935067],\
[-0.008626397,-0.003467854,0.000391449,-0.000276797,-0.00203014,-0.0035773,0.003600967],\
[0.007736141,0.01172579,-0.000276797,0.001634663,-0.005802614,-0.002450304,-0.003616159],\
[-0.154150279,0.053107578,-0.00203014,-0.005802614,0.665697878,0.34614685,-0.027563574],\
[-0.088315025,0.140609042,-0.0035773,-0.002450304,0.34614685,1.45884985,-0.04241192],\
[-0.461022925,-0.111935067,0.003600967,-0.003616159,-0.027563574,-0.04241192,0.584470313]]
# Probability
get_prob(c,estimates,vcov)
# sensor_wear
# Inputs from user
c = [1,hba1c,m3_sensor_wear,m3_tir,age14_18,age18_plus,sex]
# Model estimates and variance covariance matrix
estimates = [-2.124535244,-0.859008670,0.045902919,0.005965674,-0.585978313,-0.118947026,1.170080367]
vcov = [[0.665252055,0.161703494,-0.011576419,0.010804556,-0.252293385,-0.161645278,-0.343599436],\
[0.161703494,0.196057563,-0.001769877,0.007993871,-0.004085959,0.078118815,-0.065953043],\
[-0.011576419,-0.001769877,0.000698852,-0.00047687,0.003507293,0.000882958,0.001121935],\
[0.010804556,0.007993871,-0.00047687,0.001496196,-0.009219832,-0.006935007,-0.002067647],\
[-0.252293385,-0.004085959,0.003507293,-0.009219832,0.587356295,0.282857424,0.003271693],\
[-0.161645278,0.078118815,0.000882958,-0.006935007,0.282857424,1.231755033,-0.01298478],\
[-0.343599436,-0.065953043,0.001121935,-0.002067647,0.003271693,-0.01298478,0.479444968]]
# Probability
get_prob(c,estimates,vcov)
