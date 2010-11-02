require 'spec_helper'

class MyClass
  include Stendhal::Matchers
end

module Stendhal
  describe "a class with included Matchers" do
  
    let(:object) { MyClass.new }
     
    describe "#eql / #eq" do
      it 'creates a new equality expectation' do
        Matchers::Equality.should_receive(:new).with(7).twice
        object.eq(7)
        object.eql(7)
      end
    end

    describe "#be_a" do
      it 'creates a new kind expectation' do
        Matchers::Kind.should_receive(:new).with(Fixnum)
        object.be_a(Fixnum)
      end
    end

    describe "#be_whatever" do
      it 'creates a new predicate expectation' do
        Matchers::Predicate.should_receive(:new).with(:frozen?)
        object.be_frozen
      end
    end

  end
end
