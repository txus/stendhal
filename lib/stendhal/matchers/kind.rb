module Stendhal
  module Matchers
    class Kind < AbstractMatcher

      def match(original, options = {})
        message = "expected #{original.inspect} #{options[:negative] ? 'not ' : ''}to be a #{@target.inspect}"
        if options[:negative]
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) if original.is_a?(@target)
        else
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) unless original.is_a?(@target)
        end
        true
      end

    end
  end
end
