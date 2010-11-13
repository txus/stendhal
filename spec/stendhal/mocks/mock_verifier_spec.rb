require 'spec_helper'

module Stendhal
  module Mocks
    describe MockVerifier do

      subject { verifier = MockVerifier.new('object') }

      it 'includes itself in verifiers when created' do
        subject
        MockVerifier.should have(1).verifiers
      end

      describe "instance methods" do
      
        describe "#add_expectation" do
          it 'adds an expectation for a given method' do
            MockVerifier::MessageExpectation.should_receive(:new).with(:reverse, {})

            subject.add_expectation(:reverse)
          end
          context "if an expectation for such method already exists" do
            it 'adds an expected call to that expectation' do
              subject.add_expectation(:reverse)
              MockVerifier::MessageExpectation.should_not_receive(:new)

              subject.add_expectation(:reverse)

              subject.should have(1).expectations
              subject.expectations.first.times_expected.should == 2
            end
          end
        end

        describe "#add_negative_expectation" do
          it 'adds a negative expectation for a given method' do
            subject.add_expectation(:reverse)
            subject.add_expectation(:reverse)

            subject.add_negative_expectation(:reverse)

            subject.should have(1).expectations
            subject.expectations.first.times_expected.should == 0
          end
          it 'overrides previous positive expectations on the same method' do
            subject.should_receive(:add_expectation).with(:reverse, :negative => true)

            subject.add_negative_expectation(:reverse)
          end
        end

        describe "#fulfill_expectation" do
          it 'registers a call for a given method' do
            subject.add_expectation(:reverse)
            subject.expectations.first.should_receive(:register_call)

            subject.fulfill_expectation(:reverse)
          end
        end

        describe "#verify!" do
          it 'verifies each of the expectations until one fails' do
            expectations = [double, double, double]
            expectations.each do |e|
              e.should_receive(:verify)
            end
            subject.should_receive(:expectations).and_return(expectations)

            subject.verify!
          end
          it 'adds the object inspect to the message if raised any ExpectationNotMet' do
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
            verifiers.each { |v| v.should_receive(:verify!) }
            MockVerifier.should_receive(:verifiers).and_return verifiers

            MockVerifier.verify!
          end
        end

        describe "#reset!" do
          it 'deletes all verifiers' do
            MockVerifier.new('object')
            MockVerifier.new('other object')

            MockVerifier.reset!

            MockVerifier.should have(0).verifiers
          end
        end
      
      end

    end

    describe MockVerifier::MessageExpectation do

      subject { MockVerifier::MessageExpectation.new(:length) }

      it "initializes with 0 times called" do
        subject.times_called.should == 0
      end

      context "when given no options" do
        it "initializes with 1 times expected" do
          subject.times_expected.should == 1
        end
      end

      context "when given :negative => true" do
        it "initializes with 0 times expected" do
          negative_expectation = MockVerifier::MessageExpectation.new(:length, :negative => true)
          negative_expectation.times_expected.should == 0
        end
      end

      describe "instance methods" do
      
        describe "#register_call" do
          it 'registers a call for the given expectation' do
            expect{
              subject.register_call
            }.to change(subject, :times_called).by(1)
          end
        end
      
        describe "#verify" do
          it 'registers a call for the given expectation' do
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
