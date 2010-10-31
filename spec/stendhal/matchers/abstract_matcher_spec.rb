require 'spec_helper'

module Stendhal
  module Matchers
    describe AbstractMatcher do
      
      it 'initializes with a target' do
        matcher = AbstractMatcher.new("target")    
        matcher.target.should == "target"
      end

      it 'does not implement #match' do
        matcher = AbstractMatcher.new("target")    
        expect { matcher.match("whatever") }.to raise_error(NotImplementedError)
      end

    end
  end
end
