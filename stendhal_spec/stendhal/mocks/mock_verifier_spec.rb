module Stendhal
  module Mocks
    describe MockVerifier do

      it 'includes itself in verifiers when created' do
        MockVerifier.new('object')
        MockVerifier.verifiers.length.must eq(1)
      end

      describe "instance methods" do

        describe "#expectation_for(method)" do
          it 'returns the expectation for a given method' do
            subject = MockVerifier.new('object')
            subject.add_expectation(:length)
            subject.add_expectation(:class)

            subject.expectation_for(:length).must be_a(MockVerifier::MessageExpectation)
            subject.expectation_for(:length).method.must eq(:length)
            MockVerifier.reset!
          end
        end

        describe "#add_expectation" do
          it 'adds an expectation for a given method' do
            subject = MockVerifier.new('object')
            # MockVerifier::MessageExpectation.expects(:new)

            subject.add_expectation(:reverse)
            subject.expectation_for(:reverse).must be_a(MockVerifier::MessageExpectation)
            MockVerifier.reset!
          end
          it 'remembers last mocked method' do
            subject = MockVerifier.new('object')

            subject.add_expectation(:reverse)
            subject.last_mocked_method.must eq(:reverse)
            MockVerifier.reset!
          end
          context "if an expectation for such method already exists" do
            it 'adds an expected call to that expectation' do
              subject = MockVerifier.new('object')
              subject.add_expectation(:reverse)
              MockVerifier::MessageExpectation.does_not_expect(:new)

              subject.add_expectation(:reverse)

              subject.expectations.length.must eq(1)
              subject.expectations.first.times_expected.must eq(2)
              MockVerifier.reset!
            end
          end
        end

        describe "#add_negative_expectation" do
          it 'adds a negative expectation for a given method' do
            subject = MockVerifier.new('object')
            subject.add_expectation(:reverse)
            subject.add_expectation(:reverse)

            subject.add_negative_expectation(:reverse)

            subject.expectations.length.must eq(1)
            subject.expectations.first.times_expected.must eq(0)
            MockVerifier.reset!
          end
          pending 'overrides previous positive expectations on the same method' do
            subject = MockVerifier.new('object')
            subject.should_receive(:add_expectation).with(:reverse, :negative => true)

            subject.add_negative_expectation(:reverse)
            MockVerifier.reset!
          end
        end

        describe "#fulfill_expectation" do
          it 'registers a call for a given method' do
            subject = MockVerifier.new('object')
            subject.add_expectation(:reverse)
            subject.expectations.first.expects(:register_call)

            subject.fulfill_expectation(:reverse)
            MockVerifier.reset!
          end
        end

        describe "#verify!" do
          it 'verifies each of the expectations until one fails' do
            expectations = [double, double, double]
            expectations.each do |e|
              e.expects(:verify)
            end
            subject.expects(:expectations).and_returns(expectations)

            subject.verify!
            MockVerifier.reset!
          end
          pending 'adds the object inspect to the message if raised any ExpectationNotMet' do
            expectations = [double, double, double]
            expectations.first.should_receive(:verify).and_raise(Stendhal::Exceptions::ExpectationNotMet.new('expected foo to be bar'))

            subject.should_receive(:expectations).and_return(expectations)

            expect {
              subject.verify!
            }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, "object expected foo to be bar")
          end
        end
      
      end

      describe "class methods" do
      
        describe "#verify!" do
          it 'verifies each of the verifiers' do
            verifiers = [double, double, double] 
            verifiers.each { |v| v.expects(:verify!) }
            MockVerifier.expects(:verifiers).and_returns verifiers

            MockVerifier.verify!
          end
        end

        describe "#reset!" do
          it 'deletes all verifiers' do
            MockVerifier.new('object')
            MockVerifier.new('other object')

            MockVerifier.reset!

            MockVerifier.verifiers.length.must eq(0)
          end
        end
      
      end

    end

    describe MockVerifier::MessageExpectation do

      it "initializes with 0 times called" do
        subject = MockVerifier::MessageExpectation.new(:length)
        subject.times_called.must eq(0)
      end

      context "when given no options" do
        it "initializes with 1 times expected" do
          subject = MockVerifier::MessageExpectation.new(:length)
          subject.times_expected.must eq(1)
        end
      end

      context "when given :negative => true" do
        it "initializes with 0 times expected" do
          negative_expectation = MockVerifier::MessageExpectation.new(:length, :negative => true)
          negative_expectation.times_expected.must eq(0)
        end
      end

      describe "instance methods" do
      
        describe "#register_call" do
          pending 'registers a call for the given expectation' do
            expect{
              subject.register_call
            }.to change(subject, :times_called).by(1)
          end
        end
      
        describe "#verify" do
          pending 'registers a call for the given expectation' do
            subject.stub(:times_called).and_return 2
            subject.stub(:times_expected).and_return 1

            expect {
              subject.verify
            }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, "expected to be sent :length 1 time, but received it 2 times")
          end
        end
      
      end

    end
  end
end
