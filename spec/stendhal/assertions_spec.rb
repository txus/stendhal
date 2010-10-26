require 'spec_helper'

class MyClass
  include Stendhal::Assertions
end

module Stendhal
  describe Assertions do
    
    subject { MyClass.new }

    describe "#assert" do

      it "does nothing if asserted expression returns true" do
        subject.assert true
      end

      it "raises an AssertionFailed exception otherwise" do
        expect { subject.assert false }.to raise_error(AssertionFailed)
      end

      it "yields a given message for the error" do
        expect { subject.assert false, "softwared!" }.to raise_error(AssertionFailed, "softwared!")
      end

    end

  end
end
