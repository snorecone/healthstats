module HealthStats
  AttributeError = Class.new(StandardError)
  RequiredAttributes = [:dob, :weight, :height, :gender]
  
  RequiredAttributes.each do |attribute|
    define_method(attribute) { nil }
  end
end

require 'health_stats/age'
require 'health_stats/statistics'
require 'health_stats/bmi'
