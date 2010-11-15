module Stendhal
  module Matchers
    describe RaiseError do

      describe "#initialize" do
        it "rejects arguments that aren't an Exception" do
          lambda {
            RaiseError.new(Hash)
          }.must raise_error(Exception, "Hash cannot be raised")
        end

        it "assigns to @target an instance of the exception given" do
          RaiseError.new(StandardError).target.must be_an(StandardError)
        end

        context "with a message provided" do
          
          it "assigns to @target an instance of the exception given with a corresponding message" do
            RaiseError.new(StandardError, "My message").target.message.must eq("My message")
          end
        
        end
      end
     
      describe "#match" do
        it 'passes when original.call raises a given exception' do
          blk = lambda { 
            raise StandardError.new 
          }
          matcher = RaiseError.new(StandardError)
          matcher.match(blk).must be_true
        end

        it 'fails when original.call raises a different exception' do
          blk = lambda { 
            raise ArgumentError.new 
          }
          matcher = RaiseError.new(NoMethodError)

          expected_message = %q{expected block to raise NoMethodError, but raised #<ArgumentError: ArgumentError>}
          lambda {
            matcher.match(blk)
          }.must raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end

        it 'passes when original.call raises a given exception with a certain message' do
          blk = lambda { 
            raise StandardError.new "My message"
          }
          matcher = RaiseError.new(StandardError, "My message")
          matcher.match(blk).must be_true
        end

        it 'fails when original.call raises a given exception without a certain message' do
          blk = lambda { 
            raise StandardError.new "Unexpected message"
          }
          matcher = RaiseError.new(StandardError, "My message")

          expected_message = %q{expected block to raise #<StandardError: My message>, but raised #<StandardError: Unexpected message>}
          lambda {
            matcher.match(blk)
          }.must raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end

        it 'fails when original.call does not raise anything' do
          blk = lambda { 
            
          }
          matcher = RaiseError.new(StandardError)

          expected_message = %q{expected block to raise StandardError, but nothing was raised}
          lambda {
            matcher.match(blk)
          }.must raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
        end

        context "with :negative => true" do

          it 'fails when original.call raises a given exception' do
            blk = lambda { 
              raise StandardError.new 
            }
            matcher = RaiseError.new(StandardError)

            expected_message = %q{expected block not to raise StandardError, but did}
            lambda {
              matcher.match(blk, :negative => true)
            }.must raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
          end

          it 'passes when original.call raises a different exception' do
            blk = lambda { 
              raise ArgumentError.new 
            }
            matcher = RaiseError.new(NoMethodError)

            matcher.match(blk, :negative => true).must be_true
          end

          it 'fails when original.call raises a given exception with a certain message' do
            blk = lambda { 
              raise StandardError.new "My message"
            }
            matcher = RaiseError.new(StandardError, "My message")

            expected_message = %q{expected block not to raise #<StandardError: My message>, but did}
            lambda {
              matcher.match(blk, :negative => true)
            }.must raise_error(Stendhal::Exceptions::ExpectationNotMet, expected_message)
          end

          it 'passes when original.call raises a given exception with a different message' do
            blk = lambda { 
              raise StandardError.new "Unexpected message"
            }
            matcher = RaiseError.new(StandardError, "My message")
            matcher.match(blk, :negative => true).must be_true
          end

          it 'passes when original.call does not raise anything' do
            blk = lambda { 
              
            }
            matcher = RaiseError.new(StandardError)

            matcher.match(blk, :negative => true).must be_true
          end

        end
      end

    end
  end
end
