$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'health_stats'
require 'activesupport'

REQUIRED_ATTRIBUTES = [:height, :weight, :gender, :dob]

describe 'HealthStats' do
  describe 'required attributes' do
    before do
      @klass = Class.new do
        include HealthStats
      end
    end
    
    REQUIRED_ATTRIBUTES.each do |attribute|
      it "should include #{attribute}" do
        person = @klass.new
        lambda { person.send(attribute) }.should.raise(HealthStats::AttributeError)
      end
    end
  end
  
  describe 'included methods' do
    before do
      @klass = Class.new do
        include HealthStats
        attr_accessor *REQUIRED_ATTRIBUTES
      end
      
      @person = @klass.new
      @person.height = 53
      @person.weight = 100
      @person.gender = 'f'
      @person.dob = 14.years.ago - 5.days
    end
    
    describe '#age_methods' do
      it "should return nil if dob is nil" do
        @person.dob = nil
        @person.age.should.be.nil
        @person.age_in_years.should.be.nil
        @person.age_in_months.should.be.nil
      end
      
      it "should return years as integer" do
        @person.age_in_years.should == 14
        @person.age.should == 14
        
        @person.dob = 1.month.ago
        @person.age_in_years.should == 0
        @person.age.should == 0
        
        @person.dob = 14.months.ago
        @person.age_in_years.should == 1
        @person.age.should == 1
      end
      
      it "should include age in months as a float in .5 increments" do
        @person.age_in_months.should == 168.0
        
        @person.dob = 1.month.ago + 2.days
        @person.age_in_months.should == 0.5
        
        @person.dob = 1.month.ago - 3.days
        @person.age_in_months.should == 1.0
        
        @person.dob = 1.year.ago - 5.days
        @person.age_in_months.should == 12.0
        
        @person.dob = 1.year.ago + 5.days
        @person.age_in_months.should == 11.5
        
        @person.dob = 2.years.ago - 1.month - 18.days
        @person.age_in_months.should. == 25.5
      end
      
    end
    
    describe '#bmi' do
      [:height, :weight].each do |attribute|
        it "should return nil if #{attribute} is nil" do
          @person.send("#{attribute}=", nil)
          @person.bmi.should.be.nil
        end
      end
    
      it 'should return the correct bmi (precision 2)' do
        @person.bmi.should == 25.02
      end
    end
  
    describe '#bmi_percentile' do    
      [:dob, :gender].each do |attribute|
        it "should return nil if #{attribute} is nil" do
          @person.send("#{attribute}=", nil)
          @person.bmi_percentile.should.be.nil
        end
      end
      
      it "should return nil if outside cdc date range" do
        @person.dob = 1.month.ago
        @person.bmi_percentile.should.be.nil
        
        @person.dob == 20.years.ago - 10.days - 2.months
        @person.bmi_percentile.should.be.nil
      end
      
      it "should return percentile (precision 2)" do
        @person.bmi_percentile.should == 91.02
        
        @person.gender = 'm'
        @person.dob = 2.years.ago - 1.month - 18.days
        @person.weight = 14
        @person.height = 24
        @person.bmi_percentile.should == 66.49
      end
    end
  end
end