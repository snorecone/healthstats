$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'health_stats'

REQUIRED_ATTRIBUTES = [:height, :weight, :gender, :dob]

describe 'HealthStats' do
  before do
    @klass = Class.new do
      include HealthStats
      attr_accessor *REQUIRED_ATTRIBUTES
    end
  end
  
  describe '#bmi' do
    describe 'required attributes' do
      [:height, :weight].each do |attribute|
        it "should include #{attribute}" do
          person = @klass.new
          person.height = 10
          person.weight = 10
          @klass.send(:remove_method, attribute)
          lambda { person.bmi }.should.raise(HealthStats::AttributeError)
        end
      end
    end
    
    describe 'nil attributes' do
      before do
        @person = @klass.new
        @person.height = 61
        @person.weight = 130
      end
      
      [:height, :weight].each do |attribute|
        it "should return nil if #{attribute} is nil" do
          @person.send("#{attribute}=", nil)
          @person.bmi.should.be.nil
        end
      end
    end
    
    it 'should return the correct bmi (precision 2)' do
      person = @klass.new
      person.weight = 130
      person.height = 61
      person.bmi.should == 24.56
    end
  end
  
  describe '#bmi_percentile' do
    describe 'required attributes' do
      [:dob, :gender, :height, :weight].each do |attribute|
        it "should include #{attribute}" do
          person = @klass.new
          person.height = 61
          person.weight = 130
          person.gender = 'f'
          person.dob = 13
          @klass.send(:remove_method, attribute)
          lambda { person.bmi_percentile }.should.raise(HealthStats::AttributeError)
        end
      end
    end
    
    describe 'nil attributes' do
      before do
        @person = @klass.new
        @person.height = 61
        @person.weight = 130
        @person.gender = 'f'
        @person.dob = 13
      end
      
      [:dob, :gender].each do |attribute|
        it "should return nil if #{attribute} is nil" do
          @person.send("#{attribute}=", nil)
          @person.bmi_percentile.should.be.nil
        end
      end
    end
  end
end