import statsmodels.stats.power
import math
import numpy as np
# Normal power test
normal = statsmodels.stats.power.NormalIndPower()
n = normal.solve_power(effect_size=0.3, nobs1=None, alpha=0.05, power=0.8, ratio=1.0, alternative='two-sided')
print(math.ceil(n))
# Example code
# T-test instance
power_analysis = statsmodels.stats.power.TTestIndPower()
# parameters for power analysis
effect_sizes = np.array([0.2, 0.5, 0.8])
sample_sizes = np.array(range(5, 100))
power_analysis.plot_power(dep_var='nobs', nobs=sample_sizes, effect_size=effect_sizes)