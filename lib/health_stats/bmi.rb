module HealthStats  
  module BMI    
    def bmi    
      if weight && height
        (((weight * 703) * 100) / (height ** 2)) / 100.0
      end
    end
  end
  
  include BMI
end