module Stendhal
  module Matchers
    describe Equality do
     
      describe "#match" do
        it 'passes when original and target objects are equivalent' do
          matcher = Equality.new("string")
          matcher.match("string").must be_true
        end

        pending 'fails when original and target objects are unequivalent' do
          matcher = Equality.new("string")
          expected_message = %q{expected "string", got "other string"}
          expect {
            matcher.match("other string")
          }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end

        context "with :negative => true" do

          it 'passes when found unequivalence' do
            matcher = Equality.new("string")
            matcher.match("other string", :negative => true).must be_true
          end

          pending 'fails otherwise' do
            matcher = Equality.new("string")
            expected_message = %q{expected something different than "string", got "string"}
            expect {
              matcher.match("string", :negative => true)
            }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
          end

        end
      end

    end
  end
end
