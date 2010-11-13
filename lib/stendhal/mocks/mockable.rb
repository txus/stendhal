module Stendhal
  module Mocks
    module Mockable

      def expects(method, options = {})
        if options[:negative]
          __verifier.add_negative_expectation(method) 
        else
          __verifier.add_expectation(method) 
        end
        unless respond_to?(:"__original_#{method}")
          metaclass = (class << self;self;end)
          metaclass.send(:alias_method, :"__original_#{method}", method.to_sym)
          metaclass.send(:undef_method, method.to_sym)
          metaclass.class_eval <<EOT
            def #{method}(*args, &block)
              @__verifier.fulfill_expectation(:#{method},*args,&block)
              __original_#{method}(*args,&block)
            end
EOT
        end
        self
      end

      def once
        raise "This object has no mocks." unless @__verifier
        __verifier.expectation_for(__verifier.last_mocked_method).times_expected = 1
        self
      end

      def twice
        raise "This object has no mocks." unless @__verifier
        __verifier.expectation_for(__verifier.last_mocked_method).times_expected = 2
        self
      end

      def exactly(times)
        raise "This object has no mocks." unless @__verifier
        __verifier.expectation_for(__verifier.last_mocked_method).times_expected = times
        self
      end

      def times
        raise "This object has no mocks." unless @__verifier
        self
      end

      def and_returns(retval = nil, &block)
        raise "This object has no mocks." unless @__verifier
        method = __verifier.last_mocked_method
        str = retval.to_s
        unless respond_to?(:"__unstubbed_#{method}")
          metaclass = (class << self;self;end)
          metaclass.send(:alias_method, :"__unstubbed_#{method}", :"__original_#{method}")
          metaclass.send(:undef_method, :"__original_#{method}")

          return_value = block || Proc.new { retval }
          metaclass.send(:define_method, :"__original_#{method}", return_value)
        end
      end

      def does_not_expect(method)
        expects(method, :negative => true)
      end

      private

      def __verifier
        @__verifier ||= MockVerifier.new(self)
      end

    end
  end
end
