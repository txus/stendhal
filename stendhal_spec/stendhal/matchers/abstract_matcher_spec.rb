module Stendhal
  module Matchers
    describe AbstractMatcher do
      
      it 'initializes with a target' do
        matcher = AbstractMatcher.new("target")    
        matcher.target.must eq("target")
      end

    end
  end
end
