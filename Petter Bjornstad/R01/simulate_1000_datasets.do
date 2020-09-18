aldsim, totn(40) cn(4) ci(1) pn(3) pi(1) agelb(8) ageub(14) intsd(1) slpsd(1) slpintcor(-0.1) resid(2.236068) effsize(0.5)

generate group = "lean"
replace id = id + 0.2

save temp, replace

aldsim, totn(60) cn(4) ci(1) pn(3) pi(1) agelb(8) ageub(14) intsd(1) slpsd(1) slpintcor(-0.1) resid(2.236068) effsize(1.1)

generate group = "obese"
replace id = id + 0.1

append using temp

generate sim = 1

outsheet id sim cohort group period age y using C:/Users/timbv/Desktop/ald_sim1.csv , comma replace