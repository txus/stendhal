module Stendhal
  module Matchers
    class Equality < AbstractMatcher

      def match(original, options = {})
        message = "expected #{original.inspect} #{options[:negative] ? 'to be different than' : 'to equal'} #{@target.inspect}"
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
