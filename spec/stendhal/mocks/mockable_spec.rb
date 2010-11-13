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
        it 'returns itself to allow chaining' do
          subject.expects(:length).should be_a(MyArray)
        end
      end

      describe "times a method is expected to be received" do

        {:once => 1,
         :twice => 2}.each do |name,times|

          describe "##{times}" do
            it 'sets the times expected for the mocked method to one' do
              expectation = double('expectation', :times_expected => 7)
              subject.send(:__verifier).should_receive(:last_mocked_method).and_return :length
              subject.send(:__verifier).should_receive(:expectation_for).with(:length).and_return expectation
              expectation.should_receive(:times_expected=).with(times)

              subject.send(name)
            end
            it 'returns itself to allow chaining' do
              subject.send(:__verifier).stub(:last_mocked_method).and_return :length
              subject.expects(:length).send(name).should be_a(MyArray)
            end
            it 'raises an error if called without a previous mock' do
              expect {
                subject.send(name)
              }.to raise_error("This object has no mocks.")
            end
          end

        end

        describe "#exactly(number_of_times)" do
          it 'sets the times expected for the mocked method to the given number' do
            expectation = double('expectation', :times_expected => 7)
            subject.send(:__verifier).should_receive(:last_mocked_method).and_return :length
            subject.send(:__verifier).should_receive(:expectation_for).with(:length).and_return expectation
            expectation.should_receive(:times_expected=).with(3)

            subject.exactly(3)
          end
          it 'returns itself to allow chaining' do
            subject.send(:__verifier).stub(:last_mocked_method).and_return :length
            subject.expects(:length).twice.should be_a(MyArray)
          end
          it 'raises an error if called without a previous mock' do
            expect {
              subject.exactly(2)
            }.to raise_error("This object has no mocks.")
          end
        end

        describe "#times" do
          it 'returns itself to allow chaining' do
            subject.expects(:length).times.should be_a(MyArray)
          end
          it 'raises an error if called without a previous mock' do
            expect {
              subject.times
            }.to raise_error("This object has no mocks.")
          end
        end

      end

      describe "#and_returns" do
        it 'stubs the return value' do
          subject.expects(:length).and_returns 5
          subject.length.should == 5
        end
        it 'accepts a block as the return value' do
          subject.expects(:length).and_returns do
            3 + 4
          end
          subject.length.should == 7
        end
        it 'saves the unstubbed method' do
          subject.expects(:length).and_returns(:foo)
          subject.should respond_to(:__unstubbed_length)
          subject.send(:__unstubbed_length).should == 3
        end
      end
    end
  end
end
