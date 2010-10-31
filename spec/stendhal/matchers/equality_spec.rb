require 'spec_helper'

module Stendhal
  module Matchers
    describe Equality do
     
      describe "#match" do
        it 'passes when original and target objects are equivalent' do
          matcher = Equality.new("string")
          matcher.match("string").should be_true
        end

        it 'fails when original and target objects are unequivalent' do
          matcher = Equality.new("string")
          expected_message = %q{expected "other string" to equal "string"}
          expect {
            matcher.match("other string")
          }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end

        context "with :negative => true" do

          it 'passes when found unequivalence' do
            matcher = Equality.new("string")
            matcher.match("other string", :negative => true).should be_true
          end

          it 'fails otherwise' do
            matcher = Equality.new("string")
            expected_message = %q{expected "string" to be different than "string"}
            expect {
              matcher.match("string", :negative => true)
            }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
          end

        end
      end

    end
  end
end
