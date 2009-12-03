module HealthCalc
  AttributeError = Class.new(StandardError)
  
  def bmi
    unless self.respond_to?(:height) && self.respond_to?(:weight)
      errormsg = "You must define a height and weight attribute in this class"
      raise HealthCalc::AttributeError, errormsg
    end
    
    if weight && height
      (((weight * 703) * 100) / (height ** 2)) / 100.0
    end
  end
  
  def bmi_percentile
    unless self.respond_to?(:age) && self.respond_to?(:gender)
      errormsg = "You must define an age and gender attribute in this class"
      raise HealthCalc::AttributeError, errormsg
    end
  end
end

# require 'health_calc/statistics'
# require 'health_calc/bmi'