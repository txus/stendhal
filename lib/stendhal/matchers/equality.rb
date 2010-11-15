module Stendhal
  module Matchers
    class Equality < AbstractMatcher

      def match(original, options = {})
        message = "expected #{options[:negative] ? 'something different than ' : ''}#{@target.inspect}, got #{original.inspect}"
        if options[:negative]
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) if @target == original
        else
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) unless @target == original
        end
        true
      end

    end
  end
end
