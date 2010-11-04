module Stendhal
  module Mocks
    module Spyable
      # def included(base)
      #   base.send(:include, InstanceMethods)
      # end

      # module InstanceMethods
        def spy(method)
          metaclass = (class << self;self;end)
          metaclass.send(:alias_method, :"__original_#{method}", method.to_sym)
          metaclass.send(:undef_method, method.to_sym)
          metaclass.class_eval <<EOT
            def #{method}(*args, &block)
              puts "spy says... called #{method}!"
              @__verifier.add_call(:#{method},*args,&block) if nil
              __original_#{method}(*args,&block)
            end
EOT
        end
      # end

    end
  end
end
