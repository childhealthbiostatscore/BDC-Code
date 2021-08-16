library(pwr)

proportion_power = function(p0 = 0.75,p1 = 0.85,p = 0.8,sig = 0.05,alt = "two.sided"){
  # Transform
  phi0 = 2*asin(sqrt(p0))
  phi1 = 2*asin(sqrt(p1))
  # Effect size
  h = phi1 - phi0
  # Calculate n
  pwr = pwr.norm.test(d = h, power = p, sig.level = sig,alternative = alt)
  pwr$n
}

proportion_power(0.75,0.5)
