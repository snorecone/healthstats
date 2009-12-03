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
    
    it 'should require weight attribute in class' do
      @klass.send(:undef_method, :weight)
      lambda { @klass.new.bmi }.should.raise(HealthCalc::AttributeError)
    end
    
    it 'should require height attribute in class' do
      @klass.send(:undef_method, :height)
      lambda { @klass.new.bmi }.should.raise(HealthCalc::AttributeError)
    end
    
    it 'should return nil if weight is nil' do
      person = @klass.new
      person.height = 61
      person.bmi.should.be.nil
    end
    
    it 'should return nil if height is nil' do
      person = @klass.new
      person.weight = 61
      person.bmi.should.be.nil
    end
    
    it 'should return the correct bmi (precision 2)' do
      person = @klass.new
      person.weight = 130
      person.height = 61
      person.bmi.should == 24.56
    end
  end  
end