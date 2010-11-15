module Stendhal
  module Matchers
    class Inclusion < AbstractMatcher

      def match(original, options = {})
        message = "expected #{original.inspect} #{options[:negative] ? 'not ' : ''}to include #{@target.inspect}"

        if !original.respond_to?(:include?)
          message += ", but the former cannot include any object"
          raise Stendhal::Exceptions::ExpectationNotMet.new(message)
        end

        if options[:negative]
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) if original.include?(@target)
        else
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) unless original.include?(@target)
        end
        true
      end

    end
  end
end
