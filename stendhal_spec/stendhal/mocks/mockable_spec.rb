class MyArray < Array
  include Stendhal::Mocks::Mockable
end

module Stendhal
  module Mocks
    describe "a Mockable class" do

      describe "#expects" do
        it 'creates a verifier' do
          subject = MyArray.new([1,2,3])

          subject.expects(:length) 
          subject.send(:__verifier).must be_a(MockVerifier)
        end
        it 'creates a message expectation on the given method' do
          subject = MyArray.new([1,2,3])

          subject.expects(:length) 
          subject.send(:__verifier).expectations.map(&:method).must include(:length)
        end
        it 'saves the original method' do
          subject = MyArray.new([1,2,3])

          subject.expects(:length) 
          subject.must respond_to(:__original_length)
          subject.send(:__original_length).must eq(3)
        end
        it 'makes the mocked method register a call and call the original method afterwards' do
          subject = MyArray.new([1,2,3])

          subject.expects(:length) 
          subject.send(:__verifier).expects(:fulfill_expectation).once.ordered
          subject.expects(:__original_length).once.ordered

          subject.length
        end
        context "when the method is already mocked" do
          it 'does not redefine it' do
            subject = MyArray.new([1,2,3])

            subject.stubs(:__original_length)
            metaclass = (class << subject; self; end)
            metaclass.does_not_expect(:alias_method)
            metaclass.does_not_expect(:undef_method)
            metaclass.does_not_expect(:class_eval)

            subject.expects(:length) 
          end
        end
        it 'returns itself to allow chaining' do
          subject = MyArray.new([1,2,3])

          subject.expects(:length).must be_a(MyArray)
        end
      end

      describe "times a method is expected to be received" do

        {:once => 1,
         :twice => 2}.each do |name,times|

          describe "##{times}" do
            pending 'sets the times expected for the mocked method to one' do
              subject = MyArray.new([1,2,3])

              expectation = double('expectation', :times_expected => 7)
              subject.send(:__verifier).expects(:last_mocked_method).and_returns :length
              subject.send(:__verifier).expects(:expectation_for).with(:length).and_returns expectation
              expectation.expects(:times_expected=).with(times)

              subject.send(name)
            end
            it 'returns itself to allow chaining' do
              subject = MyArray.new([1,2,3])

              subject.send(:__verifier).stubs(:last_mocked_method) { :length }
              subject.expects(:length).send(name).must be_a(MyArray)
            end
            it 'raises an error if called without a previous mock' do
              subject = MyArray.new([1,2,3])

              lambda {
                subject.send(name)
              }.must raise_error(StandardError, "This object has no mocks.")
            end
          end

        end

        describe "#exactly(number_of_times)" do
          pending 'sets the times expected for the mocked method to the given number' do
            subject = MyArray.new([1,2,3])

            expectation = double('expectation', :times_expected => 7)
            subject.send(:__verifier).expects(:last_mocked_method).and_returns :length
            subject.send(:__verifier).expects(:expectation_for).with(:length).and_returns expectation
            expectation.expects(:times_expected=).with(3)

            subject.exactly(3)
          end
          it 'returns itself to allow chaining' do
            subject = MyArray.new([1,2,3])

            subject.send(:__verifier).stubs(:last_mocked_method) { :length } 
            subject.expects(:length).twice.must be_a(MyArray)
          end
          it 'raises an error if called without a previous mock' do
            subject = MyArray.new([1,2,3])

            lambda {
              subject.exactly(2)
            }.must raise_error(StandardError, "This object has no mocks.")
          end
        end

        describe "#times" do
          it 'returns itself to allow chaining' do
            subject = MyArray.new([1,2,3])

            subject.expects(:length).times.must be_a(MyArray)
          end
          it 'raises an error if called without a previous mock' do
            subject = MyArray.new([1,2,3])

            lambda {
              subject.times
            }.must raise_error(StandardError, "This object has no mocks.")
          end
        end

      end

      describe "#and_returns" do
        it 'stubs the return value' do
          subject = MyArray.new([1,2,3])

          subject.expects(:length).and_returns 5
          subject.length.must eq(5)
        end
        it 'accepts a block as the return value' do
          subject = MyArray.new([1,2,3])

          subject.expects(:length).and_returns do
            3 + 4
          end
          subject.length.must eq(7)
        end
        it 'saves the unstubbed method' do
          subject = MyArray.new([1,2,3])

          subject.expects(:length).and_returns(:foo)
          subject.must respond_to(:__unstubbed_length)
          subject.send(:__unstubbed_length).must eq(3)
        end
      end
    end
  end
end
