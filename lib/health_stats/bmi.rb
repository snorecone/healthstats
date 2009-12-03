module HealthStats
  module BMI
    def bmi    
      if weight && height
        (((weight * 703) * 100) / (height ** 2)) / 100.0
      end
    end

    def bmi_percentile
      if bmi && dob && gender
      end
    end
  end
  
  include BMI
end