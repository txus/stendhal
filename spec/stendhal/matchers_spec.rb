require 'spec_helper'

class MyClass
  include Stendhal::Matchers
end

module Stendhal
  describe "a class with included Matchers" do
  
    let(:object) { MyClass.new }
     
    describe "#==" do
      it 'creates a new equality expectation' do
        Expectations::EqualityExpectation.should_receive(:new).with(7)
        object == 7
      end
    end

    describe "#be_a" do
      it 'creates a new kind expectation' do
        Expectations::KindExpectation.should_receive(:new).with(Fixnum)
        object.be_a(Fixnum)
      end
    end

    describe "#be_whatever" do
      it 'creates a new predicate expectation' do
        Expectations::PredicateExpectation.should_receive(:new).with(:frozen?)
        object.be_frozen
      end
    end

  end
end
