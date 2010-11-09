require 'spec_helper'

class MyArray < Array
  include Stendhal::Mocks::Mockable
end

module Stendhal
  module Mocks
    describe "a Mockable class" do

      subject { MyArray.new([1,2,3]) }

      describe "#expects" do
        it 'creates a verifier' do
          subject.expects(:length) 
          subject.send(:__verifier).should be_a(MockVerifier)
        end
        it 'creates a message expectation on the given method' do
          subject.expects(:length) 
          subject.send(:__verifier).expectations.map(&:method).should include(:length)
        end
      end

    end
  end
end
