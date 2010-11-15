module Stendhal
  module Matchers
    describe Inclusion do
     
      describe "#match" do
        it 'passes when original responds to :include? and target is included in it' do
          matcher = Inclusion.new(2)
          matcher.match([2, "string"]).must be_true
        end

        pending 'fails when original does not respond to :include?' do
          matcher = Inclusion.new(2)
          expected_message = %q{expected 3 to include 2, but the former cannot include any object}
          expect {
            matcher.match(3)
          }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end

        pending 'fails when original does not include the target' do
          matcher = Inclusion.new(2)
          expected_message = %q{expected ["string"] to include 2}
          expect {
            matcher.match(["string"])
          }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end

        context "with :negative => true" do

          it 'passes when the original does not include the target' do
            matcher = Inclusion.new("string")
            matcher.match(["other string"], :negative => true).must be_true
          end

          pending 'fails when original does not respond to :include?' do
            matcher = Inclusion.new("string")
            expected_message = %q{expected 3 not to include "string", but the former cannot include any object}
            expect {
              matcher.match(3, :negative => true)
            }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
          end

          pending 'fails when original includes the target' do
            matcher = Inclusion.new("string")
            expected_message = %q{expected ["string"] not to include "string"}
            expect {
              matcher.match(["string"], :negative => true)
            }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
          end

        end
      end

    end
  end
end
