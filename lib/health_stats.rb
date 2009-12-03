module HealthStats
  AttributeError = Class.new(StandardError)
  RequiredAttributes = [:dob, :weight, :height, :gender]
  
  RequiredAttributes.each do |attribute|
    define_method(attribute) do
      message = "#{attribute} is not implemented"
      raise HealthStats::AttributeError, message
    end
  end
  
  def bmi    
    if weight && height
      (((weight * 703) * 100) / (height ** 2)) / 100.0
    end
  end
  
  def bmi_percentile
  end
end
