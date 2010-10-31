require 'spec_helper'

module Stendhal
  module Matchers
    describe Predicate do
     
      describe "#match" do
        it 'passes when original responds to target returning true' do
          matcher = Predicate.new(:frozen?)
          matcher.match("string".freeze).should be_true
        end

        it 'fails when it returns false' do
          matcher = Predicate.new(:frozen?)
          expected_message = %q{expected "string" to be frozen}
          expect {
            matcher.match("string")
          }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end

        context "with :negative => true" do

          it 'passes when original returns false when sent target' do
            matcher = Predicate.new(:frozen?)
            matcher.match("string", :negative => true).should be_true
          end

          it 'fails otherwise' do
            matcher = Predicate.new(:frozen?)
            expected_message = %q{expected "string" not to be frozen}
            expect {
              matcher.match("string".freeze, :negative => true)
            }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
          end

        end
        
      end

    end
  end
end
