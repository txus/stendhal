module Stendhal
  module Matchers
    class Predicate < AbstractMatcher

      def match(original, options = {})
        message = "expected #{original.inspect} #{options[:negative] ? 'not ' : ''}to be #{@target.to_s.gsub('?','')}"
        if options[:negative]
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) if original.send(@target)
        else
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) unless original.send(@target)
        end
        true
      end

    end
  end
end
