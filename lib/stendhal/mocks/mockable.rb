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
        __verifier.expectation_for(__verifier.last_mocked_method).times_expected = 1
        self
      end

      def twice
        __verifier.expectation_for(__verifier.last_mocked_method).times_expected = 2
        self
      end

      def exactly(times)
        __verifier.expectation_for(__verifier.last_mocked_method).times_expected = times
        self
      end

      def times
        self
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
