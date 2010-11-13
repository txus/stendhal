module Stendhal
  module Mocks
    module Stubbable

      def stubs(method, &block)
        unless respond_to?(:"__unstubbed_#{method}")
          metaclass = (class << self;self;end)

          if respond_to? method.to_sym
            metaclass.send(:alias_method, :"__unstubbed_#{method}", method.to_sym)
            metaclass.send(:undef_method, method.to_sym)
          end

          return_value = block || Proc.new { nil }
          metaclass.send(:define_method, method.to_sym, return_value)
        end
        self
      end

    end
  end
end
