module HealthStats
  AttributeError = Class.new(StandardError)
  RequiredAttributes = [:dob, :weight, :height, :gender]
  
  RequiredAttributes.each do |attribute|
    define_method(attribute) do
      message = "#{attribute} is not implemented"
      raise HealthStats::AttributeError, message
    end
  end
end

require 'health_stats/age'
require 'health_stats/bmi'
