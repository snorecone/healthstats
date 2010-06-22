module HealthStats
  module Age
    def age_in_months
      return if dob.nil?
      today = Date.today
      months = age_in_years * 12
      
      if today.month >= dob.month
        if today.month == dob.month && today.day < dob.day
          months += 12
        else
          months += (today.month - dob.month)
        end
      else
        months += (today.month + 12) - dob.month
      end

      if today.day >= dob.day
        months += (today.day - dob.day > 15 ? 0.5 : 0.0)
      else
        months += (today.day - dob.day + 30) > 15 ? -0.5 : -1.0
      end
    end

    def age_in_years
      return if dob.nil?
      today = Date.today
      
      if today.month > dob.month || (today.month == dob.month && today.day >= dob.day)
        today.year - dob.year
      else
        today.year - dob.year - 1
      end
    end
    alias_method :age, :age_in_years
  end
  
  include Age
end