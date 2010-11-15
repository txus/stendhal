module Stendhal
  module Matchers
    describe Kind do
     
      describe "#match" do
        it 'passes when original is a subclass of target' do
          matcher = Kind.new(Numeric)
          matcher.match(3).must be_true
        end

        pending 'fails otherwise' do
          matcher = Kind.new(Fixnum)
          expected_message = %q{expected 3.2 to be a Fixnum}
          expect {
            matcher.match(3.2)
          }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end 

        context "with :negative => true" do

          it 'passes when original is not a subclass of target' do
            matcher = Kind.new(Numeric)
            matcher.match("string", :negative => true).must be_true
          end

          pending 'fails otherwise' do
            matcher = Kind.new(Numeric)
            expected_message = %q{expected 3 not to be a Numeric}
            expect {
              matcher.match(3, :negative => true)
            }.to raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
          end

        end
        
      end

    end
  end
end
