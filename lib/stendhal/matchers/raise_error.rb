module Stendhal
  module Matchers
    class RaiseError < AbstractMatcher

      def initialize(exception_class = Exception, message = nil)
        if exception_class.new.is_a?(Exception)
          @target = exception_class.new(message.to_s)
          @message_given = !!message
        else
          raise "#{exception_class} cannot be raised"
        end
      end

      def match(original, options = {})
        raised = false
        begin
          original.call
        rescue=>e
          raised = e
          if e.is_a?(@target.class)
            if options[:negative]
              message = "expected block not to raise #{@target.inspect}, but did"
              raise Stendhal::Exceptions::ExpectationNotMet.new(message) unless @message_given && @target.message != e.message
            else
              if @message_given
                message = "expected block to raise #{@target.inspect}, but raised #{e.inspect}"
                raise Stendhal::Exceptions::ExpectationNotMet.new(message) unless @target.message == e.message
              end
            end
          else
            message = "expected block to raise #{@target.inspect}, but raised #{e.inspect}"
            raise Stendhal::Exceptions::ExpectationNotMet.new(message) unless options[:negative]
          end
        end
        unless raised
          message = "expected block to raise #{@target.inspect}, but nothing was raised"
          raise Stendhal::Exceptions::ExpectationNotMet.new(message) unless options[:negative]
        end
        true
      end

    end
  end
end
