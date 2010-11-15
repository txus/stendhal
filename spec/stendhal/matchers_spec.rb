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

    describe "#be_a / #be_an" do
      it 'creates a new kind expectation' do
        Matchers::Kind.should_receive(:new).with(Fixnum)
        object.be_a(Fixnum)
      end
    end

    describe "#include" do
      it 'creates a new inclusion expectation' do
        Matchers::Inclusion.should_receive(:new).with(3)
        object.include(3)
      end
    end

    describe "#raise_error" do
      it 'creates a new raise_error expectation' do
        Matchers::RaiseError.should_receive(:new).with(StandardError)
        object.raise_error(StandardError)
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
