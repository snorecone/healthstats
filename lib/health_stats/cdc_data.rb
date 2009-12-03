module HealthStats
  module CDCData
    module BMI
      autoload :Male, File.dirname(__FILE__) + '/cdc_data/bmi'
      autoload :Female, File.dirname(__FILE__) + '/cdc_data/bmi'
    end
  end
end