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
        it 'saves the original method' do
          subject.expects(:length) 
          subject.should respond_to(:__original_length)
          subject.send(:__original_length).should == 3
        end
        it 'makes the mocked method register a call and call the original method afterwards' do
          subject.expects(:length) 
          subject.send(:__verifier).should_receive(:fulfill_expectation).once.ordered
          subject.should_receive(:__original_length).once.ordered

          subject.length
        end
        context "when the method is already mocked" do
          it 'does not redefine it' do
            subject.stub(:__original_length)
            metaclass = (class << subject; self; end)
            metaclass.should_not_receive(:alias_method)
            metaclass.should_not_receive(:undef_method)
            metaclass.should_not_receive(:class_eval)

            subject.expects(:length) 
          end
        end
      end

      describe "#once" do
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
