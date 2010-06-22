module HealthStats
  module CDC    
    def self.data
      @data ||= {}
    end
  end
end

require File.dirname(__FILE__) + '/cdc_data/bmi'
require File.dirname(__FILE__) + '/cdc_data/weight'
require File.dirname(__FILE__) + '/cdc_data/height'