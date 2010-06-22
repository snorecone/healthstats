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
      
      return unless stat_value && month_age && gender
      
      lms_value  = nil
      chart = CDC.data[stat][gender.to_sym]
      
      return if (month_age < chart.keys.min) || month_age > 240.0
      
      while lms_value.nil?
        lms_value = chart[month_age]
        month_age -= 0.5
        return if month_age < 0
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