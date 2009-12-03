$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'health_calc'

describe 'HealthCalc' do
  describe '#bmi' do
    before do
      @klass = Class.new do
        include HealthCalc
        attr_accessor :height, :weight
      end
    end
    
    describe 'required attributes' do
      [:height, :weight].each do |attribute|
        it "should include #{attribute}" do
          @klass.send(:undef_method, attribute)
          lambda { @klass.new.bmi }.should.raise(HealthCalc::AttributeError)
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
    before do
      @klass = Class.new do
        include HealthCalc
        attr_accessor :height, :weight, :gender, :age
      end
    end
    
    describe 'required attributes' do
      [:age, :gender].each do |attribute|
        it "should include #{attribute}" do
          @klass.send(:undef_method, attribute)
          lambda { @klass.new.bmi_percentile }.should.raise(HealthCalc::AttributeError)
        end
      end
    end
    
    describe 'nil attributes' do
      before do
        @person = @klass.new
        @person.height = 61
        @person.weight = 130
        @person.gender = 'f'
        @person.age = 13
      end
      
      [:age, :gender].each do |attribute|
        it "should return nil if #{attribute} is nil" do
          @person.send("#{attribute}=", nil)
          @person.bmi_percentile.should.be.nil
        end
      end
    end
  end
end