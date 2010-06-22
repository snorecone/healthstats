module HealthStats
  module Percentile
    include Statistics
    
    def percentile_for_age(stat)
      stat_value = case stat
      when :weight
        kilogram_weight
      when :height
        centimeter_height
      else
        send stat
      end
        
      month_age  = age_in_months
      lms_value  = nil
      
      return unless stat_value && month_age && gender
      return if month_age < 24.0 || month_age > 241.0
      
      chart = CDC.data[stat][gender.to_sym]
            
      while lms_value.nil?
        lms_value = chart[month_age]
        month_age -= 0.5
      end
      
      # I feel dirty.
      ((poz(lms(stat_value, *lms_value)) * 1000000).to_i / 100.0).round / 100.0 
    end
    
    def kilogram_weight
      weight * 0.45359237
    end
    
    def centimeter_height
      height * 2.54
    end
  end
  
  include Percentile
end