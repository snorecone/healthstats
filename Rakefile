require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "health_stats"
    gemspec.summary = "Convenience methods for age, bmi, bmi percentile"
    gemspec.email = "assplecake@gmail.com"
    gemspec.homepage = "http://github.com/assplecake/healthdata"
    gemspec.authors = ["Mark Martin"]
    
    gemspec.add_development_dependency('activesupport', '>= 2.3')
  end
  
  Jeweler::GemcutterTasks.new
  
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
