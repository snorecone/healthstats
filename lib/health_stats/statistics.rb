# The following were adapted from 
# http://www.fourmilab.ch/rpkp/experiments/analysis/zCalc.html?
# Original comments below:
#
#     The following functions for calculating normal and
#     chi-square probabilities and critical values were adapted by
#     John Walker from C implementations
#     written by Gary Perlman of Wang Institute, Tyngsboro, MA
#     01879.  Both the original C code and this edition
#     are in the public domain.  */
# 
#     POZ  --  probability of normal z value
# 
#     Adapted from a polynomial approximation in:
#             Ibbetson D, Algorithm 209
#             Collected Algorithms of the CACM 1963 p. 616
#     Note:
#             This routine has six digit accuracy, so it is only useful for absolute
#             z values <= 6.  For z values > to 6.0, poz() returns 0.0.
#
module HealthStats
  module Statistics
    extend self
  
    Z_MAX = 6
    Z_EPSILON = 0.000001

    def poz(z)
      if z == 0.0
        x = 0.0
      else
        y = 0.5 * z.abs
    
        if y > (Z_MAX * 0.5)
          x = 1.0
        elsif y < 1.0
          w = y ** 2
          x = ((((((((0.000124818987 * w -
                      0.001075204047) * w + 0.005198775019) * w -
                      0.019198292004) * w + 0.059054035642) * w -
                      0.151968751364) * w + 0.319152932694) * w -
                      0.531923007300) * w + 0.797884560593) * y * 2.0
        else
          y -= 2.0
          x = (((((((((((((-0.000045255659 * y +
                            0.000152529290) * y - 0.000019538132) * y -
                            0.000676904986) * y + 0.001390604284) * y -
                            0.000794620820) * y - 0.002034254874) * y +
                            0.006549791214) * y - 0.010557625006) * y +
                            0.011630447319) * y - 0.009279453341) * y +
                            0.005353579108) * y - 0.002141268741) * y +
                            0.000535310849) * y + 0.999936657524
        end
      end
  
      z > 0.0 ? ((x + 1.0) * 0.5) : ((1.0 - x) * 0.5)
    end

    def critz(p)
      minz = -Z_MAX
      maxz = Z_MAX
      zval = 0.0
  
      return -1 if p < 0.0 || p > 1.0
  
      while maxz - minz > Z_EPSILON
        pval = poz(zval)
    
        if pval > p
          maxz = zval
        else
          minz = zval
        end
    
        zval = (maxz + minz) * 0.5
      end
  
      zval
    end
    
     # LMS method
     # Box GE, Cox DR. An analysis of transformations. J Roy Stat Soc, Series 
     #      B. 26:211-252, 1964.
     # Cole TJ. The LMS method for constructing normalized growth standards. 
     #      Eur J Clin Nutr. 44: 45-60, 1990
     # Cole TJ. Fitting smoothed centile curves to reference data. 
     #      Royal Stat Soc. 151:385-418, 1988
     
    def lms(x, l, m, s)
      (((x / m) ** l) - 1) / (l * s)
    end
    
    # puts poz(lms(25.02, -1.973763307, 19.302431312, 0.1512669735)) * 100
  end
end
  # puts critz(0.85)
  # 