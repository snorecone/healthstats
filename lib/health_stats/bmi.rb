module HealthStats
  autoload :CDCData, File.dirname(__FILE__) + '/cdc_data'
  
  module BMI
    include Statistics
    
    def bmi    
      if weight && height
        (((weight * 703) * 100) / (height ** 2)) / 100.0
      end
    end

    def bmi_percentile
      bmi_score = bmi
      month_age = age_in_months
      lms_value = nil
      
      return unless bmi_score && month_age && gender
      return if month_age < 24.0 || month_age > 241.0
      
      chart = gender == 'f' ? CDCData::BMI::Female : CDCData::BMI::Male
      
      while lms_value.nil?
        lms_value = chart[month_age]
        month_age -= 0.5
      end
      
      # I feel dirty.
      ((poz(lms(bmi_score, *lms_value)) * 1000000).to_i / 100.0).round / 100.0 
    end
  end
  
  include BMI
end